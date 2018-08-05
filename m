Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6735BC46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 21:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D34E219A2
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 21:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vAKhRKfl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D34E219A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeHEXlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 19:41:36 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:40655 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbeHEXlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 19:41:36 -0400
Received: by mail-ua0-f196.google.com with SMTP id m13-v6so10025084uaq.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 14:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lgdiXFluR903lvXgRiPtlA0Zp7ZASnFLlsPSseuNe00=;
        b=vAKhRKfltz+cqEKaf1Z4OQwrQgyL+2IaZdpFE3yf86mpCwpyEhKlVDNMSe/rd9tEp9
         Boi/InrCe6O9F7Sh9/ScFTe8fJ6GDDlIUpWkYTZoxCGUsVYONq7fwNhpwblmSKSAesNf
         IjCEBLGDW1OBkHv6fELcpFMxLjNzqyeoTlQm2UInXuyEe7M1bHGdQBGpuhTisK9XyWgs
         k/CRgMqlRsawzmBfEeqZUhLkFEaxGn7U+AuDWru+PWzpFCYtllWBy/xPuPM4g24Ocy6R
         JUczVaoue5zUOtsUipLqLMq6QPoKlIUezAtj5MaH2/GPJilzoQ65Fcosn1/x5gTSojxd
         SsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lgdiXFluR903lvXgRiPtlA0Zp7ZASnFLlsPSseuNe00=;
        b=HNLsxLr1PPpDGV9AUMNdjsILA6WTrWwkRkBso3kqdU2DOn9E6HRFWbbJlVfqcsCI0H
         WkkXWKxmM8EMUFE9ZtkRwE1Mrsfc3De8bX6/Wc2V6ogUTtaP9zGHMRqL+Ykhy8wFhFy3
         04o1NbeADfd3nfDjKZpXPr3aWzdtMfzOsqdRa4EgnuqVUEIWFtZo+2z/t0bgE7JDqT9a
         AvgIRmrcLQO09vSIBkhCvDmyI2zmJJdzhawIAz2chRqPV7suk+9937UPpA59ERe0qxqq
         oKUzjHEONmsObC90XSOM7igvdF1oB4hT3XVAEaIKQhfON90juTNDNbfLzYFk8oY0oF8L
         p3nw==
X-Gm-Message-State: AOUpUlEd1sepsOKrfDa5PpikPM/1f2ajrcR8sVgX0izyplxjMA3F/+0P
        IWjXgSv0eYi9j/zWaQfIbLV+SXVTDaT0/dWwQ4I=
X-Google-Smtp-Source: AAOMgpd2H35H62hbmrIAYURNr34C/0ZAmyE+b8eU/Ym3wb6OFTgXG2E7t/BFTTku8KhXVwpovnO3ysrhR5tcysehY3Y=
X-Received: by 2002:ab0:17ec:: with SMTP id p44-v6mr8766809uaf.53.1533504934456;
 Sun, 05 Aug 2018 14:35:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:7187:0:0:0:0:0 with HTTP; Sun, 5 Aug 2018 14:35:14 -0700 (PDT)
In-Reply-To: <CADPp2fCY7DKi_0fxi+r986T3e=7rzygAPHLby6amcdC11f+=Hw@mail.gmail.com>
References: <CADPp2fB3Oj3Jm08rVqeHxX855EnO8+22-H552Q6AFfJL-dWmtQ@mail.gmail.com>
 <a88b1975-4232-4b6f-9497-ab44dbdda5d6@suse.com> <CADPp2fCY7DKi_0fxi+r986T3e=7rzygAPHLby6amcdC11f+=Hw@mail.gmail.com>
From:   Adam Novak <interfect@gmail.com>
Date:   Sun, 5 Aug 2018 14:35:14 -0700
Message-ID: <CADPp2fCdYc2ER+Y7RUU0ZOkU-vr_b=Ep+dhEg7fcSd0TzK-g-g@mail.gmail.com>
Subject: Re: Problems with Zen under Xen and recent Linux kernel improvements
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I pulled that commit, 74899d92e66663dc7671a8017b3146dcd4735f3b, in
to the Ubuntu kernel and it seems to solve the problem. Now I just
need to get Ubuntu to ship it.

Thanks!

On Sun, Aug 5, 2018 at 12:27 PM, Adam Novak <interfect@gmail.com> wrote:
> Sorry, I am using Xen version 4.9.2, specifically 4.9.2-0ubuntu1.
>
> I am seeing the bug with *kernel* version 4.15.0, and specifically
> Ubuntu's tag Ubuntu-4.15.0-23.25. That appears to have the "x86/cpu:
> Re-apply forced caps every time CPU caps are re-read" patch, but not
> "x86/xen: Add call of speculative_store_bypass_ht_init() to PV paths".
>
> I can try cherry-picking that commit. Are there other commits in
> particular that might need to be pulled into the Ubuntu kernel to get
> it to work?
>
> On Tue, Jul 31, 2018 at 4:58 AM, Juergen Gross <jgross@suse.com> wrote:
>> On 31/07/18 03:14, Adam Novak wrote:
>>> Hello,
>>>
>>> I was advised to take this here, and to Boris Ostrovsky and Juergen
>>> Gross, by Thomas Gleixner.
>>>
>>> I am having some trouble with the new speculation control code that
>>> has been added to the Linux kernel, for AMD Zen CPUs. I am running an
>>> AMD Ryzen 7 1700, and I am running Linux as a Xen dom0 (which is part
>>> of the problem; the code seems to work fine running outside of Xen).
>>>
>>> I started having trouble on Ubuntu's commit
>>> 3f6a3b035f91a22c0d3bd27630bf61eac9c8cf6c, "x86/speculation: Handle HT
>>> correctly on AMD", which appears to be cherry-picked from
>>> 1f50ddb4f4189243c05926b842dc1a0332195f31. Since that commit, my system
>>> hangs during the boot process; it starts starting stuff up and trying
>>> to mount things and printing "[OK]" messages, but then fairly early in
>>> the boot process the kernel complains that it is "unable to handle
>>> kernel NULL pointer deference at 000...0008"
>>>
>>> On my Ubuntu bug:
>>>
>>> https://bugs.launchpad.net/bugs/1777338
>>>
>>> I have a "Screenshot of the null pointer dereference message". It is
>>> running into trouble during a spin lock in the new
>>> speculative_store_bypass_update().
>>>
>>> Has anyone else seen this behavior on these CPUs under Xen (I am using 4.9)?
>>
>> You want at least 4.9.112, especially due to the missing patches
>> "x86/xen: Add call of speculative_store_bypass_ht_init() to PV paths",
>> "x86/cpu: Re-apply forced caps every time CPU caps are re-read"
>>
>> Juergen
