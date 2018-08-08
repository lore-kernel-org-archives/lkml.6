Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525C3C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 03:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03865216F3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 03:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KxAawKR7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03865216F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeHHGCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 02:02:22 -0400
Received: from mail-eopbgr30051.outbound.protection.outlook.com ([40.107.3.51]:23158
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726503AbeHHGCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 02:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoNOvQrla27XtWjEd3xJd295ZEDsKWTZeV0qZzGw+Is=;
 b=KxAawKR71HRTuTaeGGJtlQiOwlkJ5k2oGR6vhPC8npzLVzmkE7PbIghzethaNazXxpKnpEznzmNrs0ARlkLh3GN2MhgpqFnsM5NZiI3TWn//1EBf8zWLbmJrPjdpQA9Jh2RgJT5b0AjGHkASZKdxiMdvf2yWrEmoEvpcUDwtgkk=
Received: from AM5PR0401MB2545.eurprd04.prod.outlook.com (10.169.245.8) by
 AM5PR0401MB2545.eurprd04.prod.outlook.com (10.169.245.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.21; Wed, 8 Aug 2018 03:44:45 +0000
Received: from AM5PR0401MB2545.eurprd04.prod.outlook.com
 ([fe80::a2:591f:fe8f:7c93]) by AM5PR0401MB2545.eurprd04.prod.outlook.com
 ([fe80::a2:591f:fe8f:7c93%3]) with mapi id 15.20.1038.019; Wed, 8 Aug 2018
 03:44:45 +0000
From:   Bharat Bhushan <bharat.bhushan@nxp.com>
To:     Scott Wood <oss@buserror.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "tyreld@linux.vnet.ibm.com" <tyreld@linux.vnet.ibm.com>,
        "joe@perches.com" <joe@perches.com>
Subject: RE: [RFC 5/5] powerpc/fsl: Add supported-irq-ranges for P2020
Thread-Topic: [RFC 5/5] powerpc/fsl: Add supported-irq-ranges for P2020
Thread-Index: AQHUJY+OEK4rmRCzmU6sElTr8iVLCqS02/0AgABrfQA=
Date:   Wed, 8 Aug 2018 03:44:44 +0000
Message-ID: <AM5PR0401MB254592DC0E917FD292B323BA9A260@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
         <1532684881-19310-6-git-send-email-Bharat.Bhushan@nxp.com>
 <ab2a113620123cb71364b6ae89328ae2fca49821.camel@buserror.net>
In-Reply-To: <ab2a113620123cb71364b6ae89328ae2fca49821.camel@buserror.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharat.bhushan@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0401MB2545;6:RoSYBVeHRFfOL5uY+2bBI4TGfrxD8WRkBnJI8y1Ufr/lFR8kz7sxwPe/vdqlSFW+UmQdk/4mochEv5M0cCcQG7VvKIghlMKeTKIL0/hWkjsIrlGjYMrPmhhQdUrcom/ICdHlHFwPvzrdaAKEbtFG4gHVY7ZT22eB0XggcDyhFZ3AUQzWdCxEpUrgMwZ3cvvADMW0832xjZBBNn79lD3eLP+xtHvIJALjNXtSCtc2RtQt5WOSn/BWQV+QpzyH1oVuidTj4+wS4Is4oPZJqJMAznL8RqoPEVyYa/DlRcLtKnuCXGo5RwzGkOxxl15GJQlYQdUQglKpm7sI1ODOPMuUEeip3CKadNSJBvDUq4mclp+sAdcnK4Lm58ej35IxfYfKzOXhEZB2G4D9bkLoFnrC5Me68cNA6H9mvvuDt8FyJ07hpFD6FzP/DLG1MKwbqA29n7ggm60yBeTDDY8mvLxlhg==;5:8RCz3oom0LdMwhrkjGca7ctdZtWTc93sB81iZC0NP58c9mEekwg4dLQ5oHJKIrxYWL8XAUIPUKa0gPna8jRM9YxBuEwOC+HA8662j9lw2ILIivqwEm2zxhqSQuaHt+gCIZGQ4HIGAy9uLooZlHuo6ZshJuDnCygjH96WA91UEW8=;7:J8ubtl6QVvu6pzjGc6v3/Q60NFdshT6KCftepnuvXBcXRXGy8ujw43suW1gMqYwNn7ur5vl1yaSt/CwyDlmy8gl0wPqXB+RHTJWEeOWNLPC8ozw7yjluUXTI2HfemdPpnjW1wZLnp+0T2ZAWb6cqRcMRD8epEhFRiCkO7BuANvvxV2+DtT3yLnzOnbAA+GGDnurB0WVLFl6tN4nvcv4nB/TRYiVbfTZMi3RnBTOSoATA3tfG21FD+Op2eigF37fn
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9f282c37-1d98-46db-b90b-08d5fce1481a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0401MB2545;
x-ms-traffictypediagnostic: AM5PR0401MB2545:
x-microsoft-antispam-prvs: <AM5PR0401MB25453835AC4A054D24B049FB9A260@AM5PR0401MB2545.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(65623756079841)(185117386973197)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0401MB2545;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0401MB2545;
x-forefront-prvs: 07584EDBCD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(396003)(346002)(136003)(189003)(199004)(13464003)(105586002)(9686003)(6436002)(102836004)(26005)(66066001)(2201001)(53546011)(6506007)(53936002)(55016002)(44832011)(106356001)(6116002)(256004)(3846002)(81156014)(8676002)(81166006)(7416002)(5660300001)(86362001)(2906002)(2900100001)(305945005)(74316002)(5250100002)(2501003)(76176011)(8936002)(33656002)(478600001)(186003)(99286004)(7696005)(68736007)(476003)(7736002)(97736004)(11346002)(25786009)(4326008)(6246003)(14454004)(446003)(486006)(229853002)(54906003)(110136005)(316002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0401MB2545;H:AM5PR0401MB2545.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Nq7oj7v5ZCRtSFvJXk7JupAhUzRMp/haA0hPG9dIOwtC4pjdojiF92Csewly1IljsVdGywZJZYZ9Z2Ov/LSdM9Hu3ahZA/NsFfkB4W+G2magJ3/SMi+8gmVxEBeLn661rgDOWYtVeVWu1HvGgpLh3csNIpH3Jq1cOqBBkAt2HgyjOFGcZNPyb72fWAjLgT7DEzaDdijx7LAisNa0QKLfTDQZgKfcyuvMj0zKVBya+BkGivUBDg4R6GzyDIf+OqU7eupoRIubKrdtf1enkPeM7EY5PC9prMc9INzgITv/ID/kG+d/fnvALL96XiIAuND6aVhMIKveyMKatC1FOb/wx3Qrm5tMc8k1jTZJieFG0RA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f282c37-1d98-46db-b90b-08d5fce1481a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2018 03:44:44.8964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2545
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2NvdHQgV29vZCBbbWFp
bHRvOm9zc0BidXNlcnJvci5uZXRdDQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDgsIDIwMTgg
Mjo0NCBBTQ0KPiBUbzogQmhhcmF0IEJodXNoYW4gPGJoYXJhdC5iaHVzaGFuQG54cC5jb20+Ow0K
PiBiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc7IHBhdWx1c0BzYW1iYS5vcmc7IG1wZUBlbGxlcm1h
bi5pZC5hdTsNCj4gZ2FsYWtAa2VybmVsLmNyYXNoaW5nLm9yZzsgbWFyay5ydXRsYW5kQGFybS5j
b207DQo+IGtzdGV3YXJ0QGxpbnV4Zm91bmRhdGlvbi5vcmc7IGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXhwcGMtZGV2QGxpc3Rz
Lm96bGFicy5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiByb2Jo
QGtlcm5lbC5vcmc7IGtlZXNjb29rQGNocm9taXVtLm9yZzsgdHlyZWxkQGxpbnV4LnZuZXQuaWJt
LmNvbTsNCj4gam9lQHBlcmNoZXMuY29tDQo+IFN1YmplY3Q6IFJlOiBbUkZDIDUvNV0gcG93ZXJw
Yy9mc2w6IEFkZCBzdXBwb3J0ZWQtaXJxLXJhbmdlcyBmb3IgUDIwMjANCj4gDQo+IE9uIEZyaSwg
MjAxOC0wNy0yNyBhdCAxNToxOCArMDUzMCwgQmhhcmF0IEJodXNoYW4gd3JvdGU6DQo+ID4gTVBJ
QyBvbiBOWFAgKEZyZWVzY2FsZSkgUDIwMjAgc3VwcG9ydHMgZm9sbG93aW5nIGlycQ0KPiA+IHJh
bmdlczoNCj4gPiAgID4gMCAtIDExICAgICAgKEV4dGVybmFsIGludGVycnVwdCkNCj4gPiAgID4g
MTYgLSA3OSAgICAgKEludGVybmFsIGludGVycnVwdCkNCj4gPiAgID4gMTc2IC0gMTgzICAgKE1l
c3NhZ2luZyBpbnRlcnJ1cHQpDQo+ID4gICA+IDIyNCAtIDIzMSAgIChTaGFyZWQgbWVzc2FnZSBz
aWduYWxlZCBpbnRlcnJ1cHQpDQo+IA0KPiBXaHkgZG9uJ3QgeW91IGNvbnZlcnQgdG8gdGhlIDQt
Y2VsbCBpbnRlcnJ1cHQgc3BlY2lmaWVycyB0aGF0IG1ha2UgZGVhbGluZw0KPiB3aXRoIHRoZXNl
IHJhbmdlcyBsZXNzIGVycm9yLXByb25lPw0KDQpPayAsIHdpbGwgZG8gaWYgd2UgYWdyZWUgdG8g
aGF2ZSB0aGlzIHNlcmllcyBhcyBwZXIgY29tbWVudCBvbiBvdGhlciBwYXRjaC4NCg0KPiANCj4g
PiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy84NXh4L21wYzg1eHhfcmRiLmMN
Cj4gPiBiL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvODV4eC9tcGM4NXh4X3JkYi5jDQo+ID4gaW5k
ZXggMTAwNjk1MC4uNDlmZjM0OCAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3Bvd2VycGMvcGxhdGZv
cm1zLzg1eHgvbXBjODV4eF9yZGIuYw0KPiA+ICsrKyBiL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMv
ODV4eC9tcGM4NXh4X3JkYi5jDQo+ID4gQEAgLTU3LDYgKzU3LDExIEBAIHZvaWQgX19pbml0IG1w
Yzg1eHhfcmRiX3BpY19pbml0KHZvaWQpDQo+ID4gIAkJCU1QSUNfQklHX0VORElBTiB8DQo+ID4g
IAkJCU1QSUNfU0lOR0xFX0RFU1RfQ1BVLA0KPiA+ICAJCQkwLCAyNTYsICIgT3BlblBJQyAgIik7
DQo+ID4gKwl9IGVsc2UgaWYgKG9mX21hY2hpbmVfaXNfY29tcGF0aWJsZSgiZnNsLFAyMDIwUkRC
LVBDIikpIHsNCj4gPiArCQltcGljID0gbXBpY19hbGxvYyhOVUxMLCAwLA0KPiA+ICsJCSAgTVBJ
Q19CSUdfRU5ESUFOIHwNCj4gPiArCQkgIE1QSUNfU0lOR0xFX0RFU1RfQ1BVLA0KPiA+ICsJCSAg
MCwgMCwgIiBPcGVuUElDICAiKTsNCj4gPiAgCX0gZWxzZSB7DQo+ID4gIAkJbXBpYyA9IG1waWNf
YWxsb2MoTlVMTCwgMCwNCj4gPiAgCQkgIE1QSUNfQklHX0VORElBTiB8DQo+IA0KPiBJIGRvbid0
IHRoaW5rIHdlIHdhbnQgdG8gZ3JvdyBhIGxpc3Qgb2YgZXZlcnkgc2luZ2xlIHJldmlzaW9uIG9m
IGV2ZXJ5IGJvYXJkIGluDQo+IHRoZXNlIHBsYXRmb3JtIGZpbGVzLg0KDQpPbmUgb3RoZXIgY29u
ZnVzaW5nIG9ic2VydmF0aW9uIEkgaGF2ZSBpcyB0aGF0ICJpcnFfY291bnQiIGZyb20gcGxhdGZv
cm0gY29kZSBpcyBnaXZlbiBwcmVjZWRlbmNlIG92ZXIgImxhc3QtaW50ZXJydXB0LXNvdXJjZSIg
aW4gZGV2aWNlLXRyZWUuDQpTaG91bGQgbm90IGRldmljZS10cmVlIHNob3VsZCBoYXZlIHByZWNl
ZGVuY2Ugb3RoZXJ3aXNlIHRoZXJlIGlzIG5vIHBvaW50IHVzaW5nICIgbGFzdC1pbnRlcnJ1cHQt
c291cmNlIiBpZiBwbGF0Zm9ybSBjb2RlIHBhc3NlcyAiaXJxX2NvdW50IiBpbiBtcGljX2FsbG9j
KCkuDQoNClRoYW5rcw0KLUJoYXJhdA0KDQo+IA0KPiAtU2NvdHQNCg0K
