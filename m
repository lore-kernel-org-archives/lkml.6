Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8282C28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900C3204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="aRYSwadp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 900C3204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeJLGjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 02:39:42 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36770 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbeJLGjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 02:39:42 -0400
Received: by mail-ot1-f65.google.com with SMTP id x4so9236005otg.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 16:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=kmFFZJmQzrjpo/8AXHrsuO1g1QzCZscDRdm0TH5jsjE=;
        b=aRYSwadpTdzFEooc628Iji69CofuYWmCPKM2cUP8vcer6rwH6N/H3S+f4KtEGH1sun
         MnzCI34c61strU+e+6IV51H9/B848R/ZkEj3ZGGMPRaqzthAwTsA/8nqKPHXjDJZ5ltY
         nz0ETZGUgTWgHHnFfwqHGmO7dGaxPHYKFOTZ0Dr0OsarWGPjsZD4v+qmhWUXAYVbGymC
         6+MHnGcLhbaFzFsM50uFCQrG/1ek6WjzuSIAZkf07bmp7cZacAzlhDAjRFR40oTkARaT
         aLcA8HIXmMp4OZxYZDyaHFv0x6xaqZvojy/mQXW9GCjkTRq8pAp0bfXr+frowPcrRXrh
         YOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=kmFFZJmQzrjpo/8AXHrsuO1g1QzCZscDRdm0TH5jsjE=;
        b=UZL9k/RQQR6rdbwQhMCwVY+CUJ7dYKAW0JAaSWXT3diX3COaUCsbEtgCAc/AovtUlu
         59/PN9XpYc0Imt4P9J1wsNY5++ULtph7aW6vGlZheB9N4tCA/GU8fhwv6IE2R1L+e6mL
         72km/l0L01yC5KL0DTeNXCwz8lKb8aK0vM7RFxIVU6J1qe3p9Q2DvfkGsreuiWw3+4YH
         aVHdR+ZcO6eNtBlI9AUvhtpn6DXvrUkxkge/h0IjVagkS7otfNL+Sa3h/5sm9x7TBVpx
         sss7f6w+5WdQ3FCda1XzZDoSNPp8J5Hobt+RXafUzD9B7UTzmA2nCfaky3uRl9vG2WDG
         6I+Q==
X-Gm-Message-State: ABuFfojxMQ0dGNmzat9rUxyf7H+T20n576z3n3qKII5S03E6fszjz2GX
        aYi2Jj/3s6jPGDglQNlkxWKg
X-Google-Smtp-Source: ACcGV62J+GLm8O0NnZFIYRCe1v+6G8vNE5DFIlBXtNe5XOjWf2JWKhWMG/ZvuB4jGUcKOzQ//oUxnw==
X-Received: by 2002:a9d:4617:: with SMTP id y23mr2208054ote.300.1539299412892;
        Thu, 11 Oct 2018 16:10:12 -0700 (PDT)
Received: from [10.157.197.11] ([128.107.241.182])
        by smtp.gmail.com with ESMTPSA id r33sm11221380otc.37.2018.10.11.16.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 16:10:11 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     Jann Horn <jannh@google.com>
CC:     <christian@brauner.io>, Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        <containers@lists.linux-foundation.org>,
        <suda.akihiro@lab.ntt.co.jp>, Oleg Nesterov <oleg@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "linux-security-module" <linux-security-module@vger.kernel.org>,
        <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
Date:   Thu, 11 Oct 2018 19:10:03 -0400
Message-ID: <1666564e4f8.2781.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <CAG48ez0=NRRu2FUZFwdDSMmkdWsFi1XSSPTO8bL84YAY=jOzMQ@mail.gmail.com>
References: <20180927151119.9989-1-tycho@tycho.ws>
 <20180927151119.9989-4-tycho@tycho.ws>
 <20181008151629.hkgzzsluevwtuclw@brauner.io>
 <CAG48ez3zaqOXH_jHN8=+jXjOf3vhFyWUkM_6KLPi9T8HcQySeg@mail.gmail.com>
 <20181008162147.ubfxxsv2425l2zsp@brauner.io>
 <CAG48ez3O+wAkq+0yDfoMt73ybnCOEPpi3Mu-uF57_v=6hA8ZEw@mail.gmail.com>
 <20181008181815.pwnqxngj22mhm2vj@brauner.io>
 <CAG48ez3PEce4ynRnDk=yfsAOuFGH=YMmuf13CAxEt07Yjk3ZCw@mail.gmail.com>
 <20181009132850.fp6yne2vgmfpi27k@brauner.io>
 <CAG48ez2EV8Z=Egn7hNpXd86bHdvQhVxStqE1N=U2L2R7sA-gjg@mail.gmail.com>
 <CAHC9VhQfzJgG3i=Q8C+pGY2Lpr+2MRTwxgUWec_heGOecd=xRg@mail.gmail.com>
 <CAG48ez2hTBFwmA65FXv0zJjc0_wpc1S-uOBn1t+X=0vPH25YvQ@mail.gmail.com>
 <16662034750.2781.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <CAG48ez0=NRRu2FUZFwdDSMmkdWsFi1XSSPTO8bL84YAY=jOzMQ@mail.gmail.com>
User-Agent: AquaMail/1.16.1-1284 (build: 101600100)
Subject: Re: [PATCH v7 3/6] seccomp: add a way to get a listener fd from ptrace
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 11, 2018 9:40:06 AM Jann Horn <jannh@google.com> wrote:
> On Thu, Oct 11, 2018 at 9:24 AM Paul Moore <paul@paul-moore.com> wrote:
>> On October 10, 2018 11:34:11 AM Jann Horn <jannh@google.com> wrote:
>>> On Wed, Oct 10, 2018 at 5:32 PM Paul Moore <paul@paul-moore.com> wrote:
>>>> On Tue, Oct 9, 2018 at 9:36 AM Jann Horn <jannh@google.com> wrote:
>>>>> +cc selinux people explicitly, since they probably have opinions on t=
his
>>>>
>>>> I just spent about twenty minutes working my way through this thread,
>>>> and digging through the containers archive trying to get a good
>>>> understanding of what you guys are trying to do, and I'm not quite
>>>> sure I understand it all.  However, from what I have seen, this
>>>> approach looks very ptrace-y to me (I imagine to others as well based
>>>> on the comments) and because of this I think ensuring the usual ptrace
>>>> access controls are evaluated, including the ptrace LSM hooks, is the
>>>> right thing to do.
>>>
>>> Basically the problem is that this new ptrace() API does something
>>> that doesn't just influence the target task, but also every other task
>>> that has the same seccomp filter. So the classic ptrace check doesn't
>>> work here.
>>
>> Due to some rather unfortunate events today I'm suddenly without easy ac=
cess to the kernel code, but would it be possible to run the LSM ptrace acc=
ess control checks against all of the affected tasks?  If it is possible, h=
ow painful would it be?
>
> There are currently no backlinks from seccomp filters to the tasks
> that use them; the only thing you have is a refcount. If the refcount
> is 1, and the target task uses the filter directly (it is the last
> installed one), you'd be able to infer that the ptrace target is the
> only task with a reference to the filter, and you could just do the
> direct check; but if the refcount is >1, you might end up having to
> take some spinlock and then iterate over all tasks' filters with that
> spinlock held, or something like that.

That's what I was afraid of.

Unfortunately, I stand by my previous statements that we still probably wan=
t a LSM access check similar to what we currently do for ptrace.

--
paul moore
www.paul-moore.com


