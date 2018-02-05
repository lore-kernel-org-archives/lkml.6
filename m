Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbeBEJCL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 04:02:11 -0500
Received: from mail-he1eur01on0091.outbound.protection.outlook.com ([104.47.0.91]:33184
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750962AbeBEJCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 04:02:05 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH] ubsan: don't mark __ubsan_handle_builtin_unreachable as
 noreturn
To: Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20180202154813.1625742-1-arnd@arndb.de>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <d77f9a8a-0bb2-50a3-68e3-b4f4173645bc@virtuozzo.com>
Date: Mon, 5 Feb 2018 12:02:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180202154813.1625742-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR1001CA0009.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::19) To VI1PR08MB2830.eurprd08.prod.outlook.com
 (2603:10a6:802:19::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4a1ba6b-ca42-4e70-db2f-08d56c771eec
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:VI1PR08MB2830;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2830;3:dCrmyWqwHvffakhhvZiAoF/w/ta0ztsExoFFfnKMZZVaL+MGkhCAMOvIR57yJ73tFd+k5EOUGWyQg6yCkqu5zwHTWRU6y6n53BkpPm5+0ZY8yMExtVEX7gfJBzqRCXM7gAPd21cELh3dhZX68kJ9L+KnZCJ9KjoYb+LyQJZ4ZtzCc5Ib3F1U7gm9gBr0RzaZkc3GlKOZwVDwrYA8E/wdcE6SmgAV6au3SNtRVzMUcapWNVU6GDzi9Q3Yr19ALDMm;25:WyOS+b1w8ggPhZSeo742LH+mqBIPQ2hdOj9xwLmwLptUDIIOiGoxn1hI6sYqDXJ9DyNSyzCm/lE/WoTmVnGWDPoHar7IwLyqCJPQkQRV8HNahaQs/jOxb9Pf51hNqL5676tw7YMQsp3OXfPRMvfNc5S7rjBYNpi7Ev2sZeUDM5rPSTAyDRbYWVP3v32Rqy9er3xalEeu0J95yVwTf/mfLzkvzl77a7LllWH7pOIJ5bdJ79Hmu08UOLbz/GNYg5NJRKZI9wfy4jMjxr7wpKUj83uBp7imPjGRKMUdc+P8jOj3RSftHr9JBNQS5vF2BfGH28t7NY5NmFhCiY+FoUXgeQ==;31:hBPJOftD7qZedZ6rIJdC5UendVE/hSvWuZjRQU1xqiNyb2BneNt6+p7haSrwQN9zLfyVkfGKlBFg5dvVe7SnU2DROS9BRvXIlp+2u7xyEdkSoYJTz5stgxJ+9hmO0PkPqKQBYrrhjjCvuNqkIEu7a/s6fnxG7WOXfEX0FbIpANFFkJaWrWTVTIeMB4yIMzDMTIbL61rFlpPN1MwA1mbGWIPzPMLonX7de22B4uJ72FU=
X-MS-TrafficTypeDiagnostic: VI1PR08MB2830:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2830;20:YduTxJ5KLhw4exq3hFTf48QhRT8QPt6hQNxdaqPeWEQepPXILMmTE4x80v/GWxoDVkL5Ge8X+5fUxJrTS2RiYRRoGdH1fhuZgznzoQG5N0wZiYNW4WAtHKULIVSbcomzIIrADaqxAx4NPdUowlTCNFLX5e5US5d7c1ktCwzoO47cTmXoz0aKB5rNboy+wBmoelGf6Bsng9q0w7zu3Pz8tWMCR9yETW/o/mLwPP+6/lAfAye+1pM8Xok3A94Q+wkW/dfb65pm8/Jaa40BQE55HJ2PUFMBtMCmjhLIvsaWwLiDB4oxJ+jFrUHbCLoHHyE7DyFbapD1Hbm5o7gTBSG//7l2CAHzet5VkCAygK+GtdlCPZxP2fr6W9Fy+wDxryZlfI0BSBEP6cHxJ8y2xSJoUfnFLpavxc8CXOGKkLG0ijk=;4:utMx6OClcH14NucBEH5OySsFGx+ArlGG/9LqSogC6U4/kMNJO7OcAOGc5LLXjYbcUbxxd4uZknz7/WsnL+wKPAphGw/m/dc6rvoXr2qFygbs6J5HRs6kol0r+kah2BC8bSbuMdy086w32PM9BEqDw8FfAFmLXtj2Ep4qeqCuOT5+VETsJeV0GKg75QTMdCCbDsAk9rdTxRvm+kBnrYdY/GkBE7q/H3BpE24Q/dRFPbTqneoAvNTP6pR/p4wu0bJ8GRGtD9i//Ban8RNqbxcKkw==
X-Microsoft-Antispam-PRVS: <VI1PR08MB28308B0858774863FFFCA9C2B0FE0@VI1PR08MB2830.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231101)(2400082)(944501161)(6041288)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:VI1PR08MB2830;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB2830;
X-Forefront-PRVS: 0574D4712B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(376002)(366004)(39380400002)(346002)(39840400004)(189003)(199004)(7736002)(186003)(53936002)(105586002)(53546011)(305945005)(106356001)(478600001)(8936002)(47776003)(23676004)(5660300001)(52146003)(2486003)(3846002)(6116002)(97736004)(86362001)(8676002)(65826007)(81166006)(31686004)(81156014)(229853002)(55236004)(386003)(6486002)(25786009)(76176011)(52116002)(6666003)(4326008)(50466002)(316002)(2950100002)(54906003)(110136005)(6246003)(66066001)(65956001)(65806001)(230700001)(58126008)(2906002)(68736007)(64126003)(16526019)(36756003)(77096007)(16576012)(31696002)(83506002)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB2830;H:[172.16.25.12];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4TUIyODMwOzIzOk9CaUJuYU54NkF4cW54VVNnMEhEOXM5S1hY?=
 =?utf-8?B?dWFBRWVGcWFpVXp0bWh6NXpObTlna3hKL1RqWlpxZ1pzS29YRGdFeDE3ZkY2?=
 =?utf-8?B?MEVCYS9EMXVSUThaUEZhWlVFeW4vZW5BRW9oZWNXZ2N0VTNBM1piMi8zZlZR?=
 =?utf-8?B?cWx1VWhVeWtZczNUd2ZpU1JVRG96U1B5STFTT2NvbGRYbkwvZDRuZEk2T2pp?=
 =?utf-8?B?d01odUdGYWQrYWFwUHAwSTRScnJUelhMVlVmbHQ4d2lWUWlSR3YyNURxYnR6?=
 =?utf-8?B?bFhuU2xlWUNQTktLb3VuZ0ZDdE5HbEJsMFN4TC9XTGxKL1lxbGVjNGRQVDhq?=
 =?utf-8?B?ZWNsSWZ2TEFzeElEcWdkTi9TbGhnaEsvbnBJVnZHY2swMFhXUTlYc0taRkt6?=
 =?utf-8?B?RWljRS9CeUovVjZhR1hKV1dieE9OVCtmME9uM1N6azd6U0J6SE1kSkg2cnpD?=
 =?utf-8?B?dURJbCtoZ2d4NHU5b3pmME5FdXZlT1BRSHk5MlJDRzRYWXgzcm5HcWVYMmlH?=
 =?utf-8?B?WWhWdDFQMDM1RmRNaXdMSlNpNGE5UFQrdFhjaitpQUh1K2xpME9CYy9XSWlk?=
 =?utf-8?B?bUZsNmR0RVhqWklJZlZMcHY1aysxR1NaQzc4MWlRMXVZK0Z0cWNDbVEyN3dE?=
 =?utf-8?B?b1FqY01nR0NiOXZXRm4vblFWZHk5b2NNalBjL2IwTW9qc0dnQmRMMmFJQi81?=
 =?utf-8?B?a0NReFYxVS9rMVhwTFE5RElwS0F3RnZYUkUzZithcUR4ajJFelRjWU9jSUxs?=
 =?utf-8?B?TkErY09XQ3RVbVF1VDZxY3pQd3c3SUVMV3pUUkJJKzhVSnAwMU1GWlV4b1Ur?=
 =?utf-8?B?b2VjdlFRcURqL3VuOFd3YW9FWDRqc0dNcXR6TTFTSWdlVlVQUVU0RU03SGtD?=
 =?utf-8?B?Y0tueFoxZ0lmTHNnU09nYkM3WU9UT3RUWWl0WkdFbkxNek1QYkFTMmR1T2JO?=
 =?utf-8?B?cnBTczRoakNYK1l1RTJFMFJJc0RLM1JGME9GZW50R0M5byt3N2E1SlpIcWJQ?=
 =?utf-8?B?RDZrSGRGRWJMNzk4S1h2QmowTUMrMUpkRENrdUUzUnFMWTFkVE9Vd3lSVmdh?=
 =?utf-8?B?aksxN2RsU1Nib2NSVEdmUEFTWmF2UHVxdUkzMkYwWVFQV0dVcERReFkrSlV5?=
 =?utf-8?B?ZzlJTzRFQzBFQUVSa0d4ZmNJYWNwTjNUTVpBSldXSDNZejFGL0htS1FXQ0gw?=
 =?utf-8?B?THNGVndYMWJ5Szh5YytvSmhOTlRkdFB3aFNOcjhKZWUrS3dmNzRkbDZqbUd1?=
 =?utf-8?B?RlFuRHBraTExU0g2TXBuUjRVWW5TNGhSbFlPb3M4Y0pxQVNXVTEyZ1JsbGFR?=
 =?utf-8?B?UzdpT0NIK0xHcWxQTUJDRWpvQkM0Z0FRSEI3N0FiNnNFd1hmUTRtRis2T0Vz?=
 =?utf-8?B?R3NLMVJDaVdvZVpwL2tpaXl2MFd5SDZZazFrV0hpbnMrVUhZUXpCMklZWEsy?=
 =?utf-8?B?R1F2c0pBSTJPQ255bDlzbU1NSzRXbDUvdk5OUFNLNDZLb0JuSTUrNGZMZ1hC?=
 =?utf-8?B?RmZRUS92QzhBblBQYTA4RUFYQ2w5ZjlMSngrSHFhVVVxMVZRdnFjeitiQWl4?=
 =?utf-8?B?bTdUNUhHVXIySXR6TFJjZk52SGdMZTdMaFlVTTNIYjFKckdib2xES3RKK1R2?=
 =?utf-8?B?UDZmOXdFN25ta1hNTUg2d2RBMWNUZGgyZ0REb3JsT0dFRmhLQVhRdkJGY2x3?=
 =?utf-8?B?SEN4dGsrVzFRbmlLd21xanlJenhxeFd1eERqUlVnNEdvbHlQUUQ0QmVRQnIx?=
 =?utf-8?B?cTJkVzhiTFdHSWZXbWRmTjhhM1NxdSs0SU5VS1hBS0Y4TnFBYU5LcWZTNjNx?=
 =?utf-8?B?czNudWc2cW12M2FiTzRVVmJEU0l1S1M0cTdPYmF3Q2t1REtqQjZZZG5YUkh1?=
 =?utf-8?Q?Jj1cyqWQeDd5dwyCeO9OgX2zJ5EZl3Fh?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2830;6:BoKDj3EvjUmUJgSVWhNbGCkuCKgkwoFwBoM4+QRMp9+6fiI168qrHuWAzxL3EbZyZ4zAegsxkGTcSdmW5vK+HbLB5tcfaX1zYwgJ/LIFKVbIEuHlyaQoF6goVky+WcxdBAbDuW3MmgNKrPZs1cOWK6JGTzzrQb2fvCT/BKFPUYcLy6IpCWgjV0dRR+1jbTHO9SOv7VcgJgaPBz6P7VLJeulP00uGMV6/MCEA9qXjx4fx7VDiIq+fuTs0ECxz3gDNd/rEvVLpMeEyISh6xTu3IB0OLiYcKAwSoGRh0bhvFqHE/c5mN00PbmROPnk7OYP2HiVdO23WWkqhO+j6dLZL0mWfPh9oEsGjGkSK1k8aqfM=;5:oHdhj6yEwFdmCk/NlrYarGCh8w6zrvCveXlPDR1gFHZBvTohGko/9Xa1PQp9ot+PQIbEGxerrsmBraV/lDvH/DGhvfWuP8oISP8qoLSCCMU0aJLvnvBqp/LMMimdcbxwJRNPhFRiu6Ahu3hyIc2KEbqZ11SG5hKwHqCg6pjXCWs=;24:TuPsFbIxUr8n6sJ6jw9on2GBbdl5/yJKcJTBSEVOHcavNUyejSXzdtBp80+OfSs79n7/BwzMnbNvMrtZXtcWWazc0pm+S7BI9E/RDMD19oU=;7:jDTW0zQAJEN2ic7FX6W4pnIkqZtHm8yM8dPyyocGP6Xp4zlc6Arao7O++FPm/jIYviCd+9IM6PeraFJvTkV643ZPLjKFqJCZrAAoxQp2CUEpTu0YZpcVlUdpfq91aWil2uac4cqjfeFXXBtvQC6fxHibujW2iVUHdDTSzKe+9TiT8m2Wn23DkhwhUtfMFMfhRGW2hN8p1z7GGBPJe1wIcvlI2VYCzqGbp1h3p4lj1X09vHQ4FJYm3+7PPgFejP6u
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2830;20:XM7HdYbu3XjlfPwza2isD3871P14VBOxzLK0uIqJNKbbbFWXn5bcIwWqBJr7P42LL6IW/kF6GBDQSTUsIC6Z3XVTxroaOxrpHH15g/0Myha/UsLVGXEJ4pj+oCIrZNx7NgRb9Ry3riT+PdtmUsdBxSwwDqt0pz7pwJ4zFG/6m/s=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2018 09:02:01.1509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a1ba6b-ca42-4e70-db2f-08d56c771eec
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2830
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/02/2018 06:47 PM, Arnd Bergmann wrote:
> gcc-8 complains about the prototype for this function:
> 
> lib/ubsan.c:432:1: error: ignoring attribute 'noreturn' in declaration of a built-in function '__ubsan_handle_builtin_unreachable' because it conflicts with attribute 'const' [-Werror=attributes]
> 

That's actually a bug in GCC. In GCC __ubsan_handle_builtin_unreachable declared
with 'noreturn' and 'const' attributes:

DEF_SANITIZER_BUILTIN(BUILT_IN_UBSAN_HANDLE_BUILTIN_UNREACHABLE,                                                                                                                                                    
                      "__ubsan_handle_builtin_unreachable",                                                                                                                                                         
                      BT_FN_VOID_PTR,                                                                                                                                                                               
                      ATTR_COLD_CONST_NORETURN_NOTHROW_LEAF_LIST)


But const attribute doesn't make any sense for function that returns void or doesn't return at all.
Given that gcc-8 has not released yet, it would be better to fix this bug there.
