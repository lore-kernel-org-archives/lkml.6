Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0CFC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A86208A6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A86208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933283AbeFUMJP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:09:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932763AbeFUMJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:09:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6143F4000C57;
        Thu, 21 Jun 2018 12:09:13 +0000 (UTC)
Received: from plouf.banquise.eu.com (ovpn-117-99.ams2.redhat.com [10.36.117.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C55472026D6B;
        Thu, 21 Jun 2018 12:09:11 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mario.Limonciello@dell.com,
        Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 00/12] Hid multitouch rewrite, support os system multi-axis devices, take 3
Date:   Thu, 21 Jun 2018 14:08:56 +0200
Message-Id: <20180621120908.16706-1-benjamin.tissoires@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 21 Jun 2018 12:09:13 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 21 Jun 2018 12:09:13 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'benjamin.tissoires@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a small v3 of my previous series.

I dropped the first patch as requested by Dmitry and added his acked-by
in the new 1/12.

Cheers,
Benjamin

Benjamin Tissoires (12):
  input: add MT_TOOL_DIAL
  HID: multitouch: make sure the static list of class is not changed
  HID: multitouch: Store per collection multitouch data
  HID: multitouch: store a per application quirks value
  HID: multitouch: ditch mt_report_id
  HID: multitouch: remove one copy of values
  HID: input: enable Totem on the Dell Canvas 27
  HID: core: do not upper bound the collection stack
  HID: microsoft: support the Surface Dial
  HID: multitouch: report MT_TOOL_PALM for non-confident touches
  HID: multitouch: touchscreens also use confidence reports
  HID: multitouch: handle palm for touchscreens

 Documentation/input/multi-touch-protocol.rst |  12 +-
 drivers/hid/hid-core.c                       |  17 +-
 drivers/hid/hid-input.c                      |   3 +
 drivers/hid/hid-microsoft.c                  |  49 +-
 drivers/hid/hid-multitouch.c                 | 996 ++++++++++++++++-----------
 include/linux/hid.h                          |  15 +-
 include/uapi/linux/input.h                   |   3 +-
 7 files changed, 684 insertions(+), 411 deletions(-)

-- 
2.14.3

