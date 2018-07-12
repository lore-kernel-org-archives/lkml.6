Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105E1C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DBC02147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ErG6JT0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DBC02147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732558AbeGLO4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:56:14 -0400
Received: from mail-eopbgr40092.outbound.protection.outlook.com ([40.107.4.92]:29717
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732338AbeGLO4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9EoTnx6A3+kGBfXi4G09VMji6JiHrxrBwAmiS9VIVM=;
 b=ErG6JT0FNUXXuoPhDLj+xeEJtgcbGQQNKloaH9KYFoYvjxFLsnuBWHsjxV8TFnKAxyrb25gnA3tgAMI4Z43xpFHLJ1a725nzUVgSloDMoDNAgmxxEaDUvjr442f10gkPYgmVvm6Zg0OhQaCw9RcNnNJSGs57/uAN5GWYN0amLuA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 AM5PR0801MB2020.eurprd08.prod.outlook.com (2603:10a6:203:4b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Thu, 12 Jul
 2018 14:46:17 +0000
Subject: Re: [PATCH] bug-hunting.rst: Clarify bytes sequence format when
 making "Code:" human-readable
To:     Matthew Wilcox <willy@infradead.org>
Cc:     corbet@lwn.net, christophe.jaillet@wanadoo.fr,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <153138515186.6379.2711739561825941424.stgit@localhost.localdomain>
 <20180712125711.GB15277@bombadil.infradead.org>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <82f86c56-5bbd-8060-fea7-daceaf180c73@virtuozzo.com>
Date:   Thu, 12 Jul 2018 17:46:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180712125711.GB15277@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM5PR0102CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:206::20) To AM5PR0801MB2020.eurprd08.prod.outlook.com
 (2603:10a6:203:4b::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 540d2793-db85-4e31-33a3-08d5e80639b1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB2020;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2020;3:nXU74wr9tHNFspvPMmx/GV5SLRcFPHX5h9RZs4uZGDUgAHaMGwkjxutxyW1mtoWjZXYoG9z3Kv/+p5S+XDFMZtsab/dir/8R3qQlohhfKRmJv/AxpXf5Sx+HZOoT19eAsGXBynaHt8f5pXG+X3APwrf1aVyU3K1gnB1DbkUnmGawiNZGkcvcsRCSHLVKZ2FKgMnrDxqIuCyAaOfFiZ8OQZfX0OHf7pNpz+9jJGjkWidGg08N20MQ3L08ZuKferN2;25:MtbYbTyQoBQj6ulCGXTwQ4Ub5eA3wTXQbWHWhi+KZmJN5WzAv9kp1bC7U0MF4AWnwD+UqYphhwK9Rz7x6H+cpp7SXOad1tuWxrCaLKeFk3FZFt1zTDtXpu8wzYcIy8f6Zy4/sGu4mhm3vild2uvtPJJnv1+YZFN4jLT2sgv8swIwDkIQY51foG/E+Q8nHeYaCwzvqur4lFu/O1f1Rm1nvGXMVLZhfoIa1thKfJ/q9cyIKZgn6WjOUeoB7gtYof4T4Cxrk0mlN1FJPgLxj2D1JJqhhero7O0LJQRcHehDjq86FWhqH4fJF4w8q5wAYE/Uw0yQfk6p2tzIt6SBVL5udg==;31:U1+Nao6RUZ1SjpWYdk7uqzR1jmdB135DUokeWf+O126rq6iYy/sU9EjrN3ISUAJOljtAUTj8ftuyYmD8Ph0z2W3CXALkUHFTl1FVjNy9VLgxQPqdCaRKJc1WXDvX+QhkxGKLtlZaXeEvs8XguBSxet1Sk6KoPQl9whU3sRRUcTQ5dK0XJJv8NM+9iIuV+D5SDKJZtrsgJFMLIEbJxBX+1xVkzCAaVgAY7UEisohPAWc=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB2020:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2020;20:tWnspbnQxfzNkt3Hu+Sxvla1k6gafMAlob0UVKfPJ4KOyDbCFQ+LS3UkmuohovaFudig8ePFHsXR6wb6vvza3QAk1CDUqOzmZFgr1BKTwy2R3ljSf4oXqJNl0K8MbaFcgr0gJG8H2sdfJBHk7v51sAgXuSUlueH+yUeof275jvbdQxK0nP2o6byClSHgWT3NMdw2hrfkwX5OeMOzWsj6BZGVDhyKzy+gr0F3Ojlcg8hQgaTpMSOth83rSiBOiLq/hs7Xr8Reqy0T4FfaN+8bYOCAhcUuFvWj1ZRxu0QiHd/kxHUD2Q4Vj3tgtxpU9ZcirIlWsJOIxNEkl7hQqw5M9yGJp+cg3coFoz898CTd14PynMFa2U0xyx0IfmmaqIgG2QFDXaNNDsm4KTDAAph6WnvXmwUwVsy1Fr7C937Fz24A57WT/05yKhNOdD/g9OJeSuRCMolF4zKTvcrZuvIGqJUZ7Ky7ETnvFsLp6PJ6NMaO8MAyF9NoTMQxTH252yPc;4:LtseJV1PBmPgB7SYBoJLpImBSlsNgpbVq9jlDoLn6XlUDopXNAVjtjKbNbpGVoKBmieDzjVbRzDK1BTKxOpzebUEtTZu+b7otDhN6XbUK6MUen8nCFTcE4F6WniubgXxbGK3cdXp9foqEOcdhOx4kbUgHDw+4BE8nrKF42nW1oVNTob/8EgwFSq3OaITUeZc5HCSatcZQJUd9HO9D3l+Je64tHPnDXW7xerhp8Un023nx8Ho46P4fCNZtCJXH0ewtr/DlYhSKBe8x5e99pSoTw==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB2020A2455013A575534D9B2CCD590@AM5PR0801MB2020.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB2020;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB2020;
X-Forefront-PRVS: 0731AA2DE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(376002)(366004)(346002)(396003)(136003)(189003)(199004)(16576012)(26005)(105586002)(478600001)(97736004)(106356001)(31686004)(47776003)(36756003)(65806001)(229853002)(6486002)(65956001)(50466002)(5660300001)(386003)(6116002)(65826007)(6916009)(68736007)(25786009)(8936002)(64126003)(6666003)(476003)(2486003)(14444005)(52146003)(23676004)(230700001)(66066001)(52116002)(2906002)(76176011)(53936002)(956004)(31696002)(86362001)(446003)(3846002)(486006)(4326008)(6246003)(81156014)(77096007)(16526019)(58126008)(81166006)(186003)(2616005)(11346002)(7736002)(316002)(53546011)(8676002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB2020;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjIwMjA7MjM6bWtMRHV3dWhybjlFNVlNZ29Zd09hZHRO?=
 =?utf-8?B?R0l6dERlVW4zV0N5RzZ0VlhhSXk1R2M4SFJmOUJFY29Vc0hkT0VTbnlQK3Zj?=
 =?utf-8?B?a280SjlZa2JXSEIyd2FaTFk2VjhuZEgra0F5d3dtL2R1RDNXTjFpaVViUTBG?=
 =?utf-8?B?SXFxRHZRaHdJZy9qckwvYUVUZm00R1krdC9jSFNsUWNwZEtwVEZjdUxwRUdj?=
 =?utf-8?B?ajMrTDVYVDJNQXVBRnMrZUUyUFgzV1ZJOGRPeHBIUGhhanhIVTFPSEJVZFM1?=
 =?utf-8?B?OER5TUVwVjVTRmpQNHdDdXpuOXRoZXZxbFlSZTdBQU95OVJiQWVkUXdqQkhP?=
 =?utf-8?B?cHhINE5mWDVXY1Z5WG1rUGh1L0IySjBqRHFpSDVPNXQwTHREUEVHSVRXd20x?=
 =?utf-8?B?M21DWUp0OE9LT3RCQjZsd2Ztcm9DYVVwd1lyU1Y4emEyejA1Q1NSWkoxQUJK?=
 =?utf-8?B?QkJRNkMvTXVFdC9hSjNUT0ZLa00xZTkxUUx5aTRGZlZySTRKUy8xaEtuUWln?=
 =?utf-8?B?b3VxV3hrbEVsaUM4WjRtRTRCQWF0aUdJZjF4K244YU1xSEU4ZXhVbjA0blpm?=
 =?utf-8?B?Wmk1NUVrd08yRzdTTEF2S3p3Y2JrUHFGd2ZSSkwwVkY4TzhCalZucS92WjJW?=
 =?utf-8?B?Ny94ZWIyZURNay9CWXZNVWFVN2xWL0REQmFnSTlHbWo4ZUE4dUFCSURiVlBt?=
 =?utf-8?B?Nk1qbFg0VmkrUkNmUkpjZk5HeFdEUFJxZVo5VWVHT3BGcEVyc09nK3BoQnpB?=
 =?utf-8?B?SlhGS2Frd1MyNmNucnVnM3dNTzU2MUlvSDJJUTBTN21sbUI0RDJQZ0RPSlVy?=
 =?utf-8?B?NjJtbTdkNUcrdTM3Z1B2NFEvcGZSRVFnNGJ4MWJYd0ZJOWhXL0U5R0g1NitK?=
 =?utf-8?B?bDFlN1JRMTVGQlhmOGtxRDZuUEVaOEN0Vk5nVGpsaklYajFPUEtLVFVWeUQz?=
 =?utf-8?B?V1R0STdvRkN2LzI0dDIwczVhYUpWVlhJNll6ZC9vYzM4dVl2SWxieTVZdWlM?=
 =?utf-8?B?R1NKSmZiQ2dHUC9tUCt6T0M4S3JZSDNRNFg3c1FMZ3dIWkhxMVVlT2FsSDdw?=
 =?utf-8?B?dnpxb3dhcGNPRVVDVWtkbk9QUTN6RFVvZ2JWQzhlcWJOcnF4eTdWRDJ0SFFL?=
 =?utf-8?B?THMvVEtBYnhkRTF0bVNzQlg3QzJUNWlmQnphcldOZFpzZWdQbnJySkQ4bkU3?=
 =?utf-8?B?ZVhtVGpwZzVlTDc5Q0V4bXVkYVR0R3M3VzBpR2kzVkl4d1lMZjJTQWtEaU1u?=
 =?utf-8?B?eWZwaWpKeGpkWkY1UFdrTW1WQ3krd1pPaUorUFJTblpuKy9JclZjcXFXaDRX?=
 =?utf-8?B?VnVVZHdsVEhUcU1BUUFzcUVjTEVtaU52dmUrbzVSMFBrMHM1dXdaS0JhUDVT?=
 =?utf-8?B?NlBSU1E5Uk5SMjJEMUZ1ME5zclpmd2FqdDA3WGZOSjcwbEpVaGdjcWQ4TnNt?=
 =?utf-8?B?akhWdTA5Q3RmKzVpK3dsSzd3SWNhZFJLZGYxVVRBWTd0M0lnUXBHT3lHNXk4?=
 =?utf-8?B?VFZUTHo2UDFPRkVsVGRJNDNrUVh4TDk3eUtTZXdPZ1lwQTJ5SGZNNUQwWWwz?=
 =?utf-8?B?eU5WY1llb04yNU1STXIvU1JXMHkvVnZtcnJHQkgrNnU3eUpKTGl4OS9wb0xn?=
 =?utf-8?B?UTdVQ0tBb2k0aXg5MGdRSGxLdExRbjFLOGcyU3VEUTVLVyt5UUR2NFBhUld5?=
 =?utf-8?B?ZFNhaWRidGovSW1EQWI2MER3NTRNbzFTNWVySkd6YzNNY1MxTm1IbDN6YWhh?=
 =?utf-8?B?bTNkNEsrNUoxSk9kcWlOKzRyZldhRmdoNE8ydU9pT0lPQXpNWHRDTEhacE5q?=
 =?utf-8?B?S1RDNUt4U2grN25xeGVPZ0xIYXZrMHc3SmYzbTYwTkJZNFI4Z3NMZ3VkSE9n?=
 =?utf-8?B?VUZHNitybjdOa2F0NWk3M3F5VGJGQlVUTFZld0x0L3doR3JDNUU3VUNvcjA1?=
 =?utf-8?B?eS9ONmgxNDg4T0E9PQ==?=
X-Microsoft-Antispam-Message-Info: SHFtOF3DBcy8jmmHr0Ri8275yyQesoxGSdwypJHjPuKzk7zQt003uFAhvdthJzzQFEv4bplIpZEzeKtaG/coxv9NGA0JkfBOZoHd8dP1VnXrXagTKNE9X43SAJ6tSP64RZ6JNlO1f/93McP5G9hwpo5VZuScQFPI3aJRBhW6qPI51u9h1TUTpThIP48Tvje7AsoHTuzLOHTP8H+JPdMdVJf5pA7paplJ1m1/XEYIGI1TzH+g32niaDepcLzDpBRD7vyJlB7WbIIaVAZggEEyVM6ahO8KZ+n260am+MHqu672zi7obOlf732OZRUMUzqi9Rb7wcZhUINoQH2hnc63cJVmlMGuFlAZCMTh3paCY/g=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2020;6:y7vcD8DGK8OMQ8g4Z9LoR3R3wQzlrsaKdG3OTpp8alzHFB+gdkCMr7djGfOZVASDuNgL+3XjjibiyGYLFePn89RAk1S7kljgJhT7hpOeKZHNhp3u+kkI9dkBKZdTYSyyzBquI3YpIT3pujLHid3a5Diu8JUYr7anBYal4/xZBn8OOqm1hkKCwwbZTbTLyzEMp32K0ntyptSYZPFTwwFxe7iw6tukyw5wmzOQ+2dCmSMk9MQnUoQ+V9+rzYh/8M7b1ugqKfr7I5z5R5Y3OeUmryuWrII6EiygK9NR6TiIrZ7KfLgFqAAtf9oI7060Qbd9nLQyX9bD5z6lKqQRSiclt+hj2obysHHPCmj7eKJscSEN00I4k1jdfHpkErEPc6S69+PqKrQxzHwu2L/jPBheA3tZUpMHC81FOThL+pZdQMupJiFeeIGdeZyQ/QYIPMRIe2hSsbXMut3jWtE7ge9sGg==;5:ubyJ0qGz+F6wEi4FCs9AamZWuh2lyDUgqyzxelpGlcV15MaDTjt4RxwuYNVDAVNm+r+PB11anFlHqwiqzrGYDbfcCT0IlsYHkWW7hpg4Z5Hz/ohP0P7zN++C61AD96ej4ZYggzbLAO2tQtwuLkKZry91mSb5nlbzkL0+zb5lvBI=;24:CJBwNts6n4wOglwNoXzQQfBZfimJfY0fRGvY8+pcoSSSvNXwnU5jGskxTttP/Qy5lS0Bj908Ms3EIDgZ7PoaCwF0AzK7PV6RmN3ZclIj2fU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2020;7:jjKjudmMOQD1QsmHUn1pX7w0Wa463VWhlFqykcGTMUuT4WLa5L1chKLLA+DLXB0FebJrGw9e4B0guQ6UEKcNxn483Zpon83QQULMoESYGQE5j+Ypl2I/qj8tb4CVixbf19guCamTe9cyHDoWMnV9xoEzUJ9GcadSCDHv8vuNU9JywItwYodcwRVppSPnN1XYqMjZnfzGJ9l+L3iIlLmToPLbw8Gj8YCat0O0vNDJ9bwtkLnV/+WY9ovvKKtjQ0nB;20:JTzo7Xktyp5NuUZeznlsm7m3Q0KVkW8MSSLkKZ7wCPeGDoseFJNKSZlNFnfCVpot8JPMD1O5vqFQ0tqTYK2ETPYTdCukAvEpn3VjGoLq7jZWDWrppocvLHxavEMUAIMaHbfgeNBWt9OkxnaRYozyhSbCHeBZTCB4qBnShZq8jYQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 14:46:17.4249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 540d2793-db85-4e31-33a3-08d5e80639b1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.07.2018 15:57, Matthew Wilcox wrote:
> On Thu, Jul 12, 2018 at 11:46:25AM +0300, Kirill Tkhai wrote:
>> Bytes have to be separated commas, and this is not obvious
>> for a person, who does not write in pure ".byte" assembler.
>> Let's clarify this and make visible for people.
> 
> Can we delete the entire section and say "run ./scripts/decodecode"
> instead?

Yeah, it looks so.
