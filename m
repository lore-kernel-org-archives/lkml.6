Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B727EC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 00:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E10F20868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 00:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="Z458dGtz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E10F20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbeKXLJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 06:09:52 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35816 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbeKXLJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 06:09:52 -0500
Received: by mail-qk1-f196.google.com with SMTP id w204so9343944qka.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 16:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RBh8mG9PSGI8GikIxS9pbBoaA+nEmHVPkQII5oHoG9E=;
        b=Z458dGtzZXGrR/pVTkgsb2kkqW8cR7ooYTBPWIcDmky9QO5MWeWCIKo4poKD/gy5fm
         7PO9F0xyBPlay/T+uj9b8YxBqxr90ZCo8uwc/VFp/bZFDl2VzVTFNrMO6sGJ3eo5Jrs4
         1fDq4Fi8QK6Gg/o3AVV1vafqsbuTDbemBHGZ9bKDa8jPtWkl3Q+14nifB4VL8sRShL2a
         9GTRSq64oLaFlDKkjJ6VVrnPy/wkVJhFA0fLZxoUj6IpTKVjOT/91hlNO9zoasNFuJIj
         o798EXTYn1TIfHlszIltsLopnxYY2YBIOjiZpa6oI6fbvET7j538EfkVejAP9tXdx3aR
         zokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RBh8mG9PSGI8GikIxS9pbBoaA+nEmHVPkQII5oHoG9E=;
        b=Udb3KA/n4UXloCwv93Nj5W5Ynmky7cOlOOVGhluI7DQJ7BlU/1mn+Kg3ZI77PCXND9
         PP57/X5uSOMNECcdWo6bM4nNs0UZPbJltnq+zSX01GZ6vTYW1nOVHgttkLUTl1zgUik5
         jvI0pmS8mvB6JWfVmK/NXnMpWJgoxp0o1Qo8ylAVd67nZ0UX7KwxokYK0enUypaaKXYz
         YOFlllHK5Z4PIHrhsgHSSKh0SUPSIgjfL8N76bdM7+EaxtU3bFOZct6ufX47szamTzbX
         eT6zRWuRPxj7wwLRrjpQEvjpWuNHhbaruf3aoxWS9W75trRJ5De1SIpX1zfbEdWgFvMP
         3G9g==
X-Gm-Message-State: AA+aEWaUA+4rDEKFBWtez4ZIInLdjs/xxulmOFtwhB7RXjro93lXIR8Y
        NCTQsXKkMSNnUEWZziiwfXLrMg==
X-Google-Smtp-Source: AFSGD/WSajc6JPhTm5jOFqn4noBNgFmcxXwXj1GTZUY0Nz0qH57d7BGgeQ2fuDUu/PdV+FiO2WVZFA==
X-Received: by 2002:a37:3b47:: with SMTP id i68mr1371369qka.277.1543019010596;
        Fri, 23 Nov 2018 16:23:30 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id o34sm26707515qte.4.2018.11.23.16.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 16:23:30 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kernel-usp@googlegroups.com, victorcolombo@gmail.com
Subject: [PATCH v3 1/7] staging:iio:ad2s90: Add device tree support
Date:   Fri, 23 Nov 2018 22:23:06 -0200
Message-Id: <20181124002312.6923-2-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181124002312.6923-1-matheus.bernardino@usp.br>
References: <20181124002312.6923-1-matheus.bernardino@usp.br>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device tree support to ad2s90 with standard
device tree id table.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
Changes in v3:
 - Removed of_patch_ptr from of_match_table assignment

Changes in v2:
 - none

 drivers/staging/iio/resolver/ad2s90.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 3e257ac46f7a..fdae067ed866 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -107,6 +107,12 @@ static int ad2s90_probe(struct spi_device *spi)
 	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
 }
 
+static const struct of_device_id ad2s90_of_match[] = {
+	{ .compatible = "adi,ad2s90", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ad2s90_of_match);
+
 static const struct spi_device_id ad2s90_id[] = {
 	{ "ad2s90" },
 	{}
@@ -116,6 +122,7 @@ MODULE_DEVICE_TABLE(spi, ad2s90_id);
 static struct spi_driver ad2s90_driver = {
 	.driver = {
 		.name = "ad2s90",
+		.of_match_table = ad2s90_of_match,
 	},
 	.probe = ad2s90_probe,
 	.id_table = ad2s90_id,
-- 
2.18.0

