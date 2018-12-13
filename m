Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB9BC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F6220811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="oHXUHC7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F6220811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbeLMK06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:26:58 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:56606 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbeLMK05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:26:57 -0500
X-IronPort-AV: E=Sophos;i="5.56,348,1539673200"; 
   d="scan'208";a="24315273"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 13 Dec 2018 03:26:55 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 13 Dec 2018 03:26:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LuFF6oqLzW/b2GozukIRb5LywfpLaFCHSckPCU+js0=;
 b=oHXUHC7MN4EzJl14nu+dG5vmxehjYbfgBgqkISorfZ5SdUgj9dnYc+fG1C/t+ASPFlkkxObE2Rnyvf8UdcGRyxs/dUH/thIEctn+0Dzh/YG3HN2HyISv4PJ0i5AU+vg8q3tuBmgFZKT+CCa5+TJlTpR0wQXq6hMLdrXZNxfrkqk=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1490.namprd11.prod.outlook.com (10.172.21.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Thu, 13 Dec 2018 10:26:53 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::8155:7276:d66a:e239]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::8155:7276:d66a:e239%8]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 10:26:53 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vt@altlinux.org>, <dhowells@redhat.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] akcipher: Introduce verify2 for public key algorithms
Thread-Topic: [RFC PATCH] akcipher: Introduce verify2 for public key
 algorithms
Thread-Index: AQHUkXMAwMA1v9Y9aUKBAvOjoqJToaV8ecwA
Date:   Thu, 13 Dec 2018 10:26:53 +0000
Message-ID: <b2e6060c-1e2a-c2c5-0484-715646d16201@microchip.com>
References: <20181211165938.1150-1-vt@altlinux.org>
In-Reply-To: <20181211165938.1150-1-vt@altlinux.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0133.eurprd07.prod.outlook.com
 (2603:10a6:802:16::20) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1490;6:JNsGSJJkpCyFoE9wlJkr1MeQXOymmOveq0XhK5DTD3ku2gxPmQjKUqvlpzA2mDIHCDTirQraUAdPRw8763e4U+NCYysHGsXD0CygeA+3xDdI9hfbjGEIRSLiVomdLdaWiKD++dUpFcDwneuVpHS7WR9UjGVo/sHCY+MU1MMpeJLERcWPpTzUjBPsV/YXUAUrwZNOMoHi2CBX2xlK03CZa3mFj/hDd7guxQ9duCqpEkCrJx6jCcQB5xJDZoSG6doVKVYIG77HYAVHyGg08hMcuUEDjFWPx4PLQ2otCcAz0rpGBmlyvVlcnZUV2TZSBUZh4Ep1B4XIAZ3FxzkcS6rjBGTCI40/CNeh0U4xzCoNg27RVq4GiO8wwiggH7nw1j7FMFOo024wQMsfMQjO7WI74VlmWyNVVFihj3Me4p0cASpzggxXoGeupa426hbGaV/yDlGwBdZRNmYBsm3JIY/0gg==;5:UkBYOb0AusSt44lRMtA9d2SioTT5CiiUp4ON09O4mbYKkawYv9X1M9daNiPW11ZkD02q3x7JHtoQ8KbmskCnkdkjgFev3DKy1vNlwfFfnRNNJu16nLqf0YO8EzYWyfCUufEk5I5lr/lcB7tB7T6Kcl864dH7trsaXSe08vnA/BM=;7:txAq2VUn4IVgoKbg8iEmROxqscVXJcLSMfQEtD7BI7rOSTh/HtrXsegUwGZrdZ3eraATKoPwYdvcQIsN4kn1Af30ssQoyWWrOgt5QLZgCoLP+MYjMSaypFW/U9hOhtZKCFhtS7QUQnseEy1wDE/CRg==
x-ms-office365-filtering-correlation-id: 5daa8ec4-3c87-48ca-e1ec-08d660e57ff9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1490;
x-ms-traffictypediagnostic: BN6PR11MB1490:
x-microsoft-antispam-prvs: <BN6PR11MB1490F297CF953742822D8CFCF0A00@BN6PR11MB1490.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1490;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1490;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(136003)(366004)(396003)(189003)(199004)(105586002)(305945005)(102836004)(14454004)(106356001)(99286004)(186003)(66066001)(31686004)(76176011)(52116002)(26005)(7736002)(68736007)(478600001)(15650500001)(71190400001)(71200400001)(8936002)(6506007)(386003)(53546011)(6512007)(5660300001)(8676002)(2501003)(6246003)(36756003)(86362001)(14444005)(316002)(256004)(2906002)(31696002)(229853002)(2201001)(97736004)(72206003)(6436002)(53936002)(81166006)(110136005)(486006)(81156014)(6486002)(446003)(11346002)(476003)(6116002)(2616005)(25786009)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1490;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Sbff9/fAL4q1VmDXqRWJD6NUcYTOCm0pNNRv6WszrW9Ap+L5OXCaTor8CBKB6CG/HDAy2XUPXy35+aYOWYnd5vWim2n+CNogO+mz8MbGuRGZ4g0H9tuFgdxuRMSu3MdVlAmGnTyCteeLhFhB4nA6wFfkbFQugv7CmpezemdBkv1qsOkD9gk4kY204q1ei8zao0DjwighQmN6apkmou/bbFbwNkJe6qQMNWTzpg3Ec1pninuZJiiuMVj6VzatgfuIZQ6X2JRkj4L+B61SheRkJ0247tLaouEHDvdnbC92rE75tgJjmX+vLYliPLFwpd4c
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC26C2A25B53EF46A39A2FFD06D34EFA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5daa8ec4-3c87-48ca-e1ec-08d660e57ff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 10:26:53.2195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1490
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIDEyLzExLzIwMTggMDY6NTkgUE0sIFZpdGFseSBDaGlrdW5vdiB3cm90ZToNCj4g
Q3VycmVudCBha2NpcGhlciAudmVyaWZ5KCkganVzdCBkZWNyeXB0cyBzaWduYXR1cmUgdG8gdW5j
b3ZlciBtZXNzYWdlDQo+IGhhc2gsIHdoaWNoIGlzIHRoZW4gdmVyaWZpZWQgaW4gdXBwZXIgbGV2
ZWwgcHVibGljX2tleV92ZXJpZnlfc2lnbmF0dXJlDQo+IGJ5IG1lbWNtcCB3aXRoIHRoZSBleHBl
Y3RlZCBzaWduYXR1cmUgdmFsdWUsIHdoaWNoIGlzIG5ldmVyIHBhc3NlZCBpbnRvDQo+IHZlcmlm
eSgpLg0KPiANCj4gVGhpcyBhcHByb2FjaCBpcyBpbmNvbXBhdGlibGUgd2l0aCBFQ0RTQSBhbGdv
cml0aG1zLCBiZWNhdXNlLCB0byB2ZXJpZnkNCg0KSSB3b3VsZCBsb3ZlIHRvIGhhdmUgRUNEU0Eg
aW4ga2VybmVsIGJ1dCB1bmZvcnR1bmF0ZWx5IGl0IGhhc24ndCByZWFjaGVkIGtlcm5lbA0KYmVj
YXVzZSB0aGVyZSBpcyBubyBpbi1rZXJuZWwgdXNlciBmb3IgaXQuIERvIHdlIGhhdmUgYW4gYWdy
ZWVtZW50IHRoYXQgd2Ugd2lsbA0KYWRkIHN1cHBvcnQgZm9yIGl0PyBJZiBub3QsIHdobyB3aWxs
IGJlbmVmaXQgb2YgdGhlc2UgcGF0Y2hlcz8NCg0KVGhhbmtzLA0KdGENCg==
