Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0356C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8540023E3A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="O7L0LyQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8540023E3A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965065AbeGBKLZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:11:25 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43195 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753048AbeGBKLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:11:24 -0400
Received: by mail-wr0-f195.google.com with SMTP id f18-v6so1209217wre.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 03:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/k5HpcLvF+TeChr2jSzoQ70qkl/QF3XZPMa7b4lxeWw=;
        b=O7L0LyQ3U7qE2FyiM3z8shqTYDUxzaeT3c5ss8M2OxoBGg2JxXJE3V8/Spwe+z69v8
         tGTwRlTPs7H7OY6TDi2Rd/EUcp16ATF8s8mvB5nVQdZPZDLTpKZZLxDdDlxpt5090Kmu
         X0nBJwrTbPz8gmI3RZ1SmguoDMloJ8I+nzJC5kacseS/1vs9DiYHPWGDda8eBhLD3w4n
         xfV0pi9r60FwenpDhrCAVOSNF34XSYgbEVffm795CLR0EqYyCF6YmskGLLwzG4/MLydS
         v6rTzt39zZkATKEXUkTvfxt9/UHqhaFRAfTc/+GqvPfd26nIPhC9tCfx+j1TgDFcPaf/
         Bmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/k5HpcLvF+TeChr2jSzoQ70qkl/QF3XZPMa7b4lxeWw=;
        b=CUe94+Q8ouzYRY5o8neBAD+xTpJ8LHxMmVCQs+Vf43HApLndiR2jiVSthk1zu+5Cvx
         DjeWzamYjycPBZ9PIPssqduujugMdt3cLqvPYHixNSZiunppOmUAUVZ65b94Rv8uxudq
         a3kBPkMXTa2Qr43ceoGFji6Q++0Uel/3Yzsl0ErUtTWJ5EN7s79lYPf2D4c/UISZBSza
         Gl5Ev1MT83r7byZpes/jvKpAnopcX5dwMiOfa5VbcotX49Ko16+Dy0Vx7XkmiTM1H0Uf
         AenO2inlElHe6hj45H1wo1WQK5YurkKxrRQ7EghpYNvIrHL0GZxVLHYlb0NH5k3G+Pz9
         TDIA==
X-Gm-Message-State: APt69E3mGnyh0UpGc8ektvycLdTv5NT21h/+b73mA5CuBN8bnYQZlUeC
        rSa9JIqK++uP3XIxBBqdraJfMw==
X-Google-Smtp-Source: AAOMgpe4I0wiM/zKuOPTOqhTY4xGIOyzcjs4PAxPGGFo0wHYqi4zcvhhM+Ab1iVtj5FvZKJnDxK5QQ==
X-Received: by 2002:adf:d4c5:: with SMTP id w5-v6mr18398449wrk.185.1530526283254;
        Mon, 02 Jul 2018 03:11:23 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a184-v6sm9733939wmf.30.2018.07.02.03.11.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 03:11:22 -0700 (PDT)
Message-ID: <1530526281.2900.140.camel@baylibre.com>
Subject: Re: [PATCH 3/5] ASoC: es7134: update DT binding with new compatible
 and supplies
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 02 Jul 2018 12:11:21 +0200
In-Reply-To: <20180702100412.GC18211@sirena.org.uk>
References: <20180629150924.18197-1-jbrunet@baylibre.com>
         <20180629150924.18197-4-jbrunet@baylibre.com>
         <20180702100412.GC18211@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-02 at 11:04 +0100, Mark Brown wrote:
> On Fri, Jun 29, 2018 at 05:09:22PM +0200, Jerome Brunet wrote:
> > Update the documentation to add support for the es7154 and
> > optional power supplies phandles.
> > +Optional properties:
> > +- VDD-supply: regulator phandle for the VDD supply
> > +- AVDD-supply: regulator phandle for the AVDD supply
> 
> Unless the device is able to work with a power supply missing (which
> doesn't seem entirely credible) supply properties should never be
> optional.

Sure the device cannot work without its physical supplies.
I'll resubmit


