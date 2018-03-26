Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751739AbeCZGfm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 02:35:42 -0400
Received: from mail-bn3nam01on0077.outbound.protection.outlook.com ([104.47.33.77]:48357
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750981AbeCZGfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 02:35:40 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, bp@suse.de,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 0/4] x86/CPU: Update AMD Last-Level-Cache Information
Date: Mon, 26 Mar 2018 01:35:12 -0500
Message-Id: <1522046116-22578-1-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR1201CA0024.namprd12.prod.outlook.com
 (2603:10b6:405:4c::34) To DM2PR12MB0139.namprd12.prod.outlook.com
 (2a01:111:e400:50cf::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f7adcac6-045d-40b2-c857-08d592e3c8c7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0139;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;3:W8rGASJB1uTAkfaI1e2fTdxtv55vFQAjSCcgaiPSNgkybErwOu52plbQH7RZ+DcplmMOQhh5h16VstCdau96SoN3GfRT7icfA5IHd9THVszKKI1XR3GNUgHPgWuZ6tmqUngpfUrK9JtshRDvcD5qPCEwLPj1wZAtCV6ckYSY7vODpsr8+3z/hIIJqC6KFDVpB2pURXAVcUGyYmy2GurEBUnMwpEh+AgtyEgKNKTJ8DhdnXniW1AqWinGeK36QFF+;25:yFK1m1x8K2KdXe7azv9Ns7TBM9MUBkdMCdONx9PwPB5+nYL/eVe/5U4+k6pJjY4g2DaOWszYfQOAOMu9yZbQNqw/8oKBXG/j4FNxpsJqYo6NcAZf6WWOpeKsD9ZEMBsmp4BVX2sbLmgfg50UyKkNkZe2u/kSt6hYRZipxCl5eIGlNBab2X1vqQVVZqMNKIl8zXaK1Q7bdOsfP+zcjOuJYTCJUUFC/T7xl9UgJrtHpKhwbkWeHghMKRrE63l/TMbYYKlFDEf4uYp1ig4y5hkB7I81FMwKS/6onlf3H7no9Wbau0q7xclbHe1qJH7bg7EAuP1OGv1rMwZnkycziiQY0A==;31:erDn+2pz1XsDsHP1ZTNnVRE/Mbe8z44Cg98Gcr4ziLzsXNKy3SkCNx7/VBHsDh2uwZSboa7bvGqsL/kiY4/03IKA2rydIdB1LJLVkptrI99Hi6UPUxiay9ME6WVRKoPSggsPgoIbIQn5ZOHH/u0rVpqYII7MBCpvJnarT/fE/5sBXyhwA1nKQ8xnM/aPNboF1XVh7dRg/2AW2Jl4WCqpxRbatGRC0cOL1L6R02JAH0c=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0139:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;20:VkUdg86mbLMLxhvS2kaaWdlERKnVT1JpiAm54rHrG/ewUjdveG1F6CAXQQXR3YJMJGTeeFHaomtbiPbAeISoGd6R4Gncq7kDmd1V6K5ys6kQXa98u9YN7bz0fPfhLlMwReORFBBvGdRD/AwRdoJNDLNRH+kAYb+SX9mfrWD9uEna7Iq0EV6UdXEq3so22GZXrjrfR2Tf+oj/SVhhkh09CiB3ytoCof9Uj1W2jSmjmHAmw2NNyjT7JbTBSeBN2zv2FOwTsWp/MTcwlwFTz+xhje9HVZqGhVJjzkWpDPZwXW6zKjaOP3aAHZAcyVuVOvXyr9pDsSlYMFXiHgVXH158IZcX3EC7cWLaNs24HohABDavmI4y1gSMD5JusKX0bidGTq7qZ+fuwTLWDGF6aAlbawdu5mB5yF2Gs1ROXRDRwHBHc4DG5QQRGR3+n8r2OxyFM0z+jykoJqdD1o5qBuglOvEr0q76UVf1J5Ru/G9L8wiLE+CtXk5h/479WEv/C+vv;4:wWmuBVvzdK9LBP9LHW9JJCe93zEVOxKuIUUhWjW1F6bwZ0FpQWiMMC+0cH7N9X5MzbOqv7Lkc4KNE67V8Ot9EgicbzNr2PQZyS6dVLyq93kD2AcFAjKxVGdO/we9uhXUAHvbvFEOX8MnuJRMdCx8MANByuthepH3EWdEpMH9pAAmPxOXhQ82O2tbUxKty0q2TePvgJfLcweDkR49BlM8J0hnVhEDaoPnKjeTgile7cxjTQ5d5s2p4ORhJ6dfa71rOSBZr7QORZgraVTfdPkTbQ==
X-Microsoft-Antispam-PRVS: <DM2PR12MB013962E1DF6CE6AB4A269ED5F3AD0@DM2PR12MB0139.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM2PR12MB0139;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0139;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(366004)(376002)(396003)(39860400002)(189003)(199004)(48376002)(16526019)(6486002)(52116002)(316002)(186003)(47776003)(86362001)(3846002)(6116002)(106356001)(105586002)(53936002)(53416004)(68736007)(81156014)(81166006)(478600001)(97736004)(8936002)(72206003)(8676002)(16586007)(956004)(6666003)(25786009)(7736002)(305945005)(50226002)(50466002)(386003)(4326008)(26005)(7696005)(51416003)(36756003)(66066001)(2906002)(5660300001)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0139;H:ssuthiku-ubuntu-b2.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR12MB0139;23:d7fdLOOo/atafqmVHzmUSmWtYo6tr6x31gH4/0RRo?=
 =?us-ascii?Q?ThRo2KPoyZg08fHq6fOlrVUWL6smiIeIfioLGqU2bQ74DG6tXFCWCJUqXJge?=
 =?us-ascii?Q?K7BkqW7KrSqlmIvt3esutDpLPCZmijY1o93EHYa781EeTaWrUs3UruyT1QNq?=
 =?us-ascii?Q?P/jBjCJV69/guF/dwcCBV31u5VT3rT62Cvpi/b43p5/BeWzkGX/8JxLItiCD?=
 =?us-ascii?Q?sb4+Brp/GTknu1VMEaWxsBUy77Fn38k5AVbmm1r3KO1adDsCdXFRVrRdE6SS?=
 =?us-ascii?Q?KJpuy8BnnXgbSMAhX6vzNBRZk2OI1iF8j52G1wOsoWsSZKQNXUXG74enPkBQ?=
 =?us-ascii?Q?vaGmz5/0vi/ZArK2duwaFxfgjv99FwB/aguguFR9KhA5HVuF+8HbbpYvWAx2?=
 =?us-ascii?Q?bhjke+TA9Q0smBEUAMcc9bdrfcZXMOereeqx0jCKxx3z2iHO7YBDhOU2do0d?=
 =?us-ascii?Q?jR4ig6NABbAltL6BAGjaiYvsYyuJ3q2JjTgIGEx04raMfbcl2TjXe7aOU6ku?=
 =?us-ascii?Q?pppESbEbvREbsEuZ1IMy3AR+AU2BkncQxxbOUXHHm1FEekOAQeFouO7Rqsgc?=
 =?us-ascii?Q?A3KVrYnWTJ3xwRQTvg6l+7sxypj36pgtgGnr7W4k4pFvF6hrBsVc5wov3L5Y?=
 =?us-ascii?Q?D1zWNkveCmPU6aaVXS5dQg3dBwy6Vew07vXAEF601JW6fIQjKuMcVBYaK9Vo?=
 =?us-ascii?Q?imEOGqFbFAroag4G1/T2fX+9rNlfq/gijRa8BfFgIpZO9+iDClME2TwjwgFx?=
 =?us-ascii?Q?ooTcO9RvS2/GIxGUgll7c8sm0U28R3qezXN9D5DMHlsmfAuv7SMaOT29STuX?=
 =?us-ascii?Q?/Y4NqXpBD/oTCwc4AqtY5XpbTN4mL4Wi/f0Kga/7M8QmyvTekweK/LL2eYfO?=
 =?us-ascii?Q?xBpMf4d5ixewRTWozgdIC/03oHp1yDbASvZdN6mkYoRCEogAmmb++1t/Wahe?=
 =?us-ascii?Q?YVSPS5fs964uwjlsJaDMOiPqsR6u+WMQS1HXLGZkAqe6UflLCIkDOjYwsfDS?=
 =?us-ascii?Q?kHsSv5IZidFc+h12Eyb/lWDm6w5vPToG4iS4bJCruZ733zWhakaAl+wkUg1E?=
 =?us-ascii?Q?BBCeH6As9ohxagAh9P0VcHsjyIz0nLINilJd5Aq4niWCAisaw=3D=3D?=
X-Microsoft-Antispam-Message-Info: gfoUHMztfo5obuy5iQwLAkHolY7XVz2x3itetPhC6uwxIHEUiY/Kl/HVolGjT9ksdnVxQRYJcCkR/JqiW8TfUbjFXBLXACPPMty51Ao/vHlYzxCeMqICWYBq6LXn/GpdEcsG4vKshYtBRlZACP7UU0BQsPoLPx1zLUYww/QoQPqYAlJEZbhKY32Cvlv97Imo
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;6:ERR0WfsZNIINts/eJawlCl+6gPI3koVnda4FS5tdeBBtmHaOEnRH/eqlytFp2U6obuKmSyTuEzpNWqOYzIABvrFoikTW3MBzhjlOf1JGTfdJ9G2nQ3EbccM6FIvN/lJ1rztc1dGXGno+WlWpv+Kftg3dyWyL2P+p9r29eCCEFCxwz8HLsEudv3pAsUc1mhlYEGQyh1d1iT8L5Hy9adicJLM3IcZQXeXICeKv3V3YBowa0zJtq9FwovIdgzmrqw3q5NJlijBkWCCxMekK1Iy/65Cm8rt6tEvdrJRi/urpaIz8E89g0dmSwVvbm9WYrcwKZI7utuo5fqi2cGR0a0lqwtJTX3C0iVeU3X0EfrrYyLk=;5:ZFyFsS1hgMurazTsPFsGyAMKCzvvcaQbOoQzLByOhkLEoIPgh6Qg076XBvmLGkAp6cpD9PEHFFr3/JiurRCxbyeg0YjZNJKUiZcFjmvaq4qpzyfwTV/dzEB9vlI/+uzf2zKgsSdXjxSMO46fd5Hfhq0KgvRbZJltvBTciiakmEo=;24:v5umZMIHgNVfdFnnrb2WpSqWMQaOJGmv+pOIymzkjmXvmci5woxvPRuSAi/7rES725/Fl7ZEoF3CKxEQcUdRoKey1L1XzmbQd5R+5o9RjNI=;7:FVH/2rFnuz3NDkD/+nF9IOcc3YnPwz+Laj/AssoTBB0ELKcl0tJjaMzV02chYUS0WUHfRzzqEMgfVP3O4Dz0OE9V/WEJIfdQ7Rm2Iip+idYSoz4hbbo80FaE1P4y0h8ZSf8KDgTIPD02y58KDD/A5u2p1pBapHosUSqBVTt0iF2pRv6iWcr3lyZJ4/x248L0RTad384lmfg+pHrEF2zMxJraHxae2e4uZ1uXppImpl2oABeKOpwQWcio84E63K6S
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0139;20:K4SEk1twreJ+ro4m4zvAiT4hevlSSqMMUssF1kMbRDV7Coo4nBw76l9NleDLrJIzJrRA4nqKuyk/Lvuyudk1yBApOw0oWz8Po/2wB53SwAXis0Hmy+L0QMNo+fUsRjCkBJYAbm2W1U56VkYB20Csj4wVUYSGX/zZ1kOuwonChrfoOIReBByljMWYA+ipod8be5zaWRUMzXTL/AOjyfEw6t4rscSYqsx6c4wJtJPbchU4zHMHmpMx9WjKoVY0TYlo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 06:35:35.8435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7adcac6-045d-40b2-c857-08d592e3c8c7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0139
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First, clean up last-level-cache parameters so that it could not
require ifdef CONFIG_SMP. Then, consolidate cache-info-related
code for x86 into arch/x86/kernel/cpu/cacheinfo.c.

Finally, for AMD, introduce new logic to derive LLC ID from APIC ID.

Thanks,
Suravee

Borislav Petkov (2):
  x86/CPU/AMD: Remove unnecessary check for CONFIG_SMP
  x86/CPU: Rename intel_cacheinfo.c to cacheinfo.c

Suravee Suthikulpanit (2):
  perf/x86/amd/uncore: Fix amd_uncore_llc ID to use pre-defined
    cpu_llc_id
  x86/CPU/AMD: Calculate LLC ID from number of sharing threads

 arch/x86/events/amd/uncore.c                       | 21 ++----------
 arch/x86/include/asm/cacheinfo.h                   |  7 ++++
 arch/x86/include/asm/smp.h                         |  1 -
 arch/x86/kernel/cpu/Makefile                       |  2 +-
 arch/x86/kernel/cpu/amd.c                          | 25 ++-------------
 .../kernel/cpu/{intel_cacheinfo.c => cacheinfo.c}  | 37 ++++++++++++++++++++++
 arch/x86/kernel/cpu/common.c                       |  7 ++++
 arch/x86/kernel/smpboot.c                          |  7 ----
 8 files changed, 57 insertions(+), 50 deletions(-)
 create mode 100644 arch/x86/include/asm/cacheinfo.h
 rename arch/x86/kernel/cpu/{intel_cacheinfo.c => cacheinfo.c} (96%)

-- 
2.7.4
