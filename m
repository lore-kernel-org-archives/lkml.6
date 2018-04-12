Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753392AbeDLQzX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 12:55:23 -0400
Received: from mail-ve1eur01on0046.outbound.protection.outlook.com ([104.47.1.46]:21120
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752846AbeDLQzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 12:55:20 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com;
Subject: Re: [PATCH 0/5] for-linux/sndif: add explicit back and front
 synchronization
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>, konrad.wilk@oracle.com,
        tiwai@suse.de
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, jgross@suse.com
References: <20180412160102.15833-1-oleksandr_andrushchenko@epam.com>
 <d5ede3f5-200e-f1c7-71f4-4ebfb938ca48@gmail.com>
 <43348cf5-d2f8-9d7d-0390-2273eef8f67d@oracle.com>
From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Message-ID: <db3ee9fb-d0ab-5f17-a1ec-7bb8ec5cf75f@epam.com>
Date: Thu, 12 Apr 2018 19:55:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <43348cf5-d2f8-9d7d-0390-2273eef8f67d@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [178.94.34.246]
X-ClientProxiedBy: VI1PR0602CA0015.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::25) To HE1PR0301MB1946.eurprd03.prod.outlook.com
 (2603:10a6:3:e::14)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0301MB1946;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0301MB1946;3:FGB0I1HQ99Am7OuEQ35fhCYW6Wu8mQURv0Xzje5skDegSL+iUGWjOWppvcCKJ6iuqYRlFM/JzCYC+WHebYDor+sbOTwTrHZliYnaStld8JSk++pW7b6AklC9Z1B528Es05n/nRPkiFFEW73513IofvnzCBL5Ba7OGIgNHSKoneEzeXMfoB9HhpxvFxLeopDThgKYNAKZFJymBEZTgeULlzqQI+95lvROjwYrYjfP6tP1otwrUq8TMwPZckVqPRo2;25:J5EfUoOMc4WmFysgwIHLrmlr4FFO6nwiXS23+2WrLQ1cMucHNnOyukZxWQwGD9grsTh2bip7aHlQ/6sSE6VTfv1gjvgTeagdP4TC5KwZG0u+5fh0Fr2xS8zpIN5/Z8pKlVjOY5eHS8BuX0Gx8jHJL+x0yhox2opzk6RMVATNYDq6Ybe4ZLQbppeumX4s9SJvdjDCkSAFkCpCPJ4CM6+D8ZjLnyGRzZX9SdJnwON5Oat2ZQAyR3XtwW/JGkAviIHnH4gWWjvwiWm+W55HJHBNLpx2Gr7jiGO98PxWC60bXxhgejk0gYkB10/BdwlwxaiMnOq1YN2NpJ9YeQ6zj1pxIw==;31:pq4/meny9qZYNqWkZw5mNcgZIQNa8tSoV7vb99by9vRF0yFOlU3irLOVO8T+DZC/rKmnUiTzgLvm35leFJx7AcIA3k6+sL6Tuh/MH1guoeAF75G2i738JoXiE/QZD6bT9giPByMRFnjMe0UYQ3/TXJGhuWeBAFXa6WLcYs5wEXyCTbqdWbcPEBeoZvs7k1qErnW0Gr+F7cvvLddnrxoHNhGKBxYF1dW9bTHJ2rJqJn0=
X-MS-TrafficTypeDiagnostic: HE1PR0301MB1946:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0301MB1946;20:vreZeLHQmUE8RCd9U9vGxlod4HTdYnkN8NX087WuWvNhgIFDkMV+x+I9zrNormG7Vi+os/tt+jsjIsHvx5s+41UoPYjd4lfOZ9HDNzephrcupWWUPtcRuu/imV7aTXs0MTSyZZdy1Lq9tCg1amuhKVRPXB8rj8frzjoFmv5KckVQJI8nuLeMrLXNJq2Mb8FjGvzvVCQDG/p3G7tINrXugpZFG2FQQuBsWW6O5YbkVTfdrWIPP6S8T7+GwDJZ0rC4ffKEwbTx3MrsPRA0kZcCm6wS6NrwMoNNNSWRQaBuQduoNwVTr83BgD47PqvCr7ASnEP/UevPfGVp0eIeo3bn8i18RNATZelpLWVtiPz06qhD3+RbeS4I6CK/dWe299SyakNfMdSD2zvAdzshjofyMXzi9X1CIB/c/J43anP4O2bzdBS3nNDTeqrLOV81QuUGMPoh+5O7ZmumU3UsboOHAkojDVaJ3hyfwOhhwrYKGoaB8r7JGUpdAsrxBN1h/GrL;4:4DjajFcIH2X5F5mhQ2AGljBa3N5qX0GalpqMwZ5zVGpRcooyAzeBgDp4ciyI31KfUSy8ZzlmdGDQECTsALkJj/glMxqLosWqCYXHGNNSDvFXNulzrkFPgW8YGnfoMsr3/60xyefKB0m2dhOO0HD7r7D01ax+08pr8f45J+/W0K0H3CBam1ov9bLTNbre6vf8BRsRnCj2YbgbuhK7kSRQg7uY55Zeh7Z2OUgFaWzcAOh+1RmY+m0sEyifeRCoTWoVEFEKAu6EVqqxIFOCiH+ruA==
X-Microsoft-Antispam-PRVS: <HE1PR0301MB1946147E6426B50A905D06DFE7BC0@HE1PR0301MB1946.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR0301MB1946;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0301MB1946;
X-Forefront-PRVS: 06400060E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(346002)(39380400002)(396003)(39860400002)(366004)(189003)(199004)(186003)(478600001)(26005)(77096007)(50466002)(72206003)(68736007)(106356001)(65956001)(66066001)(31686004)(105586002)(65806001)(316002)(52146003)(25786009)(36756003)(486006)(386003)(476003)(59450400001)(80792005)(2486003)(16576012)(23676004)(52116002)(67846002)(6486002)(16526019)(64126003)(58126008)(446003)(2906002)(53546011)(76176011)(11346002)(97736004)(2616005)(6116002)(39060400002)(3846002)(229853002)(81166006)(956004)(117156002)(7736002)(6246003)(6666003)(81156014)(65826007)(8676002)(31696002)(305945005)(5660300001)(53936002)(230700001)(86362001)(47776003)(8936002)(110136005)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0301MB1946;H:[192.168.0.20];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAzMDFNQjE5NDY7MjM6VytvblFlK2pwNjVGSXNuTklVS1U0WU1s?=
 =?utf-8?B?S3hrMDJGcFV3UHV3cVBWOEhUUHl2WE1DdWdJMWd1S1VvWUJDWDRUK1pZdzB1?=
 =?utf-8?B?bERJekdmTXhYWXNQa1M0Sy9WOU5naEFpcGlGYVp2NTBoa0FkN0JmMjhzVVhu?=
 =?utf-8?B?b1ZmdFRWcjdrZWhzT1NaRWpBeGNoQjRYNU9ZUlBYWTc1VWdXOGkyb0M4aysz?=
 =?utf-8?B?RjhQTEN6VFZyUzgwRnJnVTBzSGthbXR5OGZ5cUE5UTJqcjFkcXdnME5Yb25Z?=
 =?utf-8?B?VmQrc1VGbzN0bGExeG4xc0cxckFneDdJck1aUWRkeGFJUEduQTljU2xHQUR1?=
 =?utf-8?B?d3RReVNCV0h3aDVITlJQbEpkUTVaSkZMK25VTXhjSndvanJtWGJia0V3ODFT?=
 =?utf-8?B?RjZMMUxIQ3lJT0h3N243dHRNTUpnZks0cUtQaENCSkpHWUJiUWlXVGFmRUd2?=
 =?utf-8?B?YlNObmZ1MGw2YUt1a21ld1ZVaGhQZWEzOTlFTDBGd21WU0x1aVF5eHBvbTlH?=
 =?utf-8?B?OW0yR0NDZ1RkaUJpZzU4aGNyL1NoaGlNdHNTcStyLzhEekZkanV1NDI4Z0hN?=
 =?utf-8?B?KzlqU3RNS0Q1OHNVTGZBOVhWbEQrTG8wR21JZ3J2SHlXaXN6M0pSbnl1YnhO?=
 =?utf-8?B?NE1GNEV4dVpmblcvaGNZVEZpS3BpNGVyN09KL0pIS29rRUpDT0Jkbm1lenJa?=
 =?utf-8?B?akp0T25FdERDMXZBaXN0OUoyS0x1Y2VhclVPMmE3V0dHakpueEN2OFRRYStm?=
 =?utf-8?B?ZTJWRDBpZ283THdzUVpOczZHaUFVcGJIc3ZOUVhFdko2YVBWckhBaTBFL2Vv?=
 =?utf-8?B?endxc2pZWk4zVmxTcGhkZVg3WVdDMXhHUVE0SWFVTzkxazF4dys5K2FIbjVy?=
 =?utf-8?B?MFRBZ3kxTkxYV3FEWndhcW05bmRuaU5tMUlQUzR0RVdIUmxhMkFDT09SaGlH?=
 =?utf-8?B?akN2YWRveFR2NjVibkMyaUg2eTNhRzZ5bXVDYkJ2dWkreVVndjUvUWg5SG0x?=
 =?utf-8?B?eXJPT0pUbkVQUjl6ZWN4U3N3bzZwNkpsNGVpci9jcnJzRzIyYXV6L3ZOamti?=
 =?utf-8?B?dGY2TnFIYmV3YkhidVRsWVJ6RUtxRlhRUGQya0VBSmtZYXkyMWxRNU5aNm9o?=
 =?utf-8?B?ZFRGTDdDQ0Zpam9qc2lhTkFpeG5PdnhCQWR2YlMvbXM5RDdUdTUxc21CWU5p?=
 =?utf-8?B?d0xBSVRYRkJ3REdnRklDN0twYmI3eE9aWldZL0ozR2xiYVczRkpzMTBwck04?=
 =?utf-8?B?djA5OE1Vak8zS1haVVVreU92MWhZYm9PakcrRFQ4SnZDUkpJQWNIY09uMTZQ?=
 =?utf-8?B?M0NrbXJSekFneXRMWlpSZHNLQUV5N1dTaDVMK0ErVmZoTUQxV3k0MU15MVl6?=
 =?utf-8?B?MEw1TjJtcysyUUFzVHV5VzhKY0p1U0Y0dzN3T2xFV1ZSdTAxTitjVTdIYjlM?=
 =?utf-8?B?dWI1TVUyUVFQUGhYaWhLNERtNHgrQWxDOXViT3FmbEJlWmJBejA2Nkt0RGlU?=
 =?utf-8?B?SHhPVlRJNmlqeis1cUJxeUFRNjJ1ZVRLMVcySFhiMVJXMDNQekx6Qjd3RGc4?=
 =?utf-8?B?Znd3eVZXdk5kWFlHWmNtclg0WmRQdDU3cE95alVOZmJvcW9pT3g3MWN4SkJY?=
 =?utf-8?B?aTFRY2J4YzBOek5rWENYWnk3SUpSSXJ5K0drVlJKK2ppQ3BnNStEYUNlM0xO?=
 =?utf-8?B?VUcyblFNcEFVS3kzcUZ0b05XQ25jeXZkbUxJL2UvYVNRRVhOWkJ0UGIwTkl4?=
 =?utf-8?B?Vm5ucmJrZ284aExsTmlOMVNCMHFCVEwvREFrZkt5VENpbUJlS1NEMzRjOU5J?=
 =?utf-8?B?LzJ0MjdzZ3dkNWZrUytoK01Wbklac0Z3c01rV1pTQ05OcFBIKzJtczdDeEU1?=
 =?utf-8?B?eFhNWGtuVHlvQ0xyb3pYMG5BZE5xTDhUTytoYUthbENzbnpVZ1JRT2NzTmRP?=
 =?utf-8?B?cGpyTWw4SWRMb0Zta1hUQWdkNGVKcXBSandHdGUrdlZEQW9LTGtoRHAxcFdl?=
 =?utf-8?B?QkphNkl4ajIwRUVDczJDbHQ1MHZPY0NkTEhlME5peDh0Mk12Qjg1eDlFMHdW?=
 =?utf-8?B?cERrMDJzZGVXMS9yNnI1SFBrUUtta3krTWFkODdPTS9aZFFSN014YkhrNjlu?=
 =?utf-8?B?VEEwQT09?=
X-Microsoft-Antispam-Message-Info: Je3PBGRiwg3zjHlFiIJU2TZ0fGSTU0Fc7LP86W7iuj7vPPJsq0Sgbzi4VtLVo53hs7f6Kd1ifcpfLAnowHShUBq/HLpaJHRIzHRknhStwilVHMfj898lZN+0IPPIpxxuQLEQvZh/KL7NwWHQgBpgnBiBEwUypQDNQqB0RHxpsPJgKEhMnIPZ+ZQo/s1hWhGx
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0301MB1946;6:KjRwLOHImtu4gEannegcWtaI3AeihobJvQNlmQKnUD7uEidEG8ngAOGJ5/PtJVKMvvxCsmPXSKoIhel/Gx+v0OcRW/GjfvxMuT8iyOq7UUeY4/xfYn9Z1sDkafBTFUDlDviJmhb391edMoFmcuWZuk+N87aakt5PlXLLAJHLrV42wNtsRVG2RnxOc73zMNyi8hsZKs3BvpyQTvKBwMmJBLK1tsqw5z9Y2tnZtCffNk/NYzpqVw0GV0zh2/yEwLwND/uzrA0uKHMOfSdreNGdUXhd6eEN4K4bxWanR4VEFM4R5cSp+hW5vHx0gSexYtZOo8cIjcY79Tx2XUWl2ioEIKrCYoRRGe7DPk0m86uH2d4iGwFDZ8DcgFHaUdJEozdu20P5N0J6yU2j98TcJ7f46Zg3lI3L1WbDR+gC3c72N6J3Bdr6F5vwFTvHssag0FxBAoWXriP6e3aYyyV/BecyWg==;5:bCEl1AtNxpADhgHIXjRQimiT5wmP7Li9TYswAOwMOCNQgFstMRiM2/PYw2sm7It4kbGhprZJh3vUIxX4IGTz2Z222DoPwvJL96bw3L/UA9vyCeedS91oZcuurc53ynZHEuXrmbU0VzHF9caNa/puIG3mJRd6k1DM0hGEGfcNCXY=;24:uh1RjsiqfQ4fq4x8oxK9oOcQN0j6MBBAhkwpENT13exfB4yUXDR9IoeKqu8uV5SktPGuooFY2kH4lA4wcyOKI8U6OY0mpwDBimD8wg52xVM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0301MB1946;7:Gyyi79P8U2Q7zPpslMKVWjIn0jaq7J+CChd04NPAT1TBAO60VwcpBIUkgHzME0/atI4RrkUsDNxYcVhRa6Yk4sPuJnAUK0I2ffPaTJF782T0jk1bqV7grs7+ZpT2LrGQYEOYtzeDsjQOhGK/+QXUE7WHMCqMmgFAHRy+fYZOk/qN6m8/dzqOjfZUGKyK2sIPGisBFVpLaKzbnqdCxHnDXMwtZkoGGVsYKr60ZOtU9m0P2cBf+aTh6MnJIuPAbhDi
X-MS-Office365-Filtering-Correlation-Id: 9baacc0c-a707-49fc-3962-08d5a0962ada
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2018 16:55:15.8838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9baacc0c-a707-49fc-3962-08d5a0962ada
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB1946
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2018 07:55 PM, Boris Ostrovsky wrote:
> On 04/12/2018 12:11 PM, Oleksandr Andrushchenko wrote:
>> Hello, Konrad, Takashi!
>>
>> Could you please review the *Linux Kernel* version of the changes?
>> As I said in the cover letter below there is no functional changes
>> comparing to the corresponding Xen version, but spaces to tabs.
>> Still, formally, I have to drop the R-b tags and request for the new
>> review.
> Is there any reason why this all can't be done in a single patch?
Just to preserve the history of the changes?
> This is just syncing up with the canonical definition in Xen.
Do you want me to squash and resend?
> -boris
>
>
Thank you,
Oleksandr
