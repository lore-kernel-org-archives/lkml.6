Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9D4C6787A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6584221476
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pVtX+kvq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6584221476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeJIIA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 04:00:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36400 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeJIIA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 04:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=w85IpUwQo8xYzSv+H0ioqTbXHarO75e0dSv4SobL4qE=; b=pVtX+kvqZwDzH1soFPQlZp9ea
        Tybj+PIeKvbw5BmhSDgR+h34LuFEbPcUy8PQHf7ostCMSOU17Gndcuv6Rh7VZyeFD4KOBWOwwclsp
        lNbP8P0jAPbY8heFXEQ9m77FNuxyj7SVwHXF/ATBac0o03gTYvsdqlWFFF7+hCQyFoA2kOTVrR1IV
        f3p+Puxkgl2lnsKrDyyReWRrDcR5cteZDnp7ae74+jEGOvPKB9wO4Lxs6WO+LfXRkB88V640tdzTZ
        mcDfLD3hG+7lyDK8mOr8eNm+mdDLN0ACPW08gbLvsdeC400Up8fL6225GDr+dVMcUzkOzLvic475+
        IzcrmoECw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9gA3-0005Ga-LU; Tue, 09 Oct 2018 00:46:07 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-security-module@vger.kernel.org,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] security: fix LSM description location
Message-ID: <c06eb47c-05d3-f51c-625b-9bfdd33a426a@infradead.org>
Date:   Mon, 8 Oct 2018 17:46:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix Documentation location reference for where LSM descriptions should
be placed.

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
---
 Documentation/security/LSM.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-419-rc7.orig/Documentation/security/LSM.rst
+++ lnx-419-rc7/Documentation/security/LSM.rst
@@ -5,7 +5,7 @@ Linux Security Module Development
 Based on https://lkml.org/lkml/2007/10/26/215,
 a new LSM is accepted into the kernel when its intent (a description of
 what it tries to protect against and in what cases one would expect to
-use it) has been appropriately documented in ``Documentation/security/LSM.rst``.
+use it) has been appropriately documented in ``Documentation/admin-guide/LSM/``.
 This allows an LSM's code to be easily compared to its goals, and so
 that end users and distros can make a more informed decision about which
 LSMs suit their requirements.


