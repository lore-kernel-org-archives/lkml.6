Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254E5C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7802083B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HYFcOm09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfBDQZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:25:43 -0500
Received: from mail-eopbgr820137.outbound.protection.outlook.com ([40.107.82.137]:14848
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726542AbfBDQZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:25:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wwSbjs4AEOXVAhrVdWMJ7Uh5OdpuTg+tuH5EjuDI7M=;
 b=HYFcOm09zWw5i27r6s2CfQ8jZXcGNRgiEIyY8t7Ope0fw9C8ipO+K2sbxEwZJI6oD9hvbTd9JcfeoDOj2tcNwEX3obzKj3FI1m6poI6jJjaf4ZVQ79u58iVsh6EUQFBrS+sVFDMiOLIv1jdPBtxQNo1foMvPsbr+gjjIJW+6gUc=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB1030.namprd21.prod.outlook.com (52.132.128.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.11; Mon, 4 Feb 2019 16:25:34 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::15b:c868:d1bd:c781]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::15b:c868:d1bd:c781%9]) with mapi id 15.20.1622.000; Mon, 4 Feb 2019
 16:25:34 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kimbrownkd <kimbrownkd@gmail.com>, Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] Drivers: hv: vmbus: Expose counters for interrupts and
 full conditions
Thread-Topic: [PATCH v4] Drivers: hv: vmbus: Expose counters for interrupts
 and full conditions
Thread-Index: AQHUvFkZU+Jom7VDEEST5eDP05Q+0KXP05Qw
Date:   Mon, 4 Feb 2019 16:25:34 +0000
Message-ID: <DM5PR2101MB091863AD0DEF25395352BF98D76D0@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <20190117043759.GA3395@ubu-Virtual-Machine>
 <20190204071309.GA3470@ubu-Virtual-Machine>
In-Reply-To: <20190204071309.GA3470@ubu-Virtual-Machine>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-04T16:25:32.2611407Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e00cfa4f-698b-4493-9eb7-eb1621075b0a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1030;6:Iqbev/+aGpsxmD5tNy66EefXflkrH5lzjbITALV6akIN8sPg07YLoGvb6IZ9USarMGoluZjLDFdxe/NiqRSC2ySAiQsZ7u+qK5F8QHfDxkhiOXxMM2XsQAgF04YxizmLbCGSEYy6F8F0dIxRRsr5VoEWm4znvCXeWF+tZJLWo57Ql3b5tCRCfeFYbjY2eC5+BorWM32JPOFixx9UkjeGzunYta8xIxqs8L7LpWmUjmb5BDeX8u2VZeOB60CytskzuUgJJwPKAQikGn8a9jftT2DFkl8+jdQtgbWtn9T6TA++7gXNIPNZ4/PuDXNRa9rrt86FkKjX7Xet0nCDhRCo46BfBWLfkHiSB/C4lTDvYBZYoRc0vuRew2i59DLyFOmS4Oc8/X7qyOJEvKdlVWDFQbzyXiyPIOLfhqZkJTZqh6tKld7tpDkcMmZ8wxrl/euzVrbDR/GfhmgqI5uCqcqglA==;5:q6M1SjY1Eel5PGB6a/twFcwuuL0xgBKzr370xopEZ+F4rjTqoclCb60wFU3MRlNngaWCv4/YBHxe/jV8L02nKgfBWMZDAenxMKunaMaXO/KGgbUO+SRep33ESV5IfPAdFshwYadIEWNZqNzb5qI4SyxbIkQYj6PZT3j85pkl7zldAXnRprBwoPpiRG2wNwsZlzXLTvOQq6xViq15Hfyzdw==;7:Ilh0kM35a2w539sHkbFVhV3Bf20Dw9iM3NW9SHuqYReIunJc8gw+XZJN+oBUQGzJ3k+GqPRlsp+GCeyvTU1SEKO7+oG883V0apapVI6bPJ9vUPm/yvvPoi52RIbtdrbNfyY/zISnmnX8ZTgm+7VA1Q==
x-ms-office365-filtering-correlation-id: cfcdbf1e-1e38-456d-3fb1-08d68abd637a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB1030CC55EC6DE3276D757225D76D0@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(136003)(366004)(396003)(346002)(189003)(199004)(4326008)(8990500004)(11346002)(6246003)(9686003)(33656002)(55016002)(229853002)(81156014)(6436002)(81166006)(8676002)(446003)(110136005)(54906003)(25786009)(68736007)(8936002)(22452003)(2906002)(316002)(14444005)(256004)(6346003)(10290500003)(66066001)(186003)(26005)(14454004)(1511001)(6506007)(102836004)(6636002)(99286004)(71200400001)(71190400001)(39060400002)(7736002)(53936002)(76176011)(486006)(7696005)(86612001)(106356001)(105586002)(86362001)(476003)(97736004)(74316002)(6116002)(478600001)(10090500001)(305945005)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1030;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7EvkPb5fJEElwkOPyi1sbe9qGvn2TMRIH3Ix4HUC42FABGLMVQWNg43IokiM2/+c8H4NwoqbL+GmAPwX+R/PW1PyLX7KeiosYsMuGzl6yQ7dFIze4a+EMo6O+FpXNEbuI9SpT4rdDt/iS2RqnyokvEiPrB7+D03PXo9L5BDE100gWKeqTnwwfAazqGUf+7ThRhtRbz691qpsyzq745HG9KvqwPbDhQbkGkT0EtD6107GSlwNQ6wqJqgpAQDROQtDToK/Q2uWTHZdagjh9ibV216MhKTtrL8cntcvOgJOYQMO2831qMI3DKu+O0sadPEam+ZqcDPQkZZY68rbNDY1XAlKygm4oySt5i0lRYyDKeCm9VL/fSp0vbmUpsSoC8P6PrHB6k/CZwoxpgd9wlx9WkucvnwkWruORbf13kfKYh4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfcdbf1e-1e38-456d-3fb1-08d68abd637a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 16:25:34.0652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kimberly Brown <kimbrownkd@gmail.com> Sent: Sunday, February 3, 2019 =
11:13 PM
>=20
> Counter values for per-channel interrupts and ring buffer full
> conditions are useful for investigating performance.
>=20
> Expose counters in sysfs for 2 types of guest to host interrupts:
> 1) Interrupts caused by the channel's outbound ring buffer transitioning
> from empty to not empty
> 2) Interrupts caused by the channel's inbound ring buffer transitioning
> from full to not full while a packet is waiting for enough buffer space t=
o
> become available
>=20
> Expose 2 counters in sysfs for the number of times that write operations
> encountered a full outbound ring buffer:
> 1) The total number of write operations that encountered a full
> condition
> 2) The number of write operations that were the first to encounter a
> full condition
>=20
> Increment the outbound full condition counters in the
> hv_ringbuffer_write() function because, for most drivers, a full
> outbound ring buffer is detected in that function. Also increment the
> outbound full condition counters in the set_channel_pending_send_size()
> function. In the hv_sock driver, a full outbound ring buffer is detected
> and set_channel_pending_send_size() is called before
> hv_ringbuffer_write() is called.
>=20
> I tested this patch by confirming that the sysfs files were created and
> observing the counter values. The values seemed to increase by a
> reasonable amount when the Hyper-v related drivers were in use.
>=20
> Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
> ---
>=20
Reviewed-by:  Michael Kelley <mikelley@microsoft.com>
