Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1308309-1521547514-2-1855190849584686808
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521547513; b=MHJSRsyqT4MizlW2IeH1Q0mgpW2oXa41OswZrUAtlPYVytS
    WSNAHSiUfy/QFy0Yro3ti3vG+Iq4iw7pa32qlaf4N++L641SCEFPPDte6XNgsHdH
    DH0+iInVo8ZavXHRqACx1gg1Xe9eADHoptW5IjlZnzRJn6q/MXEv6D0vsq0dzg0n
    8D/FxLkKdNBjBXV2k51pyBEG8zuof8na+D0D3daHIxSiU1yik9dKa4igKGjRdab/
    VPaderfTVk5xKTi5sDM4TmawbCduG/ckGXu/ItzeiggiKQ2YkMOb7sHa6rTj3Y1k
    pDbBryJe+HZzahF4LLuKVADnGre6HoKv7j/vjvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521547513; bh=+
    Q++9UcHfk6LkU+pI6jMskMcd2vkmD9rfJmEOaN/p5A=; b=FU1wq5Fnk4UP8yXIJ
    KrF4aaDgsoiQG6dxyl7KgDxCBNMpirNohKrUMH5ihK4Gsl8XvbJEUERjxUHk02jz
    njo/B+EyTUZEgx3zAZJBzbYvpm6BJBhBqQiicQCq4oabsCJuZw1SC9Wm0DKAqptj
    EY4BuntXNIy9Yp9ARh0xDhiSkrJ3EDI0PP7xvnAoyy9hO5Q5UU1bqH7kkVF0kiWc
    xz4tmpHjaYSgGSYvK9DmZnSpWtuwo3Mzhx01VkUL23Utwb4DCp9YT+SZ0x6pc925
    KIVCYyTOGtI3M6xwD/zCBCKO0jhEG/wPsRDS3S1S6lWLYFTNb6ecjsMbIsoHXamG
    7gVew==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=tzbhVa0N x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=tzbhVa0N x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com;
From: Ioana Radulescu <ruxandra.radulescu@nxp.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH v2] staging: fsl-dpaa2/eth: Defer probing if no MC portal
 available
Date: Tue, 20 Mar 2018 07:04:46 -0500
Message-Id: <20180320120446.9573-1-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
X-Originating-IP: [192.88.168.49]
X-ClientProxiedBy: CY4PR18CA0064.namprd18.prod.outlook.com
 (2603:10b6:903:13f::26) To AM5PR0402MB2692.eurprd04.prod.outlook.com
 (2603:10a6:203:97::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bf28b1e2-d18d-4d43-fd3b-08d58e5acf9e
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:AM5PR0402MB2692;
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2692;
 3:FFG579mDcO+ibf1BU+gWIA9ub1uH8JpBuSMdEYOl7L1mmplBVSS/dqtA3bIh2LCgepJAruV3J4bd2JwkqEN9DXSH6QQdHCEzkGLqsna5Y4kyV16ZvbBhhogbzPAvvqWA5PsBXzfTMQBVIfj0C0d6Vo1JSkbBlZsf26kDw45P9mHKMxmOPusxjLDnIcbUPvzlfAmwGzA18ffS5YAfZXyloeiVOnTHLnDp/ajNsw3XK/oceIshPNa2KM970LGwogqo;
 25:R7YM127hgZ1Nk/FfeCJKm8zYomWpsaA+XiEwEdxgGJxJBqITErgnXWVWC16tEto0PfMv7x6i9jD7ZHCQS5wsYi8OiMm0C9cVKVMbxcPLpEfY0TLS71FLQ38U3r3lfzw9BM2yMKnWtx39hrHUGGjHnEETyTqna5XF1rUwpU6U95YpxFA1zxRhnjpubbzPky/aeuU4VreBuJLpJcddqAAJzfFxFfxGQ+xoKKtsdGNj3O++RmfwZu+Afhf3fPzR75+lUlye+pipyvD3CdB/ECZGWUbg/mks8/jzPEKAzLBsPhCWHKj+Mh35FqC8536Qnw0SrZj1/rixPNlb7snrhfl14Q==;
 31:exd5qN3EDPqf0dGJdeWKWe3O6RBrN6YnEWXyMik9AQJDaPy/VEUraSZtlGQshXZCEeyg2pw3BFEeHUXutLqe/en0tgUimrdj+IeI4LemNJD2tBHZosU40/iRJnEdvSQ4tB/SBarix5wN/5HlTHa1R9X595f116NCDPKVuj5Ef4Jv7PPKvp2xx/ESfjOqX9KhSmmAPaTt8Tqdz9wxEkgYiDlhjFoplpCO32uBord7Unk=
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2692:
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2692;
 20:yv4j1dJonas5MJ/v73E5zJ215gd1R52UHu4Y5B600vuiNCHVkbdjNkcmKm6IVcZqxzwGiGS1Fg0eaeF/+1RPH9quErw+IWHPtvnJ+64D/mqK8GlEwAMsB4KoY1rdazTtXAmFeDldW2OfxfXwuSD36QMC5+l3nZijOXARzDxInyArhjHTnh9nhUZOrrf+MRVuMmnqpOc/1ngZg7hC1Q/0S9xCbq708err/JY+7sBVomIAk+9LICqo7cWFAOFwUpBCsY0UTZnR39XdsNI+LMf9YJTaAxzl3pigq0N5IJkglUP8RkVPKl7wtQ4HQA80PUstpe4SX7wjuwyEQwMymbpY0vL2pPLo+F3ZcBSEWXcEWp4dsPVKj8m8z09QobAq11Nn4Ovpnh3aOAUzteTgmsGibfrySSCX5iUT6/fNlx6NpDttfs8z+0Rua5mYKfEHmPBu2d5In3A/FlKm7pHZBkLOn15GPuxzFQBb8CVOFcaiWLWt2Dt5yB4TrBkUP+TOWdCZ;
 4:a+1PRkvd3bMnO15gG28JzgY3XRFJopeH0Xy/04RnAERVrKmp9mSdkxutPEc9rIADRBESKy1LSv9yT1VuKbHSYZS/f1pI/cFYoawoEX7V8JtbiiaHXDeEtwkjKR7W+Yx05g+7PE5al/cOUboLLTtYg65HbCKaQEvJq6+eh0eFhI9wpw39KjCDxk/lmwZuFt8W/buZtNLC2iYwRJJwr7+SVPVmcYtqSYM89ZsMSk4Fdi5qn58MZTtDh276FXbJthgur66B1JWeHhUC9FsS0sPogCbMwM3LpYopEpaQKan0wyqKtwGCCMzA5jnbxwOWRMeNEJg5jLekrGtsPyXGkVnWAfQfFzcSjFcW1zKNcBfKTaApELH4fjBRN9tdmNLHhGOR
X-Microsoft-Antispam-PRVS: <AM5PR0402MB2692347D20565854E356299994AB0@AM5PR0402MB2692.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(227817650892897)(275809806118684); 
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501310)(52105095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);
 SRVR:AM5PR0402MB2692; BCL:0; PCL:0; RULEID:; SRVR:AM5PR0402MB2692;
X-Forefront-PRVS: 061725F016
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(396003)(366004)(376002)(39380400002)(39860400002)(346002)(189003)(199004)(25786009)(97736004)(2361001)(2351001)(478600001)(106356001)(6666003)(59450400001)(105586002)(51416003)(6916009)(4326008)(52116002)(2906002)(5660300001)(305945005)(7736002)(3846002)(6116002)(1076002)(50226002)(50466002)(48376002)(6486002)(16586007)(316002)(66066001)(47776003)(8676002)(8936002)(81166006)(68736007)(81156014)(6512007)(53936002)(386003)(6506007)(36756003)(186003)(26005)(16526019)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM5PR0402MB2692; H:rhuath.am.freescale.net;
 FPR:; SPF:None; PTR:InfoNoRecords; MX:1; A:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM5PR0402MB2692;
 23:5ike2yx4fC9uBYhVTPRPQezo+ixUCL1FbM/GWFt?=
 =?us-ascii?Q?tQZdcbMEKdnvNLs/j0mb1AnYbVd08Iu/3Qigo8QjlEke8sYUgaqodYh3Q1vM?=
 =?us-ascii?Q?B7qA/xxy7fpOjpSY+aaW4Ur2Gt88Pf+ugJ5K4cwalpdAAXdKbsqYs8XldGM8?=
 =?us-ascii?Q?iSdqwwsQuuyZAt0ULA/cs/nKhj5aeoKHr00zlmkapjaSGl3gf16M0XohgCk7?=
 =?us-ascii?Q?YnmSWFqiQAC5hx/tUAPHa2apjXnUuCESX/xF4TlTIi8mKlRgo0pl/j8+WC4D?=
 =?us-ascii?Q?9VV4HJbwedphmSMQfUM6Oi+r6aPjpBgX+ToWXhM8QdWcHkPLhprvw+WpkOL+?=
 =?us-ascii?Q?+//Cak183CPcEojx7jHEj8+D5x0k/fAyItDRmNy1qmswxxPgxLKeJN3d01tp?=
 =?us-ascii?Q?huf2hcJwNCYDUTPO0Hx096O1bmBt1fx4RnnW7DK1gdwbNix/Wy8P/EhTHiud?=
 =?us-ascii?Q?r8xt1/x8CfF5XL7e2ZNTdJLja22SYVHDvlKVEASd4hhXFO2tTWySZwFkTfsT?=
 =?us-ascii?Q?D5awqjeO2wRHogWw2HiOriciGSMtGohTXmntN8J4lAbqFg8DjzKg4mzCIb+7?=
 =?us-ascii?Q?A5iR2uRrrtP0HwJgCc7Ip5NG6nrID0JloAIaoFDeWR6JNxdrlnMMrEaLeLe1?=
 =?us-ascii?Q?xS9OvhPd3/ACKzW6c2BhKh7PArYxK+jhE+A32JPze9lWlfYKFTJcGzj+kG75?=
 =?us-ascii?Q?e/dktSRSAfj65cszYNK640bndy1FoNYzCVMa8UU2xZmx6l5QiM8oWfJiTkTl?=
 =?us-ascii?Q?0EF6R/URHKPbBk8yhvsJfacjAY/PaORzQStj1q3Hp96G2NaWOPp6ELp+6Ewv?=
 =?us-ascii?Q?c0slOucqlSHuXO71Jl2wGB6ryi1NihkdsGFXw2PGCMgzysQIUAUUwDZeTizN?=
 =?us-ascii?Q?IK2e58N8KyWV8wmnM7++u5JK8D6I8svn+fvLtKXsZKD+7zz9TpjSU7w2FS2E?=
 =?us-ascii?Q?BRsMDMbew4xBW/Py3tNGQ9abYnyCWZrs6TbtjU68OP80zdo1CrrwBtDwfTh9?=
 =?us-ascii?Q?JyqDA0tS3r+1M7LBexoK5/fkuBOWXstkEXnbp1SZG/oiQJ86llogDHk3/xLA?=
 =?us-ascii?Q?uLfZ4lLThTjlrzhD2hd5dTL6Z+FPmgKTYUfVzqJ5XLKqYdm8cLAi6yRnwgWs?=
 =?us-ascii?Q?RHi+szf2VExqOduxjEkAd76BYfY4gp8qi?=
X-Microsoft-Antispam-Message-Info: 3AagUVpPTiKZQ1OrMtOSEvnlQ45MJPCrRoEaAUtiFICA4f2BGz9iQ1BPK31Yv2l/GGjEL2fNyp0A/btdyjpfKllkYgC0W19qoOJR1N1u7ykNE4cUAIKw2TthxD5MTlt4RxLJUWL1qRAIVyd2owP3ujEce59Dc9dH32owgY5RHR/oMF/dTm3IUiXu3++M/kMm
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2692;
 6:23qP/cZlBHIJgZeA8lMor81E+zrs3rNWLYd71mF4VWS5xcu3mYJxTKokgPryc3C/u+yin7H33Q90NfpXpitVJK0VAGeq1VF6MthYiPcA4hkOcy8d+lrcsy8GgJottsdJ+4yYUDl7eHdoWD2moKcxHMF2QZPopQF06ZnzmxWdPkkfRUdD6uPo+avVK7sd9ND5QEI5RRVhphgAexFzDevG1qgrTtnoxhTh4UraNkdcUVQC4hHRlK0O1cUYV3tiicFtvT0jpNm7ATvibe5acFNOrJu1PE9psGXrYWr1FfZ1xGZvsRU4jLFpf4mdWxN6VSxDmxhKKYjrn81FWOcvN/NtmJvVQJZwF7l/TPjMmmnkmzI=;
 5:L43ERUHfxIwk460V/Gr97iasgfg4irr1zmyXADn4agSm+xavJzJo84evtLSJxzcObcOEFhJWsI1g+/iDcfRDjA2HQKkPWoDeavNvNbL8hvEw3KtKracukbTBPetN3L6np2aI0p8pZwQv9NvVzfBsPeiwW9WzIWfdwMiMbc2EW+o=;
 24:bKHmXx7h5Lr6jwaCHBncvX25oYdFRhiiMxLx3qoY2ButF8dw5r6608RzDx7JYBcQ1xMd5F3Au3Y/TFm2fwKYeeIvAoc/jybr5T7FOdh7koM=;
 7:JlfR/r92jnxLIaRR8wtfFgMFNrU53y17zgGAZUY+9TDiQ6d787Wf4Y3zevx/3WTXT77w7IRbchx4VjlY3If1+71oBQZfMi/6/pZKn5lXVRFaEil8YMKA84xy3md4ZP/8uo7LiqdDENovz9ye9iLdxQOlGX7DFwOFyat0uRjV7jVTm7igUikFcZjYYBb5FCrG/AAj5kukSwWgbVFbkjXkxS7VaGlefrBAms2TLg7DUqsKHsPynaqjBwueWRcVFY/X
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2018 12:05:01.1816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf28b1e2-d18d-4d43-fd3b-08d58e5acf9e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2692
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 nipun.gupta@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

MC portals may not be available at the initial probing attempt
due to dependencies on other modules.

Check the return value of the MC portal allocation function and
defer probing in case it's not available yet. For all other error
cases the behaviour stays the same.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
Suggested-by: Nipun Gupta <nipun.gupta@nxp.com>
---
v2: rebase on latest driver code

 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index f013af6..ac1a750 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -2441,7 +2441,10 @@ static int dpaa2_eth_probe(struct fsl_mc_device *dpni_dev)
 	err = fsl_mc_portal_allocate(dpni_dev, FSL_MC_IO_ATOMIC_CONTEXT_PORTAL,
 				     &priv->mc_io);
 	if (err) {
-		dev_err(dev, "MC portal allocation failed\n");
+		if (err == -ENXIO)
+			err = -EPROBE_DEFER;
+		else
+			dev_err(dev, "MC portal allocation failed\n");
 		goto err_portal_alloc;
 	}
 
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
