Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E96FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052EA20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+KaEKn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 052EA20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbeG3SAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:00:34 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55495 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeG3SAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:00:34 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so8053wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 09:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=xs+Ikt562iJDGI4INPrcIQR2Pq0jrrbGsRj3N2kNaH4=;
        b=G+KaEKn0Rr2x7NwTeFJUXUzfIzxk+GFmGcJcfFoXKww6xre6vLuaRGE/+7i51J8iCh
         SlX9IOtWOI6TY9zi/BpwC6/G1Io54UNFlO+pSZIccEvCBXVSD7ZyPGEqnI3oI8SHwZbZ
         xNVIlAfLI9FKjB4dd1kRead3kffoP1X8ikjdSYZRxZNESQ287GPCCeIAhcdpNk9XfFTy
         mWMeorMrTUI4oS9xBtDWDuMkr1LZEgOTxNPtaL6EjDhph0ixp1oYFlZKRXE2/xPgbAxZ
         AIL3yIsfM6R9q9Ut7Bi4WQHpSM2M7z1GKbHN59og8PNUydgXZ+R/TouPEPICsdlO8Nrh
         0wLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xs+Ikt562iJDGI4INPrcIQR2Pq0jrrbGsRj3N2kNaH4=;
        b=HLV0FXrqmBaeCr6R9xAiDYXSb8Q6ug2ZnIlrP6sjq25tvDMzxL/zXuLAsypE/ozR40
         UtR71Po0t8Dp4+mtGACmkrHGn144Sx3/lY1xOZ0Nls7i5jTUYbotd80zBDD+ImbmJiRw
         JO9PH76qUQGbGEthNUYtmeu4sPkFYog4lIovjcgt+vGY8EYTakudGDZ/LovctX+ulM0c
         VDpdfyu9yT2IjoJyUMWdpYffkxnHD3A+YMW4IeXHOCockP2qJFTpr9m1/5d5ZPYzPxdb
         gK+MNKMA/QUU/ekms50dMu7/vunqIMLKzwzatCVq6HjrRNsjzro5Ea+qevVZ+89/3y3Q
         8XHA==
X-Gm-Message-State: AOUpUlFOxeGquIt5AsebSc9FYogbmJ1xIGvLHP5RP+7wIwYe4avoRBv8
        LgXslhFQIj6m/gcrwdaEdEE=
X-Google-Smtp-Source: AAOMgpcJ9DrWEBaI3xLm1jhDzQ/5hoxGYlMQr+V1FRlGCSAMaQjQvvzF+W6SNNa/lqq6d3HlZu3oGw==
X-Received: by 2002:a1c:c95:: with SMTP id 143-v6mr23400wmm.50.1532967889670;
        Mon, 30 Jul 2018 09:24:49 -0700 (PDT)
Received: from gmail.com (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id s124-v6sm15302569wmf.47.2018.07.30.09.24.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 09:24:49 -0700 (PDT)
Date:   Mon, 30 Jul 2018 18:24:31 +0200
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     akpm@linux-foundation.org
Cc:     Joe Perches <joe@perches.com>, Jason Gunthorpe <jgg@mellanox.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add .clang-format entry
Message-ID: <20180730162431.GA13989@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed in https://lkml.org/lkml/2018/6/25/877

Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0fe4228f78cb..2352788d6852 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3514,6 +3514,11 @@ M:	Dave Goodell <dgoodell@cisco.com>
 S:	Supported
 F:	drivers/infiniband/hw/usnic/
 
+CLANG-FORMAT FILE
+M:	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
+S:	Maintained
+F:	.clang-format
+
 CLEANCACHE API
 M:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
 L:	linux-kernel@vger.kernel.org
-- 
2.17.1

