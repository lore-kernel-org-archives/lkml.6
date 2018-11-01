Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DDCC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 19:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA87D20657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 19:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3xDfQhj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA87D20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbeKBFDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 01:03:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43540 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbeKBFDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 01:03:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id t10-v6so21240532wrn.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 12:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Wd2vZXAI06vvBnyCtw+67x0Vh/nUWlvNvvjw8yH1GFU=;
        b=B3xDfQhjR2RuoHeuz+FMNgYYhqYqRbClKG0KRS0eNwBcI4n+PqoHvtEObA+OA+GZd8
         0vDBdRsMJy6BSIXGM5Atg5x8ZFRgpkr/mdntCZHmLiMAlze8aoFOiFgFiONd0qq0jMtW
         wpr2d0LyE6ACxcTBaggX+qZ0IbOsIILoAIBF8dzwuf/7FTx+DdxTxMZ+q2AI+60YhRmJ
         vtAK8U6aicUbTXshBJFviDSDqArkb9gAEV0XPnwTs6Y57J5NSkuWt0ifWqTiqXIiRE2L
         qtCV3tp/u31k9+U0SbLRU/oqSngCJFhh58LyNgOrUqI3M3CfvBAaGC2HCBi5GTfAziU4
         XSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Wd2vZXAI06vvBnyCtw+67x0Vh/nUWlvNvvjw8yH1GFU=;
        b=oc4Wf5Q38L0QpJ0I6pJ8P1i/aGKLduQPFCJlmuLOC3aISTeGsjq30yhEDw1TAKp7xW
         YLynkbNx7ohIDFxDWg5uJo3HYdpwgi9d2kSo9YAirpbHawmAygHElS8E5Vlp/rUMEpcM
         99xKpCAJmFooJwMmfNi61Q4VDoiviRH7Rz9VcgGDDInz+yNsREgCAUdoF5UtXqlhCpCl
         OCwCuTmjH/+/MJwI+sFXgueyl9FbORr4JXST0bAnqN4mr8f0NRGvXgMP4EOfVIV2V+fR
         w8WOxmCZsUKqTFL4VFKQsEZI5B4IvQEoDV1hIymK7ggwrAIQb+T5+9Gt55qT9ncpPcV8
         qT7g==
X-Gm-Message-State: AGRZ1gLiyfbop2EkP+km0koWKZVEfYySHG8IoH8KrM45SVAbl84G9Vso
        MQ+VexCUiyUw267j71wQYHHl4iAWDzA=
X-Google-Smtp-Source: AJdET5cibOuH82cGSXIaiW5a+4/Khw7NOo/oa+Ov0ByFTNUVW1xE+0qiUOiQGXevbND7EjJiMS4iKw==
X-Received: by 2002:a5d:6747:: with SMTP id l7-v6mr6791929wrw.152.1541102350483;
        Thu, 01 Nov 2018 12:59:10 -0700 (PDT)
Received: from osboxes.localdomain (bzq-79-178-252-231.red.bezeqint.net. [79.178.252.231])
        by smtp.googlemail.com with ESMTPSA id d11sm5585505wrx.78.2018.11.01.12.59.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Nov 2018 12:59:09 -0700 (PDT)
From:   Carmeli Tamir <carmeli.tamir@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     areklis909@gmail.com, natechancellor@gmail.com,
        dan.carpenter@oracle.com, chrisadr@gentoo.org,
        Carmeli Tamir <carmeli.tamir@gmail.com>
Subject: [PATCH 1/3] staging: emxx_udc: Added static modifier to udc_controller
Date:   Thu,  1 Nov 2018 15:58:57 -0400
Message-Id: <1541102337-51475-1-git-send-email-carmeli.tamir@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added static modifier to the udc_controller, since it's only
required within emxx_udc.c.
Previously posted without any feedback, now updated according to master.

Signed-off-by: Carmeli Tamir <carmeli.tamir@gmail.com>
---
 drivers/staging/emxx_udc/emxx_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index 3e51476..94a4327 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -56,7 +56,7 @@ static void _nbu2ss_fifo_flush(struct nbu2ss_udc *, struct nbu2ss_ep *);
 
 /*===========================================================================*/
 /* Global */
-struct nbu2ss_udc udc_controller;
+static struct nbu2ss_udc udc_controller;
 
 /*-------------------------------------------------------------------------*/
 /* Read */
-- 
2.7.4

