Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751349AbeEDKY2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 06:24:28 -0400
Received: from mail-bl2nam02on0081.outbound.protection.outlook.com ([104.47.38.81]:6496
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751301AbeEDKYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 06:24:22 -0400
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
From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Message-ID: <882655ee-994a-1aaa-8efc-9e33fb3d7eff@amd.com>
Date: Fri, 4 May 2018 15:53:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iERzne0WNsEPVKN_PT1vwNfyqpoE_YiF33RmqLMryvhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MAXPR0101CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::16) To MW2PR12MB2362.namprd12.prod.outlook.com
 (2603:10b6:907:7::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:MW2PR12MB2362;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2362;3:gyIHSY6q8QHi6M/M6hQMuFEGAuBYLIaHYRyoZLMvVkDGChc225sINIruGcpxNS5QbBswwb4hZ2DorJR4gcEPMMvFO0anmfK3ILnfuGFaR8w3I7++nIf0MVsmiZDfS85OfpcvBzlImYXSObN8f4nj34XlQLowk4pWw2GN1lMP7qVjX/X+Y1isEcjZpI3cWWXy5jMkTZxj9h1ad3p+8qP/l7chvRZ0s/Y2hS5XgrRujZPC+5RkXvf+5Fx8s1d4wRbA;25:yclmZzcLZIl+9mw1tAYXb+zYXKaqP20FwtCPtmJSRkeDo/4tOSUQVQlnQJI2Y+nQadOcc50+2hh75OIlNVFzexZ83fbBbEFwnhoLJOqf2rbH8bMCHITSlGzezMatPIKl/Bl5D2n4/PKFRfhKhpTlhFz0p8KWn5uK1X1RwKb7ST5VexqgUqq3PFeqJsRGi2MwH/JOS5XqK9C9ndfIqY/L0kCY5qdPLRDw6VLK7fZNHONgQhUm5pZYOLOVaNKRFvjDafCLbYOnf7zkeUR8HkescQ7rMd4jy6VddjjIyHohBLxgvpg2HEMGPmjZi5rhvzuomWwC9lKhjrkCjoKRfVpT2g==;31:60zO3HqjNT9itdEVsp9qT1484h48CJcoR/qUUJuFtOBrjL9vp5/A7dYzZmEeGg77L1Pz4/kl0M2J40ECyonsHc2ZF6p6dGn7n6hJ7SAxqgBeY4KPcsHjYIgbFbhbNbflhqdZA0mXYkNpPzNdf7/tylXntoOc+48ag9jWqmse2DqJTNM94P1tk/laDTnzVmrG9VwSbxM8s3U0MRvJl+SX0hiMjE/cfRUEJ+Wmx1VdpH8=
X-MS-TrafficTypeDiagnostic: MW2PR12MB2362:
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2362;20:Fu8lmEber+f4W+NfoHcvcM8a7UQAgda4UAs/sDtpP2wWRwz7e4Q0zwWgGyceBtJvgtt7y/EVgo+0mV7sgYLn8bNgTCQkzCbWBTbnDo9eHvluClz0QoC59xUntdRxL6T5thGEpJFURJuupmaHqoMzhI1GGRfgYPUIuv6W6qEahKPYsQKgJs2d+ZsHmDAgNZXTsrlCtXKdU9SlHgXz56KelNduI5iqtdRyX1yGYDEMF5d7zheVaDZ8SNHLofkSP1TnCDtYpf62XZ2i2k24V+aA6Wh6+gYal3N+lx/3XHEnjKsSGq6aew0SKxZs6DZZQQB8tNqrYubqUnr5x3VQzaG7ojnFY7FdH3uAyn0ZCOzTSs0MeDzBHNtoIAG+VVXM1RxPccX5fdCwFoXsPQvUJIz5QvKwi6NCXNLpGFK+X7pKOyD5gl/FWzKBF3/FotscaB/nvkEMimpGrYYsxB2xeSPswJK5SCp3Ur/7+djLyTId0P2fQ1zX5Wand3hgAn63WIRq;4:OTf6dQD1AiliTFNOwRPwz32iy8Ov5p/6IJpipnzIp/g3h23A8/49/ficHC4ONWX1omA7iMxEjAG25E/gFtgSNmz+wC2WTxcluv0dJ9cRzMYJfg5wLkIPwljvRQwd95hLA1z1f7QVKa84wr0FM0cIqGr2mi5mxrQhv1iRIDCInvxvo3bSUBvrw6Bl1AZa8wktqh/26bA7xQ96oh2gzLyjyGPCHMYfbL0fcuv5IBSOb6cFX2tZI9k9Fqi5gfSZUNh666PIcmCYZN0YFkJkh0CCam4J26aES/HZT7pMqkjmRDys8MgOqCmgLXKA8Kc45TiFct53InekEL/0Jts3c4JGNQ==
X-Microsoft-Antispam-PRVS: <MW2PR12MB236271F0C36AAB75CD10ADA0F8860@MW2PR12MB2362.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(21532816269658);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:MW2PR12MB2362;BCL:0;PCL:0;RULEID:;SRVR:MW2PR12MB2362;
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(376002)(396003)(39380400002)(346002)(366004)(43544003)(189003)(199004)(51444003)(305945005)(53936002)(2486003)(476003)(6306002)(76176011)(6666003)(106356001)(386003)(59450400001)(25786009)(58126008)(6246003)(54906003)(478600001)(53546011)(16526019)(26005)(105586002)(52146003)(31686004)(68736007)(52116002)(3260700006)(93886005)(16576012)(77096007)(229853002)(230700001)(5660300001)(186003)(23676004)(956004)(2616005)(65826007)(36756003)(6916009)(6486002)(50466002)(86362001)(316002)(6346003)(7736002)(2906002)(65806001)(81156014)(4326008)(81166006)(966005)(446003)(66066001)(65956001)(47776003)(8676002)(11346002)(8936002)(64126003)(72206003)(486006)(97736004)(3846002)(31696002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR12MB2362;H:[10.136.128.133];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNVzJQUjEyTUIyMzYyOzIzOlhyZ0EwRUsxbFFKMlpjVmxMaWg5RlRLd0Qx?=
 =?utf-8?B?WTU4R2pjbU9KMSs2amNqdi9xMGkzWmx0YjY1R1BpYkJROTdrSjhJN2Uvdk5Z?=
 =?utf-8?B?T0JpS3FwVUxIbWFzQjFCQ2wxTmJ4K2hWTTN0WUIvRGYzMEZIbTFkekJsK3p4?=
 =?utf-8?B?ZkV3a3hham5SdGp0b0tFSlREWlA5a1BWMVQxUURzTlMxaWowckR5L1lrV3hh?=
 =?utf-8?B?cXlRVnM1VW1lcnV6RlFncysvYmdrQTVrYmVXeVNjT2p6ZWVNU0pGYVZMTFZL?=
 =?utf-8?B?Z1N6RFFoYU96T0FJNHFmR011RVkrZFRpb09nTHNYczRWWlJteTlIZE0rRmlP?=
 =?utf-8?B?SjBTTDRqcWNZczBoeVpJUHpzaWt6RHB0MUNVcUFPT1pkZnVCa1orUWxRZ2Y2?=
 =?utf-8?B?WEduMlAzY3RHWVltUUl3b3EwL2Q2QnNIN0E3RFBuR1BvWld1WGtCdEJWTzBi?=
 =?utf-8?B?ME0vdHM2QU9Za2szRkg5ZWx3azRJRWZRV0tZL29VMmJBSDMxSFowTWQvZmRj?=
 =?utf-8?B?bGV4cnB3emkwZGpqZ1ZrU0QvdEZpakl6TVBZQ3JmYTF1a3ltYnJGOG5rRWMx?=
 =?utf-8?B?bDAyM0VIZWRGTE04YUYxbGVkR1VJbVZvRy90NlFucFp5bkxWN1B5WmZXS1py?=
 =?utf-8?B?c281QlU2UmcrTHZ5OXNGemZOQWRJbkVNZVAzajNGVVRJOUdVc2o0VDdaU1Vt?=
 =?utf-8?B?ekVNWGpDbld5cTNyTmVsSkpRQzBxWEFXQW5NYndiaE5Ham1LZzVoeERFcXkx?=
 =?utf-8?B?YkJhRGpmbS9aVldacko5QXFqdEk3aUxMYU9qcWs4eldDclhSdHF4bTBieG0v?=
 =?utf-8?B?RU1oZlYvSnQ0ck1GK3gweC95dzdKRUFNUE03YUVtRmd4YW4vdTJpTDhPN1Mz?=
 =?utf-8?B?UmJ0QUhaUllKeGV6R3B0emMwN3Nya29WaVg2NlpzMzFrTzZNNURlZWx0bEhh?=
 =?utf-8?B?VXhyZTJYTEJxdmhwcnpWZnpxRnVhQmQ3czFnLzJoWXRFN1V5bjE5T2VITnZn?=
 =?utf-8?B?Zzhod1poYUVTaVNoTEhzTjN0cWFEL2trWGhCMlJ3V3d5TCtNb2pvTlY1bmpq?=
 =?utf-8?B?VWg1WTBvMVhrV1hvL0FuS2hnY0t1M00zSTFzVkttVW9vSW9hRkJGR1hBUXR2?=
 =?utf-8?B?SDMySTFYblU1QzI4dUMvbGgzdFozMkpqQ212NUFLbnNRa3hCRG5DTENZUm50?=
 =?utf-8?B?NVU4U1FGNEdReFZqbFo5UzJhZFJ4NExPc0NMTXFmZXBqTjBmemNrbUFHNDND?=
 =?utf-8?B?T1crdUQ3ZVlTdGhrVHlVYkdrck9SUThla1ZDSEwvQ1d2VHFEb0VIR1VzRUht?=
 =?utf-8?B?ZFJIekJGSG8xdWdRSTRGM2JMMFFqdWVqcFJlQnBRZUpQcXdMZDBCWSt6cWp4?=
 =?utf-8?B?UTMxc1FoMVU5R2J6elhNMGNnZjB6ejVwODErY0NvQWR0QTBuTGRDK3RDd0dH?=
 =?utf-8?B?ZmJSZUY0d3pUYjc2REszdlR5NG5JMit3WlQ1RXNZT0FiV1RkeTNPazJGTXFE?=
 =?utf-8?B?ZEswa0lFTDlSYmhuOVZpQUFKNkRIUllIVjFXMjUrcmUrU1VkR0J1OXhTL2s4?=
 =?utf-8?B?R3oyV1doOVZQRlo3aWpyd3Irc2xWNjBmM3B4RE8wMktZd21tNDdzNG02dHNV?=
 =?utf-8?B?VUF0R0xVL0JnR00xT2pkNkdqek82Y2Y4cEJ2NEdvTnJtaWxCVm0rMDV5blBh?=
 =?utf-8?B?OWZCNjhxSmJWdGFGU1dvUTBla0tXKzFPMWMvODB5Y2tWZ2pmMHRucklqNlFL?=
 =?utf-8?B?SW1JdCtjVFdSc2JRUjFoVzZkQkJPRjE4RFRsVWtEWVNQUXdKQituY0Z6OXd3?=
 =?utf-8?B?VXBUWXFqZEJtOGE1YXJFZ1EyaWh3UVhyZkhwOC8zZXlXa3kwRmJlV3JkUGNz?=
 =?utf-8?B?aldCWkVIS3hLU1ZGWXBuYmVJVG9TcVBhbE9ra1R6TEU0b1V3dGxHVmdPWStl?=
 =?utf-8?B?MUREQVJlbFVMQU4xb01KNGEzTy82TDE0cGhZTVRoKzVwZVRHK3I5Z1ZEc3FJ?=
 =?utf-8?B?WG1BS2lBV3NDbTNkTVdtOFNpMHZ1NG5XdW5Fa3loOHh2ODdNa05rZ3BnYkd2?=
 =?utf-8?B?U0FLUjhYbXlEeFJLYWVkVjdlZlkxMWkvaDIvQUkxQUNCeWRvZzJWeENJekNm?=
 =?utf-8?B?YVNQcm5VUitYalVMbURQSGI4Y3dmcFpuL1RuWFF5RWMzU0xKaytCdTdFUmd1?=
 =?utf-8?Q?KRHmkuA+tCB17Va0PMl4s1mVyBWYcB/H1DJcO8AQSc=3D?=
X-Microsoft-Antispam-Message-Info: o2VLW1/o+zUHLaWsYOVtB68ysP7sptA20U71f3w1uIZaxslwrpFM8b/y200c3UMXMtKWaUCa4enfh6SKw5u3nSE9Hdrp58Nu+Wvqqq8F7QSlmKu3t22+Sl2Rlb/tmUl2lSh+5uDaTWMeGzHexyx++TFMnS/Z81+iK8tWp+WVlFHoLaIcvxObbhcj4/CvVfnB
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2362;6:H/PovlIe+NU2ojYCKO8nEvgq+zetihPZzNR7GTIsGIBLw+pCucSKtBJMk4S7sjnVp0dT+TglrstJuAZVXEKz2YeuJtKO3HDlZAGkDZvBBeRa8Jmfqvvez+jxg3X/7HxtXtS7IQAGUtELBueEVMOjj8eg0HnGC2lm3WGU35ZI2PU7lofSVUIvABN1DW/xNIJn+ilXz0XmWqRqPbcNbSMjIMbztXBO8DBZsBhufgYS4FFhD5s8wptRWpOR1N+EEJ4pMzJ7sbvTQBHbce+WmCxJCmOJiyZ6ilXfYo0EUT+UxDBpQXOswKYpqeqoKIBBtRxpdHSf6VZs9/67IFObm3iwGQJOFExca7rLgAOLgOT4ZbtGOFXP7YKynASnnNsEiYcqmG9w5+wNBASers+5edm0bx2j1Ago6KE2TgR5UUrikAFVoPK4+aMsv0EH02gn5+I5bE03H88PwAq/ptfRp06bKQ==;5:9qBpIjQQzldwyOh4aOUnm0YvPr4iNBgW4wNvynVSmikvVo7mI/OSjxtdigJXPn/aC3yqNwqbAznxwevbCTIvncbP76tMpSS/ER2wiCSkh62YZoEgvzfYqcLsIgC18knqxRJSh4QrIEAxd8Yqb/umbLF+ezQz6zTwDpicXtUsjOM=;24:mzBkq2ADCT8vVAuncNcntLU/077q1tqIwX42eYRIbGU6qsxDvFKKGNvXHvbFp1Rce0SuopitZ6fCePMuSf+ZdPo7M6+2tj7Nc3lk8gT/YK0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2362;7:oBwbRJTrKvOSJ8h2WWHzLeCYaLjYsHQQANM/jS4TicN7BSx1NDSw+AXbml96QnwUouiqOgj9FO2lUm+ffuFWGtAVRA0i+ywcSrIYxIcyVR/YDW1Z6BZOzkSHIUZuTFGqOImb1+WLNheTDeKZZpzS5CEkxUmo6jchvPhbk3tXl4Z6TztDnG3j2LQqDTlb3MJJmHXqc9xsJrs2SlFQK2S1TxsEO9OPfHtyRS6IboM1qtncHy71buUEw27t3c+HlboC;20:W8qAJX6RDie6mByoBifRaVUJMGMKxAgUk48tcCupnhaHzQNf9Ys700lq5ZxCqgW/i3GS/UYicVkFJPCBuZRUNhQ/WW38gs5tskWRBW0If5lxh4/OLmpKdPKKVTqGmE4NOI42VDaa0nzkNiSkf4XEQoDgXEwnlgO/zJENqHs2/OvqMetVNfKxyb0xN9fvC8YLCAqZFJCxZgkQOp+Pa9iuv/9aqsIiEEalWeUwVkcP3QVukRXKMLrx1puyrGcHyicr
X-MS-Office365-Filtering-Correlation-Id: 1ff23454-4433-40bb-80f9-08d5b1a932c8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 10:24:18.2852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff23454-4433-40bb-80f9-08d5b1a932c8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2362
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/4/2018 3:45 PM, Rafael J. Wysocki wrote:
> On Fri, May 4, 2018 at 12:09 PM, Agrawal, Akshu <Akshu.Agrawal@amd.com> wrote:
>>
>>
>> On 5/4/2018 3:36 PM, Rafael J. Wysocki wrote:
>>> On Friday, May 4, 2018 10:34:44 AM CEST Akshu Agrawal wrote:
>>>> AMD SoC exposes clock for general purpose use. The clock registration
>>>> is done in clk-st driver. The MMIO mapping are passed on to the
>>>> clock driver for accessing the registers.
>>>> The misc clock handler will create MMIO mappings to access the
>>>> clock registers and enable the clock driver to expose the clock
>>>> for use of drivers which will connect to it.
>>>>
>>>> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
>>>> ---
>>>> v2: Submitted with dependent patch, removed unneeded kfree for devm_kzalloc
>>>
>>> Well, where's patch [1/2]?
>>>
>>
>> It's here:
>> https://patchwork.kernel.org/patch/10380207/
> 
> So can you please send them both as a series with the same CC list,
> add all of the relevant maintainers to that CC list and indicate whom
> you expect to take care of these patches?
> 

Ok sure, I will send both the patches to combined cc list from
./scripts/get_maintainer.pl for each patch.

Regards,
Akshu
> I think that they should go in together as they are clearly related to
> each other.
> 
> Thanks,
> Rafael
> 
