Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40509C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED38E20865
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TN0C2NGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED38E20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbeJMMay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 08:30:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44980 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbeJMMax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 08:30:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id r9-v6so7148478pff.11;
        Fri, 12 Oct 2018 21:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y8f+zX4OUAoqVg/3NA0TrDwr4Zjok9K4JF3715XNZDg=;
        b=TN0C2NGhYjK88hDnYMJu04tPsvFFVQF89aayf5OmNyzWECQvEkD9ulD0urAGCZP40I
         5fptg6J9R/ZumR/RQz/ABDlVWOXynH/hsJuzy4xE4l4aggHZYuslxbeEzDK7Ncw1bx0o
         d+6OuWgSdHZYvNw4OAgPK8BbD5AkaRyJvyTcY1H1LToN61kZXEfrnNqpLwq6BXuWUDfh
         T8mHJ2+ti0xk2gTVmR3tgGIcyOOfivfQae6ymBFUT8aZdJY2ZjDcqwZS085aKyrJVfWk
         u4Sz3n6iKFyfDqxdzcZQY8hWUN2opLuOSIq4Gr3jHfBQAJeWAObvyUo8ErSXj5eDR41/
         453g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y8f+zX4OUAoqVg/3NA0TrDwr4Zjok9K4JF3715XNZDg=;
        b=B0mCuWEazXrSCCk+6ajk/ERnE5L/clVavYn92leDxUgZ6J/QOl7IZCBQvn7hHRmybc
         iG2pk5h3JYANwMAkZozJV6zlmdEpKdLtVXW4+HEHzVATYeL33YvaqLzmJHwBqtzfS+BD
         wQahKP445MEJEh5rA9Rfw+eX9UKUpyIp0keRCkxxytxMDVnR2gAMACXrx98gZyc2eO/f
         h35B7Zj0flXiiA+oxU+mz5bzmILfaFQBzGBn8hQnxjIh8R5UScFPWSdDKEoPvJWsvW3v
         INATGboUjpijAt8oPnr8bjFpVTuwGq+P/lsgERnYdPj72J4fwPEYN/ddQ7PKO1XNyvda
         08qQ==
X-Gm-Message-State: ABuFfogCUHipAASJQs1s3BmUL4/YF5v3nPyPUYhyUWKkXW+zYw1Rr9Yt
        sCFVe7OlAUBWFZvGI9DNfZg=
X-Google-Smtp-Source: ACcGV63QjsrJbRwU5cAl0MzKeHSMW/wwfoQ5OxrsVSViU8k1wPBAVs/y59uPeF9znxjnDgYruHnI7g==
X-Received: by 2002:a63:78cc:: with SMTP id t195-v6mr8146071pgc.329.1539406512206;
        Fri, 12 Oct 2018 21:55:12 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id h87-v6sm6959462pfj.78.2018.10.12.21.55.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Oct 2018 21:55:11 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v2 06/18] of: overlay: do not duplicate properties from overlay for new nodes
Date:   Fri, 12 Oct 2018 21:53:26 -0700
Message-Id: <1539406418-18162-7-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
References: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
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

