Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752183AbeCZTPp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 15:15:45 -0400
Received: from mail-sn1nam01on0050.outbound.protection.outlook.com ([104.47.32.50]:59216
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751748AbeCZTPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 15:15:42 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-edac@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        bp@suse.de, tony.luck@intel.com, x86@kernel.org
Subject: [PATCH 1/2] Revert "x86/mce/AMD: Collect error info even if valid bits are not set"
Date: Mon, 26 Mar 2018 14:15:25 -0500
Message-Id: <20180326191526.64314-1-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:405:3b::24) To DM5PR12MB1914.namprd12.prod.outlook.com
 (2603:10b6:3:10d::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a2b3d597-164b-458c-7b61-08d5934df6ce
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1914;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1914;3:1tAet1hjVQoAJ3RQUXvlU8yogjrMyq2n/y8TML7u34wqB8gQTDRrwW9yK+W1z0Ga/KzxqvjgiSs9XG7xgNfBpdDvr8+rvkl/h5RCpvNM6k27OmvmwH8b6KmglNHb3TzP65wX3DdigNiOjpUDe+HCGuyWlvWfIIQlM4UFb9I2dKh4X6KCPX3FSpw4SEjaLbwg6Dhc7YAkYSvNCohjx4d185LaE/j/ZB3zpX75SJ4D6xKo/gcn61CRLWhQtM0hBxuy;25:VNvUAeSXkvVIlxryhiFDCqwrzJCYLl8faPxAgDa2LG2bEYsclqDpIxrJu/r6AOTxANx12UnrYWhF4RgeR/IiVaxDcLRLlRlN0z184TF9vyLjOWkJ1dTG2luoyXnF386z+9m0ZVbqwI3tL34/VoE3yJl3TOCOFRIwc2Vf3LxY3LgqqAbJQeFC0iYqDhVqwPEXt30/Vjo64mD/toAXBamDAl48dm4QhlMJc3ALgzBqQPPqp2N+kMlwrI+hTXcPjGzSu6XfGupxBoVzpKz0iitnsyjxhzqn3eZjxhA9RM+Vy5AQ/sIpDol58hGWx4K2YVmZupHm3spF99P5it4wOEZQQg==;31:9pL7sJHZivoW2v04spmGIcyRK9bs7ZhGQjiOMpRgys9MICeSpFhQY5Df1K4JcCHQb+KCjt7reivLI0B9+JBG3rXzM2nfndMYGk5BENlweR7hCQ/LatOxkZPUdn3KzTNEml3I8f+uTERZ3mA2MDLZmF998Se3G/376C/XHISEUcAwN+pC52goyhNK1T3wcSugUacKCPNcBPFjCGmhMjtEj6zzF9ZRgkcqOiP/PmD8cw4=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1914:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1914;20:qvHbTcRweopam27EEpVVb8nojN2jeeQMsb2GgvMK7sJbPlRKz0shtupMdyMzwVWS7LzSx3HgtpihmXDlxXm0wZluIZjd4LaajVHOoXen+B4nS4SkVex06nTuwA6K3NSHCBetC3MjzuwX2Y3+zTlyg2x5+l3HovvzP1f5vcT4pJ3A8ptbXds7jz/V0LwZsaPVtKX6PeR6xKfV3Khr4il4IpnOwEjb8ytq35gUEtcvGwRbyfE3sEyQKzkaOqLDVNxu40r7R+IhMM7oBBZcyTj6tzs8RBUAkLoUvHoxXln8474XaXkQ68JijDM0tqh4FgRMCx8W5882BjILNct3gYUZ9ZZIgiVbzLUa9NZSV8sNtEqEsnQ6dG6bTV1fudBaz1KNyBSAvMJwFaQO2i5RDYWFmIEq5diLY1hNHTj8o6m2yfIk+WIR4RQVE4MzqjSCgAgeFXnJfnfXLxRXCe6Dn7u3bceZlhDcP+gG2gKbwRatSom4+RWuQ1wv0B7UmQIead0A;4:iDkqX5VWFK9pPBfeJFcFRErihK5buRDZwiWTHQj6iSS0QyjL+SoTVw/lZqpcWz4jQZ2elzgqb/qzwV6LqibUVO2S1M0AWyDnKLq/KghYGuz76Jk91T/tjtExufUVsbcGUyy8GEf+41HoZSmQ3FKNREqtSjTTCbRb+1h7n6giHr0se2cHZBGjf1v4JxZVvTgtCemvF61PHnhF7brW2sY+iUvjFkLwN4D7so7h+I0RTowZF2Xac6HNsrIvCgDFgL6fSJeQKDMVmU3FsSFmpP839txL0Z+FbkzQkLd80WWF9Df1kDVQniDag8f4OUuuw7Sf
X-Microsoft-Antispam-PRVS: <DM5PR12MB191413FCBFBA8858AF2DB6DFF8AD0@DM5PR12MB1914.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR12MB1914;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1914;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(189003)(199004)(25786009)(105586002)(2351001)(6666003)(1076002)(2361001)(72206003)(97736004)(53416004)(66066001)(386003)(7696005)(47776003)(51416003)(486005)(486005)(2906002)(52116002)(6916009)(6486002)(36756003)(4326008)(26005)(7736002)(305945005)(8936002)(53936002)(81156014)(8676002)(50466002)(81166006)(186003)(16526019)(575784001)(5660300001)(106356001)(478600001)(3846002)(316002)(956004)(2616005)(68736007)(48376002)(50226002)(16586007)(6116002)(476003)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1914;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR12MB1914;23:7Ge67hOAGcIq1HLrzsg2giWMhe7Y7ezZtA4h0eH48?=
 =?us-ascii?Q?pcWQvbCDuQ3IstYILjavEnlkhBjbiU8BJn4YCM+vT74MPWPdGicvkWsECQU7?=
 =?us-ascii?Q?zRY2t1lo9Ozn+SWJYL9DrtVr+bqIg7FPqfebJb6TdjulByrJczRBKXXILP+r?=
 =?us-ascii?Q?orINv39OQneiJA0sCYXCYeceUIQStcvZtkx2AYTg+DlrZgGmhVxuW+hQ9xBX?=
 =?us-ascii?Q?33DhsIn+Qx3Dwxo26ATNl1D15WS/r2IauFZLJtmk7fNiGAuMR+xdcDT7hRxU?=
 =?us-ascii?Q?Dvvyu5dnniBT7Adob48Bq4dEYMd/GGjPIergo5Odu6EOxDYOCFThdYjfz6As?=
 =?us-ascii?Q?ZS+ZuCAsmNDW13z/QvbHM2NbpMcuxmQtebM0cMP5ynMOPM571p1eTLTDMT/K?=
 =?us-ascii?Q?SLt2KEsRSHgJQraE+aVujFjuQ+N+I29OX4Z3ataguxemoL+OL+hRKTDjczBS?=
 =?us-ascii?Q?i4er/rKvn6Nh1gO4JwoE152Wve/r0vkOpwBDjytfJTRAzgONDMsOsgIe+Ytn?=
 =?us-ascii?Q?Y88Vn0InJ1OvHgsS5B+b7FHbybnXYkvAafM3h6YRkGAfA9dOrMeKBD5bvVhM?=
 =?us-ascii?Q?A2CIhdX0UpAJiViE7rGdUIf4d036BAGudNnUuy0yK9utlGVkIRqpkwAUZPHa?=
 =?us-ascii?Q?TMm46UjOGyaHCdGKoAwXk/iN/e7enWEaSQ0QH2HmCzqHwYtYK3Ap/n6mhimK?=
 =?us-ascii?Q?QozqPjft90rwbDBIsCOsaGU3AvAhyNE8zsP5NB3+29+k2M6gwFvzqEErI6Lz?=
 =?us-ascii?Q?tQUsKyAfb5pNUy08rwQ9We2KV3WQxw73j+hsH4wZV2Kz/+S+yAGsLvWlPPA3?=
 =?us-ascii?Q?0CTer+Haj+kGRfNDUt25PdKrfQLIYzTaMCq0ELNQBhTgdLXVDX7bSN6RZPJ2?=
 =?us-ascii?Q?IlU5tRIs3XmSvbuq8FYfMbbmmfx//ap/OQKCPGrGyC8zT+gdn3tAdpug1cRD?=
 =?us-ascii?Q?Ya1fqJ4Pu64+9etIeWAFQdDWy53mURQ5/VoiyBr9dUBva2UqK0hNMtecsCkO?=
 =?us-ascii?Q?KUR7h2ZJwYVLyBfAeFekzQnn2JheehAt4jN/cEkCiU9JRXPYt19o45dbCWBv?=
 =?us-ascii?Q?L5fbZhZIlbvTtpZnRXz8tvmMfQd/8tx6rPU5TeiOOAb96zzXz4gCC+IEi0mH?=
 =?us-ascii?Q?4QUXeDwox8gt+chaxbqATPFEJt0IZtM8qfqvxvhYEdNbLKK1BJ17ZgFMzZ1X?=
 =?us-ascii?Q?V+RSvhDq0odjN5O5R1xktP+OjQUsSBhptJNWargNCfjCtVnnNfCDbeNPwdq1?=
 =?us-ascii?Q?KZPuj/mDxwnE6jW2/A=3D?=
X-Microsoft-Antispam-Message-Info: K75NzviAfEdLH7gq37uJgwMkqTh8Htci+DeIy8V++ix+9UUXv2Zv0Bb/S1Y2MZNN2Ng8dyE2aJKPzPC0YQVIFrwhPPeuMHb1F7RxBje36UJR9abaXV+WJmgreNQCb7oNPkxzNke4uN6hNu4q1032q2LNj6ZrEEgch/4AvAc/gNjDYYjoVWzAkIy8ZIq+d7An
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1914;6:P/HBgmLBfYFJpwSwNYyYGTwcQqU7C3xUvA2EvknsKL4EYW7YJT7NwMdLOKsDdkoRIPEd4HzvQKKF+EqJmNxIxJjKp6taXw/tfrjh4HP+fU8XaC5VpaQyXUIBdoEKuw02bO71asPd0YcazWM4btA8wuSeAzbGFNN51HeywED9NPKt5egoh9QrhMezQZqxDVdFK4hYqN3rDk0u+Qvz1Lgh4IpKsmHnSvSvgDEhZHbOj+r6UmhyXQHEEiXK61Fy4PCILi0vQSsP8AaLEUxZEpOU7OVf+7prEAWIIj3EVbyzmPJp4XFE+qKKSs0bj1W+Abn3iSKqKJpDeQJFVOFf++EwaRYAovj5/v6G++b0V8HD5tu35kXlE+IGq3aRnjijnt/7dSreRk7YNJvxJVx7onJIRXZ28qwUR9EmJo+DQheuIN2riQ17x8em6F6HXu5pMCSvk5XU1ttw36Sv1BavMeo+Ww==;5:PUykEmmD+VYEz4kOcfBCefZAY8e3Ej07m9LjVX34l0uLSy5K4hFv9+IrCH1X1L0bvC4BR9ceXfum80ZO5m0D5o1SrW47aRtTTre21YiEC9VSF3aRHcMgILgqqEcM9cfcxcz1Jg75F2i7wYKV3WC8lvE8OLR94z/zs+oea20oswg=;24:/yk+liEY1Ut4s+k0z+WoqwgUu3p4N1X1eYxQ53pj+7PpaLN02+V95pLiew1s8I1Fhb8UdMk8LMuSZ07rpM/D5kzlqmmeeUs8c+eVzVL+Th8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1914;7:DSoQdC/iRL1I8G1L4qbFxvlMb+8UTc66CvQ/G4lbUB4po2x07KWgM8UEGE30l4D+8Lho8vras0ODYJrfyteTaiegtK/FD/1Nll6GTJrKP6OV47WPq4IFdszXmvUzTYyAxbGfGKCSzb5/l9pArllsU18eUixAflDcYYN3Ag9r40TDkVijIOMFQnAtf06GAvUuCXtCU70VxlXrGsInbo9eJJGhmonED4hFryQ8VnbOtThjfWeC559E88WqYGUYmYmD;20:1p44cQBzFXV9lxmHJjnyVVioPqAufPV5zgggeuWrt2o5p8MrmIl6xHe8kR/nAHV+dYjF2fYgPkDzqKV6ct+jQOURqSgy92wQhpB4zV07c24Im0lDziEC2XUfC5liz9350JpG6SO0CFilWujAQTeunCqYMD6826Mkw39NWhqPpo8VVE/ftnQn5fV3PWKqLGuElg8lLQ341mDfny4W5xRCkEX4VLcOLPDTe2oLNo2dpYdVgU7suROP0YrKAFXbU4cd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 19:15:39.8097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b3d597-164b-458c-7b61-08d5934df6ce
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1914
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

This reverts commit 4b1e84276a6172980c5bf39aa091ba13e90d6dad.

Software uses the valid bits to decide if the values can be used for
further processing or other actions. So setting the valid bits will have
software act on values that it shouldn't be acting on.

The recommendation to save all the register values does not mean that
the values are always valid.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 86079b90ebcf..42cf2880d0ed 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -446,20 +446,6 @@ static inline void mce_gather_info(struct mce *m, struct pt_regs *regs)
 		if (mca_cfg.rip_msr)
 			m->ip = mce_rdmsrl(mca_cfg.rip_msr);
 	}
-
-	/*
-	 * Error handlers should save the values in MCA_ADDR, MCA_MISC0, and
-	 * MCA_SYND even if MCA_STATUS[AddrV], MCA_STATUS[MiscV], and
-	 * MCA_STATUS[SyndV] are zero.
-	 */
-	if (m->cpuvendor == X86_VENDOR_AMD) {
-		u64 status = MCI_STATUS_ADDRV | MCI_STATUS_MISCV;
-
-		if (mce_flags.smca)
-			status |= MCI_STATUS_SYNDV;
-
-		m->status |= status;
-	}
 }
 
 int mce_available(struct cpuinfo_x86 *c)
-- 
2.14.1
