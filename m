Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E11C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A34320833
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uNCILmVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A34320833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387905AbeITVO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:14:26 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40996 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387481AbeITVO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:14:26 -0400
Received: by mail-lf1-f65.google.com with SMTP id l26-v6so8733554lfc.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 08:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BrP4s4tbT/vopMvbXg/Pe3Z/dzUJDLKn9XG52WOOPJo=;
        b=uNCILmVO5Hr/iwyEBRVx82bjjmyR8z7BfLDOwAwRQhMPIxMvtzasIeNCSfF8YYTl6J
         vW2r+5w/A66sNlWcUW4f6300mrwjV+wCu2WMJOCLkm9i666B45k3jc/X6EfRkkLJb6Bf
         lHzJpo80hIWsIycTSIYpkRAXrVKR9un5Mzhrs4av/11PhPrByPPUcO/coxvVfoW9LLWK
         TtuIxRG03Hmy/508aHDAaU80SJ5unRVWkuvVBTIpzC4xGPGUoBHDAoHG2TI/oIf9dpkL
         eKizs3DDXhp+KjdJeXNZdk9BO8mhf7qtwz1+JDwtbuc3RfDbKvL4qM2sqKC19i4WLJhZ
         r9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BrP4s4tbT/vopMvbXg/Pe3Z/dzUJDLKn9XG52WOOPJo=;
        b=Jev04+7doQxaMjAfCbsdCGQrc2jzh7PmHbLDNqA1AQa/aGTG5xwmoVCgaDQVMARUQb
         +Iqhuc07UjJCrc1L8Qv6HXuO4sUs810/DA6zEcPnazhAi0w/i4/j/mGDPjn6G0UGn+Da
         6beYnfQjOqtPOwhqjce6AnEJDiEUClTb/bkLLfHtHmK8nC2Q+4RmKGSkuXy9sWwxJg/d
         MgNqVXPWRjJIgYKZJC4pJXwS78jM0S0MS0aqXzi//ypJ4l6mhi0ffuUYZR+TdBh+0hBU
         F774fE8fYv3C1Mj1nnmsCfvoOe1i3uP9wOs9BL6WXpbTn4yM/klF4hDb2ybtFXIMjwif
         z/bg==
X-Gm-Message-State: APzg51CMDjhNsYuNB08uRj3PJdygfTsVztS2c9vEPpH5ObA0PPGI5VII
        OUX2QoQo4QGEEsNMNOU1RPfKTs3or5hFaP6xZbo=
X-Google-Smtp-Source: ANB0VdbkaXffb/Lb1qgvpiby4Yi6FQ+FLO6EqeyI+pcpjNDQjMAThxgEF6hmMeIAar0vi+rPllxR4oVbmGb8W/DEfPE=
X-Received: by 2002:a19:9113:: with SMTP id t19-v6mr11937203lfd.98.1537457423302;
 Thu, 20 Sep 2018 08:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180920143237.10000-1-jandryuk@gmail.com> <5BA3B4B202000078001EA517@prv1-mh.provo.novell.com>
In-Reply-To: <5BA3B4B202000078001EA517@prv1-mh.provo.novell.com>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Thu, 20 Sep 2018 11:30:11 -0400
Message-ID: <CAKf6xpuPRsodEoZ0mAOdJBTSpcUsXNUM8so64Uk7PSH9L=RjYw@mail.gmail.com>
Subject: Re: [Xen-devel] [PATCH] xen: Make XEN_BACKEND selectable by DomU
To:     Jan Beulich <JBeulich@suse.com>
Cc:     xen-devel <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 10:54 AM Jan Beulich <JBeulich@suse.com> wrote:
>
> >>> On 20.09.18 at 16:32, <jandryuk@gmail.com> wrote:
> > --- a/drivers/xen/Kconfig
> > +++ b/drivers/xen/Kconfig
> > @@ -101,8 +101,7 @@ config XEN_DEV_EVTCHN
> >
> >  config XEN_BACKEND
> >       bool "Backend driver support"
> > -     depends on XEN_DOM0
> > -     default y
> > +     default y if XEN_DOM0
>
> Why not the simpler "default XEN_DOM0"?

I didn't realize you could do that. :)  Yes, that's nicer.

Thanks,
Jason
