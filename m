Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20142C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF802086A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="c37wkrYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfBTQL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:11:26 -0500
Received: from mail-eopbgr730099.outbound.protection.outlook.com ([40.107.73.99]:24677
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726116AbfBTQLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:11:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mleaoC2bZ/hPiNEKkaiKieDlG3YT6JG6aAvkEaxmrFk=;
 b=c37wkrYoE5buA/LaUYB70Tds02Vgs4qu7gUM2Xa1xEwFvMY5F9rOw5ksrLd5QIFiB/bIK9qwD09LFb0XD9uv7MP2vm1mpz2ykGMTTtymDcRCSkZS561NgDeuDDt6CM3ZA2Nzi3TKRmh0zAhZxBPF3bcKTfNXodzDWbHe/XWH14c=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB1109.namprd21.prod.outlook.com (52.132.130.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.1; Wed, 20 Feb 2019 16:11:17 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::ec2d:d32b:e611:553f]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::ec2d:d32b:e611:553f%9]) with mapi id 15.20.1665.006; Wed, 20 Feb 2019
 16:11:17 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kimbrownkd <kimbrownkd@gmail.com>, Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] Drivers: hv: vmbus: Return -EINVAL if
 monitor_allocated not set
Thread-Topic: [PATCH v2 2/2] Drivers: hv: vmbus: Return -EINVAL if
 monitor_allocated not set
Thread-Index: AQHUyBVVmRJUghwXe0qbnxMNLyQDBqXo3TnQ
Date:   Wed, 20 Feb 2019 16:11:17 +0000
Message-ID: <DM5PR2101MB091868584D04E3FCE3CB6100D77D0@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <cover.1549619051.git.kimbrownkd@gmail.com>
 <cover.1550554279.git.kimbrownkd@gmail.com>
 <7481d15f52427917a5f620e29308c1aa5c63f3eb.1550554279.git.kimbrownkd@gmail.com>
In-Reply-To: <7481d15f52427917a5f620e29308c1aa5c63f3eb.1550554279.git.kimbrownkd@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-20T16:11:15.6877498Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=298b04c2-e694-45ee-ab77-51bc7f355705;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e865624-936b-4ffd-7a1b-08d6974e0ba3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DM5PR2101MB1109;23:5xj+kkamBhez3A+o53Fit9iP/chBdJsPtHY+5e0?=
 =?us-ascii?Q?NSgOp3qRgU5C8c4kXpV7Dhn+e94/gnzAO77V6/ojTT1x378QIoym+pNCtoPK?=
 =?us-ascii?Q?DCb6Opd4vRX4xH/fb7vfzE5VL1hMXhIV4as0u4Dh+xPAXh8g/CkT6oAu2nsE?=
 =?us-ascii?Q?yGKowAfcgBCNT6wUe65iN7MT/QlcQFo0hVAMUk7s6f3ogff6QD5dFsE3hZjy?=
 =?us-ascii?Q?DKyPcjUg2DbIycVpR3++4CPVEiRrH0Bso/8+AmrCCJCTde+u6fllLXxMW2wh?=
 =?us-ascii?Q?fq6zNA49/ouidAMuc83YMXGgd1EV8F4UHfvaGc1v2rGC72RrWFH1t7Y67UxV?=
 =?us-ascii?Q?gKQhvgQfEdpllCGXIWauKEfsDCq00ilA53dZRVI7jSHsL7f2ipimkx3P97I4?=
 =?us-ascii?Q?+3XTIBp0X5KOBqlSWffiwOEf+ZLvj1XrQHp3lda6nYUOQ7ll97BCMsVZbUAM?=
 =?us-ascii?Q?HvKIG8BlXDts1EYQIPNd+tbA2CuURpxPYLJ2o+VMKQhibAhQ2TPBFjhfJxRZ?=
 =?us-ascii?Q?nr7IAqvjLiD52aeuiSsgcD4IANs8JLNr2PPE9hw2b3MfcESkPmVB2BVTNxHf?=
 =?us-ascii?Q?Tb3B06O5QkvzQ4NcCA/mBYjIGbtUeoefnmCi4fEhVbs24mmuYBDZOYXZhDh+?=
 =?us-ascii?Q?OOQ7thUmTB4QTKUw20IyWv9tOrpiHLz/CQLqeOF8JtMiZbK5mIpw6S3WlExa?=
 =?us-ascii?Q?BsaQCSESpeiEkKxZlIV4Q2JdKEzq7O06sYZPtbHdMTQTM2apuCGz43cHSrTX?=
 =?us-ascii?Q?ymacypu9HzCUpNXy49uJPlZpf1Y+M8Wi5pF/hi5nCSibL6Grt4PDiXD5ERMe?=
 =?us-ascii?Q?MRn4UzoG560FqoZoFvQ8r2wk1FX48aCqHyIkyF90vPSJw5u15G8tXS0f9mLO?=
 =?us-ascii?Q?MfjoFWmhmSkNbAY/Njk8S9Rp0GWpEklREDqeE152oaVIrQpsn3ZiAzuwa7mi?=
 =?us-ascii?Q?V7LhcreHPORnMoxX3RL1pbQjerPAArlNQuT57NQSqFS9MGjhcLpz1Kjk7LfD?=
 =?us-ascii?Q?S+QND8kWA1Vh6sGvWyB968KKWDO+C79MIIplA41yI0XzcHnpLAg2qXvJ1AYW?=
 =?us-ascii?Q?9oxB5O/zE/wwvTD1X67F1chTgHhLwvRHdH898jO3jCyBv+bmeEyyaCIHnJGb?=
 =?us-ascii?Q?3M6ryPE1ZBaW6HuRptarWInahSCANsgsrZeA7oLC7iBrCXPSAJiwHjLqCPp/?=
 =?us-ascii?Q?rbuvEIfnhI+PFGU8UiAeNGxf3Zmh3t5iBvqOp2h8cecoBHHMRv3sBhMq4Ukl?=
 =?us-ascii?Q?lidubFUZ7BQz7bokaodMURq9tm6EX3BvObqL1oILDsD5m+n3Xws14cl6cHQo?=
 =?us-ascii?Q?CTu0o9onS9cjq2yIq02e3psVVqd+VPWxefPNJufyylIeFv5uYvRaYPkUm0XG?=
 =?us-ascii?Q?kU8DmSwnKLJNK8Hc7amdAftDLAiLV7qE792OEao60J1omgmPf?=
x-microsoft-antispam-prvs: <DM5PR2101MB11095EF4B7CA70FDE5ED5735D77D0@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(396003)(376002)(39860400002)(199004)(189003)(5660300002)(6116002)(186003)(11346002)(97736004)(446003)(6346003)(86362001)(3846002)(4326008)(102836004)(26005)(68736007)(106356001)(8676002)(476003)(81166006)(81156014)(55016002)(71200400001)(71190400001)(6506007)(53936002)(86612001)(256004)(25786009)(6246003)(9686003)(486006)(6636002)(14444005)(1511001)(14454004)(478600001)(229853002)(8990500004)(74316002)(8936002)(66066001)(105586002)(6436002)(7736002)(305945005)(10090500001)(33656002)(110136005)(54906003)(22452003)(76176011)(7696005)(2906002)(10290500003)(316002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: defr0ZydGPNEqpOdsK1KPW2yS66c1zzNwA6IpR9JU8xu0XUSo1XTxhRKOI9Vd8qbfJEbi9Mz9TdfwnKpejRiyId1nKGUY6HXHLTKDhES53gYU20+bdp4DHflWmrkFCGuK/wOsYcp55eZiltbfAmGK9q4bvzkcsG5ySvc34HcxN4Ba6d8vN6ZNNyfwZ+2SdmlCNqy6pZ+0OugffiShtLWoLMDU2Z882nhjQlKcxueDnE/9El+bkHGxxV4NAhjtDZGR4cYwEeTmlEDnDSOfu0qr3KY/xzW00xELvkdkiWai7tCUdfmazIJvh3rO/dOqZZqSp6KYaRBT8pELblT9Z0VJx06YYn7EFIe6qMTr6s+TvYQWdlNaLYy0HPWdaOBN//syYXUTACAID+m1QWadINtotqIuz6qhqpardWfLAh8CAs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e865624-936b-4ffd-7a1b-08d6974e0ba3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 16:11:17.6121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kimberly Brown <kimbrownkd@gmail.com>  Sent: Monday, February 18, 201=
9 9:38 PM
>=20
> There are two methods for signaling the host: the monitor page mechanism
> and hypercalls. The monitor page mechanism is used by performance
> critical channels (storage, networking, etc.) because it provides
> improved throughput. However, latency is increased. Monitor pages are
> allocated to these channels.
>=20
> Monitor pages are not allocated to channels that do not use the monitor
> page mechanism. Therefore, these channels do not have a valid monitor id
> or valid monitor page data. In these cases, some of the "_show"
> functions return incorrect data. They return an invalid monitor id and
> data that is beyond the bounds of the hv_monitor_page array fields.
>=20
> The "channel->offermsg.monitor_allocated" value can be used to determine
> whether monitor pages have been allocated to a channel. In the affected
> "_show" functions, verify that "channel->offermsg.monitor_allocated" is
> set before accessing the monitor id or the monitor page data. If
> "channel->offermsg.monitor_allocated" is not set, return -EINVAL.
>=20
> Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
>

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
