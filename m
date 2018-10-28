Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF45BECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 07:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6485C2082B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 07:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKVpIkGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6485C2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbeJ1Qgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 12:36:31 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37658 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbeJ1Qgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 12:36:31 -0400
Received: by mail-pl1-f193.google.com with SMTP id bh10-v6so2356902plb.4;
        Sun, 28 Oct 2018 00:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+eDLvkiiPUO0D/lugMgy57N+b7fklqEyeUYtP+nRnAs=;
        b=PKVpIkGwboaryX/KZ5QbQmpBbNbNQ7kPymEIUHKxQYqlLlOnRuwi7i+Jj1l7V1Uy69
         hbucVgyGk9CDQ3JZzfzBIPr04Ff4B51JqXeQqbbupOJUlGvtD4nhfZJ3UVNnMRu4tQft
         J8QWqpcGfDdni6+Gx8sPIs1TMkof/eCs32XX0m6yLJ0BF+ag9xM/JEo1r7CTe2hdvHmJ
         Dn0rR++r2E1LTPZw/gFOcDxMI01pxhqIcDT9u4cUelOm2H/T4bJNkj9PuEUE6iY7Pk2d
         z5uJ+OR5CW0zkoI6NbGj5pRM7QOolxooXCVdjn5ip3logmTtQSuxhVkrM0S59JI1u5PJ
         f5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+eDLvkiiPUO0D/lugMgy57N+b7fklqEyeUYtP+nRnAs=;
        b=hiy2vjxAVjmiZ4tJ/UdYuCoJeDQYw+u82+QUSpGsD3PR6MJke4JmADBCnuDz0qljNE
         fpkdzhlC+GbeMnq2xPk/6p4tn5tPezvyjf9Y84ilNUyICehQIkJUI5CRCbUrRolrscGw
         2WMteTNzgw4JrvKUJLb5sWdntcg5buFnzywLY7141edS2XX1AQ+m2oYg/n3ppJK3Hn26
         olMwDh/87IsMhVCEkF3MkipgZ0wGxlrnzeV+5O//XjPBghQ4kd1IxF0AqICy82unF52/
         +RmV+RpB78ZtRoS8GqXqM8Y9BAiG5xNknxHWzXxalW/PGR86KPRuONFWSs5saAJocbNd
         4fZA==
X-Gm-Message-State: AGRZ1gLVIXTkwvz4y2mJHvyoeflwGIqPwmKzHDi1YTaq6iUqhI2grrH+
        9VqO7ERb2e02Tcsty1ywwCo=
X-Google-Smtp-Source: AJdET5ePTf48hv9W7rUoFU0pozDV59sH9Cqa6oMfnW7bpmFVIV7jHKUoaJlwnTI5ckJtIHUhT3dqZQ==
X-Received: by 2002:a17:902:930a:: with SMTP id bc10-v6mr9923887plb.17.1540713158978;
        Sun, 28 Oct 2018 00:52:38 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id b62-v6sm17642892pfa.159.2018.10.28.00.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 00:52:38 -0700 (PDT)
Date:   Sun, 28 Oct 2018 13:22:31 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Slawomir Stepien <sst@poczta.fm>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/3] staging: iio: ad2s1210: Add device tree table.
Message-ID: <6b324781850b7543f8bbe67a6a48c9469d8a707b.1540712249.git.nishadkamdar@gmail.com>
References: <cover.1540712249.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1540712249.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree table for matching vendor ID.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 93c3c70ce62e..0234869e9d74 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -724,6 +724,12 @@ static int ad2s1210_remove(struct spi_device *spi)
 	return 0;
 }
 
+static const struct of_device_id ad2s1210_of_match[] = {
+	{ .compatible = "adi,ad2s1210", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad2s1210_of_match);
+
 static const struct spi_device_id ad2s1210_id[] = {
 	{ "ad2s1210" },
 	{}
@@ -733,6 +739,7 @@ MODULE_DEVICE_TABLE(spi, ad2s1210_id);
 static struct spi_driver ad2s1210_driver = {
 	.driver = {
 		.name = DRV_NAME,
+		.of_match_table = of_match_ptr(ad2s1210_of_match),
 	},
 	.probe = ad2s1210_probe,
 	.remove = ad2s1210_remove,
-- 
2.17.1

