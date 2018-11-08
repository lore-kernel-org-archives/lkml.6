Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46508C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD7B20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyrD64xg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD7B20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbeKJIUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:20:54 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33227 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeKJIUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:20:53 -0500
Received: by mail-qk1-f196.google.com with SMTP id o89so4486800qko.0;
        Fri, 09 Nov 2018 14:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=adn9WeK/Tj/r2MSSsNdCYtTeqx4f7Pg9VC8oEd04F+s=;
        b=KyrD64xgLc5aTNq/3V9R5OXgKT1naYkH7Gg1+0jgo763VN6nFYdCc5r3qdUWNRD58J
         wA3HDDP9m83KMvE+Zwkv1zZfgL6A3OZV7WlsYyTrg8MZUZIzusUjZO32l9Kzm2I4JZTv
         k6BrnHIOmd8gS62fc0LoprCNmMyMpnGfs82fn9xS5QzwtTJJMYrHdhB2cirDI5TmVMOW
         mtHDYQtdN+Mjn6JSgfjanavbiOF+ulP428/Rv2QyrGeiobuUa8B3eu2SzbUW0CqmCi1D
         c4ce4B+zfE9yQu7TXCfzsX9Ip+9YmUY8S7V90K4r5lLR92oQGKuJJ52k5btuUc54vD8k
         NNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=adn9WeK/Tj/r2MSSsNdCYtTeqx4f7Pg9VC8oEd04F+s=;
        b=rq7wdp94frpk/MHbnyaw6CrAaYpEAAlDFRliZsmN14VAj3G8jAkDI/I7Imnaq2+Rje
         i+ONWt6zJ3W2EFFD0HpHa12AkpCV6KRbhBtk4ZlxtAIhLBh/I0MR9B7Qe4nyZ45GSKru
         IBoogFV5mavIWTb9+cTZabnmek+abKe6weSOg1uAiVw6oJbymoZm/Nu1yDJo50VvFAf+
         iywrsRBQjbrKsFsBW+/m9lxZXkHXo511GcgLqFWcFJNk1y800u7qI7mzHMCZeu36722L
         t6t1LzmPbvODj0lLMaaCUJvfqhav8Ievf2k/2UtveLV2x4QozNtJIUzYc8ssfvxTeJaJ
         Wtlg==
X-Gm-Message-State: AGRZ1gJwmmDjj4QMuvuTO+KQBUl+ZR5oPw14cJO8S2BjFj4tMXmAz+Aw
        rgjDJr4o2bJ5ulkbj1Egi1VuZmhu
X-Google-Smtp-Source: AJdET5cAENoK+9jQ0PrKgl3Gzio3bKNdkOKXhIs9SXgGixuRfILTEyk9ZSrHP+0zaSOdIVS9JIow1Q==
X-Received: by 2002:aed:3221:: with SMTP id y30mr10604846qtd.126.1541803094601;
        Fri, 09 Nov 2018 14:38:14 -0800 (PST)
Received: from ubuntu.localdomain ([177.194.48.25])
        by smtp.gmail.com with ESMTPSA id b8sm6065968qka.79.2018.11.09.14.38.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 14:38:14 -0800 (PST)
From:   capetry.dev@gmail.com
To:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] fpga: altera-cvp: Fix function definition argument
Date:   Wed,  7 Nov 2018 23:13:12 -0200
Message-Id: <20181108011312.29587-3-capetry.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181108011312.29587-1-capetry.dev@gmail.com>
References: <20181108011312.29587-1-capetry.dev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carlos A Petry <capetry.dev@gmail.com>

Fix the following checkpatch warning:
WARNING: function definition argument 'struct altera_cvp_conf *'

Signed-off-by: Carlos A Petry <capetry.dev@gmail.com>

---
 drivers/fpga/altera-cvp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 45b7c8c0b..150a9f5dd 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -66,7 +66,8 @@ struct altera_cvp_conf {
 	struct fpga_manager	*mgr;
 	struct pci_dev		*pci_dev;
 	void __iomem		*map;
-	void			(*write_data)(struct altera_cvp_conf *, u32);
+	void			(*write_data)(struct altera_cvp_conf *conf,
+					      u32 data);
 	char			mgr_name[64];
 	u8			numclks;
 };
-- 
2.17.1

