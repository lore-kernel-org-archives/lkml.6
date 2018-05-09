Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965920AbeEITrm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 15:47:42 -0400
Received: from mail-he1eur01on0106.outbound.protection.outlook.com ([104.47.0.106]:44923
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965181AbeEITrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 15:47:39 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-i2c@vger.kernel.org
Subject: [PATCH] i2c: synquacer: fix fence-post error in retry loop
Date: Wed,  9 May 2018 21:47:26 +0200
Message-Id: <20180509194726.29166-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0701CA0071.eurprd07.prod.outlook.com
 (2603:10a6:3:64::15) To DB6PR0202MB2774.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2774;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;3:r5JZA2H03kfUdLXtMu1wxUlaOVWx4aIVwmcQM01PuGID5BM0Yh2vccZHZmk0FexXhLXKsCwOKX1V9p7NdfqnKx2jsA2eicvuBWLGD2KP+exFfKsd5YSxeMLDEWYL7H7Yo+80Dyvv6FO+CLa6yke0HOJeH3OGd0kJbtb749wlPPmmVFZRNvER1xu5Qvskj5rsCA8azOth7S2WfbzjwvwSaSJ1WaoF/wu2jhdAMBUCYAENb99zcEFF50tus3O7CiD9;25:iuyZejbFwLESMNOrfqYnHm92VmRCKr6yHelSdaFRQx2XKnsbbV8IDmMqrsI294WTBhlJtdHLKZfJtmRNRKgZfxprV/0M09C1N1dG4CHZuPYPPb+HCR2YNFLni3vc4jlqTqsfOw3qNNurXJCOv5CMwo9TQ2PtdLXMc21VTpjV+IDLiWVNw4SUsDGHFkkSo/Bejpmp0Iv1PalECu4po2pSMDYS5G1dJkzDEej8nZ5+ObhiOEIi0IIRyDbUpmdCU94HxgXKHb+Ju+cGPUD7nEGVLRQxYqR/D0C4JH8bJEI5PTytpnAyIKszNWHnFTYxJzDNTxulLE1nwxG8CxL92oUhrQ==;31:cEP+4+rp4VxSngxh+brtWEhYTzh5c4YXcJnh7iho8gMEv46VGU3DmUZZ1++FedtSN2Xkaq2eGGZgu/8C1cppTtsm5LyM3IKs3cvTblXicKeq0FNrLPmE1uJ+onQNuh9jAmdl9Y18+pc7ADXqsGos5mXhTcUNl1+syMyBy/681JxNPv1tA09+HnSokDU7n9FijlhJcHhGFaFYh6YxXld76ijdMIaEtBxZXFUr67FH64M=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2774:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2774805ED5F8674A8E6F7A3DBC990@DB6PR0202MB2774.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(2016111802025)(20161123564045)(20161123562045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:DB6PR0202MB2774;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2774;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;4:Yftq5LWtQLWO/q7XckUO6s/CdN60Sy/N9s3q3CVvwLLmZLwu7EmV1oXjKz4n4x7U9WWF8cYPZ1j8rkLUsrqKW+C5O2lB5tnGzf9BnF6nlQNV8ZFUdqVZF8l6Q08GtatvHfBIxCRV+H9JU0zD9oi+2zvMEq82/UmRKCFDpDZxPQdLy2K/BUCR8zQ9/uri/PspKP/iESh3W/bDrhBPur0ecDZuuDBgJd6EpUZkHUuUw/a2StcLBCbAhI0xjvvnz+wQWf2WD4dWiX4ypZ3GlYGZEg==
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(376002)(396003)(346002)(39830400003)(199004)(189003)(3846002)(59450400001)(476003)(54906003)(2616005)(956004)(2361001)(68736007)(36756003)(486006)(4326008)(478600001)(8676002)(16586007)(48376002)(6116002)(6486002)(86362001)(26005)(6666003)(74482002)(50466002)(6506007)(386003)(8936002)(51416003)(6916009)(7736002)(305945005)(52116002)(16526019)(186003)(5660300001)(106356001)(50226002)(1076002)(81166006)(66066001)(105586002)(47776003)(316002)(53936002)(45080400002)(6512007)(97736004)(2351001)(1857600001)(2906002)(81156014)(25786009)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2774;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0202MB2774;23:kEzru59wOWRC41T5hV/Mg9b+IAnaFMc0kYEAjIA?=
 =?us-ascii?Q?fyHYJri1Yb5Q9hYrid6tsJ04x9kJ8+VH9dMn28liBNHcgXgxbD/RxY7a51RW?=
 =?us-ascii?Q?39hr2FNj0hWQHWCAUvyFccO3vfWY65QVQ+Rp6/J/tTEAImP40P+ZV2z/xKHN?=
 =?us-ascii?Q?9g6sNgH2ZoUsTYCoGUun7n65hmxLA8IeT0lT3trBokhUOf8z6zE69e6TX30R?=
 =?us-ascii?Q?uBFAouv6CadVlkJrBzgYNn8etDRpo6oYMZPl9MXTxSxdfL76lSiyVmecuIUW?=
 =?us-ascii?Q?Ixq7H4SaZSNlPxgf10thsfHSxF1ZZa0Kjv9HCq1XHvkaC+D4U1ynVVQUaqAw?=
 =?us-ascii?Q?mJsQmKT9PTh56OtdTvvydQQG8M9L9mjtNlR6Rm5GVLFfie9rd4npq3IOIdXX?=
 =?us-ascii?Q?PDUEwhU2lTIAbyDD+IHePqodw7yA6NMwdJpjbDCy2yRyZmWB/oNlsju68F7G?=
 =?us-ascii?Q?ncviJGcz3ACeSmUeynCPSBROMs+J8+HeOQdPzLl+VyMlbg1JyRWcqWrDuHEJ?=
 =?us-ascii?Q?S9Ok+m+lvcn1wCktmZb+oQdqs5BOFdpD7bvORIjtTc6YatAxeXSa3gz9roWv?=
 =?us-ascii?Q?3iMCmRXYEMPQo2bnwieS5+cvcKcFMUCbPJ+g/3LT0egaz4je7fPCm5Oln/c1?=
 =?us-ascii?Q?CWLmaf8hbeTj4oVV0mZcZ025fQtVPR/SZQoBUut2pWlRpssK8RU9aAIk9n8F?=
 =?us-ascii?Q?B3FqzDzG/k6upo6GGLsE3anIpbk6Bf1iLq+pEQADOhP2HA9VeTWiiRtPRm/T?=
 =?us-ascii?Q?JjGc8O5WIGyhzZ2pCD/U7AgK6pO63I7B0PALM+gDUwdXCPhahXWWL7qKgKId?=
 =?us-ascii?Q?jgr5BgkSr/ByvZKTvgpCdTZNWhO4+3fI55J3BcQKC2onQZBe2XM8Cr8Mv3o6?=
 =?us-ascii?Q?G8ZCSRYR9s9bSfmh8JPCTwBPUAuxFDpIJOcgElGheUJ2abWjGFNzecOl5Xmm?=
 =?us-ascii?Q?t6DrnKJNIfd7GsMTS7upH+65euBMUhxLVpgTQaa9QoO9MADMHLBc4jINxCqQ?=
 =?us-ascii?Q?ISAS+gALX9g5l4qKc/K2uDGwnRPoz6L0yEtyJXbSA/41ZibQdJdEyZQm/wal?=
 =?us-ascii?Q?5oa2MsKxribTb17C6ONgT6Y9ziDuAKasnjLdhSPnb3GjEeJO9cm05O7GdvK7?=
 =?us-ascii?Q?WAuJXpVN38Cu0veT+Vg7kR7sl1VP6zzDHaHxomgZy8eQR/Cb4fV/a83elEv4?=
 =?us-ascii?Q?FDIUYCa0jeXV/0QUl3W6s/3F7DeLueYs0qPQ9JX+wFWitmUeOMN9wwuKYXbH?=
 =?us-ascii?Q?4EE1MLlJ/mRVSTkcyZ4RZMT8s4oHnA9m36F64JbhVYlYYSwHkmpMD+1gOwLE?=
 =?us-ascii?Q?DrNPlHLDESbVLMJoGrx/cHFY=3D?=
X-Microsoft-Antispam-Message-Info: qmzV9m3xFHVCOhZEJ+iFvQTqQ19gDotPsAx+c3T60IEL8GTz8UVOhxM9CWb9Atmx7E7f44qbUVarlp8Qj0z/oSkYHsgkL8Fjqes/VHQC3OWY3H855DhaVSFjxUzmeT+2iw4m91mrwMz6T2+fw3PpICRFJo/jcHkeXnMPOk99wmvDX73gBCIdOF9+8iCQ5+n7
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;6:VSeJnGFsEcdyFxu+4hjYcrQc4YVIZ7r0MNAhsmwA2KHRMwRuexbdsBLYXzJMl3Nej17rSZUBLA5GqESUxwT+mKeJadQhpN4f1jJc67+cIILSklHI2Ca24sqxb4qZoRUp0ucduKK6QQIowcAfKtQKwwEPr5FRalf34SZviije5ezYKr5C+0v2v1vC6mvtiV9t4cBEvRY0y4oAiL+6C0c/sdw3aIfjRhWamfrBnFsy6WSsQCTujUl1zRUSjVkRR9aoLahPevkyKLQ1BRKR5BGzc51E3QnJ0yOGl2F51kw5SWdb6CkhdhaVvAHdCbGc6yNvVpedVh4vqdhBw15iETU5vaXm2C3NtvQ7QFyvDIlfKJ0ordRqeAfWSgIIXYKv7ZKnsUlPBYNH9NEpUNWNeZ90tJItmrS60KSYU5G2DOFvkxEEU7QXCG23cEqPcw61JBu6N19tKXwmToW9+rlIkHTBOA==;5:7oNd9d+PH0vwWmbUkYxzxX7wYwhtQ810EdiKtx95LXWwengcM24uzXJhtVOgO0q/p7BlYORFMUw3FyLfNIBY2VSjnRDRvWHejwglSBbZEUQAWyb6K1tl+8JZPB/lp7lgPjfjUak3B+D1rCyci7lZZhYA5sU2HFxz2S9funHmgcg=;24:+DqXvThETM6p7qvdmsdB6qnb6pWZDejnrMCQpTcucEOzuVV5QYJKYOJU+zKO0gYEomN3Pvt3TncaI8l3m5k1iUKyDGTtfY5ZazKebgqlefo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;7:zCooMm2JSRl4d504hP7mSK+eoMwNmmaV95FS67h+D2qF6RCoS5+qkQY8hguTf8VA5bfFRaqYaktQZijC7sT7IIVRGn0Q+iMYKRS63HXHUnKdFeAZ/IdkBf4hYdoW6aVJFlSuMEEfrK5LjT+DweouUeTxrAAZ1WiTeMSNq2K2KAqlYTSYl8GH9EQ53Y54lNOdEfbaDCILOcZuLR/Ir6Pp6CDn3huEyJMMczFVjwPj0U8Fsu7Cadnengzz+H8DEkjm
X-MS-Office365-Filtering-Correlation-Id: d02d3105-3f2e-40f3-cb59-08d5b5e5b5f0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 19:47:34.3481 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d02d3105-3f2e-40f3-cb59-08d5b5e5b5f0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2774
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a difference between attempts and retries.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-synquacer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-synquacer.c b/drivers/i2c/busses/i2c-synquacer.c
index a021f866d8c2..915f5edbab33 100644
--- a/drivers/i2c/busses/i2c-synquacer.c
+++ b/drivers/i2c/busses/i2c-synquacer.c
@@ -509,7 +509,7 @@ static int synquacer_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 
 	dev_dbg(i2c->dev, "calculated timeout %d ms\n", i2c->timeout_ms);
 
-	for (retry = 0; retry < adap->retries; retry++) {
+	for (retry = 0; retry <= adap->retries; retry++) {
 		ret = synquacer_i2c_doxfer(i2c, msgs, num);
 		if (ret != -EAGAIN)
 			return ret;
-- 
2.11.0
