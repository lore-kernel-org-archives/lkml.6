Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2652C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD20720877
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJVvrpR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD20720877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732391AbeGKI37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:29:59 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42472 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732376AbeGKI37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:29:59 -0400
Received: by mail-lf0-f68.google.com with SMTP id u202-v6so20569896lff.9;
        Wed, 11 Jul 2018 01:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jQ1VliKAS89519IiVVIeZY/w/9fWgZ3b4QnIXWmxZIQ=;
        b=PJVvrpR+Pu7iXlzP7TJjHZXT+Nob1u4nJNtP8hw+kiHzWj8j95Vk2kjuHEsP2ieeAA
         5DUAAsenSOehe15WMvmGc16aIlRCLznS48skbz3vk/pSCKJFfA2q8XITAiOjzMb2yPFj
         eeULzO9Q1i9n1NM7uDBji+xuboSKYlJq+Dc5M5PjwrT66d8XPs9NyjtwGsSizw+qa/ku
         T55jH9fhdbiR1C//3ccRZjoyhLM7h5CgXDYKddP40497GHJ0dmKXkSjyByZCCBu3z9wr
         i4NGIN5nxNCkbp5rxYOrNFF+oOKPac9bu2whBKcvHUsyAV2kIXan/MfsRq4J9oavzlsy
         YNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jQ1VliKAS89519IiVVIeZY/w/9fWgZ3b4QnIXWmxZIQ=;
        b=Z3QLx4Nt9uROu07HgNyEc88gVdt51uXWNvg/nRORD15U6Qww/l+fWtRYCn3QhpNIK7
         IFukiH/oj9Nv1pmSlzFYxx7XtaPmxLax9NKcCOBYRcWDPFGYXt9mqctxyE18kaOfIOAj
         9HgbZW7Xx4IR95nAq8WCnVPcVBpIkyveh4iRnhVrA9XmNXe6YcSXuxVYjD3AT3tEo24y
         Ns2YF2KrjeXocmaxzD8aC7H0irJDsm+as0m7O8rTs4z2zO0UUFkDHJOZYUdfRIU9Zpji
         cyahDmDH3jWb/uiNALqthK1ZtopOc7zwdb0VhSiUquRgONKTxi20YkEGNzMIUyd25yOf
         yR8g==
X-Gm-Message-State: APt69E2WPfcQ7P1IaZWSbiL1WMYgCdbLWUTLReuUTCt86F5bYUWqI6th
        WMr3X6uYoB3p+98P/t0DmYY=
X-Google-Smtp-Source: AAOMgpcMAX50HmuI+45mNxJXS/SiTKZkBFqhlKycOiZXJfIbiK4vPIqG6Js2V+GTHT6aQYBRPDkM+A==
X-Received: by 2002:a19:921a:: with SMTP id u26-v6mr5340489lfd.89.1531297609048;
        Wed, 11 Jul 2018 01:26:49 -0700 (PDT)
Received: from mobilestation ([5.166.218.73])
        by smtp.gmail.com with ESMTPSA id g17-v6sm3008495ljg.27.2018.07.11.01.26.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 01:26:47 -0700 (PDT)
Date:   Wed, 11 Jul 2018 11:27:36 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, okaya@codeaurora.org,
        chenhc@lemote.com, Sergey.Semin@t-platforms.ru,
        Linux-MIPS <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "# v4 . 11" <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] mips: mm: Discard ioremap_uncached_accelerated()
 method
Message-ID: <20180711082736.GA9387@mobilestation>
References: <20180709135713.8083-1-fancer.lancer@gmail.com>
 <20180709135713.8083-2-fancer.lancer@gmail.com>
 <CA+7wUsxDfBdiGt5tZ7dxb63oMd=3Ry4s1Xysed8RSHJi35=VxQ@mail.gmail.com>
 <20180710074815.GA30235@mobilestation>
 <20180710175940.rbjmdcpm54gfrael@pburton-laptop>
 <20180710191354.GA32182@mobilestation>
 <20180710210415.4uqstovovdfvxfup@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710210415.4uqstovovdfvxfup@pburton-laptop>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,

On Tue, Jul 10, 2018 at 02:04:15PM -0700, Paul Burton <paul.burton@mips.com> wrote:
> Hi Serge,
> 
> On Tue, Jul 10, 2018 at 10:13:54PM +0300, Serge Semin wrote:
> > On Tue, Jul 10, 2018 at 10:59:40AM -0700, Paul Burton <paul.burton@mips.com> wrote:
> > > However FYI for next time - you shouldn't really add someone else's
> > > Signed-off-by tag anyway. The tag effectively states that a person can
> > > agree to the Developer's Certificate of Origin for this patch (see
> > > Documentation/process/submitting-patches.rst), and you can't agree that
> > > on behalf of someone else. Generally a maintainer should add this tag
> > > for themselves when they apply a patch.
> > 
> > I'm sorry if it seemed like I added Signed-off on your behalf.
> 
> That's OK, I didn't think you did it maliciously :)
> 
> > I thought the Signed-off also concerns the ones, who participated in
> > the patch preparation. Since you suggested the design of the change,
> > I've decided to put your name in the Signed-off tag. What shall I use
> > in this way then?
> 
> In this case Suggested-by might have been a good choice. Reported-by is
> also commonly used if someone reported a problem which you created a fix
> for.
> 
> Section 13 of Documentation/process/submitting-patches.rst describes
> these tags along with a couple others.

I always thought of these tags as something more like a formality. In fact
this hasn't been my first patchset sent to the kernel e-mailing list.
Although all of the previous ones didn't involve someone else participating
in the changes development, except the reviewers of course. So I do aware
of all the tags mentioned in the doc. But as it turns out I didn't
fully understand their meaning. Main rule: most of the tags should not be
added without the permission, except more or less formal CC and Fixes ones.
Anyway thanks for the advice. Next time I'll be more careful with it.

Regards,
-Sergey

> 
> Thanks,
>     Paul
