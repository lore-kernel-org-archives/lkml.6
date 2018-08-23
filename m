Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50A1C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355DE213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="NIIBd4Qo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 355DE213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbeHWNAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 09:00:07 -0400
Received: from mail-co1nam03on0081.outbound.protection.outlook.com ([104.47.40.81]:37878
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726182AbeHWNAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 09:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O64ssM6WIZbKuZjiY0o4FGYsyFvC0yLNNFucspGeqm0=;
 b=NIIBd4QoITDKimh2KNEgjo68I3oTA8oZhG61XptY613Vhy0wqqF31Smy2YyeZjEf/2r4gY6KR4AmfStMtQ6C1jfy9sCnRA2WTnGe+DE+BIC3+txRveGHlj2TyAd/OU5Pn7j2xeTruKEaV+/UpUXs5pmIRiArarXEzq2SzFwXrHo=
Received: from CY1PR0501MB1466.namprd05.prod.outlook.com (10.160.149.14) by
 CY1PR0501MB1737.namprd05.prod.outlook.com (10.163.140.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.5; Thu, 23 Aug 2018 09:31:10 +0000
Received: from CY1PR0501MB1466.namprd05.prod.outlook.com
 ([fe80::fd33:1b2e:ea31:5669]) by CY1PR0501MB1466.namprd05.prod.outlook.com
 ([fe80::fd33:1b2e:ea31:5669%5]) with mapi id 15.20.1080.010; Thu, 23 Aug 2018
 09:31:09 +0000
From:   Tiejun Chen <tiejunc@vmware.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: RE: [ANNOUNCE] 4.14.63-rt40
Thread-Topic: [ANNOUNCE] 4.14.63-rt40
Thread-Index: AQHUOkQOccSmKfMc/UepmWNJbbvpHqTNEpIw
Date:   Thu, 23 Aug 2018 09:31:09 +0000
Message-ID: <CY1PR0501MB14666E51F4D066F2E0C5208AC5370@CY1PR0501MB1466.namprd05.prod.outlook.com>
References: <20180822141458.0b6b6af7@gandalf.local.home>
In-Reply-To: <20180822141458.0b6b6af7@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tiejunc@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0501MB1737;20:b2c0sgOw62ZlBXyBZB33DREXq3C46uNzw+/OUuaOoyEm0SMuA47hK2W9Je8JQOMNb951MaeYrgqrb8qh65GFFXb+Sp2IZXS7r6C3bPYErsrgUUWf6frNHQ5c9SiGJA/PBqlV8wbzZIqgOMjgqwYDDZwTkKTZEoIMw/RNypCYQW8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bf804294-ba5d-4fa3-8f5d-08d608db2919
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0501MB1737;
x-ms-traffictypediagnostic: CY1PR0501MB1737:
bcl:    0
x-microsoft-antispam-prvs: <CY1PR0501MB1737574F6E71CC33D9FEBFCCC5370@CY1PR0501MB1737.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(181554191321653)(9452136761055)(189930954265078)(84791874153150)(219752817060721)(126837547833334)(33711482430040)(228905959029699)(145744241990776);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:CY1PR0501MB1737;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0501MB1737;
x-forefront-prvs: 0773BB46AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(366004)(39860400002)(189003)(199004)(13464003)(53936002)(55016002)(256004)(74316002)(14444005)(76176011)(2906002)(229853002)(6436002)(6306002)(9686003)(316002)(54906003)(8676002)(86362001)(7736002)(6506007)(26005)(81166006)(53546011)(446003)(305945005)(7696005)(486006)(66066001)(99286004)(5250100002)(575784001)(110136005)(81156014)(186003)(11346002)(102836004)(25786009)(8936002)(478600001)(68736007)(14454004)(97736004)(45080400002)(4326008)(5660300001)(2900100001)(7416002)(3846002)(966005)(106356001)(6116002)(105586002)(33656002)(476003)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0501MB1737;H:CY1PR0501MB1466.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Qb1NrtqV0kDkxrttMTF5T4IeztAHZUBqcekIBIaGNP3h1BFYhGr/XQCHpTdCr3/oh3t1GCav5uQF5xQVArDyzYhrFMw5C83mbsSUMiUB4GOrJI5Nz2gA5l3C/X7NjQj2eXRlqFzUs6K3B4y3KeTZI3jamaAJdX/y7RR9QnXvB+H5ggUBvp8EBVpTm5SS9VgabAH6UPQ/baZ9sGKK3iaHU/dV5pLLSPCuLSou/VJzyDxyCHxTRn8acrxF9Pdu6Y980xgfY94iTIqjpG4IQw+/1+JF4/IbpQZCM9OHOPY5nmoB9N41Sb0RDFfwZgAsV2bBl4xDpL/oUkTypccBQEG8iHVrVP3Er1iuR1ptLULWyIU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf804294-ba5d-4fa3-8f5d-08d608db2919
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2018 09:31:09.8443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0501MB1737
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U3RldmVuLA0KDQpjb21taXQgN2YxMWE1OTFiYmRiMTExNzkyMjk4MTQ0YzM0NzY1MDZhYTdmMWNh
OCAoSEVBRCAtPiB2NC4xNC42My1ydDQwLXJlYmFzZSwgdGFnOiB2NC4xNC42My1ydDQwLXJlYmFz
ZSwgb3JpZ2luL3Y0LjE0LXJ0LXJlYmFzZSkNCkF1dGhvcjogU3RldmVuIFJvc3RlZHQgKFZNd2Fy
ZSkgPHJvc3RlZHRAZ29vZG1pcy5vcmc+DQpEYXRlOiAgIFdlZCBNYXkgMTYgMDk6MzM6MDAgMjAx
OCAtMDQwMA0KDQogICAgTGludXggNC4xNC42My1ydDQwIFJFQkFTRQ0KDQpkaWZmIC0tZ2l0IGEv
bG9jYWx2ZXJzaW9uLXJ0IGIvbG9jYWx2ZXJzaW9uLXJ0DQppbmRleCA5MDI5MGM2NDJlZDUuLmEz
YjI0MDhjMWRhNiAxMDA2NDQNCi0tLSBhL2xvY2FsdmVyc2lvbi1ydA0KKysrIGIvbG9jYWx2ZXJz
aW9uLXJ0DQpAQCAtMSArMSBAQA0KLS1ydDI5DQorLXJ0MzcNCiAgICBeDQpJc24ndCBpdCBzdXBw
b3NlZCB0byBiZSBydDQwPw0KDQpUaGFua3MNClRpZWp1bg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IGxpbnV4LXJ0LXVzZXJzLW93bmVyQHZnZXIua2VybmVsLm9yZyA8
bGludXgtcnQtdXNlcnMtDQo+IG93bmVyQHZnZXIua2VybmVsLm9yZz4gT24gQmVoYWxmIE9mIFN0
ZXZlbiBSb3N0ZWR0DQo+IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMjMsIDIwMTggMjoxNSBBTQ0K
PiBUbzogTEtNTCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LXJ0LXVzZXJz
IDxsaW51eC1ydC0NCj4gdXNlcnNAdmdlci5rZXJuZWwub3JnPg0KPiBDYzogVGhvbWFzIEdsZWl4
bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBDYXJzdGVuIEVtZGUNCj4gPEMuRW1kZUBvc2FkbC5v
cmc+OyBKb2huIEthY3VyIDxqa2FjdXJAcmVkaGF0LmNvbT47IFNlYmFzdGlhbiBBbmRyemVqDQo+
IFNpZXdpb3IgPGJpZ2Vhc3lAbGludXRyb25peC5kZT47IEp1bGlhIENhcnR3cmlnaHQgPGp1bGlh
QG5pLmNvbT47IERhbmllbA0KPiBXYWduZXIgPGRhbmllbC53YWduZXJAc2llbWVucy5jb20+OyBU
b20gWmFudXNzaQ0KPiA8dG9tLnphbnVzc2lAbGludXguaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBb
QU5OT1VOQ0VdIDQuMTQuNjMtcnQ0MA0KPiANCj4gDQo+IERlYXIgUlQgRm9sa3MsDQo+IA0KPiBJ
J20gcGxlYXNlZCB0byBhbm5vdW5jZSB0aGUgNC4xNC42My1ydDQwIHN0YWJsZSByZWxlYXNlLg0K
PiANCj4gDQo+IFRoaXMgcmVsZWFzZSBpcyBqdXN0IGFuIHVwZGF0ZSB0byB0aGUgbmV3IHN0YWJs
ZSA0LjE0LjYzIHZlcnNpb24gYW5kIG5vIFJUDQo+IHNwZWNpZmljIGNoYW5nZXMgaGF2ZSBiZWVu
IG1hZGUuDQo+IA0KPiBOT1RFOiBUaGVyZSBpcyBhIGtub3duIGlzc3VlIHdpdGggdGhpcyByZWxl
YXNlLiBUaGUgZml4IGlzIGhlcmU6DQo+IA0KPiANCj4gaHR0cHM6Ly9uYTAxLnNhZmVsaW5rcy5w
cm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRmxrbWwua2VyDQo+IG5lbC5v
cmclMkZyJTJGMTUzNDY2MDExNS42MTg3LjQuY2FtZWwlNDBnbXguZGUmYW1wO2RhdGE9MDIlN0Mw
MSUNCj4gN0N0aWVqdW5jJTQwdm13YXJlLmNvbSU3Q2Y1NTA1YTEyNmJiODQ5MWFjMmRiMDhkNjA4
NWIyZTE1JTdDYjM5DQo+IDEzOGNhM2NlZTRiNGFhNGQ2Y2Q4M2Q5ZGQ2MmYwJTdDMSU3QzAlN0M2
MzY3MDU1ODUwNjIxNDI5NTYmYW1wDQo+IDtzZGF0YT12ZEg5eENJakMycFZ3TWdnR0p2VkFrZkly
cTJqRzNxSmFUaTBhc25xN1NrJTNEJmFtcDtyZXNlcnZlZA0KPiA9MA0KPiANCj4gSSBkaWQgbm90
IGFwcGx5IGl0IHRvIHRoaXMgcmVsZWFzZSBiZWNhdXNlIGl0IG5lZWRzIHRvIGJlIGFkZGVkIHRv
IHY0LjE2LXJ0IGZpcnN0DQo+IGJlZm9yZSBpdCBnZXRzIGJhY2twb3J0ZWQuIEZlZWwgZnJlZSB0
byBhcHBseSBpdCB5b3Vyc2VsZiBpZiB5b3UgaGF2ZSBhbnkNCj4gY29uY2VybnMuDQo+IA0KPiBZ
b3UgY2FuIGdldCB0aGlzIHJlbGVhc2UgdmlhIHRoZSBnaXQgdHJlZSBhdDoNCj4gDQo+ICAgZ2l0
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3J0L2xpbnV4LXN0YWJs
ZS1ydC5naXQNCj4gDQo+ICAgYnJhbmNoOiB2NC4xNC1ydA0KPiAgIEhlYWQgU0hBMTogZGE2YmVl
M2NlZjRhZjYwNTY2ZGM1NmYzZDQ4ZmNlMGIxODE2NTEwNw0KPiANCj4gDQo+IE9yIHRvIGJ1aWxk
IDQuMTQuNjMtcnQ0MCBkaXJlY3RseSwgdGhlIGZvbGxvd2luZyBwYXRjaGVzIHNob3VsZCBiZSBh
cHBsaWVkOg0KPiANCj4gDQo+IGh0dHBzOi8vbmEwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRs
b29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZ3d3cua2UNCj4gcm5lbC5vcmclMkZwdWIlMkZsaW51
eCUyRmtlcm5lbCUyRnY0LnglMkZsaW51eC0NCj4gNC4xNC50YXIueHomYW1wO2RhdGE9MDIlN0Mw
MSU3Q3RpZWp1bmMlNDB2bXdhcmUuY29tJTdDZjU1MDVhMTI2YmINCj4gODQ5MWFjMmRiMDhkNjA4
NWIyZTE1JTdDYjM5MTM4Y2EzY2VlNGI0YWE0ZDZjZDgzZDlkZDYyZjAlN0MxJTcNCj4gQzAlN0M2
MzY3MDU1ODUwNjIxNTI5NzAmYW1wO3NkYXRhPWN1VFVKT3pQYjhySlNiSzhRTGZxYjVzOWpITllr
Mw0KPiBXYnJVRGxhNXM2aXhNJTNEJmFtcDtyZXNlcnZlZD0wDQo+IA0KPiANCj4gaHR0cHM6Ly9u
YTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnd3
dy5rZQ0KPiBybmVsLm9yZyUyRnB1YiUyRmxpbnV4JTJGa2VybmVsJTJGdjQueCUyRnBhdGNoLQ0K
PiA0LjE0LjYzLnh6JmFtcDtkYXRhPTAyJTdDMDElN0N0aWVqdW5jJTQwdm13YXJlLmNvbSU3Q2Y1
NTA1YTEyNmJiDQo+IDg0OTFhYzJkYjA4ZDYwODViMmUxNSU3Q2IzOTEzOGNhM2NlZTRiNGFhNGQ2
Y2Q4M2Q5ZGQ2MmYwJTdDMSU3DQo+IEMwJTdDNjM2NzA1NTg1MDYyMTUyOTcwJmFtcDtzZGF0YT15
VnIzbGU0SjJtWWlrJTJCOE1KNzk2S2NFYiUyQg0KPiA3aSUyQmhBa0VXUXQycVo1cTJLWSUzRCZh
bXA7cmVzZXJ2ZWQ9MA0KPiANCj4gDQo+IGh0dHBzOi8vbmEwMS5zYWZlbGlua3MucHJvdGVjdGlv
bi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZ3d3cua2UNCj4gcm5lbC5vcmclMkZwdWIl
MkZsaW51eCUyRmtlcm5lbCUyRnByb2plY3RzJTJGcnQlMkY0LjE0JTJGcGF0Y2gtDQo+IDQuMTQu
NjMtDQo+IHJ0NDAucGF0Y2gueHomYW1wO2RhdGE9MDIlN0MwMSU3Q3RpZWp1bmMlNDB2bXdhcmUu
Y29tJTdDZjU1MDVhMTI2DQo+IGJiODQ5MWFjMmRiMDhkNjA4NWIyZTE1JTdDYjM5MTM4Y2EzY2Vl
NGI0YWE0ZDZjZDgzZDlkZDYyZjAlN0MxDQo+ICU3QzAlN0M2MzY3MDU1ODUwNjIxNTI5NzAmYW1w
O3NkYXRhPVRFY0wzZDNua0c2MjNVRk9nV1pWNXdrckpsDQo+IG9Qc1k3cVhjWjhibSUyRm1GREkl
M0QmYW1wO3Jlc2VydmVkPTANCj4gDQo+IA0KPiANCj4gDQo+IEVuam95LA0KPiANCj4gLS0gU3Rl
dmUNCg0K
