Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3244C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B976206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mit.edu header.i=@mit.edu header.b="hneD5Jvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfAIQzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:55:19 -0500
Received: from mail-eopbgr800115.outbound.protection.outlook.com ([40.107.80.115]:34256
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726072AbfAIQzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:55:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOyeOb/ZnaVRojQNtVkIT+8tktpMDRMo/ScHLDs+7w4=;
 b=hneD5JvgGOW8rsMW6S986ALToWt4L7SB6Rmzbk+fAY+8+sIDwzeuDr7kVMmp9lYq645lDbdTMSdxKRPtv03D7mYppyPBZtq++VYzNnjcVsmmvWPy2NXxDlRojZwb1ogCfP4alKfnORzHTQodTLNErco7g4XWmIBSAeJWO97ud+I=
Received: from SN2PR01CA0066.prod.exchangelabs.com (2603:10b6:800::34) by
 DM5PR0101MB2954.prod.exchangelabs.com (2603:10b6:4:2b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.8; Wed, 9 Jan 2019 16:55:12 +0000
Received: from BY2NAM03FT036.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e4a::209) by SN2PR01CA0066.outlook.office365.com
 (2603:10b6:800::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1495.9 via Frontend
 Transport; Wed, 9 Jan 2019 16:55:12 +0000
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 BY2NAM03FT036.mail.protection.outlook.com (10.152.85.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1471.13 via Frontend Transport; Wed, 9 Jan 2019 16:55:09 +0000
Received: from callcc.thunk.org (guestnat-104-133-0-100.corp.google.com [104.133.0.100] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x09Gt5mC014675
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Jan 2019 11:55:07 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1DF537A02E7; Wed,  9 Jan 2019 11:55:05 -0500 (EST)
Date:   Wed, 9 Jan 2019 11:55:05 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
CC:     Vinod Koul <vkoul@kernel.org>,
        "andy.gross@linaro.org" <andy.gross@linaro.org>,
        "david.brown@linaro.org" <david.brown@linaro.org>,
        Sinan Kaya <okaya@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>
Subject: Re: About some mail lost and random unsubscribe issues on this
 dmaengine list
Message-ID: <20190109165505.GC26670@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>,
        Vinod Koul <vkoul@kernel.org>,
        "andy.gross@linaro.org" <andy.gross@linaro.org>,
        "david.brown@linaro.org" <david.brown@linaro.org>,
        Sinan Kaya <okaya@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>
References: <81c9fe2de4b5dac1d5b974f5305e35bf1cf5d127.1544156508.git.shunyong.yang@hxt-semitech.com>
 <ea6c6317dabffdcfa28cdb391b50edce98ce875d.1544156508.git.shunyong.yang@hxt-semitech.com>
 <88ef21bd-4e4f-8cce-39b3-53da45740f0f@kernel.org>
 <79da1c31d3e14e6e91cf6a7cc0fea31a@HXTBJIDCEMVIW01.hxtcorp.net>
 <16bbdd233f1d45249eb2f6592418efd5@HXTBJIDCEMVIW02.hxtcorp.net>
 <b607a505d2974e1d879ba7d7c3488f85@HXTBJIDCEMVIW02.hxtcorp.net>
 <20190109065851.GW13372@vkoul-mobl.Dlink>
 <e3a2d37d7bce44eb8d3a726a8f69c8d7@HXTBJIDCEMVIW02.hxtcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e3a2d37d7bce44eb8d3a726a8f69c8d7@HXTBJIDCEMVIW02.hxtcorp.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(346002)(136003)(39860400002)(396003)(376002)(2980300002)(189003)(199004)(478600001)(26826003)(486006)(16586007)(5660300001)(58126008)(6916009)(103686004)(36756003)(316002)(42186006)(786003)(106002)(36906005)(106466001)(47776003)(54906003)(23726003)(305945005)(52956003)(26005)(356004)(246002)(76176011)(8936002)(93886005)(6346003)(86362001)(1076003)(2616005)(11346002)(75432002)(46406003)(2906002)(8676002)(97756001)(33656002)(88552002)(186003)(126002)(446003)(476003)(336012)(90966002)(6246003)(6266002)(50466002)(229853002)(4326008)(18370500001)(42866002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR0101MB2954;H:outgoing.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:outgoing-auth-1.mit.edu;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM03FT036;1:qXhH/NRglbJ/+XhDKwXIg0KGNXJcsRRhgzBN2VdtSlIpXmycccfl2FCeZcFLA32zun/dSaY8Cv9zd1eVOM9iaiDNt8FOYUvnAt7ZbHpBe/vreVgO01aXHcHHE/pYo2uP
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0cfa292-e3e7-46a5-67cc-08d676533896
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:DM5PR0101MB2954;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0101MB2954;3:C13Z9O4pe3DdI3duSBDcK58VYs/Uwjkc/XZYGXjnYrZpes1w+DhTBAm744HxBElGAkI4Frvo7lciUQq6P2juQ1l5iUHpbu2gwJ/DlSNn9TpQYWEcF6okfFmYEm5R8mlMGRHrcNjuuJzYSbB24ZZFHc21t5opQkOg2ziwGHPr8lL0xaWMaW5Gd+AETOtmBOuRWSH8xOvuuYm/KrinULMyan9uJzrYgs2AjFowt7o55froe498ZhMCxAvZmlklemFgJQj9l/zg0sZBLCGWbKhWh0lBWrNkvQHT/aKO/71UCU8Ouw82I/KPcHNvlw/ogx2RR4WpBnQsqB5nfEeFmrhfQQuE90B+kTIX5NfBHQrlrHnwkwred/vzOwYLYepPe4Ah;25:CLyM75FSew8bOPXYEQLvJ1mv12vTOEbsSDwMu+no3e4F0GXYlRo7McCfduhG8/uziJGijr0gtpfcYBpHoX/8tdo0nvNtKSukfNktCpSZELgS5RzYhJYQZHKpB3S7douuguIfNoWvm9pU7EtROTMOrD7oPiDclOFPoI3RMnWqpuT67Kb8+8vkgQCHRX5TweHt/U7tXwHZx4uBVbeVFTOnz9ansBAxGia+xyntFWKWwF3qRjznzD2tH6EsTaaZsdU1wZr0tdYP2MSVClGj/9B87y0aPvDSLNc6035lZv6rK6B6PZf5h+sTHBOTutgT5xHsWbB8dgk/6lSbWOkUcqu8ag==
X-MS-TrafficTypeDiagnostic: DM5PR0101MB2954:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0101MB2954;31:gT6rkC7HmVdnxpiFEuw2Bup6hnlr8QYeAx078Zm9IzK1cfSggs2xrVPRTT9ZCQQo/VZryYBVQlJ7DctWlkyvV/6NRIh5vKOqGC0mEgbEb2U3oSf0A5tR/4GdGw+qOnvk9Ol2BpoQktBHt0i6pbhQV6Fz3oAxLdDTDePNWGjPsAo1BUMNW2RGKp9lsnRX6849Z7KuHUheEqiiIKFXA2Ngb9wc333wVEqxALrUz8mxDJg=;20:PuYqd/UwiaUOTbc1I+yU5Yn2q0xyslfOy11cC+qMiCJA+6StEu8rB3mDHNP9v5UazT72wD73zdS/xpCN2ZDDdfSlvBByUEE6diRwkqYBbC26sBNWme4IyyvskS0e8ElagwbtPETcJT4XpCyod/+gwkPQIcgEVTM1d3bdNf9/uLpKm49/2mgrycA4s1IWrVNhWKTaiwxw2QxdBBUpeeRenFjMsQ8UCFga7XGNkDMWAyaVb+5GyBX3E50GLUBX/Tj9aYrUWCWs5DnXWc1vjTHD3NjYE8KoOL24WHyG1lweaLL0uUyJgnbXMTd1lvfm2anoR98Df4osiOvJuXsg6RwJmVq8+Z2R9X/jkrrxcsObxsiZ4R5EgHasuARybn+qCDpKewLTBx8WZC01lRzeXg30jBG3bSN5dzGybgz2uNIJVr08/nl3P08rbM5JGdI2OY1DvrXp9QWwSwNgQaqygAfzx9rte2oLmRN9x7TWwQL7lK9rl6lWCm56+ElUitLCavBX
X-Microsoft-Antispam-PRVS: <DM5PR0101MB2954EAE9C2A632F912218744B58B0@DM5PR0101MB2954.prod.exchangelabs.com>
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0101MB2954;4:aCLIUoFL5ioi0KKMnU1YiSnWCuJzj8t30o4v4jjvAiEjnJZGMFnE1yX/P3wc69ZkRjyKlayjycxe9J48Qkas/Ihyv/FEnb2p+iBW/ASrvADt9HSN6tHYER+FlYNVb14p0CLUIa11OPGeaxgHPgp8nxAXh8q0VmqQMG0jqQhZwkcSHX9Kdm8+8BR+M7whURhAsE+BBCIeHynCIsMr/uyITbATwivyVNl6te2+DvIY/qWCe2/r7QXa8T9zTxmxkcuR8i8X/OaBwdwF4xEGSZqdbHnzRURQus/oX9ZQ8Tmn7+oojuDKM4KY6q/rXkYV1kCz
X-Forefront-PRVS: 0912297777
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0101MB2954;23:UXyWq7gTbcG4qUq0MvpNgUkE7/oHjrFp68Yc8/7?=
 =?us-ascii?Q?PxVol9J1qq7Gl/ivvTNklhW7F0UjJGLrOEsUTj+xmK3nTulrOKnmGoSGva3R?=
 =?us-ascii?Q?qhvK4Y6SXnFBqR/FQd8DXqqI1NaMXGb4co4eDuevwmuBaeN6hNYyHUZqR7Rc?=
 =?us-ascii?Q?b3mA1bxnoSCpzoNcM+f+hiUfS8JqQzZaJZ84LSkDS53zZukxDwBonvTrfdRX?=
 =?us-ascii?Q?EgZQqXgf5Q2DzOnp7ZI0gGoJoHfqqKl2NyIMKyOBmhsJkRA9HncBO0Kw79pM?=
 =?us-ascii?Q?MtvmqBMEkubtbK9MCinQTChGMe53xeoQRyZugfgLpliIvvkZ/92LkYBfkBB+?=
 =?us-ascii?Q?wcUrY+Gn/G0DqjaNVyytGdbYyT/pgnUDBHhiujIe8JLfuxWhS+CJw66PDsLw?=
 =?us-ascii?Q?bI9KSv8wWUhgGeP2Be8LUTYuaY30rFRUNkEC4W9kGoRZv/z8Kp4fv3J91KTC?=
 =?us-ascii?Q?2BSeoDTAzwqHBkxhgyJ21V3HxHD1stV0zwuj5yTYEsfwNY2y2HVxbKzm/yj5?=
 =?us-ascii?Q?mqOj+GgTmA6FNXllNw0sFjw49ol87332o6hCUQIIUj3tgTGVzOoWsUWVm2vP?=
 =?us-ascii?Q?hDp5RZtz1/C9N2uDx9QYmn7Zfa9tAMfrN7uKb4ptBuRnCKZN7UBe83V3rIdB?=
 =?us-ascii?Q?TTXeLNgKAVLFsnSfX5MUirgiZU5qsd4qgbn0EIVBGt7fGP4h+RCqzIxgy/eU?=
 =?us-ascii?Q?h87Igymf37ygkoUGDyJ4ZOxD34pFo0xRRVsqHvVboioC3SCuX4H2M2k7phWj?=
 =?us-ascii?Q?moi2j8IuKdBdaIAu2+nvFHb6OU/8iY3vY7mUUq2Oo/Lz90oPhaKeYDgqgbdP?=
 =?us-ascii?Q?SC5qHWfN89ej8fO2At7s9tXi7EsEPIGGGRvkTC7yvOXUHdDA2xgwTWHKavKf?=
 =?us-ascii?Q?G+XeY6Hqu3H20bjCbQZA3beB6gVAuQzc938Twfwb9gJUQ4lh50WCbleVuJqZ?=
 =?us-ascii?Q?Nw4NVjDYVi0iq8WmiJrtZzRB30VUbfZbYChuiPNiIe5QcUJ8VPcIef5ZhSG3?=
 =?us-ascii?Q?O8hbAk7ZGdk3cw/3Y/zT4lFwqxql1rnvVWWShCf/P4mLxbxKQ9qcA1Kh/fce?=
 =?us-ascii?Q?0qpPmJb0/WjtNmw3ip3au+SRL1gsPBqmayea0nA4iGZRsHIqnAkynnIE9N9z?=
 =?us-ascii?Q?218RSYTF0GhbblyFNf5elMeegl9PAGMR/JnzWdvbJGl6qd+cBGvFkiOpfVPR?=
 =?us-ascii?Q?95OwUSMI6erJd/QDjERUN/VcGtaMDzkjLHI+XRHlH9Nd5QMn78FLlQuoV+X6?=
 =?us-ascii?Q?Dtwt2ceh5EEK/7Eb9opV950g2KzuLQlnqMGNL57dCSHURwRejs2JTnHEfdjq?=
 =?us-ascii?Q?w3w=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: saRZJUUU/r6gaYy/8I+/21HVq4XM0U7Fv29wVj9A4oGau19xQkj4vJnEhcd1VBoRYnTln/eK1lrj+2MA2gu5aFoi03A5QwdI1m24Aiad5HcsYieHpVkvADTM6i5YjbVlLNVx8nsAhhldByGHb/h5RsPszE67HT7rWhFNFpeKTdyzn/h2AuxaUnBWdk11D6YuIHn8fZTFNs+rn9PETyyg/Aldj70H3OCOR+jxkhr3L5JrhnChjUnqemQdPEcti0k471NDYIop3ky2jeuBCQvLnGikH9o60i9a+wrSN6xorJlUKD2bxTl5G2/c0wChM+Ic
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0101MB2954;6:13Is+B25JNUn+uQdWWqsKPgp6izupNOKfB1nkumrb1xe8PXfVh9kV9uNXQTF7OmtPSzJZf7dyHW8F46PxbwAep+cnVeS4rUvahKHBG3Q1YG/PNlnu0nE9am9cMToMKzv7ygQcP59bzOnvOI650Wp8jLB+5ahk8Yy7Nr4jiCr69O3YBaiWn0mwqZAdGG7M3I+b/CThssTzlXT3ol1byc73sTIWHpI7IQ6wuHmQH8ygIRULwAbqz/gZEPnLerM55o6m/bP6U4vIA/5qlmRY2/B7Wg3dr6gV8wRsnVPAi5BalHic/L11dIxUbd7yUTh3dB7JTkC3gcXPX2emJxv2mf0wa/5y5wGZWMNaCDH9KsOYExftdG1lPFyQi7MmK+gipEPAgVjrVLtwvZ2l4tO+2z9xciuoQ2d4cj++mQyVPgsma00cChAU4GZSX607QiP1vSiLNQ40DiARVw0pKvhTLFgCw==;5:Bpysa5ptsf/Wbsk3dJJdKP1RBUA1GpjKa+wVDdXWDPwqEHrGbHDNNK5/v3Ur3pYf1LQSg0ei+Cc7TNwUoaVuOGPUffGbRozyfTTKkwiLBQCkdJ7iUBr+xgIT/RyufNPuwjBgfWZhn4oGdJrViKp6UwsQbKvBx4HmTjySwdWm+VxGMSH26zMnYKKMR7wBuFdFoPeEX5MkVmMMsnkSynmVVg==;7:LNIdwZyIP7f8fxUte2ZY14JNypWsD6nXzhW1v9ygcM3UIWKZDGAT3q3/shHm3M8v+wENBwIIW89TgsOz52VNEyhVt8QtN6xz4WtvYIJpBWGAhJA/gUdKmdnquDm45rHYl2/mDVyptnb34g3aoBBhaQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2019 16:55:09.4184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0cfa292-e3e7-46a5-67cc-08d676533896
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.9.28.11];Helo=[outgoing.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0101MB2954
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 07:51:11AM +0000, Yang, Shunyong wrote:
> Hi, Vinod,
>   Thanks for your information. I will check with our IT.
> Shunyong.

The usual answer is generally over-enthuastic application of anti-SPAM
techniques, especially DMARC, which is fundamentally mailing-list hostile.

Cheers,

					- Ted
