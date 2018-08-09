Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C852C46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 03:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D472321C1A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 03:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D472321C1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=jd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeHIGIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 02:08:18 -0400
Received: from smtp.jd.com ([58.83.206.59]:46090 "EHLO smtp.jd.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbeHIGIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 02:08:18 -0400
X-Greylist: delayed 350 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Aug 2018 02:08:17 EDT
Received: from HUB08.360buyAD.local (172.17.27.61) by hub04.360buyAD.local
 (172.17.27.18) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 9 Aug
 2018 11:39:06 +0800
Received: from MBX50.360buyAD.local ([fe80::68b4:4f43:ee1:1711]) by
 HUB08.360buyAD.local ([fe80::7809:2d70:1d98:43cc%13]) with mapi id
 14.03.0382.000; Thu, 9 Aug 2018 11:37:56 +0800
From:   =?gb2312?B?wfXLtsi7?= <liushuoran@jd.com>
To:     "miklos@szeredi.hu" <miklos@szeredi.hu>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: FUSE: write operations trigger balance_dirty_pages when using
 writeback cache
Thread-Topic: FUSE: write operations trigger balance_dirty_pages when using
 writeback cache
Thread-Index: AdQvkNaTV7KWB3gJTkiAu46LKXq/Nw==
Date:   Thu, 9 Aug 2018 03:37:56 +0000
Message-ID: <EA52CBCF76D5E04D95BED55B83577BE7A6770F@MBX50.360buyAD.local>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.27.83]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBNaWtsb3MsDQoNClJlY2VudGx5IEkndmUgYmVlbiB0ZXN0aW5nIEZVU0UgYW5kIGxpYmZ1
c2UgZXhhbXBsZSBwYXNzdGhyb3VnaF9sbCB3aXRoIHdyaXRlYmFjayBjYWNoZSBvbiwgYW5kIGZv
dW5kIG91dCB0aGF0IHRoZSBwZXJmb3JtYW5jZSBkcm9wcyBzaWduaWZpY2FudGx5IGNvbXBhcmVk
IHRvIHRoYXQgaW4gbG9jYWwgZmlsZXN5c3RlbS4gQXMgSSBjYW4gc2VlIGZyb20gdHJhY2UsIGJh
bGFuY2VfZGlydHlfcGFnZXMgaXMgdHJpZ2dlcmVkIHZlcnkgZnJlcXVlbnRseSBldmVuIGlmIHRo
ZXJlIG5vdCBlbm91Z2ggcGFnZXMgdGhhdCBzaGFsbCBiZSBzZW50IHRvIGxpYmZ1c2UuIEknbSBu
b3Qgc3VyZSBpZiB0aGlzIGlzIGEga25vd24gZmFjdCBvciB0aGUgRlVTRSB3cml0ZWJhY2sgZmVh
dHVyZSByZXF1aXJlcyBzb21lIHNwZWNpZmljIGNvbmZpZ3VyYXRpb25zLiBUcmFjZSBsb2cgaXMg
YXR0YWNoZWQuDQoNCmRkLTE5MDY3IFswMDFdIC4uLi4gMTk1Mjk1LjU2ODA5NzogYmFsYW5jZV9k
aXJ0eV9wYWdlczogYmRpIDA6NDI6IGxpbWl0PTMxODAzOTAgc2V0cG9pbnQ9Mjc4MjQyMSBkaXJ0
eT01IGJkaV9zZXRwb2ludD0wIGJkaV9kaXJ0eT0zMiBkaXJ0eV9yYXRlbGltaXQ9MzIgdGFza19y
YXRlbGltaXQ9MCBkaXJ0aWVkPTMyIGRpcnRpZWRfcGF1c2U9MzIgcGF1c2VkPTAgcGF1c2U9MzMg
cGVyaW9kPTMzIHRoaW5rPTAgY2dyb3VwX2lubz0xDQpkZC0xOTA2NyBbMDAxXSAuLi4uIDE5NTI5
NS42MDIwMjk6IGJhbGFuY2VfZGlydHlfcGFnZXM6IGJkaSAwOjQyOiBsaW1pdD0zMTgwMzkwIHNl
dHBvaW50PTI3ODI0MjEgZGlydHk9NSBiZGlfc2V0cG9pbnQ9MCBiZGlfZGlydHk9MzMgZGlydHlf
cmF0ZWxpbWl0PTMyIHRhc2tfcmF0ZWxpbWl0PTAgZGlydGllZD0xIGRpcnRpZWRfcGF1c2U9MCBw
YXVzZWQ9MCBwYXVzZT0zNCBwZXJpb2Q9MzQgdGhpbms9MSBjZ3JvdXBfaW5vPTENCmRkLTE5MDY3
IFswMDFdIC4uLi4gMTk1Mjk1LjYzNzAyNjogYmFsYW5jZV9kaXJ0eV9wYWdlczogYmRpIDA6NDI6
IGxpbWl0PTMxODAzOTAgc2V0cG9pbnQ9Mjc4MjQyMSBkaXJ0eT01IGJkaV9zZXRwb2ludD0wIGJk
aV9kaXJ0eT0zNCBkaXJ0eV9yYXRlbGltaXQ9MzIgdGFza19yYXRlbGltaXQ9MCBkaXJ0aWVkPTEg
ZGlydGllZF9wYXVzZT0wIHBhdXNlZD0wIHBhdXNlPTM1IHBlcmlvZD0zNSB0aGluaz0xIGNncm91
cF9pbm89MQ0KDQpCVFcsIEknbSB1c2luZyBMaW51eCBrZXJuZWwgNC4xNy4xMiBhbmQgbGliZnVz
ZSAzLjIuNS4gTG9vayBmb3J3YXJkIHRvIGhlYXJpbmcgZnJvbSB5b3UuIFRoYW5rcyBpbiBhZHZh
bmNlLg0KDQpSZWdhcmRzLA0KU2h1b3JhbiBMaXUNCg==
