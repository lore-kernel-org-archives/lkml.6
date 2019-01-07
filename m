Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA555C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFB32070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="ja8ipZwO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfAGS2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:28:12 -0500
Received: from esa2.dell-outbound.iphmx.com ([68.232.149.220]:43240 "EHLO
        esa2.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726718AbfAGS2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1546885690; x=1578421690;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iNEXrw+JuciYXpsRk13ts/N2Ysai6OahDymefqbWf5g=;
  b=ja8ipZwOAICRyd+9QszzEDjJkPRspemOTH1DSDCu5gEg1TpsbGf7Zyht
   +ZQBmurAynckRupg8osVShfF2SB3Yfmj2+qqG2wPoCW0iyC7oiZhDRpcI
   V3zqi7iHaY23ckfTZWOUUOQCqUDHygw2bzGMVwI4Uc4NtZMP/ZIVJxtD7
   0=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EmAABLmTNchyWd50NjGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAQGBZYNsJwqDdYh5iwuCDYNFlD6BZwsBAYRsAheBbiI4EgE?=
 =?us-ascii?q?DAQECAQECAQECEAEBARUJCCkvgjoigm8BAQEBAxIREUUMBAIBCBEEAQEBAgI?=
 =?us-ascii?q?mAgICRQgIAgQBDQUIGoMAggKabj0CgW6JBgEBAW6BL4oqgQuLNIIWgRGDEoR?=
 =?us-ascii?q?OARIBNoJxglcCi0uWEQcCkWkgkW+JYpA0AgQCBAUCFIFdIGdxcIM8gjWOJ0A?=
 =?us-ascii?q?BMQGIQ4EfgR8BAQ?=
X-IPAS-Result: =?us-ascii?q?A2EmAABLmTNchyWd50NjGQEBAQEBAQEBAQEBAQcBAQEBA?=
 =?us-ascii?q?QGBZYNsJwqDdYh5iwuCDYNFlD6BZwsBAYRsAheBbiI4EgEDAQECAQECAQECE?=
 =?us-ascii?q?AEBARUJCCkvgjoigm8BAQEBAxIREUUMBAIBCBEEAQEBAgImAgICRQgIAgQBD?=
 =?us-ascii?q?QUIGoMAggKabj0CgW6JBgEBAW6BL4oqgQuLNIIWgRGDEoROARIBNoJxglcCi?=
 =?us-ascii?q?0uWEQcCkWkgkW+JYpA0AgQCBAUCFIFdIGdxcIM8gjWOJ0ABMQGIQ4EfgR8BA?=
 =?us-ascii?q?Q?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa2.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jan 2019 12:28:08 -0600
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x07IMYmd191565;
        Mon, 7 Jan 2019 13:28:07 -0500
Received: from esa2.dell-outbound2.iphmx.com (esa2.dell-outbound2.iphmx.com [68.232.153.202])
        by mx0b-00154901.pphosted.com with ESMTP id 2pv8kesdey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 07 Jan 2019 13:28:07 -0500
From:   <Mario.Limonciello@dell.com>
Received: from ausc60ps301.us.dell.com ([143.166.148.206])
  by esa2.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 08 Jan 2019 00:28:04 +0600
X-LoopCount0: from 10.166.132.172
X-IronPort-AV: E=Sophos;i="5.56,451,1539666000"; 
   d="scan'208";a="1243321372"
To:     <mlord@pobox.com>, <hayeswang@realtek.com>,
        <kai.heng.feng@canonical.com>
CC:     <aatteka@nicira.com>, <davem@davemloft.net>, <greg@kroah.com>,
        <romieu@fr.zoreil.com>, <netdev@vger.kernel.org>,
        <nic_swsd@realtek.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <ryankao@realtek.com>
Subject: RE: r8152: data corruption in various scenarios
Thread-Topic: r8152: data corruption in various scenarios
Thread-Index: AQHUpfQHALXHc6TickGdZTS3BUtrnaWjIfGAgAAA/gCAAG77gIAAZjZAgACH8QD//5wzgA==
Date:   Mon, 7 Jan 2019 18:27:56 +0000
Message-ID: <53c5ebc06e454ed38a8254acbbabaa68@ausx13mpc120.AMER.DELL.COM>
References: <ed0c9790-57be-8bca-cdd6-3a54ca24f0bd@pobox.com>
 <20161125095350.GA20653@kroah.com>
 <1816ec7e-2733-f4ba-5d30-29dbabd20aad@pobox.com>
 <20161125.115827.2014848246966159357.davem@davemloft.net>
 <0835B3720019904CB8F7AA43166CEEB201057793@RTITMBSV03.realtek.com.tw>
 <CAA=3Oqn5_5w+vrg9_7UtZ-5BEbZ9Pm=qdX3WoVZKaAkxcMXYXA@mail.gmail.com>
 <469a41ea-e97c-23d2-d129-68aad5585fec@pobox.com>
 <3D7273C4-D378-42D5-92FA-4ED72041D820@canonical.com>
 <1726a1ef-cfa7-0f97-4388-bf2ba72cb9a9@pobox.com>
 <31f145b8-4518-122c-eab8-50ed1075ba55@pobox.com>
 <0835B3720019904CB8F7AA43166CEEB2D38781F2@RTITMBSVM03.realtek.com.tw>
 <92e9ddd8a05a493bbb1f5ac4828c2f2a@ausx13mpc120.AMER.DELL.COM>
 <0e7fce67-a88e-4245-ae4e-c218bfbea12f@pobox.com>
In-Reply-To: <0e7fce67-a88e-4245-ae4e-c218bfbea12f@pobox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-07_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901070157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJrIExvcmQgPG1sb3JkQHBv
Ym94LmNvbT4NCj4gU2VudDogTW9uZGF5LCBKYW51YXJ5IDcsIDIwMTkgMTI6MDYgUE0NCj4gVG86
IExpbW9uY2llbGxvLCBNYXJpbzsgaGF5ZXN3YW5nQHJlYWx0ZWsuY29tOyBrYWkuaGVuZy5mZW5n
QGNhbm9uaWNhbC5jb20NCj4gQ2M6IGFhdHRla2FAbmljaXJhLmNvbTsgZGF2ZW1AZGF2ZW1sb2Z0
Lm5ldDsgZ3JlZ0Brcm9haC5jb207DQo+IHJvbWlldUBmci56b3JlaWwuY29tOyBuZXRkZXZAdmdl
ci5rZXJuZWwub3JnOyBuaWNfc3dzZEByZWFsdGVrLmNvbTsgbGludXgtDQo+IGtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7IHJ5YW5rYW9AcmVhbHRlay5j
b20NCj4gU3ViamVjdDogUmU6IHI4MTUyOiBkYXRhIGNvcnJ1cHRpb24gaW4gdmFyaW91cyBzY2Vu
YXJpb3MNCj4gDQo+IA0KPiBbRVhURVJOQUwgRU1BSUxdDQo+IA0KPiBPbiAyMDE5LTAxLTA3IDEx
OjAxIGEubS4sIE1hcmlvLkxpbW9uY2llbGxvQGRlbGwuY29tIHdyb3RlOg0KPiA+DQo+ID4gVEIx
NiBjb250YWlucyBBU01lZGlhIGhvc3QgY29udHJvbGxlci4gIEl0J3MgYSBUaHVuZGVyYm9sdCBk
b2NrIGFuZCBhbGwgVVNCDQo+IGRldmljZXMNCj4gPiBhcmUgY29ubmVjdGVkIHRvIEFTTWVkaWEg
aG9zdCBjb250cm9sbGVyIGluIHRoZSBkb2NrLg0KPiA+DQo+ID4gV0QxNSBkb2VzIG5vdCBjb250
YWluIGFuIEFTTWVkaWEgaG9zdCBjb250cm9sbGVyLCBpdCBjb25uZWN0ZWQgdG8gc3lzdGVtJ3MN
Cj4gPiBVU0IgaG9zdCBjb250cm9sbGVyLg0KPiANCj4gDQo+IFRoYW5rLXlvdSwgTWFyaW8uDQo+
IA0KPiBTby4uIHdoeSBhcmUgd2UgZW5hYmxpbmcgdGhlIHI4MTUzIChVU0ItZXRoZXJuZXQpIHdv
cmthcm91bmQgb24gdGhpcyBXRDE1DQo+IGRvY2s/DQo+IFRoZSBkaXNjdXNzaW9uIGJhY2sgaW4g
MjAxNyB3YXMgdGhhdCBvbmx5IHRoZSBUQjE1L1RCMTYgd2VyZSBhZmZlY3RlZCBieQ0KPiB0aGUg
WEhDSSBvdmVycnVucyBpdCBwcm9kdWNlcz8NCj4gDQo+IC0tDQoNClRoZSB4SENJIG92ZXJydW4g
d29ya2Fyb3VuZCBzaG91bGQgb25seSBiZSBhcHBsaWVkIG9uIFRCMTYvVEIxNiwgY29ycmVjdC4N
Cg0KQ2FuIHlvdSBkb3VibGUgY2hlY2sgdGhlIHZlcmJvc2UgaW5mb3JtYXRpb24gZnJvbSBsc3Vz
YiBmb3IgdGhlIHI4MTUzIGRldmljZQ0Kb24geW91ciBXRDE1Pw0KDQpJIGp1c3QgZG91YmxlIGNo
ZWNrZWQgb24gbXkgb24gaGFuZCBXRDE1IHdpdGggYW4gWFBTIDkzODAgYW5kIGl0J3Mgbm90IGFj
dGl2YXRpbmcgdGhlDQpxdWlyayAoYmNkRGV2aWNlIHdhcyBkaWZmZXJlbnQpLg0KDQpJZiBpdCdz
IHRoZSBzYW1lIGluZm9ybWF0aW9uIGFzIHRoZSBUQjE2ICh3aGljaCBpdCBzb3VuZHMgbGlrZSBp
dCBpcykgS2FpIEhlbmcgYW5kIEkgd2lsbCBjaGVjaw0KYXJvdW5kIGludGVybmFsbHkgdG8gZmlu
ZCBvdXQgd2h5IHRoZXkncmUgbG9va2luZyB0aGUgc2FtZS4NCg0KSSBjYW4gaHlwb3RoZXNpemUg
YSBmZXcgZ3Vlc3NlcyBvZiB3aGF0IGhhcHBlbmVkLg0KTXkgZmlyc3QgZ3Vlc3Mgd291bGQgYmUg
YSBjb21wYXJpc29uIGlzc3VlIHdpdGggdGhlIGxvZ2ljIGluIDE3NmViNjE0Yi4NCg0KTG9va2lu
ZyBhdCB0aGF0IGNvbW1pdCwgSSBndWVzcyBJIHdvdWxkIGFzayBvbiB0aGUgY29tcGlsZXIgYmVo
YXZpb3Igb2YgIXN0cmNtcCgpLg0KV291bGQgdGhhdCBiZSBtYXRjaGluZyB0aGUgbGVzcyB0aGFu
IGNhc2UgYXMgd2VsbCBhcyB0aGUgemVybyBjYXNlPw0KSWYgc28sIGl0IG1pZ2h0IG5lZWQgdG8g
YmUgY2hhbmdlZCB0byBzdHJjbXAoKSA9PSAwLg0KDQpNeSBzZWNvbmQgZ3Vlc3Mgd291bGQgYmUg
bWF5YmUgbmV3ZXIgZXRoZXJuZXQgTlZNIGluIG1hbnVmYWN0dXJpbmcuDQpNeSB0aGlyZCBndWVz
cyB3b3VsZCBiZSBhIG1hbnVmYWN0dXJpbmcgaXNzdWUgcHV0dGluZyB3cm9uZyBOVk0gaW1hZ2Ug
b24geW91ciBXRDE1Lg0K
