Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752651AbeEVTvC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 15:51:02 -0400
Received: from mail-ve1eur01on0102.outbound.protection.outlook.com ([104.47.1.102]:7154
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751687AbeEVTvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 15:51:00 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH v2 2/2] kasan: fix memory hotplug during boot
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "open list:KASAN" <kasan-dev@googlegroups.com>
References: <20180522100756.18478-1-david@redhat.com>
 <20180522100756.18478-3-david@redhat.com>
 <f4378c56-acc2-a5cf-724c-76cffee28235@virtuozzo.com>
 <ff21c6e7-cb32-60d8-abd3-dfc6be3d05f7@redhat.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <09c36096-f8c8-b9e9-0bed-113e494f159a@virtuozzo.com>
Date: Tue, 22 May 2018 22:50:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <ff21c6e7-cb32-60d8-abd3-dfc6be3d05f7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [84.47.128.244]
X-ClientProxiedBy: AM5PR0502CA0014.eurprd05.prod.outlook.com
 (2603:10a6:203:91::24) To DB7PR08MB3258.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3258;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;3:RSvPb5p53mb2dsRKtTjVLv9/dHyejXu6ULfXETFo9jGGko3DfiGPEQt7W5tzIQ4ErOty9WEXJT9BFGJML28MMMvJWB7wyCQFFXEq1F7zrx5E6FoKdoHCR3g2eVOt1nyVwdwFH4UYRybfaW2aYRvCd5bIQnRJMThXwXiqe7kvhCj5ZA7CMrFMjntWVnR1mKxhPBFzMpN0wEUmQUF7y8iEMcOwUmsVADovtvHcNfhB34FkplJIIvUSry6181ycHNZw;25:d7dSlbJ3n9uwcmlkhaXME+wgm7XLHz61eXwsww9gGUGiGpVn5OQvfVWys68+MXvY3i0kzMJjspR4xKwOqWHBiXBy/Aajl0zoz58ZwrYtop6eDPve4YVFp0waDMiyOl285snbSLxG4jCgnT2uV6bLEBEP+oFnQs+rZfEMWK8yCb79YqLF2bJfZF0vhszfGZIdTGq+9HDwo0KQYdaeP63YPzW+jqPbDJbcEBXzqEbNmTEglzVWsuB07BbYBEXjVvublDqMHDxeq1je2LTLEboEuUfcdCTwortMv1WLw1bWfpCMlNuTFd7nuqwq+zr95IVhjCD7z9u/NmBN8ZvWSwxhuw==;31:MyNs3cD9LWZLoEGF8JdUz8nTX718wpf/YunG2GiNsr2gpUtOscB4baqRNyGJQBu4uSzXt28qw0Ug6pvZPUbWupPqEy6NgKnU7tbwIsuYNBSr7G6b5eTMVveUZTIHhukrupz4dvy8+Dn5UAxSerq4PRM6VDKdmTXEFZ1YSxZwnxXiKhzAZGcHDAzteOFlbYXVI0r36G9X/1yDjJ+NQaNo2wi/146tzkIeQSNDBP5X2Ho=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3258:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;20:LwhJFCiH3qg05lPJmMOZVJCLdkKrgWrmdpoYSIseBVNjg1lQplwEUYxNEJN5gaxXy9iCfkIxpol3ywa750xQe8wcDqL3smut/bHHPUN6bayxlGauRFwLmc5dBX73AZLT9OYTGnNEaE/qpus2flxE+QwZMdkaEFgTvcKom5/hu6bJ8OtmE7lpp3JsmnKJ1iYj27YAiZx8dAcsuiHFRp4YX7/jEcarsr+NHrsigAwiSBPM4VVnM29nykZG9Acgct34Bmqyx5m+MEmXGdc9PxiVJWa/JLmQ09rtRykKk7qyMwjOINiQdSDqe7DJEuOhmcVVxS17IKGL7wfTJ2hNk51LNgigFO58F5twrNpBZGNDEQGqVuZy0DEBXljCJyyitcWVrB0NOczbg4zx4kGdavqHG2zwqg/bTPQCKOJ2D9cIyqG7UGoPbg7s9eSWKyj/g86l7fnN3Th34AVDyCCT3a5g0pTaIFwT1nKTwOIiIGRVJ05HmNtMkHsNAAEAB6DQbg4Z;4:NpKf/MFp++pQr+FY2kWTY0c240EwagDULAbqeDerR6fb9s70FNYcFsGoiKXBKvd7+PNK6/vESMBbpY54eutnJYXEJltM+/lEYqjAmBvt0yCxIz9tA6NZ3qw5/pF28x3qr3M9i4bDpvMNPRa1uwZJtQdsCUBNNgDB+NLBQILY4JwRLLtD358CJOaNJtVJviM6WPv7AsTelV+5hepc4JmhJgkpPLamFT2FHHnGas/6yMpVvWCtE/ITrScWmT+7PDp7m6lFaJ18ojT29qDVxq4zaC+qCkyPm9y3AqVC6v4gx1wGE9cQ+siwOd/9ByLoTE9z
X-Microsoft-Antispam-PRVS: <DB7PR08MB32580788B4DEC1A543565E48B0940@DB7PR08MB3258.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB7PR08MB3258;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3258;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(39380400002)(39850400004)(366004)(346002)(396003)(199004)(189003)(8936002)(230700001)(36756003)(110136005)(5660300001)(386003)(58126008)(54906003)(77096007)(26005)(16526019)(186003)(106356001)(11346002)(956004)(446003)(25786009)(316002)(97736004)(16576012)(53546011)(68736007)(64126003)(86362001)(65826007)(31696002)(8676002)(47776003)(65956001)(65806001)(66066001)(305945005)(478600001)(6666003)(486006)(81156014)(476003)(3846002)(76176011)(2906002)(31686004)(105586002)(23676004)(81166006)(229853002)(53936002)(6116002)(2486003)(4326008)(50466002)(52146003)(93886005)(2616005)(52116002)(6246003)(7736002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3258;H:[10.52.82.104];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA4TUIzMjU4OzIzOk5HRmFBN25PSm9sUGUxeHdiRG1nMWtUaHlp?=
 =?utf-8?B?U1VQOFVPdGEzTjNEd21yK2cxNUpxMFdyVWdOL01pVWNwUVVSMDlicTl3aXk0?=
 =?utf-8?B?MWVqWmxvNUsxbnRnMmZwTC9KTVgvd1BvZTAyK056OVIxZ1NIM0o4U0I0OHZo?=
 =?utf-8?B?cHhiWUJWaFk2OHdTYk1vOEM1c0hFdUFRdTF0YzVqRU9XTDlYQlBTcU1kYUtY?=
 =?utf-8?B?dlF6TjFLYlRVNFUyTWJNK1VROXM3K29qOFlhZVY1dGNDRWk2aXlMM25XeG50?=
 =?utf-8?B?MFdpRkthWGwwRS9lL0lRMThBWStGczF6SHZpc243dEVJTDhzRWw0bU9wV284?=
 =?utf-8?B?Z2RBVk1oOHo4M1dGOXNPaWlJdzlaMGFRQTNkRGo0QldoZGxFSlFWLy9GVmlp?=
 =?utf-8?B?anRoSUxaZGNwb3VOZEFKdTl1S0E0eXJYNWZiOTZiYUNRZzJsRGlqN3NyaWxv?=
 =?utf-8?B?eTd2RTRCeFplMVhWVm1URUc0NUxoUVk1dFV3Z25rUFc1N2hiU3I3ZnpXUklH?=
 =?utf-8?B?SXJKQ3hwK2lUeXZ6ZE5CZmVaOXdLbnp1S3ErTjRYNUxDQ2lEa2F1WUxkNUxS?=
 =?utf-8?B?Yi91eXdlQzVCeVdQREtOM3Z2cm5KOVFYZExJd24wZExuZzJuZSt0bFpiUHdF?=
 =?utf-8?B?ZmVFaWMzSkpiWDlNa01hR2w5MEE0eXVKOGxQbTIxNW9BMW9ySEVKZXJ0TEEy?=
 =?utf-8?B?ZndMRnU0TFI3czZpTEVxcmtoMk9namczQnJ0ZUtaVExhNTdPK2xhZys4NFhV?=
 =?utf-8?B?UUFiNGIwdGtVOWMvYVJQV0NVS2tXN1RTS3E1c2k4VXQ3RW4zUWJMYUxvZkdX?=
 =?utf-8?B?Z0o4Vkg0QW1nRDBXK0wxMHRsTXI0b1NnMExEQkRqSDNaYnNJeGt3WXJHRWFF?=
 =?utf-8?B?ZlpXR3h2a2I3RHJDd2d1SnRNQkJLcGU0VUI2Q28wUmRkZ2NaOGJqcXRPMGVZ?=
 =?utf-8?B?UDRSZmFBbERBSmE5V2w0RnhhZTdaU3hPYUtjMkpaS1dodlFueEVXYWZ2eEZP?=
 =?utf-8?B?cnVrbHR5aENyYTBuWXhBV3NNR0dQZjBzQmJlZFhyd3dvT1lpTEo5dW9xcnF0?=
 =?utf-8?B?K3I0SWxCdERFbzNoVkdWc1FRRjZpOG5IYUdNSEdJQWhEOXZzQ25aZUl5UDRt?=
 =?utf-8?B?UzRXT1prUU9Gd3RVWDdUemY2L1hDNkg0c0hDa0V3S3N6OWxkWUx5amNuaDE2?=
 =?utf-8?B?Z0JRN1V1MUdVcGh1NS82U1ZjV08yalZ3YUlMU0lPV1VjR2VtOFc1UVZSTWI3?=
 =?utf-8?B?UFpSRm43c0ZERTVUdlpObUZNQjFwVUwyekRJZkNQQkh2dUpGM2E4aUptWGRK?=
 =?utf-8?B?MDhRV3VzeXo3cHRWakRPKzFKQ2FraFNhd3cvWVc4UURTNzJPWDJGK013NEtV?=
 =?utf-8?B?ZXFEWmVnRUZiQ0Jxb1Y0T3hkcXpnem03V01tdUFuMDlzZ1FlL2E1UGtZMWxO?=
 =?utf-8?B?VmRFcTZLYVdIY0lIQ25PMU4vaFBuRTNaUnlIUDBTV2cwYWJNWGtBMklhNVRD?=
 =?utf-8?B?aTZaeGdvVXZCYVA2OUdVY1BnN1ZuUmxsMjRoU2JyWVgzZzVQRGEzQk83c2wx?=
 =?utf-8?B?Y05lZ2ZXRENBWE9VeENmV01DVzhuakFVSzdmY05KejMrZ05RdU1BRUNxaWFF?=
 =?utf-8?B?bWdWZXRKbFhiS0s2am1Mb20yRjc2SzJBUUpLbkdYTjQzN1NwN3FXUWxhT3Bj?=
 =?utf-8?B?Q1Z1M2d4WENvbmpHWUwrcmFETU12bjRTUmRiYXYxZk5yaDBEK1ZUclBaZ0xs?=
 =?utf-8?B?WGV5eWE0Nk9jV1NnbmdHc2RzeXlXa3pvSDRmOFRsYy94ZGQyMFdLR0Zwc093?=
 =?utf-8?B?dlBGNGNHTWNkbGR0VzhEWktVY215aDVSZVZHWHVUb2t1YnRycHhUbkdTUyt4?=
 =?utf-8?B?RmsycFBoalNza3NQblFOcmdZM0srVnp1RndObi8yL0tZU25KOFNVUUZ1c2kr?=
 =?utf-8?B?WUF3Y3c4T09tcndoK2drV3F1NThFeVljUkNkS0NTaTdXa0VMRE9uSFNlNkRF?=
 =?utf-8?Q?aK44Dl?=
X-Microsoft-Antispam-Message-Info: b51HDfHMTPdC59NucXAzzp/pnhdB47QP/5R+75xbB73kj+knBocvHsGbzE22xJeDNvSqyln1iHouMKF++ITl9fkpEee0SpzdYJvhGD/yYkGgS5NqSIwy5khng1gr6FaXic9HhZw/XiSixH07MidiyE6/a4krv35X/QTLw0kesGrE1oaKXbfMkTyebfGLGBSr
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;6:PlCq4j9MoxBanhsyM0G8m1JXDbYuXKhErJhR+o0F+ZuuTKlYwoZw1KRN7kZDR/MXaKEbCSTiYdOopH6cJVeUxsO7HfpZdSzw8HwJGhgpJVzVF78s9ze2cFGYZhlkyxke57TVmfFCfYvORKrhOniNDWAT76sp2KTI0WUxa/JGJ/zOzxrromHLzyVmwqtclE87xFRVt6995lZoB6dFekl4XsD7aQMVAOtmDhdsUtNW6zbo00ZMyYmAJ4m63TKY4Vc10YTBZ5N1h1BXKZNa8ovtA9UjotN3BO3oVm9QHTAoroLB1Lb8MQKWNoD0SJO1p31Say3bhoKjjruq/mBlk8MIxnJP8/3lBtVvhGZGArh0MGxRaf205aYLgTSXe63hwkXstJs3CKS+EM7wnWcYUg3/8A/26X7opTzpG50TtfkCpThwnyjiT8CQAElVS+K8VDtE079q9F40tRpMR8m3WLK0MQ==;5:vovaGf7hh2J3XCUkFVyGo+jjJkl+WmsQyhzTc+5TY+O91g4VWKZjusgQPELySVcP29+lkH7uBf+U0HPWdhZinRw/OG8PKEBan8xHFVdv9PsN7/SiDxubhSdxFufPSxP5h3DGoQVDL5nYFtWzgOk0HI1QuN+QqdXYwg31Mu2Zjqc=;24:pkxvBdoS/+cnk48ZVBsBxHO2FPlkvpc9F7eEHRysgkCQHZGK21m3uHqm0YBG84tJf1/awq/ymWGONmgkP6E+yxGIadt3rLyRarqewPl8pIQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;7:PsFTLAKjr7DSNsL826wAtTyoOZg4wZ96VXqkzzca8Zd9c4rdU8sCtvsw+N8dqJuQ2+K/CMTZMls2ExL9hVboZxFcFTNAtK52uR6bVd8v0QvcF7nEYBj50DBu8O/Ji61ddQxnjfCsqw/G0ExnUyEapOZqvi7aKqCeDYH9ZXNtLXscaOB4dIHJUOfvJO8GE0icgkrfHCU0yb1wzAGt6UtXZBf6mluDvCcQx/CXcLIgjrtp7mvpkCWgEHrrVPbiC9zt;20:JjQA/YlyFf5KN6yV02RNBfUto4F36IKYpnPsvy/lgtr5SpcESWIsl9nI4vZk+YJKRqdUfSX6XEHWdijJffcy5Ix9aV+Qf5SBOifVVssqHUCSyWA9ramsjTpGI0Vn9AFsTmdYot3Z6J/Umg74rD+QMD29CPLtXp4Ce7wTK4VElR0=
X-MS-Office365-Filtering-Correlation-Id: 3f0c6b4a-ecf3-4a45-f187-08d5c01d56fc
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 19:50:58.2388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0c6b4a-ecf3-4a45-f187-08d5c01d56fc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3258
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/22/2018 07:36 PM, David Hildenbrand wrote:
> On 22.05.2018 18:26, Andrey Ryabinin wrote:
>>
>>
>> On 05/22/2018 01:07 PM, David Hildenbrand wrote:
>>> Using module_init() is wrong. E.g. ACPI adds and onlines memory before
>>> our memory notifier gets registered.
>>>
>>> This makes sure that ACPI memory detected during boot up will not
>>> result in a kernel crash.
>>>
>>> Easily reproducable with QEMU, just specify a DIMM when starting up.
>>
>>          reproducible
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>
>> Fixes: fa69b5989bb0 ("mm/kasan: add support for memory hotplug")
>> Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
>> Cc: <stable@vger.kernel.org>
> 
> Think this even dates back to:
> 
> 786a8959912e ("kasan: disable memory hotplug")
> 

Indeed.
