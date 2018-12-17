Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7A9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369EE20645
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="J5ninix5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbeLQMXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:23:41 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.6]:55902 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726436AbeLQMXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:23:40 -0500
Received: from [85.158.142.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta.az-a.eu-central-1.aws.symcld.net id A5/12-08814-745971C5; Mon, 17 Dec 2018 12:23:35 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VSWUwTURTlzUyng6FmKGivRFAbwaC2LDVhiIm
  aaLTGmLhEUYPLAGPbWAp0idUf0WpkcQEFF4KCCgYpAkFcUIOGaKQKKlojoKKm/UBERVwgLtWZ
  Drj8vJx3zrn3nvdyKVzeQ4ZRnN3KmU2sUUmOIfQxRIJqUbEiOdbdM555VuzCGMeZOpLJczYRT
  PPHWox5fLWUZE6f3YMz3lNt2DyptrzBpj3pWq69caJGqm0aypZqPzVELJOskxhMKRn2TRJ90f
  0+MvPmLLvvXS2ejXo1eSiQIug6HF7eXJyHxlByuhiDJ4VVuHjxIBgYPicVXCTNwOHWV6QghNI
  ODG4V/sSEC05XImhwV/hdIXQSVD4+6ceh9Bq4+K0FE3E89A/uxcV5kfD9bZ+fl9Es9PcP+3k5
  P8H96zIh4EA6EYb7q0kBIzocPu90+j04rYBub5m/FmgaKq4/wEU8Dt54fBLRz4FrVycS+ZnQ/
  tTLY4rHU+CAZ7ZIh8Ojsnwk5Ae6i4QP+fdH/EuhaJ+LFIXnCDyeAXK0UeGXDqmIGajI30OIOB
  PKDx4d4SOgev/rEf4FDhfdK0Q8EXIe7sbEpr8k0N7hI8UXp8LAiXZpAZpZ8s/jSviwOB0NdVd
  jRHoKFOW/lpb4/ysYXMe9RDkiqlFiitmg01vTWYNRFRcbq4qL06g0qniNRs1uV7FqzqZK5UxW
  M8uranarRW3Zlp5qTFObOGsD4vcrLQt/cwUNOXQtaAKFKcfJvDmKZPnYlIy0bXrWot9othk5S
  wuaSFFKkOmKeC3YzOk4+2aDkV/SURmoIGWoLEmQZZZMNt1i0InSXZRIXWrLPYZTbv95J/dLKS
  4nTBkmLkwhcwgFtFCgt5n+tBtd+0coPCxEhgICAuRBmZw53WD9X+9DCgopQ2R2oUuQwWT9M7W
  PD4TxgYyNmBDIyv6VwrJRVE5ygC3wWnDPluaa7t4fhxu7ep0XulsuH9oxZ259gi9as2Mo98nq
  CLNut63jtnTaJGzv+LYCpzb8q2P95EsJxH5l5On5xopVa++2OlfKa6ZumD6joD6ptfJ9ZILqz
  sImfee91oK8LfPL7L7BwFODVc6oBQezzmcsOfJJ21bcPDtm8RIlYdGzcdNxs4X9DQdKyDzxAw
  AA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-29.tower-229.messagelabs.com!1545049415!2885949!1
X-Originating-IP: [104.47.4.55]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30868 invoked from network); 17 Dec 2018 12:23:35 -0000
Received: from mail-am5eur02lp2055.outbound.protection.outlook.com (HELO EUR02-AM5-obe.outbound.protection.outlook.com) (104.47.4.55)
  by server-29.tower-229.messagelabs.com with AES256-SHA256 encrypted SMTP; 17 Dec 2018 12:23:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQ4So6xMxIZHm7JkPbfdyEjvIxVcojPZj6LcatQtdIQ=;
 b=J5ninix5EspLOdKK8spj4Fa1IldRJQm20SQgQzQR+LKcSnOWTicYUSbXF0wtRNOozIJEaKfadMaISs6VYd7EJzpBaYzBPsEPftl4uoLAIulLQ7YI75PIMCEB6GiNagRrB22fQN9pfuWGmkrS/p4zcg+XUIf4YPExJqJGJ9BN0g8=
Received: from HE1PR1001MB1002.EURPRD10.PROD.OUTLOOK.COM (10.168.129.142) by
 HE1PR1001MB0922.EURPRD10.PROD.OUTLOOK.COM (10.167.193.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Mon, 17 Dec 2018 12:23:32 +0000
Received: from HE1PR1001MB1002.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b806:2864:5268:3447]) by HE1PR1001MB1002.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b806:2864:5268:3447%5]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 12:23:32 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Kyle Tso <kyletso@google.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     "badhri@google.com" <badhri@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: typec: tcpm: Extend the matching rules on PPS APDO
 selection
Thread-Topic: [PATCH] usb: typec: tcpm: Extend the matching rules on PPS APDO
 selection
Thread-Index: AQHUlbL6k39xhGS0X0+dwIYfo3mukKWC1r+A
Date:   Mon, 17 Dec 2018 12:23:32 +0000
Message-ID: <HE1PR1001MB1002719044E56D116949E2AE80BC0@HE1PR1001MB1002.EURPRD10.PROD.OUTLOOK.COM>
References: <20181217024805.122897-1-kyletso@google.com>
In-Reply-To: <20181217024805.122897-1-kyletso@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.56]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR1001MB0922;6:HlrVqe0WG5Fs70Kp85ZH8SlcjMLetlS12XHh+pzbvPfAz5GBiot3mxNQu0WLwTBLOfFBLjBl3B9wa13fP5AM1NXgtTGRv5mkpa9gJI7IjI6Bd5cQA2AaYUUWPepOC1jwSF36d8OVoInRsmrbnCBp/ehTvSg/+bn4rV+HSu5q+8goEyoJFcSHMTKkrkUK8+fRowwmdwYmKGlOCVJGM69FfjDelYAT1l0TEVj7+KUTNjnCduy5M/kXBLq1t8kSmqURQ5/9RrPg/2001hGn74xiPerVbCAefYmZTeGSc3NriyaDuqeUXw88ca/PvwWXIKtTb4IHmRFlthR/oyt620v3gLYyZPGyoE16RcEvC+asHOcRS0mo59Sb4he15UNaxXwhf+h93xb450yYuEaDbG8AAEh+XrD0Uwbj0M+giSY/fnpWQpQifl6QmQSCvRe1z3LZNnW6Fg+4H43DovCW46QNDQ==;5:UlUphTVsq34111D2X0SXH82hmuGSVVwVdzAy28wSoapDP1BDZUkFWboKl64dlyT82ZRV/psB2iJVt0sh6/RFr9+mfX/DyCaY5RGc9HssdXzM0T8iCthw8MaY2ljY6IqXlaDDn+t/Q6pC9wjZSxunnxEuJ6EWHEBUi2F6mKTy008=;7:HEMXX/E2Goo3UfA1NjzKZRSzu6t2Q9VwyiSI2QcFsLYPpEHZ6jzZtKyKgPnNgipUKsq19pH1YJCJ8g7h4TjuP+IOqSMVMXxHCLEr1HAWpiDl99T3QQGDXk9DfCONM+mupbOqSO/6AlK3fAAsqVoktg==
x-ms-office365-filtering-correlation-id: 34f40aa6-9bbd-4f0d-6bb1-08d6641a7587
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR1001MB0922;
x-ms-traffictypediagnostic: HE1PR1001MB0922:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <HE1PR1001MB09224ED5A073985BFF162BA4A7BC0@HE1PR1001MB0922.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:HE1PR1001MB0922;BCL:0;PCL:0;RULEID:;SRVR:HE1PR1001MB0922;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(39850400004)(376002)(366004)(54534003)(189003)(199004)(7736002)(110136005)(53546011)(6116002)(5660300001)(25786009)(11346002)(68736007)(305945005)(7696005)(2201001)(72206003)(446003)(74316002)(8676002)(66066001)(71190400001)(6246003)(81166006)(71200400001)(14454004)(3846002)(86362001)(53936002)(6436002)(256004)(4326008)(55016002)(81156014)(99286004)(486006)(9686003)(105586002)(55236004)(229853002)(33656002)(2906002)(476003)(76176011)(97736004)(217873002)(8936002)(316002)(478600001)(106356001)(26005)(54906003)(102836004)(186003)(6506007)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR1001MB0922;H:HE1PR1001MB1002.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QP009yoFIRTCl1NZLqIOPfOC0HE8n4mcZ0nBJozl0meIMGmwW8GYkQ8COLqoPRrPl7ta/ayFnxJRP2ZBenMDgnBsRw/NTTymy3NwtKqdq3h//KQt+lkee44YMlWk54tCH5tkdBeIXcEZ8Y45Q7rhrPj2lXpgvm8cl24Ea14aEMJL2mADsVBmM9u4qxDYwjgGDsjfCaiwd5utgbntubZCYRpmTt2P1rSgsPQfdMFoGjULewQa71ZUvHy/dJKGv1/5C66xbpBt8vcFtIrDN7RMYtVtRO3d5CHx3GTobE64LNtDvyhqY9HzMC7wfTfjAu5Z
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f40aa6-9bbd-4f0d-6bb1-08d6641a7587
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 12:23:32.0958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR1001MB0922
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTcgRGVjZW1iZXIgMjAxOCAwMjo0OCwgS3lsZSBUc28gd3JvdGU6DQoNCj4gQ3VycmVudCBt
YXRjaGluZyBydWxlcyBlbnN1cmUgdGhhdCB0aGUgdm9sdGFnZSByYW5nZSBvZiBzZWxlY3RlZCBT
b3VyY2UNCj4gQ2FwYWJpbGl0eSBpcyBlbnRpcmVseSB3aXRoaW4gdGhlIHJhbmdlIGRlZmluZWQg
aW4gb25lIG9mIHRoZSBTaW5rIENhcGFiaWxpdGllcy4gVGhpcw0KPiBpcyByZWFzb25hYmxlIGJ1
dCBub3QgcHJhY3RpY2FsIGJlY2F1c2UgU2luayBtYXkgbm90IHN1cHBvcnQgd2lkZSByYW5nZSBv
Zg0KPiB2b2x0YWdlIHdoZW4gc2lua2luZyBwb3dlciB3aGlsZSBTb3VyY2UgY291bGQgYWR2ZXJ0
aXNlIGl0cyBjYXBhYmlsaXRpZXMgaW4NCj4gcmFsZXRpdmVseSB3aWRlciByYW5nZS4gRm9yIGV4
YW1wbGUsIGEgU291cmNlIFBETyBhZHZlcnRpc2luZyAzLjNWLTExVkAzQSAoOVYNCg0KcmVsYXRp
dmVseQ0KDQo+IFByb2cgb2YgRml4ZWQgTm9taW5hbCBWb2x0YWdlKSB3aWxsIG5vdCBiZSBzZWxl
Y3RlZCBpZiB0aGUgU2luayByZXF1aXJlcyA1Vi0NCj4gMTJWQDNBIFBQUyBwb3dlci4gSG93ZXZl
ciwgdGhlIFNpbmsgY291bGQgd29yayB3ZWxsIGlmIHRoZSByZXF1ZXN0ZWQgdm9sdGFnZQ0KPiBy
YW5nZSBpbiBSRE9zIGlzIDVWLTExVkAzQS4NCj4gDQo+IEN1cnJlbnRseSBhY2NlcHRlZDoNCj4g
CQl8LS0tLS0tLS0tIHNvdXJjZSAtLS0tLXwNCj4gCXwtLS0tLS0tLS0tLSBzaW5rIC0tLS0tLS0t
LS0tLS0tLXwNCj4gDQo+IEN1cnJlbnRseSBub3QgYWNjZXB0ZWQ6DQo+IAkJCXwtLS0tLS0tLS0g
c291cmNlIC0tLS0tfA0KPiAJfC0tLS0tLS0tLS0tIHNpbmsgLS0tLS0tLS0tLS0tLS0tfA0KPiAN
Cj4gCXwtLS0tLS0tLS0gc291cmNlIC0tLS0tfA0KPiAJCXwtLS0tLS0tLS0tLSBzaW5rIC0tLS0t
LS0tLS0tLS0tLXwNCj4gDQo+IAl8LS0tLS0tLS0tIHNvdXJjZSAtLS0tLS0tLS0tLS0tLS0tLXwN
Cj4gCQl8LS0tLS0tIHNpbmsgLS0tLS0tLXwNCj4gDQo+IFRvIGltcHJvdmUgdGhlIHVzYWJpbGl0
eSwgY2hhbmdlIHRoZSBtYXRjaGluZyBydWxlcyB0byB3aGF0IGxpc3RlZA0KPiBiZWxvdzoNCj4g
YS4gVGhlIFNvdXJjZSBQRE8gaXMgc2VsZWN0YWJsZSBpZiBhbnkgcG9ydGlvbiBvZiB0aGUgdm9s
dGFnZSByYW5nZQ0KPiAgICBvdmVybGFwcyBvbmUgb2YgdGhlIFNpbmsgUERPJ3Mgdm9sdGFnZSBy
YW5nZS4NCj4gYi4gVGhlIG1heGltdW0gb3BlcmF0aW9uYWwgdm9sdGFnZSB3aWxsIGJlIHRoZSBs
b3dlciBvbmUgYmV0d2VlbiB0aGUNCj4gICAgc2VsZWN0ZWQgU291cmNlIFBETyBhbmQgdGhlIG1h
dGNoaW5nIFNpbmsgUERPLg0KPiBjLiBUaGUgbWF4aW11bSBwb3dlciB3aWxsIGJlIHRoZSBtYXhp
bXVtIG9wZXJhdGlvbmFsIHZvbHRhZ2UgdGltZXMgdGhlDQo+ICAgIG1heGltdW0gY3VycmVudCBk
ZWZpbmVkIGluIHRoZSBzZWxlY3RlZCBTb3VyY2UgUERPIGQuIFNlbGVjdCB0aGUgU291cmNlIFBE
Tw0KPiB3aXRoIHRoZSBoaWdoZXN0IG1heGltdW0gcG93ZXINCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEt5bGUgVHNvIDxreWxldHNvQGdvb2dsZS5jb20+DQo+IA0KPiAtLS0NCj4gQ2hhbmdlbG9nIHNp
bmNlIHYxOg0KPiAtIHVwZGF0ZWQgdGhlIGNvbW1pdCBtZXNzYWdlIGFzIHN1Z2dlc3RlZCBieSBH
dWVudGVyIFJvZWNrIDxsaW51eEByb2Vjay0NCj4gdXMubmV0Pg0KPiAtLS0NCj4gIGRyaXZlcnMv
dXNiL3R5cGVjL3RjcG0vdGNwbS5jIHwgMjkgKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi90eXBlYy90Y3BtL3RjcG0uYyBiL2RyaXZlcnMv
dXNiL3R5cGVjL3RjcG0vdGNwbS5jDQo+IGluZGV4IDM2MjBlZmVlMjY4OC4uMzAwMWRmN2JkNjAy
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi90eXBlYy90Y3BtL3RjcG0uYw0KPiArKysgYi9k
cml2ZXJzL3VzYi90eXBlYy90Y3BtL3RjcG0uYw0KPiBAQCAtMjIxMyw3ICsyMjEzLDggQEAgc3Rh
dGljIHVuc2lnbmVkIGludCB0Y3BtX3BkX3NlbGVjdF9wcHNfYXBkbyhzdHJ1Y3QNCj4gdGNwbV9w
b3J0ICpwb3J0KQ0KPiAgCXVuc2lnbmVkIGludCBpLCBqLCBtYXhfbXcgPSAwLCBtYXhfbXYgPSAw
Ow0KPiAgCXVuc2lnbmVkIGludCBtaW5fc3JjX212LCBtYXhfc3JjX212LCBzcmNfbWEsIHNyY19t
dzsNCj4gIAl1bnNpZ25lZCBpbnQgbWluX3Nua19tdiwgbWF4X3Nua19tdjsNCj4gLQl1MzIgcGRv
Ow0KPiArCXVuc2lnbmVkIGludCBtYXhfb3BfbXY7DQo+ICsJdTMyIHBkbywgc3JjLCBzbms7DQo+
ICAJdW5zaWduZWQgaW50IHNyY19wZG8gPSAwLCBzbmtfcGRvID0gMDsNCj4gDQo+ICAJLyoNCj4g
QEAgLTIyNjMsMTYgKzIyNjQsMTggQEAgc3RhdGljIHVuc2lnbmVkIGludCB0Y3BtX3BkX3NlbGVj
dF9wcHNfYXBkbyhzdHJ1Y3QNCj4gdGNwbV9wb3J0ICpwb3J0KQ0KPiAgCQkJCQljb250aW51ZTsN
Cj4gIAkJCQl9DQo+IA0KPiAtCQkJCWlmIChtYXhfc3JjX212IDw9IG1heF9zbmtfbXYgJiYNCj4g
LQkJCQkgICAgbWluX3NyY19tdiA+PSBtaW5fc25rX212KSB7DQo+ICsJCQkJaWYgKG1pbl9zcmNf
bXYgPD0gbWF4X3Nua19tdiAmJg0KPiArCQkJCSAgICBtYXhfc3JjX212ID49IG1pbl9zbmtfbXYp
IHsNCj4gKwkJCQkJbWF4X29wX212ID0gbWluKG1heF9zcmNfbXYsDQo+IG1heF9zbmtfbXYpOw0K
PiArCQkJCQlzcmNfbXcgPSAobWF4X29wX212ICogc3JjX21hKSAvIDEwMDA7DQo+ICAJCQkJCS8q
IFByZWZlciBoaWdoZXIgdm9sdGFnZXMgaWYgYXZhaWxhYmxlICovDQo+ICAJCQkJCWlmICgoc3Jj
X213ID09IG1heF9tdyAmJg0KPiAtCQkJCQkgICAgIG1pbl9zcmNfbXYgPiBtYXhfbXYpIHx8DQo+
ICsJCQkJCSAgICAgbWF4X29wX212ID4gbWF4X212KSB8fA0KPiAgCQkJCQkgICAgc3JjX213ID4g
bWF4X213KSB7DQoNClNvcnJ5IEkgZGlkbid0IHJhaXNlIHRoaXMgYmVmb3JlLCBidXQgY2FtZSB0
byBtaW5kIHRoaXMgbW9ybmluZyB3aGVuIEkgd2FzDQpjb25zaWRlcmluZyB5b3VyIHVwZGF0ZXMg
YWdhaW4uIFdoYXQgaGFwcGVucyBpZiB0aGUgU291cmNlIHZhbGlkbHkgcHJvdmlkZXMgdHdvDQpQ
UFMgQVBET3MsIGZvciBleGFtcGxlOg0KDQoJMy4zViAtIDExViwgM0EgKDlWIHByb2dyYW1tYWJs
ZSkNCgkzLjNWIC0gMTZWLCAzQSAoMTVWIHByb2dyYW1tYWJsZSkNCg0KYW5kIHRoZSBzaW5rIEFQ
RE8gaXM6DQoNCgk1ViAtIDlWLCAzQQ0KDQpJIHRoaW5rIHRoZSBjb2RlIGhlcmUgd2lsbCBub3cg
c2VsZWN0IHRoZSBoaWdoZXIgcmFuZ2UgKDE1ViBwcm9ncmFtbWFibGUpIGFzIGl0DQpnaXZlcyBh
IGxhcmdlciBwb3dlciBvdXRwdXQgdmFsdWUsIGV2ZW4gaWYgdGhlIHNpbmsgY2FuIG9ubHkgc3Vw
cG9ydCBhIHZvbHRhZ2UNCnRoYXQncyBmYXIgc21hbGxlci4gSSByZWFsbHkgZG9uJ3QgdGhpbmsg
dGhpcyBpcyBjb3JyZWN0LiAqSWYqIHlvdSBhcmUgZ29pbmcgdG8NCmFsbG93IHNlbGVjdGlvbiBv
ZiBQUFMgQVBET3MgdGhhdCBwcm92aWRlIGEgbGFyZ2VyIHZvbHRhZ2UgcmFuZ2UgdGhhbiB0aGUg
U2luaw0KY2FuIGFjdHVhbGx5IGNvcGUgd2l0aCwgdGhlbiBJIHRoaW5rIHlvdSBzaG91bGQgYXQg
bGVhc3Qgc2VsZWN0IHRoZSBsb3dlciBvZg0KdGhvc2UgYWR2ZXJ0aXNlZCB3aGljaCBmdWxmaWxz
IHRoZSBuZWVkcyBvZiB0aGUgU2luay4NCg0KPiAgCQkJCQkJc3JjX3BkbyA9IGk7DQo+ICAJCQkJ
CQlzbmtfcGRvID0gajsNCj4gIAkJCQkJCW1heF9tdyA9IHNyY19tdzsNCj4gLQkJCQkJCW1heF9t
diA9IG1heF9zcmNfbXY7DQo+ICsJCQkJCQltYXhfbXYgPSBtYXhfb3BfbXY7DQo+ICAJCQkJCX0N
Cj4gIAkJCQl9DQo+ICAJCQl9DQo+IEBAIC0yMjg1LDE0ICsyMjg4LDE2IEBAIHN0YXRpYyB1bnNp
Z25lZCBpbnQgdGNwbV9wZF9zZWxlY3RfcHBzX2FwZG8oc3RydWN0DQo+IHRjcG1fcG9ydCAqcG9y
dCkNCj4gIAl9DQo+IA0KPiAgCWlmIChzcmNfcGRvKSB7DQo+IC0JCXBkbyA9IHBvcnQtPnNvdXJj
ZV9jYXBzW3NyY19wZG9dOw0KPiAtDQo+IC0JCXBvcnQtPnBwc19kYXRhLm1pbl92b2x0ID0gcGRv
X3Bwc19hcGRvX21pbl92b2x0YWdlKHBkbyk7DQo+IC0JCXBvcnQtPnBwc19kYXRhLm1heF92b2x0
ID0gcGRvX3Bwc19hcGRvX21heF92b2x0YWdlKHBkbyk7DQo+IC0JCXBvcnQtPnBwc19kYXRhLm1h
eF9jdXJyID0NCj4gLQkJCW1pbl9wcHNfYXBkb19jdXJyZW50KHBkbywgcG9ydC0+c25rX3Bkb1tz
bmtfcGRvXSk7DQo+ICsJCXNyYyA9IHBvcnQtPnNvdXJjZV9jYXBzW3NyY19wZG9dOw0KPiArCQlz
bmsgPSBwb3J0LT5zbmtfcGRvW3Nua19wZG9dOw0KPiArDQo+ICsJCXBvcnQtPnBwc19kYXRhLm1p
bl92b2x0ID0NCj4gbWF4KHBkb19wcHNfYXBkb19taW5fdm9sdGFnZShzcmMpLA0KPiArCQkJCQkg
ICAgICBwZG9fcHBzX2FwZG9fbWluX3ZvbHRhZ2Uoc25rKSk7DQo+ICsJCXBvcnQtPnBwc19kYXRh
Lm1heF92b2x0ID0NCj4gbWluKHBkb19wcHNfYXBkb19tYXhfdm9sdGFnZShzcmMpLA0KPiArCQkJ
CQkgICAgICBwZG9fcHBzX2FwZG9fbWF4X3ZvbHRhZ2Uoc25rKSk7DQo+ICsJCXBvcnQtPnBwc19k
YXRhLm1heF9jdXJyID0gbWluX3Bwc19hcGRvX2N1cnJlbnQoc3JjLCBzbmspOw0KPiAgCQlwb3J0
LT5wcHNfZGF0YS5vdXRfdm9sdCA9DQo+IC0JCQltaW4ocGRvX3Bwc19hcGRvX21heF92b2x0YWdl
KHBkbyksIHBvcnQtDQo+ID5wcHNfZGF0YS5vdXRfdm9sdCk7DQo+ICsJCQltaW4ocG9ydC0+cHBz
X2RhdGEubWF4X3ZvbHQsIHBvcnQtDQo+ID5wcHNfZGF0YS5vdXRfdm9sdCk7DQo+ICAJCXBvcnQt
PnBwc19kYXRhLm9wX2N1cnIgPQ0KPiAgCQkJbWluKHBvcnQtPnBwc19kYXRhLm1heF9jdXJyLCBw
b3J0LT5wcHNfZGF0YS5vcF9jdXJyKTsNCj4gIAl9DQo+IC0tDQo+IDIuMjAuMC40MDUuZ2JjMWJi
YzZmODUtZ29vZw0KDQo=
