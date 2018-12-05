Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71664C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CAEA20878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="moUa7ufk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CAEA20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=live.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbeLEFhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 00:37:39 -0500
Received: from mail-oln040092001075.outbound.protection.outlook.com ([40.92.1.75]:59227
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726037AbeLEFhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 00:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49nlbjB/HVN4CbcTzKVYo25woRCnMJ1RH/9OpnFtFkc=;
 b=moUa7ufkXRzI6GoQWum+KjY+nwVPKHWbussPclT05MTa1ZQEs9tM3lHt/7GBwIcQh8/mkVpybTUyTSj8Y+rgKKEXshLrWvXdqtoi/B82x2Hd/6LxXdW2lTnL9D9KjojkdFWz4qSez8aAhJNNCn93LAnGw4q88G7gp+JVjsMfs4VkJRw0gzS1i/uzslRArmBpslsTV1+EmTgPTDywCF0+wk1dYMQSDzQbMMQ+dYtUN11mXic3YqO/r4lvg6jayPOVuHQeF3KuD/4zRrjHcEWviF2Bo2xGnUV6D8CnUxnC+Emo5LnL4sfoqEfJR7EhmEJB77lM2pGo+T3LNnjRMu0x5w==
Received: from BY2NAM01FT023.eop-nam01.prod.protection.outlook.com
 (10.152.68.57) by BY2NAM01HT032.eop-nam01.prod.protection.outlook.com
 (10.152.68.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1404.13; Wed, 5 Dec
 2018 05:37:37 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com (10.152.68.55) by
 BY2NAM01FT023.mail.protection.outlook.com (10.152.69.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1404.13 via Frontend Transport; Wed, 5 Dec 2018 05:37:37 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::19ff:b7ea:dfaa:2ee3]) by BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::19ff:b7ea:dfaa:2ee3%2]) with mapi id 15.20.1404.019; Wed, 5 Dec 2018
 05:37:37 +0000
From:   Yueyi Li <liyueyi@live.com>
To:     Wei Yang <richard.weiyang@gmail.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] memblock: Anonotate memblock_is_reserved() with
 __init_memblock.
Thread-Topic: [PATCH v2] memblock: Anonotate memblock_is_reserved() with
 __init_memblock.
Thread-Index: AQHUiryuEY3GC2m5nk+tSrupm8LKDqVt5pqAgAG9JYA=
Date:   Wed, 5 Dec 2018 05:37:37 +0000
Message-ID: <BLUPR13MB02891C690507E91D0581E79FDFA80@BLUPR13MB0289.namprd13.prod.outlook.com>
References: <BLUPR13MB02893411BF12EACB61888E80DFAE0@BLUPR13MB0289.namprd13.prod.outlook.com>
 <20181204030415.zpcvbzh5gxz5hxc6@master>
In-Reply-To: <20181204030415.zpcvbzh5gxz5hxc6@master>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::28) To BLUPR13MB0289.namprd13.prod.outlook.com
 (2a01:111:e400:5951::22)
x-incomingtopheadermarker: OriginalChecksum:B6EF4B677E25A9F0A1F6D6FE54D739BC0C73BC7D3A6864055C4F474FF0A3D000;UpperCasedChecksum:6642BB504BB443A7FB082DC89C5A307DAEE6F09306C58FCEAD0ADF4485CCD582;SizeAsReceived:7738;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [CeEi051hXt7cDS7P9xY52aTnRgD6aoho]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2NAM01HT032;6:a/L9r4bc5zfDE7hSL+rhBfkb3uLK7p9xa7kiTBOb44B7esFxhg2ZTMnNC9gtYVeVOGKtW6EK8Wt33xJ/uH7K5BmTod3eIfklBDZhUK5NIJIYRVVmrUf83MpEZAqXFbA4AfkrVLL3iHEuz3HQacOpeUfhi8RYEv8knUFzoCP+AelEqJ08W9BazlmvWIjMGCevTALqbeSbkiwVc/WTnjXcCGWkUeCk3/THKZAeLX+YwiGJUITE0kmItAwJ8Bt4hAWjwvmQqdGqCLads1rDGgNQWD1oZL4ZIEBVyRNts2+upEMJGce7XR1hf0YdEje6RCLCwGXFRtfDZiXG9ETEPLAyAevRrDKtI+FdQ2qftpCKBVllAIU3okyZcXX6+wIopQezaK+hoQkOHgv9NLk5lqSDNA7f1O521npITPksiWPhZyF4H8lrk7AOIgrpikAJ9O0XGDM9UIT0R2H/FxxIMYjVpA==;5:n9qpyfWtUAiZO/AgjkWPx5r3QHSzQtVMGiKCdCBHm7ILkIdFvtiCbk21P/j++P/egGUlBFeaNn7SW2auZWafbg4ttrmyqGGJKhKfysoXIIx41asrGR7NFXkCO5R6UzGCgvBen9twZFWIwdLTXi+yxxJhGpFj3OBAsS8VVcYTOgM=;7:u/4QJjB8CUcQ7LpUAKjqyufiBPYt1y6OgeKx3Ubnkd/uRsCVxVXt71YnSORrySMe7S9mnQkGDSEU8+gjsQJP+Fy0FdfJQA+dPKAoijmh2tCgcBMmYyARyKmaAwLIe5AQq/llldzMbZvICA4G3/U70g==
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1603101475)(1601125500)(1701031045);SRVR:BY2NAM01HT032;
x-ms-traffictypediagnostic: BY2NAM01HT032:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:BY2NAM01HT032;BCL:0;PCL:0;RULEID:;SRVR:BY2NAM01HT032;
x-microsoft-antispam-message-info: b9JYAZlNy651bcZj8I9cRWpYG4VT9JcaXIsNZv9XFGAILJ9VRCwyiICd+uKpsEYI
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <3F6DD7343CFD8C43BA08FE6D04863379@namprd13.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce09e1e-5e28-468e-3c58-08d65a73c32f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 05:37:37.2520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2NAM01HT032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/12/4 11:04, Wei Yang wrote:
> On Mon, Dec 03, 2018 at 04:00:08AM +0000, Yueyi Li wrote:
>> Found warning:
>>
>> WARNING: EXPORT symbol "gsi_write_channel_scratch" [vmlinux] version gen=
eration failed, symbol will not be versioned.
>> WARNING: vmlinux.o(.text+0x1e0a0): Section mismatch in reference from th=
e function valid_phys_addr_range() to the function .init.text:memblock_is_r=
eserved()
>> The function valid_phys_addr_range() references
>> the function __init memblock_is_reserved().
>> This is often because valid_phys_addr_range lacks a __init
>> annotation or the annotation of memblock_is_reserved is wrong.
>>
>> Use __init_memblock instead of __init.
> Not familiar with this error, the change looks good to me while have
> some questions.
>
> 1. I don't see valid_phys_addr_range() reference memblock_is_reserved().
>     This is in which file or arch?

Yes,  I modified valid_phys_addr_range() for some other debugging.

> 2. In case a function reference memblock_is_reserved(), should it has
>     the annotation of __init_memblock too? Or just __init is ok? If my
>     understanding is correct, annotation __init is ok. Well, I don't see
>     valid_phys_addr_range() has an annotation.
> 3. The only valid_phys_addr_range() reference some memblock function is
>     the one in arch/arm64/mm/mmap.c. Do we suppose to add an annotation t=
o
>     this?

Actually, __init_memblock is null in arch arm64, this warning is due to
CONFIG_DEBUG_SECTION_MISMATCH enabled,  the help text in lib/Kconfig.debug.



Thanks,
Yueyi
