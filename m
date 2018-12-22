Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AB8C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 21:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65FB021939
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 21:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390308AbeLVVzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 16:55:24 -0500
Received: from mail.ispras.ru ([83.149.199.45]:45882 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388468AbeLVVzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 16:55:24 -0500
Received: from localhost.localdomain (109-252-60-93.nat.spd-mgts.ru [109.252.60.93])
        by mail.ispras.ru (Postfix) with ESMTPSA id 7F4AC540089;
        Sun, 23 Dec 2018 00:55:21 +0300 (MSK)
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
To:     Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Peng Li <lipeng321@huawei.com>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: net: hns: question regarding ae_node device node refcounting
Date:   Sun, 23 Dec 2018 00:54:41 +0300
Message-Id: <1545515681-29561-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

hns_nic_dev_probe() increments refcount of ae_node device node:
	ae_node = of_parse_phandle(dev->of_node, "ae-handle", 0);

But there is no of_node_put() for ae_node.
What is the right place to decrement the ae_node refount?

Should it be placed in hns_nic_dev_probe() or in hns_nic_dev_remove()?
Or may be it is managed by fwnode somehow?

--
Alexey Khoroshilov
Linux Verification Center, ISPRAS
web: http://linuxtesting.org

