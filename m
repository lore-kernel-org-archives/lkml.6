Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7B1C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5072085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="VzD/3RK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D5072085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389607AbeKGCx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:53:27 -0500
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:19612 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728074AbeKGCx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:53:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1541525233; x=1573061233;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WKUYUstqEQjBki0tDoR+WbQ5hS4xjmXdXVOxTFdTTEI=;
  b=VzD/3RK16tJmdWj9VP1wC5H5o2kb8ZFJpJsFC88JOcKghamVemdcaRwi
   DyFQ+wqrjWeI6HRCXo9oHL/cRUgkEsKI3720jwQSop4HXxdI7S2X9F2/l
   vjNH7xHXvrnhpYmFBBx7iou0IOGmDjuXRuqPwBcfwKIRTd0pm4UFCq2cT
   Q=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FfAAA6zuFbhyeV50NkHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUgYBAQsBg2snCoNsiHeLOYINg0GTbxSBZgsBAYRsAheDQiI1DA0BAwE?=
 =?us-ascii?q?BAgEBAgEBAhABAQEKCwkIKS+CNiKCYwEBAQECARIRBA1FBQsCAQgYAgImAgI?=
 =?us-ascii?q?CRRACBAENBQgagn+BegidAQKBEIlYAQEBbXszii+BC4ptgheBEYMShEsBEgE?=
 =?us-ascii?q?ILoJtglcCgSoBjU2Pa1QGAQKNL4NbIIF4jmwslngCBAIEBQIUgUQBgRtxcIF?=
 =?us-ascii?q?ugU6CJw4JjhxAATGLNYEfgR8BAQ?=
X-IPAS-Result: =?us-ascii?q?A2FfAAA6zuFbhyeV50NkHAEBAQQBAQcEAQGBUgYBAQsBg?=
 =?us-ascii?q?2snCoNsiHeLOYINg0GTbxSBZgsBAYRsAheDQiI1DA0BAwEBAgEBAgEBAhABA?=
 =?us-ascii?q?QEKCwkIKS+CNiKCYwEBAQECARIRBA1FBQsCAQgYAgImAgICRRACBAENBQgag?=
 =?us-ascii?q?n+BegidAQKBEIlYAQEBbXszii+BC4ptgheBEYMShEsBEgEILoJtglcCgSoBj?=
 =?us-ascii?q?U2Pa1QGAQKNL4NbIIF4jmwslngCBAIEBQIUgUQBgRtxcIFugU6CJw4JjhxAA?=
 =?us-ascii?q?TGLNYEfgR8BAQ?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa6.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Nov 2018 11:27:12 -0600
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA6Hu7rU193252;
        Tue, 6 Nov 2018 13:04:15 -0500
Received: from esa5.dell-outbound2.iphmx.com (esa5.dell-outbound2.iphmx.com [68.232.153.203])
        by mx0a-00154901.pphosted.com with ESMTP id 2nk91cam92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 06 Nov 2018 13:04:14 -0500
From:   <Justin.Lee1@Dell.com>
Received: from ausc60pc101.us.dell.com ([143.166.85.206])
  by esa5.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Nov 2018 23:26:48 +0600
X-LoopCount0: from 10.166.135.96
X-IronPort-AV: E=Sophos;i="5.54,472,1534827600"; 
   d="scan'208";a="1322549601"
To:     <sam@mendozajonas.com>, <netdev@vger.kernel.org>
CC:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>
Subject: RE: [PATCH net-next 5/6] net/ncsi: Reset channel state in
 ncsi_start_dev()
Thread-Topic: [PATCH net-next 5/6] net/ncsi: Reset channel state in
 ncsi_start_dev()
Thread-Index: AQHUZpcV/jLZttPJVESchUXzrlpHT6U4CxHwgAPm3ICABZsmMIAA2biAgAC18SA=
Date:   Tue, 6 Nov 2018 17:27:09 +0000
Message-ID: <209ba91aac614acb9dc74df18ff3ed45@AUSX13MPS306.AMER.DELL.COM>
References: <20181018035917.19413-1-sam@mendozajonas.com>
         <20181018035917.19413-6-sam@mendozajonas.com>
         <96158616f0774e3d9fae0e99bb16e605@AUSX13MPS306.AMER.DELL.COM>
         <c4f0fdcc971ca258539899a8b15755b96b2353f5.camel@mendozajonas.com>
         <ea740068c02a47e2a5411f84c61e69b3@AUSX13MPS302.AMER.DELL.COM>
 <de9816e6c9cb31fdae1bb3d4a38da65b8f3a7694.camel@mendozajonas.com>
In-Reply-To: <de9816e6c9cb31fdae1bb3d4a38da65b8f3a7694.camel@mendozajonas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-06_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811060152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIE1vbiwgMjAxOC0xMS0wNSBhdCAxODowMSArMDAwMCwgSnVzdGluLkxlZTFARGVsbC5j
b20gd3JvdGU6DQo+ID4gPiBPbiBUdWUsIDIwMTgtMTAtMzAgYXQgMjE6MjYgKzAwMDAsIEp1c3Rp
bi5MZWUxQERlbGwuY29tIHdyb3RlOg0KPiA+ID4gPiA+ICtpbnQgbmNzaV9yZXNldF9kZXYoc3Ry
dWN0IG5jc2lfZGV2ICpuZCkNCj4gPiA+ID4gPiArew0KPiA+ID4gPiA+ICsJc3RydWN0IG5jc2lf
ZGV2X3ByaXYgKm5kcCA9IFRPX05DU0lfREVWX1BSSVYobmQpOw0KPiA+ID4gPiA+ICsJc3RydWN0
IG5jc2lfY2hhbm5lbCAqbmMsICphY3RpdmU7DQo+ID4gPiA+ID4gKwlzdHJ1Y3QgbmNzaV9wYWNr
YWdlICpucDsNCj4gPiA+ID4gPiArCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ID4gPiA+ID4gKwli
b29sIGVuYWJsZWQ7DQo+ID4gPiA+ID4gKwlpbnQgc3RhdGU7DQo+ID4gPiA+ID4gKw0KPiA+ID4g
PiA+ICsJYWN0aXZlID0gTlVMTDsNCj4gPiA+ID4gPiArCU5DU0lfRk9SX0VBQ0hfUEFDS0FHRShu
ZHAsIG5wKSB7DQo+ID4gPiA+ID4gKwkJTkNTSV9GT1JfRUFDSF9DSEFOTkVMKG5wLCBuYykgew0K
PiA+ID4gPiA+ICsJCQlzcGluX2xvY2tfaXJxc2F2ZSgmbmMtPmxvY2ssIGZsYWdzKTsNCj4gPiA+
ID4gPiArCQkJZW5hYmxlZCA9IG5jLT5tb25pdG9yLmVuYWJsZWQ7DQo+ID4gPiA+ID4gKwkJCXN0
YXRlID0gbmMtPnN0YXRlOw0KPiA+ID4gPiA+ICsJCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZu
Yy0+bG9jaywgZmxhZ3MpOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArCQkJaWYgKGVuYWJsZWQp
DQo+ID4gPiA+ID4gKwkJCQluY3NpX3N0b3BfY2hhbm5lbF9tb25pdG9yKG5jKTsNCj4gPiA+ID4g
PiArCQkJaWYgKHN0YXRlID09IE5DU0lfQ0hBTk5FTF9BQ1RJVkUpIHsNCj4gPiA+ID4gPiArCQkJ
CWFjdGl2ZSA9IG5jOw0KPiA+ID4gPiA+ICsJCQkJYnJlYWs7DQo+ID4gPiA+IA0KPiA+ID4gPiBJ
cyB0aGUgb3JpZ2luYWwgaW50ZW50aW9uIHRvIHByb2Nlc3MgdGhlIGNoYW5uZWwgb25lIGJ5IG9u
ZT8NCj4gPiA+ID4gSWYgaXQgaXMgdGhlIGNhc2UsIHRoZXJlIGFyZSB0d28gbG9vcHMgYW5kIHdl
IG1pZ2h0IG5lZWQgdG8gdXNlDQo+ID4gPiA+ICJnb3RvIGZvdW5kIiBpbnN0ZWFkLg0KPiA+ID4g
DQo+ID4gPiBZZXMgd2UnbGwgbmVlZCB0byBicmVhayBvdXQgb2YgdGhlIHBhY2thZ2UgbG9vcCBo
ZXJlIGFzIHdlbGwuDQo+ID4gPiANCj4gPiA+ID4gPiArCQkJfQ0KPiA+ID4gPiA+ICsJCX0NCj4g
PiA+ID4gPiArCX0NCj4gPiA+ID4gPiArDQo+ID4gPiA+IA0KPiA+ID4gPiBmb3VuZDogPw0KPiA+
ID4gPiANCj4gPiA+ID4gPiArCWlmICghYWN0aXZlKSB7DQo+ID4gPiA+ID4gKwkJLyogRG9uZSAq
Lw0KPiA+ID4gPiA+ICsJCXNwaW5fbG9ja19pcnFzYXZlKCZuZHAtPmxvY2ssIGZsYWdzKTsNCj4g
PiA+ID4gPiArCQluZHAtPmZsYWdzICY9IH5OQ1NJX0RFVl9SRVNFVDsNCj4gPiA+ID4gPiArCQlz
cGluX3VubG9ja19pcnFyZXN0b3JlKCZuZHAtPmxvY2ssIGZsYWdzKTsNCj4gPiA+ID4gPiArCQly
ZXR1cm4gbmNzaV9jaG9vc2VfYWN0aXZlX2NoYW5uZWwobmRwKTsNCj4gPiA+ID4gPiArCX0NCj4g
PiA+ID4gPiArDQo+ID4gPiA+ID4gKwlzcGluX2xvY2tfaXJxc2F2ZSgmbmRwLT5sb2NrLCBmbGFn
cyk7DQo+ID4gPiA+ID4gKwluZHAtPmZsYWdzIHw9IE5DU0lfREVWX1JFU0VUOw0KPiA+ID4gPiA+
ICsJbmRwLT5hY3RpdmVfY2hhbm5lbCA9IGFjdGl2ZTsNCj4gPiA+ID4gPiArCW5kcC0+YWN0aXZl
X3BhY2thZ2UgPSBhY3RpdmUtPnBhY2thZ2U7DQo+ID4gPiA+ID4gKwlzcGluX3VubG9ja19pcnFy
ZXN0b3JlKCZuZHAtPmxvY2ssIGZsYWdzKTsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKwluZC0+
c3RhdGUgPSBuY3NpX2Rldl9zdGF0ZV9zdXNwZW5kOw0KPiA+ID4gPiA+ICsJc2NoZWR1bGVfd29y
aygmbmRwLT53b3JrKTsNCj4gPiA+ID4gPiArCXJldHVybiAwOw0KPiA+ID4gPiA+ICt9DQo+ID4g
PiA+IA0KPiA+ID4gPiBBbHNvIHNpbWlsYXIgaXNzdWUgaW4gbmNzaV9jaG9vc2VfYWN0aXZlX2No
YW5uZWwoKSBmdW5jdGlvbiBiZWxvdy4NCj4gPiA+ID4gDQo+ID4gPiA+ID4gQEAgLTkxNiwzMiAr
MTA0NSw0OSBAQCBzdGF0aWMgaW50IG5jc2lfY2hvb3NlX2FjdGl2ZV9jaGFubmVsKHN0cnVjdCBu
Y3NpX2Rldl9wcml2ICpuZHApDQo+ID4gPiA+ID4gIA0KPiA+ID4gPiA+ICAJCQluY20gPSAmbmMt
Pm1vZGVzW05DU0lfTU9ERV9MSU5LXTsNCj4gPiA+ID4gPiAgCQkJaWYgKG5jbS0+ZGF0YVsyXSAm
IDB4MSkgew0KPiA+ID4gPiA+IC0JCQkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmbmMtPmxvY2ss
IGZsYWdzKTsNCj4gPiA+ID4gPiAgCQkJCWZvdW5kID0gbmM7DQo+ID4gPiA+ID4gLQkJCQlnb3Rv
IG91dDsNCj4gPiA+ID4gPiArCQkJCXdpdGhfbGluayA9IHRydWU7DQo+ID4gPiA+ID4gIAkJCX0N
Cj4gPiA+ID4gPiAgDQo+ID4gPiA+ID4gLQkJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJm5jLT5s
b2NrLCBmbGFncyk7DQo+ID4gPiA+ID4gKwkJCS8qIElmIG11bHRpX2NoYW5uZWwgaXMgZW5hYmxl
ZCBjb25maWd1cmUgYWxsIHZhbGlkDQo+ID4gPiA+ID4gKwkJCSAqIGNoYW5uZWxzIHdoZXRoZXIg
b3Igbm90IHRoZXkgY3VycmVudGx5IGhhdmUgbGluaw0KPiA+ID4gPiA+ICsJCQkgKiBzbyB0aGV5
IHdpbGwgaGF2ZSBBRU5zIGVuYWJsZWQuDQo+ID4gPiA+ID4gKwkJCSAqLw0KPiA+ID4gPiA+ICsJ
CQlpZiAod2l0aF9saW5rIHx8IG5wLT5tdWx0aV9jaGFubmVsKSB7DQo+ID4gPiA+IA0KPiA+ID4g
PiBJIG5vdGljZSB0aGF0IHRoZXJlIGlzIGEgY2FzZSB0aGF0IHdlIHdpbGwgbWlzY29uZmlndXJl
IHRoZSBpbnRlcmZhY2UuDQo+ID4gPiA+IEZvciBleGFtcGxlIGJlbG93LCBtdWx0aS1jaGFubmVs
IGlzIG5vdCBlbmFibGUgZm9yIHBhY2thZ2UgMS4NCj4gPiA+ID4gQnV0IHdlIGVuYWJsZSB0aGUg
Y2hhbm5lbCBmb3IgbmNzaTIgYmVsb3cgKHBhY2thZ2UgMSBjaGFubmVsIDApIGFzIHRoYXQgaW50
ZXJmYWNlIGlzIHRoZSBmaXJzdA0KPiA+ID4gPiBjaGFubmVsIGZvciB0aGF0IHBhY2thZ2Ugd2l0
aCBsaW5rLg0KPiA+ID4gDQo+ID4gPiBJIGRvbid0IHRoaW5rIEkgc2VlIHRoZSBpc3N1ZSBoZXJl
OyBtdWx0aS1jaGFubmVsIGlzIG5vdCBzZXQgb24gcGFja2FnZQ0KPiA+ID4gMSwgYnV0IGJvdGgg
Y2hhbm5lbHMgYXJlIGluIHRoZSBjaGFubmVsIHdoaXRlbGlzdC4gQ2hhbm5lbCAwIGlzDQo+ID4g
PiBjb25maWd1cmVkIHNpbmNlIGl0J3MgdGhlIGZpcnN0IGZvdW5kIG9uIHBhY2thZ2UgMSwgYW5k
IGNoYW5uZWwgMSBpcyBub3QNCj4gPiA+IHNpbmNlIGNoYW5uZWwgMCBpcyBhbHJlYWR5IGZvdW5k
LiBBcmUgeW91IGV4cGVjdGluZyBzb21ldGhpbmcgZGlmZmVyZW50Pw0KPiA+ID4gIA0KPiA+IA0K
PiA+IFRoZSBzZXR0aW5nIGlzIHRoYXQgbXVsdGktcGFja2FnZSBpcyBlbmFibGUgZm9yIGJvdGgg
cGFja2FnZSAwIGFuZCAxLg0KPiA+IE11bHRpLWNoYW5uZWwgaXMgb25seSBlbmFibGVkIGZvciBw
YWNrYWdlIDAuDQo+ID4gDQo+ID4gPiA+IGNhdCAvc3lzL2tlcm5lbC9kZWJ1Zy9uY3NpX3Byb3Rv
Y29sL25jc2lfZGV2aWNlXw0KPiA+ID4gPiBJRklEWCBJRk5BTUUgTkFNRSAgIFBJRCBDSUQgUlgg
VFggTVAgTUMgV1AgV0MgUEMgQ1MgUFMgTFMgUlUgQ1IgTlEgSEENCj4gPiA+ID4gPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09DQo+ID4gPiA+ICAgMiAgIGV0aDIgICBuY3NpMCAgMDAwIDAwMCAxICAxICAxICAxICAxICAx
ICAwICAyICAxICAxICAxICAxICAwICAxDQo+ID4gPiA+ICAgMiAgIGV0aDIgICBuY3NpMSAgMDAw
IDAwMSAxICAwICAxICAxICAxICAxICAwICAyICAxICAxICAxICAxICAwICAxDQo+ID4gPiA+ICAg
MiAgIGV0aDIgICBuY3NpMiAgMDAxIDAwMCAxICAwICAxICAwICAxICAxICAwICAyICAxICAxICAx
ICAxICAwICAxDQo+ID4gDQo+ID4gSSB3YXMgcmVwbHlpbmcgdG8gdGhlIHdyb25nIG9sZCBlbWFp
bCBhbmQgaXQgbWlnaHQgY2F1c2UgYSBiaXQgY29uZnVzaW9uLg0KPiA+IFRoZSBmaXJzdCAxIG1l
YW5pbmcgY2hhbm5lbCBpcyBlbmFibGVkIGZvciBwYWNrYWdlIDEgY2hhbm5lbCAwIChuY3NpMiku
IA0KPiA+IEZvciBldGgyLCB3ZSBhbHJlYWR5IGhhcyBuY3NpMCBhcyB0aGUgYWN0aXZlIGNoYW5u
ZWwgd2l0aCBUWCBlbmFibGUuDQo+ID4gSSB3b3VsZCB0aGluayB0aGF0IHBhY2thZ2UgZG9lc24n
dCBoYXZlIHRoZSBtdWx0aS1jaGFubmVsIGVuYWJsZWQgYW5kDQo+ID4gd2Ugc2hvdWxkIG5vdCBl
bmFibGUgdGhlIGNoYW5uZWwgZm9yIG5jc2kyLiBUaGUgcHJvYmxlbSBpcyB0aGF0IHBhY2thZ2Ug
MSBkb2Vzbid0DQo+ID4gZW5hYmxlIHRoZSBtdWx0aS1jaGFubmVsIGFuZCBpdCBiZWxpZXZlcyBp
dCBuZWVkcyB0byBlbmFibGUgb25lIGNoYW5uZWwgZm9yIGl0cyBwYWNrYWdlIA0KPiA+IGJ1dCBp
dCBkb2Vzbid0IGF3YXJlIHRoYXQgdGhlIG90aGVyIHBhY2thZ2UgYWxyZWFkeSBoYXMgb25lIGFj
dGl2ZSBjaGFubmVsLg0KPiANCj4gQWgsIG1heWJlIHRoZSBjb25mdXNpb24gaGVyZSBpcyB0aGF0
IG11bHRpX2NoYW5uZWwgaXMgYSBwZXItcGFja2FnZQ0KPiBzZXR0aW5nOyBpdCBkZXRlcm1pbmVz
IHdoYXQgYSBwYWNrYWdlIGRvZXMgd2l0aCBpdHMgb3duIGNoYW5uZWxzLg0KPiANCj4gU28geW91
IGhhdmUgcGFja2FnZSAwIHdpdGggbXVsdGktY2hhbm5lbCBlbmFibGVkIHNvIGl0IGVuYWJsZXMg
Y2hhbm5lbHMgMA0KPiAmIDEuDQo+IFRoZW4geW91IGhhdmUgcGFja2FnZSAxIHdpdGhvdXQgbXVs
dGktY2hhbm5lbCBzbyBpdCBlbmFibGVzIG9ubHkgY2hhbm5lbA0KPiAwLg0KPiBUaGVyZSBpcyBz
dGlsbCBvbmx5IG9uZSBUeCBjaGFubmVsIChwYWNrYWdlIDAsIGNoYW5uZWwgMCkuDQo+IA0KPiBE
b2VzIHRoYXQgc291bmQgcmlnaHQsIG9yIGhhdmUgSSBtaXNzZWQgc29tZXRoaW5nPw0KDQpZZXMs
IHlvdSBhcmUgcmlnaHQuIFRoZXJlIGlzIG9ubHkgb25lIFRYIGVuYWJsZWQuIA0KSWYgd2UgY2Fu
IGhvbGQgb2ZmIGEgZmV3IHNlY29uZHMgYmVmb3JlIGFwcGx5aW5nLCB0aGVuIHdlIHdpbGwgbm90
IHNlZSANCnRoZXNlIGNvbmZpZ3VyYXRpb24gY2hhbmdlcyBpbiBiZXR3ZWVuIHRoZSBiYWNrIHRv
IGJhY2sgbmV0bGluayBjb21tYW5kcy4NCg0KVGhhbmtzLCANCkp1c3Rpbg0K
