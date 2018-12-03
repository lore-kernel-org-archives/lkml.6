Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B19EC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 01:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCAE2081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 01:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="lXyd2k9s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFCAE2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbeLCBl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 20:41:57 -0500
Received: from mail-eopbgr690115.outbound.protection.outlook.com ([40.107.69.115]:21344
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725785AbeLCBl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 20:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hd9gbjhlCgxJyZGERAo2hss+kvtwrKldPXIPSfsVWw=;
 b=lXyd2k9sNV3pcbv1K379beyOkdsZR/uzOP+ZhSFO4aemSZ9xIVccIdrHkn2ehDZekUZC8QeSwbY9pZJowbSIfzMEY7SPo2iNcZR+NIOV/oTi8VkU1oGeRDumIm/aO/XN23uWfUwO0Byt1M6u+pGifvIzhZBKPeT/X72z8zDjQOc=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.2; Mon, 3 Dec 2018 01:41:50 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::f597:e00a:584b:fd8c]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::f597:e00a:584b:fd8c%2]) with mapi id 15.20.1425.000; Mon, 3 Dec 2018
 01:41:50 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        =?iso-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Roman Kagan <rkagan@virtuozzo.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH v2] x86/hyper-v: Mark TLFS structures packed
Thread-Topic: [PATCH v2] x86/hyper-v: Mark TLFS structures packed
Thread-Index: AQHUiKvVFIlaw5TtNk+YtAgoTUHDO6VsP1Zg
Date:   Mon, 3 Dec 2018 01:41:50 +0000
Message-ID: <CY4PR21MB0773D5DFA13BFA0701771F5ED7AE0@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20181130125422.21494-1-vkuznets@redhat.com>
In-Reply-To: <20181130125422.21494-1-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-12-03T01:41:48.2420049Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:+DYYbevjDeaJbefQd5F+5vQ9k6FvxfKSQAeHcJd60wM1UVXGgj/nCfTP/Vk2E6vSqXzu1PbxJU0JFKVAl4MpXhKeGHbQN6nYHtM707143gQ9YYObbT2Do4A/FE9PsZ8UH2hht5HXJU4zRIDTe2c18pHY9YTfjGgqlPLWUB2Fcq5NF/X0/NXKApXJ0w8+OAOJMrBHAA6xvjp8vi3LSkEUyNwuOnDleLmLmEiO11IXJXuq+SaZOw+NdMx+HT1LoSXd8I6bR65etKzPF9hgmM3pVtpQARfIFYApBqVDioE+TBuhif2WoVgnadarZJqBWljZapvu9UvxlAXg4bOEksp1zb+mLtVuBu7dDRn4CTSLVAWxTdYz15NJdT7cyenik8DM7gpdZ0yCtYjGlLgRO/j/KEPyt5UnVxUZkeBXAV8Y+DbR2cYXSmXLpW+xyZ+QKC+8tf0giaheXPsyx8Tk40zUzQ==;5:+H7uoeX/KdCRt6MjaGrqcjaDAhcWKeMi5ikgaIqXv7bET9Bwba00z8aREGbEXwkOM5zrwMZQIUm0HXPljYar//5QNEp2FmcUShF+G8rV6Q0s6bq10p9htsTMbcsVZxmc9eIlHP/enR+6XDqMePhhV06GlY6Nqk44u5d0XRO+OSI=;7:I4qUxvtcRsqaREFZF7Legx+hSRkgZ2Sq/aNDOZ6XtfLwdlSXYD6CbKlI0QJYwOGBCNQcA4oCiIsgddoGRxZG9/GT/XPjQgh4mP+O6jzAE5yqbY/2UcHv8UGuemGQC1d2dMrShhIhbDaI22tuKm9ppA==
x-ms-office365-filtering-correlation-id: e84d7bf2-aebb-4340-bbf6-08d658c07ece
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
x-ms-exchange-purlcount: -3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB077396D2DF537EA29EDEAEF3D7AE0@CY4PR21MB0773.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(8121501046)(5005006)(3231455)(999002)(944501493)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(136003)(396003)(189003)(199004)(10290500003)(6506007)(53936002)(33656002)(102836004)(2501003)(39060400002)(478600001)(6246003)(7696005)(76176011)(97736004)(99286004)(6116002)(3846002)(4326008)(2906002)(5660300001)(305945005)(71200400001)(71190400001)(8676002)(256004)(81166006)(81156014)(14454004)(55016002)(66066001)(7736002)(476003)(486006)(11346002)(446003)(8936002)(74316002)(105586002)(14444005)(6436002)(10090500001)(86612001)(8990500004)(186003)(26005)(110136005)(54906003)(68736007)(25786009)(86362001)(106356001)(229853002)(22452003)(9686003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wQdftulinP5gwyf2vfuxrlXw67NQ+Vij3YR9BusIn06pLtUBe0g9lo4HzUpHF1O2S74Y1pqA2aRfODuZZ4pnPr0bvIU2veWsYUHShVOGqwerltivjK4Bso1/3GmyF1YdJdgXPSzQ3I4LdPfk8K12WifAvBSrGHg3zLHecVUVOuOOmZb27Ybb7Awq+aVG+tqrYJ9bWFQM2fmYBopaEJJobwO6oDRPP94/HQmcW2xLQ1ypDoJAcRjhzP7IdX843RQQzgxHI55Sh3lRDQxNEfbbPURl0K4pUjICWggwEHh99vmCEBFAcBE9kO2cznrTWrSpbvFLStPB5InpuIhGUtRtyC0WI3ZpJA/6ex1YL6TOwKc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e84d7bf2-aebb-4340-bbf6-08d658c07ece
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 01:41:50.2545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>  Sent: Friday, November 30, 20=
18 4:54 AM
>=20
> @@ -466,7 +466,7 @@ union hv_message_flags {
>  	struct {
>  		__u8 msg_pending:1;
>  		__u8 reserved:7;
> -	};
> +	} __packed;
>  };
>=20
>  /* Define port identifier type. */

I think __packed is also needed in the definition
of struct u defined within union hv_port_id.  That
struct has bit fields, so shouldn't it be done just like
union hv_message_flags above?

Michael

> @@ -488,7 +488,7 @@ struct hv_message_header {
>  		__u64 sender;
>  		union hv_port_id port;
>  	};
> -};
> +} __packed;
>=20
