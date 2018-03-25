Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753877AbeCYRvl (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 13:51:41 -0400
Received: from mail-dm3nam03on0082.outbound.protection.outlook.com ([104.47.41.82]:16512
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751750AbeCYRvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 13:51:38 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
From: Yury Norov <ynorov@caviumnetworks.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christopher Lameter <cl@linux.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: Yury Norov <ynorov@caviumnetworks.com>,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        kvm-ppc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] rcu: declare rcu_eqs_special_set() in public header
Date: Sun, 25 Mar 2018 20:50:03 +0300
Message-Id: <20180325175004.28162-2-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180325175004.28162-1-ynorov@caviumnetworks.com>
References: <20180325175004.28162-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [36.84.65.149]
X-ClientProxiedBy: HE1PR0102CA0026.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::39) To DM5PR07MB2907.namprd07.prod.outlook.com
 (2603:10b6:3:9::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 648834a6-4dcd-44f7-9982-08d592790dcc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB2907;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2907;3:zYydbvvRqmyejmDL4DxUWXQLDD3TyfsdufpN60HrI7jiDXmxK2qFYUSLXXFcJpXEmLcY87jDWG7rttDQqxhQN+5/xq0FHiSbPDMTkKm4tJNfnGRW74K8AH763uJxXBU93KYBlyLpWNO0kCX4BohySOfGmHBRSQRmZi17oEWrMeZFjxBfP9T+pqwgyGO1UAMqX473hFlKRioBd/qqiIbbeP2wkBhIkfvcXDDGbn30qbaIP1kj1XdAOZSeCRij8KHa;25:8AHUxM7xcXNJUpuIAbvLOene0XzP0X5y1ewEtRWkv6Vkq7x4bWqq/Q3mv43CazPeOWt4xa/IcuGESj97X6wN+Qgq6RXkp7WzRF+N2FnLpyYL5+Ha7Kwqqdc+RAsqQ0zbigkRsn8MnHW7dsJV63dgIAlk3GKSLZsPGTW9WGkgWJFE108UZAVw7cnbE7S5WzYpvSFxFmlvqxkIGlCZgg1Y9N13K3CeHNXZUZjpw6vPgMixmWA2jxYjA4ydfvI5VzTs2X8wIcNnYoPwHCSxrAaTMjtMoQFzKuNh5+/B0kUsKYN8PuO+ls4dJgc6vu2InRy1OKP9uKYqSVZguuaRKUlMkg==;31:eLWeGu11vZbbRenBN7te0SIrGrSzG770EfH+TaYQ8/eSYRBooaoNtCeiKb3xGICqdFbJQXD10B6IHWHEgn7PGBbIOGQQlxbYRLm3EBBjVXkSIinHwZzpXSZi16LU58NBIp75THhMbCOu02QDq/NAuxgeGRDapegXsVWloBLkBTpAi6jpQxDw0Vzvc9OwmOuQT2EBwrxUVLcd6phZLKPV7oTvzSx1s1K+s/b6pcTd758=
X-MS-TrafficTypeDiagnostic: DM5PR07MB2907:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2907;20:F/uhseVdq/87EeeB9OL1TmkPLlPG8oHTZYSks4sTT7MsQQQ8/VxOPhYn43mA+5mWuLj5HbROEGC8e/guJO92j+esmgYxgOMtzUlR3UGJRAWtt//CQi0vnIIcEGSSzH/gBHDdMK/WEJ6oxBE35lOHGS/7heD4itlXgz0wlHu8TdI7A3PC5rx1Vw6vTEBB8EW6McOgQGEMBU2WEYuBi12+LspXin7tH1ClLGjXFbJv9n4F84fNzHvt0brdjMSzLNsWfOPI/DUCu8QoXkMhWYHVbluXn5/8LXgP+jQeXRlxIeLEL8e4ZTgDcFd190mt3q9TcZS6wfgO9QQmDUjlakQDZIZtZlS7JNL6m3GM7LtoezbosLFZii+SXZ6cGQZxrLsJ6oLLwtNJlFCLaXDtDalXtfSRW7qAMf+P9zibsJc+ILel2+toBQd/LhtJc44sDHlkgr/ibgZQBUecIQrhNCeRvpm8HkLbguG30pLmowSybHTfNpjFZdsZMxMSNZjIeU68xU5b4hbVI3WUZ65nNhI6UgruNcVRr0GF2NUVf0zIcEGXVT3gj+xZFWPouN8XmDRZ9fBxQ9GNwfPWd4kybrhj5QbZbp0nJFEtatdUCekESdw=;4:n743heyogjQw2522GoN3m/kqV36XdlWGtBaOKUAE2UxFVHJBXOfQSszgnVjj3WOFfsA+a4F4ysfiXo4LpPjbrKx6i9aSsl93oXEcic5jLuKqK47K1whuCMrmzcWA5wc6vxhAzFCX85SunOismAZD5AzvOQi868aQnK6F4ns6Ql0Nu/zsqUUw1sJL/Z+53VAN0jNke8th9HTFAzIA5vSAnQtw6Gy3VXK6Qd1YRSbhzim1Vl2pD93WGIKHpGg5XV1E1ej1xvcbhTBJ3+y/OmnGPw==
X-Microsoft-Antispam-PRVS: <DM5PR07MB2907DB37F414195C042A09E2E3AE0@DM5PR07MB2907.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR07MB2907;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB2907;
X-Forefront-PRVS: 0622A98CD5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39380400002)(396003)(346002)(366004)(39850400004)(376002)(199004)(189003)(106356001)(6496006)(55236004)(76176011)(4326008)(25786009)(110136005)(2906002)(3846002)(6116002)(1076002)(7736002)(7416002)(50466002)(5660300001)(305945005)(36756003)(2616005)(47776003)(66066001)(105586002)(76506005)(6666003)(48376002)(16526019)(478600001)(186003)(81166006)(81156014)(8936002)(50226002)(97736004)(26005)(8676002)(11346002)(386003)(16586007)(446003)(316002)(6486002)(53936002)(51416003)(72206003)(42882007)(68736007)(956004)(52116002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB2907;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB2907;23:D0JubVDkSRXLreKVbqzyTNORREV8RmemlKzOsixk5?=
 =?us-ascii?Q?WBTZjNxmma6s8TKLsmBsbD27qVx0Zg73YMmBsyVEyioRgOuGD9wPrUyPR+oz?=
 =?us-ascii?Q?jNGhB91jkiniscsYKcHzkFBCtg+2rMuOrO6c5CSCKDrFbYYZEM6e56E/Y7JV?=
 =?us-ascii?Q?1nMHYL8DdVL8RO8KRiJaTE4oj/dLeSoW0UvLEraHIzwWYnNYrkiFbZyJXVDQ?=
 =?us-ascii?Q?7bDhOkjqivO2ByNvafzbG0MDmQG3vssN0wHkcNfR+wLC7ox04+Zv/3G0O6Gd?=
 =?us-ascii?Q?Va7UvBwQqB7r/vwS0Nt/7LBZZ+NCJkYBWg8vJhCLEiDDX7g3yawwn8JKtFPZ?=
 =?us-ascii?Q?m5uig1w8U0WIObeAwkOpz786MPWHg24fkhNKB82JJYazMe6NCtu3TMrTJc6W?=
 =?us-ascii?Q?a3aSXhBQrT/QSPYznWP6woveqAqK6ELM6Jma3Ovl65oISarsrBp31oAifpWF?=
 =?us-ascii?Q?XtoMZ/SxN9YJItauaSmx5Gnw60pmcwbuu/JEyTR5ZrYuPtStiT4Kgkq5CjUF?=
 =?us-ascii?Q?WfW6e9NUT7HqA7MYsGUi91ukwPfQel0JKYbCT4J8HUBirjHVhsqNfLRdr3Zn?=
 =?us-ascii?Q?DFfUcH/S7QLpd0mBAyT+G89twJpkjAetegDWL2RpCWz5VgoN4NFbNW8OCWTg?=
 =?us-ascii?Q?n6ugNPcBRiXgKbq4/2DVy4q7YFGxRV/jNAUWk/jpuJFmZICNcKdRmy/Zcoq3?=
 =?us-ascii?Q?qQOuyZejSWC6/E0J0dfqp9tRPOEsRB2tp9QkhbYiKVi0MY+4zCQ3SpP4lRaW?=
 =?us-ascii?Q?K2m049PIf3WVV/ZsD89qf4ROeKzi28WY7Rpg4NGkgD8edr151hf1IYuzLQ8p?=
 =?us-ascii?Q?VFR0MGETZjXtozg0EEg1CfJxKgIKvancwJgxFPYS4ca351rLl6kQyHFiYJX1?=
 =?us-ascii?Q?iL1CPTeCzKWkr3QFFBQ1xI08C6CoGm8wUt4SzLUtU8S29v2iGz5iwbnMQO4T?=
 =?us-ascii?Q?ZbUbYuTg3SkYFtyM8wGN+/f7tEWBJc860K6cvW4utXuMF98hR6axBQ+f4Hyp?=
 =?us-ascii?Q?mNb6S8G3scY1bkeHlzP5oi+Jo0kvYzrv/WEmaVxwJh6/qXZ1tWKkSv/2XKzb?=
 =?us-ascii?Q?/KyIf5U7vf5H4KOpTkRRbOHGj3yqGA14upjdlZqZe+P5gSB6cNnmUhXqjkn9?=
 =?us-ascii?Q?ThrmUzbB7t/BZbgX63pdP4cBGvdNhhiS687jpHUuJcxsoYg/BmmJ8JP+pgPC?=
 =?us-ascii?Q?scHD06QzUYas3MwCEb7McJR116+VQodxb+l0Kil3LjKI7xa86hca7JHeVSAX?=
 =?us-ascii?Q?61+OLq+/yqYY00AugMdl61u2p5/8QDUrzDhwCNkRYAL3VOZL+kAGdOKeRT9U?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: iVQEuNnu9kAXzpyz7UWzdZPii0YRNPMzBcAimvpMT5d3U14kzUj8P9MxoCOPkXp1tWkVNGCqSfXmF0POlrT3rcn4GLLuMRx4fmmazc0pu0nky70MFfkCepeYHNukMXN1UF+reSy6UtE+xywREXG85y/s4SY+B9/iUiYu6+cuRMLtqTuO/igjgZsLrxQx2feQ
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2907;6:dm5gGLHsEE68w253uMYLbcd0iJjRhxOBVUizPX2pWL8s9Zid5jfqYOznxlLWd1wlWjEa+a0Cfq0CDqxHiWQkmDpTDGle1qT93keb5jrfhqXLu4Uv5cxsfxKjkqaonikFeWFAfLEvFv7BzdA0xkYYypM4I+sik1iMg/szQ1AUBqN/VPX7oy6119BBwIfMQcrKPe01FZubWedAeHr/InsqzlaALY8ExLzfYgBpLwS8QNrjYrXiTTeINftdIu3QoHcss5kaLS4UBPRMPrxqu3z2DRrKIovEqXG8tUE58hn/ROGMlxbtnlf1CjWcKVQDsQltYp7KbYZy7lffuu5NevmjgYq5e6YycKG2rEAIyKg1TfmIsbVtsajcjX+nfEWtfQhiyrHTJUazxd0YPyAYPifvvg40I4sT/Tzq6sDyAvDACWo0iny1SLOtya9oMxoXkM/97grKyRVJx8Zlalc/caeTFA==;5:9XTu2LWtgaKUFD6puO+jCq7QEPxCfGSs68tnd1g7OF74bqvhrH2n0LDsBELrwGBPBMgfUYD1MVz1PNtQQj7gWbNzN0NcFjp+2HReAiZggmr9NxK46LV/+7tGjhF4n3ihUGkGxWRSL4Uky7jxA/0W+DxSlRFSYGxEaI302ziLs0M=;24:RKscHgUb0CkKJm124VYqCwsHBSg7NfvLVucfrzPvtLuUj9FDpichX1+4vdSLaHpsGtPq3h+NCOonsNZK6GTfKZbbBhGxjG5bq0XZFJClhVw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2907;7:KK7Ycq3IXrSjhgh5nvERUrWPbKkTZQV8KJSNdYJI0GmCB72cafq8dlI1TblhYUsOP77cmX0pBEqxQAPtVbAjTAa/dgbhX8LYzJt4oJmPFu6MlI7yf0gxLZoW77/G3TvXyzGlmFLN2CiqtAmS4Gzy40ZRh92M82kWFrZ/VpAiyO+mYIcSsgpJj8r6dfNUaDpbtbU4kQlvf6J8j6IEHFiScg/DhiJE0RbgDqS55VGfRWM/6G8yH1Z+RbDCYPmBzNmA
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2018 17:50:46.7219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 648834a6-4dcd-44f7-9982-08d592790dcc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB2907
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rcu_eqs_special_set() is declared only in internal header
kernel/rcu/tree.h and stubbed in include/linux/rcutiny.h.

This patch declares rcu_eqs_special_set() in include/linux/rcutree.h, so
it can be used in non-rcu kernel code.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 include/linux/rcutree.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index fd996cdf1833..448f20f27396 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -74,6 +74,7 @@ static inline void synchronize_rcu_bh_expedited(void)
 void rcu_barrier(void);
 void rcu_barrier_bh(void);
 void rcu_barrier_sched(void);
+bool rcu_eqs_special_set(int cpu);
 unsigned long get_state_synchronize_rcu(void);
 void cond_synchronize_rcu(unsigned long oldstate);
 unsigned long get_state_synchronize_sched(void);
-- 
2.14.1
