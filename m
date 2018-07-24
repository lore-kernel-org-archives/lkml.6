Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F476C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A50C20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=LenovoBeijing.onmicrosoft.com header.i=@LenovoBeijing.onmicrosoft.com header.b="osuBXNN7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A50C20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lenovo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388642AbeGXPf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:35:28 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.1]:41641 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388460AbeGXPf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:35:28 -0400
Received: from [67.219.246.102] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.us-east-1.aws.symcld.net id CC/D1-01620-397375B5; Tue, 24 Jul 2018 14:28:35 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTf0wbZRzG995de8fC6dFSecUxtyYzSmylGMc
  tGln8x0vU6UwMiTNuB73RxrZgr82KZhGoEUPpgMoPbQfi2OSHczCY6Egngq6lZAME5twozrKS
  WhQNYXFkG413vW7q/fHmeb+f532/z/vmXgJVfI9nE5zDxlktrEkt34wZfosgmo8KivblVS3n0
  l8s1MvpmTs3AN3a/TVGtzZPA3r8SpWcdnb2yenAdByjfa1OhPafC2H07PBRATTO43TDZ06U7g
  omELoxdhuj1yY/wOmpjaCMvtoQQOjb64LPf/5DdLeSGV0ckzOD3blMpz+OMLMX7Ux7aC8z0nY
  SZ1y+BMasLl3FmAsdP+DM2sBWpuY7F8IMRFcQZupaAn+FfF1mtBSXOQ7IDItLdXj5hTRHtyuM
  VgJ/Wi3YTCioGICDt1pRaRIA8MjUvLwWpBEY1Y3CyIlDEqhHYH/0JC5NFgC89HcQF11y6jEY+
  uMnYTlBZFL50Ll6WPSgVBiH34ZcMtGjpPbDyHQ1IupM6gDsCQzjks6HQ/MXUanbDrg+ciXpIa
  k34NpKLxC1gvoYgaPValGnUc/C1b7R5J6AyoEti9eSfpTKgm0t3mQdUhQ87p9CJa2C8esJmZg
  NUK/CP8+8KZXV0HcrmrLkwJlPXUDMDCk3Cmd/rgcS0MFgzwgqgbAMtnuvYxJ4Cd4c9OGSDgJY
  VfOypHPhqYlzKc9bMFrdk9IvwvjZ8VS3rbDXHUnVB1DoOcs1gCe8/zmDV8iKCnfaN5wqb4dNr
  gjuTV5LBgx9EsU6ANYLdhZbjaUGm5k1mjS6vDyNTpev0Wl0BQVa9h1NsdbOaziWt2l0WvYQr+
  UrzCUmvdbC2QaA8PtuEr5vgG9dPwYeJBC1ijQ9XLRPcV9xmb7CwPKG/Va7iePHwBaCUEPy8k6
  BZVi5Us5x0GgS3sBdDIl0dSYZFTHJl7Nm3lgqoQlQSLT3eDwoUfdLkzDe+atZGMOuFg+qwCxl
  Fi47i5QJj0dBicsMdsu9Te++rRmQk60kgRBTkV7OWc1G2//5MsgigFpJ1onN040W273ey0IsR
  IilKnlNjGVj/0XZlWD38dUyx5DXff9Xj7dlVDapHq2p3djjPv/c5LYfJyP1ceXhZk/X531dT7
  8bW3FmbhTGNr2tf+TmMfOZ8f4O9wMlc53Hnl8KgP4hfaTCtuXE5WDjkyMPGVS73nvm1C6Z/fe
  wac+XpxeGE0deaL5U+OvonJ/edkNV9D4y1xR9amLH6YPxWLka4w2sLhe18uw/cc155FYEAAA=
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-2.tower-386.messagelabs.com!1532442515!1086270!1
X-Originating-IP: [104.232.225.2]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12902 invoked from network); 24 Jul 2018 14:28:35 -0000
Received: from unknown (HELO maesmtp01.lenovo.com) (104.232.225.2)
  by server-2.tower-386.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 24 Jul 2018 14:28:35 -0000
Received: from HKGWPEXCH02.lenovo.com (unknown [10.128.62.31]) by maesmtp01.lenovo.com with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-SHA)
         id 055d_9e6e_11be0613_4b9f_4616_8547_254e9025e626;
        Tue, 24 Jul 2018 14:28:32 +0000
Received: from APC01-HK2-obe.outbound.protection.outlook.com (65.55.88.207) by
 HKGWPEXCH02.lenovo.com (10.128.62.31) with Microsoft SMTP Server (TLS) id
 14.3.389.1; Tue, 24 Jul 2018 22:28:26 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector1-lenovo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypZ6iNIDfK0Q7008FGPTJj1qCP7iNyIYfvlBcsAwi5Q=;
 b=osuBXNN7fnwrBVdbCEINTuDfHgFuN9dOGd2i7uq+HkwtegHknOmSaH4vFvJSFL/oLg3vB1G+Vpc/+R1K+Y2N/9YM3YVS/lQNG3p/aza/e/eZCScX0YPWkSV7IyDbS20ESKYym3OUY+WoCR/OBDcyvrTvsbWp9N5ydxU5ZDPP3Ds=
Received: from TY2PR03MB3343.apcprd03.prod.outlook.com (20.177.20.145) by
 TY2PR03MB3888.apcprd03.prod.outlook.com (20.177.79.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.14; Tue, 24 Jul 2018 14:28:25 +0000
Received: from TY2PR03MB3343.apcprd03.prod.outlook.com
 ([fe80::ac73:48dc:59b:aa89]) by TY2PR03MB3343.apcprd03.prod.outlook.com
 ([fe80::ac73:48dc:59b:aa89%3]) with mapi id 15.20.0995.014; Tue, 24 Jul 2018
 14:28:23 +0000
From:   Huaisheng HS1 Ye <yehs1@lenovo.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
CC:     "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>,
        "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bart.vanassche@wdc.com" <bart.vanassche@wdc.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        NingTing Cheng <chengnt@lenovo.com>,
        Huaisheng Ye <yehs2007@zoho.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: RE: [External] Re: [PATCH 3/5] s390, dcssblk: Allow a NULL-kaddr to
 ->direct_access()
Thread-Topic: [External] Re: [PATCH 3/5] s390, dcssblk: Allow a NULL-kaddr to
 ->direct_access()
Thread-Index: AQHUIz/bjbgmHuiTBkutWaRGZ1YXlqSebNNw
Date:   Tue, 24 Jul 2018 14:28:23 +0000
Message-ID: <TY2PR03MB3343CC5CD32DBD527DABFDE592550@TY2PR03MB3343.apcprd03.prod.outlook.com>
References: <20180724084510.6104-1-yehs2007@zoho.com>
 <20180724084510.6104-4-yehs2007@zoho.com>
 <192a9dac-921f-e222-3a7d-32d43679cd12@de.ibm.com>
 <TY2PR03MB3343901A038D3E3D836C438992550@TY2PR03MB3343.apcprd03.prod.outlook.com>
 <814b615b-fc5d-627a-a11e-c54796b1b08d@de.ibm.com>
In-Reply-To: <814b615b-fc5d-627a-a11e-c54796b1b08d@de.ibm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [123.120.61.139]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY2PR03MB3888;20:HTVAQPWnKM+SO5h10p5G6HGI6zpo0z4tyHtecDyiZ9ioCoqXKpAoIfvqC2TU89MYbjOmsELIryP8ESv66fWL+bpGGUvKA4Qfo2mtQh/hLnAwv/gv3Tfn5wfDDH6f1v23QvvqWdV1etZ1e7GBWCzn6ewJVs5eSveq2KsgjfWfNkpEYBRuLlC+G+pajZtcLbMuhxumwwV/vbMfEn5JZL20kAoUNccqSJLUWbeJfkG4BOw8EVNpCCkxBGu3VU7M3RlBCNcT7DZUKTi8KyNScSHMf1+nMrHnCnlKgK0w1e2DmMuizW3XUA00aetMZaayP29ogXwpLX0Ulu9avOq1rpCiaw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39850400004)(396003)(136003)(189003)(199004)(55016002)(486006)(316002)(6436002)(99286004)(26005)(76176011)(74316002)(33656002)(446003)(14454004)(53936002)(25786009)(2900100001)(4326008)(54906003)(9686003)(81156014)(3846002)(476003)(86362001)(11346002)(6116002)(102836004)(81166006)(97736004)(105586002)(6246003)(8676002)(68736007)(5660300001)(478600001)(6916009)(305945005)(8936002)(6506007)(7736002)(186003)(256004)(7696005)(2906002)(5250100002)(66066001)(106356001)(93886005)(7416002)(229853002)(9126004);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2PR03MB3888;H:TY2PR03MB3343.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: aad76c11-3bae-49ba-a605-08d5f171b688
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:TY2PR03MB3888;
x-ms-traffictypediagnostic: TY2PR03MB3888:
x-microsoft-antispam-prvs: <TY2PR03MB388821E0BDA8E88043076AD492550@TY2PR03MB3888.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(190383065149520)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:TY2PR03MB3888;BCL:0;PCL:0;RULEID:;SRVR:TY2PR03MB3888;
x-forefront-prvs: 0743E8D0A6
Received-SPF: None (HKGWPEXCH02.lenovo.com: yehs1@lenovo.com does not
 designate permitted sender hosts)
received-spf: None (protection.outlook.com: lenovo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GaDa6pK+0Eg9L7etlqE3DGcJjNjPaV2Rogu1srCfTVDql9awvZc0ThyGb3SWkT7sDXMrfFQwV9rlaFKUnq33hPcNTJ/eXE7L+OH1gp8KfcRd2yXnTUGVM+JSMuxowBKHVuN8x6mAr4ejY36HYdGSwREw+0ZutsFaqQ1PyH8/CpaqTmm8MEZsPGieouwh1oKT75jkYomj2Xo6OL17sCJdu6XSJMERu1EwFOfvc26oWDJPWdp6ICefq4aK3qK7I21vJy6Ztxvdfwy8PKb/R8xzepQxx8GsL7GY5o7bWCwvDordIs0bvqdMm4/AaAF9rRitOHZYCxt8RPYg+LYI4O/RDEDrl69qnwQFsL4NrDkKppo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: aad76c11-3bae-49ba-a605-08d5f171b688
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2018 14:28:23.6318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR03MB3888
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2hyaXN0aWFuIEJvcm50cmFlZ2VyIDxib3JudHJhZWdlckBkZS5pYm0uY29tPg0KU2Vu
dDogVHVlc2RheSwgSnVseSAyNCwgMjAxOCA3OjE2IFBNDQo+ID4+IFNvIHlvdSBhcmUgdHJhZGlu
ZyBvZiBhIGxvYWQgKyBhZGQgKGRldl9pbmZvLT5zdGFydCBzaG91bGQgYmUgY2FjaGUgaG90KSBh
Z2FpbnN0IGENCj4gPj4gY29tcGFyZSticmFuY2ggLiBOb3Qgc3VyZSB0aGF0IHRoaXMgaXMgYWx3
YXlzIGEgd2luLg0KPiA+DQo+ID4gSG1tLi4udGhlIGNhbGN1bGF0aW9uIHByb2Nlc3Mgb2YgcGZu
IGlzIG1vcmUgY29tcGxpY2F0ZWQgdGhhbiBrYWRkci4gSSB0aGluayB5b3UgYWdyZWUgdG8NCj4g
Y2hlY2sgcGZuIGJ1dCBub3Qgc3VyZSBrYWRkciwgcmlnaHQ/DQo+ID4gRnJvbSB0aGUgbG9naWNh
bCBjb25zaXN0ZW5jeSBvZiBjb2RlLCBJIHRoaW5rIGl0IHNoYWxsIGJlIGJldHRlciB0byBnaXZl
IHBmbiBhbmQga2FkZHIgc2ltaWxhcg0KPiB0cmVhdG1lbnQuDQo+IA0KPiBSZWFkaW5nIGl0IGFn
YWluLCBpdHMgbW9yZSB0aGF0IEkgZG8gbm90IGxpa2UgdGhlIHBhdGNoIGRlc2NyaXB0aW9uLiBJ
dCByZWFkcw0KPiBsaWtlIGFuIG9wdGltaXphdGlvbiwgKGFuZCBJIHRoaW5rIGl0IGlzIG5vdCkg
YnV0IGl0IHNob3VsZCByYXRoZXIgcmVhZCBtb3JlDQo+IGxpa2UgIndpdGggYW4gdXBjb21pbmcg
Y2hhbmdlIGthZGRyIGNhbiBiZSBOVUxMIiBvciBzby4NCg0KVGhhbmtzIGZvciBzdWdnZXN0aW9u
LCBJIHdpbGwgcmV3b3JkIHRoZSBwYXRjaCBkZXNjcmlwdGlvbiBkdXJpbmcgbmV4dCBzdWJtaXNz
aW9uLg0KRG9lcyB0aGUgcGF0Y2ggaXRzZWxmIG5lZWQgdG8gYmUgbW9kaWZpZWQ/IElmIGhhcywg
YW55IHN1Z2dlc3Rpb24gaXMgd2VsY29tZS4NCg0KQ2hlZXJzLA0KSHVhaXNoZW5nIFllDQo=
