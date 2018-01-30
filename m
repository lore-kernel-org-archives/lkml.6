Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753623AbeA3RdE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 12:33:04 -0500
Received: from mail-sn1nam02on0072.outbound.protection.outlook.com ([104.47.36.72]:33552
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753348AbeA3Rc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 12:32:58 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com;
From: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
To: kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>, Len Brown <len.brown@intel.com>,
        Kyle Huey <me@kylehuey.com>, Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>,
        Kan Liang <Kan.liang@intel.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Subject: [PATCH v4 1/3] x86/msr: Add AMD Core Perf Extension MSRs
Date: Tue, 30 Jan 2018 11:32:41 -0600
Message-Id: <e19f9cdbc3c4c6496ec03e32b6ffaef8ec4b532c.1517333237.git.Janakarajan.Natarajan@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1517333237.git.Janakarajan.Natarajan@amd.com>
References: <cover.1517333237.git.Janakarajan.Natarajan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM5PR10CA0015.namprd10.prod.outlook.com (10.172.33.25) To
 BN6PR12MB1362.namprd12.prod.outlook.com (10.168.228.20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8a7d5a77-c120-476c-4f65-08d568077f2e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR12MB1362;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1362;3:X48geoeU6pMHjZQRYfJ9A9RRWeTRG7EofXxkxkajC2G9uHmS23qhclPT/GX0XU0diV+ZbLjWZZtpKSUwb6fe5QYWpbgrIfCy4wNJ7sSVDVefDFKFdZzL8EVw5t0BQnswn6RaqtHo0VTjnsyJnUOXwLJw9C/zM0gvoSIMtuaiGxMo71EyC2gW8/HUkxdWKZPenclAtNVK3I9+Ov5cKWcy9iGFQ09C+qck5Qs4IUW4fDTXBy7DCtqlR0pVuK1lCtJs;25:fWiWxDi1Yq4mRkD1NUYNa1ZnRcvLOvPsIZoLQYCIjOIdrV4eJu9YQUs1u7Y4tJFbi9g7n+jsGQFk849iYdVVDFsiwpaTDulcKbShnsIkDHEdmrzQMLUfkai1rtkgyRd6AV3JRcLfINwh/8JuW8bAn1ZC6z04MjPcHdIRSAdkTP1bvncziE/qRCf6r5bh0HtPXiHlliZ3dCVkdg2JedaS81AQGrymEBvbGYYj+67Yj3XbWtTi8zY7nyMZiO7E+1/24uU9Fj6TTSFrxk09Ty/RY4/6QJgnZ457CkjHy9E1fZ4FaFSZa52cfiSH7nNfxdgio26Vj6y0JqAUR3fIyf0hDQ==;31:gZOzzoDUs0fuNPjFU2PZuggjHqHDfZ2gj1iUh4KmL2k8k2UEojCg+j9NguBQRoP2eXsY1wlL9THkF7I2fVpWxNxNWMRWAopxoL0VoBvoKGboGl6dKv4G2dbfBpiELFARvehcCSf0fTplUbQdwrhPWkK61lyeKmldiHJJht1lGZxHQYSzZstl1Suf2o57IQ5hdJccJArusIYk2JgS0DZw/aKX9CFKOt8wVrcXeaPVzUY=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1362:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1362;20:3iUhQDSkl9Vk0eUMzrpHR11fYZjeInHI8Q1NOSDgZW6hvv+WzFdES/uBL7dp8F0lw3irjkh/XVH9l/XfPGsWFnh7AD7cpIYVPIxZohOc+PYZM2Vzq/b/rnTCiqoRiR8aqil1YT5jA8hezl4uQvW4314/hSRancDXSzZJsTiz/pER/UuxaT9yjMjkhGgLxRiDTYu4GcwjYs0FAFVD+om+K2na+63MmSN1xR1of5GmULWCvy9En5QLOm+vH5fY7wlxVPGoy4kO7D09GsOvEZetpKFP2wYaQMV8B6T6cvsoDO+FEE2Xfi4rQXB0QkhvPxfhAVlBIE4CQZhlixGO3US90Oqgj3AEtAm0RCMFaHSnTfihkZ+pC3KjUn+qdaj+1F9yRnTRdJmNgP2K7JIVb3lBkqV7GFZzIJc/SCASUBJkJXvG9W0LOvZiqq9QgxY/j+kKJStLyRJdEW9TRVRh3nN7ipuM02Qj/kqEsZzScQvYWKaX+TXMbhlqD4pnUbdhJaEO;4:Y+SkFDulX3DU90/Dm+pa/JQZRVFIn2lqopEpNwJSL0TUnK5GDo8DBHzxCACtYQIst4KQO3d+EP36kiue7DDcmIKwmftlAGVeWCTdVfvSj6L4Yr3x83A0FqTn1kRzn2bjxU0bFMxTXDOPJoSJibLV/HtxjFCZxUki6IZLibkoZen0QrkFiRqq4BJYgjTZ25xy11AJbZ4asKcPLlsVTGwoIMXVHJbMI0Hp3Z4rVVX0uULHDVFCmU2iVQB3C7w93mQVtfgw8ycDmruBDkAYAttbTmj7sgLHPipDHB82l0jRwEISTcCgVLr2LaYCiOMIT288
X-Microsoft-Antispam-PRVS: <BN6PR12MB1362BFBC331CDD25D4219C99E7E40@BN6PR12MB1362.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(944501161)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041288)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR12MB1362;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1362;
X-Forefront-PRVS: 0568F32D91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(366004)(346002)(39860400002)(396003)(189003)(199004)(6116002)(47776003)(53936002)(66066001)(316002)(2906002)(118296001)(7416002)(54906003)(386003)(72206003)(52116002)(478600001)(16586007)(25786009)(305945005)(5660300001)(26005)(76176011)(3846002)(7696005)(6666003)(7736002)(97736004)(4326008)(51416003)(53416004)(36756003)(6486002)(68736007)(50226002)(2950100002)(106356001)(8676002)(8936002)(81156014)(186003)(81166006)(105586002)(48376002)(16526019)(86362001)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1362;H:gi-joe.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1362;23:vvCiUsmuRdgQoVxVzE2fEwMvVNdICHUFnwMtnzFZk?=
 =?us-ascii?Q?ACBjy4r47BWc2TlbLOX1pAP1MfHoBWRsgPD4vGHotosJX8vhwZH2tYKKb0Jl?=
 =?us-ascii?Q?YnVabUn5l6AGA6iDwFVP59B0/e6jSTFXjaxA330lXS/82WUQ0lvpNCOyqxYq?=
 =?us-ascii?Q?5d8+JCnhN6bqt+uYvZMSko0XuZScQsj1T1pFaOxdMZz7QyrwASjQFQGnmBls?=
 =?us-ascii?Q?b7lINQTejhFiOYG3G+7DTDAS+UxGBlA3W0q+ffxeuYKV8PapO9FVWc1MOyEd?=
 =?us-ascii?Q?dgRKE/Zr7hR2U34bxMqIAIHnbEHZ1+hkq5COXXCGzdZU8f1v5iqAE/rhVKKE?=
 =?us-ascii?Q?zdMGyyiAZK5StpJZ96a/BdFidsjn6oUajgBkNGDl1Sd7XUwJMN6lKF0OrpxA?=
 =?us-ascii?Q?JIffTJh6lQBTl34ntbuMIBRl0L76zdcap5wilWt1v7+2bVR6sNKbRfMtCZk9?=
 =?us-ascii?Q?sZ3OdOlSsMi6F8w5AtoCw2jnmEOsoSARw9hHpgygc/EJanvbPUfK930D21qG?=
 =?us-ascii?Q?O4tvcxA4RsApgdHN8TbOCHwewzX1p2TjwMR1MgtcJt5Uv+yIAAPDxPmQ2BlA?=
 =?us-ascii?Q?89ofYfmclBhP4Gq7GGMaURaYLzRKoGajgonn3DHMoDGP099pjsOV4DsC0qE2?=
 =?us-ascii?Q?jp/8f1LRhGPtR3/Y9f71gKEJBjF2iOeM5a8PRyjn+4A4qA/othk0i4yB2v/B?=
 =?us-ascii?Q?jUAIz/AYlH3t+bJxKVPsfkl69dMGXk4KemPlxbKJ38FdNM3C5JI46Ubm+VB2?=
 =?us-ascii?Q?+sX26T0sJ4x8IsfH6EQRXdbU0Mi6dq/+4Oh1IXUFEzTccDGc0fJPLriPoLw0?=
 =?us-ascii?Q?w+pvvYBmyZkpLhs3w0xGNqBmtd/X4GsfH6INpyDbqE4+JMHYBP6P9bKVLHJd?=
 =?us-ascii?Q?oqYrHZ3ui5sCh+B2WrsDGZa7w+0DjLtUnJpiLDIhfUrvk6wNxoMGZuSe6t1S?=
 =?us-ascii?Q?FsONC0nXNbiIxl9UBGUy0oRZaIvI5CgV2ZhQBl1s7R7Fp86k+tSIRL41kKJL?=
 =?us-ascii?Q?oPTP98fNa9fg3cgECOKA+zbPZR7jHrFXkc27GQ5Do1dhhj8dY3MVQ0RlcK4C?=
 =?us-ascii?Q?p0P1ZDeOja8wvWgKa+t9XznbH9p2ZgO8Xaet+vOekSPUL5znXsBWbWRiqsn4?=
 =?us-ascii?Q?fD7YnoWCoZhGl1opMbHez2h225z1RqRVbMN6Lujate5P9xsAyxcjw=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1362;6:s9pFwN1e4T5DTSven07JCVZx1RfgVqas6orD3OLDm+duyu2bnv680MDoK0RETK/C/dbGuxvRF1DRN41y8uVxeuCEPwzpp1MmsM1LLZBhT9zDSJyFcQ5HppTQP+x4qDGW9qqxAtiA8PqJA5CLVereOIHxstG05Ng0I7srBEWWyl/FwJwwaUh8IMNuY+hkIHVA65QHVUAALDz+UbaXjpVl7xnHnShvAvnudnKmWRB87EDQgorI4jyUHrDWXdbAHZYAa4P+tXpw/FDlB/c4GvUEUs8IN7ZkTWmtX25mNvXPRH+268GncYQc1WNz7OC+bBDegqB1KOAmazNETMuzR8H5hjb+xnY4wFQZW96WTkIXR0g=;5:Man36vc2q/N0NBlQE0uQRNgIEFiOU7XoXop67GQYd1ggK4ChjobvivZZBU282mKCLxhj+aHLs+TAjMhWm8WpKXc7Is8lKjGRcqjwiWhCBN4uaxzB5VFJBJYvfWUt9Ks9xQWTIeCo/8Exf/Ly7Q3T4R/oYV/SYlMMEfGye0g3/EE=;24:GKG6s+TrkumAyiZzeOIXl0ECGafZ0eXZcoQBVhXLMhQGHGp8G+Kvdb6+Fo5cs5H6IfpsEXboaVcGoA5K/eDGyCpswpUfjcx6oI/sUALtx98=;7:8vRNAl/WejtD7GLTSgRvFZZooV7JYJpenTsYbo2k83dNuSJuG2sbg5eg2PBWSuYjgcbWzaq5+K8XCyFYWdito2kHPUsat/XEPmN+/GTkiaG8RwGs77tyO6H1ie9amKLir4OyEWGlcQCzIkqjRVeF6MVjhocSTghSKd2zMsgifxsllynDceymAITRmFVF26V7dRL83EdXUNSA0YgErfC66D9fqZKn2nxKLjtj3BXzssftWuI5oPD5M+CJVDhQo4l+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1362;20:myr5DR0TIMysR2yyMIFtU1Bg8nlV/rfGXY72ifSZGf07067RByuaNgXBft4t+oli+XNgz+QoHbEKt/AFavftCnoYIUrjj0XVZVcZXmKW6AMYuFwfMal8552mk+UGh+yqqS0TECUOKGtSiAojp12R1WszC6m0oOdJYJYGsyJ5ZGg5BpiiBuYJUx+GJM8RMtsAMG/j7tZi3b8Fixciw00SsdXS/W6QWKSkdVJiQMCPVC/xUvlCbSJHKqChzeyv1n5C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2018 17:32:53.8562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7d5a77-c120-476c-4f65-08d568077f2e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1362
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the EventSelect and Counter MSRs for AMD Core Perf Extension.

Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 arch/x86/include/asm/msr-index.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index e7b983a..2885363 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -341,7 +341,21 @@
 
 /* Fam 15h MSRs */
 #define MSR_F15H_PERF_CTL		0xc0010200
+#define MSR_F15H_PERF_CTL0		MSR_F15H_PERF_CTL
+#define MSR_F15H_PERF_CTL1		(MSR_F15H_PERF_CTL + 2)
+#define MSR_F15H_PERF_CTL2		(MSR_F15H_PERF_CTL + 4)
+#define MSR_F15H_PERF_CTL3		(MSR_F15H_PERF_CTL + 6)
+#define MSR_F15H_PERF_CTL4		(MSR_F15H_PERF_CTL + 8)
+#define MSR_F15H_PERF_CTL5		(MSR_F15H_PERF_CTL + 10)
+
 #define MSR_F15H_PERF_CTR		0xc0010201
+#define MSR_F15H_PERF_CTR0		MSR_F15H_PERF_CTR
+#define MSR_F15H_PERF_CTR1		(MSR_F15H_PERF_CTR + 2)
+#define MSR_F15H_PERF_CTR2		(MSR_F15H_PERF_CTR + 4)
+#define MSR_F15H_PERF_CTR3		(MSR_F15H_PERF_CTR + 6)
+#define MSR_F15H_PERF_CTR4		(MSR_F15H_PERF_CTR + 8)
+#define MSR_F15H_PERF_CTR5		(MSR_F15H_PERF_CTR + 10)
+
 #define MSR_F15H_NB_PERF_CTL		0xc0010240
 #define MSR_F15H_NB_PERF_CTR		0xc0010241
 #define MSR_F15H_PTSC			0xc0010280
-- 
2.7.4
