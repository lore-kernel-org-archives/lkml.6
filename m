Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77579C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BD820673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Dj9XJiQY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32BD820673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbeGZIzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:55:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44999 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbeGZIzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:55:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16-v6so658810wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 00:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HnMloOp36fG/w9RzJidyjEqmJ5GBDrwxVljIWkAwxCY=;
        b=Dj9XJiQYBbg9YoOh09ABmuMLg95hGcA7FQ3zt/P529UBU/dxr4yz9GpkzFYZa0zWEO
         RZS6dgbO9bkrI1p0zLASjZ4Wx5VoeSPPcFJ3Hy/RRbZhnsd/lx+WjubJadz9sKul5Jcz
         pDqQcfJTM/l2K3aicvnV8WZOhG2TZkDBQ+n01jCkrJqfG0oY1wBg404tfOSHdYQ+K0WX
         JPTcyogVX9Fy+F7HiwP52CG/qDYeAXzd71N4oO2OrWXVTeIqGCAH6UgWHC1qEEkzTl2L
         uxEOBWGnIGVhgYFbeLI2PFAuqYc3Yvp31gIP4Zpd0+91vb0GshwH3SHuX6kFpSSctALf
         KJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HnMloOp36fG/w9RzJidyjEqmJ5GBDrwxVljIWkAwxCY=;
        b=j1OU3zwJgQGbOpzBX+kDzZgLyMhvSx1qp3UHk8oGJK16/vjPT+GLBGz928N1LW2Mbl
         daybIquSluxze1AbLTVazzOeKSMivHAfqdR7FafjHe8Vx5aUK4ldmzvL/WQXOWcn+DMi
         T/EB3AQISvj/78UIb6vNvElPM/ItExxspwU4uhSjunjut0SYWPJv6JpLi8+4eIiDQSRU
         BhDZog3VP3WpTsxvONyPAeORU6kGg4Y6w2y8AH0iwnUv7ZT0ImiklkNJWYcfqAmfzXwb
         T2Bf4qCwtal6naQGFdu09y9/Y89SfsaazhDigg+KzKa/I8iveXmsYvrpJuFzNkI66l26
         tngw==
X-Gm-Message-State: AOUpUlGlDuxjXBTuHJ0dA1STwL9+4gT/15wDmYYLrFL1wH5/pG8W1ouU
        V8ypO5XBSsGO90QNpYcNbuUrHA==
X-Google-Smtp-Source: AAOMgpeFrqNFDufryjmxG1txvpXWMJGiT1/y5C2PtLRGRmBo63yZBiQrG8WadzgOb1Butop3BJ5qIw==
X-Received: by 2002:adf:9183:: with SMTP id 3-v6mr657085wri.122.1532590804270;
        Thu, 26 Jul 2018 00:40:04 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j8-v6sm780847wrn.50.2018.07.26.00.40.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 00:40:03 -0700 (PDT)
Message-ID: <9a71a5644b5257d48436a4d28972d4142a96b0eb.camel@baylibre.com>
Subject: Re: [PATCH 14/15] ASoC: meson: add axg sound card DT binding
 documentation
From:   jbrunet@baylibre.com
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Date:   Thu, 26 Jul 2018 09:40:02 +0200
In-Reply-To: <20180725190619.GA20234@rob-hp-laptop>
References: <20180717153643.8806-1-jbrunet@baylibre.com>
         <20180717153643.8806-18-jbrunet@baylibre.com>
         <20180725190619.GA20234@rob-hp-laptop>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-25 at 13:06 -0600, Rob Herring wrote:
> > +- amlogic,aux-devs : List of phandles pointing to auxiliary devices
> > +- amlogic,widgets : Please refer to widgets.txt.
> > +- amlogic,routing : A list of the connections between audio components.
> 
> audio-routing IIRC

Wouldn't it make sense to do the same for widgets and aux-devs then ?

audio-widgets ?
audio-aux-devs ?

