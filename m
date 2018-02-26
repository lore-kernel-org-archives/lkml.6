Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbeBZQOX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 11:14:23 -0500
Received: from mail-dm3nam03on0062.outbound.protection.outlook.com ([104.47.41.62]:24272
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750757AbeBZQOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 11:14:21 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: `do_IRQ: 1.55 No irq handler for vector` on ASRock E350M1
To: Thomas Gleixner <tglx@linutronix.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Borislav Petkov <bp@alien8.de>,
        Paul Menzel <pmenzel+linux-irq@molgen.mpg.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <8bb6b660-ce08-37a7-d1ab-38a690595856@molgen.mpg.de>
 <alpine.DEB.2.21.1802231914590.1437@nanos.tec.linutronix.de>
 <20180223190950.GJ4981@pd.tnic>
 <61f2fc82-4eee-8678-c37a-dc300dde4edf@molgen.mpg.de>
 <alpine.DEB.2.21.1802240941190.1825@nanos.tec.linutronix.de>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <c84da3a5-107c-2ddc-d108-ebb33df49719@amd.com>
Date: Mon, 26 Feb 2018 10:14:10 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1802240941190.1825@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:300:ee::31) To MWHPR12MB1149.namprd12.prod.outlook.com
 (2603:10b6:300:e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6eb5179a-4b45-4767-d054-08d57d33fd37
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1149;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1149;3:Cr97ojqMQPpVTIUxK8oHcnF8TtRNFug2J6Oc2VNwBUmjafl92FYekAEWA20gT65XFTqTJM+N3wBWsj7jN0E370um7v1SQPu/BwqyIW8mapq7OqbdsWukZna/rY5pwAoT0zIBKiLq5oTLTHcrhLtUgQ0Vid+ywZBj5V21DLRe0w9tewnF0BJaOaduQKuQla29E254swG4iVohU4SMJOz3JUvd+5kliadY/HcgrlVpJA8X+oerZTE3rS4TQQuNwvds;25:IEElRI9kTtyWkKlPLHUKNqa7Bi8MX3ppKAoYPPi6pgzFOkHsxve7mpSi+F1bcgHjQCIpzLCM15QSfapmnJk2pScJIiKEqt+a5TNunG8YRA/iwm/4GVz0t4Tg0TZCA1/c6Vm4wSOsKlrWNsWyaoOkpIiHeD/Sg2eq6kNbbTGztpHBm79bB2RwpqBdKnEMVkSg56qazPyLpXIZaLHJw3BQer3izxV3ZqOnNvHo0wxLMveAMucd+ElUDJCBZagrInLotuf0X1ZV9r4Tba224VC9MtLEiFfpjD2sixRDyYfU8lVUVd7UDNnZJV9v1xyePTzNVuZxTvF4RXbpfqox5IF43g==;31:i93kdeheWLL9wVRTkzb2Tb3LpcROsTjPCULSfJirEe+IYZ6r0wjvd6CggIvY9JbTgSjjzFIl5HS09OTeDxVF1VOuBDxoEEta/hpUSk8/uXuNsYizthNT6wGhhpsMQyEcEqgRZLmt/g12xlQ2+3glKX0ML4XuozvQXsxQnak6DXOxUSrQ92Co7JDlR0J6CuHHNZjgoSVLqu5W1LpxdQNfCdBDVpYSmjxcFSPolZxg1ds=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1149:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1149;20:+iWGpHDOVhCvRWwtXYcHybWnBO1QFOJTO0e/WO/TZ378aSPhVtZZxGQ58XWtcscbgi1jv1H11xlxl4HH+Tltugz6oCm7/coEjUV/ClRDApn4QVztJhJmLMiZcVfiXtW0iy110hEjrdZh7GAURGBEVo2RvIi5597olPP1NS9r9CVyyGAI/dKkuuftNPWPgNWvqkAOAFtzh+qnc3CHMMUpmMpVCIW7uR7iLXQxy1WKf90IEJVVkqIVL287tsbvE0f77bdvsyA9KHDKSA1Iu36IpyElhp1ACVz1E7azB2ANQSlQK37I8Xf/ILXxqXMfL+yEk02r39royNWMWKslvD+HEztgmEzEDtWzt8E8YVbGlR3MTVqVk1X3OWtp1PLxJ+B8JRTAahaAJnZzwwZkiLdf5gm1/nPbSdD0+yX5R6ZfVjUkqXhhb+YbBYWYsEMnPIsLcqnMMpEZjoH90Rn4kvpgQxyRyrSoYXI2CyUtao8rYhzK56ViMo1I8MuVPYIw2w9y;4:OAh+riFV6PuJPBbuIODsTfct0ErLGXwjZrmg3Ws2uR8OF0pFbyb4pKcH1NwWu2gzWtcc3+QERkP6xhHPPmc8Gpg0Y7PCo0FYnlCggiGHtQ0LEm3Mm2qfD9BKMthdYAuM9KF9NpZpNFDViN42725dMCYHMKa4Ovz+9piATp5jOeNYOWUhUKXOG++YPvSLsWl0g6VlqxpoyA6lSAJ561M9v2QsSzdpYNAGOk3QjO+YiJ0tQgxmS5BUn7J8+Tk67fT5qQnEHJLjZltMKqmcxECqSQ==
X-Microsoft-Antispam-PRVS: <MWHPR12MB114953C2F7C821F2023B9BA6ECC10@MWHPR12MB1149.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501161)(6055026)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:MWHPR12MB1149;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1149;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(39860400002)(346002)(39380400002)(366004)(376002)(199004)(189003)(26005)(58126008)(36756003)(64126003)(230700001)(2486003)(23676004)(53936002)(4326008)(5890100001)(16576012)(478600001)(110136005)(16526019)(186003)(54906003)(76176011)(77096007)(5660300001)(72206003)(59450400001)(68736007)(6246003)(6486002)(97736004)(65826007)(6666003)(316002)(53546011)(31696002)(386003)(31686004)(2950100002)(7736002)(105586002)(47776003)(575784001)(93886005)(81166006)(305945005)(86362001)(50466002)(8676002)(81156014)(2906002)(25786009)(3846002)(106356001)(3260700006)(52146003)(52116002)(6116002)(65806001)(66066001)(65956001)(8936002)(229853002)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1149;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxMTQ5OzIzOk1BY0s4Y3JmT0xaaUlZNXF5YjJtcmRFQVpK?=
 =?utf-8?B?eUhWQWZCSGRpeUxWR2RYck9Eb3ZUTVFkWFphOGdYSW5pVWtxdzZSRllBNHdi?=
 =?utf-8?B?N0xFU290dVpCSmU3NUpDc0UxWEZBMmdWaGx1blBiVjNzTjdXT2tXUnZkcUor?=
 =?utf-8?B?K2JaenZVNm53UFRuMktNb29WeW1FSXkvZFM5cUYzWTRSTk9CY0tzWk50Uk1P?=
 =?utf-8?B?cVl1eDM2OGljT0xIRUcvVWpQdWN0WGhJWE00S1lwaXREd1BoVW1ndnVqNjk2?=
 =?utf-8?B?aE5qVmhNblRGd3hwd2ppQ0pIKzhTdUYreEJ2Yndyai9jWWxoSEcyTC95dTN6?=
 =?utf-8?B?cCtSZUdONFVEZG54WlRMckF4ZS8wUzF6QjFuYzh6aUo4eVQwVkhuNVlibUNp?=
 =?utf-8?B?d2E1bkJ0S2dHMHJ0VzBwaklnUHBmMEdrNVh6UlpTaHJXVjdGUCtUL2hLbVZq?=
 =?utf-8?B?MnJjUU9Lb1RIZTQwa0xzVUhoYm1MeWRQd1VsTXMzblVSSWlPSHhHMzVFcEpY?=
 =?utf-8?B?b016RE9LMXdqNmJNQmZRMnI1MEdhNmtDVVIzWmpSTnp0bHhvKzRjQUIwdnJT?=
 =?utf-8?B?OUZTSVJTYW8xU3FveEh2SXpnbjlibkJCQ0pXQ3JhSW9QU3VpTXVldDFIYkV2?=
 =?utf-8?B?RVM2VDUzeTdmbTExdmw4Mm1va3FDVUZhNEVKTTY3QjY5eXNnMGl3WnZHekh0?=
 =?utf-8?B?eXpYU2FiRmNuTWNRazl0cGZxQ3RwKzhPYlJmRHBlY2NlQXowUXdoS05GK0Zy?=
 =?utf-8?B?ZlBEaGVwUjdhUWlKYktSaldvbldodTA1bVNtbW5pOFN2bzBldXZNN0o5V0Yz?=
 =?utf-8?B?ZHRiK1BabEY0V05PUXk3SERxMnRSd2gxeXl1QWpucEIzSmJVMG4yY1JIQ2Y2?=
 =?utf-8?B?UHM1MUt3a0NtdEhrYkFEbmcxK0Fka0NVQThIQWt2amczL1Erb1FUR0dLSFln?=
 =?utf-8?B?dER1dy8ySjZrRmJmVjhucnBzVE1CN2NGQ29ZWmVaUzNnMm53U0hHTytBenRw?=
 =?utf-8?B?UkwvTUN0dy93TDRHMVZOYmJnYytPdzlQUDRwNDhhRm9JVUhaZi84K3d4c0VU?=
 =?utf-8?B?VGhNcnZzMnJSVTVaUXJ5ekJYaHBvTlBOSy9uUWVBUzZrWHFtZCs0MlFjUVIy?=
 =?utf-8?B?YlFWQkkxSmhURkFGbHVYQmJGajdIZ1NXYjFEVytpN1ZLT05uOTdBZ2tpTnFy?=
 =?utf-8?B?aTlWT0hnVS9ib2NKU0N5ZUhRbWtYQm50LzU5b2tGYUZrd1JBWFFTN1RaUWhZ?=
 =?utf-8?B?UFdIKzRBY1Nhc3BsS3VRd2tBVEpOaFFwa0t5ZkYxdFpIM0I4dFlGSDNCelFn?=
 =?utf-8?B?d3ViNHI3bHZJeE94U3NVM3Z0bTIxSFM0N2EwQWo4ZE9kWHZxN0VkVEZ2OVdt?=
 =?utf-8?B?Q2NSeFE3SWpUL1VUNWtBV2FOajFBTSs0OU1FUjhTdXdMNkZMMzZPQloxYi92?=
 =?utf-8?B?Rk9weHZ6V2hidXkzcDl6NjhaUWxFUzdaLzRaUElRM2liSCtYaHJyRDhSM3lH?=
 =?utf-8?B?TzRPc3gzL0twZmhxTng2UC82b3VyZlpGQzZJWGQrYXMvWURxUzR2UmE2NGZM?=
 =?utf-8?B?dmFJTzFaTmhxazhJRk5nbmZMdHZtN3NRRlhreUFVV2FPampoZVJJVk9kMWp5?=
 =?utf-8?B?cjZ2QmZldXRRS2dtby9URDdQQkN6OWlHQkhFUDFpek9WdmlHaks5WXRJb2N3?=
 =?utf-8?B?NFhWSnd2U0Jmdkl4MmNsZHJyS0hOc2FkNmc4cG1qa3V4OHA5MXByZ2xUWklR?=
 =?utf-8?B?aWg3bE9pYjNPUmxwdzJJemtHR1g0SE1jQVlQZ3AvMmJsQWxKWWlub0piM3Ju?=
 =?utf-8?B?c3hMa2cvZWtIVlpnVytDKzlvcFhZczNaKy9xaEJkVGUzcGFQU1BoNXN2WFFQ?=
 =?utf-8?B?MllqSU40RHZvQ202QUd5N2E4M21xQjQ2N3BVTGFOclVOS1FwbElOS1pkaTJv?=
 =?utf-8?B?dXNyYVd5aWVLSDB6VGovcDlIY2Z1YmZxY2laR0V3d1VsNWpKcFcwUGxRdEFC?=
 =?utf-8?B?RXZyR01qd2RIR0V0QkRDT1ZBTnpZdzAwUGFGUEU1NDJXcitUc0ltNEFTRDdX?=
 =?utf-8?Q?5lItCwH05OK8L1t8oTQsJKrOF?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1149;6:HdN7v2+8bhvnYjzDzi7FZe81pKcDf50fOdls+tiQeizo1r9ePxj3Bf3BCrXWx1cpQBgoTL8Ii0oc05WpisI6gKHUYhSDiR4IYyFbP3nssFI5VvmoiI80fISCeKBZ1pGjWmHb6MvfhnRwEKkdTqjjdZn4SW0rY969v/kq5kR5tEAGRhbNSJg924LlCDKLNF9L40F+X3aPI8uz8/eZ3X8Es9lapYhIqmROUMd7HdU4ijITgGDNNEnfKrh2p8qhNncmwKWEb3b4qhIAC00RJoowgJMn1KphRGqzBaGPdcxPtavX3X6KSXYu9wQkkeal19BpxQN/m0gwaEbbuUDdiR4QtmfmOzwXbge9/ax1kt5SRWE=;5:XTMbwQD54u+9qdmSP8T2woWfGrb9kvNQXoexJpMslfS7lJq7zT1bwD8umvE6+2ysOryCBZIFUxBb4byQqAGNZ4AMDQ+G4OPIovqVhPQ+UjiyV9Bjh4Uzm0Zi5+PieFQOUM6TtnjcPPxz2YV8T+wkt3OLmLCpJLE4ihIN8Ciw8oA=;24:rmasJqihQcKsteKwcKFPT0NBmJZ23cd9uOLsju0siZheSQjWF/Y/7NophUqRFTgVirWuOozyuzuVqbY3JgeqjixcwIKpE/sDAhRtInJ2eEk=;7:ga/oxsf+1R0WOZA2XVs2FWo11UuI3FGhGns9SGBmHA8XIwhUb/8LiOjfIAU+msnCckYmhEl9e5W0/yzaNyVbXHgerEsU0Ts1f6KXbPkjrTNZJZBbi+gxw+/TZfuFVer9Jrd61qj03JXrL6xmLM53isFQ/hwtpguRTcGykdS9DeBnX9Gufd6JRFmut4E71DCVXiINyTctU0U/LFgm+81+stUgbYEsZSU+wiT4GIjcvYgkDd5QHfox99p1bSKT6nbc
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1149;20:+W9fzQiZ18W1qFg9xVJN+ciKHY2sZUk0UIZEmb3n2MKG4sbyOLE3EONI7xFgeFA5GwEwpJ9LTB7poDEBBomZ+1sFtvq+w3vAfdUp9I76/ISeqRzic0zfk6/291hRWBsoY7TBuJReuXbsi88MG26UxJSeq5YuxAYH5tZXR6IKBmh9K8krUM7XXGkZ5wGmfQwV6PrY6pPMoR6k+cF7pSVP0xCtLeGMPag1hnKl5IzofJ2sGXe5iPzsTuzmEiNBUtS/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 16:14:18.2734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb5179a-4b45-4767-d054-08d57d33fd37
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1149
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/2018 2:59 AM, Thomas Gleixner wrote:
> On Sat, 24 Feb 2018, Paul Menzel wrote:
>> Am 23.02.2018 um 20:09 schrieb Borislav Petkov:
>>> On Fri, Feb 23, 2018 at 07:18:34PM +0100, Thomas Gleixner wrote:
>>>> Borislav is seeing similar issues on larger AMD machines. The interrupt
>>>> seems to come from BIOS/microcode during bringup of secondary CPUs and we
>>>> have no idea why.
>>>
>>> Paul, can you boot 4.14 and grep your dmesg for something like:
>>>
>>> [    0.000000] spurious 8259A interrupt: IRQ7. >
>>> ?
>>
>> No, I do not see that. Please find the logs attached.
> 
> From your 4.14 log:
> 
> Feb 19 09:48:06.843173 kodi kernel: CPU 0 irqstacks, hard=e9b0a000 soft=e9b0c000
> Feb 19 09:48:06.843216 kodi kernel: spurious 8259A interrupt: IRQ7.

I think I remember seeing something like this previously and it turned out
to be a BIOS bug.  All the AP's were enabled to work with the legacy 8259
interrupt controller.  In an SMP system, only one processor in the system
should be configured to handle legacy 8259 interrupts (ExtINT delivery
mode - see Intel's SDM, Volume 3, section 10.5.1, Delivery Mode).  Once
the BIOS was fixed, the spurious interrupt message went away.

I believe at some point during UEFI, the APs were exposed to an ExtINT
interrupt.  Since they were configured to handle ExtINT delivery mode and
interrupts were not yet enabled, the interrupt was left pending.  When the
APs were started by the OS and interrupts were enabled, the interrupt
triggered. Since the original pending interrupt was handled by the BSP,
there was no longer an interrupt actually pending, so the 8259 responds
with IRQ 7 when queried by the OS.  This occurred for each AP.

Thanks,
Tom

> Feb 19 09:48:06.843258 kodi kernel: Console: colour VGA+ 80x25
> 
> So this has been there in 4.14 already just the detection mechanism has
> changed due to the modifications of the interrupt vector management code.
> It's not a real issue, just annoying ....
> 
> Thanks,
> 
> 	tglx
> 
