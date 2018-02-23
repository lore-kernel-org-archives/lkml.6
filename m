Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933567AbeBWUEy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 15:04:54 -0500
Received: from mail-by2nam03on0063.outbound.protection.outlook.com ([104.47.42.63]:18496
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933252AbeBWUEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 15:04:00 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, bp@suse.de, x86@kernel.org
Subject: [PATCH 6/8] efi: Decode additional IA32/X64 Bus Check fields
Date: Fri, 23 Feb 2018 14:03:31 -0600
Message-Id: <20180223200333.6410-7-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180223200333.6410-1-Yazen.Ghannam@amd.com>
References: <20180223200333.6410-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR04CA0033.namprd04.prod.outlook.com (10.172.163.19) To
 BN6PR12MB1906.namprd12.prod.outlook.com (10.175.102.12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 98203f14-3a7f-4b2e-4ee9-08d57af89388
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR12MB1906;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;3:8BLkCm2wXuBtSifN/Nr/uQtZnCVUtbWHdXLhrPwJzJJub3bXNX61epeWcuSGuuJZZAsFPWWIMbeR4US7UsjPTaGrmP1vYVrN01RAPv0pvdpSMm7e7DUEQdL+Yi97BHqFmPC9Q1LTbEIl1k+UKUHD1Vess3QO3dPMLseHSGumwaA2hQoJ0nJ4U/ymWv+Kv2nXfI4SGyFQLk84qiehVeYAX8U8j3kuUZLWM032xEYDufdS8VAn79d12M+WvJM1BFH8;25:t5eQFOrgFAHK70u4/GnlGtDwVWeZiidqGK74S3K9ogUua/aiY/SOrRH2jmakySZTZW6tDfn54ooqpmbLmzjL/8TJYdKQZgSySEf8Xt6FVH8UwPPDubLBHjSn/0zw8NZLocGCcc/sfCySjWlFqljQmg36h0OhtPGqAT0/Fb/WiG9fdroCiUk+lkfNqbY7GweBlRVUXog6S66LAtyOb6K7Msj7EqRsdzpAnvp0rDRIAKETpEIGxtQUsMRj3QG+WlNGpFYgnowIwpgcoxBrOifUXiKorumTJ0gAB28r68NSPyjwinUU84eBoOpNEs6mydwWoy9WZB0tQ4JndxICXbAu/w==;31:U8Ve0M1F0BcYzZkzfGQaa5c+q9idjZKCD4Vydu+YVK/NR6eVP2cuzE1EiU9EuVHqUFK2fEcIQK0k6lDMAInrewDydzb/VAvHC+bpdqr7jUDLyK89X4JpE+9omv11eBZGeWWEnt4dsXOBV0+R5m16cWh3WhVO/is05UWzZybsYeDP1doZXk3Y3wyRSR4y893jwO7qlJUlA3YDDucagHRWJdUuyTkAWaAwVXWJ2DgdTbk=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1906:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;20:0F/AJrZ8MToB5PGHHrLEXhImyV11aFoUUCMa4LeDKWADpbEmUzd/dpuvVmbQ6X3hj0abyd5urgiLaagj5KdGmoWoipf+XtiWvkOE9gTC9b5DORNRuO+A+P/j8u2AAMMCKmhRC0LUaWt/EzitznzhdnutbP01cuelAmgxjTNxdOQKXLBBvY/3HfiOC+sHktRzFMiX41Sa6yvhL/5x+8aqaCmrfFVHCaMsfNb9gRVCJ/ZG0zSXLjS/lF9kfaOmrCn+CbrBkwD7PQ4xRoc0hG933MV5Es4nvIJJ1AaXLcN9gY0SoKmOIF167ScHRxmT8IjgGQY936F/Lkm2FqgvetK5BGqjdkXitb+mi5coLY4Roj+z7w+xyC8Ozv0upkzUJsWgJA6KyjJp6suw3wZxU/IP9WjhIcpowQMf9fGVB4jiJnSN2WFa52DsY5qzL2cT8B5tmQyllpTgJBZQP8fyRT8KmeIhC2vokPsAiLiFYx9VTVBLIBFcYsRNKdN5GOUHvDfu;4:it0nAMgHS4PRdCuhA286/pcV8qxPZ3mja2bpIY8sXXxP90mgY6JeL56v6JziJPvQLoRnRyZbJG8Cx0XOzo028tOFt+z3hbBlgF077mW0gsyH+dkH5U7DV3YZaT5f0AgTKwfU0oCM+++C5gl0stid2bs2BlrWcVJgHvdjPEbZ1qEM/yPMwQpCl+2T6WjaEr5Yy5EBVLmaC6TL5rhcS62WHLI253GnFiHIHVGnvUCouhAoLlm9F+0sXP9b1MmZibFwLoAsA2zFPcj7j6w4FlVldLvyut9I5vP5wrURdu0EejcxqJBVU7fnNz9nkJfBWxZSmaX0xLgp6ROxLpIyaDBEpA==
X-Microsoft-Antispam-PRVS: <BN6PR12MB190620F12896BE855325E552F8CC0@BN6PR12MB1906.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3231101)(944501161)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:BN6PR12MB1906;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1906;
X-Forefront-PRVS: 0592A9FDE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(376002)(39860400002)(366004)(39380400002)(346002)(396003)(189003)(199004)(386003)(50226002)(8676002)(478600001)(8936002)(81166006)(81156014)(106356001)(26005)(4326008)(76176011)(2361001)(53416004)(51416003)(72206003)(2351001)(68736007)(2950100002)(6116002)(6916009)(6666003)(316002)(16586007)(66066001)(25786009)(1076002)(2906002)(3846002)(47776003)(5660300001)(305945005)(7736002)(97736004)(105586002)(48376002)(7696005)(52116002)(36756003)(16526019)(186003)(551934003)(53936002)(59450400001)(50466002)(86362001)(6486002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1906;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1906;23:WDmq1Z3bR9u0LWGi1BDiYJZojLiMbaj3NuFztWsUF?=
 =?us-ascii?Q?XY3VOJ8GtiqRE0819iN9qaASmOSRHTQu4X3OYOtIVTB8inwHBBb+RjqbWrQp?=
 =?us-ascii?Q?fJdIOEwQAGyZ/InMj7JNz83/eM2FfPw4yeuhBh4fPwEqnQ6xOilFuPSBAc8o?=
 =?us-ascii?Q?TBQ/54DTlv92HkCXZ/NJlzc568IF0S7BIuK8KUWEfjndOYPUuKqBvjfbtmuX?=
 =?us-ascii?Q?glIpZik5eounY5ti39ndgMJ8lQ0XztO1eSL1l2K55/f4pdi5B7/lo+FVyFyX?=
 =?us-ascii?Q?2R4TXd9yj9/ImkotR9IfES9eZSatFSh6BkgfZ6jsF7RVtuLG1Hz9VghDq970?=
 =?us-ascii?Q?TPu5hjcackb03fd6kdccNUi9+o3jbc+CjUnxpjXU2Gqrdy6185jqJBeNSY6o?=
 =?us-ascii?Q?VgzIHtvYNVPJonIy2bCKJUTt0qSffS8wFymX0hAxKDB5I84I2lyG86YHqVXM?=
 =?us-ascii?Q?ClxuXejt29GZSFp9OAqLBDsm7z0DRuJK0nAOIJ+rOaS1/HsxVQzLx4IHBhMC?=
 =?us-ascii?Q?Z2VQs+t1QagG+TnM9E/wzBXqgaEq2HJG4MacK9XdZC/BW4BgLTs/IB+KHmz7?=
 =?us-ascii?Q?n/LaldaKbeDSSWQZG5T3lbbHbUwNTyAPrEmIvH0tlF8URo6mPyWt22IDpsUq?=
 =?us-ascii?Q?jrauEHjQDmEFpVQFG+fizcyvF5YBWzkcIIAwVBN/pkvzH8wj15sMgoxkmnF9?=
 =?us-ascii?Q?h7lPBnvGE0/iHwxbZTxqS5YzBb2mTY0GVTWWr1+EbnehqVFRI1MYlLrt68wd?=
 =?us-ascii?Q?qkih2cdoGw3fx4FXAlseJfblo1d0+ORFc2MWMSHajUFPMpnIwweBM2I/bhF6?=
 =?us-ascii?Q?YG6/m3L4vGIsAzDBkYyKrWB2Ug+dnLcF3Eo/exEkrcx361Rt/AwYYdmRVAz0?=
 =?us-ascii?Q?9Rh1ALxc65T+baybfQIK9yPdAzKBsrG84cjqYrzKa6DL8I4x2uViB2oV0OrK?=
 =?us-ascii?Q?lFUBF9SsT1W/A7p/QcnwFTt+FMR4EUjHxdPgSB200WMUBVtHxHkl4mLk6ZfM?=
 =?us-ascii?Q?naAMVUeq+YeWQrfY6vElhUOaObz0LLwQ7n6dQhCO3l2rCFLrvGNC63gFrSsT?=
 =?us-ascii?Q?oEb054zDE3VbuLRuwyrpYHP232C4e8AgRHioxF15ezYAl8SyO2RhvAKaGgZs?=
 =?us-ascii?Q?rxp/tKD5y+sxpAuvV4WLtBsHkqUsDaXfzuwZneMTSoSgsroZRfck/bylDagx?=
 =?us-ascii?Q?wCiL4frtj5wvlHuZ7FBqPdWINfWky/PvCQmU/UCKJkOa3mGnps0BhSJISU62?=
 =?us-ascii?Q?VCLjWeOyrERkKtStBu9mqbyIo7XYJ2EbVCS6JmeAinOjQRqUvwI3zpkVD1BL?=
 =?us-ascii?Q?RXY7g7QuNB0xHjgwitQb8oFDvxVqksCT/6/b5w/jEIs?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;6:qCrjUPJ/zyJmOr4zPE/OU2t/xcX1PZtk8muBS9ZfPajaI+Fbzst53jCjtMM/TOmNeT26xuelDftdeBeDQyfcQrHB84S7FhRWv3yWhJOsNBpFMj30Hj/0/BsZ6qjpQ2vsLQkLPJdtOlyAfAM8GK9ZgzF2ti/rRzIKYAJV582WUISi8zjcvwVmo/VEUNIGGYgt7kEM5gNrwsyjApwngFFk8SttcW7yHYAYY08+iWR3kXTnKnG/awjexlLLp62GgljDJjXEPGJFAbLNd87VH0PkqAK30t9RhfIIARDq+GV6dGI0lipjkdcTGFAinqar8XOqbpXGqc+rcb6IL62yroLqcOh7PQjgauR7cLbdsXmx2lY=;5:zSYm30kv+qi0npVzMsDgTuO2aaiPHqQ70LI+gXdeLernmVGSLD+l+m480744BTUtgRWwU2WQIKfnCA1xsS/x/fVJQb6u2GHsUp/QhMHgHuOvw1nwnaGexED6yFFGOE2BwXtkSvtqKj2WidNjXVCYAczhSrQcUwD7tabzKtlgZCg=;24:emVY+Es8viJL+ypQjvpNyUzsqu7W4eU8678guM+3hZmH+pEjbqQXNqeIV1xV6DtelpXHMK9cUQawMnATA9J/DEwvHH750ceTCb6Q76AAZQM=;7:TkeXL8mLIwbZRixxO8bxJVSehejN03b2AT++s59wb11S49ML3KgFdiyirdYB0wUibJAQpZwjtB5q5O1kqRPwuDbRlO+OePdyAwYuzSzSr+Zgiz69g4Y6gy2KLLJIaFKw/AKaCn6J2jZZSvJ2HTCuzpvwXXVuz0zOtWr8kxFjAl8cAnvTcfXBRNBLftIaYSh6Yqff5rpmNOZs0YS9Rer5//D17m6vZ7g2LsRJ1phmrsbDKTfIVOtAj3q6D6dyqk12
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;20:hkM26mNT7667N1hvmTxK6FU35ZtPBmBNCp/FHo6worMHnBCfqBZMcXVkY0V/kcRzqLdt1jkOarJ/N9hiDkRyFmT4Hm+y+rGHnTy32r6jKNFFpQF7MynLxAUxYmEABA0K1UtOt4+FN1q2Fh/cCwirYHHIW/quyvdHW1WlOljQsNfRqc5o5gPdRK9TB8wLFC4czgmMe3yc2fOVD4UR066dQWwOOX/vLVhuHKZfumCtHrMijF0usygE8Itfwq3j+AKI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2018 20:03:57.5486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98203f14-3a7f-4b2e-4ee9-08d57af89388
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1906
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The "Participation Type", "Time Out", and "Address Space" fields are
unique to the IA32/X64 Bus Check structure. Print these fields.

Based on UEFI 2.7 Table 259. IA32/X64 Bus Check Structure

Cc: <stable@vger.kernel.org> # 4.16.x
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/firmware/efi/cper-x86.c | 44 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
index 75f664043076..df4cf6221d8e 100644
--- a/drivers/firmware/efi/cper-x86.c
+++ b/drivers/firmware/efi/cper-x86.c
@@ -42,6 +42,10 @@
 #define CHECK_VALID_RESTARTABLE_IP	BIT_ULL(6)
 #define CHECK_VALID_OVERFLOW		BIT_ULL(7)
 
+#define CHECK_VALID_BUS_PART_TYPE	BIT_ULL(8)
+#define CHECK_VALID_BUS_TIME_OUT	BIT_ULL(9)
+#define CHECK_VALID_BUS_ADDR_SPACE	BIT_ULL(10)
+
 #define CHECK_VALID_BITS(check)		((check & GENMASK_ULL(15, 0)))
 #define CHECK_TRANS_TYPE(check)		((check & GENMASK_ULL(17, 16)) >> 16)
 #define CHECK_OPERATION(check)		((check & GENMASK_ULL(21, 18)) >> 18)
@@ -52,6 +56,10 @@
 #define CHECK_RESTARTABLE_IP		BIT_ULL(28)
 #define CHECK_OVERFLOW			BIT_ULL(29)
 
+#define CHECK_BUS_PART_TYPE(check)	((check & GENMASK_ULL(31, 30)) >> 30)
+#define CHECK_BUS_TIME_OUT		BIT_ULL(32)
+#define CHECK_BUS_ADDR_SPACE(check)	((check & GENMASK_ULL(34, 33)) >> 33)
+
 enum err_types {
 	ERR_TYPE_CACHE = 0,
 	ERR_TYPE_TLB,
@@ -92,6 +100,20 @@ static const char * const ia_check_op_strs[] = {
 	"snoop",
 };
 
+static const char * const ia_check_bus_part_type_strs[] = {
+	"Local Processor originated request",
+	"Local Processor responded to request",
+	"Local Processor observed",
+	"Generic",
+};
+
+static const char * const ia_check_bus_addr_space_strs[] = {
+	"Memory Access",
+	"Reserved",
+	"I/O",
+	"Other Transaction",
+};
+
 static inline void print_bool(char *str, const char *pfx, u64 check, u64 bit)
 {
 	printk("%s%s: %s\n", pfx, str, (check & bit) ? "true" : "false");
@@ -144,6 +166,28 @@ static void print_err_info(const char *pfx, enum err_types err_type, u64 check)
 
 	if (validation_bits & CHECK_VALID_OVERFLOW)
 		print_bool("Overflow", pfx, check, CHECK_OVERFLOW);
+
+	if (err_type != ERR_TYPE_BUS)
+		return;
+
+	if (validation_bits & CHECK_VALID_BUS_PART_TYPE) {
+		u8 part_type = CHECK_BUS_PART_TYPE(check);
+
+		printk("%sParticipation Type: %u, %s\n", pfx, part_type,
+			 part_type < ARRAY_SIZE(ia_check_bus_part_type_strs) ?
+			 ia_check_bus_part_type_strs[part_type] : "unknown");
+	}
+
+	if (validation_bits & CHECK_VALID_BUS_TIME_OUT)
+		print_bool("Time Out", pfx, check, CHECK_BUS_TIME_OUT);
+
+	if (validation_bits & CHECK_VALID_BUS_ADDR_SPACE) {
+		u8 addr_space = CHECK_BUS_ADDR_SPACE(check);
+
+		printk("%sAddress Space: %u, %s\n", pfx, addr_space,
+			 addr_space < ARRAY_SIZE(ia_check_bus_addr_space_strs) ?
+			 ia_check_bus_addr_space_strs[addr_space] : "unknown");
+	}
 }
 
 void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
-- 
2.14.1
