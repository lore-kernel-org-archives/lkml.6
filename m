Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95CBECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED3820821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ab7w+9WH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED3820821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbeKAA7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:59:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45715 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbeKAA7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:59:21 -0400
Received: by mail-pf1-f195.google.com with SMTP id v5-v6so2920107pfm.12;
        Wed, 31 Oct 2018 09:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CVl1ESSj4idIa/gbF1NQ+Xy9kDUcvqho4q0SllzV20U=;
        b=Ab7w+9WHaj5ieIEXc158y+Grk9mmLMeZzCEaKMNf3P+OgbEG6E/I+ylQtqV3KkiR4F
         LMVBR0NClQsxCO5IqnxHa2RVuNJ61lkzZY799rk5fMtBrxh7506rfBxlSiloqHe9DP5W
         lAJPE6LTPxxtiO6agbJOdfJPz8IL7CokheIABeXkrhjoX5rvjzPr68uRTLFuZ91+iFbL
         bObi2iBzhIYk78LI4hUjJm+8hrhxYmTQYxjNoF9DnyV7flx5RzxEnYi17ySD6k8E4+Bs
         7QlyYFAcXr9c6HrWAU4pTvQNJFOP1Q6XOfPpGNk8efGduK9M2dzECOjWYuiKgRdOCmte
         Xn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CVl1ESSj4idIa/gbF1NQ+Xy9kDUcvqho4q0SllzV20U=;
        b=mkr/G0fqn/mVrlDgmwIks8K8WuqDsqkgix2ea41xrOdCrbXrIgQLrfwdIV1Z+RJW3W
         nHoubTnHRM41KL83Rg8AEu4DCdctlHh3Nhto335ldk6Kc6j5xkk2pk+oirv+us5LmH9O
         asSCqoKE5ggRnvPaQcXIBrMkQQQ/o33pYv8mVHcDyrlTP3f+aM5RCGgLSJ21ecKxKgw7
         ISOo+F2LKqWmM9iRd68JXz/WmEojUgEAFhLVnj+m+Uqp1Ajij2xj+o0gy6RnupQaiBwV
         1xR5qGJ4CgMxW+PBZOg7BenLvf5Mpxd5kwUlyhZnrvMR4Pz/LqsTr6voZPq0jMFCTYjn
         2CzQ==
X-Gm-Message-State: AGRZ1gLE4jmGLqi3QV9Veny30aK++qinuYHczQbv5J5Ko3N3Khh2zCCO
        S/EjIF5dUTiSnZJX57C1blg=
X-Google-Smtp-Source: AJdET5fdFZ9qbWSa8LWQg0zUojvdgpJgZyJu998JYFlMuPqP1J+WY+5ytIf36Ed+Ej3rHTUzVXTMDA==
X-Received: by 2002:a62:7086:: with SMTP id l128-v6mr4118503pfc.181.1541001644140;
        Wed, 31 Oct 2018 09:00:44 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id u19-v6sm30759983pfj.115.2018.10.31.09.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 09:00:43 -0700 (PDT)
Date:   Wed, 31 Oct 2018 21:30:36 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Slawomir Stepien <sst@poczta.fm>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/3] staging: iio: ad2s1210: Add device tree table.
Message-ID: <ee142522b129dd6fd8d71b5567d9c6711e89efbe.1541000375.git.nishadkamdar@gmail.com>
References: <cover.1541000375.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1541000375.git.nishadkamdar@gmail.com>
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
index d3e7d5aad2c8..7c50def91a2b 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -701,6 +701,12 @@ static int ad2s1210_remove(struct spi_device *spi)
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
@@ -710,6 +716,7 @@ MODULE_DEVICE_TABLE(spi, ad2s1210_id);
 static struct spi_driver ad2s1210_driver = {
 	.driver = {
 		.name = DRV_NAME,
+		.of_match_table = of_match_ptr(ad2s1210_of_match),
 	},
 	.probe = ad2s1210_probe,
 	.remove = ad2s1210_remove,
-- 
2.17.1

