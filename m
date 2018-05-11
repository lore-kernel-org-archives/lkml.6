Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752643AbeEKDiF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 23:38:05 -0400
Received: from mail-sn1nam01on0100.outbound.protection.outlook.com ([104.47.32.100]:36448
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750937AbeEKDhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 23:37:46 -0400
Authentication-Results: spf=fail (sender IP is 64.157.242.222)
 smtp.mailfrom=nxp.com; nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=fail action=none header.from=nxp.com;
From: Yinbo Zhu <yinbo.zhu@nxp.com>
To: <yinbo.zhu@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Catalin Marinas )" <catalin.marinas@arm.com>,
        "Will Deacon )" <will.deacon@arm.com>,
        "Lorenzo Pieralisi )" <lorenzo.pieralisi@arm.com>,
        Li Yang <leoyang.li@nxp.com>
CC: <xiaobo.xie@nxp.com>, <ran.wang_1@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Changming Huang <jerry.huang@nxp.com>,
        Minghuan Lian <Minghuan.Lian@nxp.com>, Zhao Qiang <qiang.zhao@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "jiaheng . fan" <jiaheng.fan@nxp.com>, Po Liu <po.liu@nxp.com>,
        Nipun Gupta <nipun.gupta@nxp.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Priyanka Jain <priyanka.jain@nxp.com>, Sumit Garg <sumit.garg@nxp.com>,
        costi <constantin.tudor@freescale.com>,
        Bogdan Purcareata <bogdan.purcareata@nxp.com>,
        Meng Yi <meng.yi@nxp.com>, Wang Dongsheng <dongsheng.wang@nxp.com>,
        "open list:CLOCKSOURCE, CLOCKEVENT DRIVERS"
        <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "open list:FREESCALE SOC DRIVERS" <linuxppc-dev@lists.ozlabs.org>,
        Tang Yuantian <Yuantian.Tang@nxp.com>, <ying.zhang22455@nxp.com>,
        Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH 9/9] armv8: add psci 0.2 stardard support
Date: Fri, 11 May 2018 11:35:30 +0800
Message-ID: <20180511033530.7931-9-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180511033530.7931-1-yinbo.zhu@nxp.com>
References: <20180511033530.7931-1-yinbo.zhu@nxp.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:64.157.242.222;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(1496009)(396003)(376002)(39860400002)(39380400002)(346002)(2980300002)(1109001)(1110001)(339900001)(199004)(189003)(53936002)(81166006)(51416003)(446003)(8676002)(11346002)(59450400001)(81156014)(50226002)(1076002)(77096007)(2616005)(476003)(126002)(97736004)(47776003)(44832011)(26005)(6636002)(5660300001)(486006)(8936002)(76176011)(336012)(106466001)(86362001)(498600001)(54906003)(110136005)(48376002)(305945005)(356003)(85426001)(7416002)(316002)(8656006)(105606002)(16586007)(36756003)(7406005)(2906002)(4326008)(50466002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR03MB2182;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;LANG:en;PTR:ErrorRetry;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD018;1:Ln6wDsYjO+B5tDpbbeakt7BVFfHkWNEN2HSMWax1Kl/MVMNcpVYfLpMSv3tp8W7hc6i2Uzo/0NiYvh6hQcb/CwLwObvJgpdz8uWeHRBQYjDP53ERhGefamNUvVZN849M
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(5600026)(2017052603328);SRVR:CO2PR03MB2182;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2182;3:nC2o6eBPufneS5G/QXA7mah8jSfN7RoIrXLsfl46YZcvtB7bHPo/Fw+uxE17lZ3hJ1VWlNKcgeTHFFgfV9shAE072ycYF5MoJIiTjL58tfFSjxIG2X55DyK5a74Lx/pP9P0rgNHpwFaiqXzg67dqRb+V2o2vsqRJMfOcSIF9ogmRaErDVThb5wIZuzj4aBQyMCmD8cuRsFdtaKvOmsNj8T8gswDfod8tZThRnWy8tpcgyA1KG0Rk+z31MHm5azNvzN2YsQGisFotnJI7QRAwRpQFg7mWcNYTMfLvR9Mfv9ZhHOObr1q+l4oMvleAf+5GCVxS/CSFqBmnkyDlr66dwnyhcm5JBegGTeml2YJwbHk=;25:9YLkIfssdC/Qn1EFWKpeNhHSiOL8+4Nf9q5/Fx14AfLW0W2cnCvC5v4c5Rs5312SlWqZiZ+vlTQT6YJHV8VVfJwiyX0EOpSMy8reesJPDM/genFh+4Qd97Q5RyC47fvmQwS6+NbxtgmHKliqAZeMUZQewlz2+IxUAyyLX6qwtdfsU9s0T+b6PCbWqqP1X/XhyrFl6ol6qQU7qXaHVlzPz9QSpx7h7rdxHuuPDkRI8kSffRnjnYC5LRZNS8FJ/KmuFL0m1WkncEtwaWoPYbSSVIFmmpqa/1L/bk/Pi76NjyA4zM3EUms1tkqUGBxRQY3x2uCyeF3Egj3RAAgE0x8Ckg==
X-MS-TrafficTypeDiagnostic: CO2PR03MB2182:
X-LD-Processed: 710a03f5-10f6-4d38-9ff4-a80b81da590d,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2182;31:afmNkffMdsPuzQdHj6ngBJ9nUUiZqHM4tQNHmGK7HO06M7vow+lxTkhRU5jINyoucvYjrg+i0U7En3YWbRQ1DYQWGeABjpNFGbiNtEbFqSR79JWN+T9Wf50Pu8ZfvimRAjahRV9Rz4PBiQnQ0/ZA56kmGYAXJmlbzjGaa/9BYhRoW9qE2JsPZz1/Hsblm/1gQ9VFnyPUcQ7H4JUNohvoG10NkP3pQl4v6UAwUzToAmU=;20:5olecBlvEjlgdZreFkydSNWBeKiDzvw2dgja/1TyvAd6Z7WEwwtkmV4pUZwJLzkeEYxMse7pAvAZ1Ev6vsBW6Lu9cuzXxUGeCCFLgHlXJl0eqdnaxQxRD9o99alYn70d9eID674k3ITF1IYrgHkKMh6vkdocZk3oIZR/JifNlGZgR0AbJ7J2AOAzZw9VeMeM83WuznswvRCGS8fjQt8pwGDBDhRUTIaAMOYVPeIZxOONjC0mX7DaeOQ6aAJK0Ulq5Tjh2RjQeACna13IthLoZFmHxF81l+3o01nMNpRTCGxMjftN5O0EjSiQMlp62AyG/RLHItfWxvQ6n4BOT19Z1rmFIwOl5QZSo2X+CKXnFPKCC71BKy8mwl2ivDYeCYH67dPduklYZdq9HWa9F4qba+urBYXAV0gQ5K2RI6Vyp/h5JpcKkpSuDi8uiuysXFG1JW4iW3tHccn2wLgFp4aN+F2EC3D4DAaC/g44l2VUNW2DqjCq8kfZfccl9UC8MvFNebyCPYLKVS4+6Pu9LA7PaIhIukhhIC4LjWBXJP0l0x2rLys2kVgpNUbCqB/dEFJdFRLnQe3a1iCDmxLyvPTZnITgKS6DIfalSqm+htN3Kv4=
X-Microsoft-Antispam-PRVS: <CO2PR03MB2182FFC228AACB74938B0EB9E99F0@CO2PR03MB2182.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 0
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93003095)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:CO2PR03MB2182;BCL:0;PCL:0;RULEID:;SRVR:CO2PR03MB2182;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2182;4:11CMllXOTy2pCTM5wlEf8yRG75B+UA0SQUGljgGW3DPoyhUwkuhLuh2FxM1bAlfmOS7y38JPS2iXofr4puWeE/XNoG7aaLcyUdhZmMsN0AjEIU1Lw96i2MXi+NNyvUW2VT4C19TivY7oP0foy25RfhrZ1ljqPnw77vxz9oRT7eUF5Pkp8bF6MzkISJDgDIGzXEoC9fNCusmxZmljrcVcu5fTJaUuJcScrKXeIBROpUz9/6gpVCxqP1amXCqDnGYejAlMveFqnFtKgS2MhREAHRD+pqxMMtEFnejb3WVFPKrEI8+Lg+tH3BO/chuFZe/3
X-Forefront-PRVS: 06691A4183
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR03MB2182;23:kgZVxHXg+t9QARgBCrdLON6T0kUGcOmYqiboXra83?=
 =?us-ascii?Q?GzBYG5nlnFLxYZsPWeK2CkGTp0wsDwc/6IakaSz4N29+9dt0NpDR8Q44h+PF?=
 =?us-ascii?Q?AkCl1UPH2JIWHaKCSKIlnWg2n7wDWL/jgUy5Zs3i+hdhFcIqR62ZuoF9cWQB?=
 =?us-ascii?Q?OrUVc2K9FBY0mkEXFvTra6IgbxnzJLPw/4AaxKCzThph9z8N5asoVQQspvEZ?=
 =?us-ascii?Q?LvY3kKAB9Q4AnbC22UlyzF7CyHHmFCHwxbX7JgoVej6KTZZBEBxEAwjfvabK?=
 =?us-ascii?Q?bhXFZDnUIXH+DYx/YfKFYh6s6ArH9Sbr/4UgxkCELOIClPIf6Nkhh+R1Rekx?=
 =?us-ascii?Q?zB7K4/WLjMKxQ55TNmZLxcTbEVpetqX2aS2V4H1lDi+W0XU4DlzzbgKDLguN?=
 =?us-ascii?Q?SM3V8INGk2hWWsloahdMKNKK1EfehXIVD7XZFco74oKwbh8WEiu8HmLXoPkM?=
 =?us-ascii?Q?PPONfl2iD7/ArxXwDJg01lfZOIAEhkOMwJ0vLgCZWtjGBIELbePe4Yd5D+ah?=
 =?us-ascii?Q?6S0um3BF4ykpjR1Zivr72irv+ZlICz+dPgTfLlOK6gzGe7wA5R8D87g1700N?=
 =?us-ascii?Q?a/2e2Oly8JmmJzncBc3YXUWO2/2/XOOLk5ALlEWBcB2cIj42d0sLAqXvIQxB?=
 =?us-ascii?Q?FfaIt21dohkMjHhIAmvqZph4cBL7CO0IjnVgtgWGdxCU8uV5V/S9tnyGia5g?=
 =?us-ascii?Q?K6g8sjd6tZwQjPm5UxkgujxRp9FkJaN4qW3bFoXcqp4sV7cAoySEkbpEIsHU?=
 =?us-ascii?Q?aKX0imfp5R05Gmy2aQNWydKgVGjMBb5u44xvpRKyE7u6WbHetBBXvXqWlW1p?=
 =?us-ascii?Q?bh5/PDOKGFl5RarjkfqqzCg4ecB5JO3hIsHW8lxibkt9QIcXAHHO5yRGeRnX?=
 =?us-ascii?Q?0rGBm6pzs0wcOIKJgDHkEXXGrjyPAN+V/ssO7Ck7rvsuA0QZ7Dj2CRNSjKiN?=
 =?us-ascii?Q?JTdol1tFGamx+1Yj7eSmietDRfq0jGyWN+g8UvIH4rVTtEVd4xd9kY3HABo2?=
 =?us-ascii?Q?fni4SV9zgvzWMBTKXHDz71X6JK7+t97tAC1fBPSNHttmB8p38Gx0gQjLnSH/?=
 =?us-ascii?Q?PwdF74IjlKzFtkoiNOtYv5nLS1ma4vh48tf67G9+C3ke3LBWecmRa4sp5jbZ?=
 =?us-ascii?Q?Q41VPnnwuDsmRMTNQee8qwYb/+S1E+w2m/ofEohVTd+tfflLOw5gEUlb/rJN?=
 =?us-ascii?Q?3f8UqEfVHYIGelSzNyLc4J933NzCwDVQLswfHspOMw7A5wdu+n8y3RxiaJG8?=
 =?us-ascii?Q?gE6wuMHijeFQzulIsc=3D?=
X-Microsoft-Antispam-Message-Info: +Egy91/28l/u39nRpA2ccFiYzZJ4xWQC35o3FFzQcN454FX7T6xCMpW+BU56n09IlIaN3LF05UZ5sutdRc4kRjMtCybvigBw1ODGTVk3JCaQ4Vm2BjfVW3sBrSssHZIjYPDOucpw6HISuOEnuvFLyi0x+2Mk9av9/7BTEuT6enuOpPHjn/9ERZMcKdY5UTs3
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2182;6:uXAtRCqQqUB2ehiVFjoys4p9te7kvibtA+iGiTgSgIfgd+0bUG2L7K5b4TIahd1RlpOpFlCi6LNpggVcX/wDalZCW5HC2IzJlacbBLXUUITKFwHgTvw/A/yXejgrfNxKsu/cU7qtvir3SG/PcMQExBhNqu32L4ZxBbyu3yle0a0eSgqu1R/Vc28uaereA9+PEC1AFtgtnDmtUMx9jvA7zAyAe/mTRcOwr1j+K2jvzvZARbxgKSx3cwS5UV2y04pj+lh0veVzSQAqJGMAx+BV36CLtxx+xZ+xGIScLRubeHHHgsKNrBTpM9e+/WYyfnwLncRoqD6n+3KHZflskV//2Nf0p+eaWn09/mHLp/UXTxbspUm8kqoaBUUf2hQ0Ni4me0PK320aD5nlmOCCesdjXJ3MzaCCwKWCtwJ0McPfzbvQCF+4p439gZ/9q7y3FfrGO0LbxWF0WaGmD/di2taSzg==;5:Z7NfPfffFF7sU0j4/tiZmw60zCnLHXP7BNBHMdWJ1maLtflapBAEHqleNXpDq/o4WE6nl9P843mNIwO7OofwApeJQyG8bQ0Sfgfl6lwCWyYBV4GOFIhVrXPjD81aGBc2/3qV9HKtXr6tN3JJTFj0DCCaVvHP1sQGQsjwORhTNys=;24:srXrCKIW205UrbeZMhTLcC5yaNiWwora3pjUhAQAO86WIlhDxegvmFivG05chgfF6F7hCO/DWnDlNuZtjYyTfR5Z/3UNYVon+iZ14rxYqFI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO2PR03MB2182;7:Eu9rgoj0QXtWUALkTzvxAByp9nr747Q5QTmU+7Gc14v2YfY82vINQYPFQH7aoYFVNpm5JDWFd1AcjK6Oe7vxAIn64KZPj+MJg+dGLaGxw7UC/JDuWqlI2XF2ABiuycTYGzYEW7y8T9XOZmh4UAzvnFyY+JCw5pGZuLu5xxeCuzevPky9Zv9eqw9CSdT+Rld/eMcMvJs5cD7G9M3tdd3FhheTmBKqv5ST+Pk8AkTAtgvD5ogef30nxCpKij3uGB1K
X-MS-Office365-Filtering-Correlation-Id: 2ea6784a-7e94-4368-e70d-08d5b6f08b9b
X-OriginatorOrg: freescale.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2018 03:37:38.7833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea6784a-7e94-4368-e70d-08d5b6f08b9b
X-MS-Exchange-CrossTenant-Id: 710a03f5-10f6-4d38-9ff4-a80b81da590d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=710a03f5-10f6-4d38-9ff4-a80b81da590d;Ip=[64.157.242.222];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR03MB2182
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuantian Tang <andy.tang@nxp.com>

In current kernel, only psci v1.0 is supported. But our psci firmware
only support psci v0.2. So update psci driver to support psci v0.2.

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
---
 drivers/firmware/psci.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 0bd795f..c9ed9fb 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -468,6 +468,8 @@ static void __init psci_init_system_suspend(void)
 	if (!IS_ENABLED(CONFIG_SUSPEND))
 		return;
 
+	suspend_set_ops(&psci_suspend_ops);
+
 	ret = psci_features(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND));
 
 	if (ret != PSCI_RET_NOT_SUPPORTED)
@@ -573,6 +575,8 @@ static void __init psci_0_2_set_functions(void)
 
 	pm_power_off = psci_sys_poweroff;
 
+	psci_init_system_suspend();
+
 	suspend_set_ops(&psci_suspend_ops);
 }
 
-- 
1.7.1
