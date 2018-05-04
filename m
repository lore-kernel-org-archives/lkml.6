Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751377AbeEDKJi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 06:09:38 -0400
Received: from mail-sn1nam01on0053.outbound.protection.outlook.com ([104.47.32.53]:9338
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751107AbeEDKJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 06:09:36 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
Subject: Re: [PATCH v2 2/2] ACPI: APD: Add AMD misc clock handler support
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: djkurtz@chromium.org, Alexander.Deucher@amd.com,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1525422930-27826-1-git-send-email-akshu.agrawal@amd.com>
 <1525422930-27826-2-git-send-email-akshu.agrawal@amd.com>
 <3734664.7VekyYX7C7@aspire.rjw.lan>
From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Message-ID: <0afd036f-9526-f5c8-4bd6-87d145319370@amd.com>
Date: Fri, 4 May 2018 15:39:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <3734664.7VekyYX7C7@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MAXPR0101CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::26) To BL0PR12MB2355.namprd12.prod.outlook.com
 (2603:10b6:207:4c::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BL0PR12MB2355;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;3:j/mSArazqXN5h5HN6HG+hlv/Dz0mlU0KHMaokwJX2GrgwkuLEKeZ3CELguNmeJSTA2Ssxptc5kciJp9crpz2lX9OY/2NezUM9WODr1+llmEzKE6jKJldaO9ClIh5Hx8t1zJqJ6DaH63ib8kjubJnkJbnGwM2sis2hTwhkj9zcEOGwRbLAFAL+Vz2UDYKWTCOKWEvJCR+uh1LrFhSa1edBwByV853PBqE4aUKnMjl57ymUwJ1zl+N+uD6Q7EqYr4X;25:Z6heZsvWSCUFECWuySpwwJrMPVLx4N32lNfW2mN8rmSMyUCKU/STRAhu3VoMkIbGJ1YZsqpMDT1k2YdKt15HBBgK5cwqu/EDxP1wb5yi4e1YgHz0p4ZOTzwbOotoaniM4uQnhlyh5nDpgsa2oz7G9h7xz8OfuMWVEd4hr+Nr6Rq4xc0GAmmISraN51y4EhMTndzX70dYj81+kn5qMe5H3tAUrv9MmQcHeh3KSLisXtRb7CXvr5djuXlSVneSAF4PePnXwsq4yG7LAMBL4J+nlAwybQgg+t4rEhpNd4VAeRkJU6JkihYK73gLBPhCi8YrQz8imrrBPqMsXigsI5VrNw==;31:f9hFIiWqsWky4/poB3V6njrb0hDvjeoPjNlFFJHl+v1ajM0FJbd7nyIWYI1fvyWmvDqqqkuQzhSKIn0xF40dvOrq23QJcPrpzNF5+IiwH7aTCw/LPN7JwHi+3fZRDmBj9iuGWQ7qXo/5YLoVzxFQOR8hIIGBNcLDMyDEXjp6RfxAEwhPgqwkB4GadR8MlSosOarGGkffbM5zIsbpGbLOgtlNoY7VT2Ae/nVQaPZ5S/E=
X-MS-TrafficTypeDiagnostic: BL0PR12MB2355:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;20:IcdE9CQiXlMLQLYEW6xGWxOSKQecCxEyuGgySIMEZ3orPEeJ5DSdlHC0GjXJTUuR5AYyrsFOWWV2jTTrX5MXhQhgW0fbgKAbyZlbNq17muSWxwgkbpNdKt3sWfLLW8qUBOev1TAWMAPD52dArtogbhnBTQOxdq11hM22H6W3G4NCQqD0KuHd28aMCGWtqvwhtM7IEZgtOkoFARP9KfbvdtGAzp7Og1A8ELYOg6emlYK7dTAzA5XzeJkikpZWdXO5UMiXX9JxcJeWIaYdBnSXWH2WsUT59RcOgednOB0MQT4q1Dc4j79az1t8SeJUVPWaLjplYoMotHuAVcy4ZzOqxvDQyQ0ufLRGdbVyJfzhoc98UzfnzcTA1oXsL8cBMKQxDn8A7gzhmKYLgsRsbgcL04XVJB6nw2i7kgiPtlnd7ooysfJ/aIbVA7xVKOwTWhhmgTZyWSqin1H747h4yNG5bbx09K6VdPzpH4ygBU0O5qph9qpHTLShURK8grUvtnax;4:TAxt6MZFG0n92Yz4BG/8T5P/ROaY+8I25V4vah5GHV8e3nwLSaEkEN0WdfQ2Ej5M0HOvwKrfb72mY4LLx/ePZBNsq59wqPSs+zu7fwCa8yiBHbwz7fktMVhNV7BHeC0Gjw+c4jVeo+edxZF1Z2aNrGgjB1SVVZ5Cd8KATwE6NdOSBuVIpULU8KuQZ7Ot15WyRfHP5LcWSWv+RvKVMH+MgY6xzkSJ0WmFaoc199JxtiwkLAeX+YK27mX6XUVgs6an7+gvuEZ9RRvF5WeOR1qeIrMWYSTX7ZXiXhcfG7tk3LjmI4aw+hdg+9e2rwayw0OO37U+WOdPVwQyQSDwU0pL6g==
X-Microsoft-Antispam-PRVS: <BL0PR12MB23553DCE4E121880CB60A3D7F8860@BL0PR12MB2355.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(21532816269658);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR12MB2355;BCL:0;PCL:0;RULEID:;SRVR:BL0PR12MB2355;
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(199004)(189003)(58126008)(16576012)(316002)(2486003)(52146003)(386003)(23676004)(6666003)(6916009)(486006)(3846002)(229853002)(81166006)(6116002)(53546011)(72206003)(68736007)(54906003)(8676002)(2906002)(64126003)(25786009)(3260700006)(59450400001)(76176011)(50466002)(966005)(81156014)(52116002)(478600001)(230700001)(956004)(106356001)(36756003)(7736002)(446003)(53936002)(97736004)(65806001)(66066001)(31686004)(31696002)(8936002)(47776003)(65956001)(2616005)(105586002)(476003)(11346002)(86362001)(4326008)(65826007)(6246003)(26005)(5660300001)(305945005)(16526019)(77096007)(6486002)(186003)(6306002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR12MB2355;H:[10.136.128.133];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDBQUjEyTUIyMzU1OzIzOjJLNXYyMzlQU0R1bnkxZDg3VzF3N282WTEr?=
 =?utf-8?B?NTRuN2xkdlRBbVREclAxNkFKbVd1WXJEQW8rRHBYQzdmV0tMNDBFSlY3dlNQ?=
 =?utf-8?B?TC9JYldUNkIwUmFyOXZqTWRPazRlYStWN3kzaU8ySnJuRnIxZlp2U1FQUGFu?=
 =?utf-8?B?T2ROb3RQdStNL3doUzdGRGlvZy9JZXA1L2JVMTBDbkJWUnFtaFhaUGNITmRv?=
 =?utf-8?B?L1RxSzRvRmsrZmJuNzZ6cVFPblpwaG9BbEtQTlhYWTlPc1FEcmptOW56Wjdm?=
 =?utf-8?B?MVlMNVFhRmY5ZjQ0cmFxRk81K3NmM0NoU3NWU0REQkRad242bVpXOEU4VDJQ?=
 =?utf-8?B?bWNJQnBQMVEzMmtwMGtrazNQak9ZUGlWaTYwbEx1UHBwakhobzQ1VmE0clNV?=
 =?utf-8?B?VXZWWWJWQndJQzUveEN4bW12OGRHN2FzRWduYjRnb2JFUnU5eXQ2TWRmOUg3?=
 =?utf-8?B?c1dEVmdacnZQeUlwd08zbDh5U0ZrTjgvMnpvZ2xFd0EyUTVUL1d2UVFMcy9I?=
 =?utf-8?B?QjkvWk05alZnUWJCVzlyaTU2QjZnK2k2Vno2Vi9zbmNMWVA0eHhpdmRYRk45?=
 =?utf-8?B?RUU3K3l1dnJTSGRZODMzeW9jdTZieTBsZ0tBa09reVRoZjhzTWwzVTRaeklC?=
 =?utf-8?B?SmxJRmRXRlpsSDhidlhmSTEwUjIrYlFoQVBDUXFHN0xKaTFnaFIxV2NpaUE0?=
 =?utf-8?B?aGNRcHVhSzZNalh4Zm9zVVZUdHdCVDdmVDE0UEFGK1h4VnJjSWxTOVVTOEE2?=
 =?utf-8?B?QWRKS2ZuV2Rjem9NTGRaUXhpZzJGTHlocVdkSmluVXRXZGYwN2Q0NnlmLzl0?=
 =?utf-8?B?ZmxNSElOYWE0N3BWSG4zOHF5VzlSczZydXVWWDZiS0VJU09LU1h5T3ovbERJ?=
 =?utf-8?B?cG1oVHRnVXR2WW1KcVNlL0Z4dXlmS1NuREdpWjI5VE8rcUQxdVpMR3NPeTJw?=
 =?utf-8?B?WExLaklMcnBtbzJ1Q1NTSkJBSEg3OFh5UU1FNVB4NElYQmtEUG9CZDVxaFd1?=
 =?utf-8?B?U2I4OWh3em1sbnJOV0hKLzJUUzZnTTgwU25LbkREWWlEOFQrd2RWb0dyeGt1?=
 =?utf-8?B?V2VGbGttMTFDRnhWVGJaRzVXSEhsdTJQWGNncnJ4N0p0UVNPVlhaajJieXlU?=
 =?utf-8?B?VkJ5aU9LQmsveEg3QjdkSlpVcWV3bEpjL2lIZVZ6ZWRCbElJSGt2dnFEeEhH?=
 =?utf-8?B?YVRhS29ldnQxaVU1SC9ydFN4bjYwV1NTZmRnbkRyRXhHdmFLNzlkRHA1RmlM?=
 =?utf-8?B?Mk9WSzZIa3EybHBpRXB5c291Ti9GL3FLRjB0OUgzL3AvTWZuSjF1bzE4V3k0?=
 =?utf-8?B?b3I4b0xZS2dKaTIyZFBGNDFPT25maG8vMnlSSDV2K0xnUVRFb2FOL3oyckFZ?=
 =?utf-8?B?Rnd2WVlNQUlLVWlpc2FFVnZaaUhLVVE5cDdEZUJSekZlTEU4U21STUtFc2Jl?=
 =?utf-8?B?RVZHL0d0R0tEVjZ6NXlaczdPWHo5T24xNDRxYjcvdEVxUzBoajR0SE1HNktC?=
 =?utf-8?B?V0RyWTNtelRQM3NMTldSRGNJeFRWOTVOSFhJN0d6dGtLblQxNXN4alJ3ZEZa?=
 =?utf-8?B?NFhZUTJNZ2pubU5CZThELzNtOFlBOEhqWHZDUWh3TWd6aGhmZEFibGtHeTBk?=
 =?utf-8?B?akVuZmIvb3FGbGlWK2d2M09sUEtzR1RwbEdPdHh6YXo0OE5hOUZxeE45NG9m?=
 =?utf-8?B?SVFYQWIvc29KNDdrNWlLaXFvTVFlcnFYSnFMb2pwRkhzY0Vla3E4MWovNUFs?=
 =?utf-8?B?V3FMOFNlNmRjRUdhZGJEa04xZXhUOGExUGEwbThZbXo0bjdEdDQ4NU1YQ0Ew?=
 =?utf-8?B?Qm0xNjUzTEtQY0R5emV6QXAzZ1ZVZnNYWGRLTFV5enlabVM4WExNZHpPWjUy?=
 =?utf-8?B?aHFzcnZyREdqdVZRTmY1bzhicGVqL2NYQTZMU3MvcDQ2L2VBMEVDMGNwdUhU?=
 =?utf-8?B?SW1vMSt6YkwwcEgxZVNUNzRkdHlJSHU1dkVqWTFjc2MvY1pub0MyNXlpSkRX?=
 =?utf-8?B?aW9BcWFqUU1CUkp1NFo4bnpBWlorSFZ4RjZvMTdpaDhBRmJyNE9pT1VKbndY?=
 =?utf-8?B?RG95Y1FQVDI3M0E0S2oxczBHQTZJcEorbnBkejBVZkY0by8yRWZSOXJGdjBj?=
 =?utf-8?B?L3c9PQ==?=
X-Microsoft-Antispam-Message-Info: 9Acq9ppiZTtZ8euuijgRYdRyoe12xm+AsDWAjw4bTIM9a3/ws6cntXGHUgxaIEEWv6I+cVTT3goYnO5BeEv76FL5lB2cfuuiVoXXPnlUoM1kbJRqVMRJDT0X9pxhvzvezzgpsI9CC96qPeNe4wHgKlaSW4XkpZT6ZhTbrEpKVkCnli4/cTGrmVqUjyNliREX
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;6:qTW9MApHE1duYssQvkLIs9UN/9Ig8pd/mjQv7Cijv0lUa9zlDLvrqm780SmTcTCKTB5sQc5SOSqXq7OmMtOEVESViCaKDdywZOX6+jdSXHu9xAJOkFrYgN/RVTsg24CqJKJ1NipZcC61N2BKNX2FwzD3DfKwv1ftzmnpcl9pMZ0pQZMIjcNKjJeX8b5dDlCbE89nELdjxSBTwtSMXjY1UVfvWaXIX+2jSPOuOoBD0MVenA0EW3MJSUPxjdO5TLztYF6qdvKV+NrqNSN94G96CgJmfjmHkbsOTLDXJesmAZwJc3KerZcuZUM5QkptLirahxmwsJnNhiL2MGUJkeF61eZVDgvTfkTFEJe0EDfJEZFibMJUl/7ZXi6tRAuYObdipuHIkJaIdGDLBGGG+tJ9HYC9sHQn0NvuwkZ4RvqCRUZF+vblmNC/zDeVxmbBm1EAYon6+uh+GFcMqls8FBZoRg==;5:F579Cjv9ShUZDMhsM3vXfh6eH4eTT25sv3D6ueL6gkz/fFqh9XApTe4Fm83n0X64aEEbKY3ykCWbECWsVueMx0LfQICyYpXoUiXpd2bYlIZolweMhaGtSjY08Ww+oHoXULcURa6Je8MrJuOSHasLSyr1rpBIvSQ+nHgIyh4z0MQ=;24:+H+TCAffvFFarBwkfuindGmzpFllSfOnNic8qFkrsYxKYA7cKnpgNiSFS3/HOQLPIxOLn1iBEvSKn10UE3NxAT2/+NtEscib0+uBy0Ts8gk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;7:kGwJtsT2I1ypP1LqE1RmRtz4BdZvkZd/27i4Bts5Me2VRAgQuIH1jTII0rh12fzyWtR3qC4DDiFm8j6fsZAe/skDmUmzTBIU/kiX5HeS44PjzGOBRaF2dtNZHc5x610qIgZKOVEV3V5q8+zNmK5nZlN67ghldurdpwL5Q/PP1KYibVLi154dFV4muaIWdD754LxJ66IZ9yFrwIGLgOMA2EVROFPvLU+wEe+8cqgxTRgK4DfCrHnAjqq1fxVjdWMR;20:gIn/VSyAZN+Nv5fZfUUdP+IDc32FswmaVm26nLrHaCdlVFrlnSfMqGVp09wchplwITk0zJpuw2sXOT21JqfnNgZxMQUvHsLlgzT8KrgSDTs1MJJ2/yOqRKS9yeXsqdIUrRexRC0ygujJv6LThbx/XWI2C3iVaCMQesWO3IdpU/VDlw73qMja5JKn4319LPgHtGYq1dMb+iK6vB2rT45N1WIwRWCLfveI6TGXEQRj/ZarbxOU5cYJLjB6T+zjif/Z
X-MS-Office365-Filtering-Correlation-Id: af4ef28b-46c4-45ac-1817-08d5b1a722ad
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 10:09:32.0651 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af4ef28b-46c4-45ac-1817-08d5b1a722ad
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2355
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/4/2018 3:36 PM, Rafael J. Wysocki wrote:
> On Friday, May 4, 2018 10:34:44 AM CEST Akshu Agrawal wrote:
>> AMD SoC exposes clock for general purpose use. The clock registration
>> is done in clk-st driver. The MMIO mapping are passed on to the
>> clock driver for accessing the registers.
>> The misc clock handler will create MMIO mappings to access the
>> clock registers and enable the clock driver to expose the clock
>> for use of drivers which will connect to it.
>>
>> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
>> ---
>> v2: Submitted with dependent patch, removed unneeded kfree for devm_kzalloc
> 
> Well, where's patch [1/2]?
> 

It's here:
https://patchwork.kernel.org/patch/10380207/

Regards,
Akshu
> Thanks,
> Rafael
> 
