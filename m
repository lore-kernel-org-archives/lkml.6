Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67785C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C6F217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551162047;
	bh=HMCDdviA0h4RNTNzLuMdlrK/6uDGQ2pjM8xSWFgy3ZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=rjSy2+SD2wNmi+fN5CVrw4sQmd8Q9ZGtKE26VKqIPMZch8HMFcwN92ONqG5t1LHIH
	 n3MArBgov4q8TK33zPNN9NxKdore3OdzOl+WMdDugqgTXXmEAgSpZeXJMB/9LwScQh
	 9bmK/hJlx0dwN/ynSPxm+QozsJIs6bcfeFoLlw4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfBZGUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:20:45 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39240 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfBZGUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:20:38 -0500
Received: by mail-it1-f194.google.com with SMTP id l15so2427930iti.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 22:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=n4Mj7KOXm6f0pBpzRgDrlWbIzKTJTfgrfuBaGNTY7yk=;
        b=PY0Nul/0AWqzJM799Ga/WcZYMTalopzAvzHjec6ve1tJ9nuTJZE5Pb6WYPTB6JGw0U
         Rc2gH4xqxca2QQgPdrGUKoZygnlTrMnaBY9FAD80oMCn/2do/Cu4326WRbGJrCwSrOh+
         FgeOR3iVP0y1UvDcePvyiS2ZoYDnP38hwI6u9V0NKrhe+UD/JLMuhMj9teA87f7XlZN5
         qHWmq6DW0DSPgxMjkHL63z0j6iGCo3fR7FZEavuF8be3Y04+wEBl1GpTEoRQRV3l82wc
         fgI4OuiuRpSblX+JcnQ1u0/ZDTvPC68oxQRGZZYH2NOWrc2sPOyphxtmpQrbt0erRWdZ
         AC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=n4Mj7KOXm6f0pBpzRgDrlWbIzKTJTfgrfuBaGNTY7yk=;
        b=L/ajLmf53cIa7xkws7Pntb+5ks+2C3eYHa4XkVb2tpQ1vCdKSJvWZfoIk8PvE77RFB
         984bieF+XjPn0sAT+jzyAPVbe01zzLMAJUXpgm/Ri4D9pC4wuuFYxe7J4EwWDpx5WR8q
         TPG1fhWazaC3LuqIND2zw1vgZerN3cl9fkvxZIPKgX6MWlF1/h/6MfufGNIYMT76ETs8
         0OSOPpQm7xs43MnaVxkYgV+9gdGdr9k49OUX6/60/4a/B9Stzn1laeDODq8OJaVHAup+
         MJRBd0/Lu0V5aH9qQHSTKn+mQQTbmEOQ2iHBK9Elzs/ExJCB6DjdKq2L1Ly9YNhMOwgR
         xlrQ==
X-Gm-Message-State: AHQUAuY9FWIBc8b0EOCcDiYp5n6KBAbOxCPPomsBHBeSc4ro0RGActEM
        S12Ha9KajdfPP18VzPiwPao=
X-Google-Smtp-Source: AHgI3IY6Qt7mMB1wI3JKGb7Q/qgZ6ynGZfI6f8h1yhrTIQOutpyR8Briny/4FgMJMwxGGQQ3sbmjog==
X-Received: by 2002:a02:9f86:: with SMTP id a6mr11746629jam.87.1551162037743;
        Mon, 25 Feb 2019 22:20:37 -0800 (PST)
Received: from kbl.lan (h66-222-56-144.cntcnh.dsl.dynamic.tds.net. [66.222.56.144])
        by smtp.gmail.com with ESMTPSA id w8sm6431431ita.21.2019.02.25.22.20.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 22:20:37 -0800 (PST)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: [PATCH 12/14] topology: Create package_threads sysfs attribute
Date:   Tue, 26 Feb 2019 01:20:10 -0500
Message-Id: <1ca9cc00d89d184d098a955509df2d527ef940da.1551160674.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <e2810a5317d3a109a98204e883fd1461f77b9339.1551160674.git.len.brown@intel.com>
References: <e2810a5317d3a109a98204e883fd1461f77b9339.1551160674.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Len Brown <len.brown@intel.com>

The sysfs cpu/topology/core_siblings (and core_siblings_list)
attributes are documented, implemented, and used by programs to
represent set of logical CPU threads sharing the same package.

This makes sense if the next topology level above a core
is always a package.  But on systems where there is a die
topology level between a core and a package, the name
no longer makese sense.

So without changing its function, add a name for this map
that describes what it actually is -- package threads --
the set of logical CPU threads that share the same package.

This new name will be immune to changes in topology, since
it describes threads at the current level, not siblings
at a contained level.

Signed-off-by: Len Brown <len.brown@intel.com>
Suggested-by: Brice Goglin <Brice.Goglin@inria.fr>
---
 Documentation/cputopology.txt | 8 ++++----
 drivers/base/topology.c       | 6 ++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/cputopology.txt b/Documentation/cputopology.txt
index 4e6be7f68fd8..2794dbe8e559 100644
--- a/Documentation/cputopology.txt
+++ b/Documentation/cputopology.txt
@@ -46,15 +46,15 @@ thread_siblings_list:
 	human-readable list of cpuX's hardware threads within the same
 	core as cpuX.
 
-core_siblings:
+package_threads:
 
 	internal kernel map of cpuX's hardware threads within the same
-	physical_package_id.
+	physical_package_id. (deprecated name: "core_siblings")
 
-core_siblings_list:
+package_threads_list:
 
 	human-readable list of cpuX's hardware threads within the same
-	physical_package_id.
+	physical_package_id. (deprecated name: "core_siblings_list")
 
 book_siblings:
 
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 50352cf96f85..5f4405a08c6e 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -57,6 +57,10 @@ define_siblings_show_func(core_siblings, core_cpumask);
 static DEVICE_ATTR_RO(core_siblings);
 static DEVICE_ATTR_RO(core_siblings_list);
 
+define_siblings_show_func(package_threads, core_cpumask);
+static DEVICE_ATTR_RO(package_threads);
+static DEVICE_ATTR_RO(package_threads_list);
+
 #ifdef CONFIG_SCHED_BOOK
 define_id_show_func(book_id);
 static DEVICE_ATTR_RO(book_id);
@@ -81,6 +85,8 @@ static struct attribute *default_attrs[] = {
 	&dev_attr_thread_siblings_list.attr,
 	&dev_attr_core_siblings.attr,
 	&dev_attr_core_siblings_list.attr,
+	&dev_attr_package_threads.attr,
+	&dev_attr_package_threads_list.attr,
 #ifdef CONFIG_SCHED_BOOK
 	&dev_attr_book_id.attr,
 	&dev_attr_book_siblings.attr,
-- 
2.18.0-rc0

