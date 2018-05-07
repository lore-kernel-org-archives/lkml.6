Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeEGHoy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 03:44:54 -0400
Received: from mail-co1nam03on0071.outbound.protection.outlook.com ([104.47.40.71]:41216
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750964AbeEGHou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 03:44:50 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Mon, 7 May 2018 15:44:13 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm: berlin: remove non-necessary flush_cache_all()
Message-ID: <20180507154413.5ca0838a@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR01CA0014.jpnprd01.prod.outlook.com
 (2603:1096:404:a::26) To MWHPR03MB2640.namprd03.prod.outlook.com
 (2603:10b6:300:46::10)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR03MB2640;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2640;3:iyiVTK1BOVwRLjOpnTF9JhTRqyZ3PsWcRXTscNZ9hcCxb4+Gn8iYDp6tCsptdRJqMUUrVtdeIlmQCy6SD5pHQLa7YYDFVc8MQLaQ3cmVUV4UsVr45ROsTjIN900oqE7n9A2YUfvXxMsJClcYJJByA5pRt9d6jF11lFDoacyTzvPlHp2d6xSp3Ra4aSP7HCXtm4ZuZFDpDdHGyUbH77wWSS+jOcwTxla4VND2bX46dt/AowE+jNxyFfe3d49z4Imu;25:ivNJh4iiQcnkNX0tmMwS8QsgkCXZAYVi9asT3IRywwSJFS0yqixzyKzHLea3LLZpPhSDzHtgbqlfV1ogo+kk2iwfpHw7d2Si36xBUBbMr5qCwroIVf9iJbFo7Y0kyYILCTCh7f7o4QYuieub1MqMOE+U+n+W8L5tezBPpUP6dNKF9S1Uk6gpUvsvQDm57wPhy7V1Cs9lP8MBcZsnTF9rxgZ31UA0Ns7chY8R3vpgQLXriFCNpH44A32xVNp/Z3mLvAZyZmRdFJPiyr51IXiZg9pP+DTQ5TGdhL6hDfKSvuW906AM+agJKvsDeosGzfFLTU6mGf6DfdsNIN2DlUmgKQ==;31:+0ceFYA0fBw3uViBV1rjcozzAeFfky8/2CVJBSB3DeBPa2jhn2mgwWBRtlUdgXkLdYULbGaanq+l4qnwB1aA6t+2HXLZ7/ZkJRPLvERh7fiqSYIoc0BjHjwTJd1D/Vars1C1u2u+OE/ogkgUxRRoUY02CTBTLg58OGI/2Lv8WtxrKnK/d/nl1DzLM/pgj1SAR39MEUwixD8qytPeU3ptbOZcXB/mfcA3lnxpOLVMH6o=
X-MS-TrafficTypeDiagnostic: MWHPR03MB2640:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2640;20:31U6qNsyWxtWhwaVzQsN4MLYSfEUJ5zlw+f63r9sF/U8K/0ZAJP06NG4kGYnIyqe+Sm1v/aNiCAsCJiOd1tDTTQIwVBYF70BmqzCLmEl4Niz0S4sCm0ZmK8KVR5UyotNS7oaU9YmWVk8N76CYUAtCwRLLWUdsvJw0qWusIB+P4cOu6JMcCI0Azerzyocfegc3YFwW4UUYo5sgAGre6kqAVTjCkASZfNF9Dl9vKNDdxdG8Bc+SjjmWFbOnG+30PX/ldNhLYPOLAUCFw88FW0XDeYD1jeiVjombyUzFBMaqwinUKmhQ2DKyoIpwPvUAh3rR+0oX8hXDld35nyxZP6vnbavhDs2kugcUeitImRxNiTam6UO0od++Qa75YCZo05Y6Kt/plfarVoaNV/I8dhhmedvnUNgZQiuDktaLm0rFFNH1ZSTc3ID/GSJcAw6WdOFlo5jq9rLbd7+23I8krC3lLe44IHjxv7ZgMFh9N/1vtq0y577cyQ2ro510rZrclKV;4:+BEK4KiwFLgTGK/wsFlc69JFk9tVqctO74Y2E4UEZQ9Qv3KvZuJks8G6nOfiXooLun6/LQuzOEfjZUn3gVCfrxFphGztjDt5997PlX+Spr8Xa0hhOpZVLNx16Ws4+IemScAewZs695Hx6iMhBO3MM6NE+jNtXz3DfxdrRtNJqMPU77wBoHMlJ87hiZidWOC8EHLWO7PARU3n5ueXPbuDU+HCnKczm+57a0IbvHPgpliPaMCN/ih2dwoNU8Yyyfn0FWg0vTdWJPEzTRC5V8WTwA==
X-Microsoft-Antispam-PRVS: <MWHPR03MB26409729BEA7ABB0661F55B2ED9B0@MWHPR03MB2640.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150025)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:MWHPR03MB2640;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB2640;
X-Forefront-PRVS: 066517B35B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39850400004)(396003)(366004)(39380400002)(376002)(199004)(189003)(4326008)(8936002)(26005)(55016002)(305945005)(9686003)(16526019)(68736007)(186003)(33896004)(230700001)(59450400001)(6506007)(386003)(1857600001)(25786009)(316002)(52116002)(7696005)(105586002)(66066001)(50226002)(47776003)(106356001)(97736004)(81166006)(81156014)(8676002)(39060400002)(50466002)(2906002)(6916009)(5660300001)(476003)(6666003)(23726003)(1076002)(478600001)(86362001)(486006)(956004)(72206003)(53936002)(6116002)(7736002)(3846002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2640;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB2640;23:ciwtEdD2aUPylNeK9yt/nn3h0s5CmM0G16loPTILs?=
 =?us-ascii?Q?FyJLOs1TmbiaNRG5mnbzofg290xO0mTdPLB1vNT+2ZgU4aw/fiZxwNEL4JFO?=
 =?us-ascii?Q?S7X+BFH2aLBONCrFz8ZX1szT2Bqr6amJEUBri5Ph8aMaB+cvJ9YPtmcshjzY?=
 =?us-ascii?Q?BoxpjFL7Wi0VqgACM6IvyZBPMiuCTh1JHrFKVlbOE4etgkiCgEQnwXw1ZDlZ?=
 =?us-ascii?Q?OHed6qmEFKpNpSI/lxD/dYRBylHFJfXniQj9yJ8jP4oRiMiLIVmq7+WDNiAR?=
 =?us-ascii?Q?2NrnLBZQqMFAlNKh8v6sasMrCntjo/yEZvGRYJxXj2h1LpShuuP13ahVNVFa?=
 =?us-ascii?Q?bkldjcQL03ZOZ4r6p8FHYyL9lHjT71y0vscdl04tl4QLa0WwvBkX0QKevShG?=
 =?us-ascii?Q?MI800YiBxCz4YzMB2+0kIiJv6R1duFjYZ5WyRw1rS04ipIFEQSxS7v0TeMm6?=
 =?us-ascii?Q?hqOt79ogCWmSpIEhw9Hi5yssZTOFX11PTDBxWsOSfUdgQes8EHry3+Rojclm?=
 =?us-ascii?Q?l/LITVQuxepEYbPu03xPwEV9KMAn0RPYqAZIrJq1salyFer1iQjBuMg1IO0r?=
 =?us-ascii?Q?6GflpZ7fYb+SKzPIspvqb7BX2H187OAzbukPDlFWTV+thLKakha/de2XW1VP?=
 =?us-ascii?Q?DDBgI00Ec+6GOTF8zwhWW+h8ys6JAtnR8f1dlSTPg5kCt8s2PaeP1pPyzMqZ?=
 =?us-ascii?Q?j0s9O9XLWTp6KkrhSEbF87GdjRO93x50AMgsWzftTa95QKdv1sDV0S+yN0U5?=
 =?us-ascii?Q?ZbM/kEQpQviegfWBcaFkm9zem20FDCVkd+AdUr0kmTBQq1SNNGImrhsRcqtY?=
 =?us-ascii?Q?jUxQo14R3yyNKweZSj2MGjiygp0NH1cg27qU4+b7iPbRkQrmm4/Dp2v7Gy0b?=
 =?us-ascii?Q?Vg9wcwcL/TnCh61a40hRwQuJM8ZiT7Lye8Hs73/B76AQjT7YHBca+c5HOA9V?=
 =?us-ascii?Q?d8r/x3zqAeMtv0PD+bgKL6ZBjU0lHEbni3EFysPabdQcHXC8Gc/RX+6GGubi?=
 =?us-ascii?Q?SVLWmv2gt81TEzmz7FPy9PmMrfigPZEGiZCIW1xKNMqLNHI56NEb8eWJjGJt?=
 =?us-ascii?Q?zSIrHFaVlrVElJmml7GtedTGRP9PKHb6nX2xu+gQblml+bdrYOvGrLNDQ0vD?=
 =?us-ascii?Q?Atn/swdc/RcOgrcM+SCfRk9q3eaQeT7EeaFXHmRzCPzVFUmuM30dsfs0tO4D?=
 =?us-ascii?Q?BGyrW7wKnFVYKB02hEfxMymSbX0BaLMo+og/aOxokat4qoeHQ6FmgU3zZ5W4?=
 =?us-ascii?Q?Hvt61WA1W8csXPaphQ=3D?=
X-Microsoft-Antispam-Message-Info: YgCG0vnwIGEDJoEP6tjjY9ljp1yti6+vt1roxVBSexCdjJhXpoG3k1Y+a00EW/F+mI6tdNqOE/67+5We8eO8OsbyY2Ny1l9dYPJnRMgPOdq3XUq2x8ae37YIaGgX+FXhGfGxCxJ2Dicy13EjcllNuusjsZm42/wjUjp1l+6uVDXf/mvh35hYdeCwdrzAUn6y
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2640;6:X/QT7dwxSSbYaqAqqcXmsjqpv9eWJEMKGpEBFqejTvutbRE8HvNFyaNo//qFzfNOpKmdPXilgDUIuGubIUknhBjiAVR/aGPHab7RSEbdtsRBBBLg2FHRKQvcOzTTHY2oZm6gy7zZ+I+kiInBZF2Z3Rj1ZFAj0AkyEJCkYiQ5hRJXt4rBLlMiVOOGd61lbFY15oepWcXT3GFfsraM98Bp4yhuHcSOA7tJsF/dmfV5NNKA/ELvfEjGnfFnnpMrYlEz8Eicyl1dsXdkFGIUo0EgTAJMfimVUT/lykplBTW6JhgvQxS0Fv4Cpcs1ssnzl6QJK6313DWJe0T+NFDZPFnL0Wr/BuquCkv38VfUnTeCdhwh4ufTihAYRUgVDOik5XN9exrvmHYprf93s4F6IfepjW8osdAkNHaXvQyqps+aGY6epJ0Ec5OLHJP107uECjgqX3NtiiYcwbEVa72XRtlaSQ==;5:XbMXwWAxFOu6hgJCAqphEcwoX9U7yAOkR7q+4PzGqcEqVfn3sVTa12/T6Vqj3pTHaAKcFLXVjt3YFXLGYERZMSO59q2MSYWkJGWeJCYQ+G5ZwjtOJQGePqDIWYmkKu/CVARn6NO+v5okxbaLNkjiY3rvdZ3Rc7rn0JRYuyMccoE=;24:UpWhtZpg8FEXEGaANJWwSBl2pYjR029smO7ziX3ZkIgYotncUfwZUO6NiA/wux5XEPVgBvSdJ6UC8l+2shmPwXhsdtwcMB4NhNLV1pM5FSA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2640;7:BiUfsb0l18d3oha3Nwf/ycBFEtZah+XU12rVWbbpm31d43pLHdekyraQRrcCyeDjFYcyMuWG7Ci46mRyljbiDGtNt9KKlT8vnyv5QYyd+8eAq+aSSBG51EXU2iqZ3ePzhTKWpO8utd8oGXekbmV19InQ3ZlU73m8FDhP6Lp/s8oX3gXLk/Zab8MapHW3qIloBpfQJwfsTST1hbceRcPrl4gkSWvyhtWZ7QZm6Vbt4SVp/39zsxFPpDu1slwkubVP
X-MS-Office365-Filtering-Correlation-Id: d425a3c7-40e1-44c4-b3ae-08d5b3ee68c2
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2018 07:44:47.4596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d425a3c7-40e1-44c4-b3ae-08d5b3ee68c2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2640
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I believe the flush_cache_all() after scu_enable() is to "Ensure that
the data accessed by CPU0 before the SCU was initialised is visible
to the other CPUs." as commented in scu_enable(). So flush_cache_all()
here is a duplication of the one in scu_enable(), remove it.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm/mach-berlin/platsmp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-berlin/platsmp.c b/arch/arm/mach-berlin/platsmp.c
index 7586b7aec272..a8ae4a566d99 100644
--- a/arch/arm/mach-berlin/platsmp.c
+++ b/arch/arm/mach-berlin/platsmp.c
@@ -81,7 +81,6 @@ static void __init berlin_smp_prepare_cpus(unsigned int max_cpus)
 		goto unmap_scu;
 
 	scu_enable(scu_base);
-	flush_cache_all();
 
 	/*
 	 * Write the first instruction the CPU will execute after being reset
-- 
2.17.0
