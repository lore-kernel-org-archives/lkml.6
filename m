Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2669103-1524408260-2-16523101425517992542
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
    1524408259; b=A5Gmgd8raX81rJEpfmPWDTLHjgl2KjBUew8rHOKyN9ewkQ7udt
    56myaMaEqJebmDQjoPnJE5I0b8Fhj9dec2JDOl0mvDMzIsjIGOkREBmdArvjzhrI
    5x0MSpWiXnx2ZN/aH5V74p8q5pd35Kzk4F7GyWZr+sWRyiBuQQnMJbjYjQo5oHIz
    k+2Cnw/sojJ8+OgmZZb0AbymUGljlDbZwgtqGYgI+Go8aKfNwcGWI4H210h8hd+J
    DRzJcMqAHpS+y0mx52+l2SJdFuhw5TRDn70x9K1D9K1aeoVCWKV2My8W68/NH/Di
    dIuf4vf8NDeM3t8tGMjoO9JVM4YzztZbRqGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524408259; bh=nqBNOqoQhFUBvRmjJvPCSM1qO5pn2o
    hT1Itoe3QU89I=; b=BOjlq5VUCIw/TBl+b82cpV7D0WJAC0+4ZYl1njjB1jzKC5
    6BmIY0xGYmFHAwaRFQUbJy92//kgy3sdmqvPvtLm2Rt787Nn83DMq2MVxXR1+WeZ
    4MlUdcykUFmHrADw6f8yIzF+Hjoe93bHCW/dEAi/yd2EgjgEQjIzRZo4SzOFUrKt
    xcGcn/iyAaAyyDAEQRaCOeI/AO0NIMx0ZTL7sx5A1cmMztLH+e/kpKuzpPc/kEjl
    j1sTQw/l8tXfy7hUXXhYStM+b7ps7/e490TQxsAaIU9Nd0WXlkOVW88+usYdTfAl
    ZzWcHXBqNxQo5xEDZOYC9fWFRhJzCErO8hQB6NYg==
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
X-CM-Envelope: MS4wfJcDL/35mGyBX7TX9SxM5Nc4qngTW5ywUVo8dNyGpZ+hJLfE6Qp7pvuPzE26yx4k8eMnj0kvfpNbuhKEcMWlxUG2MxqqsgOPe6suW5B717SHhTKjVFvU
    nYmU0j+jlT3gE4pG2RBbaZiwibv1A44ul7GEKVjM6GtNiNbZT8YXdEH98w4WLPPl1890UJZ0STOV599ddYphv/rS5K5qlGID6A0+FG1MjIv03TdA0iA48eGm
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=DfNHnWVPAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=Gyl36tz_ZFhzQlB0iyQA:9
    a=QEXdDO2ut3YA:10 a=rjTVMONInIDnV1a_A2c_:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932385AbeDVORD (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:17:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57892 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932380AbeDVORB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:17:01 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaron Ma <aaron.ma@canonical.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.4 43/97] HID: Fix hid_report_len usage
Date: Sun, 22 Apr 2018 15:53:21 +0200
Message-Id: <20180422135307.717270442@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 3 files changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1258,7 +1258,8 @@ static void hidinput_led_worker(struct w
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
@@ -314,7 +314,8 @@ static struct attribute_group mt_attribu
 static void mt_get_feature(struct hid_device *hdev, struct hid_report *report)
 {
 	struct mt_device *td = hid_get_drvdata(hdev);
-	int ret, size = hid_report_len(report);
+	int ret;
+	u32 size = hid_report_len(report);
 	u8 *buf;
 
 	/*
@@ -919,7 +920,7 @@ static void mt_set_input_mode(struct hid
 	struct hid_report_enum *re;
 	struct mt_class *cls = &td->mtclass;
 	char *buf;
-	int report_len;
+	u32 report_len;
 
 	if (td->inputmode < 0)
 		return;
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -110,8 +110,8 @@ struct rmi_data {
 	u8 *writeReport;
 	u8 *readReport;
 
-	int input_report_size;
-	int output_report_size;
+	u32 input_report_size;
+	u32 output_report_size;
 
 	unsigned long flags;
 
