Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72E8C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653CE217B8
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 653CE217B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=jd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbeHIJzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 05:55:21 -0400
Received: from smtp.jd.com ([58.83.206.59]:39915 "EHLO smtp.jd.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727237AbeHIJzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 05:55:21 -0400
Received: from HUB07.360buyAD.local (172.17.27.60) by hub04.360buyAD.local
 (172.17.27.18) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 9 Aug
 2018 15:31:25 +0800
Received: from MBX50.360buyAD.local ([fe80::68b4:4f43:ee1:1711]) by
 HUB07.360buyAD.local ([fe80::28df:5a5c:9366:bc40%12]) with mapi id
 14.03.0382.000; Thu, 9 Aug 2018 15:31:12 +0800
From:   =?utf-8?B?5YiY56GV54S2?= <liushuoran@jd.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: FUSE: write operations trigger balance_dirty_pages when using
 writeback cache
Thread-Topic: FUSE: write operations trigger balance_dirty_pages when using
 writeback cache
Thread-Index: AdQvsvIPMjEjyAkwQ42padLUm7s59Q==
Date:   Thu, 9 Aug 2018 07:31:12 +0000
Message-ID: <EA52CBCF76D5E04D95BED55B83577BE7A67744@MBX50.360buyAD.local>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.27.83]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmsgeW91IGZvciB0aGUgcHJvbXB0IHJlcGx5Lg0KDQpJIHRyaWVkIHRoaXMgY29uZmlnLCBi
dXQgc3RpbGwgY2FuIGdldCBiYWxhbmNlX2RpcnR5X3BhZ2VzIHRyaWdnZXJlZC4NCg0KW3Jvb3RA
QTAxLVIyMC1JMzEtNzctOFM1RktNMiBleGFtcGxlXSMgc3RhdCAtYyAlZCAvbW50L2Z1c2UvDQo0
Mg0KW3Jvb3RAQTAxLVIyMC1JMzEtNzctOFM1RktNMiBleGFtcGxlXSMgZWNobyAyMCA+IC9zeXMv
ZGV2aWNlcy92aXJ0dWFsL2JkaS8wOmBzdGF0IC1jICVkIC9tbnQvZnVzZS9gL21heF9yYXRpbw0K
W3Jvb3RAQTAxLVIyMC1JMzEtNzctOFM1RktNMiBleGFtcGxlXSMgY2F0IC9zeXMvZGV2aWNlcy92
aXJ0dWFsL2JkaS8wXDo0Mi9tYXhfcmF0aW8gDQoyMA0KW3Jvb3RAQTAxLVIyMC1JMzEtNzctOFM1
RktNMiBleGFtcGxlXSMgZGQgaWY9L2Rldi96ZXJvIG9mPS9tbnQvZnVzZS90bXAvdGVzdDAwMSBi
cz00ayBjb3VudD0yMDAwMA0KDQouLi4NCmRkLTYzMyAgIFswMDFdIC4uLi4gMjczNDk5LjA4MzA1
OTogYmFsYW5jZV9kaXJ0eV9wYWdlczogYmRpIDA6NDI6IGxpbWl0PTMxODA1NTYgc2V0cG9pbnQ9
Mjc4MjUwMSBkaXJ0eT0zMTAgYmRpX3NldHBvaW50PTAgYmRpX2RpcnR5PTEzIGRpcnR5X3JhdGVs
aW1pdD0zMiB0YXNrX3JhdGVsaW1pdD0wIGRpcnRpZWQ9MSBkaXJ0aWVkX3BhdXNlPTAgcGF1c2Vk
PTAgcGF1c2U9MTQgcGVyaW9kPTE0IHRoaW5rPTEgY2dyb3VwX2lubz0xDQpkZC02MzMgICBbMDAx
XSAuLi4uIDI3MzQ5OS4wOTgwODk6IGJhbGFuY2VfZGlydHlfcGFnZXM6IGJkaSAwOjQyOiBsaW1p
dD0zMTgwNTU2IHNldHBvaW50PTI3ODI1MDEgZGlydHk9MzExIGJkaV9zZXRwb2ludD0wIGJkaV9k
aXJ0eT0xNCBkaXJ0eV9yYXRlbGltaXQ9MzIgdGFza19yYXRlbGltaXQ9MCBkaXJ0aWVkPTEgZGly
dGllZF9wYXVzZT0wIHBhdXNlZD0wIHBhdXNlPTE1IHBlcmlvZD0xNSB0aGluaz0xIGNncm91cF9p
bm89MQ0KZGQtNjMzICAgWzAwMV0gLi4uLiAyNzM0OTkuMTE0MDgyOiBiYWxhbmNlX2RpcnR5X3Bh
Z2VzOiBiZGkgMDo0MjogbGltaXQ9MzE4MDU1NiBzZXRwb2ludD0yNzgyNTAxIGRpcnR5PTMxMiBi
ZGlfc2V0cG9pbnQ9MCBiZGlfZGlydHk9MTUgZGlydHlfcmF0ZWxpbWl0PTMyIHRhc2tfcmF0ZWxp
bWl0PTAgZGlydGllZD0xIGRpcnRpZWRfcGF1c2U9MCBwYXVzZWQ9MCBwYXVzZT0xNiBwZXJpb2Q9
MTYgdGhpbms9MSBjZ3JvdXBfaW5vPTENCi4uLg0KDQoNClJlZ2FyZHMsDQpTaHVvcmFuDQoNCi0t
LS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogTWlrbG9zIFN6ZXJlZGkgW21haWx0bzpt
aWtsb3NAc3plcmVkaS5odV0gDQrlj5HpgIHml7bpl7Q6IDIwMTjlubQ45pyIOeaXpSAxNToxNA0K
5pS25Lu25Lq6OiDliJjnoZXnhLYgPGxpdXNodW9yYW5AamQuY29tPg0K5oqE6YCBOiBsaW51eC1m
c2RldmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K5Li7
6aKYOiBSZTogRlVTRTogd3JpdGUgb3BlcmF0aW9ucyB0cmlnZ2VyIGJhbGFuY2VfZGlydHlfcGFn
ZXMgd2hlbiB1c2luZyB3cml0ZWJhY2sgY2FjaGUNCg0KT24gVGh1LCBBdWcgOSwgMjAxOCBhdCA1
OjM3IEFNLCDliJjnoZXnhLYgPGxpdXNodW9yYW5AamQuY29tPiB3cm90ZToNCj4gRGVhciBNaWts
b3MsDQo+DQo+IFJlY2VudGx5IEkndmUgYmVlbiB0ZXN0aW5nIEZVU0UgYW5kIGxpYmZ1c2UgZXhh
bXBsZSBwYXNzdGhyb3VnaF9sbCB3aXRoIHdyaXRlYmFjayBjYWNoZSBvbiwgYW5kIGZvdW5kIG91
dCB0aGF0IHRoZSBwZXJmb3JtYW5jZSBkcm9wcyBzaWduaWZpY2FudGx5IGNvbXBhcmVkIHRvIHRo
YXQgaW4gbG9jYWwgZmlsZXN5c3RlbS4gQXMgSSBjYW4gc2VlIGZyb20gdHJhY2UsIGJhbGFuY2Vf
ZGlydHlfcGFnZXMgaXMgdHJpZ2dlcmVkIHZlcnkgZnJlcXVlbnRseSBldmVuIGlmIHRoZXJlIG5v
dCBlbm91Z2ggcGFnZXMgdGhhdCBzaGFsbCBiZSBzZW50IHRvIGxpYmZ1c2UuIEknbSBub3Qgc3Vy
ZSBpZiB0aGlzIGlzIGEga25vd24gZmFjdCBvciB0aGUgRlVTRSB3cml0ZWJhY2sgZmVhdHVyZSBy
ZXF1aXJlcyBzb21lIHNwZWNpZmljIGNvbmZpZ3VyYXRpb25zLiBUcmFjZSBsb2cgaXMgYXR0YWNo
ZWQuDQo+DQo+IGRkLTE5MDY3IFswMDFdIC4uLi4gMTk1Mjk1LjU2ODA5NzogYmFsYW5jZV9kaXJ0
eV9wYWdlczogYmRpIDA6NDI6IGxpbWl0PTMxODAzOTAgc2V0cG9pbnQ9Mjc4MjQyMSBkaXJ0eT01
IGJkaV9zZXRwb2ludD0wIGJkaV9kaXJ0eT0zMiBkaXJ0eV9yYXRlbGltaXQ9MzIgdGFza19yYXRl
bGltaXQ9MCBkaXJ0aWVkPTMyIGRpcnRpZWRfcGF1c2U9MzIgcGF1c2VkPTAgcGF1c2U9MzMgcGVy
aW9kPTMzIHRoaW5rPTAgY2dyb3VwX2lubz0xDQo+IGRkLTE5MDY3IFswMDFdIC4uLi4gMTk1Mjk1
LjYwMjAyOTogYmFsYW5jZV9kaXJ0eV9wYWdlczogYmRpIDA6NDI6IGxpbWl0PTMxODAzOTAgc2V0
cG9pbnQ9Mjc4MjQyMSBkaXJ0eT01IGJkaV9zZXRwb2ludD0wIGJkaV9kaXJ0eT0zMyBkaXJ0eV9y
YXRlbGltaXQ9MzIgdGFza19yYXRlbGltaXQ9MCBkaXJ0aWVkPTEgZGlydGllZF9wYXVzZT0wIHBh
dXNlZD0wIHBhdXNlPTM0IHBlcmlvZD0zNCB0aGluaz0xIGNncm91cF9pbm89MQ0KPiBkZC0xOTA2
NyBbMDAxXSAuLi4uIDE5NTI5NS42MzcwMjY6IGJhbGFuY2VfZGlydHlfcGFnZXM6IGJkaSAwOjQy
OiBsaW1pdD0zMTgwMzkwIHNldHBvaW50PTI3ODI0MjEgZGlydHk9NSBiZGlfc2V0cG9pbnQ9MCBi
ZGlfZGlydHk9MzQgZGlydHlfcmF0ZWxpbWl0PTMyIHRhc2tfcmF0ZWxpbWl0PTAgZGlydGllZD0x
IGRpcnRpZWRfcGF1c2U9MCBwYXVzZWQ9MCBwYXVzZT0zNSBwZXJpb2Q9MzUgdGhpbms9MSBjZ3Jv
dXBfaW5vPTENCj4NCj4gQlRXLCBJJ20gdXNpbmcgTGludXgga2VybmVsIDQuMTcuMTIgYW5kIGxp
YmZ1c2UgMy4yLjUuIExvb2sgZm9yd2FyZCB0byBoZWFyaW5nIGZyb20geW91LiBUaGFua3MgaW4g
YWR2YW5jZS4NCg0KVHJ5DQoNCiAgIGVjaG8gMjAgPiAvc3lzL2RldmljZXMvdmlydHVhbC9iZGkv
MDpgc3RhdCAtYyAlZCAvbW50L2Z1c2UvYC9tYXhfcmF0aW8NCg0Kd2hlcmUgeW91IHJlcGxhY2Ug
L21udC9mdXNlIHdpdGggeW91ciBtb3VudHBvaW50Lg0KDQpUaGFua3MsDQpNaWtsb3MNCg==
