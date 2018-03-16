Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3328118-1521214838-2-4898869537810713902
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521214837; b=uGbF2d/kzoPtojg6LsETvU3Jf+sUistSsJfcerJHDusmyMU
    PZFL8us0dwcEYudlzMdNAJIcEsKIjZlyua8Dy3UbK1f0W4Ek3yHUyNqmtSZaHax1
    4snagVSWxjRxcWD8JOC8UiEimb/notOSn5QXF1/c9+l/EmtvH/IdJtvZrkFq97Fa
    rg72Ioj7nBbtYb5uRlDUGC+XktRI1e2vPcvXSYHYNs6H9eG7RWFXXp3XlzERrcv+
    zye9b922tYgAFuSaKFCpTzuTbzjvRRpRq+2yyk/Fq74HL7FD871YR3/XoUV2IpFn
    Fe8nDyno8TAOqcJBLVumLRWSdiwHuRRGEUGgT6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521214837; bh=3Hm8lwaD6qT0n1yIOBYMrx3u8+
    vIezIRedzJzHgPpIA=; b=caQvYsHV8WTb8QfyrTP0JB1A8yEF4iJ0kpTniPHko0
    X+mVK+6U714GcyOeiHv4lWsEeZ1a2jdn+iAXf/ud30fHdkjXpmydsxkphRBQFwBp
    HoQ4RR+UQDO/99xZ1tUhLc3yBOrEsaF03OsmAjCGqt+z2tw+7GgUUJTV5xccAjWo
    2GWNyetdg2Lybzgps+pJqeJnty5Kln/R3y0JSgq/MnMIfOeRYzbJERw3QwRvttJ1
    MzVtL2sFobEVodLu2Q8OrGzlnKtrGweGz6uC6Rst8bOsxz+/UIJrjNCUdAvtvGOy
    7yXTNZVqiPywNR1QPAomxXPrEioqK6lZMbw3hyHaq0CQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965045AbeCPPkZ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:40:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43566 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964989AbeCPPkY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:40:24 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 030/128] HID: multitouch: Only look at non touch fields in first packet of a frame
Date: Fri, 16 Mar 2018 16:22:51 +0100
Message-Id: <20180316152338.045316429@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>


[ Upstream commit 55746d28d66860bccaae20a67b55b9d5db7c14af ]

Devices in "single finger hybrid mode" will send one report per finger,
on some devices only the first report of such a multi-packet frame will
contain a value for BTN_LEFT, in subsequent reports (if multiple fingers
are down) the value is always 0, causing hid-mt to report BTN_LEFT going
1 - 0 - 1 - 0 when pressing a clickpad and putting down a second finger.
This happens for example on USB 0603:0002 mt touchpads.

This commit fixes this by only reporting non touch fields for the first
packet of a (possibly) multi-packet frame.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-multitouch.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 65ea23be9677..397592959238 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -778,9 +778,11 @@ static int mt_touch_event(struct hid_device *hid, struct hid_field *field,
 }
 
 static void mt_process_mt_event(struct hid_device *hid, struct hid_field *field,
-				struct hid_usage *usage, __s32 value)
+				struct hid_usage *usage, __s32 value,
+				bool first_packet)
 {
 	struct mt_device *td = hid_get_drvdata(hid);
+	__s32 cls = td->mtclass.name;
 	__s32 quirks = td->mtclass.quirks;
 	struct input_dev *input = field->hidinput->input;
 
@@ -837,6 +839,15 @@ static void mt_process_mt_event(struct hid_device *hid, struct hid_field *field,
 			break;
 
 		default:
+			/*
+			 * For Win8 PTP touchpads we should only look at
+			 * non finger/touch events in the first_packet of
+			 * a (possible) multi-packet frame.
+			 */
+			if ((cls == MT_CLS_WIN_8 || cls == MT_CLS_WIN_8_DUAL) &&
+			    !first_packet)
+				return;
+
 			if (usage->type)
 				input_event(input, usage->type, usage->code,
 						value);
@@ -856,6 +867,7 @@ static void mt_touch_report(struct hid_device *hid, struct hid_report *report)
 {
 	struct mt_device *td = hid_get_drvdata(hid);
 	struct hid_field *field;
+	bool first_packet;
 	unsigned count;
 	int r, n;
 
@@ -874,6 +886,7 @@ static void mt_touch_report(struct hid_device *hid, struct hid_report *report)
 			td->num_expected = value;
 	}
 
+	first_packet = td->num_received == 0;
 	for (r = 0; r < report->maxfield; r++) {
 		field = report->field[r];
 		count = field->report_count;
@@ -883,7 +896,7 @@ static void mt_touch_report(struct hid_device *hid, struct hid_report *report)
 
 		for (n = 0; n < count; n++)
 			mt_process_mt_event(hid, field, &field->usage[n],
-					field->value[n]);
+					    field->value[n], first_packet);
 	}
 
 	if (td->num_received >= td->num_expected)
-- 
2.16.2
