Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7F0C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848D020852
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=LenovoBeijing.onmicrosoft.com header.i=@LenovoBeijing.onmicrosoft.com header.b="n60EICOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848D020852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lenovo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbeGZCoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 22:44:05 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.114]:26614 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728523AbeGZCoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 22:44:04 -0400
Received: from [67.219.250.198] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.us-west-2.aws.symcld.net id 52/D3-01618-304295B5; Thu, 26 Jul 2018 01:29:39 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VTf0wTZxjed3e9no7To8D4YKBZ3aIjaaHo5je
  3JUtM3LnMbJhs6mA/ipy0rhTSKxE1WyA1YOyQQgRiC51GMhiyMetItq7yo9v4JVKBAQPtCFgn
  GFZYQLIFbHbXq267Py7P8z7P+77PfbmPwhUT8kSKKzJzJqPWoCTXE7rZaUyFPXsoM83X/yRq7
  e/G0WV/BYmG15YBqi3xyVFt9U2AeidKSHQt6JAhy6VWEnXfnCOQo9aCIc+1PgKNuOtIZKm8JU
  e2ixYcNfaEMFR5b5VAS4OlclR65QFAvoc9MjRp68bQ6l+C2fPzafy1p9iuGS/JXm1KYS955jB
  25EYh6+zLYDvqW+Ss1REi2D/vThLsQvsoyQ5c+EnOXr1+kl1ybWLLOq0Y6wr8gbG+qZD87Y3v
  yfTG7Pyij2S65R9/wQuWySLndStZDGbJM2A9pWACAM5bfsAl4gXQ3/E3JhKCacKhzV0fUc5is
  DlQJpOIH8Ap2wOBrKNI5nnYNz8WdsUyKwC6x8eASHAmRMKapiuk6IphMmHV6MUwjmWyoG1gSC
  7hdBgsuxfGBPMcDCx8homYFjxrI/WEiBVMLnRYG8L1dcyr8FxLZ7gOmGRYMzMVruNMPKyvsYc
  TQYaBDR4fLuE4OHcnFKlvhhWXywkJJ8Phz63hoJApx2Gn49dIwz44v+IhJKEHQOfskiBQAkmB
  i2O7RAiY/TD47QeS/WNY2/81JuGX4fx0dWT+JthcPh0Z48Lh4MDpSIgkGFxqISU8I4NdpbtsQ
  GX/zzfYhRW4cKqt7lSp/Aw8Z52W28PHEg37zgeIC4BoBjuzTfpcnTlPqzeoNGlpKo0mXaXZvl
  2leVGtPaHKVhfyqmMcb1alq7XHeDV/PO+wIUdt5MwuIPzaTwjPd+CON8cLEihMGUfv33swU7E
  hOz/nuE7L6z40FRo43guSKEoJ6e+VhzIV0SYulys6ojcI9+ORDKkoZSzdLso0X6DN4/W5ktQP
  XqKcX1ZV4dTaQrXwvm2tqcIVhDHfyCXG01u2CA2M2KArND4e9+jGDYPkxBgaCAEVUQWcKU9v/
  r9+H8RTQBlDd4hro/RG8+Ot94VAmBAo7vA7YiCz9l8psRgA/8DKUFbvwyHX+z30023+d0cbj+
  7IapxMKvu9zv6JvS3Yemr38viEte3Em28w+pPbPqXH2ywH6RcS4hrcFV/5XjdmbPiiKyF1b+8
  Ov2nr4sZ9mw/cwgZDdafaj65OaI5sy1q8bXrrlT22A7vv3siI/ubsztSt48Y9Z2YruRLuN5ez
  2KskeJ1Wk4KbeO0/5VP9+GwEAAA=
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-30.tower-346.messagelabs.com!1532568572!1286543!1
X-Originating-IP: [104.232.225.2]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17637 invoked from network); 26 Jul 2018 01:29:37 -0000
Received: from unknown (HELO maesmtp01.lenovo.com) (104.232.225.2)
  by server-30.tower-346.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 26 Jul 2018 01:29:37 -0000
Received: from USEXEDGE02.lenovo.com (unknown [10.62.65.5]) by maesmtp01.lenovo.com with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-SHA)
         id 2ab4_581c_dcf6cc64_618e_412e_904e_b72b9358c77a;
        Thu, 26 Jul 2018 01:29:28 +0000
Received: from APC01-PU1-obe.outbound.protection.outlook.com (65.55.88.21) by
 USEXEDGE02.lenovo.com (10.62.65.5) with Microsoft SMTP Server (TLS) id
 14.3.389.1; Wed, 25 Jul 2018 21:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector1-lenovo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Y8VqAQJrZV+Pbi2qKj1pRPmRP109srm5rhBthUd9Cg=;
 b=n60EICOaQShwIVYD/37SQBrgkw7hJKYA4CK/a+VlDPFIYMryKy+Cw06pqdZWGE8ne3V4Zy2e7SARv0rZDzRAh44ATX3JlgXESJad37otLJx3Q8WmizwgLraIKTxidN38EamtZf66hfsj4n6eKSV5153/iuJITooYXDFBZVHGP0Q=
Received: from TY2PR03MB3343.apcprd03.prod.outlook.com (20.177.20.145) by
 TY2PR03MB3630.apcprd03.prod.outlook.com (20.177.22.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.13; Thu, 26 Jul 2018 01:29:22 +0000
Received: from TY2PR03MB3343.apcprd03.prod.outlook.com
 ([fe80::ac73:48dc:59b:aa89]) by TY2PR03MB3343.apcprd03.prod.outlook.com
 ([fe80::ac73:48dc:59b:aa89%3]) with mapi id 15.20.0995.014; Thu, 26 Jul 2018
 01:29:21 +0000
From:   Huaisheng HS1 Ye <yehs1@lenovo.com>
To:     Dave Jiang <dave.jiang@intel.com>,
        "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "jack@suse.cz" <jack@suse.cz>
CC:     "willy@infradead.org" <willy@infradead.org>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>,
        "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bart.vanassche@wdc.com" <bart.vanassche@wdc.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        NingTing Cheng <chengnt@lenovo.com>,
        "colyli@suse.de" <colyli@suse.de>, Huaisheng Ye <yehs2007@zoho.com>
Subject: RE: [External]  Re: [PATCH v2 0/6] kaddr and pfn can be NULL to
 ->direct_access()
Thread-Topic: [External]  Re: [PATCH v2 0/6] kaddr and pfn can be NULL to
 ->direct_access()
Thread-Index: AQHUJF+ONha2A8Ufp0G8aERNK9fMsKSgssBg
Date:   Thu, 26 Jul 2018 01:29:19 +0000
Message-ID: <TY2PR03MB3343365E80CCBC374C0EFDD4922B0@TY2PR03MB3343.apcprd03.prod.outlook.com>
References: <20180725162849.8320-1-yehs2007@zoho.com>
 <3689520a-4a49-4e1f-6ee9-2ff4a9796b9f@intel.com>
In-Reply-To: <3689520a-4a49-4e1f-6ee9-2ff4a9796b9f@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [57.197.58.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY2PR03MB3630;20:10lvqvbcZ28twUX/VieqUT2Amm5sXRNKs4b1aqMnErQ2ANwuTVY0EmyF1qBrVVtsWmDtS17Rl3esKbwWB3unrSIt2opqeP4We3U0kOKtpMhIRlugxfhKYB3MiNZq+4NKO/ou5l761Y6pME0A2jQzla0XmXZjNRBKLQ/FMId8Jz+g47ZAwa0e8+gNOT/kaar9dY9n9pYZxxyVfFljeQCQ1tF8BF1QI99gOhMTAhZsJ4PZ/wyRb5c22bkSUvw84rqen8U+g0PpoiizudatX4udL/gihFKDHnAJG4Xj+TMMUpGH07/obz/Dc7E36eDKu9qyPcu8WZ7JhOenl6u1X32SQQ==
x-ms-office365-filtering-correlation-id: 9adbb744-137e-439a-7ea7-08d5f29736f8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:TY2PR03MB3630;
x-ms-traffictypediagnostic: TY2PR03MB3630:
x-microsoft-antispam-prvs: <TY2PR03MB3630570C9CBB81D6C598B81B922B0@TY2PR03MB3630.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:TY2PR03MB3630;BCL:0;PCL:0;RULEID:;SRVR:TY2PR03MB3630;
x-forefront-prvs: 07459438AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(366004)(396003)(39850400004)(376002)(199004)(189003)(99286004)(53546011)(6506007)(5660300001)(76176011)(102836004)(7696005)(26005)(54906003)(2900100001)(256004)(14444005)(478600001)(110136005)(68736007)(11346002)(14454004)(8676002)(486006)(229853002)(446003)(7416002)(186003)(81156014)(81166006)(8936002)(6436002)(86362001)(105586002)(476003)(106356001)(6116002)(74316002)(66066001)(2201001)(7736002)(305945005)(9686003)(3846002)(55016002)(97736004)(25786009)(2906002)(316002)(53936002)(5250100002)(33656002)(6246003)(2501003)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2PR03MB3630;H:TY2PR03MB3343.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: lenovo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FAJBZ998y7msgWFxUW+Moi1Mspk/xnpseffS+f2RKg8XRp0iqB/psJK5EeXvUlkj+IPtkem+K3VQBPx71zD5udL7cs/GmhwzoU+jf7WdpQTFS1eKk3KT/J5NL7M2m146Vk4gy0gU0L0xGJ1sgGbMp5aX2qDiICaE6JXwkL/bs4l20u8K08jPHVM1jmDDXT6qlo7IOBXFAXxQU5yNw7amZz//oMftamV2GSk3iB1TeebX38QdezlCfv0WsPxW09rtN2v+6iFRlmBaWNDrPCsrAb7qsCz6FcYlzaKyC9SKF2z6jLlgTgN1oMb0xUNgqjv8Q8tEPrHWEcmr2lo7kkh2Xk5NBEAzisneAfHlqQF/Fhc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9adbb744-137e-439a-7ea7-08d5f29736f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2018 01:29:21.2757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR03MB3630
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBEYXZlIEppYW5nIDxkYXZlLmppYW5nQGludGVsLmNvbT4NCj4gU2VudDogVGh1cnNk
YXksIEp1bHkgMjYsIDIwMTggNTozNiBBTQ0KPiBTdWJqZWN0OiBbRXh0ZXJuYWxdIFJlOiBbUEFU
Q0ggdjIgMC82XSBrYWRkciBhbmQgcGZuIGNhbiBiZSBOVUxMIHRvIC0+ZGlyZWN0X2FjY2Vzcygp
DQo+IA0KPiBQcmV0dHkgc3RyYWlnaHQgZm9yd2FyZCBzZXJpZXMuIEh1YWlzaGVuZywgSSBjYW4g
YXBwbHkgdGhlIHdob2xlIHNlcmllcw0KPiB0byBsaWJudmRpbW0gaWYgd2UgY2FuIGdldCBhY2sn
cyBmcm9tIG1haW50YWluZXIgb2YgZGNzc2JsayBhbmQNCj4gZG0td3JpdGVjYWNoZSBmb3IgdGhl
IHJlc3BlY3RpdmUgYml0cy4NCg0KVGhhbmtzIERhdmUgYW5kIFJvc3MuDQoNCkhpIEphbiBhbiBE
YW4sDQoNClRoZSBwcmV2aW91cyBwYXRjaCBzZXJpZXMgZm9yIE5VTEwtcGZuIGhhZCBnb3QgeW91
ciBSZXZpZXdlZC1ieSBvciBTaWduZWQtb2ZmLWJ5Lg0KTm93IEkgaGF2ZSBleHBhbmRlZCB0aGVt
IHRvIGxvY2FsIHBvaW50ZXIga2FkZHIsIGNhbiBJIGdldCB5b3VyIFJldmlld2VkLWJ5IGZvciBj
dXJyZW50DQpwYXRjaCBzZXJpZXM/IFlvdXIgYWNrcyBhcmUgdmVyeSBpbXBvcnRhbnQgdG8gbWUu
DQoNCkNoZWVycywNCkh1YWlzaGVuZyBZZQ0K
