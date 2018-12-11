Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A35C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E97B20880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544843;
	bh=zP88Unxa/B2JUvTLJpu+NKAFeg+Up1Z4DuKzvnJS6HA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oNBMLYdZcl0npuRkQ0SaiElwqWdGt20PcwRglPnBvFnA8VP3IvB8rH1YbBkHl0rFl
	 MahM+/u/21PHhqgsuCPH+G/y8jqm1XRJOgGk9ZdzJq4wwlVcFJtmGjbjHWPJeerkVE
	 gApWbmaPjYIsbM4IUFL1BtvyHl1/0ldo0mwnvSYk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E97B20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbeLKQOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:14:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:37740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728990AbeLKPtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:49:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 539B0208E7;
        Tue, 11 Dec 2018 15:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543359;
        bh=zP88Unxa/B2JUvTLJpu+NKAFeg+Up1Z4DuKzvnJS6HA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=trwEzmpHCQkJha4uPav309z5FC/DqMVM5lMrQRKAr/6OzVQBYVDLDz18vdzuuUK4J
         R3TBY/ldNLwlorK8o1LXfKMX5vb5YAyfMkr0xhTMMRcCya+0YR5yIjqhD+M+s4/76U
         ZJTZiAJymfe1RyWU9uzSe7RLxCgXROXqM0QL9TDM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 4.9 20/51] ARC: [zebu] Remove CONFIG_INITRAMFS_SOURCE from defconfigs
Date:   Tue, 11 Dec 2018 16:41:28 +0100
Message-Id: <20181211151614.707668625@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151612.328911565@linuxfoundation.org>
References: <20181211151612.328911565@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Brodkin <alexey.brodkin@synopsys.com>

Zebu boards were added in v4.9 and then renamed to "haps" in v4.10.

Thus backporting
commit 64234961c145 (ARC: configs: Remove CONFIG_INITRAMFS_SOURCE from defconfigs)
we missed "zebu" defconfigs in v4.9.

Note this is only applicable to "linux-4.9.y"!

Spotted by KerneCI, see [1].

[1] https://storage.kernelci.org/stable/linux-4.9.y/v4.9.144/arc/zebu_hs_smp_defconfig/build.log

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arc/configs/zebu_hs_defconfig     |    1 -
 arch/arc/configs/zebu_hs_smp_defconfig |    1 -
 2 files changed, 2 deletions(-)

--- a/arch/arc/configs/zebu_hs_defconfig
+++ b/arch/arc/configs/zebu_hs_defconfig
@@ -11,7 +11,6 @@ CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
 # CONFIG_PID_NS is not set
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_INITRAMFS_SOURCE="../../arc_initramfs_hs/"
 CONFIG_EXPERT=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_COMPAT_BRK is not set
--- a/arch/arc/configs/zebu_hs_smp_defconfig
+++ b/arch/arc/configs/zebu_hs_smp_defconfig
@@ -11,7 +11,6 @@ CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
 # CONFIG_PID_NS is not set
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_INITRAMFS_SOURCE="../../arc_initramfs_hs/"
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_VM_EVENT_COUNTERS is not set


