Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD35ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 13:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCC52086B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 13:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DCC52086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbeIOScU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 14:32:20 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6455 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727028AbeIOScT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 14:32:19 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 939F0FBD559DA;
        Sat, 15 Sep 2018 21:13:19 +0800 (CST)
Received: from DGGEMM507-MBS.china.huawei.com ([169.254.3.21]) by
 DGGEMM403-HUB.china.huawei.com ([10.3.20.211]) with mapi id 14.03.0399.000;
 Sat, 15 Sep 2018 21:13:16 +0800
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
Thread-Index: AdRJmkzwtMeGnSbeRVCa8sLtVjSk6wABGdoAACuOoAAAM28tAAB2QDCA
Date:   Sat, 15 Sep 2018 13:13:16 +0000
Message-ID: <E490CD805F7529488761C40FD9D26EF12A7A9301@dggemm507-mbs.china.huawei.com>
References: <E490CD805F7529488761C40FD9D26EF12A7A1814@dggemm507-mbs.china.huawei.com>
 <CAOQ4uxiQ_Kb9H9z5nCJL0XJGO_2Dn2Z3KtGv2WZHkt-e+vkZ=w@mail.gmail.com>
 <E490CD805F7529488761C40FD9D26EF12A7A5ADA@dggemm507-mbs.china.huawei.com>
 <CAOQ4uxjQK_PKAp2WMPewPZzVhE9WGHfuxyQBPcjyJ6xdJ_j7Dw@mail.gmail.com>
In-Reply-To: <CAOQ4uxjQK_PKAp2WMPewPZzVhE9WGHfuxyQBPcjyJ6xdJ_j7Dw@mail.gmail.com>
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

b24gVGh1LCBTZXAgMTMsIDIwMTggYXQgODozMiBQTSBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxA
Z21haWwuY29tPndyb3RlOg0KPk9uIFRodSwgU2VwIDEzLCAyMDE4IGF0IDI6MjUgUE0gTml4aWFv
bWluZyA8bml4aWFvbWluZ0BodWF3ZWkuY29tPiB3cm90ZToNCj4+DQo+PiBPbiBUdWUsIFNlcCAx
MSwgMjAxOCBhdCAxMToxMiBQTSBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPiB3
cm90ZToNCj4+ID5PbiBUdWUsIFNlcCAxMSwgMjAxOCBhdCA5OjUxIEFNIE5peGlhb21pbmcgPG5p
eGlhb21pbmdAaHVhd2VpLmNvbT4gd3JvdGU6DQo+PiA+Pg0KPj4gPj4gSW5vdGlmeSBhcGkgY2Fu
bm90IGRpc3BsYXkgaW5mb3JtYXRpb24gYWJvdXQgdXNlcnMgYW5kIHByb2Nlc3Nlcy4NCj4+ID4+
IFRoYXQgaXMsIHlvdSBjYW4gb25seSBrbm93IHRoYXQgdGhlIGZpbGUgZXZlbnQgaXMgZ2VuZXJh
dGVkLCBidXQgeW91IGRvbid0IGtub3cgd2hvIHRyaWdnZXJlZCB0aGUgZXZlbnQsIHdoaWNoIGlz
IG5vdCBjb25kdWNpdmUgdG8gZmF1bHQgbG9jYXRpb24uDQo+PiA+PiBJcyBpdCBwb3NzaWJsZSB0
byBhZGQgcGlkIGFuZCBjb21tIG1lbWJlcnMgdG8gdGhlIGV2ZW50IHN0cnVjdHVyZSB0byBpbmNy
ZWFzZSB0aGUgZGlzcGxheSBvZiB1c2VyIGFuZCB0aHJlYWQgaW5mb3JtYXRpb24/DQo+PiA+Pg0K
Pj4gPg0KPj4gPiJJcyBpdCBwb3NzaWJsZT8iIGlzIG5vdCB0aGUgb25seSByZWxldmFudCBxdWVz
dGlvbi4NCj4+ID5JIHN1cHBvc2UgeW91ciBwYXRjaCBjYW4gc29ydCBvZiB3b3JrcywgYnV0IGl0
IGV4cG9zZXMgaW5mb3JtYXRpb24gdG8NCj4+ID5wb3RlbnRpYWxseSB1bnByaXZlbGVnZWQNCj4+
ID5wcm9jZXNzZXMsIGV2ZW4gZXhwb3NlcyBwaWQgdmFsdWVzIG91dHNpZGUgb2YgdGhlIHByb2Nl
c3MgcGlkIG5hbWVzcGFjZS4NCj4+ID4NCj4+ID5XaGlsZSB0aG9zZSBpc3N1ZXMgY291bGQgYmUg
YWRkcmVzc2VkLCB5b3UgY2FuJ3QgY2hhbmdlIHRoZSBmb3JtYXQNCj4+ID5zdHJ1Y3QgaW5vdGlm
eV9ldmVudA0KPj4gPndpdGhvdXQgYnJlYWtpbmcgZXhpc3RpbmcgYXBwbGljYXRpb25zLg0KPj4g
Pg0KPj4gSW4gb3JkZXIgdG8gaW1wcm92ZSB0aGUgZmF1bHQgbG9jYXRpb24gY2FwYWJpbGl0eSwg
Y2FuIHdlIG1ha2UgaW5jb21wYXRpYmxlIGludGVyZmFjZSBjaGFuZ2VzPw0KPg0KPk5vdCB1bmxl
c3MgYXBwbGljYXRpb24vc3lzYWRtaW4vZGlzdHJvIG9wdHMtaW4gZm9yIHRoZSBpbmNvbXBhdGli
bGUgY2hhbmdlLg0KPg0KPj4NCj4+ID5JIGd1ZXNzIHlvdSBhcmUgbm90IHVzaW5nIGZhbm90aWZ5
IEFQSSwgd2hpY2ggYWxyZWFkeSBwcm92aWRlcyBwaWQNCj4+ID5pbmZvcm1hdGlvbiAoYWxiaWV0
IHRnaWQpLA0KPj4gPmJlY2F1c2UgaXQgbGFja3Mgb3RoZXIgZnVuY3Rpb25hbGl0eSB0aGF0IHlv
dSBuZWVkPyBXaGljaA0KPj4gPmZ1bmN0aW9uYWxpdHkgbWlnaHQgdGhhdCBiZT8NCj4+ID5JcyBp
dCBkaXJlY3RvcnkgbW9kaWZpY2F0aW9uIGV2ZW50cz8NCj4+ID5JZiBzbyB0aGFuIHlvdSBtaWdo
dCBiZSBpbnRlcmVzdGVkIGluIG15IGVmZm9ydCB0byBhZGQgc3VwcG9ydCBmb3INCj4+ID50aG9z
ZSBldmVudHMgdG8gZmFub3RpZnk6DQo+PiA+aHR0cHM6Ly9naXRodWIuY29tL2FtaXI3M2lsL2Zz
bm90aWZ5LXV0aWxzL3dpa2kvU3VwZXItYmxvY2stcm9vdC13YXRjaA0KPj4gPg0KPj4gVGhlIGZh
bm90aWZ5IEFQSSBkb2VzIG5vdCBzdXBwb3J0IG1vbml0b3JpbmcgZmlsZSBkZWxldGlvbiBldmVu
dHMNCj4NCj5ZZXMsIEkgYW0gd29ya2luZyB0b3dhcmQgdGhhdCBnb2FsLg0KPg0KPj4gVGhlIGZh
bm90aWZ5IEFQSSBzdXBwb3J0cyB0Z2lkIGRpc3BsYXksDQo+PiBidXQgZm9yIG11bHRpLXRocmVh
ZGVkIHByb2dyYW1zLA0KPj4gaXQgc3RpbGwgY2Fubm90IGFjY3VyYXRlbHkgaWRlbnRpZnkgd2hp
Y2ggdGhyZWFkIHRyaWdnZXJlZCB0aGUgZXZlbnQuDQo+PiBDYW4gSSBtb2RpZnkgdGdpZCB0byBw
aWQ/DQo+PiAtIGV2ZW50LT50Z2lkID0gZ2V0X3BpZCh0YXNrX3RnaWQoY3VycmVudCkpOw0KPj4g
KyBldmVudC0+dGdpZCA9IGdldF9waWQodGFza19waWQoY3VycmVudCkpOw0KPj4NCj4NCj5TbyBp
ZiB5b3Ugd291bGQgbGlrZSB0byBjaGFuZ2UgdGhhdCB5b3UgbmVlZCB0byBhZGQgYSBuZXcgZmxh
ZyB0bw0KPmZhbm90aWZ5X2luaXQgKGUuZy4gRkFOX0VWRU5UX0lORk9fVElEKQ0KPm5ldyBhcHBs
aWNhdGlvbnMgdGhhdCB3b3VsZCBvcHQtaW4gZm9yIHRoZSBmbGFnIHdpbGwgZ2V0IHRhc2tfcGlk
KCkNCj53aGlsZSBleGlzdGluZyBhcHBsaWNhdGlvbiB3aWxsIGtlZXAgZ2V0dGluZyB0YXNrX3Rn
aWQoKQ0KPm5ldyBhcHBsaWNhdGlvbnMgd2lsbCBnZXQgLUVJTlZBTCB3aGVuIHBhc3NpbmcgRkFO
X0VWRU5UX0lORk9fVElEDQo+dG8gZmFub3RpZnlfaW5pdCgpIG9uIGFuIG9sZCBrZXJuZWwgYW5k
IHRoZXkgY291bGQgdGhlbiBmYWxsIGJhY2sgdG8gZ2V0dGluZw0KPnRnaWQgaW4gZXZlbnRzIGFu
ZCBiZSBhd2FyZSBvZiB0aGF0IGZhY3QuDQo+DQo+VGhhbmtzLA0KPkFtaXIuDQo+DQoNClRoYW5r
IHlvdSBmb3IgeW91ciBndWlkYW5jZQ0KSSBhbSBtb2RpZnlpbmcgdGhlIGNvZGUgdGVzdCBsb2Nh
bGx5LA0KVGhlIGtlcm5lbCBtb2RlIHNlbGVjdHMgd2hldGhlciB0byBkaXNwbGF5IHRoZSB0aHJl
YWQgaWQgaW5mb3JtYXRpb24gDQphY2NvcmRpbmcgdG8gdGhlIEZBTl9FVkVOVF9JTkZPX1RJRCB0
YWcgd2hlbiBmYW5vdGlmeV9hbGxvY19ldmVudCBpcyBjYWxsZWQgDQp0aGUgdXNlciBtb2RlIHRl
c3QgcHJvZ3JhbSBhZGRzIEZBTl9FVkVOVF9JTkZPX1RJRCB0byB0aGUgZmFub3RpZnlfbWFya2Qg
cGFyYW1ldGVyIG1hc2ssICANCm5vdywgaXQgY2FuIGFjY3VyYXRlbHkgZGlzcGxheSB3aGljaCB0
aHJlYWQgdHJpZ2dlcmVkIHRoZSBldmVudC4NCg0KSSB3aWxsIHNlbmQgdGhlIHBhdGNoIGxhdGVy
LCBwbGVhc2UgaGVscCBtZSB0byByZXZpZXcgaXQNCg0KdGhhbmtzDQo=
