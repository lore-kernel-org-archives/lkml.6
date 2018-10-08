Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F33AC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25B32088F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3/CNbEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B25B32088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeJHOf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 10:35:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44250 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeJHOf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 10:35:27 -0400
Received: by mail-ed1-f67.google.com with SMTP id z21-v6so12222700edb.11;
        Mon, 08 Oct 2018 00:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=eXakZImny/OmFnJYppAUEOgT+bT2mZ/T8guu6pku4KQ=;
        b=b3/CNbEUEYdrefUxfrLblq3+QZUIG12PSukTSpmtq0Om1WpANSY/pDBSjUniStkhAC
         +fNyOWYE27I+/5A0cOIrY7R8FQXsunSY0kwtN6x+wrl4qCqCMrQIqMcFA+tPLH+ilWTc
         2N2QUD4wpkI8cdXbYpXsIFnQnZKGWgxWzwPPtPLssZR0wpnXxhGdsoLc34IYxi01Acd/
         qTeocCNWUGi2JwZptmbQTYcl44/oznzPTtMeCUrNP4EkcUzg0zDACOurMPIqe9T7EU8f
         hY9PoR8F2MjsM1tLNCwNAB9MUUqEcaEL/3nnom966ueZ6gvHHABsSkrFsdCW767Q+vJU
         U62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eXakZImny/OmFnJYppAUEOgT+bT2mZ/T8guu6pku4KQ=;
        b=OG2PDiiw/ihNKz+69lonqIo2kVo29s7IUMqBbES9mbrGpuz+6gvbdm41I/BGWLX/QS
         wLPt11iN9nsZxqe16UyRisKyxIxyRWgO2QaKeuLjYett6MuCBcAXYC2rBL3y9RmyBZAc
         k8w6JAHPRIT8MqQSJ/RM++qaRwKRn0ooXaHibpdHCHFr9gKeJvoN1QXwPu6fg4z//tP/
         DSLpJbunTbC23742qj+Hgg/mMihKNfMzSe6VkyWJz1vkwxU49V1CWSo6fjbuNEkUaBVP
         eVsexfksGjEvcx87Dq2Pg/JlaGbL7kNK+/Ntw6FtWfyonGEH6yoR4DAP9PejpjWFHoJS
         Wl7g==
X-Gm-Message-State: ABuFfoj5jdsJeij4MQBtJNLtYPyutFFe6f5nOogOOkPsB1ZwnWmGhW0a
        5qhXWycGLpZFWjjaaT2MwaP/RKXu0Ng=
X-Google-Smtp-Source: ACcGV6263RO9AaEYfr5qCFwz6Kc9WgF1YOil/b/+AP/feGyYVggHiQym1VfTep8rWHBJNdtFpTVOYQ==
X-Received: by 2002:a50:ba3c:: with SMTP id g57-v6mr27384504edc.214.1538983507631;
        Mon, 08 Oct 2018 00:25:07 -0700 (PDT)
Received: from mcepok-pc (200116b8645dc8003574d41d1f9d8508.dip.versatel-1u1.de. [2001:16b8:645d:c800:3574:d41d:1f9d:8508])
        by smtp.gmail.com with ESMTPSA id i38-v6sm5668962ede.83.2018.10.08.00.25.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 00:25:06 -0700 (PDT)
Date:   Mon, 8 Oct 2018 09:25:05 +0200
From:   Marian Cepok <marian.cepok@gmail.com>
To:     hdegoede@redhat.com
Cc:     dvhart@infradead.org, andy@infradead.org,
        linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: touchscreen_dmi: Add info for the Trekstor
 Primetab T13B tablet
Message-ID: <20181008072505.GA8334@mcepok-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add touchscreen info for the Trekstor Primetab T13B tablet.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Marian Cepok <marian.cepok@gmail.com>
---
 drivers/platform/x86/touchscreen_dmi.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index cb204f973491..c07954f0efc6 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -381,6 +381,22 @@ static const struct ts_dmi_data trekstor_primebook_c13_data = {
 	.properties	= trekstor_primebook_c13_props,
 };
 
+static const struct property_entry trekstor_primetab_t13b_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 2500),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1900),
+	PROPERTY_ENTRY_STRING("firmware-name",
+			      "gsl1680-trekstor-primetab-t13b.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
+	{ }
+};
+
+static const struct ts_dmi_data trekstor_primetab_t13b_data = {
+	.acpi_name  = "MSSL1680:00",
+	.properties = trekstor_primetab_t13b_props,
+};
+
 static const struct property_entry trekstor_surftab_twin_10_1_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 1900),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 1280),
@@ -648,6 +664,14 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Primebook C13"),
 		},
 	},
+	{
+		/* Trekstor Primetab T13B */
+		.driver_data = (void *)&trekstor_primetab_t13b_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TREKSTOR"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Primetab T13B"),
+		},
+	},
 	{
 		/* TrekStor SurfTab twin 10.1 ST10432-8 */
 		.driver_data = (void *)&trekstor_surftab_twin_10_1_data,
-- 
2.17.1

