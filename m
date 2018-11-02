Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F6CC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F292081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F292081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbeKCAoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:44:11 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:56287 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbeKCAoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:44:11 -0400
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MQvH5-1fwGtZ3Rvr-00O01o; Fri, 02 Nov 2018 16:36:34 +0100
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MQvH5-1fwGtZ3Rvr-00O01o; Fri, 02 Nov 2018 16:36:34 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ariel Elior <Ariel.Elior@cavium.com>, everest-linux-l2@cavium.com,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>,
        Tomer Tayar <Tomer.Tayar@cavium.com>,
        Denis Bolotin <denis.bolotin@cavium.com>,
        Rahul Verma <Rahul.Verma@cavium.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] qed: fix link config error handling
Date:   Fri,  2 Nov 2018 16:36:24 +0100
Message-Id: <20181102153632.1646632-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:4roWWxVSKT7R5vRrB16ZZ5BGYXw06RETKkivZSYmyNZ3O41gCRa
 DilHpHXpWZKtn4aX7TeZC9IkBoMVbbfKl1UgyYVRWdqxah6ndjU9y+oPELwmlkSYJp7SaVd
 sad0CBt/Nm6WNl5qeqzjCTjCWgAi65PJ57ewBc/lvBPucs3oCqEn2PwKGoJQkuJSuu38/vN
 P5lDpUqo1Jjkf9OY4xiWA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:B0iscfhiLFg=:DbhgyaY2sxYLS3O0sVP3k1
 pBtaDP+9KSLlRghNEyL4KaQGiMQfd5mwmPFfAQ51F6J+A9uNYmcj2sQJHRHD5ss6VJIL3bk0v
 s3L/7qS/l9lzX/OeaavF6Uo+SFpHW/Hy+Ot2ggK8Dfxjlbgh9htGde6n2bIXkBo1Ml4yha+Wz
 LJAESo/PQzn+TjyVj4+hgRVi1UuYKfpHimN8UgQskzN9tD1ZipUQDsa/Fj/S4jyF0prG4Tat/
 jIqdh7dovr1fo5ucYymBaLU6JqWqgY8NqbbxLW3fYHJxWdrGvwBseXfEXdLfv+N504Mxz+Moo
 Sit6rLiEGWGBZakZcS5ALU/pseNbBIV5oMtOaxq6WpPFn9ORCFVxJ4dS+yn60WhSYY20lAg5A
 wYjO6+8ka62yH4mN+f/R3lr1aOq2fe90+6s5DINlR5tYB7xz/+Yky33NP3KVhEkg/I1IALVvd
 g2lGkOiUvagGuBTu1K9j7zXmEIz1MIDH+p+tkTwQoBjnPhFCUkrq2WCrkYsiiOpOjQzqAxPHA
 8nBd3Vgvxg/73vgBLf15zsjyic/h8G4pqW0aJrvn7FKOvYflIFYuD00XbUwI0rciCXE7b++X3
 jNJ3zZu1P8GL1jKAqJrfoQGUKNAyiDFvie1fhHNmDezgTsqCXcoTybKFUqPz78mwS4B0ThkF2
 ellJwEGwXvMsfaqyCnzJdBQmQ2quNrRt5tIf6nZlWLiC0LeR1H6lQkMUTezuWtHn252I=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-8 notices that qed_mcp_get_transceiver_data() may fail to
return a result to the caller:

drivers/net/ethernet/qlogic/qed/qed_mcp.c: In function 'qed_mcp_trans_speed_mask':
drivers/net/ethernet/qlogic/qed/qed_mcp.c:1955:2: error: 'transceiver_type' may be used uninitialized in this function [-Werror=maybe-uninitialized]

When an error is returned by qed_mcp_get_transceiver_data(), we
should propagate that to the caller of qed_mcp_trans_speed_mask()
rather than continuing with uninitialized data.

Fixes: c56a8be7e7aa ("qed: Add supported link and advertise link to display in ethtool.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/qlogic/qed/qed_mcp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.c b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
index f40f654398a0..a96364df4320 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
@@ -1944,9 +1944,12 @@ int qed_mcp_trans_speed_mask(struct qed_hwfn *p_hwfn,
 			     struct qed_ptt *p_ptt, u32 *p_speed_mask)
 {
 	u32 transceiver_type, transceiver_state;
+	int ret;
 
-	qed_mcp_get_transceiver_data(p_hwfn, p_ptt, &transceiver_state,
-				     &transceiver_type);
+	ret = qed_mcp_get_transceiver_data(p_hwfn, p_ptt, &transceiver_state,
+					   &transceiver_type);
+	if (ret)
+		return ret;
 
 	if (qed_is_transceiver_ready(transceiver_state, transceiver_type) ==
 				     false)
-- 
2.18.0

