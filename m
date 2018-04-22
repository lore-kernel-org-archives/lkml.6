Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2591571-1524405459-2-16034932556764420266
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524405458; b=Dh8enbC7mbyl2GTkmUThzVqCEoiU4njWXY6VxhRZrX4J3900W/
    JRgtyWL1K8RZ5Mj38vD1pcyLISSxIn+OH16YH8/aCTUihfQvlVdbRFIp6GNnQ/Fq
    /JHYq0vHr1O3xpM01JgGfRu454s7OoVZLlmylWEOm7UaQ4BbzHGj1LENCjhZA+A+
    F/to9ulQmNvbAoAnv9FBSFWQIxuPbl7aoxOx1cv8cVohOTZeO107Za8mm3Auf8vz
    U2MdxeuJO5+K8KnSfaG7NljPV+XZ70af0OFptc3Z/VXXEBlqQIJsUVOzckwG3S/z
    yLT9pot+m/XlMBBCBK+nFFzg8dXNTmcaOlww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524405458; bh=1GSL2VUJK0eiAZEalkcemUCG3oAMfJ
    j9eF5ZkwHn7PQ=; b=IVSm9oDjiPJObToIHh397LdNUASb8LCUFdDPqLX1hu6aVE
    RW05nUIkMlYfRpCq0XyXJmqBnCM6E0BitJtXXaUBkVhfNTNqpvk2pGFmACmxWJJB
    IlYxP4l184PK0D8wJxL6q7f5gjygEVkrLL5e2C1mQp8GtE6gJWZUa88gkPMUGC6s
    AtVO0fKFStxr3K3AoYKTtzhPaL6iUOkVAKnm/kZOfJRVCdGvx+oRnCrEe69lvmya
    rC/mRRphIdeE/sJ/vA9AsQYe3mZ1iRn3PsXN0UMxU2tkfiTAmVYRvqgTWLpYsRHV
    tH/O1YwDmQqLlugPmSGu02FjIyI/xKxEAYDsGFfQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfEw9FpsX9UczhpASMq0oAU9YmAcfel7HKIkcG8BKnfrwkGQ8XmQWDy7xXhp0mVkAkgoiS5AIqFWUB7RiweZaEeicZBGkXjAEKBRSeL9oShN0ESMMMsNw
    LCZtZcqVvKRXjGlcmPV3T7sMMofl+IMD1ptdRi+rv7dxijgPkv5wsMpu/Z2DPUdDfLcpIdloPzTh9cU02yEoK3HlM/KHj7Nd9t3M6NA4vPGjmqxSLDs6/QtX
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=DfNHnWVPAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=f6o_zdfkVKY26JVic08A:9
    a=QEXdDO2ut3YA:10 a=rjTVMONInIDnV1a_A2c_:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753645AbeDVN5e (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 09:57:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45774 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbeDVN5b (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 09:57:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaron Ma <aaron.ma@canonical.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.16 071/196] HID: core: Fix size as type u32
Date: Sun, 22 Apr 2018 15:51:31 +0200
Message-Id: <20180422135107.934247264@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaron Ma <aaron.ma@canonical.com>

commit 6de0b13cc0b4ba10e98a9263d7a83b940720b77a upstream.

When size is negative, calling memset will make segment fault.
Declare the size as type u32 to keep memset safe.

size in struct hid_report is unsigned, fix return type of
hid_report_len to u32.

Cc: stable@vger.kernel.org
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-core.c |   10 +++++-----
 include/linux/hid.h    |    6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1365,7 +1365,7 @@ u8 *hid_alloc_report_buf(struct hid_repo
 	 * of implement() working on 8 byte chunks
 	 */
 
-	int len = hid_report_len(report) + 7;
+	u32 len = hid_report_len(report) + 7;
 
 	return kmalloc(len, flags);
 }
@@ -1430,7 +1430,7 @@ void __hid_request(struct hid_device *hi
 {
 	char *buf;
 	int ret;
-	int len;
+	u32 len;
 
 	buf = hid_alloc_report_buf(report, GFP_KERNEL);
 	if (!buf)
@@ -1456,14 +1456,14 @@ out:
 }
 EXPORT_SYMBOL_GPL(__hid_request);
 
-int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, int size,
+int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, u32 size,
 		int interrupt)
 {
 	struct hid_report_enum *report_enum = hid->report_enum + type;
 	struct hid_report *report;
 	struct hid_driver *hdrv;
 	unsigned int a;
-	int rsize, csize = size;
+	u32 rsize, csize = size;
 	u8 *cdata = data;
 	int ret = 0;
 
@@ -1521,7 +1521,7 @@ EXPORT_SYMBOL_GPL(hid_report_raw_event);
  *
  * This is data entry for lower layers.
  */
-int hid_input_report(struct hid_device *hid, int type, u8 *data, int size, int interrupt)
+int hid_input_report(struct hid_device *hid, int type, u8 *data, u32 size, int interrupt)
 {
 	struct hid_report_enum *report_enum;
 	struct hid_driver *hdrv;
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -851,7 +851,7 @@ extern int hidinput_connect(struct hid_d
 extern void hidinput_disconnect(struct hid_device *);
 
 int hid_set_field(struct hid_field *, unsigned, __s32);
-int hid_input_report(struct hid_device *, int type, u8 *, int, int);
+int hid_input_report(struct hid_device *, int type, u8 *, u32, int);
 int hidinput_find_field(struct hid_device *hid, unsigned int type, unsigned int code, struct hid_field **field);
 struct hid_field *hidinput_get_led_field(struct hid_device *hid);
 unsigned int hidinput_count_leds(struct hid_device *hid);
@@ -1102,13 +1102,13 @@ static inline void hid_hw_wait(struct hi
  *
  * @report: the report we want to know the length
  */
-static inline int hid_report_len(struct hid_report *report)
+static inline u32 hid_report_len(struct hid_report *report)
 {
 	/* equivalent to DIV_ROUND_UP(report->size, 8) + !!(report->id > 0) */
 	return ((report->size - 1) >> 3) + 1 + (report->id > 0);
 }
 
-int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, int size,
+int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, u32 size,
 		int interrupt);
 
 /* HID quirks API */
