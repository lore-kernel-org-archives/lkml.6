Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kyWuuH86"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 00CE1601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932408AbeFFIDh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 04:03:37 -0400
Received: from mail-bl2nam02on0054.outbound.protection.outlook.com ([104.47.38.54]:52419
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932262AbeFFIDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 04:03:34 -0400
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=permerror action=none
 header.from=amd.com;
Date: Wed, 6 Jun 2018 16:11:32 +0800
From: Huang Rui <ray.huang@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: radeon 0000:1d:00.0: GPU lockup (current fence id
 0x00000000010da43f last fence id 0x00000000010da52d on ring 0)
Message-ID: <20180606081131.GA6773@hr-amur2>
References: <20180605144404.GA7389@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180605144404.GA7389@zn.tnic>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(39380400002)(2980300002)(428003)(189003)(199004)(16586007)(316002)(8936002)(53936002)(186003)(47776003)(54906003)(72206003)(9686003)(26005)(58126008)(86362001)(6246003)(81156014)(33896004)(336012)(305945005)(76176011)(2906002)(8676002)(33656002)(4326008)(77096007)(104016004)(15760500003)(356003)(33716001)(486006)(81166006)(126002)(105586002)(97736004)(106466001)(5660300001)(11346002)(46406003)(426003)(476003)(1076002)(446003)(50466002)(23726003)(478600001)(229853002)(68736007)(97756001)(6916009)(6666003)(55016002)(18370500001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0768;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT010;1:0OnJuD92sr5hRDkNhbtyIV4lGHgFNJK0YgEG0sRYYbGhvR5caZ7qTx5lxXzTsbvkLqXm5RamsUrRfnMB5kmbP/3euwBDggTU1/R1pRaE59f60PHilamVMtCCwjhdH18O
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060);SRVR:SN1PR12MB0768;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0768;3:tHuxziZD+OM/Wa0mX2FyqdfG/TMqyYig+4bMdDcbqwYitQmHda5esctfi/X2yvZJkCu4hivkRCSQqumw45h2NdiBYMpcmOdYkd3dgtrb1MfCzDzRz9O/ylvIGAzYHXdGRnZF9tSeYfWvXJjDpEgikfJnFxzItSvYJrgjz95Bzcx+z3E4qkTJdApai7RSleXZOq6nYwiod6AaAZ/T+QR0+QqoEOfyOvneXVKH0q9fNJTXRLxUc2xC/x5yh8CtuHGg3hx7xPyWVHYPnUhY/7CStb29rFFWO4eoy2+3q6m7duX29jeSIeqMhKTcejy4HZUcSnhezrrggyjlARPHsHYL/U1MKNjhLA8GIuLHRJ926O0=;25:0YZoitJ8XsblUHDSd+1VnlQngSWgKFxNHF4n27XD4XPbjJnCeYkMOEhoebG6/kzhQXzr8CmWkUhIVU2aUeXzq6mJ68EOb3Ay9+kMS8OkQqpDWwu7C5KoanP4SNQkQZjJ7njU6GcVOFW5KofWgkBPoGM1FJrm4O4LuPXe+OKF1tYSq7c1XcO/XAStGXEL81p2xJsqt1cN0KyWsqMRsPkKTv2nmfC1Mzo7bwSWFEheDMuTubCXHsrhYPvwP5pUJ38Hi3g5KhtHoZEzgoVZ665fOWC3Mkg156LwRzs4Q1fDUx4r+ElvgPFnzu00N7xX3QJYmXRt7676YtUmP5Q1bt9CEQ==
X-MS-TrafficTypeDiagnostic: SN1PR12MB0768:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0768;31:z6zoAE/QZa0/4bHhpi48r6nfhsQP3ZbE1mMmvJSUXfWVS89aLxvjLC/aoCrkfILPmqaF0n9N3tTknJFhAV1WKDPLucRhTGId3L0g6w1FWH9Zqh86Kzg9SuE9IHhKmGOb/1uu0lvmDy6i9ws+NgZ+9A3mTUgOK4otGZhz0lOBsXxxULe99UQM4ZS9ow0T0K9NWvkxVKoUzCKfgO84PvWDYyfLy8lACdgFDYYJnHilek0=;20:AlLVgduOBK3+L1WHp2DjRju8MnHvuEWNY//Dbq7tf3JpUb51/0F0T8JTse9gGDD3aHddXVvAJivoZML7EhGY/uUlxdYc5c/mzmY25XHUxR8o6LyZbgubY0t4cULulVj/fYfRqIrElFBsySSZfM8o0X6YFFf9Rbmp5Y9ApzedKtZETifg4t5tQo1JadJDAjq99Cfcpz1NvMNSXqdTjQB4XoM0JAds6EyvyTE2yEzfAUTKOK/HW5ZwaAaoA8l76U8T58kZN/xHrhtJhQsxvqX0ekCJ2PCq+l11iIoYZ3qd+5Vl4fghsA5TPS3ob10642k+HqQWpxluxG8a1BceAJF3ZfY8x/uwoaQnMOMfWYLM9y8kZGYQcerAQyjLtqLaVCg2OPjPr91Fwrt6jd7Hg3PEgvL6CvWBKHLrlPA2lEbonMHVFeV5k41SlyYMewNvBgglz/IA9mKOqdIQC6HR0n/u28/+RwM6G9rzJFLN5vDSWXW+qDkK8vFsdwETID9iUfRt
X-Microsoft-Antispam-PRVS: <SN1PR12MB07681D80E4761C289FE4B800EC650@SN1PR12MB0768.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93003095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR12MB0768;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0768;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0768;4:UPVdyWDfmn7793L2l2zqAfqp26T2aFjawO/zo+7YpR3UXMkRMq2m1+mcWsHqLXsHOzIQlKN6WTPXqsar6PqDHgfzTy9lW2BTrkPS6dhQ+del0LyKx7qV8bA0JmY/UdU9uJFKhPe3rZsd0C/tu8GSdLRvuK1nenom+2/9mmF8CGeYGonKwpNHKndnalJjFgznpnuproyx9i7HrWzBTXKsAD1R0nzJ54XcCDNzP4p2lDea3CDrZTB0vyn7NMLOhHakT+wajAOHLv5JcBwVNe4gWA==
X-Forefront-PRVS: 06952FC175
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR12MB0768;23:3eC0wm2K+QTe78zP0EmoVEfw8CpilepsM+L5u7ad/?=
 =?us-ascii?Q?ExN1W0C24rArVb1qzV2DHT2mAgJcRnYFfa46TrvTF2llLvzAoe6g9h4148Go?=
 =?us-ascii?Q?0AQCgzBtuYbvkYK5oXOe3SexvK5+RaSI0MhoCnwGZGqX6OnT5ZcZHSDiyopN?=
 =?us-ascii?Q?33AtZ77m0n2CQoHHCUCRFfGpd94MEFnqleGfCpRJvksp7SDAfDm8If1lJLw/?=
 =?us-ascii?Q?a9CWO5BpzUPAjMFc6yUlIm+FpJBkdaNDAfLzMQoA0zz0CeThKZzr2G+dTRbK?=
 =?us-ascii?Q?6chrwU3xPL6cAMCrqZ12uvLeO4TpyQo0c/GbFWESxA13hmNvTM+2TCZMyghy?=
 =?us-ascii?Q?IzTbz48yAYAaFQN3NuY+aycu5y2l1rbzw3aSKdQK9rZOl4eQh+/JgOpeJsC6?=
 =?us-ascii?Q?ZBATdXLTOWMF+lw2gIoeD5rofLcYbBENxDJ5ymVktJ990PBerz37MRjTwiHk?=
 =?us-ascii?Q?K9ZuRIpID3UwJrFBFEGac0IUyaotElxU90oZEM8nFsNB9502xMjXihNbDiBb?=
 =?us-ascii?Q?6YNtLmA/BA64dwtBspxZ/iE258bApo0xfnPC9PB+6Mf3PxRKk5ONxvuN88jy?=
 =?us-ascii?Q?SolBJdJ1T1rf6Nkq7XR3jFfOPeYFxfePavI2JWFp3qmsvH0OlV9BqB0Gw/1c?=
 =?us-ascii?Q?bAU46Py3WScTeU+XJ5FLCyQT5MrW6Ix1k0MC+xSX7X7O+sitMO6hQftxi1yg?=
 =?us-ascii?Q?VMwv5ltqwkDhS0BIBtMylA4reTB+pSeIoe7QcKZnt+JPPt07gqrkN+kO8MnK?=
 =?us-ascii?Q?RbfMlwnBRPTUVBMf7nG8gZzssfsCA2we50+7Jgs/lsRyi9lDDpAxMKBKp1WV?=
 =?us-ascii?Q?RsT9Gqg4qo8PFmatJcorHKN9vyXlCFi+8rO19+SD4oVoXlzDhxqnRGfAEhaA?=
 =?us-ascii?Q?fImz5et8111j9fk3BUc9aMG/pOF7/+5lNDLcHUJHrN8HTQoTzBBoaRbya6d6?=
 =?us-ascii?Q?HKf1266EYmUDtSGcdtTBwY/S3vHGT9vytgYxftqYJYDWjwnRBcfQqLwwT6Pe?=
 =?us-ascii?Q?jbcqpJzxkQiSJX9RGeOXXuy2jv6wR9FVR8/0yAcvr9HP9FPiPPtR5LK0pKF6?=
 =?us-ascii?Q?ibvVdaW/NAZlA7/UQNX0XOUBVjnWRkfWf5f3DVDTA37bsX3deqE5ljktfQoF?=
 =?us-ascii?Q?7Bk/mNY3mTvZb5V8QFU5yFIcDXjTRJykm0KMiF5ilwtv9kws+AZl887yqFCV?=
 =?us-ascii?Q?ylG9wdpaBPFDzB8SjeLADKEWNKRx97vXNC1S70NRN6hcQ1ZDA6REvndY2+1S?=
 =?us-ascii?Q?iTIJvY7ewre/GSqMVCdv4BjErbqG8Ety/RDfVugNU2u8J5EnMzGI3DfkpvkJ?=
 =?us-ascii?Q?FbwywpK0m3EgMcvH7g4ykLs1lUsFGrDLG2GJxqEsjZsRj6SlbrxkuZj+QV51?=
 =?us-ascii?Q?+2MZQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: oI7O/tYzZORw8E2t0CSg89UIFyKisJ+qGLstZtJ7QMDjMkQGCpn1QyBPEPoTsX9c+L8PmFzCz6WpfuLheO8Ma17iNJIo09Bta9IlEUsMzGAmxW85eVn5JC05RKPYrCEsfqTepmDQW4CG0GjXd7zDnV+e7T+rcIVYn/Uau7eSAr1oUa9sC9CuYqeHx3eQ0nOF
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0768;6:m6xnMXxq4yfnUh/J2wJcvmXZYfM98ytUXbbQjQjcQmTZEwzNi5dY7XVz8Ok++JEcZYt36b305kF1JOUlcPh1MJ2rVsSFM1/bAsd9+RDYgNeKjgjWOxOAQ+kbVwUGIBueExnEeXd9Z3/teOITDEPboLmrUnN28s2v0ZcSFQcjc+39nxkmbe+znlp2pJ1IVZlF6IH/cJdullQwtaL7j7B9yhhZbFRmfuxFN9zJ08KyYZ7BtCpqW2gvbw8W5w/JctJVzitEet6OT4WpuQAozpMqAdBxW1U2wLd+wbnW74GEfaZvK3GBL4GT8vbD25Db5vrDvM9N92vrnFl67zuB3IhlHprwriweSDUWO4NzZ83AwHZv6/N7dcCQOfL3J3MHgE9rN3q1wpWScri8ZfpGEgRmBQg8xO95XN8se1wh+1GgzhRloxKAXQ9F3SsUpkkRXvrC9L/j2bLKTtKVwbEvFI5+rg==;5:ruh9PUT7WXhHTFlzA61u33WIe9zAQlXTZnJoih97QTIZusjM+rZJSblsivJfiMc/C5NEzh3Ha2aNPK3LDZIFDVm4S6hGsEsyQp6pV8Cll+GOs5xozwfdgyP4iifcafEoCmGbMrwKz+8TeWGR4hphtuoXz8vQ9It9vU28UeItVp0=;24:5quvo0Fck2b/0OJ4tmzDMz/B6QqW+buxt3JAzCfOs9XPTroSm2FeNOfls3tF3VX8l1EsOZiqqxBWQ0gw9z7DlfLKDtL2mWfuiKLcVyybFVw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0768;7:hhfslWF1qcYdcNQkoaTRrR3D745qSxJZy3uxlBG4nmnTnqM/S9SpZEk5otC2oIVNqXgvui5w+zgqhsO5gZVi91+vyUTMCKLOOVG6v4cVws/XmVfo72Z4VI6cGdleAnDBuOeLmm0nbV9IT4fK+1yeYr7YByYVOb8aMWsqAxDRcRFIv4HFn7lmOn7tbT2jEqom+J+Q7++qh7gbkxzEH572JI3Kl4EwsWg566ZInLSi1Fur7nQRtqVCN1KS7tMZdn6m;20:ui1TWN4s1YM5xhPRLIvHLPoSdw0NgW2LcFIv8VJX1bl9huDy2JXMhJTUl2tE54S/Q/XnDTz4ST0ojXEQ+9LUcU/wp/dtDloVifP8Oe/5V2E4PAknklnY56YUV4yp7uos9SX+KegyD9bgabxoLQwWzBRo2/z6g/FMRUtelgnlRm96K/CM+O0jatq3mstl9GqToeV7LOruPqHj0QpOrPJxojIkEApT392iT3a9HKXyTnnk/bf2RoLSa9o5ZFj1YJHZ
X-MS-Office365-Filtering-Correlation-Id: 03dafbf3-287d-4c8d-9cd1-08d5cb83fe5d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2018 08:03:30.8839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03dafbf3-287d-4c8d-9cd1-08d5cb83fe5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0768
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 04:44:04PM +0200, Borislav Petkov wrote:
> Hi guys,
> 
> X just froze here ontop of 4.17-rc7+ tip/master (kernel is from last
> week) with the splat at the end.
> 
> Box is a x470 chipset with Ryzen 2700X.
> 
> GPU gets detected as
> 
> [    7.440971] [drm] radeon kernel modesetting enabled.
> [    7.441220] [drm] initializing kernel modesetting (RV635 0x1002:0x9598 0x1043:0x01DA 0x00).
> [    7.441328] ATOM BIOS: 9598.10.88.0.3.AS05
> [    7.441395] radeon 0000:1d:00.0: VRAM: 512M 0x0000000000000000 - 0x000000001FFFFFFF (512M used)
> [    7.441464] radeon 0000:1d:00.0: GTT: 512M 0x0000000020000000 - 0x000000003FFFFFFF
> [    7.441531] [drm] Detected VRAM RAM=512M, BAR=256M
> [    7.441588] [drm] RAM width 128bits DDR
> [    7.441690] [TTM] Zone  kernel: Available graphics memory: 16462214 kiB
> [    7.441751] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
> [    7.441811] [TTM] Initializing pool allocator
> [    7.441868] [TTM] Initializing DMA pool allocator
> [    7.441934] [drm] radeon: 512M of VRAM memory ready
> [    7.441990] [drm] radeon: 512M of GTT memory ready.
> [    7.442050] [drm] Loading RV635 Microcode
> [    7.442865] [drm] Internal thermal controller without fan control
> [    7.442940] [drm] radeon: power management initialized
> [    7.443222] [drm] GART: num cpu pages 131072, num gpu pages 131072
> [    7.443487] [drm] enabling PCIE gen 2 link speeds, disable with radeon.pcie_gen2=0
> [    7.477319] [drm] PCIE GART of 512M enabled (table at 0x0000000000142000).
> [    7.477400] radeon 0000:1d:00.0: WB enabled
> [    7.477455] radeon 0000:1d:00.0: fence driver on ring 0 use gpu addr 0x0000000020000c00 and cpu addr 0x        (ptrval)
> [    7.477708] radeon 0000:1d:00.0: fence driver on ring 5 use gpu addr 0x00000000000521d0 and cpu addr 0x        (ptrval)
> [    7.477778] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [    7.477836] [drm] Driver supports precise vblank timestamp query.
> [    7.477896] radeon 0000:1d:00.0: radeon: MSI limited to 32-bit
> [    7.477990] radeon 0000:1d:00.0: radeon: using MSI.
> [    7.478062] [drm] radeon: irq initialized.
> [    7.509056] [drm] ring test on 0 succeeded in 0 usecs
> [    7.683793] [drm] ring test on 5 succeeded in 1 usecs
> [    7.683853] [drm] UVD initialized successfully.
> [    7.684009] [drm] ib test on ring 0 succeeded in 0 usecs
> [    8.348466] [drm] ib test on ring 5 succeeded
> [    8.348921] [drm] Radeon Display Connectors
> [    8.348978] [drm] Connector 0:
> [    8.349031] [drm]   DVI-I-1
> [    8.349082] [drm]   HPD1
> [    8.349135] [drm]   DDC: 0x7e50 0x7e50 0x7e54 0x7e54 0x7e58 0x7e58 0x7e5c 0x7e5c
> [    8.349200] [drm]   Encoders:
> [    8.349252] [drm]     DFP1: INTERNAL_UNIPHY
> [    8.349308] [drm]     CRT2: INTERNAL_KLDSCP_DAC2
> [    8.349364] [drm] Connector 1:
> [    8.349416] [drm]   DIN-1
> [    8.349467] [drm]   Encoders:
> [    8.349520] [drm]     TV1: INTERNAL_KLDSCP_DAC2
> [    8.349576] [drm] Connector 2:
> [    8.349628] [drm]   DVI-I-2
> [    8.349680] [drm]   HPD2
> [    8.349732] [drm]   DDC: 0x7e40 0x7e40 0x7e44 0x7e44 0x7e48 0x7e48 0x7e4c 0x7e4c
> [    8.349797] [drm]   Encoders:
> [    8.349849] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
> [    8.349905] [drm]     DFP2: INTERNAL_KLDSCP_LVTMA
> [    8.430521] [drm] fb mappable at 0xE0243000
> [    8.430575] [drm] vram apper at 0xE0000000
> [    8.431194] [drm] size 9216000
> [    8.431245] [drm] fb depth is 24
> [    8.431295] [drm]    pitch is 7680
> [    8.431406] fbcon: radeondrmfb (fb0) is primary device
> [    8.496928] Console: switching to colour frame buffer device 240x75
> [    8.501851] radeon 0000:1d:00.0: fb0: radeondrmfb frame buffer device
> [    8.520179] [drm] Initialized radeon 2.50.0 20080528 for 0000:1d:00.0 on minor 0
> 
> in the PCIe slot with two monitors connected to it. radeon firmware is
> 
> Version: 20170823-1
> 
> What practically happened is X froze and got restarted after the GPU
> reset. It seems to be ok now, as I'm typing in it.
> 
> Thoughts?
> 
> [197439.022249] Restarting tasks ... done.
> [197439.024043] PM: hibernation exit
> [197439.058296] r8169 0000:18:00.0 eth0: link up
> [200941.240184] perf: interrupt took too long (2507 > 2500), lowering kernel.perf_event_max_sample_rate to 79750
> [221973.686894] radeon 0000:1d:00.0: ring 0 stalled for more than 10176msec
> [221973.686900] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000010da43f last fence id 0x00000000010da52d on ring 0)
> [221973.686929] radeon 0000:1d:00.0: failed to get a new IB (-35)
> [221973.686950] [drm:radeon_cs_ioctl [radeon]] *ERROR* Failed to get ib !
> [221973.693971] radeon 0000:1d:00.0: Saved 7609 dwords of commands on ring 0.
> [221973.693985] radeon 0000:1d:00.0: GPU softreset: 0x00000008
> [221973.693988] radeon 0000:1d:00.0:   R_008010_GRBM_STATUS      = 0xA0001030
> [221973.693990] radeon 0000:1d:00.0:   R_008014_GRBM_STATUS2     = 0x00000003
> [221973.693992] radeon 0000:1d:00.0:   R_000E50_SRBM_STATUS      = 0x200010C0
> [221973.693994] radeon 0000:1d:00.0:   R_008674_CP_STALLED_STAT1 = 0x00000000
> [221973.693996] radeon 0000:1d:00.0:   R_008678_CP_STALLED_STAT2 = 0x00000000
> [221973.693998] radeon 0000:1d:00.0:   R_00867C_CP_BUSY_STAT     = 0x00000006
> [221973.694000] radeon 0000:1d:00.0:   R_008680_CP_STAT          = 0x80000645
> [221973.694002] radeon 0000:1d:00.0:   R_00D034_DMA_STATUS_REG   = 0x44C83D57
> [221973.768483] radeon 0000:1d:00.0: R_008020_GRBM_SOFT_RESET=0x00004001
> [221973.768541] radeon 0000:1d:00.0: SRBM_SOFT_RESET=0x00000100
> [221973.770637] radeon 0000:1d:00.0:   R_008010_GRBM_STATUS      = 0xA0003030
> [221973.770643] radeon 0000:1d:00.0:   R_008014_GRBM_STATUS2     = 0x00000003
> [221973.770646] radeon 0000:1d:00.0:   R_000E50_SRBM_STATUS      = 0x200080C0
> [221973.770648] radeon 0000:1d:00.0:   R_008674_CP_STALLED_STAT1 = 0x00000000
> [221973.770650] radeon 0000:1d:00.0:   R_008678_CP_STALLED_STAT2 = 0x00000000
> [221973.770652] radeon 0000:1d:00.0:   R_00867C_CP_BUSY_STAT     = 0x00000000
> [221973.770654] radeon 0000:1d:00.0:   R_008680_CP_STAT          = 0x80100000
> [221973.770656] radeon 0000:1d:00.0:   R_00D034_DMA_STATUS_REG   = 0x44C83D57
> [221973.770664] radeon 0000:1d:00.0: GPU reset succeeded, trying to resume
> [221973.786437] [drm] PCIE gen 2 link speeds already enabled
> [221973.788725] [drm] PCIE GART of 512M enabled (table at 0x0000000000142000).
> [221973.788745] radeon 0000:1d:00.0: WB enabled
> [221973.788749] radeon 0000:1d:00.0: fence driver on ring 0 use gpu addr 0x0000000020000c00 and cpu addr 0x0000000063adc4ad
> [221973.788936] radeon 0000:1d:00.0: fence driver on ring 5 use gpu addr 0x00000000000521d0 and cpu addr 0x0000000088b51197
> [221973.819814] [drm] ring test on 0 succeeded in 0 usecs
> [221973.994512] [drm] ring test on 5 succeeded in 1 usecs
> [221973.994522] [drm] UVD initialized successfully.
> [221984.438892] radeon 0000:1d:00.0: ring 0 stalled for more than 10448msec
> [221984.438898] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000010da440 last fence id 0x00000000010da52d on ring 0)
> [221984.450978] [drm:r600_ib_test [radeon]] *ERROR* radeon: fence wait failed (-35).
> [221984.451011] [drm:radeon_ib_ring_tests [radeon]] *ERROR* radeon: failed testing IB on GFX ring (-35).
> 

Ring 0 ring test passed, but fence is not back from ib test. Is it possible
that page table is corrupted after gpu reset? Radeon is legacy driver,
Christian, can you comment it?

Thanks,
Ray
