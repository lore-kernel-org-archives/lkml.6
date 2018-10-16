Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9E4C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9922098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTf9uVoj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9922098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbeJQBOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:14:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729116AbeJQBOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:14:12 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A3BF20866;
        Tue, 16 Oct 2018 17:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710567;
        bh=KJVxEfZP8C2jKZLof+MUzT+NSIxYaOkmE6fD6IQ7+5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GTf9uVojiyTN1+E6F+6fA0OFeXH4l7kXX75wZfYpqTQK3gNIMCK3GKWvu8ExntUxx
         dQugtrmG/nyAm+EWhGUtJBtE7BA0vARoDwAf0nNy/TAwQOv4rNuH5KybMOTz6ksjtX
         d+cMrKsRsfl50D26zG4O//SCEIYykh6vWlpRN4io=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lei Yang <Lei.Yang@windriver.com>,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 04/71] selftests: memory-hotplug: add required configs
Date:   Tue, 16 Oct 2018 19:09:01 +0200
Message-Id: <20181016170539.544744133@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
References: <20181016170539.315587743@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lei Yang <Lei.Yang@windriver.com>

[ Upstream commit 4d85af102a66ee6aeefa596f273169e77fb2b48e ]

add CONFIG_MEMORY_HOTREMOVE=y in config
without this config, /sys/devices/system/memory/memory*/removable
always return 0, I endup getting an early skip during test

Signed-off-by: Lei Yang <Lei.Yang@windriver.com>
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/memory-hotplug/config |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/testing/selftests/memory-hotplug/config
+++ b/tools/testing/selftests/memory-hotplug/config
@@ -2,3 +2,4 @@ CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTPLUG_SPARSE=y
 CONFIG_NOTIFIER_ERROR_INJECTION=y
 CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
+CONFIG_MEMORY_HOTREMOVE=y


