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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81C9C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9787B2081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTlZt5u6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9787B2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbeKFArK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:47:10 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35908 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729760AbeKFArJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:47:09 -0500
Received: by mail-pg1-f194.google.com with SMTP id z17-v6so4384747pgv.3;
        Mon, 05 Nov 2018 07:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Eps1KFA7lEghL7/4dmQbZz3ImKypsw61x2xaOWgNqDg=;
        b=gTlZt5u6/vzKqoG3PjCr8lAQ26z5MBBKNrCnWqffkqsJlD5p6kXawKm6ffNfxxIQT/
         RzUgUTxlCAv1sCjEsZNkIFACMb7xfs8Lf08QdG9wJHa9LQgYJuu3MhcIUwkA5OltE/nn
         KWUp8nAdz8iaay9kFo10eXDaWTkjTFtB9ikhiraNL16qwmBh2ntT1/XRkyuKfP1lGGiQ
         FI7II6KnWwG3hbiErSQXPqBbldUtlsEk5MczQ+hae+aNNE1xoWN+Py81rHXDX2ncKwQm
         OLV8oNcGGdu5RmZKELszJbV6l5rOvAQ/qkcOUVX+/hxVZ2grPzjtWPRd0gsu5USArgFB
         kANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Eps1KFA7lEghL7/4dmQbZz3ImKypsw61x2xaOWgNqDg=;
        b=kwmTIDK6t9f0FWAzCt0qNF+K/CLNVx+0yT5l7hBbIlLUAY6UGLpXETlZnWspdcw9qa
         5Q7BGVV8GsYy0g/itW2VTIzGXZtYaJe+OcHE0mSSqUEOBTYQjGQijAv6jmE2oQxeP2r9
         UvcNBG8EEYfpfPOHSgr9c92J1pUXV+6fU6F7BgT0Iw33UGMysFID1pupR9FfL2g1VraV
         cpmy+YfMimWbasrxeikcbK9n0OHqNznuNGF/psvz4YMtyzcLCVlTjFv3pcB6ZDSFpWcx
         4jIVaSJWOG96KdtWvw53582c0eLUDmAPqBjI1yzYhRv0CM9CGPHK2OGW1xoCcJ9AedF0
         YLiw==
X-Gm-Message-State: AGRZ1gJKOGhuQ3YpZ2H7UXhc3RZvvT9hIZPTuM+Lj9SRLjYCrH90vEc5
        qOYg+XZfNpF1pHC7WtyvFXj+0yQh
X-Google-Smtp-Source: AJdET5el0E2+PBwqJW9dh4BMEuo83mkeQc3jYFOppW0RBR0EZIN6ZXgfPkxK0Uag69Vo4Ew5+zGS5A==
X-Received: by 2002:a63:3c44:: with SMTP id i4mr20326569pgn.286.1541431616477;
        Mon, 05 Nov 2018 07:26:56 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id u76-v6sm37260578pfa.176.2018.11.05.07.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Nov 2018 07:26:55 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v6 03/18] of: overlay: add missing of_node_get() in __of_attach_node_sysfs
Date:   Mon,  5 Nov 2018 07:25:00 -0800
Message-Id: <1541431515-25197-4-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

There is a matching of_node_put() in __of_detach_node_sysfs()

Remove misleading comment from function header comment for
of_detach_node().

This patch may result in memory leaks from code that directly calls
the dynamic node add and delete functions directly instead of
using changesets.

Tested-by: Alan Tull <atull@kernel.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

This patch should result in powerpc systems that dynamically
allocate a node, then later deallocate the node to have a
memory leak when the node is deallocated.

The next patch in the series will fix the leak.

 drivers/of/dynamic.c | 3 ---
 drivers/of/kobj.c    | 4 +++-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 12c3f9a15e94..146681540487 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -272,9 +272,6 @@ void __of_detach_node(struct device_node *np)
 
 /**
  * of_detach_node() - "Unplug" a node from the device tree.
- *
- * The caller must hold a reference to the node.  The memory associated with
- * the node is not freed until its refcount goes to zero.
  */
 int of_detach_node(struct device_node *np)
 {
diff --git a/drivers/of/kobj.c b/drivers/of/kobj.c
index 7a0a18980b98..c72eef988041 100644
--- a/drivers/of/kobj.c
+++ b/drivers/of/kobj.c
@@ -133,6 +133,9 @@ int __of_attach_node_sysfs(struct device_node *np)
 	}
 	if (!name)
 		return -ENOMEM;
+
+	of_node_get(np);
+
 	rc = kobject_add(&np->kobj, parent, "%s", name);
 	kfree(name);
 	if (rc)
@@ -159,6 +162,5 @@ void __of_detach_node_sysfs(struct device_node *np)
 		kobject_del(&np->kobj);
 	}
 
-	/* finally remove the kobj_init ref */
 	of_node_put(np);
 }
-- 
Frank Rowand <frank.rowand@sony.com>

