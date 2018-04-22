Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524405958-2-5334777686613497773
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enroda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524405958; b=XcRrfknM/vQk4j2KsOyFcIFK4yoBxLlkbqen6dRKRL04MwmWit
    Bw+DRuLByOPGccgrxT7T9dQzlT47h0e+qR1EZ2s/GcvVZ1XF3Qp/AHDBmXnHLz6u
    0H3M21QQXGFFnNXW4Q1Y8aVV0gpd1Ij6sKXjruVzqRHl7gSRkUtuIKZZpWRFbFWM
    9CWHGLxjCv1rAIA70zjMESdo6TLlcJT61V7tD5Q/BYy6ZdrAP43AQdXrdKXbs/qv
    +mDq2oD8c4OVKacHKZZxJbOVc1i4/2THQCjweo27kv6qgsKaGICWlN4BuP5z1ojs
    qyDzqoHIDsea2WVPAPcmhtXupTxbbqnPDcBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524405958; bh=wkzVP6spEZY2QHMRXu/EqLyRyNQh+G
    h5jaDxyQgszJ8=; b=aeFNgzKFUtAzCUJDxFGI4sGLPu5Rs/CY4Y8gbQDWVGQpjz
    FYD+zDEdeNiKul83BfTGBtKhUOMmK/q6LDhybLwX7pMalx7C5vchQHkyW6Ttd78Z
    2ADk57BU0+mynhikblO6QrFi8ypePwc6WrWIlltvmMYNNIcR6UqnjkBpmAcGjrbd
    ZF5K44mSueZKQovklBODQQn2GnDpZz6eifXCYz2MWqw+za+sgLuIO3WLJRrnNnaj
    8Ikzvdgkkn/GBbSMGRTca6MgnKC83LSrZtbrg5whg2ic2fmd1qNwm9sURPFL+e4d
    rLw40hZPKSW7MjuQJeyhee7rjo3i8QxavlBRVJhg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPFbpPGjBQftMhnzjCTeiniQrQQpa5tzTDkkOsvoVxOiOOF5sQ72RBfGK7jGLkkTOevqd9I5n2suOZ6k0u2XOZX03fk3QuU85x5zz7Sdjd5J5vyYu4BR
    YudyfwPp+UIW+G3VYq7E+bAPqAIfQ/AFNw0AkMnmBlzSkrtfMkx3O8SEmrhIwty23j03dPLScxgACDbpFBAkalKgvWxSBlGPDncVabxCXpX7/rxAi8x2NeII
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=DfNHnWVPAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=wynPBu5hdynl86m2cIoA:9
    a=R8TaTY3p6jOQmxo2:21 a=8wgGt2Nd2eZaud2l:21 a=QEXdDO2ut3YA:10
    a=rjTVMONInIDnV1a_A2c_:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755395AbeDVOFx (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:05:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51042 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755456AbeDVOFw (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:05:52 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaron Ma <aaron.ma@canonical.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.14 058/164] HID: Fix hid_report_len usage
Date: Sun, 22 Apr 2018 15:52:05 +0200
Message-Id: <20180422135137.823960184@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaron Ma <aaron.ma@canonical.com>

commit 3064a03b94e60388f0955fcc29f3e8a978d28f75 upstream.

Follow the change of return type u32 of hid_report_len,
fix all the types of variables those get the return value of
hid_report_len to u32, and all other code already uses u32.

Cc: stable@vger.kernel.org
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-input.c      |    3 ++-
 drivers/hid/hid-multitouch.c |    5 +++--
 drivers/hid/hid-rmi.c        |    4 ++--
 drivers/hid/wacom_sys.c      |    4 ++--
 4 files changed, 9 insertions(+), 7 deletions(-)

--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1359,7 +1359,8 @@ static void hidinput_led_worker(struct w
 					      led_work);
 	struct hid_field *field;
 	struct hid_report *report;
-	int len, ret;
+	int ret;
+	u32 len;
 	__u8 *buf;
 
 	field = hidinput_get_led_field(hid);
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -354,7 +354,8 @@ static const struct attribute_group mt_a
 static void mt_get_feature(struct hid_device *hdev, struct hid_report *report)
 {
 	struct mt_device *td = hid_get_drvdata(hdev);
-	int ret, size = hid_report_len(report);
+	int ret;
+	u32 size = hid_report_len(report);
 	u8 *buf;
 
 	/*
@@ -1049,7 +1050,7 @@ static void mt_set_input_mode(struct hid
 	struct hid_report_enum *re;
 	struct mt_class *cls = &td->mtclass;
 	char *buf;
-	int report_len;
+	u32 report_len;
 
 	if (td->inputmode < 0)
 		return;
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -89,8 +89,8 @@ struct rmi_data {
 	u8 *writeReport;
 	u8 *readReport;
 
-	int input_report_size;
-	int output_report_size;
+	u32 input_report_size;
+	u32 output_report_size;
 
 	unsigned long flags;
 
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -115,7 +115,7 @@ static void wacom_feature_mapping(struct
 	unsigned int equivalent_usage = wacom_equivalent_usage(usage->hid);
 	u8 *data;
 	int ret;
-	int n;
+	u32 n;
 
 	switch (equivalent_usage) {
 	case HID_DG_CONTACTMAX:
@@ -408,7 +408,7 @@ static int wacom_set_device_mode(struct
 	u8 *rep_data;
 	struct hid_report *r;
 	struct hid_report_enum *re;
-	int length;
+	u32 length;
 	int error = -ENOMEM, limit = 0;
 
 	if (wacom_wac->mode_report < 0)
