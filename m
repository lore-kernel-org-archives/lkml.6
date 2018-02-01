Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753309AbeBAStC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 13:49:02 -0500
Received: from mail-dm3nam03on0054.outbound.protection.outlook.com ([104.47.41.54]:29401
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752924AbeBASsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 13:48:45 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-edac@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        bp@suse.de, tony.luck@intel.com, x86@kernel.org
Subject: [PATCH 3/3] x86/MCE/AMD: Get address from already initialized block
Date: Thu,  1 Feb 2018 12:48:13 -0600
Message-Id: <20180201184813.82253-3-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180201184813.82253-1-Yazen.Ghannam@amd.com>
References: <20180201184813.82253-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR1101CA0010.namprd11.prod.outlook.com (10.174.237.20)
 To BN6PR12MB1907.namprd12.prod.outlook.com (10.175.102.13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7c7fdce3-2c30-498a-8b60-08d569a4623a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR12MB1907;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1907;3:VzTtjkTKLQcxEf3AoSO6NdzWJRVn2jw7nBj1zPe4f2cDkLICXzWrlbplvAYKAFrcPaniTmsOFgKSinm9k1bD/hVJi6A+II4W206KZ/GrQUeQqUKq6/juCwTMoIUFb8uUwSgSpfkEM/G0QLSJEuakYgoE4vPKYSazUswnE6GFARPQ6nN9bIz3i6K7jfLu8Smt7ubvc0xkdi31hVsS53LBsZrl6DGpVGg2qgVYjaO0lcvru0cHgy57CLRPn80mkuBU;25:7FA4BvY1tPpjHolHTnk4t5ehYhsc5AA3RPRSfw32B+ko0SktosgDg1LdenET3AfdCDjzTTcR9pLes3vTPsfIzFc1sJmossmxVgvXTaYbkBGs7u7M5XrPkiVCUFgR15Dw6jV+EqYGMZBiaGAgkrN//bStxg4GmYg3a+W2wrgXkduohtLGzZdAni9p+C9vFUwItbFwSHEgGJpmQFv22OHouvvxLKceXmBhixEqazlzgPiXKw2lauvNUhqMiemkQcsUUWzIoL0vN/SAegUX+HLAAMHsb/9dchM36feGQUwnCRk5KI/bt4fSVy4vAmY6qBZWFszoTLZLJuWXLW0j+mablw==;31:7h62xbcPgDE9vVenyeIPApQt3xjKRYbuZ267mhqVmYodgAEn4NBxVEnViCeBILGi9JfFhxpUBItkEdO/o80P3B6Rr77wde95iE2nhuOJB1+GUvNcnGn9e2vZz1t/+SZ5CsSavFa1E7t+A343yUck6GpS6jMuCJJlAhK52P5K2F1zdJuL36vYd0Aa27an832L+4tnm7jlgbrxb0Z2MlDTep1I4i9ZoZMHj9mBvKnrbWE=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1907:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1907;20:x00lZVOa583CBHhxPuUvREATGbKNdEwP9/99BKqfCpq6nZ54D/pAgAxSrXOJk3IsA6zrens1SCw2l3ZTnAIXGeOpP6vLhQRslIWzevg6TCd02SxLyi/wLczACSORdKBW6olddrn3J+QICXTPGP1RtJ9L6qJz1tWF2qIEN1wNIhv/pNtDxcZi5Ucmqa6nddwg6ba275hBbBct03u5h/R6GDKJ8p15hS+HNYAgk5kj4wSFNUNNtaCEUfPe3IM7Qj8fiOThYWxBi4/uNWEZtuAjG2Ldv15yfajoMzwNO6AX612a6TW9bmDkDaKbVnFQVRKSSNJY6HTuiC5UFuyiL6UU0x9KAHVvp85TVlGYbpdnXRUKcsZHf/MvvG0Q2T0zzFcOnLrWa/a9YKkWV/Nj1jz509YXi+nSaHvEtANtnDWbhlcEVsPN1o56K54QbHWY+w1BsxSyeRspeH/6ewcvObk373yTAxNGJxX/Kyx7d912Epg4LpFzdKncCfmeeroavEGE;4:Cntv8796cBNfaIdf/4qehMHkmY2J/ONRYxJE+sl7SSG6hdfhnPJZfTdmUlXKeMEfM2S5OmhbnSQlRY+D37Mykr57ORRySFFWOrGbGpBWlQZaQteVK48R3bJeNDoMUv5LmWf3RalZpbQ4olQQr0cBf6EKIgB4ZFJU59ebF69BC077ZCNmni9qkq3cpjSzBV/xA8fqzQqXInMGo4S5Rmbxn60zf9SYL3oRAHgX1GeM8V1IppaIXgQHYe3o0ek6HFZzV8RpNkkbIcJI1UlfTPngZ59PA5mDark+jfV3Np+kMu4ZZyHT+sbOX94cHqDA6/M4uL39mBesC4hm1b+uATlg9Q==
X-Microsoft-Antispam-PRVS: <BN6PR12MB190796D55E21781EADAD79C2F8FA0@BN6PR12MB1907.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR12MB1907;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1907;
X-Forefront-PRVS: 0570F1F193
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(396003)(376002)(366004)(346002)(199004)(189003)(16526019)(3846002)(81166006)(53416004)(68736007)(7736002)(4326008)(6486002)(36756003)(53936002)(6116002)(2906002)(305945005)(1076002)(97736004)(386003)(59450400001)(6666003)(7696005)(25786009)(47776003)(6916009)(26005)(2950100002)(52116002)(2351001)(76176011)(316002)(51416003)(72206003)(66066001)(105586002)(8936002)(106356001)(50226002)(478600001)(8676002)(5660300001)(186003)(86362001)(48376002)(50466002)(81156014)(2361001)(16586007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1907;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1907;23:hXkQWh2xLbnV3RNuSa91xiRMbHUBiWjYneolPYhBX?=
 =?us-ascii?Q?oKccNkg5AD0kks6DaOEaxfz+kEb/NnpazhuuLNz8oLfMF8Sh6UOLTU7sxPs0?=
 =?us-ascii?Q?OHoJA/ki7NB7Iz2z0Wu92vsDIhOFFu3w8jgrAijh+UL0xiT2TsZ81Qqa/jlm?=
 =?us-ascii?Q?+f66slYqQQ5PFuc1eJR3/YE3Xx2YT72Ki6extxEMbmW9MhdoG1DQF11K9ieO?=
 =?us-ascii?Q?RowG2iegaQNi2pFoOmJz/qej8+K/yNdKXvAwrJjwTBEsEdG/RXfGEv7ZzZYF?=
 =?us-ascii?Q?yzuDRH6rYy4RKRywo2098ZG0SYs2l5NKEudRDGumVYrHYqWygHTJj6W42rdf?=
 =?us-ascii?Q?pfshfDvlYN/uMvOnOxy8zx8E6TgCvrJaU5uCY6p8TWahbAWUsthJhcSnEKiP?=
 =?us-ascii?Q?LyApXNPW5+2ezGG/57iQoJ7R8kwXOdYmgMomwBijqnwW0A3/r9jQooyUTp5c?=
 =?us-ascii?Q?DB3jkhMKT2hToLTKvD3Nb/7dIzKkCF0eQpzQf3fQ+IV1SXtS3nLnbsietZl2?=
 =?us-ascii?Q?ebLhvHe2UNaQVukL87BMi/d7Ix7T+o/O/RJlx7u7pMIbczC8VPcrrDhGXcPK?=
 =?us-ascii?Q?PRrh4ve6fUS5bsZJNgfRzaYWLvFgP35XU4csOzq96+nzgiKHTBU9Z5q0d2/k?=
 =?us-ascii?Q?b6QiSZpF9z/99aC7kSk7dwLtsDshQTIfXGyiOAV4ym0Czgb5EPNNXMsQoZfC?=
 =?us-ascii?Q?QcSNlEOGv0jAWjDhZ9XO6PHasCdhgOw9sBGzvA1E6XjsR2I/F6JyKvZLz8II?=
 =?us-ascii?Q?ws7r5ugSU7BJNAUl5nch69dX77Py+1GYClGYDdGF0LphglWna9i/oqMshUEC?=
 =?us-ascii?Q?0z8VgrXqF9tB3NADIrHVgE9zJ64SD9Hy7GuWxuLGmqzJ74hzCLRH5nT2Hdeu?=
 =?us-ascii?Q?AM4ZV1tzQloRK+IME4mkytQOEmUnpMEcTxeklo3lp91ay2huo/RzZmSHMyfc?=
 =?us-ascii?Q?z4YsSku4yma6wr4/O4cVUMl8kmZUY5Oi24UA+fxjeZMJX5srYyHzn0VROa9v?=
 =?us-ascii?Q?QIZk76pLqs9OiJNOw/oUkVun+U583Y+un01TGvGlrOEE0WxU036hG8Y3jxAL?=
 =?us-ascii?Q?Rh72XxvmTGg86jbNFoEyppQLYW8HVWZ4S8MdGxEWB5l4MhGPVidL99XKpbv0?=
 =?us-ascii?Q?h7rDJhUWJ2C0p/h9up4e0fheb386aSbeoSE17GTuxSSMYsKrvE4swJ3tnjW+?=
 =?us-ascii?Q?vlV2IZenhYXm1KnS5vBqTHxO3zMC3jASWi9?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1907;6:8A+IfuqR0DPKxHkHOkPBrHlWRH0tSYf1Ea8gGL553MrAN5gcglz+VIW73gPW37fFwj6kayA0IckYE+gaQeu4EenqsOtPsBTqpVplF1DnkYdseZhoyq4K6mtUku+I1XFLAZSuRTV4qdyId+eHuupwGWV7RoUBBhYEoR45drXnaHavn6Gzd4F6Mhn2no0CRUYHKuYFBYfV66A6mB6Wclo/q0dvJX68l1ddidf/rPc65HfpjhWEfEUpUZvCuDRoI6ZU52ZD4XRJEP/V8tEKwmK0MydUrybcFxM/kYmkAWVyjaFg6kRO5aUcDWVsF6bW5QGSJtz/uccGmDBHmCEAosI5bn845IeN9gdr+0Au1r7DXhU=;5:pcKgg2ayV904GzXxU2tIKGH7uJx2qCcYVM/Pjzp8+I90ds8K4QFG2WKp7RLMWzn8edJ8GCwfuXJINsmvOh+8KWjnspK8dT+yj8KhY8zaUWsDU4bR1MvTvCyFCUF1+0veEPDn7QsoY+DXy/gychS9GkspvI9InZPWQaH/WCD7KHc=;24:9CH0jDNhLZn7V++F1C0CH3pEu0BFMLUCZJBgDR2PN1HsffmmMOx7tmrL1VqS2WduY2Kw434d4A8zvnSuWyOtTWpsAkMlXbET1FLiIdYghes=;7:/YzsM/KvR8Dw6jLQJBk+Ak1XGlxEj0NErJgOCjwzxStp5YTh0r9pVDoe3kzD8tzg0NCZs3YDPlxbwSG4jH2+SXvAvrULSXymoFBbgQmfccY1Pwp3vzybXupZ2cCH014IGjRTzl+93YK2pMXD/7mXXCMh+LPCUL8Mnz9q876Plrz/1g/EmaA3DGjVxl2LKCumPgF1hOdr8KgkgEWmE9EIwhEbEYt7CskBDdXB/H6+d81tDZEB9y06zTA4kgSo/1GF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1907;20:rVP9w0Sl/AspsurWOIL5zXszjStgn+1pqNKO1I9PHp3YXYDWjynwNIiIFJfmzmEdkah4sTOYjB/UHZntJIcBh1kRfNgsjP+LZzcyZH6BZlMA9CMLVAFM7Ce9hfmvddR8ctYRv204a6JEcFiMCXcr+ClIe9dFnNHBf7+Z3edGm4jSc+YajAyh/8LDNODVFLgUpmE1WrclRt5uRUlMbFrdLJzGfsD/XPvjDFjhuqXMNB6te4sBOe0xOvxyByZzPQPs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2018 18:48:28.2443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7fdce3-2c30-498a-8b60-08d569a4623a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1907
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The block address is saved after the block is initialized when
threshold_init_device() is called.

Use the saved block address, if available, rather than trying to
rediscover it.

We can avoid some *on_cpu() calls in the init path that will cause a
call trace when resuming from suspend.

Cc: <stable@vger.kernel.org> # 4.14.x
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mcheck/mce_amd.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c b/arch/x86/kernel/cpu/mcheck/mce_amd.c
index bf53b4549a17..8c4f8f30c779 100644
--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
@@ -436,6 +436,21 @@ static u32 get_block_address(unsigned int cpu, u32 current_addr, u32 low, u32 hi
 {
 	u32 addr = 0, offset = 0;
 
+	if ((bank >= mca_cfg.banks) || (block >= NR_BLOCKS))
+		return addr;
+
+	/* Get address from already initialized block. */
+	if (per_cpu(threshold_banks, cpu)) {
+		struct threshold_bank *bankp = per_cpu(threshold_banks, cpu)[bank];
+
+		if (bankp && bankp->blocks) {
+			struct threshold_block *blockp = &bankp->blocks[block];
+
+			if (blockp)
+				return blockp->address;
+		}
+	}
+
 	if (mce_flags.smca) {
 		if (smca_get_bank_type(bank) == SMCA_RESERVED)
 			return addr;
-- 
2.14.1
