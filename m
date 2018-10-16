Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8255C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5B32086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cq1hSWMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5B32086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbeJPXnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:43:06 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36702 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbeJPXnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:43:06 -0400
Received: by mail-qt1-f194.google.com with SMTP id u34-v6so26269272qth.3;
        Tue, 16 Oct 2018 08:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gCKTNClp2yvKEISOoXozjZYcjejKdZkaxGx68gHbOFA=;
        b=Cq1hSWMR4PvDzQNcMBse05Fj/OhGgNKS8zRn9Q5lisdQGUxlNMW7o2xp1NrVDe1FRn
         VyAVYGjx+mTwZvydkP1D1iZOV9YThpihzzyayKNai/uzAGqSftNxREV6kgEEhDte6lbJ
         DGWY6UuaoHIfIp7ty6RoNS7BGJNF0ps8Q9JybvNzYQxnrEETU6DkapgAHK3IuYv12eVb
         xdhDrdm/8ntDGKEOk1UfcOQLVNrhbp7pYBKgls9xwVVZI5+HxsjXXp4tFIOy41VsDcP8
         G47Ol0ScZyPY6S6kM4NJptzBWtwzP6IckeTzrXuXVUkaA73QIFPtb5p30lciIoJKI5Gb
         z4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gCKTNClp2yvKEISOoXozjZYcjejKdZkaxGx68gHbOFA=;
        b=JtZJ6xIe3LMiVYrRqd2V5o5et7fHao9b9QdqHuFxL9bsGNwPwBzPFNk4S1LeMSiBTR
         kf1krIgM0/lreJHrq7Ul9ougGTf9U+BMeROFhH/AJqE7vNFd3k8J+qY9hPnF1xNfZqV3
         p4HXkf1FkSZxxJgbnPnCnnakhre5gW2F7hk7Zristxtg23AYMZlD46F83LfJXZYeZMOa
         UW6E7+Rv0j/IR5BigTPdExTrUy7Un2ZGhmza0i58SRN3nmdODBfX6yWe4ZlmxZi517kV
         5LeT34vGYUCyRWilfafgZLBvH0BB2PYEWQWMi+JYHQxnZ9vwinCxWJrtpcQRPYKRIXvJ
         21gQ==
X-Gm-Message-State: ABuFfogdPWYy+VDl3kGMOf6Z3VQSY77S+515EeorpXxqZdKvMeiNZqXA
        +/71xo516ZXjfxdO1f1i43lg+MCumqLonj3lVLA=
X-Google-Smtp-Source: ACcGV63okDkzZG35mxbb1fHX9DLTQ6Doaih96jIsyZcbWIgUqDglhR+S3QJx0+dpPp6JnePzbuRG3YEjoaRfJ8A1XcM=
X-Received: by 2002:ac8:190e:: with SMTP id t14-v6mr20179178qtj.327.1539705122910;
 Tue, 16 Oct 2018 08:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <262d8a05cedc76bc90fa5be7d3b92d5faa2b4ce9.camel@perches.com>
 <20181012162816.14396-1-david.e.box@intel.com> <6fd036103f87d52214694ac0a172527a113c07b5.camel@perches.com>
In-Reply-To: <6fd036103f87d52214694ac0a172527a113c07b5.camel@perches.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Oct 2018 18:51:51 +0300
Message-ID: <CAHp75VcPiyU+NKnzEdqSye2Eat8RtxNyFbUKZ3DGdXinF5A=eg@mail.gmail.com>
Subject: Re: [PATCH V3] MAINTAINERS: intel_telemetry: Update maintainers info
To:     Joe Perches <joe@perches.com>
Cc:     "Box, David E" <david.e.box@intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rajneesh.bhardwaj@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 7:46 PM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2018-10-12 at 09:28 -0700, David E. Box wrote:
> > Remove Souvik who has left this role. Add Rajneesh and David who work
> > jointly on telemetry updates for new platforms.
> >
> > Signed-off-by: David E. Box <david.e.box@intel.com>
> > Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> []
> > diff --git a/MAINTAINERS b/MAINTAINERS
> []
> > @@ -7355,7 +7355,8 @@ F:      arch/x86/crypto/sha*-mb
> >  F:   crypto/mcryptd.c
> >
> >  INTEL TELEMETRY DRIVER
> > -M:   Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>
> > +M:   Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> > +M:   "David E. Box" <david.e.box@linux.intel.com>
> >  L:   platform-driver-x86@vger.kernel.org
> >  S:   Maintained
>
>         S: Status, one of the following:
>            Supported:   Someone is actually paid to look after this.
>            Maintained:  Someone actually looks after it.
>
> Perhaps this is driver status should be marked
>
>         "S:     Supported"
>
> >  F:   arch/x86/include/asm/intel_telemetry.h

Thanks, Joe.
I may fix it when applying.

-- 
With Best Regards,
Andy Shevchenko
