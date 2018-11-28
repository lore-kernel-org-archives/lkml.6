Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6DDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE6121019
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bJVG/RGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE6121019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbeK2DAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:00:04 -0500
Received: from mail-eopbgr690049.outbound.protection.outlook.com ([40.107.69.49]:34720
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727979AbeK2DAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 22:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XK9txnNm1E9hCECbPAJceLcJVXUgc0OWOGK8veq9/0=;
 b=bJVG/RGrUpojKpIwSNdu0VDHx89DiHCz8uscy4f+GMdKVfb5xp67jXxS+XhbxLXsrn+lgK+5Sg7qCmW/MAB9nXtSqsB5HruicVxlxfKTnleMjadApOx8PgzbgWkNpuAYV1wUc1jSk4lsitNWxR1P3BeZyy/knTtUALNOZkPBipw=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1689.namprd12.prod.outlook.com (10.172.40.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.18; Wed, 28 Nov 2018 15:57:53 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 15:57:53 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Luiz Capitulino <lcapitulino@redhat.com>,
        Liran Alon <liran.alon@oracle.com>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] KVM: VMX: re-add ple_gap module parameter
Thread-Topic: [PATCH] KVM: VMX: re-add ple_gap module parameter
Thread-Index: AQHUg05KbhM/A5ofokS+JgCmkrvk26VdoU+AgAAMPICAB7ITgA==
Date:   Wed, 28 Nov 2018 15:57:53 +0000
Message-ID: <0a2d9427-18e7-408a-d0ae-b8277cad542a@amd.com>
References: <20181123120214.174457a4@doriath>
 <8049C3CD-E816-4270-A64F-0BB92BD56338@oracle.com>
 <20181123132641.712e2695@doriath>
In-Reply-To: <20181123132641.712e2695@doriath>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0002.prod.exchangelabs.com (2603:10b6:804:2::12)
 To DM5PR12MB2471.namprd12.prod.outlook.com (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1689;20:BZ5ASESnRZs7P5+JPYwq9XsKiqrnE2UFX5wqcfDl9kOcTqDRKDXr1Q9LmaWjcqEDlS0wX16CAMtRW1MlgzKA9NHfwFMifEQiyicwIi8SIouL4cRZglQuYPOEnRAU7yt5L+h0C8FvoOJ8tVnBS4pq180etxT1pU1DofjWHeRP02QS8fBvZFZ6RVVpskJ8tjjU8psHYPk7IDc5tS/O9+Fldi5v5sC2F9dLGqmiu9+YAU3yNu7LTuWiH9iIJcqvHBx4
x-ms-office365-filtering-correlation-id: c010d8bb-0851-4c6c-0385-08d6554a4154
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1689;
x-ms-traffictypediagnostic: DM5PR12MB1689:
x-microsoft-antispam-prvs: <DM5PR12MB1689C28AEFB55639B24B96ED95D10@DM5PR12MB1689.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231443)(999002)(944501410)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1689;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1689;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(366004)(396003)(39860400002)(189003)(199004)(13464003)(5660300001)(6436002)(36756003)(110136005)(54906003)(11346002)(446003)(6116002)(3846002)(53936002)(97736004)(6246003)(52116002)(76176011)(102836004)(53546011)(4326008)(476003)(14454004)(2616005)(71190400001)(71200400001)(316002)(6512007)(6506007)(305945005)(486006)(7736002)(81156014)(81166006)(386003)(72206003)(2906002)(86362001)(99286004)(68736007)(31696002)(8936002)(478600001)(106356001)(186003)(6486002)(105586002)(25786009)(31686004)(66066001)(256004)(26005)(229853002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1689;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Q8P8DjV6QbMpiHRjZymrUdgzGBbwP44qE0BE4j0WP/OdKWymadDQWd/ceSOw3i/jqmjPBGao4+7E22K3qDQSwLgAD80typU/Dov5HsHl4AaRDtqKXCP4TVLRCjPIOzSimBkufpqJrTahVPVBEL/jDN/yqX3qNt57VDU7whMpRy5o13efApCGwXTK9Pgy7cKMC2sN6kW27+APJW0AH7p2ZkLZiEc3m5JNYqQtXDWiFJ6ytg95hW/Lq7qNNnI4KrUpax9pqpOUan23kxyKd+fU5l9e3RkArgzUr3BUu3QmESNl0BOpzQB4zLq6gbN0k4YVBFRMOQu6VWCX2BUNEMPbGx7UFuH8uAapb8bV/pvGVWw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3822BAD26835445985490A604A74876@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c010d8bb-0851-4c6c-0385-08d6554a4154
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 15:57:53.3030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1689
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TXkgYmFkLi4gU29ycnkgYWJvdXQgdGhpcy4gSSB0aGluayB0aGlzIHNob3VsZCBhbHNvIGdvIHRv
DQpzdGFibGVAdmdlci5rZXJuZWwub3JnDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogTHVpeiBDYXBpdHVsaW5vIDxsY2FwaXR1bGlub0ByZWRoYXQuY29tPg0KPiBTZW50
OiBGcmlkYXksIE5vdmVtYmVyIDIzLCAyMDE4IDEyOjI3IFBNDQo+IFRvOiBMaXJhbiBBbG9uIDxs
aXJhbi5hbG9uQG9yYWNsZS5jb20+DQo+IENjOiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRo
YXQuY29tPjsgTW9nZXIsIEJhYnUNCj4gPEJhYnUuTW9nZXJAYW1kLmNvbT47IGt2bUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0hdIEtWTTogVk1YOiByZS1hZGQgcGxlX2dhcCBtb2R1bGUgcGFyYW1ldGVyDQo+IA0K
PiBPbiBGcmksIDIzIE5vdiAyMDE4IDE5OjQyOjUzICswMjAwDQo+IExpcmFuIEFsb24gPGxpcmFu
LmFsb25Ab3JhY2xlLmNvbT4gd3JvdGU6DQo+IA0KPiA+ID4gT24gMjMgTm92IDIwMTgsIGF0IDE5
OjAyLCBMdWl6IENhcGl0dWxpbm8gPGxjYXBpdHVsaW5vQHJlZGhhdC5jb20+DQo+IHdyb3RlOg0K
PiA+ID4NCj4gPiA+DQo+ID4gPiBBcHBhcmVudGx5LCB0aGUgcGxlX2dhcCBwYXJhbWV0ZXIgd2Fz
IGFjY2lkZW50YWxseSByZW1vdmVkDQo+ID4gPiBieSBjb21taXQgYzhlODg3MTdjZmM2YjM2YmVk
ZWEyMjM2OGQ5NzY2NzQ0NjMxODI5MS4gQWRkIGl0DQo+ID4gPiBiYWNrLg0KPiA+ID4NCj4gPiA+
IFNpZ25lZC1vZmYtYnk6IEx1aXogQ2FwaXR1bGlubyA8bGNhcGl0dWxpbm9AcmVkaGF0LmNvbT4N
Cj4gPg0KPiA+IFdlaXJkIHRoYXQgbm9ib2R5IG5vdGljZWQgdGhpcyB3aGVuIHBhdGNoIHdhcyBh
cHBsaWVk4oCmIFRoYW5rcy4NCj4gPiBSZXZpZXdlZC1ieTogTGlyYW4gQWxvbiA8bGlyYW4uYWxv
bkBvcmFjbGUuY29tPg0KUmV2aWV3ZWQtYnk6IEJhYnUgTW9nZXIgPGJhYnUubW9nZXJAYW1kLmNv
bT4NCg0KPiANCj4gSSBmb3Jnb3QgdG8gbWVudGlvbiB0aGF0IEkgbm90aWNlZCB0aGlzIGJlY2F1
c2UgSSBoYXZlIHN5c3RlbXMNCj4gZGlzYWJsaW5nIHBsZSB3aXRoIHBsZV9nYXA9MCBpbiBtb2Rw
cm9iZS5jb25mLiBJbiB0aG9zZSBzeXN0ZW1zDQo+IGt2bV9pbnRlbCB3b24ndCBsb2FkIGFueW1v
cmUuDQo+IA0KPiA+DQo+ID4gPiAtLS0NCj4gPiA+IGFyY2gveDg2L2t2bS92bXguYyB8IDEgKw0K
PiA+ID4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4gPg0KPiA+ID4gZGlmZiAt
LWdpdCBhL2FyY2gveDg2L2t2bS92bXguYyBiL2FyY2gveDg2L2t2bS92bXguYw0KPiA+ID4gaW5k
ZXggNDU1NTA3N2Q2OWNlLi5iZTZmMTNmMWMyNWYgMTAwNjQ0DQo+ID4gPiAtLS0gYS9hcmNoL3g4
Ni9rdm0vdm14LmMNCj4gPiA+ICsrKyBiL2FyY2gveDg2L2t2bS92bXguYw0KPiA+ID4gQEAgLTE3
NCw2ICsxNzQsNyBAQCBtb2R1bGVfcGFyYW1fbmFtZWQocHJlZW1wdGlvbl90aW1lciwNCj4gZW5h
YmxlX3ByZWVtcHRpb25fdGltZXIsIGJvb2wsIFNfSVJVR08pOw0KPiA+ID4gICogcmVmZXIgU0RN
IHZvbHVtZSAzYiBzZWN0aW9uIDIxLjYuMTMgJiAyMi4xLjMuDQo+ID4gPiAgKi8NCj4gPiA+IHN0
YXRpYyB1bnNpZ25lZCBpbnQgcGxlX2dhcCA9IEtWTV9ERUZBVUxUX1BMRV9HQVA7DQo+ID4gPiAr
bW9kdWxlX3BhcmFtKHBsZV9nYXAsIHVpbnQsIDA0NDQpOw0KPiA+ID4NCj4gPiA+IHN0YXRpYyB1
bnNpZ25lZCBpbnQgcGxlX3dpbmRvdyA9IEtWTV9WTVhfREVGQVVMVF9QTEVfV0lORE9XOw0KPiA+
ID4gbW9kdWxlX3BhcmFtKHBsZV93aW5kb3csIHVpbnQsIDA0NDQpOw0KPiA+ID4gLS0NCj4gPiA+
IDIuMTcuMg0KPiA+ID4NCj4gPg0KDQo=
