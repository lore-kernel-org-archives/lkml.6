Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174E4C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 21:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA87F2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 21:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA87F2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbeKPIAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:00:40 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42401 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbeKPIAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:00:39 -0500
Received: by mail-lf1-f68.google.com with SMTP id l10so11594632lfh.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 13:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6eXWvU1hc1vq5nQl2iRF8gvooNDGaeCWPSdQLhdgWtE=;
        b=brPKOhhMmbZ3TRH1jOheSLSAnYXCIa1s0uPMNge3tZ7ZLVXapXfWKl1rAxLSQnCzxi
         Jv5SE4Zt2IijQkHunE7Zc8hxT/0XT89KsQJud+ART7/KUeFz9g8j4811/42FMvN2LbL7
         Kiswh++McApkAqdltqq3nZ9ehw8WtcFJtX46vumeiASiJBiPLKHMkYFGzt06asbnTckd
         uhOo6dsyf3umcG+Y8MQ3GAf024250FLEy2h8NZqzrMzJWT6mWONLbvHZLMHU7KHetrae
         KAH+2LRueOv5nKVJ3xmiwGOCzVZspMBAfuVp40VwS0L2ABRQQ49VtG7Ve6J0/qJq6VUf
         VX9A==
X-Gm-Message-State: AGRZ1gIi+IWiWzuanMZj5/hdCGVe3EVig2zNYdTow6fmEXbephUZHF1t
        8BW937ihpMLNALHTsWIMou9zAFvOu+biYM2rH0wPig==
X-Google-Smtp-Source: AJdET5cEPCMgrcfXSSn98VpF7wsquCKN1QBCYi6JvQGpPURf8e14Xu1ow5V4gceQ7+oWm1P2HhITd+d3IPJM+hcngvw=
X-Received: by 2002:a19:750a:: with SMTP id y10mr4215653lfe.43.1542318662777;
 Thu, 15 Nov 2018 13:51:02 -0800 (PST)
MIME-Version: 1.0
References: <1540593788-28181-1-git-send-email-bhsharma@redhat.com>
 <20181027100241.GB1884@MiWiFi-R3L-srv> <CACi5LpPf9Zr1beowRNGmLZY7DtS3JDt8D=FONjqas9yo7TyCjg@mail.gmail.com>
 <20181030020752.GB11408@MiWiFi-R3L-srv> <CACi5LpP0_s9zAF+QfKpU+kG6BKqqkiwQhcW-WFZ0=SnBeX7ZXA@mail.gmail.com>
 <20181030085917.GC11408@MiWiFi-R3L-srv>
In-Reply-To: <20181030085917.GC11408@MiWiFi-R3L-srv>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Fri, 16 Nov 2018 03:20:50 +0530
Message-ID: <CACi5LpPrYgiy--FRgN4549cxLPMrtx6mY9_QRggKNo7gK3WxYw@mail.gmail.com>
Subject: Re: [PATCH] x86_64, vmcoreinfo: Append 'page_offset_base' to vmcoreinfo
To:     Baoquan He <bhe@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Dave Anderson <anderson@redhat.com>,
        James Morse <james.morse@arm.com>,
        Omar Sandoval <osandov@fb.com>, x86@kernel.org,
        kexec mailing list <kexec@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,

On Tue, Oct 30, 2018 at 2:29 PM Baoquan He <bhe@redhat.com> wrote:
>
> Hi Bhupesh,
>
> On 10/30/18 at 12:33pm, Bhupesh Sharma wrote:
> > > Why it's broken? Have you investigated and figured out why it's broken?
> > > If fix, what patch will it look like? Does the patch prove it's not
> > > worth using the current way?
> > >
> > > Have you thought about this in advance? Or still like before, you said
> > > on arm64 you found different boards have different behaviour, then
> > > makedumpfile maintainer Kazu said he investigated and found it may be
> > > caused by KALSR. This time, for this KCORE_REMAP adding, can you help to
> > > investigate further and give an answer to the issue you found and
> > > raised?
> >
> > Ofcourse, the patchset which added vmcoreinfo into kcore was discussed
> > and it was agreed that this was a better approach to move forward and hence
> > accepted in mainline.
>
> Currently I am wondering why x86_64 need add page_offset_base to
> vmcoreinfo. Is it because any feature or userspace tool is broken if
> page_offset_base is not added into vmcoreinfo?
>
> Why KCORE_REMAP adding broke makedumpfile, do you find out the root
> cause and what it looks like if you fix it in the current way?
>
> Can you list the reasons one by one as below with short sentence?
> 1)
> 2)
> 3)
>
> >
> > Regarding the makedumpfile issue, I have already provided a detailed
> > reply to Kazu (you are Cc'ed on the thread) and also proposed a
> > makedumpfile approach which
> > reads the 'page_offset_base' value from kcore (using the kernel
> > interface provided by this patch),
> > [on which you are Cc'ed as well]:
>
> This is your replying mail link:
> https://www.spinics.net/lists/kexec/msg21616.html
>
> Then what on earth do you want to fix in this patch?
>
> So Kazu's patch which decuding page_offset_base like x86 64 have done works.
> Yes, and your way using vmcoreinfo in kcore also works, but this is not
> the reason which supports you to discard the old way Kazu suggested. Now
> we are talking about why you want to discard the old way, and adding
> page_offset_base to vmcoreinfo.
>
> Please elaborate and reply with simple and clear logic.

I have sent a v2 patch with a much simpler git log message. Hopefully
that should clarify the intent behind the patch.
Also lets see what views the x86 maintainers have on the v2 patch.

Regards,
Bhupesh
