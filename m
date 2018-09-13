Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50E1C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7502B20839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7502B20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeIMQei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 12:34:38 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:6037 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726886AbeIMQeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 12:34:37 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 4D325D466ADC5;
        Thu, 13 Sep 2018 19:25:31 +0800 (CST)
Received: from DGGEMM507-MBS.china.huawei.com ([169.254.3.21]) by
 DGGEMM405-HUB.china.huawei.com ([10.3.20.213]) with mapi id 14.03.0399.000;
 Thu, 13 Sep 2018 19:25:29 +0800
From:   Nixiaoming <nixiaoming@huawei.com>
To:     Amir Goldstein <amir73il@gmail.com>
CC:     Eric Paris <eparis@parisplace.org>, Robert Love <rlove@rlove.org>,
        "John McCutchan" <john@johnmccutchan.com>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: RE: Is it possible to add pid and comm members to the event
 structure to increase the display of user and thread information?
Thread-Topic: Is it possible to add pid and comm members to the event
 structure to increase the display of user and thread information?
Thread-Index: AdRJmkzwtMeGnSbeRVCa8sLtVjSk6wABGdoAACuOoAA=
Date:   Thu, 13 Sep 2018 11:25:28 +0000
Message-ID: <E490CD805F7529488761C40FD9D26EF12A7A5ADA@dggemm507-mbs.china.huawei.com>
References: <E490CD805F7529488761C40FD9D26EF12A7A1814@dggemm507-mbs.china.huawei.com>
 <CAOQ4uxiQ_Kb9H9z5nCJL0XJGO_2Dn2Z3KtGv2WZHkt-e+vkZ=w@mail.gmail.com>
In-Reply-To: <CAOQ4uxiQ_Kb9H9z5nCJL0XJGO_2Dn2Z3KtGv2WZHkt-e+vkZ=w@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.57.88.168]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBTZXAgMTEsIDIwMTggYXQgMTE6MTIgUE0gQW1pciBHb2xkc3RlaW4gPGFtaXI3M2ls
QGdtYWlsLmNvbT4gd3JvdGU6DQo+T24gVHVlLCBTZXAgMTEsIDIwMTggYXQgOTo1MSBBTSBOaXhp
YW9taW5nIDxuaXhpYW9taW5nQGh1YXdlaS5jb20+IHdyb3RlOg0KPj4NCj4+IElub3RpZnkgYXBp
IGNhbm5vdCBkaXNwbGF5IGluZm9ybWF0aW9uIGFib3V0IHVzZXJzIGFuZCBwcm9jZXNzZXMuDQo+
PiBUaGF0IGlzLCB5b3UgY2FuIG9ubHkga25vdyB0aGF0IHRoZSBmaWxlIGV2ZW50IGlzIGdlbmVy
YXRlZCwgYnV0IHlvdSBkb24ndCBrbm93IHdobyB0cmlnZ2VyZWQgdGhlIGV2ZW50LCB3aGljaCBp
cyBub3QgY29uZHVjaXZlIHRvIGZhdWx0IGxvY2F0aW9uLg0KPj4gSXMgaXQgcG9zc2libGUgdG8g
YWRkIHBpZCBhbmQgY29tbSBtZW1iZXJzIHRvIHRoZSBldmVudCBzdHJ1Y3R1cmUgdG8gaW5jcmVh
c2UgdGhlIGRpc3BsYXkgb2YgdXNlciBhbmQgdGhyZWFkIGluZm9ybWF0aW9uPw0KPj4NCj4NCj4i
SXMgaXQgcG9zc2libGU/IiBpcyBub3QgdGhlIG9ubHkgcmVsZXZhbnQgcXVlc3Rpb24uDQo+SSBz
dXBwb3NlIHlvdXIgcGF0Y2ggY2FuIHNvcnQgb2Ygd29ya3MsIGJ1dCBpdCBleHBvc2VzIGluZm9y
bWF0aW9uIHRvDQo+cG90ZW50aWFsbHkgdW5wcml2ZWxlZ2VkDQo+cHJvY2Vzc2VzLCBldmVuIGV4
cG9zZXMgcGlkIHZhbHVlcyBvdXRzaWRlIG9mIHRoZSBwcm9jZXNzIHBpZCBuYW1lc3BhY2UuDQo+
DQo+V2hpbGUgdGhvc2UgaXNzdWVzIGNvdWxkIGJlIGFkZHJlc3NlZCwgeW91IGNhbid0IGNoYW5n
ZSB0aGUgZm9ybWF0DQo+c3RydWN0IGlub3RpZnlfZXZlbnQNCj53aXRob3V0IGJyZWFraW5nIGV4
aXN0aW5nIGFwcGxpY2F0aW9ucy4NCj4NCkluIG9yZGVyIHRvIGltcHJvdmUgdGhlIGZhdWx0IGxv
Y2F0aW9uIGNhcGFiaWxpdHksIGNhbiB3ZSBtYWtlIGluY29tcGF0aWJsZSBpbnRlcmZhY2UgY2hh
bmdlcz8NCg0KPkkgZ3Vlc3MgeW91IGFyZSBub3QgdXNpbmcgZmFub3RpZnkgQVBJLCB3aGljaCBh
bHJlYWR5IHByb3ZpZGVzIHBpZA0KPmluZm9ybWF0aW9uIChhbGJpZXQgdGdpZCksDQo+YmVjYXVz
ZSBpdCBsYWNrcyBvdGhlciBmdW5jdGlvbmFsaXR5IHRoYXQgeW91IG5lZWQ/IFdoaWNoDQo+ZnVu
Y3Rpb25hbGl0eSBtaWdodCB0aGF0IGJlPw0KPklzIGl0IGRpcmVjdG9yeSBtb2RpZmljYXRpb24g
ZXZlbnRzPw0KPklmIHNvIHRoYW4geW91IG1pZ2h0IGJlIGludGVyZXN0ZWQgaW4gbXkgZWZmb3J0
IHRvIGFkZCBzdXBwb3J0IGZvcg0KPnRob3NlIGV2ZW50cyB0byBmYW5vdGlmeToNCj5odHRwczov
L2dpdGh1Yi5jb20vYW1pcjczaWwvZnNub3RpZnktdXRpbHMvd2lraS9TdXBlci1ibG9jay1yb290
LXdhdGNoDQo+DQpUaGUgZmFub3RpZnkgQVBJIGRvZXMgbm90IHN1cHBvcnQgbW9uaXRvcmluZyBm
aWxlIGRlbGV0aW9uIGV2ZW50cw0KVGhlIGZhbm90aWZ5IEFQSSBzdXBwb3J0cyB0Z2lkIGRpc3Bs
YXksDQpidXQgZm9yIG11bHRpLXRocmVhZGVkIHByb2dyYW1zLA0KaXQgc3RpbGwgY2Fubm90IGFj
Y3VyYXRlbHkgaWRlbnRpZnkgd2hpY2ggdGhyZWFkIHRyaWdnZXJlZCB0aGUgZXZlbnQuDQpDYW4g
SSBtb2RpZnkgdGdpZCB0byBwaWQ/DQotIGV2ZW50LT50Z2lkID0gZ2V0X3BpZCh0YXNrX3RnaWQo
Y3VycmVudCkpOw0KKyBldmVudC0+dGdpZCA9IGdldF9waWQodGFza19waWQoY3VycmVudCkpOw0K
DQo+WW91ciBzdXBwb3J0LCBzaG91bGQgeW91IGNob29zZSB0byBvZmZlciBpdCwgY291bGQgYmUg
aW4gdGhlIGZvcm0gb2YNCj50ZXN0aW5nIHBhdGNoZXMNCj5hbmQvb3IganVzdCBieSBwdXR0aW5n
IGZvcndhcmQgeW91ciB1c2UgY2FzZSBhcyBhbiBleGFtcGxlIGZvciB0aGUNCj5uZWVkIG9mIGFu
IGV4dGVuZGVkDQo+ZmFub3RpZnkgQVBJLg0KPg0KPlRoYW5rcywNCj5BbWlyLg0KPg0KDQpUaGFu
a3MNCg==
