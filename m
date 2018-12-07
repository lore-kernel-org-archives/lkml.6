Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5700BC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1589220838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B7knzsBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1589220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbeLGRxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:53:41 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45304 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbeLGRxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 12:53:41 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so3612467lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 09:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7W2Jo8k5g508fZh2IgM1IBwqeX6LuSif1IWSNZ41Xxw=;
        b=B7knzsBHAQkxqHYV3V1LX900eP3fItBLYzEWCbx+jMDUL4hm5emJPp5WRubve/qlMj
         OQhgGswKGT+/V+Snnn6xpF2MNHZfFEbBK8a/EVyFr43LVoEGEb48hIFHxIrPWxmWgnQr
         5ab5jtCEvpK/jaqMOjO/8NCeJiaLOnV5WBdwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7W2Jo8k5g508fZh2IgM1IBwqeX6LuSif1IWSNZ41Xxw=;
        b=cVS31JkIxd05nMDXfyQXdc5qOWI1ZSbXy1nb0l9bWybRxhvtqRcWyLZfHc5aCS83vW
         a76yNLaWERsJwQRrxrMCNE7Zk5+UBjv5nAeJmA25//JNR+MjtPmSm7PkS0k1xGEZXnNM
         gAZ43hWWG6B9j+V+KttpSe1NETpr8Dp07rXRYEHeFIc1WP9/yKPIf2yLdcrzPpwxxBlD
         z5SZ06PkbBPp5rHYY+tX19vfFbwY25KLdKEwuKPxgnitC/hmgqPU9MC8Mpd1F5wkc/Ed
         wkgp2HRIY8IDJOMBZb96FZcoV8boL4P9JeETZjINGjN+3UjoZb9nELR4kQpuCyuKFjHz
         /vIw==
X-Gm-Message-State: AA+aEWbORKRedQWd+dd9YPM6fUF9EMFykRDhz0/CJ6XuZEaJk6jMivD2
        CpO96Qfya8E+4MbPU/I+rPvSpzG9ZH8J8mUs3Ybj+w==
X-Google-Smtp-Source: AFSGD/U0VhiXesvSTnvcA2a2PYkgpWi509B4Vx9qsagUTS2cco1M9d+psxDY7CtP7OejQ9tl5BqQ0zJIa0IsGqPidfQ=
X-Received: by 2002:a19:750a:: with SMTP id y10mr1841392lfe.43.1544205218964;
 Fri, 07 Dec 2018 09:53:38 -0800 (PST)
MIME-Version: 1.0
References: <20181206143011.174892052@linuxfoundation.org> <CA+G9fYtzxd9a=OVr=Uwcouqikpe2EB_WJyuBhO7BX96mYWJ1NQ@mail.gmail.com>
 <20181207144157.GB20201@kroah.com> <1544196864.2867.70.camel@codethink.co.uk> <20181207155141.GA30688@kroah.com>
In-Reply-To: <20181207155141.GA30688@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 7 Dec 2018 23:23:26 +0530
Message-ID: <CA+G9fYtLrnx7Qihw3xwAQ+vudZ+KR+Va1Z+NM+_dm12ve8UrgA@mail.gmail.com>
Subject: Re: [PATCH 4.9 000/101] 4.9.144-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        mike.kravetz@oracle.com, open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Eric Munson <emunson@mgebm.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2018 at 21:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Dec 07, 2018 at 03:34:24PM +0000, Ben Hutchings wrote:
> > On Fri, 2018-12-07 at 15:41 +0100, Greg Kroah-Hartman wrote:
> > > On Fri, Dec 07, 2018 at 02:40:26PM +0530, Naresh Kamboju wrote:
> > > > On Thu, 6 Dec 2018 at 20:15, Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > This is the start of the stable review cycle for the 4.9.144 rele=
ase.
> > > > > There are 101 patches in this series, all will be posted as a res=
ponse
> > > > > to this one.  If anyone has any issues with these being applied, =
please
> > > > > let me know.
> > > > >
> > > > > Responses should be made by Sat Dec  8 14:29:43 UTC 2018.
> > > > > Anything received after that time might be too late.
> > > > >
> > > > > The whole patch series can be found in one patch at:
> > > > >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-revie=
w/patch-4.9.144-rc1.gz
> > > > > or in the git tree and branch at:
> > > > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linu=
x-stable-rc.git linux-4.9.y
> > > > > and the diffstat can be found below.
> > > > >
> > > > > thanks,
> > > > >
> > > > > greg k-h
> > > > >
> > > > > Mike Kravetz <mike.kravetz@oracle.com>
> > > > >     hugetlbfs: check for pgoff value overflow
> > > > >
> > > > > Mike Kravetz <mike.kravetz@oracle.com>
> > > > >     hugetlbfs: fix offset overflow in hugetlbfs mmap
> > > > >
> > > > > Mike Kravetz <mike.kravetz@oracle.com>
> > > > >     mm/hugetlb.c: don't call region_abort if region_chg fails
> > > >
> > > > Results from Linaro=E2=80=99s test farm.
> > > > Regressions detected on arm32 and i386.
> > > >
> > > > truncate_above_4GB (2M: 32): FAIL mmap() offset 4GB: Invalid argume=
nt
> > >
> > > Can this be tracked down to a commit in this tree that caused this
> > > regression?
> >
> > The test failure is part of a hugetlb test group, so one of the above
> > is responsible.
> >
> > Ah, I missed this fix (it's already in 4.14-stable:
> >
> > commit 5df63c2a149ae65a9ec239e7c2af44efa6f79beb
> > Author: Mike Kravetz <mike.kravetz@oracle.com>
> > Date:   Thu Apr 5 16:18:21 2018 -0700
> >
> >     hugetlbfs: fix bug in pgoff overflow checking
> >
> > Ben.
>
> Thanks for this, I've queued this up and pushed out a -rc2.
>
> Naresh, can you see if this fixes the issue for you or not?

Yes This test getting pass on -rc2 on all devices arm64, arm32, x86_64 and =
i386.
truncate_above_4GB (2M: 32): PASS

Thank you
- Naresh

>
> thanks,
>
> greg k-h
