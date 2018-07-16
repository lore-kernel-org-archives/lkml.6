Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C193ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE2C208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QZmBVWwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE2C208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbeGPL1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 07:27:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39582 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727712AbeGPL1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 07:27:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id h10-v6so31431053wre.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 04:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sE4pS6nnLAGghvMHLCi35WSO3pgPPiRg0TEkR3ol6MY=;
        b=QZmBVWwh9+scSAQoj25DeX/EhInuwmv0o/zRB0k8CY7e/DWoGDoz/QB7BHkeRapkRY
         LWIdZJ7BiV0TLwECoPrnwfh/Dv8gG+O9IpjfRsBGQslF+k56HqusnxWg9ULD3jZNTstY
         pCJcD91BDyws2iGxQ+WurR4gdw6cdBFXavb8TbUyOI5kLqcmm7ZU3qZ2Y6UVJ9ruUE3g
         slaYLOlkxanTDHOqU0QJ9OuhsRRN3YjCtKtOfqUDNW08kfjdrEdb570N4OP0Gq5TiWPx
         Rlp40CDrEN5KGCHdBf+qpcOAH4Blo1139KNIqwQuBDm8CqUW4jjPdowOOZOnQlg/hXCk
         v8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sE4pS6nnLAGghvMHLCi35WSO3pgPPiRg0TEkR3ol6MY=;
        b=GvGc432lhKhNHHTGTUOmm/pXR7aX413mcVwlev7FxeJy5Mfn5tZnYYipsYxybheqPa
         E9PBqRGfD2BI0kPPGDxMPha69RZrwrRntC7xBcNrsVwnW9vefVDIE5Uxnv/embxCagXT
         dxcM+dVQFL53HxFNEUybG71RFn8a9G6nGIRDVpFhHR2llFIMjTS3FCcw/RNw5VVf0xsW
         6YlauAVwu4EGfmObKdk2qQQIrUqoylNubwKIn5qEiT/s6obxdagH1SW2CEsPRgDHmT9d
         1bipptT70M6bQmF/tRRKdyQ/rF2JxW0q2HU4KFRfbiUUEHQ6bfpa/e2tdH3DTkigrif8
         86gQ==
X-Gm-Message-State: AOUpUlEHyWkDYCN7mfUgdaJa3k3y3tN4GoOGgU9S/ilxNzvzZIpC8bb9
        mQrOiu9GltUZ7BaJzjTPJJ1Tkw==
X-Google-Smtp-Source: AAOMgpek/EQ+Q9UMteLQE3Bdp4nHHRGeD5eTE16g+9SVmJZKMTlGmBJVhGHsqkC5fuD/jmtIUSzu7A==
X-Received: by 2002:a5d:438d:: with SMTP id i13-v6mr12372686wrq.156.1531738836358;
        Mon, 16 Jul 2018 04:00:36 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id m17-v6sm12008502wrn.55.2018.07.16.04.00.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 04:00:35 -0700 (PDT)
Message-ID: <1531738834.12853.64.camel@baylibre.com>
Subject: Re: [RESEND PATCH v2 2/2] clk: meson-g12a: Add EE Clock controller
 driver
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jian Hu <jian.hu@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        "Bo.yang" <bo.yang@amlogic.com>,
        "Xingyu.chen" <xingyu.chen@amlogic.com>,
        "Qianggui,song" <qianggui.song@amlogic.com>,
        "Sunny.luo" <sunny.luo@amlogic.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Mon, 16 Jul 2018 13:00:34 +0200
In-Reply-To: <1531728707-192230-3-git-send-email-jian.hu@amlogic.com>
References: <1531728707-192230-1-git-send-email-jian.hu@amlogic.com>
         <1531728707-192230-3-git-send-email-jian.hu@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-16 at 16:11 +0800, Jian Hu wrote:
> Add a Clock driver for the Everything-Else part
> of the Amlogic Meson-G12A SoC.
> 
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>

Point raised about fdiv gates remains un-answered.
Please address all the point raised before reposting your patches.



