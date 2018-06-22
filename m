Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A1EC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F052F24078
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UtjVc5Se"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F052F24078
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933310AbeFVKmO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:42:14 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37736 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbeFVKmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:42:12 -0400
Received: by mail-wr0-f193.google.com with SMTP id k6-v6so6225451wrp.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 03:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8R6n2xRXdqtFq28V7vY2JJ5kpFftemgMVw/Ft2cGQVY=;
        b=UtjVc5Selq7t0TxXuCeBGJf4V5RN9kOqjthEcNijGjSdU5VGklunUS9rkoVfzXYB30
         A/dqE0KbykrijpwFFPDiv4fPCc9qUmClVLkZXM0rgin/QVAGbEGaF7hznF7Kbb46SLXG
         y03c81Xb7Lr6Ys4GSStIdbX1FvlwWwV67wUhaEKEDCwv6vrtEz/UwmFLKgAON7RMAd3k
         SBSVpzcaQR9yWS49Ccbv1s7/KNnfXlflnbBvCXIfgZOFEVr7LEFqy/5iuxEYuXTmHgNz
         8T+4cBRkxL3vlQErQQyH2CQBt68fd3P9XJLOCZRZ2gjsdGyUKkTlEzYTODWt+7KjKokO
         Dvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8R6n2xRXdqtFq28V7vY2JJ5kpFftemgMVw/Ft2cGQVY=;
        b=Lp83D5SDBJpZ4XvVbsnwGO75pRsgLNDxVPENsyGpv6rIsS6Ewxfj1IML1HJJUshsxo
         GP5Pza6n8Z7lEqF1tytt9Qk2/rBIKoExJcoaHDFzN5if0zbDX0O78JbwB7AfnprRfSw4
         n9CxHVN8Ugd8OoYE6kdNDnH/YV2dztFs/onOWjKxdD5PjPhTOKQ6PTIAaviuOgXR1xbc
         2wp2NQUtFJDqx2VuhkjgbYSB17GJPHBTqd0eKa7sPcPbt+cUn/N6gCYi128CNMfZanHU
         M4im7LWHB25ABegIk/DsVEDVwQNR4Ld2JH/oSY8Q2hYcINM+lGCuMsNgxXBG7NRhv3cN
         nXFg==
X-Gm-Message-State: APt69E1giOHxHJSugbP2rkaUP7hQ4oEyUBbskN9yPf2JlKmVXhpeTQrS
        SfpdlCvUOnuMHNYaEsKmJQjGcA==
X-Google-Smtp-Source: AAOMgpeVwvKc/qM4vOWDlU1Fv7t9sYcK/X+RiumD+dPFRWbi0KBKG+rF6hnU3KDyawzQgk8cA4F0wA==
X-Received: by 2002:adf:8e50:: with SMTP id n74-v6mr1169520wrb.100.1529664131523;
        Fri, 22 Jun 2018 03:42:11 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c10-v6sm8076072wrs.6.2018.06.22.03.42.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 03:42:10 -0700 (PDT)
Message-ID: <1529664130.2900.5.camel@baylibre.com>
Subject: Re: [PATCH] clk: meson: remove obsolete register access
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 22 Jun 2018 12:42:10 +0200
In-Reply-To: <0e57617b-0ece-3c6d-f124-6197ef82b1c7@baylibre.com>
References: <20180619160050.26958-1-jbrunet@baylibre.com>
         <0e57617b-0ece-3c6d-f124-6197ef82b1c7@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-20 at 10:31 +0200, Neil Armstrong wrote:
> On 19/06/2018 18:00, Jerome Brunet wrote:
> > The legacy method to access the hhi register space is not longer used.
> > We can safely drop it now.
> > 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> >  drivers/clk/meson/axg.c  | 37 ++-----------------------------------
> >  drivers/clk/meson/gxbb.c | 36 ++----------------------------------
> >  2 files changed, 4 insertions(+), 69 deletions(-)
> > 
> > 

[...]

> 
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Applied for next
