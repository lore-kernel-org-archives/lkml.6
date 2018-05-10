Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966237AbeEJPZ4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:25:56 -0400
Received: from mail-by2nam03on0071.outbound.protection.outlook.com ([104.47.42.71]:2462
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964827AbeEJPZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:25:53 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Igor.Russkikh@aquantia.com;
Subject: Re: [PATCH] net: aquantia: Fix an error handling path in
 'aq_pci_probe()'
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        davem@davemloft.net, pavel.belous@aquantia.com, weiyongjun1@huawei.com,
        dan.carpenter@oracle.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20180508063947.11317-1-christophe.jaillet@wanadoo.fr>
 <a784ae7f-cd9c-4141-f862-0c01f61d0200@aquantia.com>
 <2369a016-547d-65e1-9ba7-9a6d16cda41a@wanadoo.fr>
From: Igor Russkikh <igor.russkikh@aquantia.com>
Message-ID: <f3df0dab-ea28-f30d-f0d4-7e2b4aee9276@aquantia.com>
Date: Thu, 10 May 2018 18:25:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2369a016-547d-65e1-9ba7-9a6d16cda41a@wanadoo.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [95.79.108.179]
X-ClientProxiedBy: AM0PR06CA0039.eurprd06.prod.outlook.com
 (2603:10a6:208:aa::16) To BLUPR0701MB1652.namprd07.prod.outlook.com
 (2a01:111:e400:58c6::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(2017052603328)(7153060)(7193020);SRVR:BLUPR0701MB1652;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1652;3:R6De2MTT9vS2k6z7Pisef12G/kUWrNE1HMQTHYdfVohQw6oUReJfcFQ7uaa69a0rmhxkwKkbLPXHbChsg24uYJ6IU14T7v/suYALVw2mkoAw8/F5mU8FwdrV+i69CUTPT8mGNzERGfErv1cxMWYhK1abDOY4G9Ui8cHTv/odpKUaIVK8P5/zwKJCYN6GqfYjnslFhNplp61S2czPDWp3NSVXecXGIcpKrAzSqKRRk4Y112g3utUObyDrkeyBpc/h;25:yvgiRLvFm22kIMEqNO09P5qwfHfk2daptOgviE8GM2fuE/42ZDuI5uuscPU2wmVu6V4E8iYIOnwzbnmkuWNry43ft0bttFctdYunYMONjevovzEYRY8HpZRGFV0xxZk0Zwqp9zR+PVMiVmFdMT5kpQfdK2BsLYS0IDq3QzeIPbLnt4izGQYYoHzfP8y0p6GBp9BpH9eTm9naD3gatIxM1bY0AzEy2kTfsQRgx4FCCUVYz1KSUhKkJhutVx8vbxvVf+Dat4GvjduXiXSwgp7MJZsfTgQqoVzliVn3lrqsOPvjDpDlzYMiAm9RAXjIBzjcizgswoHrI6bZEYzOaJBYXA==;31:lOnkqXQsSdu0qf/XxiH+Afa1UyxjmNXZdWghl+LtN4WlE9dUPR9y8/IiupRfioBGjMIKCIu99BTaOPnUEL1TQRy0W684WRNK7aNY0+981PNgdNS/lXAu5hqHEJVM4Fc6ZrUq2inUz1lIa0Js8qZVdPa5meCeOIgztTaULxCIOiViQPmg9vDF6u5IyHoptmJCg8Kvmrzgv/+Mu324JS+zWhJqQd51bHQkgG5ImTL6fNg=
X-MS-TrafficTypeDiagnostic: BLUPR0701MB1652:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1652;20:N7k2zuWLW8A/quKCzAgRhajoNBKS701j6Zrcz8IxyWk5Osp+sjWTN4Fr6GCq1yuPBtwMLvPR5TkoE0+u8MGenetgH5VMRvzs3li52iPJPCslZjVz0XWrq4zcOipDr0p+dVhqvfMQP7SN6QiFEDsslku9Uj6NRxaGXR63EGZmFMNKlMHZBZv942lulwCnzT7YQAmthCaajxsuSz+pl8DOZrJ++rSn4ZX2wZajTWXFpnRiKDUd6zIiaZVD9TyFrmB5cbTzWBRwi62CLYxvxGyaV/NAIS4jHDQojSOV7/qQztLiEMr8Vf2xCwQwKGxnZNQIWU1bQQhAm4W5kpRtCFYJbBFI2YiNt0XOv0ITm7jA94QIFLN0tLMdV5MxcQBZD3FsCPwhs8mvK8Al4V3cZbxOGaI7qY1CxwHy/vX4fx3zZrLd/iMJn5ZkUTp72hlOsMy8bPD5zwa/Oqb6y9+yXvsmTqeUwsYP0ChtLE3RpQPpdmJvZbkXqRhvqYDLtLviLijY;4:ljcrkeGSBHzv7Ot0MnEnHZBurXP/QJZbQnQ8yWJe4qOjeA5SM9tW3yGgRdGqCPl0eudU0ygFiELuIjRKxKagD2ZRcuFRpjuUDzSjhmL/rSS4mCbT9RtM0pfxFv/cBej8amG4P2FmarCGbsP3BLsokkDSxanvWn9ZAVRLAVgDUHXzu6+5oHMIDEd1mdvt8PT6u3xiwCg4KquCxXCpVkQrAAJsI2CWbS4PNd0V0UIsur8iGbX6rpiZlX2VVZKNNyLaSRIhu7wzZASeaa3qXMjtKw==
X-Microsoft-Antispam-PRVS: <BLUPR0701MB165279E7DFA4BD8DDB4B0CC598980@BLUPR0701MB1652.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:BLUPR0701MB1652;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1652;
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39850400004)(39380400002)(376002)(346002)(366004)(396003)(199004)(189003)(956004)(31686004)(58126008)(68736007)(6246003)(486006)(446003)(105586002)(47776003)(8936002)(386003)(44832011)(26005)(81166006)(230700001)(36756003)(6666003)(59450400001)(5660300001)(65826007)(77096007)(476003)(6116002)(53936002)(106356001)(11346002)(2616005)(4326008)(76176011)(23676004)(2486003)(16576012)(52116002)(25786009)(8676002)(52146003)(6486002)(305945005)(316002)(7736002)(478600001)(86362001)(65956001)(81156014)(31696002)(97736004)(229853002)(16526019)(65806001)(72206003)(50466002)(3846002)(186003)(2906002)(66066001)(64126003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0701MB1652;H:[10.0.3.15];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjA3MDFNQjE2NTI7MjM6WHh0Z3p1cDU5cENaWng3dE5HNjFITWVv?=
 =?utf-8?B?NGUzT2J0TjFta0MzcmI4V3pCTy93ektmYlg5QWdWTVN1ME5IbVZ6bjdOaVZ1?=
 =?utf-8?B?NFNWZ20rN3BWQkRUZFY5SlgwQ2FkTmR5V2lQbjlMTGZWbkNiTlY0MTA1RU1q?=
 =?utf-8?B?V1gyUTgzQU5FVGV1U05jVDAzSGRSTnZtYVpyZ3lXVFNwOVNDdFBJNmUxSEc0?=
 =?utf-8?B?enZyZlorb2hWOEZJL2RQdGZqeWZESnlqT0FDVXd4alFCNFpiQVpNS3dkRTFs?=
 =?utf-8?B?UEJ1MVBjVGZSaHhuYmd4RjNCMnJDTTRDUDZYWkZ2ZEJnU3dUN2ZxRmJBeXZB?=
 =?utf-8?B?ajJrekxQYVdqNzhhak9KZGg0amRIclZibzZ0d2xvaVFqZ01Tc1RrQUIzTkZM?=
 =?utf-8?B?ODZZRExORHF6ZHB1d2FXeUFobDJUWDZPK2t3SldOS1VkaVNINjlyMGhsZkJT?=
 =?utf-8?B?UTlnZ3U0RTk5WE9DZ0JRNjhyOVBhTE5URUtmTEtvL3lOeVZJYTg1MEdrTTZW?=
 =?utf-8?B?ai9VbUY2enhpL0NSRzhFc0NKVUJBUjAyYUpMWmpnS2hZMTJOYXZ6Vk01aGcv?=
 =?utf-8?B?VDZnRFhXOHpWb1hrbmdoS3FBb1NzYit6a2RuaFNoV0NUVUZZdFhZUzRuZXJL?=
 =?utf-8?B?c0ltendGajdJSHhPWGY1NEFoa3dEd2lsTXNrbW9nSGIrZ3RDMi9LRWQxTVMx?=
 =?utf-8?B?TUtnWW92ZW5iUS9WR2M4dXgxSmxQMDU3SWFtM1lzc05NaGhsYUUvQytZTWVH?=
 =?utf-8?B?bzVqMDU3TVNXZjFKaHV4Q2txb2xFb1NNM2FOVll1eTlIZzI2b1FZRm5INHEy?=
 =?utf-8?B?dFl1ODlmaVFmUkpmL0o2TnFtbjROeUpzK05qMU4wN1o5SVFybU9GeU9ibE1y?=
 =?utf-8?B?M3ozempNSjlJckpqNkNoR3BYYnIyVm94UzY5WGpUdVdIMDhtWVdpMlJlcU5U?=
 =?utf-8?B?SGh5ZTU3M2hmbFpLVStEeDZQUzkyN1VjVWRnMW9meDdTMlpvenl6SmdFbHFD?=
 =?utf-8?B?dGp6YXhoUlNXYzN1N1RNS2lWdGk2bEV5djJVOU1LOS9KYmRMNEluUGw0VDY1?=
 =?utf-8?B?NVFHei92NjREck95eE9JVnFPODdWQXJQQXVjYWZxMkJDSTU3RzhibkZERGJn?=
 =?utf-8?B?dHVTSDJmM2U1UjNwa3ZZa0oxTmZ4L2YrSWMzUlNVYW1HWFZJMVZZZ2hWUU9k?=
 =?utf-8?B?VVZBbmJBdG5QWWppMXpEU0NFVXdJK1RhQWdWci9La1BPZzB4MytMbmM3cC81?=
 =?utf-8?B?RktWN0I0TUN3c1AySDkyWFErY0UzbmljeTl5TUhyT1IvTml6YzRRenF6emlO?=
 =?utf-8?B?T1hUeGM3VDNFTXhJT0pOdjh1UnhuWmV1M0VzZmM5U0JwZjh6R3d5S1VreDhk?=
 =?utf-8?B?ajZUbDc5NHlxK2tjdzdDRFpuS3BuU0gvbXloTDIzMzhFRUV5QWRrNjJCaVJj?=
 =?utf-8?B?NFIweTJWaUNLRXFzQXRGY1ZxL09KN1BVT1d4ZEQ0MjhxWWw2WEdMNmFpL0Ju?=
 =?utf-8?B?bGIvTGQ5NHNqODZtUFBjWEgwcnNwdEZRYmlHeU1wQjM5UjhLY2wxTTMrbi9o?=
 =?utf-8?B?ZmRrREorR1o3MEdPb05ab3NIZnRGUFN6RW04QnVhS3g0dVNNV2FxR0ZCK2Iz?=
 =?utf-8?B?b3lDMGNBcjVxbTlSTnp0SE9NVHhjRnRsbVI0SUtLSnNhYmQ1Y25Xb2dMU2FD?=
 =?utf-8?B?M3Z2NGNvMC9WejRrN0Ywa2I1SDkvYUpRam1RQnp4M3FxUUtBb0pPWHNYOTBV?=
 =?utf-8?B?dGpPZFoyMmRVRzRIbklOSitWZUFiQTZLR3RXS1FDZGkrV3JNLy9LM091ZVdG?=
 =?utf-8?B?ZEtDa1RVNFFnSTFiWit1ME8zRFdxbTByZHA4bkhBL3J2ZjhiU1lEMVYxWENZ?=
 =?utf-8?B?R3VKSUQrWU9YbWsvYnEwNGR2bjZEN0htZWs3LzRMNkNDVUFSVFUvaVFtb09l?=
 =?utf-8?Q?Y7HfGzV4zflCxECIAB8owD8bBl/MWsVc=3D?=
X-Microsoft-Antispam-Message-Info: dXnNr8JmNMK0TTemKixwG3wgxURCtusdcwABcAPNtC+Q3tVjaJcbXio87Isu1AlsxXVcuk3/SwwUXiflBEXZbdgKbd8fpLbNcr454VozBQUnJ3V2jk78YtvKXkt4ihRF9aui/85CFmrfXWfH6mG7kA16UxtWQ45xotHerJO2OVWKov2pwOOKNffoJg+UaKug
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1652;6:A3HR7a5HXwBtc6FwNYdy2OSfqRohDMxVtkY/X9Ex/1181Uu/y5FZSJJHcWi/0ycf73r6tXhfgrKYXvnmrbexubbuAvTprj4fmSQsM2QXn339jvKFNIQGHm2n5vx08tm8VL1p6HQPHxrz7Vf5GzkLlHEvJZmImhiUnqQIGH+2M7aFaR7ZNHfJrohYqczaZDL8wLS2dpcXGLQKCQ4dLQcZIU9SeHDnWo3gpptPemTHm5Inme8n1jCc3c9vJcGYBOPPOERe0vpz0jnXAPBJuhtzvaB3WwihXCO3QEgDWqLhGNlE4+B4i/yusImvGPqTJtmiq7MOhjYdQvPT39WA0cBRTNSKOME9anP6cAuDSVNefQhiERmq3O/skJ5Qzwd802Onmkb6FWL48aAYBfcC7yFQHUaXJos2nFINpeXN0mY8wnd7uUCiqWzK1CtyiM/GvRxvBdIno1bTEdU4RJI/6fTLHg==;5:pVidkxqc2q5i+safabVhPTWhoJOfqTFlKZjYUOekYWEIqXx4Rccmba0uz/ImLBBKV7QpQX250dnm5rFzUR7ObYJscsQ7X/UMKDhHaUkQEOReyf3LMUYDBTw15n+jMpVLOaIPXRmGAEw9AO5o5HCK5XSnmPozCUJ8hSHgJ74VXwU=;24:LwT9tmiWSGwlLWwKxWL183CQVJKxcF1jCm+lIntd1UA3HkfZ5r66TyZT8ErFBtCwSjL9A6TgeFKbI+TyXCgBfKpnOWkmMhHyoHMRrSSDa0Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1652;7:yA76o6VlK+a08By5C2i7ODmCq/KwObHwiL0mWBcRXnFlPusfGE1V6v/FIqyH5qdqTU9S5sgDX/7HJCJYI5Quxc3+vmV2Bl76pz4bQP+ID/h3Xt1N3XdkfYUk6MUi3Aq+sRiI3xqZ8YTAHhz/puAaGB3QN8YtZi8IEZjfkA1Cj8w1E8Gn2pcBXg/+jGkkXIDO6+Lm4dunLkgqb7CbLCla5BjaaLaa1zf8lqGdFaqtEhTxKdUOMeNSfhqgoe5OR5qX
X-MS-Office365-Filtering-Correlation-Id: 736d7524-8395-4b5b-4730-08d5b68a5093
X-OriginatorOrg: aquantia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 15:25:50.1662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 736d7524-8395-4b5b-4730-08d5b68a5093
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 83e2e134-991c-4ede-8ced-34d47e38e6b1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0701MB1652
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Patch timing is sometimes surprising!

Indeed it.

> 
> Not sure at all if it can be an issue, but I also noted that the order of 'pci_release_regions()' and 'free_netdev()' is in reverse
> order in the 'aq_pci_remove()' function.
> I don't know if done on purpose and/or needed, so I've left it as-is.

I think the order is not important here, so believe thats merely a cosmetics.

BR, Igor
