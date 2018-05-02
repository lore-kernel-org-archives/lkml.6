Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751192AbeEBKQK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 06:16:10 -0400
Received: from mail-dm3nam03on0075.outbound.protection.outlook.com ([104.47.41.75]:32064
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750936AbeEBKQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 06:16:05 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Subject: Re: [PATCH] gpio: zynq: Setup chip->base based on alias ID
To: Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robherring2@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <6ee982f8eb6e07f9ecbb0cc5093152f4a16b9c31.1523454899.git.michal.simek@xilinx.com>
 <CACRpkdbOa+AvhQT1RCWA_zQuTpp4qfNjZBFDOKLdaFqMGAe+cw@mail.gmail.com>
 <f9dd4f64-4026-f495-5810-32affb5b0944@xilinx.com>
 <CACRpkdaxwRc0zoDKogVGisXTPJ0EwLbOQjHzz1pSEjvWCsSCTQ@mail.gmail.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <cc8d864a-e8e6-d30d-ae54-91819e5d0b8d@xilinx.com>
Date: Wed, 2 May 2018 12:15:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdaxwRc0zoDKogVGisXTPJ0EwLbOQjHzz1pSEjvWCsSCTQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(346002)(39380400002)(2980300002)(438002)(199004)(189003)(36756003)(36386004)(54906003)(110136005)(58126008)(478600001)(2906002)(356003)(31686004)(44832011)(86362001)(76176011)(93886005)(77096007)(53546011)(2486003)(23676004)(63266004)(305945005)(230700001)(65826007)(6246003)(47776003)(336012)(39060400002)(81166006)(8676002)(81156014)(31696002)(26005)(446003)(4326008)(9786002)(106002)(5660300001)(476003)(65956001)(186003)(65806001)(8936002)(316002)(106466001)(126002)(11346002)(486006)(50466002)(426003)(2616005)(6666003)(229853002)(64126003)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1675;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT007;1:3yMY0oItyhvJVu+zLXHB9wMRkl94IUYRRl2nJpEPr06xYqPKJXu72sZRZWC1fxEAg5lCkxICr/hUT17q9ApMljCXfLSiHoQqVk4hY/LW9z9pn6fN9v6Lt14KI5/Mv/PS
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY1PR02MB1675;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1675;3:mCYixeEnVPHDQDdr+f9CK6aPaQ9bPHrF7H8IFSbftCJK0tMLPzGHnX++LYuVQMKIMDTUrMEbElX4u64A4B4kX5bE/koBzMuMgi1xtF4Ak6Fy3sKzKO5O0Q0OVK6HTOgYapcxuqAxZUllPE4ESdZ68eYMrjdHcJzqR7ztE3R6M9KWdeN5yBeRJ/DKgPVLOPOSshPa70P2Ao0xcRjED8AaYcHxqxZ6XQ1ObaKr3cNW7jhbG5aBqoEUqWarW59o/1M/729gCemcA1WyDOmjHm0LtjeJFcyNzHgUpXQllSm15P78j8SvFkH8sxkwEhOboBVyfCmHpdTlnyWh5pVz0LuvbiQrEPurQHHsZhzyPJhmXOM=;25:jOz5kJuR3RlQ0fSqr5fWY/F6RhwDwxmEg+055Tc5LInsT3XEqce40H3+QP5LqWmm8fC0zXmTM8xhKOWFgCG6NrsPsiw0Fd69l8R5J+YAXERRgHFxyyY1d3/Z1e4tP94Awh7nJ2mIvAHRfRxz+fVGPtJ6RZwWg/zQ1juZMmNIuvs88vswGgl8gCT364MBxTOX/GkgrDreiHRExPJZc2EJilvTBV4pl/P4aDCHrhlU5PL4jIfNfOsF2lsl0aM7SNGU0YO0kpJjILIMjl4BM0lncXzPe/rLC4RKjgRJnUy3nVSljIdlpwhNGF7ngSoZ1P6Nn1zgXR9zS4dXfLujn/u2wQ==
X-MS-TrafficTypeDiagnostic: CY1PR02MB1675:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1675;31:uVSMOPYGVGjPi7XPE20ZmUEWLc/dii0Oz+ybydhc4Fk51Fm87wO1TRH28egbXgwNub/TTiZQk02thFN66U8jfGbvIwZ8uvcBxAp+RaQ0Jutstocr12nuBmMKhOkQGMBVmHFtV/mb3lfMBYratH1FuIDuF6W5WXdPg1IZOe7orZwJbjx0dO+ARGY8fIjbnDaLypmgdMEKMD/HpJuguOFDUFKUS8C6Sy0B6TgxNWfdRmY=;20:nF1AELu2kRfqWXQ956+DBdyYdiNycJsAcA5UrMgi3jjD+DpRr7PmZQW6CWvx8VL3hunDsWj0Ge10pgIrmOwTmrCNuHzPL7y4B+OF9x8+wPu2ywhJyJ/qav/Z5s9JIzvXxCMvel4FmPD7sbwhCafEgdgCASdLMNRxdSMkeQIa0VKyjOPGr3LFjIV+6QJW4eWevJ5bXI/xiFgYnHVNPLPGy/jb6bhsrWnoc5hfwJlCYZV7HMuo/0M/BF8NhXxjQwtMcp//CiAuwouMwz3i6JlFo8JA9TEFfZCnOdii8lrbtbQmjIBBGWk1mgAVYqy3249Fm74bb6+trjJX7PFOFUa16yeRgu5tTTS4MmxCoDeAgdKbEdHgo2de9pdHdycaUzqxwD7dvbbOY2IYjNFaOFP/rTaxh06DQt/MgTsymgZ+g9JgBiNYZsgM5FRCZkUCVmzBCKn7OV0udiWSq9NPUxDwiJrhKQe9zPXR7wRQFaFM4fIbNFmDmDpPZ3ijo2Ldyo/U
X-Microsoft-Antispam-PRVS: <CY1PR02MB1675A2556C1745E2436FC2D8E2800@CY1PR02MB1675.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(278428928389397)(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:CY1PR02MB1675;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1675;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1675;4:SMzd4HGLza4+JjUoj+3XsNMCBlDJZgTwLV9Q/2/BTK+fP9wBWyioIHl0CCdy/h7ZVDHFOpJYMZp9/PcKGoZ2cwnyvr0Sb1vfc3SHJwyK+PFlbY3FA7vPgnz3GdkgR7fmjbgq4W4HfCZeuIPwnuwn/4hOjC9Saocg5ATyklaT6W7/u8yRKcn4PT2rWx7F7ZgMk8ap/0vJd+YQViRt3jJ13gNPH8n373W5Hy72LacYnWDVpRnZLLhGED0depffzjy8iOi8FgpJ1TMsL5s5YHX3GF/YU+Oc6GiqUDGpTDtNq7RDZMF4XvmbL+g8agPI8xvver5fLp51n7NtmvKY4SFXh+U5DiqOlXfR3bjrJ0mt3MI=
X-Forefront-PRVS: 06607E485E
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjAyTUIxNjc1OzIzOmNGbis5cmx1bXpSNDEwVURoNkdmTzlwOWJH?=
 =?utf-8?B?QzJMUXNBVmlOZktpeW9QbVM4YXFmYWRSMHJnZEJIcGpqWVBQcXN2NFpiT3RI?=
 =?utf-8?B?czlVWTRNdjFDdHV6NFBxbDFOMzdIQW5MRlRwWWphaXlObVpZUDFmcnNQZzh3?=
 =?utf-8?B?SGp0bVJqQzIyRGNiZVJlQzVXbFptQmF1SmpSVjZRVzV2SXlnWEJYNGFsS2Jo?=
 =?utf-8?B?T01yaWFSbS9xTW1CZTdlL0lKMkF2ZXNqTHpLQzd5ZDhhVkc0TmhBY0M5Sk9S?=
 =?utf-8?B?M1JxZzAwV2pRN2Q2Y0N2VkFaOVFSRnkvQ2RMZjAvbFcrWlFKVElVenorL3lx?=
 =?utf-8?B?MHR5aXF6ZUp2ZmZDTEEwa1FTb0c5Zm8zcDA1dFUrUVV4dlYvazM3NHV5NE9v?=
 =?utf-8?B?dTB2WlhDbFRBZnlNTm5GZTdVdHhMTmNlUWtWbGU2d2R4d3M5Qk0wODVTeVh5?=
 =?utf-8?B?Mms4Q25NNTYxcVF0S0YveVJOdkJLQlJubFlzZVZYVzJrcTJaR0l4Skt3TExy?=
 =?utf-8?B?Z0lZN0liQUNsVkdzZHJ2M0w5VmhCZkRvRXNDc3hpYzFZV1lOUHA5bzNDRkd4?=
 =?utf-8?B?em9sOWhtZFFhNlNpN3NiZ2xGTi9heTRHek10ZUxVd1FpSDVRZ2wzQ0RPUnJt?=
 =?utf-8?B?SnlFQmlQRXlBREYvc0d4bElSTWRBWnZOMUdPSXYyQ0JmNmRxWDRLRXJrNE9T?=
 =?utf-8?B?VFVtQjgvUEdLRHNUb1FiMXpRK0l3YVZ2V3Z1WlIwa0RGWmQxV3o5a0YxVVBL?=
 =?utf-8?B?NmR5SExFVVZnVWNiRi82KzFCY3k4Tm1rRlVvNHBtMHhoaDNaa2V5VkJEQWVX?=
 =?utf-8?B?MnRWLytxbnR2aUNyWlZhZVViRVJ3ZjJOeGZ0d01mNzRSNk1XTGxDdVM5bGVX?=
 =?utf-8?B?dmRtSjAzRnpXd3VwRlFldXZpTnNZdzYvamlpQ2hYbGgyaXhEQ3BzUjBkY2lR?=
 =?utf-8?B?UG5uOFJVaGNHQVpXMUQzYVRqK3lSYlpZalFCSVBnYjVLZWdGM2oxSGljQ3Br?=
 =?utf-8?B?YUpwTUVnRnFlNWJpdCtvczY0eWd0SzIrNncrUlJTWGpBTTA2TWxwU3phcVU1?=
 =?utf-8?B?U0dzcmlpbUo5dGdpNTZYTjZrcExSWHYrMkhLcTAxOTRXYUVicXRLQmNJenBm?=
 =?utf-8?B?QXMweGhHaFFHUEQwZm1WbWdOOUtJV1lZdWl6SnhuUWo1TUpMdjk1bHFPMFM5?=
 =?utf-8?B?TG5KeVM2WVdOWlc3aWloNWRVRzBzbWk3bTJmUXR6bG94WXE5b1llY003NHU5?=
 =?utf-8?B?ektEeHhwMU9LaGdweWM3ZzROK2UyWGFDTERpblFUbTh6NEU0aXNoZUsyb0cz?=
 =?utf-8?B?NERiTktDdlZGLzErREF3bGdpNGxVTGhyeG5sMFYzN05CajUrR3JqTUdwVXBW?=
 =?utf-8?B?UUpLN0tyRXk2K2JQOXY4NFFheWFTcTJ5Um9veGZTYVVxbFZHR00vSFdoeGJv?=
 =?utf-8?B?dEJXTjVIL09HWnVUUGV1VE42aVFsL2Y4WUFvYUZmU2pDY0doMnQ3VTdqbWlF?=
 =?utf-8?B?Rjdnd0xWdUYwa1ZTbk1PU1BjSHB4Q3BMSTFJWjhKWkNjV0NpMUtDd1NJWFRV?=
 =?utf-8?B?SGZnWXBLcEhlaFdudlA1RGVDNVRyR2NvVGlvS052azF5UVQxODQzdlJIcXht?=
 =?utf-8?B?UW9GMFZ4SnZpdzd4b29nRExyL0pZN1JLRGZ3V2x1Y2FRdGh3M3V3U3NYSXAx?=
 =?utf-8?B?VjFiVVh4V0JRYVg4dFNndno4S0g0RG03ckdoK3k3Q3hXQnBQYUFZM01USkRU?=
 =?utf-8?B?djA2NTZIR0RwNCthcFJqSUppV1dibjdodVdxWEhCd3l4bkt3NkZ2QkY3b3FS?=
 =?utf-8?B?blJUUTR0bnVCNEtOTzlrUUp3Y2hLNVNvVFNQUzN2YXZSN3BvUHFJa0Nsb3BL?=
 =?utf-8?Q?G2MoA4oDv9RqB6FCO0P6iTK/IDspPrjc?=
X-Microsoft-Antispam-Message-Info: nqJnlGPjQd6p/+u3gBPy89wTNVKOSnvjQ5A4RPH25O/sYzYVuWDB9JIOJ+0QT/+ueOktvgJ/aIby/oFCvit+0NKBLD0jN9/6M1mWvtOzkk4lEg8cPgfz4uvWqtpxy+sT8c6s2WrHfZuy5hRr+vmaHVGWHM307fuIJQF+CoiFIIw5ZFvHJqgIqrEjMkgESSmI
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1675;6:+XzQMv0kVs8RGL4hPf7j8juLnMcwZkl5pHQ+MHqfyfYzkaCASB1zaOQQJpr2TAvx0W1vBlPZ3M4NzOocfuVQZn9dShMccY6+pSE4NZPzhU4kTuG76LaMqAcdc20Ke2X5dmlvU+uO/nuaaqYtJe21hw34c/+DV5b/AAUexdWeGxWYCGRnKJb8VoZLK4RNLhzdYpyEnHiWTC81hgG6AdKVA2US4HBQwXJ+aVnNp1YLvhddWwvRFP0PSLL4EvyuK2HQ4U3OG36rCXt4A5RB0yNnKCR9IQ9iyOUjtWRhvEilzCZxJPWEL0QIwpY5YvRAOCTuHR0Xg0Y/ploMbkNwXIXCbzgcaCUzFM1mXWaz8xkTIJu7jax3NsRHmFLoRAVdiuTA+s6AO1OvNvUOPuk9Zo8lvuBM+dckcolsFPieQXBONazKdH/5DohChJnzru+IMk4MXMP4RYJI4oDo+RIqVFsa1g==;5:ovw39SbOjvTSJyxcsZ9gFbn3hPC/pqU2Un2HRE7DmplrTib4di97RRVES49RDN4Y+cePDVPnekkZuml/6cmEoEwBxL6SHkwC4+d6QWyi3GaBpyXzRANuKtCdjOR8aPdIfHd6nf0BK1M7KbH+wE6QrONVRTjwq6hv5GFFau3vPlk=;24:E6t2MbdV/Wq7L1mexZRqsOR1n6WS89J0Y6j9d8nDGprM6n+wL12ZQr2bxhGNvXGMAWVHqcsW6QIC88lBDTHYF42UT/O3VwMiTIH35bmC+Ts=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1675;7:sFwv5hYpS50awNH4tWYc+CKGxNULLCdOhjRfb/XXom0SSFqbdfIblnZWNr79dP69YqHb0WafimpR03lxa8gs4RBxWO63EEHKV+MfImIDCjrQ1hfwqQU7yMRHK/3GjtQM/gzZsc9sPy8bOPG7ZhZSBQoyMSk0IQxMTdFCBDk3ahIQ1aXN4RXFSeI+wwBvjLqxHKYV4cXwWGmUartBAWfo16AAbBGpUwbO+VblVIUFLrn062GLQAQpbYVVcDlDohvy
X-MS-Office365-Filtering-Correlation-Id: f5e13970-53e7-4252-5ca9-08d5b015b526
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2018 10:16:01.9972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e13970-53e7-4252-5ca9-08d5b015b526
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1675
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.5.2018 12:10, Linus Walleij wrote:
> On Thu, Apr 26, 2018 at 3:35 PM, Michal Simek <michal.simek@xilinx.com> wrote:
> 
>>> The only use case which I can think about is userspace sysfs
>>> and then I would really like to know why these userspace
>>> users cannot use the character device that is nowadays
>>> supported by libgpiod and there is even patches for some
>>> IoT libraries to use it. The character device makes the
>>> GPIO Linux "base" irrelevant for userspace.
>>>
>>> GPIO sysfs is deprecated and moved to the obsolete ABI.
>>>
>>> If there are legacy applications that use this I would have
>>> to consider it, but since this has been -1 since the driver
>>> was merged I find that unlikely.
>>
>> Yes, it is about legacy application which I have seen recently and there
>> is no source code for application calls it because board vendor doesn't
>> provide it.
>>
>> You are right that -1 was used from the beginning in mainline but
>> unfortunately this driver was in vendor tree for a while and it uses 0
>> there.
>>
>> In upstreaming this was changed to -1 but customers have a lot of code
>> which developed against vendor tree and they want to use
>> latest&greatest. And without this they are not able to run that
>> applications.
>>
>> I found that this logic is already in 5 drivers in mainline that's why I
>> send this patch to be +1.
> 
> I see.
> 
> Sadly comaptibility with out-of-tree driver code is none of our
> (community) business.
> 
> We do pay a lot of effort not to break the ABI to userspace, but
> it needs to be an ABI coming from the mainline kernel, not from
> a vendor tree.
> 
> So to the mainline kernel this is no regression.

I understand your statement. On the other hand it is feature which was
permitted in past for some drivers and this is +1.

Thanks,
Michal
