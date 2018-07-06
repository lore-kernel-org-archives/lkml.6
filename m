Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4767C6778A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 02:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B912409C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 02:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B912409C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932174AbeGFC5Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 22:57:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753770AbeGFC5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 22:57:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C309A4010216;
        Fri,  6 Jul 2018 02:57:23 +0000 (UTC)
Received: from gblock2.localdomain (ovpn-12-18.pek2.redhat.com [10.72.12.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31DE32166BA9;
        Fri,  6 Jul 2018 02:57:18 +0000 (UTC)
From:   xiubli@redhat.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     hamish.martin@alliedtelesis.co.nz, jannh@google.com,
        pkalever@redhat.com, pkarampu@redhat.com, atumball@redhat.com,
        sabose@redhat.com, mchristi@redhat.com
Subject: [PATCH v3 0/3] uio: fix potential crash bug
Date:   Thu,  5 Jul 2018 22:57:13 -0400
Message-Id: <1530845836-49101-1-git-send-email-xiubli@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 06 Jul 2018 02:57:23 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 06 Jul 2018 02:57:23 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'xiubli@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

The V2 patch set maybe not post successfully, so post it again
with one new updation.

V2:
- resend it with some small fix

V3:
- switch to use request_threaded_irq


Xiubo Li (3):
  uio: use request_threaded_irq instead
  uio: change to use the mutex lock instead of the spin lock
  uio: fix crash after the device is unregistered

 drivers/uio/uio.c          | 151 ++++++++++++++++++++++++++++++++++-----------
 include/linux/uio_driver.h |   2 +-
 2 files changed, 115 insertions(+), 38 deletions(-)

-- 
1.8.3.1

