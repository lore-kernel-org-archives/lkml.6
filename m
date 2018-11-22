Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_TVD_FUZZY_SECTOR,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E985FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 20:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B93208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 20:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkdjVSh4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B93208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405031AbeKWHQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 02:16:32 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38720 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730632AbeKWHQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 02:16:31 -0500
Received: by mail-qk1-f193.google.com with SMTP id d19so7465259qkg.5;
        Thu, 22 Nov 2018 12:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E8txJ2Mr/1Nx5BwIcNhMC7arKTkTIfGbDpJ7btoKNbE=;
        b=DkdjVSh4taAkdlxDHU9wK7qjhClGiuoCKCXZuu9HrdzVYuztbadWnhgYXziCo5hS6B
         1XiaB/29ROoE4tOh4vZBL7fFUM6tR/rDHD6WGVabhQ2cNZ17dAXV7NvSqa+D0NBi0Xt/
         kqq+ywUfJ/1ClNFZfQMQeFv+w4b4ku6E4DwkM/DGdREUCoB2dTE2y0WmuJYWUjY8ALbd
         ihx7UjU7etvqdcRSZGx2NeUjwjF0tYuGKbgCKcDL+wee5zLZSk3mGTFDfVr1AdSIktJM
         s7BzXaBUyWF+I7PcUe46+GmZFgeGb+f85dC0j38V9iVtIxYwOSdNHF81LmlvLhtvRzcF
         99NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E8txJ2Mr/1Nx5BwIcNhMC7arKTkTIfGbDpJ7btoKNbE=;
        b=JLfcajXX2L+Gt+dFqE/6aLqHPEFwOf20i36srVFCLT0oHpitONr14qfNKLr9zkRE2r
         bikympPS6sq4H4TiJFsQo0lPsAmrMX+QF/fbuGQjVqZamqL166n6uzoDEeO8t4YkoKvd
         57EhXL1zZfJPNKbAbV40GSyuWmHd3Lct0xG+RI6jN+hyTbCxCqnd3UWHor21UF/NT7XB
         8e0ecXIFwl1HlG5jxAcG53XIhyRZKcXHOzT7EBmifSBdJZl64x+xiAfwckaFGgL740cq
         /mK9qERd1oJa5x7rs00Vr8s/jNm11G+89gjrsmvRO6sizBAZMpKv94EviNqIZENipHrE
         vqJg==
X-Gm-Message-State: AA+aEWYR50+DREOWY1WnyXyafHfLh4CavdRVySs48f8XlJgwKOv+W6Ve
        wtlvklG9zt8gHwhUW4OAdl8=
X-Google-Smtp-Source: AFSGD/XrJHxZU0wJZZ5gct9iSktRBeDdxnllf4kqLhokDxDrejcrIIk6Jt0W2D/uoQB8zPWGhmr6iA==
X-Received: by 2002:a37:6a84:: with SMTP id f126mr11206687qkc.342.1542918930251;
        Thu, 22 Nov 2018 12:35:30 -0800 (PST)
Received: from infosect0r.umd.edu (129-2-181-223.wireless.umd.edu. [129.2.181.223])
        by smtp.gmail.com with ESMTPSA id v53sm27629674qtb.6.2018.11.22.12.35.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 12:35:29 -0800 (PST)
From:   Shreyans Devendra Doshi <0xinfosect0r@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shreyans Devendra Doshi <0xinfosect0r@gmail.com>
Subject: [PATCH] Documentation: dev-tools: Fix typos in index.rst
Date:   Thu, 22 Nov 2018 10:34:56 -0500
Message-Id: <20181122153456.24413-1-0xinfosect0r@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a spelling error and removes an extra whitespace character.

Signed-off-by: Shreyans Devendra Doshi <0xinfosect0r@gmail.com>
---
 Documentation/dev-tools/index.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
index e313925fb0fa..b0522a4dd107 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -3,8 +3,8 @@ Development tools for the kernel
 ================================
 
 This document is a collection of documents about development tools that can
-be used to work on the kernel.  For now, the documents have been pulled
-together without any significant effot to integrate them into a coherent
+be used to work on the kernel. For now, the documents have been pulled
+together without any significant effort to integrate them into a coherent
 whole; patches welcome!
 
 .. class:: toc-title
-- 
2.19.1

