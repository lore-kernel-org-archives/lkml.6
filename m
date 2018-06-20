Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6486FC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1341B20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFcqRLW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1341B20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754441AbeFTRfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:35:15 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43058 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754185AbeFTRfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:35:14 -0400
Received: by mail-oi0-f66.google.com with SMTP id t133-v6so326477oif.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qSJqeomfTXTTtCStsdga/WYRMWGC7tEQH+acYOsWp28=;
        b=mFcqRLW8+R+jL26CSlUvz036s+t3LmPd9JhIqD/a78f3E98fyFoBRu30AZGViNSW0O
         LX4TF+YoAqofhzwuDlfZvPHoR+HDl5LhIPCW526ASLdDciqBU4l2pjzedPiBgxNUc6ca
         iVN30+BIK/0vKFT/hlPJQAbgExp2Aq/DhVjn5q/hJapjVWl8reYJj+tGBZubtqHA/RLp
         LPAqv+8tTsn+h1nA9LgkSbozGut2m3xlR9ixMObEtYa0C4ZwT6OfAaILhlCp1sxf34K5
         ir3xsTxQfp+tH/T5RM0FTetcFOpr+V8ycQQFF63keJ4xXBG6KL7roqgT2n8N5WvL5RZ3
         widw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qSJqeomfTXTTtCStsdga/WYRMWGC7tEQH+acYOsWp28=;
        b=sqB6uQvO8feGAhArsld8AuLB3RaRnrN572pI9EEHZrrw/qlsIeS+BbQrpPdBMNl5zv
         1+XmVhd+0/kBiNLninncv0BPqmjvBlL/icxO+Rg331cIepcSlrr29RGrCe5YlzDgKbj5
         8HpXmMdZUf5IXxXFM49R1J/4HYN6oIoBnbemn6TPmzDGWp03QsbE3xJPfurMTHpAK7Bi
         EbOSywPUY0v2G85tpSXpqO+wvp+bh48Mc71rGl0RLG43sBqTbuda/Nc7M2/MHj8JGIjU
         0otSWW7GDWrOOHuh/nfi0h5hqUvnB9uSONl9AEzz4UuWmSYiLtUckiUb8JDD99MdrOrE
         kicg==
X-Gm-Message-State: APt69E0LxhQo5B6HBeNCVhnr0ld6uPsN8B11+96Akj/l8Ce+7lD+QJuY
        eFDtoBtWkjcImjiqADaqfpc=
X-Google-Smtp-Source: ADUXVKIMM3Br1IVbjj/1GlBjRxiuYsIsm3cki1t1y23DbR7K7QXSukn0rufP8T7UJ74MWYJhXkdxBw==
X-Received: by 2002:aca:da87:: with SMTP id r129-v6mr12841570oig.199.1529516109446;
        Wed, 20 Jun 2018 10:35:09 -0700 (PDT)
Received: from t7-ThinkPad-E560 ([71.41.190.130])
        by smtp.gmail.com with ESMTPSA id k47-v6sm1906730otb.50.2018.06.20.10.35.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 10:35:08 -0700 (PDT)
Date:   Wed, 20 Jun 2018 12:34:53 -0500
From:   Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel][PATCH 2/3] ASoC: TSCS42xx: Remove Playback/Capture
 in names
Message-ID: <20180620173451.GA3900@t7-ThinkPad-E560>
References: <cover.1528143829.git.steven.eckhoff.opensource@gmail.com>
 <a1f30fe79d376bb1dea4c41a34f198310a8ff9a4.1528143829.git.steven.eckhoff.opensource@gmail.com>
 <20180618113154.GC6928@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618113154.GC6928@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 12:31:54PM +0100, Mark Brown wrote:
> Really?  They're part of the spec so it indicates that the apps have a
> problem...

I apologize for the delayed response.

I am unable to reproduce the issue that I was seeing with controls that
had Playback or Capture in their names. I am going look into this
further.

I was seeing an issue with amixer set where it would not find the
control, but I could use the numid. I wanted to make sure that it would
always work, so I could provide amixer set commands using the name of
the control in our documentation.

Regards,

Steven
