Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751851AbeEDRMS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:12:18 -0400
Received: from mail-by2nam01on0048.outbound.protection.outlook.com ([104.47.34.48]:25472
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751511AbeEDRMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:12:14 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
Subject: Re: [PATCH v2 2/2] ACPI: APD: Add AMD misc clock handler support
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Alex Deucher <Alexander.Deucher@amd.com>, Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1525422930-27826-1-git-send-email-akshu.agrawal@amd.com>
 <1525422930-27826-2-git-send-email-akshu.agrawal@amd.com>
 <3734664.7VekyYX7C7@aspire.rjw.lan>
 <0afd036f-9526-f5c8-4bd6-87d145319370@amd.com>
 <CAJZ5v0iERzne0WNsEPVKN_PT1vwNfyqpoE_YiF33RmqLMryvhw@mail.gmail.com>
 <882655ee-994a-1aaa-8efc-9e33fb3d7eff@amd.com>
 <CAJZ5v0hHoyv0LaZrnm2eVfsEEr0OJiJYC=qQpPd0wnGWRuNvGg@mail.gmail.com>
From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Message-ID: <632199db-468e-7785-4652-8fbc3b547ff0@amd.com>
Date: Fri, 4 May 2018 22:41:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hHoyv0LaZrnm2eVfsEEr0OJiJYC=qQpPd0wnGWRuNvGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [125.21.194.1]
X-ClientProxiedBy: MAXPR0101CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::11) To DM5PR12MB2357.namprd12.prod.outlook.com
 (2603:10b6:4:b4::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2357;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2357;3:Ctwhnea5nMsIkDoBg6b0numCW3i4OeSJNkQFJU45bzAPK4vVXaEmqpmxUQc4fW1ef13W2SY21c4OyDqNT71vqFL30DWvlvO+/F4qNDLLh6DB9kxgCOEq4fpQDdsbClyhcvamoHY82fG74KlL+j0cN3CYo6sx4uDhd9iTFHSOl2J1dT5Zh9XviUkjwcfAE7Xxj6cCsN9PHoKvkDWCOqAisjSC3eKwCF59a7r482vQ7YJovK6QqOBE/Brut5q+jIA8;25:MM0gkHShS5laOJobrog6+z+xA15nrAt1Z0qBigiHp3EM7crBmN9wKkwgqFgNVzxKPKI70a1KCHNxtC0w16zAUXOq5gfK6WXp6TXXswfZeT5xEkUa4NJfJm7ft/iHFgeC+1cUU8HlE05OFw5i36JhtiC7hsMJ1qRiEunLjNBNXltTbl87Yyo4AvFCT0kUaZ1Be5U3UujbD5Ibsj1sEPIU5l6LDJzm+NHsjaQHVg7MxeG3X9s7jTy2Pd8utTNDvm4AZm9xJeq6Ueh4yAmFX7GRGbzlNkN/ZnI7BYTb0a/eAr0RRwkiXRVPYt69KZqxraqvReo32stS1ABQfcqhsJb1dQ==;31:DXtAfg0q/m8BNwQ0JGaBpfUY8gu+QVLoyFdogJaC+54Ru1yG/B4XcOP5T68n1UR94X4SWHOlB8AmGDJCah6pa+gCHm+RSDJQdAm6kJLIs1u13LB6i6s0yrGLHIPjXJBfIvRTn961I3Ba5VlvSm6bN3rV1ZJVfGJQiBiBde3LyvDjvhkrqTA3uFGINyavskaVAn32WzCvstYEeB8m1Rx66jtVfPMCw6T7ZM8qQVjPXqw=
X-MS-TrafficTypeDiagnostic: DM5PR12MB2357:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2357;20:s8dtCcq84rIb0kt0B5314JNjNxxaOwdB+Le+cvP0jAaMhZg6U1Wp5Y7t2StsLlKkRoFzkDkFJvO6pUx3wCZoqmxPiFMlWCYGrR8ne9ugYevKgHd+oHvQuU9PdC8TKsrQecXKBvXCw7b+H3KqRcWBU1elLfAwHHgqgdjH6kkFnfUpanugyfoaauTmy72NDwBC/BKohn18lNFLBUmvAXCC5CdrLQkpn7RTqaG/oDQ4ytDnPNpKF82r0kZrfq9NkZDogcB3shNdHrCuD5+4s6SuWs9XoY4sn8mx3fE7f4oYROrhw4Zyie4rUIq2mH713MShscZpDhUCn2/FDfztQs+0S08kFSPWcu7JhQzcV1Ev0cp5LE1DX9uEMDecL03/Xq3N+5xHo5/XMopds2ZETu1ALNL5U3vqE1/BmLCY+6Pak5yByCTy+11e8hu7B7HwEAq6etmqYd9Wg6Tcy/r0Oj2WUEgKF8bxwhm7fUq/KHScO7CGFGvu+i9bQ8OJu68nLKhd;4:1pcniwUQsSP5O0eGru60quBRXKc5hCwQhRuMS69G5lOs/FiEOTLTnLM9MgX4FEV3My8XVPATYTPlIp/GhDTFSAe+sYZZCMyqKI6Z2DQSCteQoHWxugprkYn3drz/SNRn5c74FjCa96gFy8Yk4/QfkssJCermzfNAbbFuJD4DdAl0gjvDFp/6Ic2a6FWxu1mqdym3Rz6s/HGDbAZfm5ZwwedzlE7BgB3tBJxAdza+JsD0OTo0hzC22xSOaqTeTANz0e6Ke+rmJa7YWVi0A+MQnowEbYafjwCvxV17xwOyapyLumDW/7QacignfoHmg0YasHOOHiU2ht0W1TaicMOQzQ==
X-Microsoft-Antispam-PRVS: <DM5PR12MB2357F968AE7713D1BF154B4FF8860@DM5PR12MB2357.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(21532816269658);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR12MB2357;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2357;
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(39860400002)(366004)(39380400002)(376002)(346002)(199004)(189003)(43544003)(316002)(65956001)(16576012)(58126008)(54906003)(7736002)(486006)(72206003)(305945005)(478600001)(3260700006)(36756003)(25786009)(966005)(3846002)(47776003)(6116002)(50466002)(16526019)(8676002)(66066001)(6916009)(93886005)(31686004)(5660300001)(186003)(6666003)(65806001)(8936002)(81156014)(81166006)(64126003)(476003)(229853002)(956004)(11346002)(65826007)(446003)(97736004)(6246003)(106356001)(86362001)(52116002)(77096007)(2906002)(68736007)(2616005)(4326008)(23676004)(2486003)(52146003)(105586002)(53936002)(76176011)(6306002)(59450400001)(31696002)(53546011)(6486002)(386003)(26005)(230700001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2357;H:[10.224.116.199];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIyMzU3OzIzOktCWXFpSmpnQW0zL3FxM3pCVUFrVjQxeEdm?=
 =?utf-8?B?QkxCYkh1NCtmZVpHZmRIa0p2VExLcUJYb2xrR2krMTZyZ2tmdGRKQS9ybXNR?=
 =?utf-8?B?M3dNaUY2bjdLOW9jUXkwcHNMcDZvcmNMcUltbERkUEVFc0NZbXVmNWFvVEcr?=
 =?utf-8?B?enNYOWhJN0JZUTZnbHpUMElMTThiVkUrV1N0ek4vUXdUenhrOXF0SU9MWDlh?=
 =?utf-8?B?L3RtVG9vNGRXUzA0cVRkVE4xbzgzbmNyWTNORldaTDZRN0RtUHM3RVpVb3dK?=
 =?utf-8?B?QTYvR0YxbE5LKzR0WVdoV2tmbk1qdHhDMWxzZnFlQXB2Q0VQWHdWbk5uL1BV?=
 =?utf-8?B?QzdqMENSVHg5NTZmR3dVQm1JbElMSll2YnRmR2hUSys4bm1rdHhncTl0dnkv?=
 =?utf-8?B?MkRQWDhmV2VrVWE3RnZXRjdSaUNpNHRxVXB3a000UkxqanR5MHJEd29welU0?=
 =?utf-8?B?UkFNcEw0WnhXclNzSlN3YkFaUnJLL2plbThETkZBd3h1M2hyNzdnQTlQYnhD?=
 =?utf-8?B?SThmZEVpVVVoWGsxai9BWVBNSUFUWnVIM3JXQXJycGhPZzFSbGJwWG51d1dQ?=
 =?utf-8?B?ZWFUQzRqdkFQcFFGWGNrd2RpUzdndVFuNjFQc2xxZ1FENHhFdmg5SnBzNWRP?=
 =?utf-8?B?MDVFbC82djVlK3M3N3JxcTF1bVVTN2FkeVBCODh1Y2hRLzQzUVcrSDRUdkc2?=
 =?utf-8?B?aTVNU0xmVkZLTS9JQXV5TW9rdVc3L0ljSEQ4MWR3b0MwU0JoY2ljdVlyUXV4?=
 =?utf-8?B?ckF6cW1iOEl6UnZ1WVppWC9Cci9uckFzZjNFenBMWHh4UGk4c3Z1VG9nYzA5?=
 =?utf-8?B?a1ZVN2Y5bXlWZUhUZ2R0SDJpeUhCVkRkbDNFT1VYS1BhMjFDbndDZWtlK3BK?=
 =?utf-8?B?aWJmUndjTVlaSTNBaTdoT3EwR1FkUzZ4L2tabXdOcnBZWWVodmkvVXhYRDMy?=
 =?utf-8?B?amdNZnEweGt0d25pUjQ2T3FpMFlJSlhxQWQwNTlsUmMyc0hhRVZ3NTFWM1JL?=
 =?utf-8?B?WmJxY21lVCs2UXRsbHpudGhpVmh6R0l4Y05waXNGcjg2eWhRVSs5RWQ1NkU1?=
 =?utf-8?B?eDk0UDg0bC9SSXdvMkRNS2NuRUE2RitjRWpidHBIRDdHclcwRjM2dkdtek4y?=
 =?utf-8?B?UFRUdkU3bG5WVGtBdDU2MVZHcjJ6NGRUR1FRLzVmbHV4OW9pQ0FZcjlpc0J3?=
 =?utf-8?B?YmRwWkV2TGZmdTUxR2VlOTRuWldCTFFaSVhDYWtJVGw4MURCSGtoaUVWdm05?=
 =?utf-8?B?NXE2NUEvcnJhNmtGUnZwUGsrblo4N1BEcVNKMU9vcFNta0hFK1hpRHRwVS9P?=
 =?utf-8?B?V2I2ZlRpUVFjWlY1cVJYZnpDM2l6ZWE4djduWlRheG9UbVMxVW5BVjVEV1I4?=
 =?utf-8?B?djlTMnloQ21odFhoZ1BhWFgxOTJyQ0d4OUtmRWJNMy80K3ExdE96NjY3dXJK?=
 =?utf-8?B?SGZtS0tOQk9SVmdsbUg1WTVBSkVwNXlOSGx2VEpMQlVEaVlnSkFJNFQxQlZ0?=
 =?utf-8?B?enVvckJsS285SmtrKzZBMytRS2QwQjJXYVVLR2owdnBjWlpBSUpMQ1hpeVRa?=
 =?utf-8?B?emtLdktkVlUvVTFHcEMxRnA0OEhOb0FSaEVVeXhPclRyL3RMZzRHTXR2L3Uy?=
 =?utf-8?B?RGtrcGFHRkxjc0thRDRjY3JvbUpxbThvYk55T1dIa25iZGFxdWQvemJwTk5L?=
 =?utf-8?B?OWJvY2dNNllIRE5jYUVnS2xHL1cwU09LSWQxZVNURUlURndqdGZzd1RSZ2cw?=
 =?utf-8?B?MzFaVDY5VENoellYSEJxbGJDNDh2SkVqT0RUN1hnRHpEMVc4NE9qU2gzYk81?=
 =?utf-8?B?V3B3MCthUVJoSzNlN3VuaVYwYlhmcy83dDhVeGZUL3VNWVNLU0p0cVhPWXpU?=
 =?utf-8?B?LzNRMjY2WUUxMkJud3liNHJoU08rUllRQ3VhMkowNVdZNzlEUkxIZEoyUGZs?=
 =?utf-8?B?WU1wN2RVL0pOVHV2TlVGT2tMQkZVWXJncnhSVkxzYkIvWmNuSGF6dnhCdFFX?=
 =?utf-8?B?WitTVnErTU1hMlBXT2ZCcG5TTXRUQzZ5akFXeTQ0UW5QT3A0NmpWTEUvQ3Nw?=
 =?utf-8?B?SHdxTWE4SjBUbXg3VnU5dUJHaG5nRnowbTFzYjFNVDRKQ2kydnRxR1Y3Z2c0?=
 =?utf-8?Q?2QZejYQTt22OIEKNGj4DcWoiJyTWcZEUdfWWIJDM9mqF?=
X-Microsoft-Antispam-Message-Info: WSsteYUREJQ3Yb2Slk5NE7wt3Qp2vYLOjISQ7d1rgWOdyO4wCVU2iuuvaYMDKisz6Nw7k+PlHHIAJsn+CX9QBC1lxr10zml4zNvHQN3vsHfIgNq1TJ/6XCwrKbKpBBjbMbYQIEQHFwOSoTb9RRDP4Xn56txNLggGCNNEVV1mwgrXetN9O7TOa6xA0H5jtEfF
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2357;6:BAisGgicWqlEs9XL5MbTtx/7QYjHFaXuc+cI7a1azrgNH4TqPgDXKAI6nOCkDyAmfaBTqPgbN0pxbUFtfzGf7rwGIwh7r2yAWbMQWq/xptZhfFGu74J3z2fmE7+y1otUrgt30wxgRJjBTsjT6dsYN8N53IwpKDYgwL3wEB0ZIGkKskRNELVIKExmOCXNMSLyK738uSY5hijrbof0+pidno2Q8BS8lR4NeIFykSqubdPbfUqu/apoauvHxrcQYezVAsoHc+42OjH1ZXnYB0ecJDMhrSh0DDHSdOwpnT7F3D7POvqEsiukVU9QBmUbYCalYQ/H/Vaad+s2Ci8DLya3kHom+aAFGVXSnPm4M7Un2N5JfmxnVAINrWS4daHe+oh6ZD4A8x/T9GQ0btKrv5FsAYiWkNZtN4zQRq+qm30LNpqUrO4qVEg6GMfaC1U0aRbMjgtkIHt0KgRArOwA68vQSQ==;5:G78v2+Q0RsQbKzbiMKIOkXz1VT5UUZPMRsPTSfDAIN4HaqQE3IAcpEgvNEtVlxiB6bloib9QPc/0oBP2xcvALmX8oxBxveynv+/l5cpU5JI/LImJdgDEj+lJ7ZqMLQNWa/dzPkdghHhR3eQtfzCDLUL5dQpQJc8Cgpg5Tl/Mtek=;24:n/DleUFQeVlGUu6EyGPO8qH8FycaBiwLPa43pdJRQERzA8a9xHro0XLSlrhSjQjhrpPIGWm6glSPoa6mbeONxCooB/m7b+Hci+7/r6zJPjw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2357;7:jTABmJRpVu9fMOlHUTlm1aru4XFHzYgI5ri9AFsaDMHU+uMw0tNnkWVvz6Zs71YbZ2jbMVYuzLHvLjmEgSA/zSRLGOHi7YmDzkoTL+iSxeS1j8HXWUTuejNILms7y7vkaQmxYneXjPol06P3tikCMYlmezn/s2g3+bt712Gr1iBWUo73e47WrkzjHumzmesQuaVOhSjawKNz0kS2NUL58tE9171xnmODWvsEMpXkZBrYLhjiWBMvHjzB3Wj+IybO;20:FVaR7/zyskPngYYd9TqA5QPS0TZvy/nCYHjq8uF/UtRCwBIVMdE6nrebtd86j7O3IWBwMZYd1X3HsQVcwZjqrqzhIN7pieozHCxzuFYexhJFFEuAmBwfzWpLgDM/r763a5a+hTGXU7KgwOMfD+mugNxa+jQTkhW4usbGhc4W5Dn9JT3vP4gbeh2Bzn4hevjFcwInVe7nQnyT69oq1/C6MogikoKqGW8guy/XzHJ9zgLAEpoloMw5v2I7x6qDx67P
X-MS-Office365-Filtering-Correlation-Id: 3643b9c3-4610-44d4-5aae-08d5b1e22cbc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 17:12:08.7497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3643b9c3-4610-44d4-5aae-08d5b1e22cbc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2357
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/4/2018 4:37 PM, Rafael J. Wysocki wrote:
> On Fri, May 4, 2018 at 12:23 PM, Agrawal, Akshu <Akshu.Agrawal@amd.com> wrote:
>>
>>
>> On 5/4/2018 3:45 PM, Rafael J. Wysocki wrote:
>>> On Fri, May 4, 2018 at 12:09 PM, Agrawal, Akshu <Akshu.Agrawal@amd.com> wrote:
>>>>
>>>>
>>>> On 5/4/2018 3:36 PM, Rafael J. Wysocki wrote:
>>>>> On Friday, May 4, 2018 10:34:44 AM CEST Akshu Agrawal wrote:
>>>>>> AMD SoC exposes clock for general purpose use. The clock registration
>>>>>> is done in clk-st driver. The MMIO mapping are passed on to the
>>>>>> clock driver for accessing the registers.
>>>>>> The misc clock handler will create MMIO mappings to access the
>>>>>> clock registers and enable the clock driver to expose the clock
>>>>>> for use of drivers which will connect to it.
>>>>>>
>>>>>> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
>>>>>> ---
>>>>>> v2: Submitted with dependent patch, removed unneeded kfree for devm_kzalloc
>>>>>
>>>>> Well, where's patch [1/2]?
>>>>>
>>>>
>>>> It's here:
>>>> https://patchwork.kernel.org/patch/10380207/
>>>
>>> So can you please send them both as a series with the same CC list,
>>> add all of the relevant maintainers to that CC list and indicate whom
>>> you expect to take care of these patches?
>>>
>>
>> Ok sure, I will send both the patches to combined cc list from
>> ./scripts/get_maintainer.pl for each patch.
> 
> It also would be good to add a cover letter with an outline of all of
> the changes together.
>
Done. I have sent the patches to combined mailing list, with a
supporting cover letter.

Regards,
Akshu
