Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D864C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA19C25461
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ysPgDByB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA19C25461
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965021AbeFZMIo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:08:44 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50252 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964929AbeFZMIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:08:43 -0400
Received: by mail-wm0-f65.google.com with SMTP id e16-v6so1631863wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 05:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jbgCHz2vbvtvy0SwoU9JJFegHLoZ9nOkEVfqNuoH/d0=;
        b=ysPgDByBhA302zm+tPaPunILPcYw3rh3jPXBSa9TntoUwhaTNSmxb1oLdjtQYkv/3O
         VoBplj4k0NjzRQOtqS0g4lcgFoGmDQh9Y6iVd1ODvRrc8NlCoe2PESuJpCbzIdipWzMB
         WxJ1s+RcT6OSu/uRYhedYM6DZws6hKhMLHAeZ4r3oYQxdvnRhwJrGbRAb0GuCFQcsYKT
         3ub14b0WYYD3RCQss3x2yemFfR3xjjVm0FvD8EMDyeK//3ljURXIZeZd5XkRL4EtBPRj
         1/KxgHcQN/mVwGdMvlYvkaN97t24J78uDJa05X0A7Ix5U4OE0cmMdz9IPXval2mJuaZ8
         UbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jbgCHz2vbvtvy0SwoU9JJFegHLoZ9nOkEVfqNuoH/d0=;
        b=lmj0UFT/hfjQ9FSnU86KtdjIs4eaDnYcXLUHvkWQQDCUCM3Lir/Ck95Cm4gmoA184y
         c9N+eam84kDoKo3tQEpboxBjt0rJOpbjay93JkEL/J1ArZElZmOXegaGVc/KJfM+rI7D
         qbQRoly7JKlD03DlzG+Yo0Eefre5/oFiwD0nnEgjZ0MBpoGxsszgOloRYx75lr1d0Gh9
         phH1i0Vj6ply7OqlUsvgdHFs7t+9Wrx/OCKrFPndutrZpM8Goe7z/jREOqzUv0fPhiEs
         d37+g0ggfX5rp9ZPF841Bz+9vLknmZ9qhojcopNxWgVNQwXfNxar2BBP31IB4OASuk9i
         WIrA==
X-Gm-Message-State: APt69E2Jg4yOmaQD5wuR/5JxSMq1QWrXNtfdQdt5ydwol8vSCmtB4UxS
        n0TdJIj+XXLyzytopwaQMywAuQ==
X-Google-Smtp-Source: AAOMgpdo4dBnddPOLlKs8ama6hElBdw/PaH0uaKMa/hvaJHRIn1IDdvk8V8hL7sK2TXb3ZxsXisQyg==
X-Received: by 2002:a1c:5451:: with SMTP id p17-v6mr1430718wmi.69.1530014921734;
        Tue, 26 Jun 2018 05:08:41 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h12-v6sm11814152wmb.3.2018.06.26.05.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 05:08:41 -0700 (PDT)
Message-ID: <1530014920.2900.50.camel@baylibre.com>
Subject: Re: [alsa-devel] [PATCH 1/1] ASoC: soc-pcm: DPCM cares BE channel
 constraint
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     jiada_wang@mentor.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 26 Jun 2018 14:08:40 +0200
In-Reply-To: <20180626115526.GC1779@sirena.org.uk>
References: <20180620092520.14101-1-jiada_wang@mentor.com>
         <1530008318.2900.44.camel@baylibre.com>
         <20180626115526.GC1779@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-26 at 12:55 +0100, Mark Brown wrote:
> On Tue, Jun 26, 2018 at 12:18:38PM +0200, Jerome Brunet wrote:
> > On Wed, 2018-06-20 at 18:25 +0900, jiada_wang@mentor.com wrote:
> > > +	/* DPCM used FE & BE merged channel */
> > > +	unsigned int dpcm_merged_chan:1;
> > Jiada, Mark,
> > Do you think we could extend this flag to let the link choose whether the merge
> > should be performed on the codec dais (as done here) or on the backend cpu dais
> > ?
> > I have more less the same need as Jiada but since my card uses multicodec links,
> > merging on the codec dais does not work for me.
> > Like in soc_pcm_init_runtime_hw(), we can't enforce channels min/max based on
> > the codec when there is multiple codecs on the link.
> 
> Ugh, probably that'd work.  The ideal thing would be to remove DPCM but
> we're stuck with it for the time being :(

From comment here and in other mails, I get that you are not big fan of DPCM :)
It is indeed a complex beast ...

It there anything else we can use to represent audio routing within the SoC ?
The SoC I'm working on make heavy use of this, unfortunately. 

