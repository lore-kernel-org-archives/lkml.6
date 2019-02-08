Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031E3C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B3621924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=MicronCorp.onmicrosoft.com header.i=@MicronCorp.onmicrosoft.com header.b="Db65oTtC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfBHLkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:40:11 -0500
Received: from mailout.micron.com ([137.201.242.129]:25979 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbfBHLkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 06:40:10 -0500
Received: from mail.micron.com (bowex17g.micron.com [137.201.20.31])
        by mailout.micron.com (8.14.4/8.14.6) with ESMTP id x18Bdjds020492;
        Fri, 8 Feb 2019 04:39:45 -0700
Received: from bowex36c.micron.com (137.201.84.132) by BOWEX17G.micron.com
 (137.201.20.31) with Microsoft SMTP Server (TLS) id 15.0.1365.1; Fri, 8 Feb
 2019 04:39:44 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (137.201.84.23)
 by bowex36c.micron.com (137.201.84.132) with Microsoft SMTP Server (TLS) id
 15.0.1365.1 via Frontend Transport; Fri, 8 Feb 2019 04:39:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=MicronCorp.onmicrosoft.com; s=selector1-micron-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqwUnwYq4ecgcrg7I4vLn1yANo/lgI87wnUY73AVIas=;
 b=Db65oTtCupbi1itBIKoD8cfG88yVFPc4M8kqcfF8FS0eFabxvsJnh/k0qfY2SziTZxY49naTJM6utRCXJHPcd7TCYFIozy1/UtJiYwRTpG2H4KIVAl9R9ZSHp4FeKe0/0ZUqvV6AyTpk2FXFaXocWPn/BOEsdq0SVIZoMUBTl8o=
Received: from BYAPR08MB4533.namprd08.prod.outlook.com (52.135.234.15) by
 BYAPR08MB5703.namprd08.prod.outlook.com (20.179.61.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Fri, 8 Feb 2019 11:39:43 +0000
Received: from BYAPR08MB4533.namprd08.prod.outlook.com
 ([fe80::911c:eb84:5e0d:c669]) by BYAPR08MB4533.namprd08.prod.outlook.com
 ([fe80::911c:eb84:5e0d:c669%3]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 11:39:43 +0000
From:   "Bean Huo (beanhuo)" <beanhuo@micron.com>
To:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "richard@nod.at" <richard@nod.at>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>
Subject: RE: [EXT] Re: [PATCH] include: mtd: spi-nor: change HWCPAS to HWCAPS
Thread-Topic: [EXT] Re: [PATCH] include: mtd: spi-nor: change HWCPAS to HWCAPS
Thread-Index: AdS+60iqy/bLyT9iSLSC+lMdoEdfvQArYGaAAAIzopA=
Date:   Fri, 8 Feb 2019 11:39:42 +0000
Message-ID: <BYAPR08MB4533E2C1B5CBD0789F1A1F0EDB690@BYAPR08MB4533.namprd08.prod.outlook.com>
References: <BYAPR08MB45338B3B9FE13B8FB3070789DB680@BYAPR08MB4533.namprd08.prod.outlook.com>
 <f167ad30-2a15-e430-1a6e-d1e1ba455b67@microchip.com>
In-Reply-To: <f167ad30-2a15-e430-1a6e-d1e1ba455b67@microchip.com>
Accept-Language: en-150, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=beanhuo@micron.com; 
x-originating-ip: [165.225.81.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB5703;6:bkdTN3aicJMaF6INvUWeElP9j3zsj+fYMlyas4i8eNnBbI70Gj/CoJHrBYxTFrKqQHuhNRX9selTPcKaNPe0Uc/coO3lWQ42dX6y8vOMgL7kFZOzGITRJ8n4ForxfWBZ524QZ1O9VXxJM4xdGN/INZMEv/1M9OoxAPpSyRyjqxzWCa59OzZ274gwjDN4gHYGqkH6DJcZlPwoq8xnv/tvYJw0pgI6rJ+dJGTtmDRmm782pI96GP2y1ox7AGbMvVwRVfXL2vYwHqGXNyi2KHViPYsMKFHdwjm4MUPgR57yccxpB0PBl9CFP1zdm/X2Xuld6+Yy7dWjb1l2sdI/F04Vl1OlJ1/UUXqQN+ei2/JEddN3OBuKu7p8AAJNfWpTwpT2fSPq58KyUkAUvSM3CQCo7gL3fSY62HrGjb5iJB7bnT0NMVWx/N1h6CiQXlpcwyMi4siwtUjz0gAzoEVLTFoOhw==;5:UIms7SyphXWh6haTRAxPNQp9PlCojm/yzC9oS2nab5EFPklDsQ6/5QKkxYbuiBZijsOph1W8mlX35b9pjT5CnvRBKpcWRZGWW427yb/i+6s2RGl1de292Kz6yrWyj90Huz+EPNiREBAWfV8T9DOz89mAKNXvq6tfhGm670vhaGkS8ejUwoA3logdCF+6Qqh82yiUfSRgRQc5Ozrg2rIUkA==;7:JSSTjkdnRWqZtbevcAdtXu3cGhKH0SB7HkpKyYf1N9Nm3eP9lVwIrNBKuTySvwcS8SaHohWJ4tnUR0ih7d2/UJ1l3+PhkJ+tHFhRl61C0OgSVO+qyQNsk56pTyp+/4JuNNOq0glIEZUa3CoA3ty8eA==
x-ms-office365-filtering-correlation-id: 67ba1e39-c250-40f4-ef9a-08d68dba1e50
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB5703;
x-ms-traffictypediagnostic: BYAPR08MB5703:|BYAPR08MB5703:
x-microsoft-antispam-prvs: <BYAPR08MB57037BCF7FEC1B7FB526A853DB690@BYAPR08MB5703.namprd08.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(376002)(39860400002)(396003)(189003)(199004)(26005)(6116002)(2906002)(54906003)(110136005)(316002)(14444005)(6506007)(55236004)(256004)(6246003)(3846002)(97736004)(8936002)(2201001)(102836004)(86362001)(14454004)(186003)(8676002)(105586002)(68736007)(106356001)(81166006)(81156014)(9686003)(71190400001)(33656002)(446003)(66066001)(6436002)(11346002)(4744005)(478600001)(55016002)(305945005)(71200400001)(53936002)(74316002)(2501003)(7696005)(476003)(99286004)(76176011)(25786009)(486006)(4326008)(7736002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR08MB5703;H:BYAPR08MB4533.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: F15bGEcqTpzNry17xaroWNVP+3TrzL6BUCmFOvpvYBBgDrUUgM/us133c3HkWaxNg5D8K193cbFSsH9NQpprOHT80X/E95mwIOQ4QtJoN6UsmQCVPq1JwwlLAwPJ7k3ofCNsmfom9ZNW+SGIHzmLLLJAmO8bB4hSqPfQ7Jzxaaakpf3Ak+HkbaydxIMdZrhG1kNjJ2ujWrCzXh2DZMw8f5CJO44uBsPjhQozBhB07ZoBMJJsbO18cjOwehixbD873D1X0c91OSVZpP0TKqYnYr5qiZ3vVVqY2UAO6cdQ1rbfyAHr3SW4kAyovyXQ243WAx88c4yLnH2i8rwlPeOfNwfHZiMNqlE2mWbuNwxjXQ4aAI1gXT9BVm1VksAZ52mOkH3IFgF2qOb6z4C3Q0fh6AcioozrKUWibFtmKTVYpC8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ba1e39-c250-40f4-ef9a-08d68dba1e50
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 11:39:42.9786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB5703
X-OriginatorOrg: micron.com
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24416.005
X-TM-AS-Result: No--7.554800-0.000000-31
X-TM-AS-MatchedID: 150567-139010-106230-186107-704425-700648-702118-703283-7
        03788-702344-105250-701305-851106-700075-702126-106420-701236-704689-702358
        -705178-702020-701461-703969-708328-700107-148004-148007-148020-148050-2004
        3-41000-42000-42003-63
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-CheckInternalSenderRule: True
X-Scanned-By: MIMEDefang 2.78 on 137.201.82.98
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tudor

>SNOR_HWCPAS_READ_OCTO was renamed to SNOR_HWCPAS_READ_OCTAL
>please update your remote and send a new patch.
>
Which branch do you mean? I checked linux-mtd, not renamed yet.

>The patch prefix is wrong, it should be prefixed with "mtd: spi-nor:". Whe=
n in
>doubt, you can check how were prefixed previous patches on the same file b=
y
>running something like:
>
>git log --oneline include/linux/mtd/spi-nor.h
>
>On 02/07/2019 03:46 PM, Bean Huo (beanhuo) wrote:
>>
>
>This looks like a blank line, it's not needed, remove it please.
>> Maybe this is wrong abbreviation, change from HWCPAS to HWCAPS.
>
>Indeed, it is, use imperative, something like: "Fix wrong abbreviation,
>s/HWCPAS/HWCAPS"
>>
>> Signed-off-by: Bean Huo <beanhuo@micron.com>
>
>Your S-o-b tag doesn't match the author name, please fix this as well.

It is automatically added by git, what is correct way?=20
Thanks,
//Bean
