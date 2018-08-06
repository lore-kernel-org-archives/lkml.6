Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822ADC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 06:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0F5219DA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 06:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TwNUvFBb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B0F5219DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbeHFIe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 04:34:57 -0400
Received: from mail-pu1apc01on0139.outbound.protection.outlook.com ([104.47.126.139]:61341
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726178AbeHFIe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 04:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Txx3mgifpFcfm0sBz/40BlTx8mUn6pood7scQOo5His=;
 b=TwNUvFBb4M/taeXsuo7zM99hH0z9m6eG80D5oWkjEKp15odpiYZJE2RHPRBpBYDsHP99Q9aw6NElMAK7Xo1JNo1cDnXEoIElAI+19nuNv4M2aHDeQjWgl4sLCrX4PWtvOXabaDTO3W03V1PdH7GOESDsNiK2gYqDC4yLw8cXdW0=
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM (10.170.136.145) by
 SG2P15301MB0096.APCP153.PROD.OUTLOOK.COM (10.170.136.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.3; Mon, 6 Aug 2018 06:27:14 +0000
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::79cc:ffbc:c0e5:57d9]) by SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::79cc:ffbc:c0e5:57d9%4]) with mapi id 15.20.1059.003; Mon, 6 Aug 2018
 06:27:13 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?iso-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: Re: linux-next: manual merge of the kvm tree with the tip tree
Thread-Topic: linux-next: manual merge of the kvm tree with the tip tree
Thread-Index: AQHULUQOLZqxYxD4EkOj2UmPEvmSq6SyQnUA
Date:   Mon, 6 Aug 2018 06:27:13 +0000
Message-ID: <d9c9ff93-a183-798a-5404-e1768de7597c@microsoft.com>
References: <20180806151211.710b8615@canb.auug.org.au>
In-Reply-To: <20180806151211.710b8615@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SG2P15301MB0096;6:f7KbV4+yNeTP1xY4WVnYtafHpa0F24diJyVEF8Olc9kPZbeFUQUgqEG9aalAUv4fnY7yJnL1jxM9G5XJF2iiIf8aHEFmchIR/z+Lt0OpChRZYfk0RlE7AmCv9X7c/OjOJOq3LZ28tjRatcmXaBcEZWT0F9fRKbqI408tzxlwCGkmU7iYUrC5Wi72LGgJHnG/8nE/iIXYfw9FPVqkl2CToTvK6fR2kOi0OVpCGE7Q+oaVw+Ud+weR0s78BAG/QqoDmyhGDglGvngLZCnUZE6Z295GuhASIXAKrqioGNWN5taFXX7/qNJuW/PjA9RPBn6n6Yhwa5fR8hT9l1jjSBPDwqPL7q0zYTvG8xo2HO/6Yhpb6r9G9Juo0uqsQZC+wDqZgVPT00IQ8PmcE5ivrG9rRKtizmWK6LHG7fncd+GAuQhHpwfpD7K97enqUx88cKDaGx74iUpsMldTcaCC1cl9Yg==;5:mrgrqmSdh6leH1tgdmMcITXq8x6WPiyBaxAoaUYmwF6+mt6B7Kec3mRax+AN00DnOu2aMIL67dUYzZqXzi6mGc5e3Ym5gU5W4GVPm1IccEJSj3nWBET/j2HqoL0u8elHkEPWINFUh/CZj51qDJb8eprhGhPZxDkNePwfU+jbWWI=;7:yeiHJQXpN+GFCxTYgD+sBZ2bhEXE7kAHJ9p7TYlMJzAnhtzlAeAh7F7GxzArGwvrej8Jsl1j62c1OefR5Tk1fiDfrPI0ch0ozoVFvoEP9wlvzr/PYFXoaPl0oLRFk0Vlcx6ztSlnd9lIJASbtG68N1uw54gVDngSl7F+75mk+10X3UWeRU+0p9hzyXZZwyoChqKwV8nsalLw53XP4wigHwam40zfKEkLXRdtUMiNX9/pKkPkgwwvzE93mahk2rmJ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 995e7c48-067b-40fc-5120-08d5fb65a612
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:SG2P15301MB0096;
x-ms-traffictypediagnostic: SG2P15301MB0096:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-microsoft-antispam-prvs: <SG2P15301MB0096C1F910C1C90A1C3D21E392200@SG2P15301MB0096.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SG2P15301MB0096;BCL:0;PCL:0;RULEID:;SRVR:SG2P15301MB0096;
x-forefront-prvs: 07562C22DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(53754006)(316002)(110136005)(6436002)(25786009)(6486002)(105586002)(305945005)(22452003)(478600001)(7416002)(66066001)(256004)(54906003)(8936002)(11346002)(6512007)(446003)(10290500003)(6246003)(107886003)(8676002)(97736004)(53936002)(4326008)(106356001)(5250100002)(2906002)(68736007)(81156014)(81166006)(7736002)(6506007)(5660300001)(36756003)(53546011)(10090500001)(102836004)(76176011)(229853002)(31696002)(486006)(3846002)(86362001)(14454004)(2616005)(476003)(31686004)(26005)(186003)(72206003)(6116002)(99286004)(2900100001)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2P15301MB0096;H:SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: W5f+ghPiQWDMMNmbpffuumDc+FPfDKZbJawZaivanHH4wXjlAhiTBopinhLjnis6ZiYjdPHjYjb0LWR/NXfc4EKXjec72p35wOL3KMZJgsi9J7OO4vKUG/+KQWeunab0A47qg9m8vYGiXuHRuOMOApZxbR2ADe1lFg48x3bRc3TX83FWohm3m7J6YFu082wkeMMgMCBCxRjeW6aXirVPg3H3B+uqxA/Av6Glyg9hvTl5QUjwAmkDDbU911oXCAye5Salqxwqh5uYz9EAEPVJW9AYBUOx++UYLGuI9PnNSwHAPRt308eY2/tFz/z4r8GTodjmHprJImag1M/SZOs99LsdLpwLZ/BT7PJvxlAYQjY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <2F560AE98EBC4A439A09680C1F38001A@APCP153.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995e7c48-067b-40fc-5120-08d5fb65a612
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2018 06:27:13.4123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen:
	Thanks for fix. I will discuss with maintainer about how to deal with=20
the issue.

On 8/6/2018 1:12 PM, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next merge of the kvm tree got a conflict in:
>=20
>    arch/x86/include/asm/trace/hyperv.h
>=20
> between commit:
>=20
>    58ec5e9c9044 ("x86/hyper-v: Trace PV IPI send")
>=20
> from the tip tree and commit:
>=20
>    47c054685621 ("X86/Hyper-V: Add hyperv_nested_flush_guest_mapping ftra=
ce support")
>=20
> from the kvm tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> =
