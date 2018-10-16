Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63003C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A8B20869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tg9xQeeC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A8B20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbeJPK10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 06:27:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37611 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeJPK1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 06:27:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id c10-v6so10083482pgq.4;
        Mon, 15 Oct 2018 19:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zdOcjsQSagxh/0ytfqlFE21zp3hEcz2hdT+yMst4gNc=;
        b=tg9xQeeCkWQhyodbcvSdj7q+fcOref2z2sntaCR3p7E1gnJ8305hhoo461U+aUZU8C
         /e7A1f/oQWrEZ+nxSTpeYP4Juu0L9CxsC7XQ7wcFKhCO0d1BZqKeR6YtaETtQHlFr4Ah
         zy98BikYtjnC37L8Q8LsvYfLIt2xS46xLXaLLCklO+LAD9+U/pD75X/g1JFA3zmH51Mj
         4p1hBvJTPTXsgcy638l3rD25kEItXXvGd/CL0XkpFSj3J4wWi8dnpmoBIXZvsUyxg3Hj
         UgzlTBEk6O4HckEYIlQzFVk0H2btgsH8mPQwqJwgjDekz4i+kJrJ3nv8aca95mUNYgKp
         kb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zdOcjsQSagxh/0ytfqlFE21zp3hEcz2hdT+yMst4gNc=;
        b=tqKm3Vrmmr2mFK1FF5QuJdjhJLw4vpqK/fJBfXqFljotRhn+KxEfnbjc5AzwbcBi/e
         UcqG63y8YM+PdpmrrhQiAK60/tJgpgUuYKp94spSYO9qdPRiBjBI8onITeN3pfogN21l
         cRzhdj6Fwy0utWlqsBwQ4sEMK0nDSgJgYCKCAnnv+/uOEN+g8H4DKb/o0DltWXZi3YoS
         Eo4gO8lDBWzEHlJbBSzKon4y9c4nRJzgFPGP+wgPtQEOwrJV31TXgDm4lRKam6SXJXIZ
         s6GML4dczHRqDxsMXRQWPwphgxPbGiJB7OC/yuZIIVy6qumk3mTXvmvSjGNuS+DFiFTr
         2aEw==
X-Gm-Message-State: ABuFfohLz/uX8gakzwz5EOuENdyjcw2eaSkBo6EYYimpzQ6TnWb9uZiw
        GkCsLmo8gYiVqYceaBL3jBU=
X-Google-Smtp-Source: ACcGV63dcwn3CfpfcdVSxpP02cwtPNNT8Ar0b4/iVFpYNWFL+3jdOGemzpNooad64rL6NFDMHaH+5g==
X-Received: by 2002:a62:68c3:: with SMTP id d186-v6mr12074613pfc.195.1539657561371;
        Mon, 15 Oct 2018 19:39:21 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id u79-v6sm18620287pfd.117.2018.10.15.19.39.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Oct 2018 19:39:20 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v4 08/18] of: overlay: reorder fields in struct fragment
Date:   Mon, 15 Oct 2018 19:37:28 -0700
Message-Id: <1539657458-24401-9-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
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

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 7fcf4a812d06..272a0d1a5e18 100644
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

