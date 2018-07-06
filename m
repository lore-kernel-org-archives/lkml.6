Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC79C6778A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 00:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02C7240BD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 00:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F02C7240BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753483AbeGFAGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 20:06:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57722 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753251AbeGFAGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 20:06:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BCFA787928;
        Fri,  6 Jul 2018 00:06:46 +0000 (UTC)
Received: from gblock2.localdomain (ovpn-12-18.pek2.redhat.com [10.72.12.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52C872166BA9;
        Fri,  6 Jul 2018 00:06:41 +0000 (UTC)
From:   xiubli@redhat.com
To:     gregkh@linuxfoundation.org, hamish.martin@alliedtelesis.co.nz,
        linux-kernel@vger.kernel.org
Cc:     jannh@google.com, pkalever@redhat.com, pkarampu@redhat.com,
        atumball@redhat.com, sabose@redhat.com, mchristi@redhat.com
Subject: [PATCH V2 0/2] uio: fix potential crash bug
Date:   Thu,  5 Jul 2018 20:06:37 -0400
Message-Id: <1530835599-2234-1-git-send-email-xiubli@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 06 Jul 2018 00:06:46 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 06 Jul 2018 00:06:46 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'xiubli@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

V2:
- resend it with some small fix

Xiubo Li (2):
  uio: change to use the mutex lock instead of the spin lock
  uio: fix crash after the device is unregistered

 drivers/uio/uio.c          | 142 ++++++++++++++++++++++++++++++++++-----------
 include/linux/uio_driver.h |   2 +-
 2 files changed, 108 insertions(+), 36 deletions(-)

-- 
1.8.3.1

