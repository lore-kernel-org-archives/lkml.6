Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759367AbeD0VfF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 17:35:05 -0400
Received: from mail-cys01nam02on0085.outbound.protection.outlook.com ([104.47.37.85]:62624
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1759082AbeD0VfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 17:35:02 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, bp@suse.de,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 0/4] x86/CPU: Update AMD Last-Level-Cache Information
Date: Fri, 27 Apr 2018 16:34:33 -0500
Message-Id: <1524864877-111962-1-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR15CA0030.namprd15.prod.outlook.com
 (2603:10b6:300:ad::16) To SN1PR12MB0141.namprd12.prod.outlook.com
 (2a01:111:e400:5144::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0141;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0141;3:KYbUk/REzvzDEhmI02LbY/427fLxeqyloD0dNW6tJ0gQ1m67cB719iTaBR9SkHgrI2Vw0OMdmLt9tPWrV35MbXIpMgI1NjLa3XFSDRWupNpMXBlBHqXqT+fiObWmHAG4tOlMYD+pHZ2WP3Mh2JCOxKsRmyYFQKpHWwB5K6p33fX/5Ltz5vePAfsJMz94RRiQ3bcfazQNj/BpfCPA5TikMErXKPkw1/jZdkgMo7v5m4vrwCKjqDu/ZEZ5IojA0rtn;25:2gakNy0fK2k1E6UUenaOt4KI5b+cIsP0ZJ8uChtT2+55x/v2UHxg2QxXzGQhRTNQfuJBHSwDArIT8x0pdZZY+BhX8KmoLeHN7nC5LUciHdN+FRGnQix+93s79CDZVTjHnlUEutFPY7GciyNBfezIHFBmXZPdlSIPMnCNpKzmDrsLlTmlv3uxe/9s6tDxb+oZY/LeTuIRzNI794AtS+ZDpAYpQIJIG5Zbs07fkbK3U8f2qnQiX0q9HfiyMt2Q7AvpwCy08nDOYHauWryWXeFrpg5rToTWf61eF0Rq4segy24b3gsnRNReOmt11hI3EQrKDH7t4VzsJgDrNJhJE/r+rA==;31:GhA20kNozwyvOu0DIIgBaxRoEN4RyKUYdlnnBiP/VJSY0oWjN2K7i4GlRTUkInNx161pvNDrhvzX3vnnmyzXbp7oCq2DmqpJM6hnvxwcykeSPQ9A648AhjyPlirR/uAhcCa5gHRBZoml5vnP46oW/zuCY+ylTyt+E/9tA1crHTxtWFsitiZPhzJNgV3aj+1ieqZmvoQGSGQwhCnHwxQ/SOnDTRpUofvlwivV6MsOebc=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0141:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0141;20:iYTQnbUJZ5AqCNFzAW85PEJgieaBjvD6O9qsrMLSAIf7Lw8UvcGCg9axX8rdvIwdhIJcLoqDh/QNLrphK5RxJBJ4PQ0FuIBi6oNUbDbyMqtwS02zvoTMSZZyBt+HCGG7RCGiI6LE2pURWlwyTWRYv67Bacap+CQJ7eDFwEh6ZDLRkcTFms2p3HkYI6fc6gIl1PsyqLGMKfm4ZgZVGDA9qJRwM1cU2dE5L1dKWozF99SO8m2uGEPDNO8XQuF142AbCEFIMxzLgDq7SnZ+rNGPDLX9kq4arIh10cnRq7IzX2YPBTsHC6PuV/zAcaQ93VTbgZBnBd9cVT//B9ZIlK8f9VE0/3BTX/hUAWSvqHq2m64W4J/l8H3FkqoCjs316erSfEX8wy2EVfCKFa4F9cwsGvAs5pp7DWBPn39yxwdlasQpBgO5T6adf/BarNF7fM5L/7kY5xP/OiigmyACrHv6QGg/GMzYpPuxP4bKR57Bn6fLHSFJtT1R9bhQ90dwGHNZ;4:inschx2Ms7mHkJMd6kQzjScsycRi/xsxV1VMpnFnufK/b4afd9ZllpxRtx9/mLpuvAKuwPx0qLd1Iu2qOSMHSjk35+PQv+0ESc2CHlTE+Nw0goXymD3VJKi10JtveSISntbw+nW1hWpXTifztZ/uTQLsg47VmJU+ZHhmlwGYYpfYvshUMAtWloMUNiZCSvWIG4IioKDp/I+f5JmvKrbpO4dKQfACkoxMEZzYu9F28C6WZmkNVkkgHfSfyU7MZ6QFnp5xEPgndD2vpiblz77smg==
X-Microsoft-Antispam-PRVS: <SN1PR12MB014164707A4D98C953523CCAF38D0@SN1PR12MB0141.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:SN1PR12MB0141;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0141;
X-Forefront-PRVS: 0655F9F006
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(39860400002)(346002)(39380400002)(189003)(199004)(478600001)(956004)(72206003)(44832011)(2616005)(486006)(6666003)(97736004)(2906002)(52116002)(50466002)(26005)(3846002)(6116002)(51416003)(7696005)(53936002)(476003)(48376002)(6306002)(6486002)(186003)(50226002)(68736007)(81156014)(105586002)(86362001)(66066001)(305945005)(16526019)(316002)(81166006)(7736002)(53416004)(386003)(5660300001)(8676002)(16586007)(4326008)(25786009)(106356001)(8936002)(36756003)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0141;H:ssuthiku-ubuntu-b2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR12MB0141;23:osiwGonHVwBeTfscJ2kHWnWxEbifd7GqmIUsiU2bl?=
 =?us-ascii?Q?IxNCshjTzxlrKWfAN8z5x7fRGJMjC1JrB6XzfSTElzOoTaBsThcXTh0PbZ9p?=
 =?us-ascii?Q?74gVce1qa9Axx3remtAeOZG92xDbEK/RNwaRFoyebPWlrkS25584X5BH4Urr?=
 =?us-ascii?Q?XE6Ds0d/UwuSjwp9Y73+8tauhkE8jtHUsgDdrY+9ShleK9SlShbk3/IRf7IY?=
 =?us-ascii?Q?6UdLDUB8i6A3guJ816t7jYA6UawV/S+teqN/4wXsvHnYRwdFAahh0kBxPxcL?=
 =?us-ascii?Q?IL1ys9/+FK8wukJQ7nNUdNY83f5QmxRoZ7rBvEOcm9T4bQlv2xDvti/FClpD?=
 =?us-ascii?Q?P5pxqKuxx/oWoUsxhRNBYyvPcI412R809myV7pBNCSJ6snh3kL6jeCorlFkl?=
 =?us-ascii?Q?Ke2EyRkgAYlyyENq2Z3WmjM4kVA89ALZHh6TgQBPGKGY71gmcQtzi4hOuUcc?=
 =?us-ascii?Q?hh7Q0x4BZfhiQrDHnin3NNBB4atLb/dZYYaqwO5uueeVcBykTJzDKXngRxb/?=
 =?us-ascii?Q?/Uayhayg52u5kdcIvMnSCgVl1uq6ZH+xu0J/5lUqMRw6W/ySUg4RqIb83Okc?=
 =?us-ascii?Q?lB1/evG6+yWGUaTkzn6AsQc19q+hYRKIpxxQUHlRlEySUoBiBJUNUswhGDFl?=
 =?us-ascii?Q?OHRzyOiBFnS712iOfmODQPski3MLJYSyAMArnzR9koILs12h0XSMCLiY+jrt?=
 =?us-ascii?Q?qF/ytp8Z3Jb4WFgn9TU50hk2EzMNcMXYyHtIwxSayARL3Ubc+cOlTr5wi39o?=
 =?us-ascii?Q?WdzN1Aqu9/NLPv2Dq36H1gVteeVbYT131lyti3dbdob/WlnTODxW3J7IN8rY?=
 =?us-ascii?Q?6MGjnYik7nnG+6pvjEMJquA3r027HlfmmDmyG8kz/T6GI+ZFKeIuFf44PvaM?=
 =?us-ascii?Q?WtZ7oNM6ozn6Y/ej06+3+aIMd+Y1S+4+lTGtZWrpb0O1Ee/aFpumw29jL4rN?=
 =?us-ascii?Q?pkOanvND2rlMP112zYQdXfYBcLJ3aTorRLveoHXZWhpRJ/8ho3WwRpjsaas7?=
 =?us-ascii?Q?HGCFYvYZGmw6w0+WMPYCMmeIGJDdSHsThQsjhElxKDMaC2rlbpcZfrLDYDaM?=
 =?us-ascii?Q?na0i6nZ15/kXYzRxcNfdXgwSwoPEgqgjoZ3TXIhhQknyW1zvH7EkXcH+SOss?=
 =?us-ascii?Q?toCwDmEBQeJZizaGPS215AEUakwvL7gV3xTxXViKzvBiEXI0Sydhw=3D=3D?=
X-Microsoft-Antispam-Message-Info: PcagDZMsQw7cs+W1DLPDqSOwwh7irswgWIZnsai3VGaTY5xlx9PSZkGtVOC2tAh2g7JnDPFdrIDfPPjFhdXJzBHJI7IbNejbirNPZDdw39Ka1aUDjDDEYMNnUzXfeIqfw0XHZMN5B8wkGUDuK0hgJxx5SzmxdQaL0FcFJ0hjxKSIPNZRmyL+N8qIX5cArY6e
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0141;6:Pubnl2wRZJ6Y+Vy2B7idT3PCGslBWjbsYExblCJbWDK6Cds/eQazst0FcNHeKdm1AuoliVRbze4jelrUKWUJA/PuqaJkZOQFgYtGfmRkBWY5MYFFiKwsWRkgyn6MBuvKT5GTHkecmZPMMAu0+cr2Qki0jTmSzP3v19KlKXk5zCk49bHhlKr0xakz019TaRmvykpB0Pz6xkPpdADbLk1sHnJJsl3N4bxSfnKXVezPpoY7FyArUvI/T6b8fJg6LEurYTijQ98JEsnTukk9q3VjpTSYZ+t8xF/yeQ4jia1njm3gEl5aLtyyqoW9O5oZOum7yG/iBblOD1YMSQ4EOXEHoRRYgTPeAEpCaxEENUfEAANlHkdp37ZjXinowBxMWdCrcLkiGr3x4Ho/2erR7PhOWnitlfQ4VV0kxaHdN7fJWz21e081KIzSdNw4ou+XSX+Uigjj4Rjsbqj0ik/o2UZX3g==;5:GY2A7y1+BMD7vbXzh0x4al2FNNT6qBcs+24bfc68CnqgxGelOELYvRgT5MailRjwqcf3pqJVFTIoNV9+hTv5e5AOcnPuJTMiNPH9UO6wde+uEj1QIF+ew6mYjS0OUHd89ObSoGooaiGkRnZihqriLaW3F9SXUUwZfYSnQIXOR48=;24:9DJSphKzjM8gca6DsFE4CYG1djoTb+dgbB2aIFrUlroVucAN2/fuAaAFp/vbpn9a+L+hGbwtP1WzvqKswyMuZyVumiqrYI8e3zpke4aCYvY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0141;7:wzSOrfkqRBcovE8Czm5o7UICT5b8IPI8o80LoU3SmOxxr8iGb9pyuHZwixjFWt9tp6lw9gNtXwpax5/rCoiKBz7ploBFnPUstR7YBoln71Q50xvRReprtVgNWYK20iOYXm2l9OgDIWbaq5FnjpleoGRHGx8psgEnMhiHzQWhfQtMOgwH/7glN1swY+NkrOAzDWF9/PPDLYTdyBup0b7Rw4U8U5wIHblzOktRzNrdjjuv49D4pfof9xR0QLUrP5Qu;20:uY1Ljqem3YnVTnLLasIZhlrNNspCVVLkhnIdXKS9OYtfhSFXAZwQJGC+/T5+P6Tsy0hyzHbb1K9CqZlkxUXR5uHwnksRIYyLvUxCjkar6AdmnurzMRWXYjX+E+okooXzagwDyhLF298UIc29CWAptzdzYr+F30lA7nmO+pyK11yhW8YNIDqvzH9JJkgN6Cwb3yjLb/RylBHdtPQhyuzab6UwxIdeZfCV/cVbbvqYOMbP5mnWY0jlInDEhOW/E2GF
X-MS-Office365-Filtering-Correlation-Id: 7016226a-ad31-4b82-5ee8-08d5ac86ba39
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 21:34:58.1460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7016226a-ad31-4b82-5ee8-08d5ac86ba39
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0141
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First, clean up last-level-cache parameters so that it could not
require ifdef CONFIG_SMP. Then, consolidate cache-info-related
code for x86 into arch/x86/kernel/cpu/cacheinfo.c.

Finally, for AMD, introduce new logic to derive LLC ID from APIC ID.

Thanks,
Suravee

Changes from V1 (https://lkml.org/lkml/2018/3/26/24)
 * 4/4: Do not EXPORT_SYMBOL_GPL for cacheinfo_amd_init_llc_id.

Borislav Petkov (2):
  x86/CPU/AMD: Remove unnecessary check for CONFIG_SMP
  x86/CPU: Rename intel_cacheinfo.c to cacheinfo.c

Suravee Suthikulpanit (2):
  perf/x86/amd/uncore: Fix amd_uncore_llc ID to use pre-defined
    cpu_llc_id
  x86/CPU/AMD: Calculate LLC ID from number of sharing threads

 arch/x86/events/amd/uncore.c                       | 21 ++-----------
 arch/x86/include/asm/cacheinfo.h                   |  7 +++++
 arch/x86/include/asm/smp.h                         |  1 -
 arch/x86/kernel/cpu/Makefile                       |  2 +-
 arch/x86/kernel/cpu/amd.c                          | 25 ++-------------
 .../kernel/cpu/{intel_cacheinfo.c => cacheinfo.c}  | 36 ++++++++++++++++++++++
 arch/x86/kernel/cpu/common.c                       |  7 +++++
 arch/x86/kernel/smpboot.c                          |  7 -----
 8 files changed, 56 insertions(+), 50 deletions(-)
 create mode 100644 arch/x86/include/asm/cacheinfo.h
 rename arch/x86/kernel/cpu/{intel_cacheinfo.c => cacheinfo.c} (96%)

-- 
2.7.4
