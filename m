Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D751ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC102085B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpgZ3o/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC102085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387432AbeKFArQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:47:16 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38987 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730307AbeKFArQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:47:16 -0500
Received: by mail-pg1-f193.google.com with SMTP id r9-v6so4377466pgv.6;
        Mon, 05 Nov 2018 07:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jF7CtwoKyOCOUUznnCb9oRyK4jRjdXLVVX13D8F3sAE=;
        b=bpgZ3o/dLLW5JQfdO2WtI3t++aSL1ev4v/ap+54HN0AWZT9trya4mbc8xf8I4SN45O
         2ooTizEquN5TrxEPJeubz+e3DNVEuy05lp4PyVOYTxg3LM6HwlB1gWf8+h3WQfZIY96N
         G5f3YVG1w9mQLKVWSW2lTHri1FUE2NGxH6muHD5AZyJepz0owgKKXVqGXEklCwiL+JvJ
         NEK+b6pGaWCy1pMHMMEo1/3+9U6V+xVg4FbNViDDq+NDlHjEWp3GHhSbD6IKAhm+F4Wp
         rNCCGrq4fWFn2spKrt0k3/EnhVJCy9ZOPKOEVlyHiKTlCLMx8ov/wFvzbbit4MMq6sbG
         HTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jF7CtwoKyOCOUUznnCb9oRyK4jRjdXLVVX13D8F3sAE=;
        b=UTAAGU1XGYNo6OjbdtuBt88DZh5k4qAGmnwyjadt0komYqNGCdSzr7YiH+Bm9+Zkjd
         4P36HJN255gjCUYbHsbFK7AGPeqmliHag2ilDIkp2re/OLe+Y+MMbiKLMcTu7vKP7R4r
         QGO+jk0c9yIll6zX7WLa3flc3KvbA5Cxpx1r5Ygx5TL0o7r0Yjruf9q5lviDDp/hggax
         mcIZnJRtpKTHyeXvwon0FOxoKZRzeXTTE8ahfEyniR2lUhKqDW+mYYcwcRSw3KEfls2/
         k71sjc6P75tTGVZ3DcHCV9bfMVIRE597y3MsIrEHWhs3QxKs2m2DkHSEz4l8oFbASGlR
         T/9g==
X-Gm-Message-State: AGRZ1gL1/SLI/HSsoiLprvviROcZv8aqyQ+/NEw7Nku5ui5vlwxKENS2
        +r1JsTmYzDtrOTx4fJ4V1gw=
X-Google-Smtp-Source: AJdET5d3U+86JkkVAwDoC/NH8Ul07GZpAGbcOuoc/UWSGneCrAC2sd/MiP6Np5IF47sJJhVtgD0sgA==
X-Received: by 2002:a63:4141:: with SMTP id o62-v6mr4073305pga.370.1541431622887;
        Mon, 05 Nov 2018 07:27:02 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id u76-v6sm37260578pfa.176.2018.11.05.07.27.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Nov 2018 07:27:02 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v6 08/18] of: overlay: reorder fields in struct fragment
Date:   Mon,  5 Nov 2018 07:25:05 -0800
Message-Id: <1541431515-25197-9-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Order the fields of struct fragment in the same order as
struct of_overlay_notify_data.  The order in struct fragment is
not significant.  If both structs are ordered the same then when
examining the data in a debugger or dump the human involved does
not have to remember which context they are examining.

Tested-by: Alan Tull <atull@kernel.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 9808aae4621a..15be3da34fef 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -49,8 +49,8 @@ struct target {
  * @overlay:	pointer to the __overlay__ node
  */
 struct fragment {
-	struct device_node *target;
 	struct device_node *overlay;
+	struct device_node *target;
 };
 
 /**
-- 
Frank Rowand <frank.rowand@sony.com>

