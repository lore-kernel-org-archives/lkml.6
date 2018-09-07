Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6647FC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286CE2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:34:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286CE2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbeIGPPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 11:15:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57902 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728183AbeIGPPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 11:15:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7B3887A7ED;
        Fri,  7 Sep 2018 10:34:55 +0000 (UTC)
Received: from plouf.redhat.com (ovpn-116-25.ams2.redhat.com [10.36.116.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F124663F4A;
        Fri,  7 Sep 2018 10:34:51 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        Simon Wood <simon@mungewell.org>,
        Olivier Gay <ogay@logitech.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/7] HID: logitech-hidpp: support non DJ devices
Date:   Fri,  7 Sep 2018 12:34:43 +0200
Message-Id: <20180907103450.13890-1-benjamin.tissoires@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 07 Sep 2018 10:34:55 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 07 Sep 2018 10:34:55 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'benjamin.tissoires@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri, Nestor,

I have this series in my tree for a while now (first commit was in January).
I never sent it (as far as I can remember*) because I was requesting
feedback regarding the G920 wheel. I think I haven't break it, but
mistakes can happen.

Anyway, I think it's been too long, so I am just sending it now, as
it will fix the names of the non-dj devices that share the same USB receiver
(G900 and G403 for instance). Also, rebasing on top of new code is a pain
I'd rather not do every 3 months.

Cheers,
Benjamin

* looking into my archives, I actually sent those as a part of the
battery support in hid-logitech-hidpp. Consider it as a fresh start though :)

Benjamin Tissoires (7):
  HID: logitech-hidpp: allow non HID++ devices to be handled by this
    module
  HID: logitech-hidpp: make .probe usbhid capable
  HID: logitech-hidpp: support non-DJ receivers
  HID: logitech-hidpp: get the name and serial of the other non-HID++
    node
  HID: logitech-hidpp: create a name based on the type if non available
  HID: logitech-hidpp: support the G700 over wireless
  HID: logitech-hidpp: support the G900 over wireless

 drivers/hid/hid-ids.h            |   4 +
 drivers/hid/hid-logitech-hidpp.c | 470 +++++++++++++++++++++++++++++++++------
 2 files changed, 407 insertions(+), 67 deletions(-)

-- 
2.14.3

