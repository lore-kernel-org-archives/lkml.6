Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A579C070C3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D2620652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vddVpi1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D2620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbeJOII5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 04:08:57 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36244 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbeJOII4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 04:08:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id f18-v6so8308927pgv.3;
        Sun, 14 Oct 2018 17:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y8f+zX4OUAoqVg/3NA0TrDwr4Zjok9K4JF3715XNZDg=;
        b=vddVpi1AmJhyFbWAVOaSGOLGGucg2BUuxTM5wvJ2OvyCwJtjgqZm+XdzDCZpavXCyU
         OHf2twaNg8dWJQzJNbvwF549GEuholfxTpWdf1BO2ooOHKlvRDiBqzabv7gqpNNN9Fca
         xhtud/n/B/hJ1WGlCuBwNV0m29wxzMCMwqIFprGB+M+MzS/JtMy3M727yeJEgCfJ1v3V
         OJZRRR2fde/vphpuw+ehqPqGiYuvoensA4vLkD1bA0/xRGvHiaTTkA+0TimUIZWUUdhk
         4F4UroT+e6b1mgkKbGgZPNVOqrDT2jsw71tiCh2PulVy29g8I0hTnovjscE6BLugImS2
         vfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y8f+zX4OUAoqVg/3NA0TrDwr4Zjok9K4JF3715XNZDg=;
        b=rSRkvu9crwEjEe1GrMHWvICPDF9015GAtOjfsqlGBAutdEkDwMTauyfQgsibkkId+U
         +SqxiKIs90kE3HoPqXNETESOoWGRmmj0RY9sFHTKcFqSyUecxZwNmnZeSiNHW6qvvS0g
         gfCenkNkroNjM/lfNqq973pzkIi3Okbk+CX/ms/L3zSILdAETt23M+yN7mQW53xlYVDP
         nVT9IIbbZjZsdQUiFBc5Z6qYEEiMSk4L9KiOc5iTLWmyb9MCcD4o8TK93V0WKvJ7oG/r
         uLWHaXTeIS2/J4B2KRkmsZ6MJsw6vIS7TkjBWp8kKt/45YyP8cz6l/YOVPDoqbu09nE/
         SNdw==
X-Gm-Message-State: ABuFfoj/AeuV4WMiYRTFZMSPirUWgMCRClISMuxC8xliSlj3ggBCa7sB
        H8sTk6N3oisJsmKGQXsTQoE=
X-Google-Smtp-Source: ACcGV612kGF23lI/IBRSGRLXD3+AHwU4TUXp3SRw7aP+4Ccv262X6c7pQUwBVf4mxnRI6LNGyoyr3w==
X-Received: by 2002:a63:1122:: with SMTP id g34-v6mr13827364pgl.85.1539563167453;
        Sun, 14 Oct 2018 17:26:07 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id j14-v6sm11387110pgh.52.2018.10.14.17.26.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Oct 2018 17:26:06 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v3 06/18] of: overlay: do not duplicate properties from overlay for new nodes
Date:   Sun, 14 Oct 2018 17:24:18 -0700
Message-Id: <1539563070-12969-7-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
References: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
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

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 94740f4ee34c..7fcf4a812d06 100644
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

