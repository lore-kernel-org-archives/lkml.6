Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64188C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC368204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="AmPfhaHk";
	dkim=pass (1024-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="EAsNgBFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC368204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ericsson.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeJKSWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 14:22:06 -0400
Received: from sessmg23.ericsson.net ([193.180.251.45]:50723 "EHLO
        sessmg23.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeJKSWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 14:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=ericsson.com; s=mailgw201801; c=relaxed/simple;
        q=dns/txt; i=@ericsson.com; t=1539255319; x=1541847319;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=E0m+VXwLR3ZwKUYWzjfuLq0dD4Kh8KPAxhu6AWI1YdY=;
        b=AmPfhaHksWkXJ+5kqszjz7vL7EsPjiJsrgaavdtHRVrLqNdoWmUfooZ4aCSB0Vco
        ImwyRb5SIbBJnbx4CUbLeZfDotTMXQwXOPgQcCku1fzwMoR9krCijmZ2eViZnOzb
        bsA0tcpO/rRjOTnAJTyzClgRvpf/wpW5Mw/SU4va5I0=;
X-AuditID: c1b4fb2d-fb3d09e000003a27-45-5bbf2c17ade4
Received: from ESESSMB504.ericsson.se (Unknown_Domain [153.88.183.122])
        by sessmg23.ericsson.net (Symantec Mail Security) with SMTP id A3.FC.14887.71C2FBB5; Thu, 11 Oct 2018 12:55:19 +0200 (CEST)
Received: from ESESSMR506.ericsson.se (153.88.183.128) by
 ESESSMB504.ericsson.se (153.88.183.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1466.3; Thu, 11 Oct 2018 12:55:16 +0200
Received: from ESESBMB502.ericsson.se (153.88.183.169) by
 ESESSMR506.ericsson.se (153.88.183.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1466.3; Thu, 11 Oct 2018 12:55:16 +0200
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (153.88.183.157)
 by ESESBMB502.ericsson.se (153.88.183.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1466.3 via Frontend Transport; Thu, 11 Oct 2018 12:55:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0m+VXwLR3ZwKUYWzjfuLq0dD4Kh8KPAxhu6AWI1YdY=;
 b=EAsNgBFvLW8/Eiob/1ryAqwvrnG0o7RkK0CrxvTIBAKl4aVtcH6YDBws8vt1LPd70m6T4WhPJHPeM//rdOflZAfG70NSeiVcS3QMV3b+oFhqfEHJgnzO3c212A5t+WRDaKealNtn75h7qNaE0lJQbZW82Ho9wIi1yfUVPrKwmhU=
Received: from DM5PR15MB1513.namprd15.prod.outlook.com (10.173.225.146) by
 DM5PR15MB1419.namprd15.prod.outlook.com (10.173.225.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Thu, 11 Oct 2018 10:55:13 +0000
Received: from DM5PR15MB1513.namprd15.prod.outlook.com
 ([fe80::d98e:89f4:67f0:9caa]) by DM5PR15MB1513.namprd15.prod.outlook.com
 ([fe80::d98e:89f4:67f0:9caa%4]) with mapi id 15.20.1228.020; Thu, 11 Oct 2018
 10:55:13 +0000
From:   Jon Maloy <jon.maloy@ericsson.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        "parthasarathy.bhuvaragan@ericsson.com" 
        <parthasarathy.bhuvaragan@ericsson.com>,
        David Miller <davem@davemloft.net>,
        Ying Xue <ying.xue@windriver.com>,
        netdev <netdev@vger.kernel.org>,
        "tipc-discussion@lists.sourceforge.net" 
        <tipc-discussion@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Parthasarathy Bhuvaragan <parthasarathy.bhuvaragan@gmail.com>
Subject: RE: net/tipc: recursive locking in tipc_link_reset
Thread-Topic: net/tipc: recursive locking in tipc_link_reset
Thread-Index: AQHUYTfZQc9PfXVAEEyWjugxlcoluqUZ3nyQ
Date:   Thu, 11 Oct 2018 10:55:13 +0000
Message-ID: <DM5PR15MB15134EF6AA09E8268FA58D519AE10@DM5PR15MB1513.namprd15.prod.outlook.com>
References: <CACT4Y+bcxEz=P2E5TRj6A1qeCOQ+WtWR44WGLzqdDttLzD393A@mail.gmail.com>
In-Reply-To: <CACT4Y+bcxEz=P2E5TRj6A1qeCOQ+WtWR44WGLzqdDttLzD393A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jon.maloy@ericsson.com; 
x-originating-ip: [198.24.6.220]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1419;6:p8pvWhqXg42GbGqfKQgwsGgcaAXKRJA7WYBxgsMDrQEO2cOrd9iyqewGbOMWC5o8WYXqF37Lru1zVLt+UtrPCVb5B2MOD2Nc8JbPiwekExAhtfYJPnWNC53wdXJ2JTk4nA3TqpOJb0iZMaWE2xI/wM2cGjo2VrSUB75HTIvGp0d7rmaHxTBIG44tRUvip0cJxht0m4Y0tiljx00EiXEEf+KnSSOdrpzCddjkljV2K+uNV8rg45/pol7RYpbnzLXIqfhaQx3qFT3PhlgiX9ctR9oQpDV0V+tb1rF6eBBdsd2sxTwQPSQWGwcX2TGYmsOxNhRERyRpcwbRZ08xCFONKie5H3NHFf2/WK9thIoRL9FZXvQvgkyxazL7uuXa36YkUjexST0V3V/PazRJZNVhyibBZz7usLkWk/0vLuuOoGhOPXBIDfKc4GYR0fSVpmnbd6ZoDtj1fQeQtl87AD03nQ==;5:2Nz1JyGl/DeeD3PkRNKgmygtNxtMd91sOncuB1VYD5QTIuWS++W6gQrj4yd8EqjK4xs1F5Z8mY4obKISisEzsSJAfYHZ2/4nKLRQ0SpUje+wb2gYk1cj8dWzk92ARhr/o8N61rrA8tZ9zeeIYcKQYdGsDOphzbQZ/3bKMrCKT0Y=;7:2U8G6XeiY4BigXbOdWj5Ch+4IZvldYowro61igB6FZdIsHti3ypax/JETvbBF/2XLMr1bZX0bjduZS+i/OUZp7qJsRg+Bi2EAeDS9AiXwXrz5NZgOLD9rF2YXXsSeNCfK8FdOQYenK/TIh/WzkayOI60+GoRFb8pcomJsZiP7w4NVXkfZhCGOJXH4t53WFhJQDSiuo6TCBbZCnKzI0KNzh9wASOpo2msj3K2NuEKF1MD/MV/DFVtfjYVld0ou9uD
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: baed0c94-9179-4fc3-c22f-08d62f6805b4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1419;
x-ms-traffictypediagnostic: DM5PR15MB1419:
x-microsoft-antispam-prvs: <DM5PR15MB141958A7484000D284A7780A9AE10@DM5PR15MB1419.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(37575265505322)(248295561703944)(143289334528602)(42262312472803)(211936372134217)(153496737603132)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:DM5PR15MB1419;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1419;
x-forefront-prvs: 08220FA8D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(376002)(366004)(39860400002)(13464003)(189003)(199004)(5250100002)(2900100001)(2501003)(478600001)(256004)(14444005)(5024004)(33656002)(102836004)(68736007)(186003)(26005)(25786009)(8676002)(106356001)(81166006)(81156014)(4326008)(39060400002)(105586002)(74316002)(99286004)(53546011)(6506007)(7736002)(76176011)(71190400001)(97736004)(71200400001)(7696005)(305945005)(3846002)(6116002)(9686003)(14454004)(446003)(86362001)(55016002)(53936002)(575784001)(5660300001)(66066001)(316002)(229853002)(486006)(44832011)(2906002)(110136005)(6246003)(8936002)(11346002)(6436002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR15MB1419;H:DM5PR15MB1513.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ericsson.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: A2rZOrN53Z88zL9V1KD19034td90Zr6sGtqbi8d839Tv5sN9YNEMvOfyrjzuV7m24eZ9YWP8boezloTwoctUkJK6swPrioFtdMz1cMCcTABgW2VBHQyOZ4/Vmc1zeIl3GZ9MXrmRjIoau4F6jMZ8RvwSnc36Hhyh1v252cl4YGjK4xv2uktRnLJiPWzP1VbfIk0vW+rq5EHLlcP3Ek5j4uylph55T54ty1Ax34dODHvuT7i6hl2LzznxHBMlZCh16ZKjFEQOxowhTNV/rHVm4vU0T+/TILemIm8rX1XML6oN2/gXUvbzrtSjd8QnfI+sgvmzt7rc2PyuOHQJPuhCmvjuvI1nAb1lteKSxr4R+Gc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: baed0c94-9179-4fc3-c22f-08d62f6805b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2018 10:55:13.7249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1419
X-OriginatorOrg: ericsson.com
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHee69btfV4nG+nYysloFKaqnExSz02yqE8kM1F+nKm/Ntyq5a
        KoFoiSmU4Es6FWf5wbfYGEvLRPMly2lKaprmayqhKRiiSUrldi369jvP/3/+5xx4aFLyzMaF
        jlYnsRq1Mk4qEFGlV5vSvJyPtylODBf6MeUD9ygmfzZbyAw1lwuYbp0To58oRoxpIIaZGx0l
        g4QyU+0YIXupnRTKdMZk2SvdGiFbM7rK9KbnxEVBmCgwko2LTmE1PmcjRKqKpsTEGo87631d
        wgykc89FtjRgf1ipGidykYiW4DcIcj7NkHyxgaAsu0Hwr6jpfrKrVBPwu2BIYOmncD4JI+uh
        vFBIwP2M+t2wLwi+LhlIi0uA3WGxOAdZBAc8TUDVYIHQIpA4GMqm+wkL2+PTMG4yWxsccCBU
        tq/Y8OwL28MLFD/uGOinVq0sxtfAsGWwsgRfhM7MHqvfFl+Cqeklaw7CTvDD3EDws5xhfL6S
        4M/GUN0yQPLsCItzv3Z66R2/HHoX5PzzYTB/zEA8H4TByjzr/oBbhdBVPCLgBS9YLSrazQmB
        yt5Gije9RdDfOYwsoYA9oTk7hsdYMJp3LRUIWh5OkvnIV/vfetodG4k9QN/swz8fgcK8WaHW
        erEd9JTOUzpE1SFHjuW4+ChfP29WE32T4xLU3mo2yYh2PlG7acvrBar/FtyBMI2ke8W3j7Yp
        JDbKFC41vgMBTUodxD4lrQqJOFKZmsZqEsI1yXEs14EO0JTUWexd1xImwVHKJDaWZRNZzV+V
        oG1dMpBCgUVMlntrutvkmGqSIWWmR/uU8qf2H0q2J7LfM7n+hpnP3SN2efLaUBSRrg0xuIbH
        nd90Gsy3a09ZXj+lvhLwM6ixLGuzxnMDBxgvJ3ptj5U1Xxcv13eg6jNB8W7nHoQ+vvt6v/7d
        nuCC707OIaU3LsS4HBpY0C+l3FrqU2VKKU6lPOlJajjlH94GPwtAAwAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRG1pdHJ5LA0KWWVzLCB3ZSBhcmUgYXdhcmUgb2YgdGhpcywgdGhlIGtlcm5lbCB0ZXN0IHJv
Ym90IHdhcm5lZCB1cyBhYm91dCB0aGlzIGEgZmV3IGRheXMgYWdvLg0KSSBhbSBsb29raW5nIGlu
dG8gaXQuDQoNCi8vL2pvbg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IERtaXRyeSBWeXVrb3YgPGR2eXVrb3ZAZ29vZ2xlLmNvbT4NCj4gU2VudDogT2N0b2JlciAxMSwg
MjAxOCAzOjU1IEFNDQo+IFRvOiBwYXJ0aGFzYXJhdGh5LmJodXZhcmFnYW5AZXJpY3Nzb24uY29t
OyBKb24gTWFsb3kNCj4gPGpvbi5tYWxveUBlcmljc3Nvbi5jb20+OyBEYXZpZCBNaWxsZXIgPGRh
dmVtQGRhdmVtbG9mdC5uZXQ+OyBZaW5nIFh1ZQ0KPiA8eWluZy54dWVAd2luZHJpdmVyLmNvbT47
IG5ldGRldiA8bmV0ZGV2QHZnZXIua2VybmVsLm9yZz47IHRpcGMtDQo+IGRpc2N1c3Npb25AbGlz
dHMuc291cmNlZm9yZ2UubmV0OyBMS01MIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IG5ldC90aXBjOiByZWN1cnNpdmUgbG9ja2luZyBpbiB0aXBjX2xpbmtfcmVzZXQN
Cj4gDQo+IEhpLA0KPiANCj4gSSBhbSBnZXR0aW5nIHRoZSBmb2xsb3dpbmcgZXJyb3Igd2hpbGUg
Ym9vdGluZyB0aGUgbGF0ZXN0IGtlcm5lbCBvbg0KPiBiYjJkOGYyZjYxMDQ3Y2JkZTA4Yjc4ZWMw
M2U0ZWJkYjAxZWU1NDM0IChPY3QgMTApLiBDb25maWcgaXMgYXR0YWNoZWQuDQo+IA0KPiBTaW5j
ZSB0aGlzIGhhcHBlbnMgZHVyaW5nIGJvb3QsIHRoaXMgbWFrZXMgTE9DS0RFUCBjb21wbGV0ZWx5
IHVudXNhYmxlLA0KPiBkb2VzIG5vdCBhbGxvdyB0byBkaXNjb3ZlciBhbnkgb3RoZXIgbG9ja2lu
ZyBpc3N1ZXMgYW5kIG1hc2tzIGFsbCBuZXcgYnVncw0KPiBiZWluZyBpbnRyb2R1Y2VkIGludG8g
a2VybmVsLg0KPiBQbGVhc2UgZml4IGFzYXAuDQo+IFRoYW5rcw0KPiANCj4gDQo+IFdBUk5JTkc6
IHBvc3NpYmxlIHJlY3Vyc2l2ZSBsb2NraW5nIGRldGVjdGVkIDQuMTkuMC1yYzcrICMxNCBOb3Qg
dGFpbnRlZA0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
PiBzd2FwcGVyLzAvMSBpcyB0cnlpbmcgdG8gYWNxdWlyZSBsb2NrOg0KPiAwMDAwMDAwMGRjZmMw
ZmM4ICgmKCZsaXN0LT5sb2NrKS0+cmxvY2sjNCl7Ky4uLn0sIGF0OiBzcGluX2xvY2tfYmgNCj4g
aW5jbHVkZS9saW51eC9zcGlubG9jay5oOjMzNCBbaW5saW5lXQ0KPiAwMDAwMDAwMGRjZmMwZmM4
ICgmKCZsaXN0LT5sb2NrKS0+cmxvY2sjNCl7Ky4uLn0sIGF0Og0KPiB0aXBjX2xpbmtfcmVzZXQr
MHgxMjUvMHhkZjAgbmV0L3RpcGMvbGluay5jOjg1MA0KPiANCj4gYnV0IHRhc2sgaXMgYWxyZWFk
eSBob2xkaW5nIGxvY2s6DQo+IDAwMDAwMDAwY2JiOWIwMzYgKCYoJmxpc3QtPmxvY2spLT5ybG9j
ayM0KXsrLi4ufSwgYXQ6IHNwaW5fbG9ja19iaA0KPiBpbmNsdWRlL2xpbnV4L3NwaW5sb2NrLmg6
MzM0IFtpbmxpbmVdDQo+IDAwMDAwMDAwY2JiOWIwMzYgKCYoJmxpc3QtPmxvY2spLT5ybG9jayM0
KXsrLi4ufSwgYXQ6DQo+IHRpcGNfbGlua19yZXNldCsweGZhLzB4ZGYwIG5ldC90aXBjL2xpbmsu
Yzo4NDkNCj4gDQo+IG90aGVyIGluZm8gdGhhdCBtaWdodCBoZWxwIHVzIGRlYnVnIHRoaXM6DQo+
ICBQb3NzaWJsZSB1bnNhZmUgbG9ja2luZyBzY2VuYXJpbzoNCj4gDQo+ICAgICAgICBDUFUwDQo+
ICAgICAgICAtLS0tDQo+ICAgbG9jaygmKCZsaXN0LT5sb2NrKS0+cmxvY2sjNCk7DQo+ICAgbG9j
aygmKCZsaXN0LT5sb2NrKS0+cmxvY2sjNCk7DQo+IA0KPiAgKioqIERFQURMT0NLICoqKg0KPiAN
Cj4gIE1heSBiZSBkdWUgdG8gbWlzc2luZyBsb2NrIG5lc3Rpbmcgbm90YXRpb24NCj4gDQo+IDIg
bG9ja3MgaGVsZCBieSBzd2FwcGVyLzAvMToNCj4gICMwOiAwMDAwMDAwMGY3NTM5ZDM0IChwZXJu
ZXRfb3BzX3J3c2VtKXsrLisufSwgYXQ6DQo+IHJlZ2lzdGVyX3Blcm5ldF9zdWJzeXMrMHgxOS8w
eDQwIG5ldC9jb3JlL25ldF9uYW1lc3BhY2UuYzoxMDUxDQo+ICAjMTogMDAwMDAwMDBjYmI5YjAz
NiAoJigmbGlzdC0+bG9jayktPnJsb2NrIzQpeysuLi59LCBhdDoNCj4gc3Bpbl9sb2NrX2JoIGlu
Y2x1ZGUvbGludXgvc3BpbmxvY2suaDozMzQgW2lubGluZV0NCj4gICMxOiAwMDAwMDAwMGNiYjli
MDM2ICgmKCZsaXN0LT5sb2NrKS0+cmxvY2sjNCl7Ky4uLn0sIGF0Og0KPiB0aXBjX2xpbmtfcmVz
ZXQrMHhmYS8weGRmMCBuZXQvdGlwYy9saW5rLmM6ODQ5DQo+IA0KPiBzdGFjayBiYWNrdHJhY2U6
DQo+IENQVTogMCBQSUQ6IDEgQ29tbTogc3dhcHBlci8wIE5vdCB0YWludGVkIDQuMTkuMC1yYzcr
ICMxNCBIYXJkd2FyZSBuYW1lOg0KPiBRRU1VIFN0YW5kYXJkIFBDIChpNDQwRlggKyBQSUlYLCAx
OTk2KSwgQklPUyAxLjEwLjItMSAwNC8wMS8yMDE0IENhbGwgVHJhY2U6DQo+ICBfX2R1bXBfc3Rh
Y2sgbGliL2R1bXBfc3RhY2suYzo3NyBbaW5saW5lXQ0KPiAgZHVtcF9zdGFjaysweDFhZi8weDI5
NSBsaWIvZHVtcF9zdGFjay5jOjExMyAgcHJpbnRfZGVhZGxvY2tfYnVnDQo+IGtlcm5lbC9sb2Nr
aW5nL2xvY2tkZXAuYzoxNzU5IFtpbmxpbmVdICBjaGVja19kZWFkbG9jaw0KPiBrZXJuZWwvbG9j
a2luZy9sb2NrZGVwLmM6MTgwMyBbaW5saW5lXSAgdmFsaWRhdGVfY2hhaW4NCj4ga2VybmVsL2xv
Y2tpbmcvbG9ja2RlcC5jOjIzOTkgW2lubGluZV0NCj4gIF9fbG9ja19hY3F1aXJlKzB4ZjFlLzB4
M2M2MCBrZXJuZWwvbG9ja2luZy9sb2NrZGVwLmM6MzQxMQ0KPiAgbG9ja19hY3F1aXJlKzB4MWRi
LzB4NTIwIGtlcm5lbC9sb2NraW5nL2xvY2tkZXAuYzozOTAwDQo+IF9fcmF3X3NwaW5fbG9ja19i
aCBpbmNsdWRlL2xpbnV4L3NwaW5sb2NrX2FwaV9zbXAuaDoxMzUgW2lubGluZV0NCj4gIF9yYXdf
c3Bpbl9sb2NrX2JoKzB4MzEvMHg0MCBrZXJuZWwvbG9ja2luZy9zcGlubG9jay5jOjE2OCAgc3Bp
bl9sb2NrX2JoDQo+IGluY2x1ZGUvbGludXgvc3BpbmxvY2suaDozMzQgW2lubGluZV0NCj4gIHRp
cGNfbGlua19yZXNldCsweDEyNS8weGRmMCBuZXQvdGlwYy9saW5rLmM6ODUwDQo+ICB0aXBjX2xp
bmtfYmNfY3JlYXRlKzB4YjUvMHgxZjAgbmV0L3RpcGMvbGluay5jOjUyNg0KPiAgdGlwY19iY2Fz
dF9pbml0KzB4NTliLzB4YWIwIG5ldC90aXBjL2JjYXN0LmM6NTIxDQo+ICB0aXBjX2luaXRfbmV0
KzB4NDcyLzB4NjEwIG5ldC90aXBjL2NvcmUuYzo4Mg0KPiAgb3BzX2luaXQrMHhmNy8weDUyMCBu
ZXQvY29yZS9uZXRfbmFtZXNwYWNlLmM6MTI5DQo+IF9fcmVnaXN0ZXJfcGVybmV0X29wZXJhdGlv
bnMgbmV0L2NvcmUvbmV0X25hbWVzcGFjZS5jOjk0MCBbaW5saW5lXQ0KPiAgcmVnaXN0ZXJfcGVy
bmV0X29wZXJhdGlvbnMrMHg0NTMvMHhhYzAgbmV0L2NvcmUvbmV0X25hbWVzcGFjZS5jOjEwMTEN
Cj4gIHJlZ2lzdGVyX3Blcm5ldF9zdWJzeXMrMHgyOC8weDQwIG5ldC9jb3JlL25ldF9uYW1lc3Bh
Y2UuYzoxMDUyDQo+ICB0aXBjX2luaXQrMHg4My8weDEwNCBuZXQvdGlwYy9jb3JlLmM6MTQwICBk
b19vbmVfaW5pdGNhbGwrMHgxMDkvMHg3MGENCj4gaW5pdC9tYWluLmM6ODg1ICBkb19pbml0Y2Fs
bF9sZXZlbCBpbml0L21haW4uYzo5NTMgW2lubGluZV0gIGRvX2luaXRjYWxscw0KPiBpbml0L21h
aW4uYzo5NjEgW2lubGluZV0gIGRvX2Jhc2ljX3NldHVwIGluaXQvbWFpbi5jOjk3OSBbaW5saW5l
XQ0KPiBrZXJuZWxfaW5pdF9mcmVlYWJsZSsweDRiZC8weDU3ZiBpbml0L21haW4uYzoxMTQ0DQo+
ICBrZXJuZWxfaW5pdCsweDEzLzB4MTgwIGluaXQvbWFpbi5jOjEwNjMNCj4gIHJldF9mcm9tX2Zv
cmsrMHgzYS8weDUwIGFyY2gveDg2L2VudHJ5L2VudHJ5XzY0LlM6NDEzDQo=
