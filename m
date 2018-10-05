Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F22BC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C59208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Txvvydwn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C59208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbeJELLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 07:11:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37729 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbeJELLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 07:11:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id c10-v6so4139188pgq.4;
        Thu, 04 Oct 2018 21:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TSvuFcg8dSVKckHCq64beWOdH/WxX+9HQwnn/E0dljs=;
        b=Txvvydwn/k63hOxYlZwYdwaQIAjsth2Jaw4zbDNdTvqPzUBK/bEWuzmAxECzPr/rYB
         5ee7eBaNw1FbEYKkJ4M/WHi1t1nNCDk5vVrtbTuzDmVpBWywMHZMCbtMkyDjKD+IEShv
         Fshm8YpT/NObVTDG3rnXVe9X1gblxeezdCDtpJNZ6XLbQc01eR7O2FLjyBGIcN4G6a+V
         WHIFJ4Mp/4B0eZ2NxalIRlvpGQaQx8112Pd0FQJX3TymYYILDXlRQ1T4QgysP/e8XVsX
         dikNHoa/BUjMAwOGD35MjuM2ynoK/ZjKzfpqn+GqHfMZZUmhddS/DuBQPxc4FUro5AW8
         rA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TSvuFcg8dSVKckHCq64beWOdH/WxX+9HQwnn/E0dljs=;
        b=SuZgAzny+5lna4E2tbMo68bcvWM6rMw4s+n5tBBOOH/4t7VQjjmE/2ajjpdyS7tsYw
         IA07TR8bFLGT+RCir4Fb9FEOaeyKAyO6N8zwfx6xSd6ehRgiOAOJA6XgTkp58nUBdtum
         l6l1LxSyRxzHzMrNevZhiasCwu1IMh2QoNs+bSgOpp+QVGYfpKHayjAbiPUd60CK4/5x
         ZXFt6MtBEptInqFPEQG/gAVSvZrIV4sijoQvYd2oPieeUQBc863jQFH4LcfqiRhRNjsD
         TU0qL7UZZJPk9T+rc8FiC80HM1yIzJqme7EQ/nBvHg+ygn52bOl8NlDKuFbAgPf4Fk+c
         wAxA==
X-Gm-Message-State: ABuFfogUqeeLfEgJOWHAHoHOgPj6m6JuCFu9K7c9iM+sMAselSgIV1uv
        mS10ci9Le9BVqad9G2Z2KI0=
X-Google-Smtp-Source: ACcGV60Nq66DYWpjLNnNkOqwngvmQOK1t9t7z+KD3D9MvbeI/Z+r0dGjkV540jzK0as9aN/rEEhBDw==
X-Received: by 2002:a63:eb07:: with SMTP id t7-v6mr8409158pgh.441.1538712859586;
        Thu, 04 Oct 2018 21:14:19 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id n63-v6sm277975pfn.9.2018.10.04.21.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Oct 2018 21:14:19 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH 06/16] of: overlay: do not duplicate properties from overlay for new nodes
Date:   Thu,  4 Oct 2018 21:12:37 -0700
Message-Id: <1538712767-30394-7-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
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
index 0b0904f44bc7..c113186e222c 100644
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

