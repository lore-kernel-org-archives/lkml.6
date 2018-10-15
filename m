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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F886C71122
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218512087D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wnr+8LIC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218512087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeJOIIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 04:08:53 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37904 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeJOIIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 04:08:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id f8-v6so8295530pgq.5;
        Sun, 14 Oct 2018 17:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2V0SSjUhWRPC5W4OdqGfdKbaaGUGCT0NLhr5UzIi3kQ=;
        b=Wnr+8LIC1PVd+cR+XFwtzb94AQJUTHPMc8z1qC2M9v2nyrBF3I8nvB/v5WeMstwlbi
         bT9o5Nj1pzNAlrctIxXg/qgHTW6nmUP91nwKfhb89hBFcFRV/kR6VkFbEqu84RE/Qb+f
         Z3wMG8+CNokXVeDAKI6DkMkgHNdShb8wUimvnKxigjyyHKG3OFb52pGyA+VWh4Iux2gB
         8sy9WQ7YbxYCOwNWNN27/zXeGVZw99HSBA2mp5jyxNn/LJB0uPAA24+zh7w1jLsGpXSB
         QKsWwpBdnYMzoEomC5a8IBDfq/kdYB321XO9DRY/n/8YfolwKAw8SC4SFn2R8iwyLGo5
         PSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2V0SSjUhWRPC5W4OdqGfdKbaaGUGCT0NLhr5UzIi3kQ=;
        b=CAsOQQiG3f3zSUMp35xC8wSiXukTWokjm5CN8gBo3TVvec11FXEQCs9pCkFpN2DlSv
         jaU6ZqM1+VNE00SDnNzyUj69auzIcTALe0591d6NZZ6SDwKb1a6yt+zT5KItd2KjPd08
         X7vzhWW33czVh4Xwpje4iRFgVj3pLVqgRi+y4zxLRuLNkwyfoMs7EGn9kHJ9fG+XNTIR
         GTcXRTUu3Alyqe8yLrIDtjkfHsW2fzPsbNABIqd5v5YXF6PRUTDxxdHwSq+Bi1xIHgYk
         taaGZtW6R3rpFiVHCsun5Hd/MoOISCDvxZNZGAIosHIRCwM3x7ERGFPhIoK+KrpAV4Eq
         ldSg==
X-Gm-Message-State: ABuFfogvBoc9eaY6ZyeTlq5YxPx+DDUpsGmF6p2h+2qstAnAx3xjkqtj
        4gq054iKkeNO6TlDKqh9MGM5pBSW
X-Google-Smtp-Source: ACcGV63YiTii26iv8CTGNE+zWkdSWeEpJc2NTAH/PvOKTanhSexqc2OmDQ8I9YpIfVUaG6/8G+cXiA==
X-Received: by 2002:a62:7501:: with SMTP id q1-v6mr15164034pfc.225.1539563164629;
        Sun, 14 Oct 2018 17:26:04 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id j14-v6sm11387110pgh.52.2018.10.14.17.26.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Oct 2018 17:26:04 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v3 04/18] powerpc/pseries: add of_node_put() in dlpar_detach_node()
Date:   Sun, 14 Oct 2018 17:24:16 -0700
Message-Id: <1539563070-12969-5-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
References: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

"of: overlay: add missing of_node_get() in __of_attach_node_sysfs"
added a missing of_node_get() to __of_attach_node_sysfs().  This
results in a refcount imbalance for nodes attached with
dlpar_attach_node().  The calling sequence from dlpar_attach_node()
to __of_attach_node_sysfs() is:

   dlpar_attach_node()
      of_attach_node()
         __of_attach_node_sysfs()

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 arch/powerpc/platforms/pseries/dlpar.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index a0b20c03f078..e3010b14aea5 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -272,6 +272,8 @@ int dlpar_detach_node(struct device_node *dn)
 	if (rc)
 		return rc;
 
+	of_node_put(dn);
+
 	return 0;
 }
 
-- 
Frank Rowand <frank.rowand@sony.com>

