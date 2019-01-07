Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487C9C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F4C2183F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="mkSCheIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbfAGPqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:46:19 -0500
Received: from esa8.dell-outbound.iphmx.com ([68.232.149.218]:4002 "EHLO
        esa8.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727362AbfAGPqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:46:18 -0500
X-Greylist: delayed 566 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Jan 2019 10:46:18 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1546875978; x=1578411978;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h0giUe4TLOeIzo3IJKivXaM0NbFkKkb2BIotavaEGuY=;
  b=mkSCheISJC7AeQdELpX2N06ivrmamoYF8vmWoBlJ/Cypd7TZeZFDLNg3
   ToUnwVcRDNvsnNPLzAR+ge6KtZp+B8SkBz7BsqE5gZvWKMFgrs3EpLIKo
   HfjAAeJbYlV4fotnd9PleJm+nYbGmcOwJb1soK/xURjdl2+TWi9gg3T/v
   M=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EEAACucTNchyeV50NjGgEBAQEBAgE?=
 =?us-ascii?q?BAQEHAgEBAQGBUwMBAQEBCwGBWoEPgQInCoM2P4h5iweCDYkdjlIUgRADGDw?=
 =?us-ascii?q?LAQEjC4Q+AheBbiI2Bw0BAwEBAgEBAgEBAhABAQEVCQgpIwyCOgwuBE06MQE?=
 =?us-ascii?q?BAQEBAQEBAQEBAQEBAQEBAQEBARQCDGQBAQEBAwwGEQQNOgsMBAIBBgIRBAE?=
 =?us-ascii?q?BAwImAgICHyYICAIEAQ0FCBqCNUYEAQGBaQMVD4pBjzk9AoFuiQYBAQFufDO?=
 =?us-ascii?q?ELQGDSg2CGAWBC4s0ghaEI4JXRwICgSwBEgEDM4JxglcCiU6BfZVeMwcChxS?=
 =?us-ascii?q?HKoMrIJFviWKFBYESih0CBAIEBQIUgU0FKw8oMHFwUIJsgicOCRODOIpTQAE?=
 =?us-ascii?q?xiDMPFwOBBYEfAQE?=
X-IPAS-Result: =?us-ascii?q?A2EEAACucTNchyeV50NjGgEBAQEBAgEBAQEHAgEBAQGBU?=
 =?us-ascii?q?wMBAQEBCwGBWoEPgQInCoM2P4h5iweCDYkdjlIUgRADGDwLAQEjC4Q+AheBb?=
 =?us-ascii?q?iI2Bw0BAwEBAgEBAgEBAhABAQEVCQgpIwyCOgwuBE06MQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBARQCDGQBAQEBAwwGEQQNOgsMBAIBBgIRBAEBAwImAgICHyYIC?=
 =?us-ascii?q?AIEAQ0FCBqCNUYEAQGBaQMVD4pBjzk9AoFuiQYBAQFufDOELQGDSg2CGAWBC?=
 =?us-ascii?q?4s0ghaEI4JXRwICgSwBEgEDM4JxglcCiU6BfZVeMwcChxSHKoMrIJFviWKFB?=
 =?us-ascii?q?YESih0CBAIEBQIUgU0FKw8oMHFwUIJsgicOCRODOIpTQAExiDMPFwOBBYEfA?=
 =?us-ascii?q?QE?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa8.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jan 2019 09:36:51 -0600
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x07FXMw2024234;
        Mon, 7 Jan 2019 10:36:51 -0500
Received: from esa4.dell-outbound2.iphmx.com (esa4.dell-outbound2.iphmx.com [68.232.154.98])
        by mx0b-00154901.pphosted.com with ESMTP id 2pv6bfh97g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 07 Jan 2019 10:36:51 -0500
From:   <Mario.Limonciello@dell.com>
Received: from ausc60pc101.us.dell.com ([143.166.85.206])
  by esa4.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Jan 2019 21:36:50 +0600
X-LoopCount0: from 10.166.132.187
X-IronPort-AV: E=Sophos;i="5.56,451,1539666000"; 
   d="scan'208";a="1344293558"
To:     <jerome.debretagne@gmail.com>, <alex.hung@canonical.com>
CC:     <platform-driver-x86@vger.kernel.org>, <andy@infradead.org>,
        <dvhart@infradead.org>, <rjw@rjwysocki.net>,
        <cwhuang@android-x86.org>, <tristian.celestin@outlook.com>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] platform/x86: intel-hid: Missing power button release on
 some Dell models
Thread-Topic: [PATCH] platform/x86: intel-hid: Missing power button release on
 some Dell models
Thread-Index: AQHUpelHFZhnag+VV02c4tD1P+suiKWj8a8A
Date:   Mon, 7 Jan 2019 15:36:48 +0000
Message-ID: <057ab73bef634b4f8c474924eb6db572@ausx13mpc120.AMER.DELL.COM>
References: <20190106175644.24872-1-jerome.debretagne@gmail.com>
In-Reply-To: <20190106175644.24872-1-jerome.debretagne@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-07_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901070136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogcGxhdGZvcm0tZHJpdmVy
LXg4Ni1vd25lckB2Z2VyLmtlcm5lbC5vcmcgPHBsYXRmb3JtLWRyaXZlci14ODYtDQo+IG93bmVy
QHZnZXIua2VybmVsLm9yZz4gT24gQmVoYWxmIE9mIErDqXLDtG1lIGRlIEJyZXRhZ25lDQo+IFNl
bnQ6IFN1bmRheSwgSmFudWFyeSA2LCAyMDE5IDExOjU3IEFNDQo+IFRvOiBBbGV4IEh1bmcNCj4g
Q2M6IHBsYXRmb3JtLWRyaXZlci14ODZAdmdlci5rZXJuZWwub3JnOyBBbmR5IFNoZXZjaGVua287
IERhcnJlbiBIYXJ0Ow0KPiBMaW1vbmNpZWxsbywgTWFyaW87IFJhZmFlbCBKLiBXeXNvY2tpOyBD
aGloLVdlaSBIdWFuZzsgVHJpc3RpYW4gQ2VsZXN0aW47IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5r
ZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSF0gcGxhdGZvcm0veDg2OiBpbnRlbC1oaWQ6IE1p
c3NpbmcgcG93ZXIgYnV0dG9uIHJlbGVhc2Ugb24gc29tZQ0KPiBEZWxsIG1vZGVscw0KPiANCj4g
DQo+IFtFWFRFUk5BTCBFTUFJTF0NCj4gDQo+IFBvd2VyIGJ1dHRvbiBzdXNwZW5kIGZvciBzb21l
IERlbGwgbW9kZWxzIHdhcyBhZGRlZCBpbjoNCj4gDQo+IGNvbW1pdCA4MjFiODUzNjYyODQgKGlu
dGVsLWhpZDogUG93ZXIgYnV0dG9uIHN1c3BlbmQgb24gRGVsbCBMYXRpdHVkZSA3Mjc1KQ0KPiAN
Cj4gYnkgY2hlY2tpbmcgYWdhaW5zdCB0aGUgcG93ZXIgYnV0dG9uIHByZXNzIG5vdGlmaWNhdGlv
biAoMHhDRSkgdG8gcmVwb3J0DQo+IHRoZSBwb3dlciBidXR0b24gcHJlc3MgZXZlbnQuIFRoZSBj
b3JyZXNwb25kaW5nIHBvd2VyIGJ1dHRvbiByZWxlYXNlDQo+IG5vdGlmaWNhdGlvbiAoMHhDRikg
d2FzIGNhdWdodCBhbmQgaWdub3JlZCB0byBzdG9wIGl0IGZyb20gYmVpbmcgcmVwb3J0ZWQNCj4g
YXMgYW4gInVua25vd24gZXZlbnQiIGluIHRoZSBsb2dzLg0KPiANCj4gVGhlIG1pc3NpbmcgYnV0
dG9uIHJlbGVhc2UgZXZlbnQgaXMgY3JlYXRpbmcgaXNzdWVzIG9uIEFuZHJvaWQteDg2LCBhcw0K
PiByZXBvcnRlZCBvbiB0aGUgcHJvamVjdCBtYWlsaW5nIGxpc3QgZm9yIGEgRGVsbCBMYXRpdHVk
ZSA1MTc1IG1vZGVsLCBzaW5jZQ0KPiB0aGUgZXZlbnRzIGFyZSBleHBlY3RlZCBpbiBkb3duL3Vw
IHBhaXJzLg0KPiANCj4gUmVwb3J0IHRoZSBwb3dlciBidXR0b24gcmVsZWFzZSBldmVudCB0byBm
aXggdGhpcyBpc3N1ZS4NCj4gDQo+IExpbms6IGh0dHBzOi8vZ3JvdXBzLmdvb2dsZS5jb20vZm9y
dW0vIyF0b3BpYy9hbmRyb2lkLXg4Ni9hU3daSzlOZjlSbw0KPiBUZXN0ZWQtYnk6IFRyaXN0aWFu
IENlbGVzdGluIDx0cmlzdGlhbi5jZWxlc3RpbkBvdXRsb29rLmNvbT4NCj4gVGVzdGVkLWJ5OiBK
w6lyw7RtZSBkZSBCcmV0YWduZSA8amVyb21lLmRlYnJldGFnbmVAZ21haWwuY29tPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBKw6lyw7RtZSBkZSBCcmV0YWduZSA8amVyb21lLmRlYnJldGFnbmVAZ21haWwu
Y29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsLWhpZC5jIHwgNyArKysr
Ky0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsLWhpZC5jIGIvZHJp
dmVycy9wbGF0Zm9ybS94ODYvaW50ZWwtaGlkLmMNCj4gaW5kZXggZTI4YmNmNjFiMTI2Li5iYzBk
NTVhNTkwMTUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsLWhpZC5j
DQo+ICsrKyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsLWhpZC5jDQo+IEBAIC0zNjMsNyAr
MzYzLDcgQEAgc3RhdGljIHZvaWQgbm90aWZ5X2hhbmRsZXIoYWNwaV9oYW5kbGUgaGFuZGxlLCB1
MzIgZXZlbnQsDQo+IHZvaWQgKmNvbnRleHQpDQo+ICAJICogdGhlIDUtYnV0dG9uIGFycmF5LCBi
dXQgc3RpbGwgc2VuZCBub3RpZmllcyB3aXRoIHBvd2VyIGJ1dHRvbg0KPiAgCSAqIGV2ZW50IGNv
ZGUgdG8gdGhpcyBkZXZpY2Ugb2JqZWN0IG9uIHBvd2VyIGJ1dHRvbiBhY3Rpb25zLg0KPiAgCSAq
DQo+IC0JICogUmVwb3J0IHRoZSBwb3dlciBidXR0b24gcHJlc3M7IGNhdGNoIGFuZCBpZ25vcmUg
dGhlIGJ1dHRvbiByZWxlYXNlLg0KPiArCSAqIFJlcG9ydCB0aGUgcG93ZXIgYnV0dG9uIHByZXNz
IGFuZCByZWxlYXNlLg0KPiAgCSAqLw0KPiAgCWlmICghcHJpdi0+YXJyYXkpIHsNCj4gIAkJaWYg
KGV2ZW50ID09IDB4Y2UpIHsNCj4gQEAgLTM3Miw4ICszNzIsMTEgQEAgc3RhdGljIHZvaWQgbm90
aWZ5X2hhbmRsZXIoYWNwaV9oYW5kbGUgaGFuZGxlLCB1MzIgZXZlbnQsDQo+IHZvaWQgKmNvbnRl
eHQpDQo+ICAJCQlyZXR1cm47DQo+ICAJCX0NCj4gDQo+IC0JCWlmIChldmVudCA9PSAweGNmKQ0K
PiArCQlpZiAoZXZlbnQgPT0gMHhjZikgew0KPiArCQkJaW5wdXRfcmVwb3J0X2tleShwcml2LT5p
bnB1dF9kZXYsIEtFWV9QT1dFUiwgMCk7DQo+ICsJCQlpbnB1dF9zeW5jKHByaXYtPmlucHV0X2Rl
dik7DQo+ICAJCQlyZXR1cm47DQo+ICsJCX0NCj4gIAl9DQo+IA0KPiAgCS8qIDB4QzAgaXMgZm9y
IEhJRCBldmVudHMsIG90aGVyIHZhbHVlcyBhcmUgZm9yIDUgYnV0dG9uIGFycmF5ICovDQo+IC0t
DQo+IDIuMTEuMA0KDQpSZXZpZXdlZC1ieTogTWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9u
Y2llbGxvQGRlbGwuY29tPg0K
