Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E896EC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEAB324095
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEAB324095
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754538AbeGEQ1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:27:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57448 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754043AbeGEQ1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:27:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 45A0D2BDFF;
        Thu,  5 Jul 2018 16:27:36 +0000 (UTC)
Received: from gblock2.localdomain (ovpn-12-94.pek2.redhat.com [10.72.12.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 682CF2156889;
        Thu,  5 Jul 2018 16:27:31 +0000 (UTC)
From:   xiubli@redhat.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     pkalever@redhat.com, pkarampu@redhat.com, atumball@redhat.com,
        sabose@redhat.com, mchristi@redhat.com
Subject: [PATCH 0/2] uio: fix potential crash bug
Date:   Thu,  5 Jul 2018 12:27:26 -0400
Message-Id: <1530808048-9494-1-git-send-email-xiubli@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 05 Jul 2018 16:27:36 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 05 Jul 2018 16:27:36 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'xiubli@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>




Xiubo Li (2):
  uio: change to use the mutex lock instead of the spin lock
  uio: fix crash after the device is unregistered

 drivers/uio/uio.c          | 134 +++++++++++++++++++++++++++++++++------------
 include/linux/uio_driver.h |   2 +-
 2 files changed, 101 insertions(+), 35 deletions(-)

-- 
1.8.3.1

