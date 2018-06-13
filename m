Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4B056C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5EE208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIDlq+i3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5EE208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935821AbeFMVAE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:00:04 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:37516 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935524AbeFMVAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:00:02 -0400
Received: by mail-ua0-f193.google.com with SMTP id i3-v6so2676249uad.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 14:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gT7r1sibYLOAhXCDknByiosKTTDrsSY14UqJOEGxSqU=;
        b=eIDlq+i37Ztjt7HOsbfOy5X5wBT0MoGIlLM8U/bJ7t4bm/PfueXBRO1lzPtlVbERIg
         2Y+jT3jTNvp7jpYTg4azllfJNALM34yYhHlWmxdbDjU4wg3REsTAsHehEMrZI7MtthV0
         xwapgEyt35+ytaCyhr3VVFr6XAhxweT2oqHCJjcwG6aXL0uQDRdouoksjHb3bfekrb3G
         rnOZIBc3B4h2dIcUFzYzim4+5QTyR830qR+pZM5z9+XJd60d5W/F+WXFqDb8/HDKzNwr
         5HQJvWaB+oVTVEBA4N/I+AVUMfwUg2g9hVIeN6q/+ysHKziX5gsu23i0AYDhTBqs3EXj
         Sp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gT7r1sibYLOAhXCDknByiosKTTDrsSY14UqJOEGxSqU=;
        b=qFmjCgtpbvyftJQHCobFaLGglnfJev9fFxu/whpMOEeK+sI3yZ34WSBmLoZ/RmhSMt
         JKJiSMA6ZXEYR13v0ClrbcdbFF7AM93wyBKhSGA3xXWC4p8nfY55RvDtA7cMtdd5YS7u
         YBKHbqnJ11+ohoIuTFo8uXczKIEOY1S0zYnX0si80AjcFsYry/0C96r9uZ8r+YsPM9qF
         yMrbDwbrYwg3G/4qMMuLPVUCyG6atEhLPvSNWG0z/JPKWjMsp5P0DaFWd2kdWanAvBGY
         BezjQMN4DPLuRH9+eXUvW41eYoRvMMKvQxq7U5BtqI1Mxn4az9amvhCIXZKZMsPwue58
         3ztQ==
X-Gm-Message-State: APt69E1HRuNSLXDdjFna/wfgTPC2liytts68X4l/Ko9l2DbcQdTdkbcD
        0F65y2EVtvicFGdVtCdfoO5kRHDG
X-Google-Smtp-Source: ADUXVKI8095yFTth1wktYEHTtubp3hvtVorel2norLd4FP1+ML+SoP6QimYG+EG8GqCHHECSwKiQcA==
X-Received: by 2002:ab0:4f04:: with SMTP id n4-v6mr4435535uah.172.1528923602052;
        Wed, 13 Jun 2018 14:00:02 -0700 (PDT)
Received: from javier-Z97X ([2601:582:c500:a66c::21e8])
        by smtp.gmail.com with ESMTPSA id j18-v6sm471398uan.2.2018.06.13.14.00.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 14:00:01 -0700 (PDT)
Date:   Wed, 13 Jun 2018 16:59:55 -0400
From:   Javier Martinez <javiermlinux@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: octeon-usb: octeon-hcd.c: style fix line length
 warning
Message-ID: <20180613205955.GA16029@javier-Z97X>
References: <20180613204015.GA15689@javier-Z97X>
 <20180613205255.GA14313@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613205255.GA14313@kroah.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 10:52:55PM +0200, Greg KH wrote:
> On Wed, Jun 13, 2018 at 04:40:15PM -0400, Javier Martinez wrote:
> > Checkpatch.pl issued a warning in the top of the commment within
> > octeon-hcd.c. This is a simple style fix for that.
> > 
> > Signed-off-by: Javier Martinez <javiermlinux@gmail.com>
> > ---
> >  drivers/staging/octeon-usb/octeon-hcd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
> > index cded30f145aa..768b0148f3d5 100644
> > --- a/drivers/staging/octeon-usb/octeon-hcd.c
> > +++ b/drivers/staging/octeon-usb/octeon-hcd.c
> > @@ -1,5 +1,5 @@
> >  /*
> > - * This file is subject to the terms and conditions of the GNU General Public
> > + * This file is subject to the terms and conditions of the GPL
> >   * License.  See the file "COPYING" in the main directory of this archive
> 
> The grammer is now incorrect :(
> 
> Shouldn't we just have a SPDX line at the top here and this whole boiler
> plate text be removed?
> 
> thanks,
> 
> greg k-h

Sure, will get right to it. I am actually newbie to all this.
I watched your tutorial on youtube when you were at FOSDEM,
Huge help, thank you for that.
