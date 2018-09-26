Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB60C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA70420843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="l840kU/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA70420843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeIZVEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:04:04 -0400
Received: from esa7.dell-outbound.iphmx.com ([68.232.153.96]:58398 "EHLO
        esa7.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726994AbeIZVEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1537973440; x=1569509440;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+4ypBBY0nEEzNWnwXRJ8RIPi91GaXzOhN1bD7y+3csY=;
  b=l840kU/nJjEfxtH8CwYCPnk7uCwKiO6+mY95qDDUnCfUMuqpWH6xOVoK
   Q1iUbK6kGQm6AprsZjF+gK9vGP+UDPMimeqgdJ0BXaYlMdumZe+u0ZWHN
   zKttdkNLrXvPZRuDCE6uZYohhGir9efu0cIEuzQpeqfz9P5OVHP1kJsku
   s=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EzAABYnKtbhyWd50NaGwEBAQEDAQE?=
 =?us-ascii?q?BBwMBAQGBUYJzfygKg2qIFV+LUoINgz2FIY1xgXoLGAsLhD4CF4NnITQYAQM?=
 =?us-ascii?q?BAQIBAQIBAQIQAQEBCgsJCCkjDII1IhGBCQEBAQEBAQEBAU0CDWMBAQEBAgE?=
 =?us-ascii?q?BEREROgsFCwIBCBUDAgImAgICHwcfEAIEAQ0FCBqCfwGBaQMNCA+YXIlXAQE?=
 =?us-ascii?q?BbYEuhzgNgkwFgQuJcIIXhCSCVkUDhGGCVwKINpQlLAcCjClqgxIfgUaEUok?=
 =?us-ascii?q?cK4hFg3qIAAIEAgQFAhSBQoIOcIM8giUOCYgfhXlvAYwkgR4BAQ?=
X-IPAS-Result: =?us-ascii?q?A2EzAABYnKtbhyWd50NaGwEBAQEDAQEBBwMBAQGBUYJzf?=
 =?us-ascii?q?ygKg2qIFV+LUoINgz2FIY1xgXoLGAsLhD4CF4NnITQYAQMBAQIBAQIBAQIQA?=
 =?us-ascii?q?QEBCgsJCCkjDII1IhGBCQEBAQEBAQEBAU0CDWMBAQEBAgEBEREROgsFCwIBC?=
 =?us-ascii?q?BUDAgImAgICHwcfEAIEAQ0FCBqCfwGBaQMNCA+YXIlXAQEBbYEuhzgNgkwFg?=
 =?us-ascii?q?QuJcIIXhCSCVkUDhGGCVwKINpQlLAcCjClqgxIfgUaEUokcK4hFg3qIAAIEA?=
 =?us-ascii?q?gQFAhSBQoIOcIM8giUOCYgfhXlvAYwkgR4BAQ?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa7.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Sep 2018 09:50:33 -0500
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8QEltEd012004;
        Wed, 26 Sep 2018 10:50:36 -0400
Received: from esa2.dell-outbound2.iphmx.com (esa2.dell-outbound2.iphmx.com [68.232.153.202])
        by mx0b-00154901.pphosted.com with ESMTP id 2mr9aeh42x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Sep 2018 10:50:36 -0400
From:   <Mario.Limonciello@dell.com>
Received: from ausc60ps301.us.dell.com ([143.166.148.206])
  by esa2.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 26 Sep 2018 20:50:24 +0600
X-LoopCount0: from 10.166.132.152
X-IronPort-AV: E=Sophos;i="5.54,306,1534827600"; 
   d="scan'208";a="1199603124"
To:     <andy.shevchenko@gmail.com>, <stuart.w.hayes@gmail.com>
CC:     <dvhart@infradead.org>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH 0/5] Update and move Dell drivers dell_rbu and dcdbas
Thread-Topic: [PATCH 0/5] Update and move Dell drivers dell_rbu and dcdbas
Thread-Index: AQHUVQbIAkOKMlqYGEi5wPk0PAlAR6UCuxoA///ppiA=
Date:   Wed, 26 Sep 2018 14:50:32 +0000
Message-ID: <2c21dba5f4074bc0861277ec5701d2ff@ausx13mpc120.AMER.DELL.COM>
References: <20180925193418.28493-1-stuart.hayes@dell.com>
 <CAHp75Ve=ZnkBbdG3Myu1qzubr6+q74Q0u9pR7+nHXG=yAO-0rA@mail.gmail.com>
In-Reply-To: <CAHp75Ve=ZnkBbdG3Myu1qzubr6+q74Q0u9pR7+nHXG=yAO-0rA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=757 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809260144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBUdWUsIFNlcCAyNSwgMjAxOCBhdCAxMDozNCBQTSBTdHVhcnQgSGF5ZXMgPHN0dWFydC53
LmhheWVzQGdtYWlsLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBTdHVhcnQgSGF5ZXMg
PHN0dWFydC53LmhheWVzQGdtYWlsLmNvbT4NCj4gPg0KPiA+IFRoZSBkZWxsX3JidSBhbmQgZGNk
YmFzIGRyaXZlcnMgbmVlZCBzb21lIGNoYW5nZXMsIGFuZCBzaG91bGQgYmUgbW92ZWQgdG8NCj4g
PiBkcml2ZXJzL3BsYXRmb3JtL3g4Ni4gIEFkZGl0aW9uYWxseSwgZGVsbF9yYnUgbmVlZHMgYSBt
YWludGFpbmVyLCBhbmQgdGhlDQo+ID4gbGlzdGVkIG1haW50YWluZXIgZm9yIGRjZGJhcyBpcyBp
bmFjdGl2ZSBhbmQgbmVlZHMgdG8gYmUgY2hhbmdlZC4NCj4gDQo+IEkgcHVzaGVkIHRoaXMgc2Vy
aWVzIHRvIG15IHJldmlldyBhbmQgdGVzdGluZyBxdWV1ZSB0byBhbGxvdyBib3RzIHBsYXkgd2l0
aC4NCj4gDQo+IEJ1dC4NCj4gUGxlYXNlLCBhZGQgY29tbWl0IG1lc3NhZ2VzIHRvIHBhdGNoZXMg
NCBhbmQgNSAoSSBjYW4ndCB0YWtlIHcvbyB0aGVtKS4NCj4gQ29sbGVjdCBEb3VnJ3MgdGFnIHRo
YXQgcHJvdmVzIGhlIGlzIG9rYXkgd2l0aCB0aGUgY2hhbmdlIChJIHJlbWVtYmVyDQo+IGhlIGFu
c3dlcmVkIHNvbWV0aGluZyB0byB0aGUgb2xkIHRocmVhZCwgdGhvdWdoIEkgZG9uJ3QgcmVtZW1i
ZXIgdGhlDQo+IGRldGFpbHMgZXhjZXB0IGFubm95aW5nIGZvb3RlciB3aGljaCBzaG91bGQgbm90
IGJlIHVwIGluIG9wZW4gc291cmNlDQo+IG1haWxpbmcgbGlzdHMpLg0KPiANCj4gU28sIHdoaWxl
IGJvdHMgYXJlIHBsYXlpbmcgd2l0aCB0aGUgY29kZSBJJ20gd2FpdGluZyBmb3IgdjIgb2YgdGhp
cw0KPiB3aXRoIGFib3ZlIGFkZHJlc3NlZC4NCj4gVGhhbmtzIQ0KPiANCg0KSnVzdCBzbyBpdCdz
IGV4dHJhIGNsZWFyLCB5b3Ugd2FudCBhbiAiQWNrZWQtYnkiIHRhZyBmcm9tIERvdWcgVyBpbiBh
IHB1YmxpYw0KZm9ydW0/ICBPciBoZSBzaG91bGQgYmUgQ0MgdG8gdGhhdCBwYXRjaCBhbmQgbmVl
ZHMgdG8gZ2l2ZSB0aGUgYWNrZWQtYnkNCnRhZyBpbiB0aGUgVjI/DQoNCkhlIGFscmVhZHkgZGlk
IHJlc3BvbmQgaW4gYSBwdWJsaWMgZm9ydW0gaW5kaWNhdGluZyB0aGlzIGFsdGhvdWdoIGhlIGRp
ZG4ndA0KImdlbmVyYXRlIGEgdGFnIiBmb3IgdGhhdDoNCmh0dHBzOi8vd3d3LnNwaW5pY3MubmV0
L2xpc3RzL3BsYXRmb3JtLWRyaXZlci14ODYvbXNnMTYzMzYuaHRtbA0KDQpDYW4gU3R1YXJ0IGp1
c3QgYWRkIHRoZSAiQWNrZWQtYnkiIHRhZyBoaW1zZWxmIHRvIHRoZSBjb21taXQgaW4gVjIgYXQg
dGhpcw0KcG9pbnQgY29uc2lkZXJpbmcgdGhhdD8gIE9yIGRvIHlvdSBuZWVkIHBhdGNod29yayB0
byBwaWNrIGl0IHVwIGFuZCBhcHBseSBpdD8NCg0K
