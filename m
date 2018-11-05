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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5FEC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B662081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZFsW05K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B662081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbeKFArO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:47:14 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33247 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730263AbeKFArN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:47:13 -0500
Received: by mail-pf1-f193.google.com with SMTP id v68-v6so1000818pfk.0;
        Mon, 05 Nov 2018 07:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mDWmpK0OiVEqlMHbao8c5fx+Nz1R8IrIrFeiQ9xLgiE=;
        b=FZFsW05K2i5M+UoXuDDE/DtreQnnw2El3l3uZWE+PB0q8LzUYY18T/k5+ewDoYZvoz
         HUovE3w6jDvxZBDhB3noInGYzc/sAm7m3Cpv44DpmOdl4PCuL2OYH/oDI2xh28ubeDwU
         FPM1rDG/6FmT8deFdkRiOCTe6M1Jz++Nikz3GSKxu/X9DjoA3VXDprP4auTV2Acu7LlW
         f2StjqATKDh/QgNE8t7LLFN6ahEwEk+B7+T6SgsBJHhuqPpOq70gvEqtRwG7rP0Zmi8W
         vvLu5w01mryA7h/fiXomLpVz/epvd9L29cQzlx0Q2ZzddUvWSomwAF5kOHQsH44L6znw
         S8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mDWmpK0OiVEqlMHbao8c5fx+Nz1R8IrIrFeiQ9xLgiE=;
        b=kgNEK5vITvXRrCT3VVa4TNHixM6L1cIMymbg3/q2fVJC4P73XJu3tjOIjZvFLUuTsE
         VBu1v1UEIq0C1/QKbGnv/0w3wANc+Eu0gltahzUpxVaVvnFre/y5DEkBhGdjVCYMZpNq
         3IOExL8KOT5KFFoIrdCNxoXxInMHWIegKAOpJ9kvPBJYUve4pbFh1w2C1t3XBzUvMSE6
         lJEF4+XMCnwKT2yTTcvPw9Uc+SIkqab+gEISxOH78xrdBDks6xScP8A8KEuU//lCmB9w
         M5ONLxduRt5FOOojIJNHo7K9bKcEeNfwKkl/HN33RJ1fg58KTfbHjYnqf+dvjRw+03xF
         gPpw==
X-Gm-Message-State: AGRZ1gKtg4wFceHqrsNexoh6RqXOmgCq5IBZmRis1YuVD94Isf3CDyFC
        isI94Cns60ZXyUi59CaSpt2kXurN
X-Google-Smtp-Source: AJdET5eEYAn10mFPvXv4Ix+DIBhe+L9mdmAMLibh6DXt7QRmQdcO6vF+8xzTs7Z1Xkmjwug5EQcXgQ==
X-Received: by 2002:a62:4301:: with SMTP id q1-v6mr21923331pfa.163.1541431620374;
        Mon, 05 Nov 2018 07:27:00 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id u76-v6sm37260578pfa.176.2018.11.05.07.26.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Nov 2018 07:26:59 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v6 06/18] of: overlay: do not duplicate properties from overlay for new nodes
Date:   Mon,  5 Nov 2018 07:25:03 -0800
Message-Id: <1541431515-25197-7-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

When allocating a new node, add_changeset_node() was duplicating the
properties from the respective node in the overlay instead of
allocating a node with no properties.

When this patch is applied the errors reported by the devictree
unittest from patch "of: overlay: add tests to validate kfrees from
overlay removal" will no longer occur.  These error messages are of
the form:

   "OF: ERROR: ..."

and the unittest results will change from:

   ### dt-test ### end of unittest - 203 passed, 7 failed

to

   ### dt-test ### end of unittest - 210 passed, 0 failed

Tested-by: Alan Tull <atull@kernel.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 6fd8e6145e10..9808aae4621a 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -393,7 +393,7 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
 			break;
 
 	if (!tchild) {
-		tchild = __of_node_dup(node, node_kbasename);
+		tchild = __of_node_dup(NULL, node_kbasename);
 		if (!tchild)
 			return -ENOMEM;
 
-- 
Frank Rowand <frank.rowand@sony.com>

