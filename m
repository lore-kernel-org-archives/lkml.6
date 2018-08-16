Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DBFC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 22:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7DF208B0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 22:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Zw8EXMBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7DF208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbeHQBzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 21:55:43 -0400
Received: from mail-bn3nam01on0107.outbound.protection.outlook.com ([104.47.33.107]:10690
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726103AbeHQBzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 21:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xn1JKqXhesJECxlzG9Bmwgkch7UgaDyleHYuVJtPfy4=;
 b=Zw8EXMBnP87rtiXTpOYdYmWJDIi9P7MPQWtPkIqUqWGqAEwLWTIyZWl9P/W5Ms3YLjByyvIE0WrRcdVkXY5defonmgf7anHr81gJVu4ihJk8jIVmKRO/HyXxg8HETmkZxTougLQqWndw+VMlHat3nVobtKqoUZq9QrcCPPFEoWk=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0474.namprd21.prod.outlook.com (10.172.92.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.7; Thu, 16 Aug 2018 22:54:38 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee%8]) with mapi id 15.20.1080.009; Thu, 16 Aug 2018
 22:54:38 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Jia He <hejianet@gmail.com>
CC:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Philip Derrin <philip@cog.systems>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kemi Wang <kemi.wang@intel.com>,
        Petr Tesarik <ptesarik@suse.com>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Daniel Vacek <neelx@redhat.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jia He <jia.he@hxt-semitech.com>
Subject: Re: [RESEND PATCH v10 2/6] mm: page_alloc: remain
 memblock_next_valid_pfn() on arm/arm64
Thread-Topic: [RESEND PATCH v10 2/6] mm: page_alloc: remain
 memblock_next_valid_pfn() on arm/arm64
Thread-Index: AQHUNbQckrhYDDtuAkijz8ueJvYRWA==
Date:   Thu, 16 Aug 2018 22:54:38 +0000
Message-ID: <20180816225437.5zkchip422esdqwh@xakep.localdomain>
References: <1530867675-9018-1-git-send-email-hejianet@gmail.com>
 <1530867675-9018-3-git-send-email-hejianet@gmail.com>
In-Reply-To: <1530867675-9018-3-git-send-email-hejianet@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [73.69.118.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0474;6:/LFcFPKizceh+46zfDdbD0FoWZ4w0dbWkxIC2RnTaOqdoxcRgqqIDWq9XAT4hzGOFjnpIU90wnoIEHKRwjIq/YP2AacVXVOzFu6r2e7FOMZJhHGbHNZ3PBfFDEh+VzfJOeObRsa36WLNGLeJGhmm2w3TxdAshby51MwqmTNN5wLFbmUfVLSbi+2L4Ne6V7/Bt7RH4Jaz2IT+WY5A5jWTr3RSSPhlZe2bxyubYnOrj8LE0WZgfxCiI3nai4aX00/XQFQO7vDYqjEHGUwk9s0iG74i2JafjIpH5R2c5GA/yNRNkxtjgsrbuar2yr2KYNTeCw4uI8M15dp/OnLNZQ4unVz4AOoeN/m4b+4eYIk1R2fKrk8jNa86vKZrsLusqr+f6PJPT6OzFzkznZaMoP9RMge9nFaEBS6gUMdd5SGKZ8UcgbWRh2vphfwTCbTwYMruvF8bv65VXbPhd3bA994dbQ==;5:+yfd44tEvqcs1LgcQ/tUfVp7lha8ed3xNMifMEx4VRM8SnTe8ancm5DkCKwdrQvjJDKPWwneGfil2W7+09RS4Hu9PjhztBSzGEyOmuaSBwa9a/Iaxxq9qkRVZXcnKDH4dM+iIW2SbCNrDytWtrpjODJ/ObZ7hsGGMuukh21eViY=;7:vscdPNx8AEIqPL20liCE+LBQIQd0DQssQZbyRwT+pZC7Ordb7cahA2Xfa9UB8W7N3NwhNqJoEltz3X9q8/hSlVgEaLJ4y0W+eowlLBOwcAWiR8GzxP1F196m9phHb2aZCnrrK9WjlpoPiZjCWNazeAcd/yTm6qatzGAPCO2ecuBptIfv5s4uVNiJqpaTm4gyfGylSblU7altBru/GVzX9AmeBFk7xXpUYpEqudbug4aBWN9uPqgJuA5Ggvd+/h3t
x-ms-office365-filtering-correlation-id: 44220bf8-b25b-4c53-db9d-08d603cb3ece
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0474;
x-ms-traffictypediagnostic: DM5PR21MB0474:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB0474456D3FAE117BF25F4A399D3E0@DM5PR21MB0474.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(20180801012)(6040522)(2401047)(5005006)(8121501046)(3231336)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699016);SRVR:DM5PR21MB0474;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0474;
x-forefront-prvs: 07665BE9D1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(189003)(199004)(6246003)(68736007)(25786009)(22452003)(54906003)(106356001)(8936002)(105586002)(33896004)(10090500001)(81156014)(8676002)(81166006)(316002)(305945005)(4326008)(5250100002)(39060400002)(7736002)(6116002)(3846002)(1076002)(97736004)(6486002)(86612001)(256004)(217873002)(6436002)(7416002)(7406005)(2900100001)(66066001)(229853002)(5660300001)(6916009)(53936002)(9686003)(6512007)(102836004)(6506007)(26005)(2906002)(99286004)(76176011)(53546011)(186003)(11346002)(476003)(86362001)(10290500003)(72206003)(478600001)(486006)(446003)(14454004)(1411001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0474;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wgY7Kmikjr+44vCJfGjhkHVQozS4qXt/liAkWw3Cni4NU4GXhFoHNGsziesRj/AP6d1O0iDDWeybr1IeKAI7+2QmAhanCqBoMqWPgCQZAdygFBKskpoDRY4CAHEbDKTnOIM2nrrqrx6qHAf5vI0F9IOMOy27IsYDG3CabTlowomlGH9Hm/ANDGE3PyOM2t1AM1XIhbugmUDiARocv+4bflJqyIda/zK9UszNnHtUpsHKF+oTyeAcAu8NYiH/d6dMOL18YiAHveJcc45S289id8NfFYIT46IGHc6rmtqDp2irmQbqF/71IK3oEeg1Gn0AP53Ocd4e4fsIHuXXzXRoUVGioIrlFji+NRbDTYZ98Uo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <46623D63BEBB1E4ABFC291B2624C8EAD@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44220bf8-b25b-4c53-db9d-08d603cb3ece
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2018 22:54:38.4710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0474
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-07-06 17:01:11, Jia He wrote:
> From: Jia He <jia.he@hxt-semitech.com>
>=20
> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
> where possible") optimized the loop in memmap_init_zone(). But it causes
> possible panic bug. So Daniel Vacek reverted it later.
>=20
> But as suggested by Daniel Vacek, it is fine to using memblock to skip
> gaps and finding next valid frame with CONFIG_HAVE_ARCH_PFN_VALID.
> Daniel said:
> "On arm and arm64, memblock is used by default. But generic version of
> pfn_valid() is based on mem sections and memblock_next_valid_pfn() does
> not always return the next valid one but skips more resulting in some
> valid frames to be skipped (as if they were invalid). And that's why
> kernel was eventually crashing on some !arm machines."
>=20
> About the performance consideration:
> As said by James in b92df1de5,
> "I have tested this patch on a virtual model of a Samurai CPU
> with a sparse memory map.  The kernel boot time drops from 109 to
> 62 seconds."
>=20
> Thus it would be better if we remain memblock_next_valid_pfn on arm/arm64=
.
>=20
> Suggested-by: Daniel Vacek <neelx@redhat.com>
> Signed-off-by: Jia He <jia.he@hxt-semitech.com>

The version of this patch in linux-next has few fixes, I reviewed that one
looks good to me.

Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>=
