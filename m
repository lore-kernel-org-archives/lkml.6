Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751873AbeCNPZG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:25:06 -0400
Received: from mail-co1nam03on0086.outbound.protection.outlook.com ([104.47.40.86]:39155
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751758AbeCNPZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:25:02 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH v2 1/5] iommu/amd - Add debugfs support
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <152055660594.63229.5131049527614494130.stgit@sosxen2.amd.com>
 <152055664720.63229.16209149030018336339.stgit@sosxen2.amd.com>
 <CAHp75VdK6qFopBE4rD4yNO5GHccxyte=GhYU7YGcWOEYSCyX8Q@mail.gmail.com>
 <30bd9559-0e44-bd18-6b9a-ec35bc8276f3@amd.com>
 <CAHp75VeySPBEeJKRXzmqfPey56J3rwr2-dPRzSYx+7a7TAC5rw@mail.gmail.com>
From: Gary R Hook <gary.hook@amd.com>
Message-ID: <08d19301-7e8e-7586-8ffb-91823af0d31b@amd.com>
Date: Wed, 14 Mar 2018 10:24:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeySPBEeJKRXzmqfPey56J3rwr2-dPRzSYx+7a7TAC5rw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR14CA0026.namprd14.prod.outlook.com
 (2603:10b6:404:13f::12) To SN1PR12MB0702.namprd12.prod.outlook.com
 (2a01:111:e400:c42a::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ec7468f-76c9-48a1-986b-08d589bfc00e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0702;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0702;3:PfrL0Q5mBg2Xf4dqyDWnE75jEzAfkTX03u8GsOO5XPKDkSZ69MDBtKwdE/cStLO3Y2+WDMdqg3rGop4NYrvJj0eeDNZupBI5XF4NSiSyN7FvlzkqJ7MHr+33XzMx8EMh3rASP2SRV6kl5j+34DDi4Gg5tByg5HqQ5zSP39CVd7VtE1hZm0qoRVwrfUmN3gjGsIG/coI+rI7ZcpyChKJ77D7TUEhvk0nLQTwj6N0qJvkGqyImoYzRcv0Bn0XnZQ90;25:sb+3dZUS4StRivWjK+UJ9W2q1rT4ztxWK2iSQFExtFIgYT7gL5u7Z84mBvVPWFi5MHxKxgdN6AVV5Yt/KwBRhnvjyJx9Jq0JxyiMHafppw20F8dKLt//vylxVyXpW2JcahylCgH+b80DVEGLOlQGk99leBcZyNnuwFL+/N0iBjQqxEvPWo4gnH2xMZ07r1J8D23b1DiJ08KB8u2wCYceFqhwVlVc6XDuGUR3WKufQG6SlxaMEsPryFZxUUd2Z7/+QC06R5qPXAk3rr3dlbWS6lRWAqtANR6UBaSeesFL0pVreEqBxrntdS2xqiusbABZwN25X9sE5mCtAngJ03DgXg==;31:LYv75aUqF+qHmfF5VwGPyQ4blxHmfl5eiPGO0MIubhyQUoI9U5+oSnePd8MF12SEE2v8JsGtT81lrBN8F/tCExa8kigWPrEWxKhJPa6m5JHwPc6q3y7RGKjgdkEmAjCmmeV1DUGkXA5RIIYsRwuvzpKFQYcUgT+uuw+O1h5yifH04mAD8kwJ5du4PoSEYba6O65aPFCQkMrK3z4Gcdh+u6EVeqANCnSRsTJUTRW/pFA=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0702:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0702;20:jrJtbji3PqQbHPZifPjDZdaHXQkIygqFvKbOYPxI2v3AbXR5gJ4PrMt5sZOzG7t255zS0IdHydddVrB+9wkBYSXJktoe4OQRJmk1U27f9ZlZYw2N7zeLTuhlG5oebKNjWJWYefYlvZsj5eyO1C7+Q4FUhEHT4Ug7zjZsgjqtpfLcyRcQZX0vvbV7dpam8jBwIm/KnwOMFhYK83VhxNWZ1KYb7YTkVttirAKvzNdF5hiLuSTBm4IFR2SOw1iwsrNSHlv2FRL1rDJwgo2XLBxwkk5OvKaDIhLgXk8tKTxb1mPvRx0UXvXRNhu2ftzYh59opMdph0Tzg5+h2v+IcR5iS0AwRLHP+V8vy+HaXnTe+4BjaWaqS0Em31VIc3kkqndMZfltD5Zoji/vblXKh6O2/oN1DvexY6En/+xUX2QVrRy2IHaHBdEaBgPViu8vRsKCZgv2YAqeg8YpeRyZSdWHEasODIAMmKi6pqnLbyxCjTOMhQembXLUK370vMgv0gzJ;4:bVVNLbkkA8IvWG0beN/ilywvddXJM3ogG/bMQ33N7r/rtXYoLa2nMHmpfVj9PL/COjiW0LATu6hnckZ94EPtfVgJS/e1G60aNbBexOQOhCV7PlhrOgON+kyUjVRmnESVUM6g793iy6gJEKy+TEWrIHVkTWLNtfngMBzPbLap4zzRz1toa3n/wtV/r08m9RwdePC6Yoh350oeG15u99Mniw01fyGvp9AxyBLvSga5CEfcjWb4UJtJfYWvtg9TpVmdx4VRVyAW2Prmnr5ngTp88jmvqAekt0tYTye75UPeIIy1xOQPh88QSDZ2SY7BcKPq
X-Microsoft-Antispam-PRVS: <SN1PR12MB0702C3B62B6478B737D3B132FDD10@SN1PR12MB0702.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:SN1PR12MB0702;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0702;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(346002)(396003)(376002)(39860400002)(366004)(189003)(199004)(77096007)(52146003)(76176011)(966005)(31686004)(64126003)(67846002)(23676004)(59450400001)(186003)(386003)(2906002)(65806001)(16576012)(2486003)(53936002)(6116002)(4326008)(54906003)(25786009)(6246003)(53546011)(6306002)(106356001)(66066001)(26005)(52116002)(47776003)(65956001)(58126008)(3846002)(68736007)(86362001)(229853002)(39060400002)(305945005)(31696002)(7736002)(478600001)(6666003)(36756003)(16526019)(6916009)(2950100002)(316002)(93886005)(81156014)(8936002)(8676002)(81166006)(50466002)(72206003)(105586002)(65826007)(5660300001)(230700001)(6486002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0702;H:[10.236.109.62];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwNzAyOzIzOk9jMnZNZytEVzlXM2x0STBFZ1hXRVZtbmw2?=
 =?utf-8?B?TFA1TUkrSjFRWWlCS1NXWVl2K2VFMTIzV0M3Y2pRbmwzNUIxYUN4U3dMdTNF?=
 =?utf-8?B?YUFnT3d0TXNsclV6bGx2K202cEozYThsUElWMXlDQjRmUWlqWWRtLzVXdnQ3?=
 =?utf-8?B?OHJ6M3d0OWF1VTl3T29PTE1sMklCdm42TDQ4TzNIZ0hyVTRHRThsRlRtYmlr?=
 =?utf-8?B?eC93MUE2M0RZL0ZVSFZqd0dEUWlmRWorZ01pU05IZUNwY2ZnV0FwSzJzbFNr?=
 =?utf-8?B?QWYvRFoyR0VRRkRVOUJwcFV2emJhYWJhYmt0WWplTS9FR3ZETDI4N3drbC9s?=
 =?utf-8?B?bXd5K3ZwN2ZPRDlNbzUzU1lGc053dlZMc2FKZ1NCbVFKWW9RYXN2anVaYWlH?=
 =?utf-8?B?WnBvbUpkeTh6dzFiV3NTdXRZRHMyRldyRGtIZit6aGZvS0FNVEdaN1F1aEty?=
 =?utf-8?B?ZTFFUEh5Q21oaDU4aFFrQkM1OEVOa3RFb0k5NGVJWmU5dldUMkZhNWhOU2Jw?=
 =?utf-8?B?YjRESFIzVksrNDFIQmdjbkVVWHRhTUtMeUhZVmcwdjh4ZXE3U0FvZVUvcWcw?=
 =?utf-8?B?cUpvR2dmOWhuNkh4VnpuSk41Wll1WDB6ZGpBOXpFVmNJMmdNUGRFUFRLUjJV?=
 =?utf-8?B?aG53S1B0eVJYYXhrdDdSaTQwbTNkbVVEQ3E4YlRxeXFVNUxodEN2UTNORGsy?=
 =?utf-8?B?SHh3ZldPRXRTaS9SMk5oTGUzRDdxOFNKeitnanRpTjRjdTVHZDVxZ0RvYkFu?=
 =?utf-8?B?QmxKUmQ2Z2puQi84cXNaU3B4Vno1NTFOWVFlUnNHTUlYZmw0NEhabnZjUko1?=
 =?utf-8?B?L01wcEFPL0gxU1NXTFlwRzNTRWNFdUVGcEQ4VFBWU0pMYnJpZjNxY3JGdjF1?=
 =?utf-8?B?b3hSU1pjL2lpUjR0Ym5mYmxFREZtdUxXU3JDUFFaVThSb2ZnclRjSGRGbmwx?=
 =?utf-8?B?VVZ5Qk5zQTZmbmRBb012MFcyczRZNDNYTm9OZ2FqRXJzU0lmQndvWjBvSG93?=
 =?utf-8?B?S0tiSGRDeTl0cmlvbHRacFA4emd2Q1FvTXVWS1JVdExaTllCUVRiRjRIWUZ1?=
 =?utf-8?B?cDI3dXAyLzgxOUI4MzJhZjd5VkZwQXFRZ1M0SXI1V0VZV1hSTHB4QzJLN0Ez?=
 =?utf-8?B?T2ZyVE5hYTJ3WER0SWkvTDNhZSt3NkRNVUE5eDJnR0VHeGc2RVN0RDR2UmVk?=
 =?utf-8?B?dWNqL3VSSExsM0NRVnplRlgyR1A0V2JsWXdMQUdtOUs2TVhFallxT2pZeVhE?=
 =?utf-8?B?NFhaZ1M1L2RJUXFVUy9qbzRLODVEVytKZXNQdFhiYzhlaDJwQmY1NUYybHJX?=
 =?utf-8?B?YXhWYVl6cVhkUUVUQ29Rdm1MSCtrV1BQWGcxZ213N2lzb3FXaG9oV25GTGFI?=
 =?utf-8?B?Z0gybGJmT1VieGVBc0VUUXg1RjhyU2FuNUdFS0hTbWJaWXBwQVovQzJndGVm?=
 =?utf-8?B?UTlxUVdvR3NOZW1sRU1iR09FQzBWdDFScjZLQTBDMmJpK25sS0R4cG5zYjFz?=
 =?utf-8?B?anlIK2dUOGVOMDY5SndVS0k3Zm95TmxGNW1BUjFoQ0dCcm5vaEdtL1FsQXQ0?=
 =?utf-8?B?MUJZUG1HUmVTbHhNNVZLRkl0UDFIUWZOTUY5dE1sUGhndEhaK05VdUhvSWdK?=
 =?utf-8?B?NHJLaDlJR01tRmNsRVRPWDBNT2NWZ0RTWE5mOVIwejM5UlVMMGVkVVdpM3pF?=
 =?utf-8?B?MzZPb25mck1ET21iZlp1Mml1WGtvdm1sTk9RL0xKWHpsK3p0R1QyUUFlRWtC?=
 =?utf-8?B?WkJ2K21zNnZIcHVMVG5JUmQwNjVjNEhkYnpZeHJkVnhtMExYaHdPMGxKUk5y?=
 =?utf-8?B?dm1zNWZrUGduTTU1MjQvS2VOWlhzanVBcGhhSjEzTmJPVzV6YUhSUjVJZ1ZO?=
 =?utf-8?B?cXZ3ejNxVWR3ZHJ5ZUtINmREUSt2akxHWXZSQlBqUFFqdWVxZVFhbXFHZEZ3?=
 =?utf-8?B?OXY2QTB5eTIvYWRKOVcrQWE3TkZGUFRMdjhjWjhrNlZCR3JKMGdmU2g5MFh0?=
 =?utf-8?B?SWpab3pXMUQxREM3MFFrWGdNUG9JMHBOQW9JeXJjbTRMeEsvY0oxcEV6amdo?=
 =?utf-8?Q?GVtU=3D?=
X-Microsoft-Antispam-Message-Info: DNIR7jBgoiymfwc2J63ZG0rT+T4N8jHHxfnG49cBDBtAbiAeFsesSvpFgnC/KkAOMHw9zqhOPxaP6DQHwL+QHUruaUXUJKRbyCgEXuOSKezPd3Ve+HQsjQEdSHE7NbX3w0Vt7emIUBYt3ono04+H8dn85sgKkl5ZMor562nR3zzyNQJN9N8qjKBV8FqwHQRz
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0702;6:T00eI80xfeh1/oY/+kQDlDdG87yvE5g6cDWDTSPeiwu28XXQR6sOVxUGmLXES75SsWhm+ozmG5UB3B7ax6eiGOMipwh68WfjFzIWY9/lnvOU5AwSV8vlv2tgBPMkmuy3J+z98x2R5jJy7R3Ek5vCsBgIb0jSIwCsJGZDA0NzDgJxgsWKkfWvEsiqpY+jPHepRJdxJnNH1lS2LQY7w12aOO7udChcw0a7O09PuQEfCWsyOvspMBQrOJqBi1CqYf3bi74FRHU+s2CZIUiL1ee9dZnUCHbxHJcnxj/AqHle0yyCtniX9+io0lNdXmr11Ez/yETtXEvv+Uly47K/RtDZ+sjVAIu1JNWK37ZSoniSBD0=;5:dXRqXxrzpwiZzXyBwIYM+z6JSPRQkHFbaJgLGIk9f7QhnHVA5Nv32IkQt+f0njPdoaqQIj+32Clr36p3lWfpCaGrnJ9kMctCXkDa24jA+epo/OzwSTZc1R8kyNCZpnp7VdqLARhNALEaLJrLBPK99SZ4Mr6UidOLyfTRbbY9WKg=;24:HDFvmeV79DhqRqWQmVYEm4pKylG7hGtlZkWvbvD4o9OJhokHaVK2NcFJkej4Xp6lOPPdV3yfgNr1oDFR9lNZZovOaHoQ8Im7vn3qkBgP76E=;7:Yg9+MCJQVA55igwW4fZlOSN6LKTsiooS5LHtIbYYXU0SjT457JQ2FFqEPUd5M5qu81HIwkeE9q2ce7fvCFB7ppKRMpqxUTJs1eQjqbm/Pnxk+ZdlVBB+XzO8kIpOD/XiLT6hs96vJXqfna1CpJPMmNMBlqZFDDkmMtQzqzaoH/bf3zQrmJfiG39U/6Zl+Nv5sMaKTZAJVoU+RDKVcwJ7gQoOBpq0YzqA1DevNQaiAgFk5KaAVkfFPyRMEoh3A10m
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0702;20:fcKkTtOxugASVRcLRVf0g00ApPtGEnzvO/CnBO8QtvLW7vYyDJ//0xystFslzk7ZXf4ikcXd3VAu15hr9xixQTsZTzmo536ZCaU7WbVspXCgj9t02oBFnsmtfReJvpbrvqTpk3bw29cvd66W/9aocAN+SVotR+QT4V2XTXOf1VcnECfffpqoAhKzK0eZeEUI4kT8p/+s/RMFGxTFMldBrjtjhAK++97rboYQpWDAXSKN+dKXLi7h4ebSomrJ9dHI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 15:24:59.2671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec7468f-76c9-48a1-986b-08d589bfc00e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0702
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/13/2018 03:23 PM, Andy Shevchenko wrote:
> On Tue, Mar 13, 2018 at 8:54 PM, Gary R Hook <gary.hook@amd.com> wrote:
>> On 03/13/2018 12:16 PM, Andy Shevchenko wrote:
>>> On Fri, Mar 9, 2018 at 2:50 AM, Gary R Hook <gary.hook@amd.com> wrote:
> 
>>>> +#include <linux/pci.h>
>>>> +#include <linux/iommu.h>
>>>> +#include <linux/debugfs.h>
>>>
>>>
>>> Keep in order?
> 
>> What order would that be? These few needed files are listed in the same
>> order as which they appear in amd_iommu.c. I'm gonna need a preference
>> spelled out, please (and a rationale, so I may better understand).
> 
> To increase readability and avoid potential header duplication (here
> is can bus protocol implementation where the problem exists for real,
> even in new code!)

With all due respect, I don't find that you clearly answered my 
question. I will hazard a guess that you mean to -alphabetize- them? 
Which I am happy to do, and will do so in the next version.

If that is not your meaning, I'll have to ask you to use small words, 
and not presume any understanding on my (or anyone's) part about 
preferences that are not documented in the style guide. I don't mean to 
be thick, but I have to ask for clarity.

Given that this is a preference, and that there are reasons for -not- 
doing so, I would also like to hear other comments on this suggestionn.


>>>> +       for (i = start ; i <= end ; i++)
> 
>>> Missed {}
> 
>> Wasn't sure about the M.O. given that the body of this loop is a single if
>> statement. And I don't see anywhere in
>> https://www.kernel.org/doc/html/latest/process/coding-style.html
>> in section 3.1 where curly braces are called for in this situation. May I
>> ask for clarification on the style rule, please?
> 
> You can do nothing, though I'm guided by the end of section 3.0
> (though it tells only about 'if' case).

Fixed this.

> 
>>>> @@ -89,6 +89,7 @@
>>>>    #define ACPI_DEVFLAG_ATSDIS             0x10000000
>>>>
>>>>    #define LOOP_TIMEOUT   100000
>>>> +
>>>>    /*
>>>>     * ACPI table definitions
>>>>     *
> 
>>> Doesn't belong to the patch.
> 
>> I'm sorry, I don't understand. The added blank line doesn't belong to the
>> patch?
> 
> Correct.
> 
Fixed this.

Thanks,
Gary
