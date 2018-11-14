Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11DDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C472243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdrxThUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C472243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731880AbeKODub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 22:50:31 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39834 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbeKODub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 22:50:31 -0500
Received: by mail-pf1-f194.google.com with SMTP id c72so3586540pfc.6;
        Wed, 14 Nov 2018 09:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=is25qCpPljuaf4qCIup+ZmHsZK5fqsg5hh0SXacfU0I=;
        b=bdrxThUwxBThduQU1knDOgOlKmny9htcRckdS3fT/1HproF6doMglC36pavHDrAT0P
         B97qqxMOW/5C++GcNSyD7NLu83k+oeZE0sYA1eb3uJHdIIHnUUSPdzUNa+pT3ZLKCcOB
         zXg1mSfw6tzdAPNhyv/W7Im0gWz3Gecx+E6egvm/BgQFNQduzIcVjr4OPwSxw6luAVty
         MPqP52Ps3o0MfFOR2N8vBal6/7V8MVWxYRwzbdLU1GBkbMpt1ey/HM+NeF5SJLAOmt5P
         ZoLArDLkxZZWs9VHjXp5AuDGwApckMye+RyLmqyPRbyvKLjK37HH4SAHQUp2QSFugw+Y
         iAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=is25qCpPljuaf4qCIup+ZmHsZK5fqsg5hh0SXacfU0I=;
        b=Gcxamkgr1BdkYB6+sZU+8X0J0kngCF+i4oY8jQa9/+jPKhZ3KFp477wB8MWvbTq5ap
         myyf5DIvHofNbWs/pF8XVIhGXWxJRKW7joyNeFlAv7qrqfT04tHVkU8ZQc7pR/48iKnl
         QKqZ6nJn3k4SkWicoLOqAzvgxmIt6O0lGreiafuefCrzhOzRxff7NtgKSV3XyuVWECd1
         T3eIL5PiiEKMLXBtCWivf8Z5FLBtFsblMcNOnRmSRQAtYeKEkrqcDGS3RvvL8T6uK66R
         BouFzwK2A/6eOfOFWKhfnxIm/nQ0g4V3QCcOg14T8U3bAATPbMSNLcSHStqWSXr3HFn4
         QUOg==
X-Gm-Message-State: AGRZ1gJ+Fkvm1vUhdnzlsVa2tdaHl6KfLmCcVEq63LYI/EGq68P2tnIo
        uv4fh+6C/yuakNKJRtjrYYc=
X-Google-Smtp-Source: AJdET5ePGb6jstYqSWlPkYgIsPlLpSF/lSCWU2RgdPLncRKE+TB20A1HgObXUP4bbV2wiUDVKujZMQ==
X-Received: by 2002:a63:5320:: with SMTP id h32mr2618558pgb.414.1542217581884;
        Wed, 14 Nov 2018 09:46:21 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id 202sm8660096pfy.87.2018.11.14.09.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 09:46:21 -0800 (PST)
Date:   Wed, 14 Nov 2018 23:16:14 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] staging: iio: ad7816: Add device tree table.
Message-ID: <d2df511b4a84b92925a39b5051932eef4426f18d.1542215638.git.nishadkamdar@gmail.com>
References: <cover.1542215638.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1542215638.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree table for matching vendor ID.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index a2fead85cd46..925f7086bc07 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -422,6 +422,14 @@ static int ad7816_probe(struct spi_device *spi_dev)
 	return 0;
 }
 
+static const struct of_device_id ad7816_of_match[] = {
+	{ .compatible = "adi,ad7816", },
+	{ .compatible = "adi,ad7817", },
+	{ .compatible = "adi,ad7818", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad7816_of_match);
+
 static const struct spi_device_id ad7816_id[] = {
 	{ "ad7816", ID_AD7816 },
 	{ "ad7817", ID_AD7817 },
@@ -434,6 +442,7 @@ MODULE_DEVICE_TABLE(spi, ad7816_id);
 static struct spi_driver ad7816_driver = {
 	.driver = {
 		.name = "ad7816",
+		.of_match_table = of_match_ptr(ad7816_of_match),
 	},
 	.probe = ad7816_probe,
 	.id_table = ad7816_id,
-- 
2.17.1

