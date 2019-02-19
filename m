Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A494C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2508E208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dNe6/mBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbfBSVrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 16:47:13 -0500
Received: from mail-eopbgr720065.outbound.protection.outlook.com ([40.107.72.65]:4320
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725994AbfBSVrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 16:47:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DdndwGwUNdcEEharK0m7PMkD5s1DlJiMhVaBKQxPLs=;
 b=dNe6/mBR7L3JL+2XkdDL6HvQLX9fsGEJaqblZudWWt5kQTBy6NJMLndUCux2FHmwZv3T7lcXGcHgH2Dr4f8fKrNpIBvz4ftmqw7VndOr5giOSMe+F1C8EX4W5EAQx9NtfRxBky5MzblAsecLhWYVxW0WZwQ1UtyfrTwrclRlgZg=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB2905.namprd12.prod.outlook.com (20.179.71.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 19 Feb 2019 21:47:08 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::2809:46:d708:b9c1]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::2809:46:d708:b9c1%5]) with mapi id 15.20.1622.016; Tue, 19 Feb 2019
 21:47:08 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: False positive "do_IRQ: #.55 No irq handler for vector" messages
 on AMD ryzen based laptops
Thread-Topic: False positive "do_IRQ: #.55 No irq handler for vector" messages
 on AMD ryzen based laptops
Thread-Index: AQHUyGtPvkSDpgAjRUO4lAxcOgUb+aXnm82AgAAMrAA=
Date:   Tue, 19 Feb 2019 21:47:08 +0000
Message-ID: <13dbe818-a364-4cd4-3ac4-78bd7e8d28e3@amd.com>
References: <95e76875-f6b2-cbea-cd74-dc14ee77b2f8@redhat.com>
 <alpine.DEB.2.21.1902192144390.1644@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1902192144390.1644@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0049.namprd05.prod.outlook.com
 (2603:10b6:803:41::26) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26fa4873-f205-4c5a-d4d0-08d696b3cbbe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2905;
x-ms-traffictypediagnostic: DM6PR12MB2905:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: 1;DM6PR12MB2905;20:u9yRQgIshSgTPIieHVudHX6nayyNsHt5kwRE2IZIhsodwVlE7LLiwcQyas8neByyQRj6q9Rw5aZ+ESwv2gaF9JFy4Vf/VqmCoO1pekfYfks7y9KbKjKe4x2gp9hSxHg5d1zGLpEDOk4NbNERPQPY1vQ979Z8qoOyQQgyeHV9Vffc1eaP0DrSp4VScMzkWQ2F4jTOoNcMPZoq7A6a9DXZdLtHoHz+bHc6yf8lrvIf36PLO9rzSamqqpbt8NuFdQ9K
x-microsoft-antispam-prvs: <DM6PR12MB29052DA5D38D208C2606C505EC7C0@DM6PR12MB2905.namprd12.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(11346002)(15650500001)(6436002)(4326008)(446003)(486006)(52116002)(229853002)(2616005)(386003)(186003)(6506007)(6116002)(3846002)(102836004)(53546011)(26005)(476003)(6486002)(5660300002)(106356001)(53936002)(305945005)(66066001)(2906002)(72206003)(105586002)(6246003)(14454004)(31686004)(36756003)(76176011)(478600001)(256004)(14444005)(68736007)(8936002)(7736002)(99286004)(6512007)(81156014)(71200400001)(71190400001)(31696002)(110136005)(25786009)(316002)(54906003)(6306002)(81166006)(86362001)(97736004)(8676002)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2905;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mdme46+BMS/R7z5nT+5WsYdvBey9VQmkoWWY4gpz6WiN6Q/SlYu9sLpaKPutlFs98h9sWdwVaKW8LuoFjUiOSOH0X/5b99U0nChJpq+lCjPhXO7bX7NFxSNMc657j6T4ZS/eVYRNATIkP+IPamcr0Ln2b+VepoPXZ7KfuUaSovmp8qS7GNcWVKVBogORCxyakB+YFkGv9ficNC5Lj7fY5MfRz/vw5JfqFe8+9lmQlqCTbXr3o+aTS+bBlzD+zURRFyaOuM2tWS5/cECfYwd/ROzqeu9wBvwqAOj6oMM2sJQhktznw3akg3GyFwXcLMyZkEA2Qir8frp0X2xDk/WEP+6PNdKEYWbR67ZR7tYIvyFCxT3d3qRpyy9YM7FzbNoNBxwxm8VgNZ98Ah7Gpk3SZmmzH8rNuKdXrUUF+2/0e+o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C01B40830D2C54491B925E4F60ECA48@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26fa4873-f205-4c5a-d4d0-08d696b3cbbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 21:47:07.7054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2905
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8xOS8xOSAzOjAxIFBNLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6DQo+IEhhbnMsDQo+IA0K
PiBPbiBUdWUsIDE5IEZlYiAyMDE5LCBIYW5zIGRlIEdvZWRlIHdyb3RlOg0KPiANCj4gQ2MrOiBB
Q1BJL0FNRCBmb2xrcw0KPiANCj4+IFZhcmlvdXMgcGVvcGxlIGFyZSByZXBvcnRpbmcgZmFsc2Ug
cG9zaXRpdmUgImRvX0lSUTogIy41NSBObyBpcnEgaGFuZGxlciBmb3INCj4+IHZlY3RvciINCj4+
IG1lc3NhZ2VzIG9uIEFNRCByeXplbiBiYXNlZCBsYXB0b3BzLCBzZWUgZS5nLjoNCj4+DQo+PiBo
dHRwczovL2J1Z3ppbGxhLnJlZGhhdC5jb20vc2hvd19idWcuY2dpP2lkPTE1NTE2MDUNCj4+DQo+
PiBXaGljaCBjb250YWlucyB0aGlzIGRtZXNnIHNuaXBwZXQ6DQo+Pg0KPj4gRmViIDA3IDIwOjE0
OjI5IGxvY2FsaG9zdC5sb2NhbGRvbWFpbiBrZXJuZWw6IHNtcDogQnJpbmdpbmcgdXAgc2Vjb25k
YXJ5IENQVXMNCj4+IC4uLg0KPj4gRmViIDA3IDIwOjE0OjI5IGxvY2FsaG9zdC5sb2NhbGRvbWFp
biBrZXJuZWw6IHg4NjogQm9vdGluZyBTTVAgY29uZmlndXJhdGlvbjoNCj4+IEZlYiAwNyAyMDox
NDoyOSBsb2NhbGhvc3QubG9jYWxkb21haW4ga2VybmVsOiAuLi4uIG5vZGUgICMwLCBDUFVzOiAg
ICAgICMxDQo+PiBGZWIgMDcgMjA6MTQ6MjkgbG9jYWxob3N0LmxvY2FsZG9tYWluIGtlcm5lbDog
ZG9fSVJROiAxLjU1IE5vIGlycSBoYW5kbGVyIGZvcg0KPj4gdmVjdG9yDQo+PiBGZWIgMDcgMjA6
MTQ6MjkgbG9jYWxob3N0LmxvY2FsZG9tYWluIGtlcm5lbDogICMyDQo+PiBGZWIgMDcgMjA6MTQ6
MjkgbG9jYWxob3N0LmxvY2FsZG9tYWluIGtlcm5lbDogZG9fSVJROiAyLjU1IE5vIGlycSBoYW5k
bGVyIGZvcg0KPj4gdmVjdG9yDQo+PiBGZWIgMDcgMjA6MTQ6MjkgbG9jYWxob3N0LmxvY2FsZG9t
YWluIGtlcm5lbDogICMzDQo+PiBGZWIgMDcgMjA6MTQ6MjkgbG9jYWxob3N0LmxvY2FsZG9tYWlu
IGtlcm5lbDogZG9fSVJROiAzLjU1IE5vIGlycSBoYW5kbGVyIGZvcg0KPj4gdmVjdG9yDQo+PiBG
ZWIgMDcgMjA6MTQ6MjkgbG9jYWxob3N0LmxvY2FsZG9tYWluIGtlcm5lbDogc21wOiBCcm91Z2h0
IHVwIDEgbm9kZSwgNCBDUFVzDQo+PiBGZWIgMDcgMjA6MTQ6MjkgbG9jYWxob3N0LmxvY2FsZG9t
YWluIGtlcm5lbDogc21wYm9vdDogTWF4IGxvZ2ljYWwgcGFja2FnZXM6IDENCj4+IEZlYiAwNyAy
MDoxNDoyOSBsb2NhbGhvc3QubG9jYWxkb21haW4ga2VybmVsOiBzbXBib290OiBUb3RhbCBvZiA0
IHByb2Nlc3NvcnMNCj4+IGFjdGl2YXRlZCAoMTU5NjguNDkgQm9nb01JUFMpDQo+Pg0KPj4gSXQg
c2VlbXMgdGhhdCB3ZSBnZXQgYW4gSVJRIGZvciBlYWNoIENQVSBhcyB3ZSBicmluZyBpdCBvbmxp
bmUsDQo+PiB3aGljaCBmZWVscyB0byBtZSBsaWtlIGl0IGlzIHNvbWUgc29ydGEgZmFsc2UtcG9z
aXRpdmUuDQo+IA0KPiBTaWdoLCB0aGF0IGxvb2tzIGxpa2UgQklPUyB2YWx1ZSBhZGQgYWdhaW4u
DQo+IA0KPiBJdCdzIG5vdCBhIGZhbHNlIHBvc2l0aXZlLiBTb21ldGhpbmcgX0lTXyBzZW5kaW5n
IGEgdmVjdG9yIDU1IHRvIHRoZXNlIENQVXMNCj4gZm9yIHdoYXRldmVyIHJlYXNvbi4NCj4gDQoN
CkkgcmVtZW1iZXIgc2VlaW5nIHNvbWV0aGluZyBsaWtlIHRoaXMgaW4gdGhlIHBhc3QgYW5kIGl0
IHR1cm5lZCBvdXQgdG8gYmUNCmEgQklPUyBpc3N1ZS4gIEJJT1Mgd2FzIGVuYWJsaW5nIHRoZSBB
UHMgdG8gaW50ZXJhY3Qgd2l0aCB0aGUgbGVnYWN5IDgyNTkNCmludGVycnVwdCBjb250cm9sbGVy
IHdoZW4gb25seSB0aGUgQlNQIHNob3VsZC4gRHVyaW5nIFBPU1QgdGhlIEFQcyB3ZXJlDQpleHBv
c2VkIHRvIEV4dElOVC9JTlRSIGV2ZW50cyBhcyBhIHJlc3VsdCBvZiB0aGUgbWlzLWNvbmZpZ3Vy
YXRpb24NCihwcm9iYWJseSBkdWUgdG8gYSBVRUZJIHRpbWVyLXRpY2sgdXNpbmcgdGhlIDgyNTkp
IGFuZCB0aGlzIGxlZnQgYSBwZW5kaW5nDQpFeHRJTlQvSU5UUiBpbnRlcnJ1cHQgbGF0Y2hlZCBv
biB0aGUgQVBzLg0KDQpXaGVuIHRoZSBBUHMgd2VyZSBzdGFydGVkIGJ5IHRoZSBPUywgdGhlIGxh
dGNoZWQgRXh0SU5UL0lOVFIgaW50ZXJydXB0IGlzDQpwcm9jZXNzZWQgc2hvcnRseSBhZnRlciB0
aGUgT1MgZW5hYmxlcyBpbnRlcnJ1cHRzLiBUaGUgQVAgdGhlbiBxdWVyaWVzIHRoZQ0KODI1OSB0
byBpZGVudGlmeSB0aGUgdmVjdG9yIG51bWJlciAod2hpY2ggaXMgdGhlIHZhbHVlIG9mIHRoZSA4
MjU5J3MgSUNXMg0KcmVnaXN0ZXIgKyB0aGUgSVJRIGxldmVsKS4gVGhlIG1hc3RlciA4MjU5J3Mg
SUNXMiB3YXMgc2V0IHRvIDB4MzAgYW5kLA0Kc2luY2Ugbm8gaW50ZXJydXB0cyBhcmUgYWN0dWFs
bHkgcGVuZGluZywgdGhlIDgyNTkgd2lsbCByZXNwb25kIHdpdGggSVJRNw0KKHNwdXJpb3VzIGlu
dGVycnVwdCkgeWllbGRpbmcgYSB2ZWN0b3Igb2YgMHgzNyBvciA1NS4NCg0KVGhlIE9TIHdhcyBu
b3QgZXhwZWN0aW5nIHZlY3RvciA1NSBhbmQgcHJpbnRlZCB0aGUgbWVzc2FnZS4NCg0KRnJvbSB0
aGUgSW50ZWwgRGV2ZWxvcGVyJ3MgTWFudWFsOiBWb2wgM2EsIFNlY3Rpb24gMTAuNS4xOg0KIk9u
bHkgb25lIHByb2Nlc3NvciBpbiB0aGUgc3lzdGVtIHNob3VsZCBoYXZlIGFuIExWVCBlbnRyeSBj
b25maWd1cmVkIHRvDQp1c2UgdGhlIEV4dElOVCBkZWxpdmVyeSBtb2RlLiINCg0KTm90IHNheWlu
ZyB0aGlzIGlzIHRoZSBwcm9ibGVtLCBidXQgdmVyeSB3ZWxsIGNvdWxkIGJlLg0KDQpUaGFua3Ms
DQpUb20NCg0KPj4gSSB0ZW1wb3JhcmlseSBoYXZlIGFjY2VzcyB0byBhIGxvYW5lciBsYXB0b3Ag
Zm9yIGEgY291cGxlIG9mIHdlZWtzIHdoaWNoIHNob3dzDQo+PiB0aGUgc2FtZSBlcnJvcnMgYW5k
IEkgd291bGQgbGlrZSB0byBmaXggdGhpcywgYnV0IEkgZG9uJ3QgcmVhbGx5IGtub3cgaG93IHRv
DQo+PiBmaXggdGhpcy4NCj4gDQo+IENhbiB5b3UgcGxlYXNlIGVuYWJsZSBDT05GSUdfR0VORVJJ
Q19JUlFfREVCVUdGUyBhbmQgZGlnIGluIHRoZSBmaWxlcyB0aGVyZQ0KPiB3aGV0aGVyIHZlY3Rv
ciA1NSBpcyB1c2VkIG9uIENQVTAgYW5kIHdoaWNoIGRldmljZSBpcyBhc3NvY2lhdGVkIHRvIHRo
YXQuDQo+IA0KPiBJIGJldCBpdHMgYSBsZWdhY3kgSVJRIGFuZCBhcyB0aGF0IHNwYWNlIHN0YXJ0
cyBhdCA0OCAoSVJRMCkgdGhpcyBzaG91bGQgYmUNCj4gSVJROSB3aGljaCBpcyB1c3VhbGx5IC0g
RFJVTVJPTEwgLSB0aGUgQUNQSSBpbnRlcnJ1cHQuDQo+IA0KPiBUaGUga2VybmVsIGNsZWFybHkg
c2V0cyB0aGF0IHVwIHRvIGJlIGRlbGl2ZXJlZCB0byBDUFUgMCBvbmx5LCBidXQgSSd2ZQ0KPiBz
ZWVuIHRoYXQgYmVmb3JlIHRoYXQgdGhlIEJJT1MgdmFsdWUgYWRkIHRoaW5rcyB0aGF0IHRoaXMg
c2V0dXAgaXMgbm90DQo+IHJlbGV2YW50Lg0KPiANCj4gL21lIGdvZXMgb2ZmIGFuZCBzaW5ncyBM
QUxBTEENCj4gDQo+PiBOb3RlIGlmIHlvdSB3YW50IEkgY2FuIHNldCB1cCByb290IHNzaC1hY2Nl
c3MgdG8gdGhlIGxhcHRvcC4NCj4gDQo+IEFzIGEgbGVhc3QgcmVzb3J0LiByb290IHNzaCAtIFNI
VURERVIgLSBPb29wcyBub3cgSSBzcGlsbGVkIG15IHByZWZlcnJlZA0KPiBwYXNzd29yZCBmb3Ig
dGhhdCA6KQ0KPiANCj4gVGhhbmtzLA0KPiANCj4gCXRnbHgNCj4gDQo=
