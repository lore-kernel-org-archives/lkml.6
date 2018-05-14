Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932942AbeENRBm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 13:01:42 -0400
Received: from mail-eopbgr00109.outbound.protection.outlook.com ([40.107.0.109]:58368
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754066AbeENRBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 13:01:33 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 00/21] i2c: make use of i2c_8bit_addr_from_msg
To: Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc: Brendan Higgins <brendanhiggins@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
References: <20180514145330.4857-1-peda@axentia.se>
 <c83bb5ddf36b419c4c01e20384c7b532c9a48cd4.camel@perches.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <29558f7d-1b80-8c6b-cd26-58cab6bc3ee1@axentia.se>
Date: Mon, 14 May 2018 19:01:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <c83bb5ddf36b419c4c01e20384c7b532c9a48cd4.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0130.eurprd05.prod.outlook.com
 (2603:10a6:7:28::17) To HE1PR0202MB2778.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;3:w5hx6iE/hIaCf9C2XR/Q9ToaCYXTZSg9i+xtlAnCWECtJ8hvxXUHw9upBGQTaohdSffzP0BL//rP3oV/DhRJ2QcZ8BMh8hODR8CLfzrzh3ouSGh6m9KXKVWh5m91kWTm22umKmwnaOLb6kQOy9hSrH8Om3LndB4zaXpusDX9477DI6e74zRl1bTWtQd4Niosd8F7rWRmYzz3OYkjGZbNv9KivZ2k2bLAA6EXM+L1rdKDY8xJ73/vHdjELBfZBkJU;25:g7ml1yeaR/Rbkhc9AjZetD+RrQEZyIVpGQHJEcCV2o4KPtAqrTGLYEDHMvSseSNJZsfn1HxH241d7EyfbyjumqWn280WE/EZgyECZt3tAauWkfYE98jqL/YjiQ0FtKa0S/yB8o3eMAoBTBgCCaJ87Ti+znBrlzdCG5tRv9lvXdosk0xyDRAorzO9xmr6idEeU+IFVIEw2XbOxnPB1xP1oaNMLUY0TFgSkHAhzPg8JN0aEnh7UQM6+KUyqJnSumgqX7yqg0CYRxH+HK0ou09IV0LsudxWqFkyXAjI48nF+EMr+Lx/tfPYmH07z0K6LJnvoGRBJ12ynXRFccguKKRfHA==;31:4MK/ZMENaDv8PpLT8DYvYu5RyNS2TlV1JoensO88lrcJnM1VH+G92cMMtbSJ5hxVvzLnbVE0pLDhX1jVj6GDFXCgdhzl9SlFIMfo6N179mvSp1p5gc7JcxYzJjafrEab2uA8EsSRI92Qlnf4JdlXWXQwa6SHYETstZdfFBKDe8aJwkQJeyjj6cqvtAc4XDI8yI75lHrQTh6xek/BSCe9W9L6LQ1E81Qx3TCH5I9IKrg=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2778:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB27782BC87B6E66F2E1E74D3ABC9C0@HE1PR0202MB2778.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:HE1PR0202MB2778;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;4:Lq0+7w/6rph/xElLmJ1BYu8wa/0ihrmlhdM1FufM+dzrwSxi+JvE7ZpvK1eOb7O/0QiwLdIDNh191HORSMzS6wMb7077/5fYZENeby97mpWDUFlUrVq6AYmYiIhBxNV8olKsm7hh74VVR+MyxrEcKoT2gNrSMgFOryJECP2j6ZQSDTAwqiWMIndWwHGbRxspos/x15HyKxvFQ7PGHFLmKwlE9+mfHllDwsw0s4jzQcBzs/yoeZaVxcB0L84Gtnm4nj1nfvggm4y2oSUzaAETFQ==
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(39840400004)(376002)(366004)(396003)(39380400002)(199004)(377424004)(189003)(36756003)(66066001)(3260700006)(47776003)(186003)(59450400001)(65806001)(11346002)(446003)(65956001)(7736002)(2486003)(6486002)(50466002)(229853002)(6246003)(52116002)(52146003)(36916002)(2906002)(15760500003)(53936002)(23676004)(16526019)(105586002)(25786009)(65826007)(8936002)(305945005)(6666003)(117156002)(64126003)(53546011)(230700001)(86362001)(386003)(106356001)(97736004)(478600001)(316002)(16576012)(7416002)(8676002)(486006)(476003)(2616005)(76176011)(3846002)(26005)(31696002)(77096007)(74482002)(68736007)(31686004)(956004)(58126008)(81166006)(81156014)(54906003)(4326008)(5660300001)(6116002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2778;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDJNQjI3Nzg7MjM6eHdMV1pXRDhMU1d5NWduRGJ2MGJoYUla?=
 =?utf-8?B?UWh4dW5USUZkSmxXSy9vdDRjaFlIdW15dWRaeGh4aFdkcmJtZTA4NjI3TVlv?=
 =?utf-8?B?RURBemEwVEdtcXhRRjdtWEFLWVJ0cUlLY2kzTW9CQXoxYXpJdFdTSG03OFRW?=
 =?utf-8?B?Q3dzZ0FEeVFhVTNCd1RBMGQvSkJkTkt5M3ZZQS9ZeWlPYjZNcTRPczlmbDdu?=
 =?utf-8?B?YkUyTVRrWVU4ZS94aGxMckVXSEp4V09BazdHMWMyYjIwQ2RWcXVuVTc0L1I1?=
 =?utf-8?B?ajg5Q2dFaG1jOUppVTlwRVMzQkxqWVpqMjgxQ2F5OXpCN2Z6MUpldkRkRHNu?=
 =?utf-8?B?eGxsUVV0NzVrbW9vdHZhYnMzVFBHa0dlMzdsRjFkYm5rWTBmZmdoWlMyTmtH?=
 =?utf-8?B?WU80Q3lEMm10czJWNGlRcUwwbW1keVQ2WlZ5S25ON0V0ZDZPWUlvYzhJa3di?=
 =?utf-8?B?UnJEM3Z0d1BQN3VYbkFXbmtDZk1tMlJ3NmV1WXZmckJOSGF5aWNyR0xoTjBk?=
 =?utf-8?B?TGpnOXpwa0lhOFh3OUcrbTJvODg3Q2dpdkpJTjRiWW1TanZyUWF1RzI2OWJ2?=
 =?utf-8?B?RUEvVlFIeHJsT2ltSUdRWkpEWGRrQUl4akFJMldtRFFQT1JvdVZUM2tLaFll?=
 =?utf-8?B?L3BFVDZWdi9jZnBBMGl3bG9pRk54aTJ0Z0dLcGxXK3orWWZzNS9Ra2xKaCth?=
 =?utf-8?B?T1pwMHRuNWZaUVZGOXhmYkFONjdsSW8xanJHeEVZWUVIWUpSdUNLSWJDZzlF?=
 =?utf-8?B?WTFFb3o2ODRNZk5BT1k0NlJtempKUHlSOWFDWXFTbWhvek9JRnRLRDByM1Ju?=
 =?utf-8?B?bkI0d1hYd1FTckMyTHRBRFplOVhmK3BpYmk5N3E5Sy9hNFZ2RFNROU1pSCtR?=
 =?utf-8?B?T24vQ3lWWEFGM0N3Z2o3TFNwV1RqaWszaE0vV2pMZDlaZ0VHZnk2YUxIKzR0?=
 =?utf-8?B?RzdQQk9qWHA1VVlzdVI0U0M3WU9IdHVzbGZDQmlSZDBIOUlMWXRVeldqNTBO?=
 =?utf-8?B?T01YZHc0VUpkRDhBQ1paL1dDNXc1N21aK1NFa2hOVXhGVGVWaW0xY3haenFw?=
 =?utf-8?B?Z1FtV2U4WXVmK2d1R3ZEMi95STFUL1FRc0hwODZoNS9yL3ljVGFZR1JQQUtq?=
 =?utf-8?B?MDRWNnV6MnJTbHM5T3BjVjJjWndrSXRRYjBnbFlic3VTemcvYlI4Z25icUhi?=
 =?utf-8?B?YjNqMTgybXZNWTBoaVkvNXNWNWE5dXR4cnZpWGl3TmVGL2NzeFdMaG4rY3Uz?=
 =?utf-8?B?eUhFaVlMd05iQ1lXdi9zV0JOS3hZMEJKaHNTMnBqYUdhdDVsejlXNmYxSDk1?=
 =?utf-8?B?K05sTkV6K1J5V0FzTDY4REdSV1lDd09WZ1FWUkR3dTJkcVVIdVkrZjJNSmFT?=
 =?utf-8?B?RHcyV1NBWVVKT3JGM2ZxakZxN2ppeC92RVp0VllXNXd0VE9VbytOV2QrS2Zv?=
 =?utf-8?B?YVBEM1hhUFR0MXZBZW5Ram8yMkZhTzdFQ0hROG9TaGp3ZXJsU0FKWkJjbnJk?=
 =?utf-8?B?TUtpMS9DZlNmQnhRSW16WXhPNjRIcno1NU1OenhNVUZmeHQ3TkowMWtCOVYw?=
 =?utf-8?B?UmFYa0lwS3JaV0Q3Sk1Dc2QyRVVMTFNTTlpUTVBFRmZWdkNrL1B1Y3dOK2Uz?=
 =?utf-8?B?NC83bVJrRjJNN1cyUXAyVXN0b1JJL09MKzByb2h4UGhqbTcvZVR1ZGdXR3Vz?=
 =?utf-8?B?bTVPcithV0xmdm5YaGhKd2ZTcnZONVYrU1pQako5WElVQVhmQ3pWOXNCVmRh?=
 =?utf-8?B?aXFSeGljOExUaTZCdW5Ob2FvSHVRQjZia1cvWlAwQno4bm94OFJadE16RXI4?=
 =?utf-8?B?ME80ZUVhV3dJV1NsLzAyT2t2MkIyRXdibVdwTWhMMU5aOG9UZVpQWVpTYm5m?=
 =?utf-8?B?dGVrOUdkcDlEVkVMeGtudE14RWRPMVZZV29tTmEra1dhOWhOTzF4cHpIZlpu?=
 =?utf-8?B?NnIzdndwWTg0ZUpjajFWbXdoU1NNSGpGbHVwZ2xGOFlpWFBXamUycllrd2NR?=
 =?utf-8?B?K2tjbFg0YU1URFJxLzVMWTlkRW5uaXY5a3pBczNzQkJPc2xZUnY4NERlbEVS?=
 =?utf-8?B?YmlPWjR1SmtrUzhocnAxV3hNc2NvaEhrTzk5YWcwMFIzR3JWV3F2YWlWVE5q?=
 =?utf-8?B?MmduNGpWcnVrUk9pdnlIbEtCQm5PMnp0U3NaekltTkg1SjBqOFRjejkrKzMw?=
 =?utf-8?B?aXpvSGZPQmhCUjVmY3N5N0lhVTdJU3c9PQ==?=
X-Microsoft-Antispam-Message-Info: z8anwvofMWCMQZOR8ajqfMiG7TYQHsGsXj+5pzq89W0urYEEgNIbuu4Om2GJX7YO6svLw6kMjWyZy1Wy0AUYFZuJnVEApdFvtmHk3bj8HV9/uB9SsAZVHPAK/45w+QbWpXit19c13SrGv4CB/o9qtN2DEbX+hPegMqAkjK/ybTIpuKBdoYSzfXYM+Ar2IMle
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;6:KlMQcFg36/jL9sNzubGZXMy3I6/B4gnD69e3GdPV9jxjpypUXhydoyoIL63EHxLtWrhx3txp/kROTzkHItMYzVz1DhBDAELkGP7eqDOIF0edQ7PKJx1UugnWzUIv49P8jZyjGWd/XTsL594R3BMmDom2JBWG8D9BoT76hmqOkkqypPg8WiPsj06HJeid/VHBQF/IOR6ghbhnGI68wZGchDvDQippMY2X3oDfHLGLYl8jnMiKvFMQdsiwmn7pOno57kKHFJdZKU+6DR8vxkT6lro5mmdiiWzp/NFnX2W1ns3moArd4GO4DcCzLMU/2qCxvdikEiAaCrZgTxFTE62qBudy2QkFUXiJ+Wt2L9UOz+gwqhWWqWJs7VW1MhAwIaH+SUjye4ZZ25O/w3dUBdPdG762ZD+S3u4WVhXiVxmjjQoB37SzuDC0fiyCr09cJDfVyOrx88B9krVszB44zggovQ==;5:IFpySiAbxHkm4fHAnR7AJPIJVFGFJDtb2ophQQO8t2Qa+CBXFaNCDjmRZTtIF2Be/cPpDfjOUXfOu/gL0UwrbE/WzeenF+kZvJ+AiCAJ5e71+8Yr8YTgERzqO5Rw821qSlIxOI09JQMNx+kZIipfw/QsBlM3RwLkb2CU5tPkElg=;24:Elqn2Wq3b/ooW/OwThQeHqLA5EbO7ZEy86Q1tRU4x1b7vq3mGlYn4Tlc403QuExOKNmJn2k6U12eFL+fieKgp7hJF22G/P8CRySDYkHjBSU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;7:cuNruGYe2d5Tvkk6aSTx5ZYW8IJuWkDgn2LxQ92kGpbfy1qGI+sgP3DfiyHs7t59tmVNm6EuDDbE+XYTJ2Z9QnbePGMkB1h74X86ahnbuJaA2h8zJ81oiI1ps+ufJs0MUtodI462qId9BFqT1RuJgTCrXjRzZ657aRC3RO/STdDxGH8n+2qQ+OZR4enEflhpmn97rEQ/NYMfhvkG+e5KlwHwsj/RnekaP43IEyGWQEXl0NUU7FodZuVgl920x2NJ
X-MS-Office365-Filtering-Correlation-Id: 25c54696-89b5-4cdf-5829-08d5b9bc555c
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 17:01:27.3961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c54696-89b5-4cdf-5829-08d5b9bc555c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2778
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-14 18:11, Joe Perches wrote:
> On Mon, 2018-05-14 at 16:53 +0200, Peter Rosin wrote:
>> Hi!
>>
>> The nice little inline i2c_8bit_addr_from_msg is not getting
>> enough use. This series improves the situation and drops a
>> bunch of lines in the process.
> 
> Perhaps the inline should test for I2C_M_REV_DIR_ADDR
> as there is at least one use like
> 
> -               addr = msg->addr << 1;
> -               if (flags & I2C_M_RD)
> -                       addr |= 1;
> +               addr = i2c_8bit_addr_from_msg(msg);
>                 if (flags & I2C_M_REV_DIR_ADDR)
>                         addr ^= 1;
> 
> which look odd

I say no, because the driver has to also indicate support with
I2C_FUNC_PROTOCOL_MANGLING and I don't see a sane way to check
that part of the contract. But what do I know. Seems orthogonal.

> Do any of these changes now no longer need
> the temporary flags variable?

Right, I thought I had made any obvious further simplification made
possible by these changes, but I overlooked that one. The flags
variable is certainly over-engineered in i2c-algo-pcf.c and would
be a good candidate for removal. But that's only patch 3/21.

I'll wait for a bit with an update, and Wolfram can adjust this on
the way in if he feels like it.

Cheers,
Peter
