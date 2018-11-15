Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91836C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB89208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mena-vt-edu.20150623.gappssmtp.com header.i=@mena-vt-edu.20150623.gappssmtp.com header.b="YUMgEJUm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB89208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mena.vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388270AbeKOXpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 18:45:02 -0500
Received: from mail-vk1-f176.google.com ([209.85.221.176]:43144 "EHLO
        mail-vk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729034AbeKOXpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 18:45:02 -0500
Received: by mail-vk1-f176.google.com with SMTP id o130so4462850vke.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 05:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mena-vt-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bkvrH/H7L01ZNgV8U26Z0LfgWYl8jbWsM+kMF4NPu0Q=;
        b=YUMgEJUmKz5keVGP7Fsb2eUD9yGDV19IewgYPIZBylvZ0i+bQU5/ed/baXerpj5xMU
         IOdNipQ0b9YOcynjYwMLOrAurBU0VxN2BLIv0IjayY52YvzFnaxhkw/Z3s3UeD8LHJVo
         HL+q1xYUa63wNxD0nqSNQiuJn2ffCpPWiJPw6MYFtpCR6Zg0bKhi2ba7RACbf4mvz3tO
         CxwnaCgbdQopPjEvrYD7ldMnMYdqJnn1l0r8wm5kFOamRG98+gQT1ftp0VqG2sgou0I5
         uxL0l0eqOuOholN8f6gu1cUb1JMkVF8wiEyAffv6X5MXuWH+GOKyDmuPKFGDROOZCWrQ
         Ku2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bkvrH/H7L01ZNgV8U26Z0LfgWYl8jbWsM+kMF4NPu0Q=;
        b=DEP0sMRlr6LmO6NKm2VG4o1T1yQc5baBUOSyW3q85kStwnLnfg9mnA+XcNKs0B7gNg
         KrIGQy8fdfwE8x9MuzTyTJlKaGBhdG6o2mZ3iPmENzuG3Si0Cc1xIqMcmcHMuUpP4HoV
         0pXxr6+an86qdDu26JNqYrVEBSG9ji5JuTyNoHGK42vl5fMkXQTYBMyURxcQeGLPF1Z0
         xmFA+lw7zC5xD9x1n3V35AfPuBZiWJ2FkyFGi1VXU6E+J/ZkFO3/fgl0VPH1yMYESYMa
         T8R3yoTbSTW+43ufLrzsa1jvsK+bCowl+bmJKi0HnF7OU18HmR3AfDTUrrZnB3RUW/Kj
         byOg==
X-Gm-Message-State: AGRZ1gJf+0s4/bk5my8ja+xMgXM1JCouODdfk+Vyqsp2Yw2iYwA34scV
        8ssDOHfraPFl6owqQqP5QgiGCEkpCOLySNKDVAz1aw==
X-Google-Smtp-Source: AJdET5c6fQ4L8EJWNtzqIVMHhok8nyw5TOxqM5Uy6CXwmvt/ESF426PD0n1sCdvOZ+VSXz9OVX5JipFB7v+VFsRi5AI=
X-Received: by 2002:a1f:360a:: with SMTP id d10mr2561814vka.79.1542289028041;
 Thu, 15 Nov 2018 05:37:08 -0800 (PST)
MIME-Version: 1.0
References: <CANBxJ=EQOt1t=PkLsMvtfB2SbiLMPeGvFxB7SJXf7m3OkcionQ@mail.gmail.com>
 <20181114180807.6crs7awhvo26ldbr@hawk.localdomain> <CADYN=9Jh10guVNFfhS8XH+RwZAouLJQu7Svg4+Tz3rQDexzDkg@mail.gmail.com>
 <CANBxJ=G4xdF8ZOR4zyoX1edNa=jYxk1xrzoi+7Xgcqt9qDoM2w@mail.gmail.com>
 <CANBxJ=EB8izWM8iLd49Uvd1z1O-gLvkGmiKNHjfHifFohj2xbg@mail.gmail.com> <20181115090203.5z25gwa2yznj6mmu@kamzik.brq.redhat.com>
In-Reply-To: <20181115090203.5z25gwa2yznj6mmu@kamzik.brq.redhat.com>
From:   Ahmed Soliman <ahmedsoliman@mena.vt.edu>
Date:   Thu, 15 Nov 2018 15:36:44 +0200
Message-ID: <CANBxJ=EHkuxKFoQw=K21o=9_FMhi_=on=Poq+ZF37eieoKV4zg@mail.gmail.com>
Subject: Re: KVM selftests are failing
To:     Andrew Jones <drjones@redhat.com>,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Nov 15, 2018 at 11:02 AM Andrew Jones <drjones@redhat.com> wrote:
> I think you should be able to pre-compile the selftests and save them,
> and then bisect the kernel further back than their introduction. Actually
> you may want to simplify the test case to just a mmap/madvise pair and
> see if that reproduces, since kvm selftests doesn't do much more than
> that. (Other than all the /dev/kvm ioctls - you have the right perms
> on /dev/kvm, or are running as root, right?)
yes I have /dev/kvm permissions, but it shouldn't matter at the moment.

well I stripped the kvm self tests from most stuff and ended up with
simpler code
(sorry for spaces, I am using web interface to send this email)


#include <stdio.h>
#include <sys/mman.h>
#include <string.h>
#include <errno.h>
static void *align(void *x, size_t size)
{
       size_t mask = size - 1;
       return (void *) (((size_t) x + mask) & ~mask);
}

int main(){

       int ret;
       void *mmap_start;
       void *host_mem;
       size_t length = 6291456;

       mmap_start = mmap(NULL, length, PROT_READ | PROT_WRITE,
                       MAP_PRIVATE | MAP_ANONYMOUS | 0, -1, 0);
       host_mem = align(mmap_start, 1);
       ret = madvise(host_mem, length, MADV_NOHUGEPAGE);
       printf("madvise returned: %d\nerrno: %d %s\n", ret, errno,
strerror(errno));
}

Now I couldn't find a single commit to bisect from, I checked 4.20,
4.19, 4.16, 4.10, 4.4 back to v3.18 tag
and None of the builds I attempted did work. All of the kernels returned:

madvise returned: -1
errno: 22 Invalid argument

and the strace logs looks like this:

mmap(NULL, 6291456, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0x7f46ea2a1000
madvise(0x7f46ea2a1000, 6291456, MADV_NOHUGEPAGE) = -1 EINVAL (Invalid argument)

For comprehension, this is done on intel core i7-4500U CPU @ 1.80GHz

As for now I will comment the madvise line and the assert when writing
my own kvm self test. I think it wouldn't cause any trouble?, If it is
not the case, please let me know.

Thanks,

-- 
Ahmed
Junior Researcher, IoT and Cyber Security lab, SmartCI, Alexandria
University, & CIS @  VMI
