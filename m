Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B037C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 21:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBBA20652
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 21:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CBBA20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbeJNElS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 00:41:18 -0400
Received: from mail.ispras.ru ([83.149.199.45]:38054 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbeJNElS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 00:41:18 -0400
Received: from localhost.localdomain (unknown [85.140.179.81])
        by mail.ispras.ru (Postfix) with ESMTPSA id 34F0D540089;
        Sun, 14 Oct 2018 00:02:44 +0300 (MSK)
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
To:     Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: mfd: syscon: syscon_node_to_regmap() and device_node refcounting
Date:   Sun, 14 Oct 2018 00:02:39 +0300
Message-Id: <1539464559-22268-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Could you please clarify why it is safe to store device_node pointer
in of_syscon_register()? Who is responsible to make sure that 
it is not disappear?

static struct syscon *of_syscon_register(struct device_node *np)
{
...
	syscon->np = np;
}


--
Thank you,
Alexey Khoroshilov
Linux Verification Center, ISPRAS
web: http://linuxtesting.org

