Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbeBZQmc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 11:42:32 -0500
Received: from mail-dm3nam03on0085.outbound.protection.outlook.com ([104.47.41.85]:22256
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750807AbeBZQma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 11:42:30 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: `do_IRQ: 1.55 No irq handler for vector` on ASRock E350M1
To: "Morton, Eric" <Eric.Morton@amd.com>, Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Paul Menzel <pmenzel+linux-irq@molgen.mpg.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
References: <8bb6b660-ce08-37a7-d1ab-38a690595856@molgen.mpg.de>
 <alpine.DEB.2.21.1802231914590.1437@nanos.tec.linutronix.de>
 <20180223190950.GJ4981@pd.tnic>
 <61f2fc82-4eee-8678-c37a-dc300dde4edf@molgen.mpg.de>
 <alpine.DEB.2.21.1802240941190.1825@nanos.tec.linutronix.de>
 <c84da3a5-107c-2ddc-d108-ebb33df49719@amd.com>
 <20180226163102.GM4377@pd.tnic>
 <0337DBEF-58BD-447A-A828-DE1A7CEF21E4@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <13724e9f-a6f3-ece2-b007-741e45ef3660@amd.com>
Date: Mon, 26 Feb 2018 10:42:23 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <0337DBEF-58BD-447A-A828-DE1A7CEF21E4@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR14CA0042.namprd14.prod.outlook.com
 (2603:10b6:404:13f::28) To CY4PR12MB1141.namprd12.prod.outlook.com
 (2603:10b6:903:36::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4f4c31c7-e83b-4c86-db4c-08d57d37ec77
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1141;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;3:XFTddJm/TvXBwJDE8z4ylGDSWIkywgDk5jawVorNrev1OQZlveXIyHxBUCx4D4bKwlTTWRA13CFH69j6JA9Ey+3H9cKpmUUfPgnKdGttSTzajIhg/96xTtI62ScBeUDhMEb2GA1b4BIfoZxBjLI6xMjWrr55bKh+p8Tl93CnHK4NZOu5U9oK69Es58PhIFnZiwnybngpmXWhysrjOCeExTRhtNnbQ4le5kFd7GO1WKST/ZqV9rNRukCbAghSz0VZ;25:U77UL2coAXyvBD1FWs8A0dIJxJH+k85niuevX9dMl26iSd+UBFzokdXQxmyoXh8ShD6Sd8h1GYjJuFt7nXlDFvvnDYk/yqN8ybTSMB2POCejE6r3gAl9EHRwqv0v4dWZXcF7EGQ0peReLoJHCSsYAW/xncJndQgXL54NdHezcQwhg92ZumRr3X+N5Ckq0EKjIF3yO6E7Ix235MYXBedrfmdUtNSqY7AEugYWEErU/yL0LxiZarEPjVHY3xLw70gFCdGuSJzqIpeaqO9s/DrT6nKcncH0u/s2NXYYvPNGt0RszYi7HNHLoaWkLlz0YeO2RhxDBFbuGVXcCkViDon7Ng==;31:CsPZQYtrLYPvRQufoGK119slWLbUidfcwfeW8O9SWsFdEvC/xkt0MZcuJhjNZWyjpwdC5nmkLENgW4Xf34K+fnp3mobpqlCwUDchRVZeDDK3wTlO2tsEqbZ997b5nnlvLGHw8wVvLiSsrNZyAAq+oPpSGdKq34FAAjfbArGToGF80HQahW+YO1+AbxCgzMIPw1yCYEJmkJy0gdtpzv6NxQEMmVvjVduaGHeWU86oerY=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1141:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;20:U5B0L0U8xBq2c7uU7rw7YvU6uaKTnilg6Dsd3IpSlF0wNwtvx9WgqJxidMntKUWkgksLXDJ7BFG8SVEoHX9/OkqStEvi+sWjcxKSY0ujRyC0Kkrm3a8NJzmpU0BKAIzKbdZYRsiq2hzuodtzTUFJcUCJnILeC8/UZJeBuosRtWlAIV1Idbn4hIIlOQ7mG5stS8oL7F2AqzpDGPglnqDGTtz+EGfIzVYfoUId5XCNaUstFqeQBgmfqPIhJxwVuiYJvsVyRYTYl0lZ61/UiR11IFo+u84kgeooQxxqQ1JJLypT+3kzEsEA6Y57kx6MikbgaSLDcwF+rwVkX3QPsxRaSCk24LdeLGybcUpqjJmCkQDeWMAP6f7zSGbAApfz4nxc0ENKrWDd4qraXajIzqQUoDMjpLN/hXdOyhcabBCY2Q3VkAlKVk/uB8Z+tlOoUtrL+yxHuwz7bMXqqSMotoWXP+icX0nsGBC+1D1hgFr19RaY7QI+HlkBqx8aN1UmKCq4;4:o0DvC5nZjG9MfzA2pL0u17lc7yraD/WaCAuPlfHFxet7U7xJekg26vwVb9Ka83PyHneeXNyAJkPis81zqKG0RP9tr5ALU8W5bgdturgXku0usbvZQiuxJ1GPIsa1HgLBZOTtg44//YqNkjhwEba+9M6hubUaSlztmWFwaFRErZ0RVCpGwW2QYaPPWu9rSbe3aW2li7mnoGjYoIafzgWfFYsjg/oVESrke9Yfv3TjwjXrhfP+cLJUtHusRqQ0nuAWu8/1FVkmpNelozegcRafADRRML4g4uUkts1XuRU+V2SUEtG6EiFWr0GrtrzZROZs
X-Microsoft-Antispam-PRVS: <CY4PR12MB11413C9506C325861DF65C03ECC10@CY4PR12MB1141.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231220)(944501161)(93006095)(93001095)(6055026)(6041288)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR12MB1141;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1141;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(346002)(376002)(366004)(39860400002)(39380400002)(199004)(189003)(93886005)(16526019)(23676004)(52146003)(110136005)(2486003)(58126008)(316002)(305945005)(77096007)(106356001)(36756003)(52116002)(76176011)(81156014)(81166006)(3846002)(2906002)(6116002)(2870700001)(8936002)(6486002)(229853002)(7736002)(2950100002)(6666003)(86362001)(54906003)(16576012)(8676002)(31696002)(65826007)(5890100001)(53936002)(105586002)(3260700006)(25786009)(4326008)(575784001)(386003)(59450400001)(53546011)(26005)(31686004)(65806001)(5660300001)(68736007)(72206003)(65956001)(50466002)(66066001)(47776003)(64126003)(6246003)(478600001)(97736004)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1141;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxMTQxOzIzOlVYMjYveVg3aG8xNnNWczY0bEhTeHV3d3VU?=
 =?utf-8?B?d0xoMGtrT0U1L00zMDRhdmRMQW8zVHY0NXlSNHhZRC90STJLdVNqaTBhY2Vj?=
 =?utf-8?B?YU9aRXR1bWZqa0U2VzIyQmRrSUtsVldrREtKcWIzK1d1Kytrb1g3N1hYWGx2?=
 =?utf-8?B?cGFYUklGM3dvWjdYS0J6alN2L1hRd2JGdnlTUXNkUGoxZGo5cFR3TmpoUmV5?=
 =?utf-8?B?djZVei96YndUdjVOay9lTU0yWGRGaC9rTTJpY1RRcEZpOTAwSWRlak52Z3Fw?=
 =?utf-8?B?MHpaNWZVaDlSbFZOaU03LzRkOWo3UTV6cWJWdURBUkFXbksreFdiTWhGZ1V5?=
 =?utf-8?B?L3REYXlCQ29PMzRCR1p6akJDalFoZEZUanl3TkhNZE1DRTJpNC9hb1dKSEpy?=
 =?utf-8?B?cGY2TktsZCtzeWFoVENOa0lrcDlqZzRDckdKeGtaUnpmNDBGRzRqeE84WFQz?=
 =?utf-8?B?ZVBvZWlhS1BNRXNLQU9NekQyaDhaMjdxRkovTk1GVlQ1b2RwTjYzQWt3Y3hI?=
 =?utf-8?B?NkJOR0dUWStHVjBtdFMrczIvY1ZUYndXNFJ2c3UrdGd6OFgvYTA5dSt2M2cz?=
 =?utf-8?B?b3V6c2didjdOS2F5VWtjTmpaeno1Y2tkMHFCT0JjSXZTVFZHdEhGeWlSSERv?=
 =?utf-8?B?ck9oMTg4Rys5Tzl5UnIrd0xrVHptVUNmdmlzNzZzWkgrVDRwbUY4VWdNRmV5?=
 =?utf-8?B?a1RHRWcxSEdNeGJCd3F2RFUydENnU3FwRHZ4b0V0SE8vaG1Ocnp6N3pZTWxw?=
 =?utf-8?B?NXJsZXF6NS9SR1ZFa2pzMkIvT3BLUU1IUXVQWnN4K25DanNkWFBtaCs3OHBD?=
 =?utf-8?B?Tk9wcnpaczdMQjJvbEVKeldZYklCTlJvdElIVDQ3U0UvRWtPR1NnUVpWNzFt?=
 =?utf-8?B?S2o1OGczbVIwdkpmRE5uRXdmQTR4dWdGUWJuR3JBVHdNbUNQYkp0OUpXMG43?=
 =?utf-8?B?bjl5Wk1lbFZ2WjEvYnZpZEFSc0ZxUFMzUGthYUVXM0NOVDdUa2tsTi9sQ0pj?=
 =?utf-8?B?Z0hIcEJzblp4cVkvZ1U0VnQ5b3JHd0RGUHRLWncrV1FHVFRjT1lndXl6cHJS?=
 =?utf-8?B?YXEwRU9Uanoya0phSVQxdWZVWkV5VUdoTnBCVjBuSFI1Y1hDbXFOdjZGYW1y?=
 =?utf-8?B?VjNyMDdBVGxZMm92WmZIVE5iREVMN1JtZDRiSGpYTnFLZjk5b3JXMDdvS2E5?=
 =?utf-8?B?VlhLWXUxVXJDVDNzM3Z2aUU1Vk9OUlVWOXpad0tKMXpHemc0Y3I1YjB2bE5I?=
 =?utf-8?B?cWp3V2x1N1hnU0V5T0hVdjQxeVlPd1RUbkQxNldWaTZzM0NULzRITEVOREVM?=
 =?utf-8?B?bmxtVXhEbGhEenlWZlhuMlpTTk5iaUNzc2hqZlArdHRMWXhZRlZHVTZQdHE0?=
 =?utf-8?B?amVobmczb0xqTG5hT05QaEROdjlOalRYc3JocVBhZnNOUC9RVlRQZWJjcUlp?=
 =?utf-8?B?SzNRL3RKVDBZRkM3b2N3V3Z4clBOZ3h6UVVjWWU2b2x1ZDQzR0VSaXNjczB6?=
 =?utf-8?B?Zlh1cWhqbUZnTW1jbkJjdHBVbTEzR052ZjNUQUl1T0xkRVZBOWNXay9BUGtw?=
 =?utf-8?B?OVhHYm11SklmWTFGQmpvcURNb3pyb0lXUnkrTzdHdXluUDBDbnZXdUt3SXox?=
 =?utf-8?B?WWx4OWRuallUVUZKZzVMeWpubHRySVNxaFAzd3dlaHE5blVrMW9IQk5rVnA4?=
 =?utf-8?B?OGprNXN6UzVta29YT1RBR1JBUllTaDV6ZUxXU0l1MnNSQTJrY1hHaURZOHJn?=
 =?utf-8?B?YUZ5WWlXMDJ2ckEreGJ6MVJ4WTRNeUdtcDlVU2FEM2ZYeGhkZUxvcGVqQ0sw?=
 =?utf-8?B?M21NN0U1UHZUZHJlVkJRcGZNYndZWHduMkpkMU4rZWxYL2pNMUJJSXZpMU5J?=
 =?utf-8?B?MHZJcGxxUldSRDJ6MElTdEZiWnYrV2lzNU9NOTVnRFdvWVBQS2dKS0hYU2gx?=
 =?utf-8?B?dkVKZjdadWpmeG0weit4Y0g4OU1rcGd4ZTl0U05mczk5a3RBeVlvQThyc292?=
 =?utf-8?B?d3pmVzZhYzBwN1A2UDM2Nmxsd092aGloR3VQOTlvQXI3ZFlUOCtYZU5LRGpP?=
 =?utf-8?Q?Mb8M=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;6:WViDrlVPWNFcRoQLxRi1R7Hye4m4T7v9kjPaYA3xfRluZcMHSpkJdo/HHJIZD2mL/11qRT6nkGRDjzV2ZCJn3KeE7buwI76EQ3scdGhRQEVuIyGnTW1p1GtBB3XHYLMo9prZu3p4ek0PcyLmxLsKbNeo7O7IKnygrbtkOI9YLWifmTnveD8Fb/mmybtjvlUQwOpU26IRN/KLD7glYDLxc5QG03AVUSsi3X0bBclvmTlILU2K5Bs8D6yLzhp9xaBJCvjigo2VLdCMKYL7gWLnEv/Pnnhnw7aQRTFwaKAku3unNgcyxQpRYBOSQP2LI/yVoLrFbVDS+xfowPXCrczDXitnkqSKm/mRnQl6RQnBXJI=;5:6rp5EZTIilm1+qTvBOApknx8ib9gas2PB0hXVooUch4bFx4HLvq6C8+DXXREuln7eXscj26KaI02ASf53Tqxo8wBv51U0950Ey4QltqjlMaQ8xiRTiItsM96hYVkXjgE8zqQpL/h02ZUlntTeJo7EddY9LeY2tr72/FxdkZRlyI=;24:y91D0fPRohaprGtptuoXmfxtXL0uY9HdzOp7Gwj949UP6c4NwShlloLZBi4YNqAEkTbpOcgDuY/A5bCnWAyxbKwRkQp8voeGuiKTjGNe2ks=;7:rLaVg2o++A4i6v+dgmZHKLLjwoVEjrWdwtBVvOlPcS5XSlZgN1d0SgYrgbSjE9E2ly+fvVQMa5yDixBiiev5Hhox7nxsE1Cqb0NnlP6i9Nv+modKlqvLwrXZd8aN7G371Z0mvvpDLGLqAbQoy3OrN4KGc9W27cxagJTvBY/WCA+zGb4sgBGmua4GV2CjmsHN4fgbRS8vhxEiL7cP49c014h2jY5mcSazI1hPI2QYFs+zCrqWDVbAIZY0+vzHFciD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;20:Dt/FjVp+zWDdqoZyTbUGXUiamZ9H/l4R6k/fOfpxRylq+x/Cs3pMDVm17dF7M08AJaTYhi4J10cfNkcIkuPJ2VFjVWdGKEv1kWhPs/Mt+bYJX90DDJPTR6ROcHj2xAtcO4R9Hbzz3lEYhJ4s0KHlwYQXKoBx9LvPOzIGQBu+rgjwIrmiDcDpxE7EBUFxIzHGcCOtpk+K8MkFcp40f1CdnpsEeUQayG/tBe9hqxcBA26k/Fc8EvPRW5e5iIrO10jH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 16:42:27.1744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4c31c7-e83b-4c86-db4c-08d57d37ec77
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1141
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/2018 10:37 AM, Morton, Eric wrote:
> Thomas,
> 
> Yazen dug out PLAT-21393 as sounding like this issue. I haven't had a chance to digest it.

Yes, internally to AMD, that was the bug that tracked the issue I was
referring to.

Thanks,
Tom

> 
> Eric
> 
> ﻿On 2/26/18, 10:31 AM, "Borislav Petkov" <bp@alien8.de> wrote:
> 
>     On Mon, Feb 26, 2018 at 10:14:10AM -0600, Tom Lendacky wrote:
>     > On 2/24/2018 2:59 AM, Thomas Gleixner wrote:
>     > > On Sat, 24 Feb 2018, Paul Menzel wrote:
>     > >> Am 23.02.2018 um 20:09 schrieb Borislav Petkov:
>     > >>> On Fri, Feb 23, 2018 at 07:18:34PM +0100, Thomas Gleixner wrote:
>     > >>>> Borislav is seeing similar issues on larger AMD machines. The interrupt
>     > >>>> seems to come from BIOS/microcode during bringup of secondary CPUs and we
>     > >>>> have no idea why.
>     > >>>
>     > >>> Paul, can you boot 4.14 and grep your dmesg for something like:
>     > >>>
>     > >>> [    0.000000] spurious 8259A interrupt: IRQ7. >
>     > >>> ?
>     > >>
>     > >> No, I do not see that. Please find the logs attached.
>     > > 
>     > > From your 4.14 log:
>     > > 
>     > > Feb 19 09:48:06.843173 kodi kernel: CPU 0 irqstacks, hard=e9b0a000 soft=e9b0c000
>     > > Feb 19 09:48:06.843216 kodi kernel: spurious 8259A interrupt: IRQ7.
>     > 
>     > I think I remember seeing something like this previously and it turned out
>     > to be a BIOS bug.  All the AP's were enabled to work with the legacy 8259
>     > interrupt controller.  In an SMP system, only one processor in the system
>     > should be configured to handle legacy 8259 interrupts (ExtINT delivery
>     > mode - see Intel's SDM, Volume 3, section 10.5.1, Delivery Mode).  Once
>     > the BIOS was fixed, the spurious interrupt message went away.
>     > 
>     > I believe at some point during UEFI, the APs were exposed to an ExtINT
>     > interrupt.  Since they were configured to handle ExtINT delivery mode and
>     > interrupts were not yet enabled, the interrupt was left pending.  When the
>     > APs were started by the OS and interrupts were enabled, the interrupt
>     > triggered. Since the original pending interrupt was handled by the BSP,
>     > there was no longer an interrupt actually pending, so the 8259 responds
>     > with IRQ 7 when queried by the OS.  This occurred for each AP.
>     
>     Interesting - is this something that can happen on Zen too?
>     
>     Because I have such reports too.
>     
>     -- 
>     Regards/Gruss,
>         Boris.
>     
>     Good mailing practices for 400: avoid top-posting and trim the reply.
>     
> 
