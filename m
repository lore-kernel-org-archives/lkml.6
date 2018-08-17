Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E230BC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74CFF218EB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IZhBPmVp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74CFF218EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbeHQNUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:20:36 -0400
Received: from mail-eopbgr60115.outbound.protection.outlook.com ([40.107.6.115]:27765
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725992AbeHQNUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAeOb9+hSNsSZasOQAy13759wsvbLRGceyDNk4zkxZw=;
 b=IZhBPmVpx9YP8buEEU9Grd/xbfflaRDoR9IgNJ/Dvb8l4fsoK7UrQbQiRABSIKahAkrh168+XyoXmVQU9TkRbAmE3lInaQ/gYJ951f10ZzTgzw36RLLQAvx1HBBjiXxQATmqWvE54pImmjJZEQhIgEf53YLmWp8ZijI1nf9G8ys=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=eshatokhin@virtuozzo.com; 
Received: from [192.168.0.101] (93.80.97.227) by
 HE1PR0801MB1707.eurprd08.prod.outlook.com (2603:10a6:3:87::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.25; Fri, 17 Aug 2018 10:17:37 +0000
Subject: Re: [PATCH v10 00/10] livepatch: Atomic replace feature
To:     Petr Mladek <pmladek@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Jessica Yu <jeyu@kernel.org>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180307082039.10196-1-pmladek@suse.com>
From:   Evgenii Shatokhin <eshatokhin@virtuozzo.com>
Message-ID: <d40cb118-97d7-4d2f-4b39-265341bd9dac@virtuozzo.com>
Date:   Fri, 17 Aug 2018 13:17:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180307082039.10196-1-pmladek@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [93.80.97.227]
X-ClientProxiedBy: AM6PR0402CA0007.eurprd04.prod.outlook.com
 (2603:10a6:209::20) To HE1PR0801MB1707.eurprd08.prod.outlook.com
 (2603:10a6:3:87::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 082e10de-423e-4c32-d97f-08d6042aa870
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1707;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1707;3:VuLIVTB1GGt8gj0RyzVG695qVQbRcnycNB6QdvFnCu4vzeV2LdQX2/8egFkfjA7CTG3jIMznbaQhoctOP93lfUTdpdD8JetZHzP+U0Y3cNRQHGGBCkVScfpynOgiXU1Duohw/kZogj2Vr1JVYBdYiD5Y4bQeBRYY9fAmeUXaDMB0PR8ruLPRjpFShCDNdZwCbks4/KpQBuX4NpeUpJPilpy/6tGUNaUBf6QgXEeBPhSR5M91g0m5sPuTRmrkTB+a;25:6pLKVW2gfQcprJ25sXev3igXHqu6a56s/ubOr9flUX9bnP6RHBQnv7PIlmZ9ZvMqT7bl7+V2lQP0AnbbOV/wlP5SLA5XJs5daqS58eG/1T7lYOE7pcjLHGSvibAUvmbV4Sv2cxoemFJ3rMO6zVuaNdFJCn02rCcmiKs4PcI3RUOcOP9MeOmjB6DlV/6YKFuqT4kg/kFZ+YKs4+TElwO44aV2I2HjALbL8aiYg8DxmbRlc03ub/52X3hAO2bEIaIdOW6KhGNyOqBmbXoc4cDcxmUN1rDrGTgSTxbtU1x8r3GNV72IMFXcGb8pq5UM/Fc6ia+65FKnWrWKbVZIPg8azg==;31:fbpxLGlxKo2iP+wgz5mGOKdy+w/pbMle0aP+u8UGX7e4lU7hQCKWe/Wkd8N1iHWjNIuIvKNtGh6PKSQ9PZxXqIEHvQ2q4SQpXCQ9pbBmlums1PCEtZlcQL6DEjKCtvRUs9rbAc1JvNJxdwHV27QXvoxjN6nw5hw0t5Ls8fJcUczdj5/ZTWTFm81u5mc8KrNLHBCql9eOAxurp6enZK8Pusrczzn8XO7zASVsRWbH3ew=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1707:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1707;20:n15bz8bemHdonyLvfQ/XbEkuSoaOVTINMQG/EPvk6emfjxfojRr/ynv0DiCsorBzWYDx4cXssD6WI9c84uBCSOVWnrJyL/YfSp4zSTNodqC5U32hEbHXDc2DUnETMv1MnIIwhxmQ3KVuHeEAiQWasuNsPIl5kFqSPz/LyXlxBq0D1dyIS1cm8NEF5by4kxpjNRfkydn4OGbq2BbtBbHt919xNlZXdkd7sCVZpCxGhleIObcTa+iZRwktjjPzJvNWDVJPACwkJmbeFnroTGCtBxeM2vV62So+KY+Co14Klx2Xr7GNPDlR9VIXtYoMuVcNkZ6mA8sBxNQJ9stuzDsFKvkON7qWy2jP6tfxes57lC7+x59Xhzg7w5umHTrcsz49EkGHZVpOk4Jwok/1AymFidBmT04mW/gh8ItgtiSTpmBn2GBiVfFdckeKXD2vOPNxx59f7Ay+NZ2OKRiVWYZF6iVqAUKZGGZlgI84FcoHffPQBYRC8lpVupWF35xMIjmx;4:DfS8U1bCbEZO4sS+OWFrwPWDBNddLN2zD0JCuQrhvy4wMHEidFCp5J2BZW4ijcNaLKJRXR0HVIKtbnWqhNWKFyXtSnb/+Vf3xuGp5dGe7OJVNdMZEguNrPYZFe/1oOh7dzqIaOG28IFFr0v1aX76AapetVfuulqhTr6X7XuFfGtoiZtnwdxJdfRmCTJ4j3EmuuaveHGP0cfs3LUtWbYlV9ZpbOHXZTv3b5dnvahzpzOOUUDSND8a9dcyMOTho2fzLMqkqOYidk+klIW25BiuemjEFuaDSpTeD/eZJOmBhcPDhZxsDJ8TF8JHK/bmwKII
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1707E06494BC170DEAF4EB25D93D0@HE1PR0801MB1707.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699016);SRVR:HE1PR0801MB1707;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1707;
X-Forefront-PRVS: 076777155F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(136003)(346002)(366004)(39850400004)(376002)(396003)(45074003)(199004)(189003)(956004)(5660300001)(476003)(23676004)(86362001)(52146003)(68736007)(2486003)(186003)(486006)(52116002)(31696002)(50466002)(2616005)(36756003)(67846002)(110136005)(54906003)(81166006)(58126008)(81156014)(16526019)(8676002)(31686004)(105586002)(64126003)(106356001)(316002)(16576012)(478600001)(6116002)(3846002)(25786009)(117156002)(8936002)(53546011)(7736002)(305945005)(229853002)(53936002)(77096007)(4326008)(6486002)(26005)(97736004)(6666003)(6246003)(2906002)(230700001)(65956001)(66066001)(47776003)(76176011)(386003)(446003)(65806001)(11346002)(14444005)(65826007);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1707;H:[192.168.0.101];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjE3MDc7MjM6UXYrbUhGaEZwZm83b3U3OFZxcHpDSnZN?=
 =?utf-8?B?M25SY3pSeFIydXh4SkxKaTNUSnBOR1VKKzBoVkw2VmFLMjN4ZkY2SlROQlZw?=
 =?utf-8?B?K1grUmpnMjAxdFB0WDdZS1gybWVzeTNGSXFwb3lDVlNXSWFDR2dOMnp4anRO?=
 =?utf-8?B?NFNhYkdKR08yZ2lEVVVVWXlQVkdxNlJ4cVJyRXhXMzZmbjhVWklBc21VWXpX?=
 =?utf-8?B?cGJETC93bWoxRDM0WmNrbHJudjJvek9qRU13NTNOb1dKZ1hDNGMyQTI3QXo3?=
 =?utf-8?B?MTF2bVEyYk5zQUMyRWRKS1hBU0YyZHVueXhKM25HU1VRU2UwV296OFMxMWpP?=
 =?utf-8?B?Q0t1ZVljczBRUTkwbHpvbjQyOUZEclhwdjJwRmsvaTBWeGhNSWFNOEgwb2dE?=
 =?utf-8?B?MVlBLzRMMER4Y3ZIeXVCYTlXWkRWWS8rNXhiV2E3b0Z6SC9aYm5EeE1ydGh3?=
 =?utf-8?B?Vm9MbzI4SC9iOElRSmZKelBUckZYRkdScFRnR010WGdZcXQ0L3VXT1ZUSWZx?=
 =?utf-8?B?RzN2QzRQblFCUC9CWVRTcHEyWFdhRkovWGN2a1FuR0l2NG5oZUVnUmVYNlIx?=
 =?utf-8?B?d2V4a3RjcTdxSkdUMEJIMVZWVDB3LzNaaXpjRXZKbHBHRWsyZmhnVDlKbzZh?=
 =?utf-8?B?VUlyTXZieTNBZ0IvZW5nVWZBeVhTOHdCeHhzVE9FUW5tOHM0M0tCRVNDbkZN?=
 =?utf-8?B?ZzlOZFdMMEd3aWtsNU5Kb2NjdlNqL0dwMFFCeHBTd2ZKRVhnUHFpREpKbFpR?=
 =?utf-8?B?MG1VZmRNRGloMTdsenZ6NkZsS0FodGo3VXV4Q2dyS1RTalB3enczK3hhamkr?=
 =?utf-8?B?MnpmK1c0NlRodVEwZi9mblBFVWxxelVHZjQ3U0RyZmRpMXAxbFhDTnlYTDUw?=
 =?utf-8?B?NHpmc2p3TVdDdzJBTGxYY2IzTUdJSlBROHA5NjdkNEYwNDVRbTV4VjJodFEv?=
 =?utf-8?B?M3NubXlGVS9tZjZ4MmhYbklXOVRZUm8rTit4anZ4TGR2a1FSZ2FWNmFJM0hB?=
 =?utf-8?B?TGx5VTBNbm5odk1neFo0QXQwL3M5blFjM2cxWDNoL29SNDJkcVBhZjZXWVFa?=
 =?utf-8?B?blJ0Wkp4SkhEUzBXbGJSdkdyRFdtV1RKQUk5U2hPQ3RIVDRXQnovS1pvTjVD?=
 =?utf-8?B?cWpSWTZrUWpCMTcwejA5RUIrak5qT1RqVXNJYi9TUmUraFJ1Ymc1V096dWRX?=
 =?utf-8?B?T25OczRNUDM1OW0zb051Rm8rRm5ZeEFkNWx3Q1NJYzlmSHljaGt6YjZ4VTgw?=
 =?utf-8?B?cDREZ2x5Qk1uQUtGTWtqNCttVHBHVU9ZTmpqcmxpOG43c1lQdkNRb0NiVk5a?=
 =?utf-8?B?aURBaVpFUXo5ek1MZjN0akNUTU1tRWxqTDJ5cGRXSFdGVStjOVBKVlB1clVM?=
 =?utf-8?B?NU0xTkVJZCthdy9YK09wYWxnU2draEs3MUpIMnExWmpSQmsvUjF1WmJJeXdE?=
 =?utf-8?B?SURoV3F3WXkzY3J0cjJmeVBCSVNZKytoT2ZJYms5YjkyQ2Q1eGFpbEI3TnhM?=
 =?utf-8?B?SUx3dnM0cmI0VE01UENiNmVHZE1FTVlxaGVBWFRTMG5nZ0NWdFBNeC9NZXlx?=
 =?utf-8?B?b2NEQVY4VGZ4WnR6QmI4d3VvajlJZWhCUi80OXhhV0R1ajNhTWNIUjZFeXhv?=
 =?utf-8?B?US9tWHFBU1RaZHF5Zk5ad0dJMUYwYVkvRlRrQjRQK2M1c2FENGs5K29MaUZo?=
 =?utf-8?B?c3ppNXNMK1g2WE5yMUJkV1prRGNHQ2FHMG96cjA1MUhlcnlOQW1LUTdWVGxX?=
 =?utf-8?B?Q0g4dFdTb2ZFTTF1a1dzZVZsd3Vta204Zi9vTldFTlRmc0JNYUlDTTF0Y0dD?=
 =?utf-8?B?cFpXSDZTT2lGMEF4WnJ4enBCSHZ3b29KeE1aT3ZIdXN4R29nT0VxYm9xclh1?=
 =?utf-8?B?K0h2Ukx6WjdWemExL0llaW9IdWJCMkI2d3VXcXhsUEt5c3JNbXNEMzB6Nnd0?=
 =?utf-8?B?U2M3empCYnJGSFRpSk03VUN3bTVLY0crcDdlaGxjY0JINkw0YUk2THpyc0po?=
 =?utf-8?B?V2xiTG1jay92N1ZSb3lzdXJidjVadFBpWWxMMHdNcVpJRG9ManhLcE9Hc1FO?=
 =?utf-8?Q?DWkPzU=3D?=
X-Microsoft-Antispam-Message-Info: 9Z2Hy+joR6hj/mL7T14FaynWFlsHuGPrm+nZ/TtVJFpRherO+S6RBH1c3MWNvfnqnt8vMP3/LLivS+fPIKEomFq1VyB58KMA3v88f5lVrO0VEoVWjDlFC1VimXmiJXxxOdG7knRIDMwJKWZSMw61LnVwmtTL/CjvGpzGGdTbX+N/cpbmbgPUQ4CBkwtldeuz1bQ/yfv9QEe1HG7UkXC9Hhvp7vSMMS9PP0VZFwcI7cQWt7Wjr3X3sSku3R5RXucgzI1HLHgFvRSn1Gwc0JEWnBq6nwOCVY/D6bn88fLpGnY8wiLW0Qgif3jt/YRqon5MylLCero6yfr24ocKTeYQGzAAecTvfJOQ/AWzcOnGen0=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1707;6:BRHddZ/K7nwJ+nM+HKTLTdSozhkEjbh/xaE9akrrXCxpm8WR1pzljN5utbvUvGKc1RT5O3RAZtnQ8wJF2UqRzrDkeMkluBmOeyY2ozoe67yjyBhyu2JaAOOrD23jh1kotkBmP7TjxAKFa06zsntA3iL/qo64uM/D+4rp9IJ+m8eIkYceXIeRHCy1/X3oLre1uHGtu2T8XcAFcenpvVOehUnQWz0ZE1R09nMKvvz5QAqoTwqoTV4DquvoSmW/zSzFTw74hKenfTYMhLL6HxBtsb7jMb9QArsV97Ee6tmxN6pPztb2u5Zl44Bw8HOeOkzETin+czzSoMk30RvUrULyoVt8A2FlKEF/t7/nSXRSQ/XuYJQ/NR0gOdUm/OgVGnzUWlk2rkn1QUvQRuyymmiZL+gaIAN+hL3jl7LsW23d9lxPuCt5usw1NwYyCuiqFLJtdtwZ6aNTM1wDvQw3X1CekQ==;5:R7ZXDHDk40eayrToYU+2Q58+7bFy84F4uQxf0+VA1kCY/2BdmZjDGzMTZPu9XYViwPvgAPpARTHjhkOu7wFSsx8ATGKS7wU4jq54oFjX2qP8B1BApoQSnK1bwMYhZdkVAbtVC6do8rTfDOB+eMPoMYJYzfdKfMPK8INSexm49ww=;7:2zvxhC7n+WpOAeungSWrSc2qcWULw84+GNWK5ZP3lTeRVxajT4UA1J5k73iDNPheq1mTkOKKP5lcTr0tib6aGVmGQ7PdaJ2/0TIwlVYooTUqtzcl9lkSNSf1Ncg4exklaFE/Ct8SlLoDS0gcQtX40lyfrM6PX5yHUdLj+PwrLdHnz5/RBm35IkC0Xuvxt84/QsZTjCdwtJbFrgjHZ2DrLjs6Ju12tAJnmN2zJ/kVqg2sz2tyFZrg9OOqEeWEq90B
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1707;20:uV2YFm41EIcxrpC0u2W2YWUnEIOb3xCNoxXyEPBK3gl/HBSosx4A/mkH61XfAD38njqbkXYF5X99ud4AyKYCiMXu7M2Gbiq2VcJGwmAm6tZ/3ZxP9l6+IDY7bQunWDoASw1Yy0MCTCSeestfoeydX3/l0PTVJzqFjZjl3Bg7/xA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2018 10:17:37.2402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 082e10de-423e-4c32-d97f-08d6042aa870
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1707
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07.03.2018 11:20, Petr Mladek wrote:
> The atomic replace allows to create cumulative patches. They
> are useful when you maintain many livepatches and want to remove
> one that is lower on the stack. In addition it is very useful when
> more patches touch the same function and there are dependencies
> between them.

Could you tell me what is the current status of this series? Looks like 
I lost track of it.

Is there anything else that should be done here before this series could 
be merged?

> 
> 
> Changes against v9:
> 
>    + Fixed check of valid NOPs for already loaded objects,
>      regression introduced in v9 [Joe, Mirek]
>    + Allow to replace even disabled patches [Evgenii]
> 
> Changes against v8:
> 
>    + Fixed handling of statically defined struct klp_object
>      with empty array of functions [Joe, Mirek]
>    + Removed redundant func->new_func assignment for NOPs [Mirek]
>    + Improved some wording [Mirek]
> 
> Changes against v7:
> 
>    + Fixed handling of NOPs for not-yet-loaded modules
>    + Made klp_replaced_patches list static [Mirek]
>    + Made klp_free_object() public later [Mirek]
>    + Fixed several reported typos [Mirek, Joe]
>    + Updated documentation according to the feedback [Joe]
>    + Added some Acks [Mirek]
> 
> Changes against v6:
> 
>    + used list_move when disabling replaced patches [Jason]
>    + renamed KLP_FUNC_ORIGINAL -> KLP_FUNC_STATIC [Mirek]
>    + used klp_is_func_type() in klp_unpatch_object() [Mirek]
>    + moved static definition of klp_get_or_add_object() [Mirek]
>    + updated comment about synchronization in forced mode [Mirek]
>    + added user documentation
>    + fixed several typos
> 
> 
> Jason Baron (5):
>    livepatch: Use lists to manage patches, objects and functions
>    livepatch: Initial support for dynamic structures
>    livepatch: Allow to unpatch only functions of the given type
>    livepatch: Support separate list for replaced patches.
>    livepatch: Add atomic replace
> 
> Petr Mladek (5):
>    livepatch: Free only structures with initialized kobject
>    livepatch: Correctly handle atomic replace for not yet loaded modules
>    livepatch: Improve dynamic struct klp_object detection and
>      manipulation
>    livepatch: Allow to replace even disabled patches
>    livepatch: Atomic replace and cumulative patches documentation
> 
>   Documentation/livepatch/cumulative-patches.txt |  83 +++++
>   include/linux/livepatch.h                      |  65 +++-
>   kernel/livepatch/core.c                        | 422 ++++++++++++++++++++++---
>   kernel/livepatch/core.h                        |   4 +
>   kernel/livepatch/patch.c                       |  31 +-
>   kernel/livepatch/patch.h                       |   4 +-
>   kernel/livepatch/transition.c                  |  41 ++-
>   7 files changed, 598 insertions(+), 52 deletions(-)
>   create mode 100644 Documentation/livepatch/cumulative-patches.txt
> 

Regards,
Evgenii
