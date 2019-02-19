Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77D0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BEF221900
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550547627;
	bh=huGfrNB+Ix9zH9pKjyZxrYDyNx+lbpxgbGpA1uVpNFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=mzV7H9QhezoRgLHKFiIgm+ioLfShfh0tUw8iACXv/876ReY+jo3yTcWyLgPu1cLAl
	 bvvAHGF0pKFx0Jj6swnZ3K/3E6u3sGeRXPz2KCGLkP3dqfgItnmDP8lZeTtSkFhyM8
	 RzbqgulKhKqRtR9ZDrSNGWtm6sLlbniWWR2Kv0Oc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfBSDk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:40:26 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43538 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfBSDkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 22:40:23 -0500
Received: by mail-qt1-f193.google.com with SMTP id y4so21606913qtc.10;
        Mon, 18 Feb 2019 19:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=9G8vrRa9yUi9LzXfHhpGRHPsVfQdCZamY6J2P4AWut4=;
        b=YLeTKnOpK3uKiTJhCpE9YCvyH5a1BOVx8OPDH4tg5ksgXU6dd2xH90neMd/N1L5fL5
         YWbjc0Hq3L2G+VtTR1cbkQmF8uljZaQqbPfBmHwrcxMfwBznQRTNfdgFbgyq4vopKZc/
         ktLXUvovV/zOGqqG5CxIdRSsUUf0BdXvCxkpdEaUDyuzSFfjTzjisyaalw8DUbkUAdIt
         /6FjQ/GIjuVHXY3hF7k9TxzPp4QrIaBmF6v3gDZcDMId8Lpslqoy5eTeSb6UJeFyF1xj
         0N5+/vLS9Q1/0+fKVieAJSZBCAjVn2YxUl+duY3gR0VOtoa8BA45Aw0/XzxuX887nn6Z
         cfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=9G8vrRa9yUi9LzXfHhpGRHPsVfQdCZamY6J2P4AWut4=;
        b=O+XBs8Hnhwd92TPOx+lZSssjyVxtMCuZlclP6L5bgAvQx6x0PXlKxZspXQU+CTUM51
         no98JZCQ0IG4Bm8iKNBR+8cR7zhABzkwOVgPprdaElwrK7XAeF24w7adxsIFRBgZo0TI
         SMgfX00oqqimTu0aFUBoBypprbSgAncBYKD6v7eWF4k2K0wJOe/aypj6D6Hd5HN10+aJ
         c70DTg/nAkIshn7X2cHZz7QjkUd0MUXdQbWDgIGvUJRzCbwBKILGREZCGYTdsUKI14vi
         kmlVFWfpzQgEDEYgcc36/+z5qldMpXqI4ZcRCgFGQp6/dTtq5XlHqrJCDxTv/7PhimFt
         Pgag==
X-Gm-Message-State: AHQUAuZJPUnhh6T19ZvsuTf5y/YGK5RmpCbK2DnBWl07jIhhxM2hFbWb
        c5AZM5HPSs6+BNe0S7xTYag=
X-Google-Smtp-Source: AHgI3IaUITtctY/QTnCTJYzkY28bAH70dTyhL7GJSf0ftWx4TPvA4bYRpsfFjgE3lzFc32th1/Uj+w==
X-Received: by 2002:a0c:baa8:: with SMTP id x40mr20002003qvf.18.1550547622653;
        Mon, 18 Feb 2019 19:40:22 -0800 (PST)
Received: from kbl.fios-router.home (pool-96-233-42-17.bstnma.fios.verizon.net. [96.233.42.17])
        by smtp.gmail.com with ESMTPSA id u5sm7327680qtg.37.2019.02.18.19.40.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 19:40:22 -0800 (PST)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH 01/11] x86 topology: fix doc typo
Date:   Mon, 18 Feb 2019 22:40:03 -0500
Message-Id: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <20190219034013.4147-1-lenb@kernel.org>
References: <20190219034013.4147-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Len Brown <len.brown@intel.com>

reflect actual cpuinfo_x86 field name:

s/logical_id/logical_proc_id/

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/x86/topology.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/x86/topology.txt b/Documentation/x86/topology.txt
index 2953e3ec9a02..06b3cdbc4048 100644
--- a/Documentation/x86/topology.txt
+++ b/Documentation/x86/topology.txt
@@ -51,7 +51,7 @@ The topology of a system is described in the units of:
     The physical ID of the package. This information is retrieved via CPUID
     and deduced from the APIC IDs of the cores in the package.
 
-  - cpuinfo_x86.logical_id:
+  - cpuinfo_x86.logical_proc_id:
 
     The logical ID of the package. As we do not trust BIOSes to enumerate the
     packages in a consistent way, we introduced the concept of logical package
-- 
2.18.0-rc0

