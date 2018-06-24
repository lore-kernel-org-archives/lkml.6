Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DATE_IN_FUTURE_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B5CC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 07:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2448224E09
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 07:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ctnp0Pzq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2448224E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751759AbeFXHXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 03:23:55 -0400
Received: from mail-eopbgr50087.outbound.protection.outlook.com ([40.107.5.87]:28288
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751083AbeFXHXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 03:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaFfWCldCn3NbKlfEsjxnMX6YiMiKczJUlR5IFcNfGM=;
 b=Ctnp0PzqqMv2e9LbUNaAbhikzhfF2SmJ9A9TO2yHCzTlV0RWoKQYB56D+ozPn+VCF+gbprytyAYGpB1bBFgVqvfyNXbtUdqb1kdi9lBHw3x/wKQZiMqRk0oQUcqrJKvzUXVW/vjzHHXslOXk1dl0Lzy+iPyjM6Q5JQnhFssR5xo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vakul.garg@nxp.com; 
Received: from lti.ap.freescale.net (14.142.187.166) by
 AM6PR04MB4246.eurprd04.prod.outlook.com (2603:10a6:209:4f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.20; Sun, 24 Jun 2018 07:23:48 +0000
From:   Vakul Garg <vakul.garg@nxp.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, corbet@lwn.net,
        Vakul Garg <vakul.garg@nxp.com>
Subject: [PATCH net] strparser: Corrected typo in documentation.
Date:   Sun, 24 Jun 2018 18:14:01 +0530
Message-Id: <20180624124401.24584-1-vakul.garg@nxp.com>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR0101CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::20) To AM6PR04MB4246.eurprd04.prod.outlook.com
 (2603:10a6:209:4f::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff7859ce-d085-40d9-cddc-08d5d9a36e0b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4246;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4246;3:A6NKpBNlyxbXFF75xz07XXaNvxnult4shHr02I7AcXvpRr0qB1Ppq71+ZRZZS2qKMrEEogxvSVTSKEocuSg787rwy7mD8br2aPKqQAfFdPRfoLuSd1UEViZmPesNK7xnMweMj0yz3b3PezTI1Yzp2vBGexULcskFWFrrnHmNUFL7Qjz84/BkB2hoxfYJZKMQ1zh9Mar+4D5lbRMpZ1hsEDIcmeQRmxUYMMQYfvwcAxC/NEdCAgZxYxwKhtuMMqlp;25:WJSbFKRVKZgJW5yI5x+vJQF4WfZkauPFmLTuFMPybrovcGUFlLx21wAq34TIV5KnuX7XKddUk7RsNZcLXSEsCzmUyoroPu4K4JgjqyuA9Z148jrtAv6QfqpWSSN7vph/t6FNBpm/6LHkxG/I6guCgEVDaP2a00Zm/0Lt1bsHKd0cm4uDfqr4xHsueWsQAjCrWOf+NExjLu0cbN7RuoWgedSs7ytBGUgRVGHIOGy3vtm0Eqb1meiwtHGqP54H7KoBt6DHUk0ZCr//wTPM0/LImc9A9yATkI5jeT93ti9uZrBTskJxvwfYlT1qyRxfusP8RAP3Llu9G2p+CEEaQe9Fpw==;31:qzoV8LIKjrYZOhN7anIj69tNJ4R0XgEw3bpvehvWHAYEhB3xCWSOzLt4QB77WogQ02hA9Lh9S/swNh1uV1UFGczEF7ejqZJTEXgwWhjiikGYPshPKSlNoMxuj659q0kv1THMiGUHI/t2WFjyMciKth7QV4TBRBGcrCWbJ58FaOQs3jpzD90TF1eUxx/9zwkxJSW77QQsEU0EtdQbVRDEqUJjkEvsbfvCXBHJUFT/Xms=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4246:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4246;20:2DYemgE3U75hCLIfCoR0DD19N931g4v6/y+rU+I0WGekU+iXrsbVxvvMyL6bnUoPl4vQISXY1N+jJqwV1ndnjUFB+uMiR99y0fk4cGgzSt6xk33KgFNzcGidqscJSLDgAvROQHwt9T5nylTpdzfCPPrYvOpq1KJZRVPu1Bq4mf/LJOCHXUiHdPHAQfdy7Ts742JRdtv908rIGvPYFBeUnyLAWqRFhNBx2B8rcyFj42lDg1rk30AKORBlNGY99kRmmgUF2iCX6tvhieZ3UadYCPgVHsKEtoCosba/c+h7X11196sBxclX4Lacu4fPlp510sPHUrpN7ZNi5/uQrinJ0zcPZk3Scsb2bMbcNBpY+pGVowOybHxkehitWud1a7x6fM9dTkQBx8VMRJ+vl0EEPLEYtP/4vUMdX4UK+VhFzz1kun2u+paIHT3oEBSCBFTWeJsHgki9ww0qrQ+bTZWyVLMB9kA8anPMFLifBh6KX2Ig2GPHPRNgjHyifasD8n4O;4:g/pO/yz37gjFfBxVD/4TjPDe2PNSx02Zb9bEiabt3e8gpQrxh0tRQH4yniIbhR8SvJG8uLzIZcpc8ZLh+s//eb5Y4fFk3i8iXJRiuaeBvgDJ+X5qmTavD8eglzBFflPTKbmZ6OxeID/1SsXXRQsRx1ukvdgLb6+hUUx+LXTeoN+JTcr2B0fOhmoERUnItgmXAoaBhlSrjhrjtiE2xmNGIHHWzhF/phvBiEtqyAHdRnm0vCer9S+Uzwx7bX/jMHjUg1wYDd4qbk9QYWB5dB+kkxMTPwuxuLn01ZFx/AlWCC3qjRDR/zHmp96oDDC4Ddwv
X-Microsoft-Antispam-PRVS: <AM6PR04MB42467021118F628E5D26EBE78B4B0@AM6PR04MB4246.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM6PR04MB4246;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4246;
X-Forefront-PRVS: 0713BC207F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(376002)(39860400002)(396003)(39380400002)(366004)(346002)(189003)(199004)(478600001)(2906002)(386003)(6506007)(59450400001)(51416003)(44832011)(52116002)(2616005)(476003)(956004)(6486002)(86362001)(486006)(4326008)(26005)(47776003)(53936002)(2351001)(316002)(16586007)(2361001)(25786009)(6666003)(97736004)(186003)(105586002)(66066001)(50466002)(50226002)(48376002)(106356001)(6916009)(16526019)(305945005)(5660300001)(7736002)(6512007)(55236004)(68736007)(81156014)(36756003)(8676002)(81166006)(3846002)(6116002)(1076002)(5009440100003)(8936002)(110426005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4246;H:lti.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR04MB4246;23:Ql4JyFyboowVqWeFZDozQAXITwNF/5fD7F++xStDu?=
 =?us-ascii?Q?/YonNcjEBJEVSHhkJ7AWmJ0y4yVctfrxtQLMEnwkwPiBEiC4PgNKT2Kk1i8w?=
 =?us-ascii?Q?kT86ZU2C13pI0tg0BI18VmbySYMNA8QQWljsBmWOfPK8qWXUbxLQBB8LkbPm?=
 =?us-ascii?Q?foMt3lm2kD+qpt6ct1jaTgpeB3MNXbEeXyUakFIdcTH/69dSvrknZZTiJFP8?=
 =?us-ascii?Q?VAPIKQgkpBYayY/xdUquOESWvMvViz/+CiD/L4f+1LfcI7GSrVe5kmas4Cvh?=
 =?us-ascii?Q?vMQO9tITWJ+UQrwdHIpoG8jx3A4St/f9FF1D5iB6m5jyktKxXMbO3bCi/Ajr?=
 =?us-ascii?Q?riDCD73l0mEvKi/gLBizqNs81QS1m9RPz+2pSKsPIOpWkVaLFdU3DS/Fd55w?=
 =?us-ascii?Q?a30mROLa1wkzpJNZOo/a5lfBksSpL+2aZht/xwiRkJy5jk8UlkTfDxZdTrnC?=
 =?us-ascii?Q?hDGfdIEoZRs4xns0yp2cQx1ZkVUzImvliANHm+cBUlAXRa66/NXBK+BMexb9?=
 =?us-ascii?Q?RCslxZHRjZVPcBUmICbmukvH0/WmGcltrB/kItAljQkFuUWoWjoMuyY5x90T?=
 =?us-ascii?Q?8OrnNacz9tf5otG/2N5+eQ1HbIEMgiS49UbEtayGI4iMkIDCFAHzJWts92t8?=
 =?us-ascii?Q?i6QIxIsxRD/JTod6ctLVuhCe7olcMAzB1LLeYRksGYSRgInqWQLKi8+O3b/Q?=
 =?us-ascii?Q?03jcEd0BrhOj4ldKEb89VVhMaZmvUW/LgoI9dU67+iW+MpZbe7ARbZnZ3Bwy?=
 =?us-ascii?Q?rxsNxB5Y6e5FrtpkwpcXr/jcqivvzr/XU6wE2ew/UXWXMjndtbTNMc34+Rab?=
 =?us-ascii?Q?dxE/4iXgjsFFPA6gfpQq3VE+YByazHg0v060XBiRhIh9C1aW7DXtv4FiX1Mk?=
 =?us-ascii?Q?YpCVSgZ3DkjLrtBYQgUHb2kVKxCac57Y2fP0xdQDQLhEdSJe0Z67sPCIy7Zf?=
 =?us-ascii?Q?fO+6P8y1m6J1wE1uQzieCSJnwe/t2U+c7gTQy9JJk/KFsvmQTKadqIVgCwgd?=
 =?us-ascii?Q?KTV+CNoZWFCpm5EPlNGaIx+ZDgPeJL/AJ5cBxjzapuK5ZXrZP3oK/aGHEhT4?=
 =?us-ascii?Q?um2FAY+zK/g0oAqjinmHxrjYRPhnfFpGI7bLAaFhJfXew7tzylgvqUkaO8yn?=
 =?us-ascii?Q?BBD9+2tsm2s2AjVt0Ps1/GsFGLGN0Erh916NEd28nyCNJ2Mpsv8TtlAF0rpv?=
 =?us-ascii?Q?galDGbu3ljBFXTvlqZVUhSwagmmHd+luRIZPzP23Gdfvn1wrld6DRvs+gsk8?=
 =?us-ascii?Q?ZRQK41IhTleTEvpDT7pnvjCj/CiBPnAjQNeQRQ9278lM0FyCA91c56RSqDLp?=
 =?us-ascii?Q?xcqPnhU9dRrP1ep7shn83Srt7LtIIouZeoOoJkgzUX9LEtUGA6J5rnEW9VBV?=
 =?us-ascii?Q?DpmcTTDAcSBs0KpeFXKkOK2+YWRfs4r1x+u4Sh1OvSyWI7v?=
X-Microsoft-Antispam-Message-Info: 5kRBSr9p6rMYgI1sG/yMbJq1OAPqjZJRc3+idJt2tjY72D+FnIziIx30VLLXW9u6zeUy/DQBM5GZw4VJhL8rKZZBDELIWjV2eI+OmbGoqVpyFeXTqeXHRL+nSkyAYX3mYZdgfE8Movr3qAfgUe+S45JmTn77Mwd0BS/fd7BtqMVc/Y5u6lelCFA0r/x9+rLz1OZMr3QBPx6vScioJFu3SZoT4+PQ0koTnXZ+L7rflQTAQsFDauqSjJE56UuKfzV8UGqT+son4JmtfORZGvuHgopwZ9tdYyXJ6rcgqZRt7b/VsSTC1wgvIfFOlpi00idIKp7yIE1JgHcWf+X5Lw4VpnrLSc/n3NpyXNXK6WIEdds=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4246;6:uvWEvKTbcmf9feeI9mLOgrpkpRckG4K9NroHnsyyJJUoyoOPTMEe+vGZhD1oLSL6UgWGFip9aGs2QnQ5D5SqO/BTI5QlB4sejGExK0oMje+o6/gIE1UQ0PEfomwILjX57l2GWxsI8RU16Wz4nvHaZYWwQ0az4rcG9csGC0hnDzQnZHUkT0K8YpyewTzU4LOwiblI2wnuH8uXiqVCsLUR0dgV303nxdWsM0iug09XynZ959UdpDLE3w9FxyPNXVX6Do9/X9PhkNRuk7XILMJaRrohriDf0RR6zfzMQfLyvbDSTXospMpzDzis08W4mqpT8vCtIwEFJFUtVYWo97MCTuHc96Satw4wARh8Y+RFlQVNozdzd3h8Hrfwk/BuBnKHXG2X0FafTr14LRmjUn08fuHlb6U5+JOorxkLMNcgoM9cvxft0zcFo3z8JkegWrWC5Mb9VZ9xBALZsOCjWzW2HA==;5:V2RSUzddxFqSlPNsQ1f9naS/wt+HEp6rfAbQ9Sqvvp5w5QoL3+i4AtayIYgG+YaQdUIinoO75F7nalh4VCgN2/lWuK90hocZcG/HoK36zfakkVvhKnOZjzV0Tb8C83qcvqmDIq6Ye1Nm5wRlXvzAj+wB/Hna8B8oaub1x3QQxko=;24:KNZeC1gzqSu2QRcK7ZAYQJjnNxO+EvawWlaTYHC2/M7w5gU3vQCJt+b2AAFivtWBBoVgj/mjx8rSYeB/kii+GO70cu1+dHt8HT2DFbwxXxs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4246;7:8tAT1PP8psLUKKsSddzXJA2Jirh5FqswXoPBBZ2sE0BxjB6898wVzeJa+U9dbmZXZ3qNx/DCzQW3Q8SETEQn/pzUVANRykIUDSSrx+Gzdfx8xBv0b94uwbqiXQ7DdThKuP6L1oiJPtHABuHLUvaDNB7imXm/ANi1KbBAEbxCdeHjNOgJiHFz+65+wxwX5RZxVSr2WlyW/O4Lu3LSspAAMwval279XwMOehyaF+uXh6epQZ7YmUfLLiwkhSorhKsH
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2018 07:23:48.0539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7859ce-d085-40d9-cddc-08d5d9a36e0b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4246
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced strp_pause() with strp_unpause() to correct a seemingly copy
paste documentation mistake.

Signed-off-by: Vakul Garg <vakul.garg@nxp.com>
---
Resending for 'net' as advised.

 Documentation/networking/strparser.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/strparser.txt b/Documentation/networking/strparser.txt
index 13081b3decef..a7d354ddda7b 100644
--- a/Documentation/networking/strparser.txt
+++ b/Documentation/networking/strparser.txt
@@ -48,7 +48,7 @@ void strp_pause(struct strparser *strp)
      Temporarily pause a stream parser. Message parsing is suspended
      and no new messages are delivered to the upper layer.
 
-void strp_pause(struct strparser *strp)
+void strp_unpause(struct strparser *strp)
 
      Unpause a paused stream parser.
 
-- 
2.13.6

