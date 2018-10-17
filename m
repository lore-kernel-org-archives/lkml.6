Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA2DC5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18AB9214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18AB9214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeJQLIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 07:08:42 -0400
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:49118
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727460AbeJQLIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 07:08:41 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id CcHhgcOAEwkZtCcHhgMqg3; Tue, 16 Oct 2018 20:14:09 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1gCcHg-0000DW-Rb; Tue, 16 Oct 2018 20:14:08 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     Dexuan Cui <decui@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Stable@vger.kernel.org
Subject: [PATCH 4/5] Drivers: hv: kvp: Use %u to print U32
Date:   Wed, 17 Oct 2018 03:14:05 +0000
Message-Id: <20181017031406.773-4-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181017031406.773-1-kys@linuxonhyperv.com>
References: <20181017031241.669-1-kys@linuxonhyperv.com>
 <20181017031406.773-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfO/7iIvFkadVilXYjypum8szLTlTo8ur5i9m/fu2HdjIf4bw/fMGMSzzwIi7hUSKutjYVVa+1BhKWUk0xv7qOTLjEWPln8znLNSmk8BiixXnv9uOSdf4
 jlFCFs7JCZ/iBNEyWkfp/jurp80SxVMMPnp7gPSO5CDCeVjnSnOim/J9VnwIytgQLMB2hj96cDrP+ukIKs+LIpBqQ46cKwlh4+rz5zwIaaIzHLAaF9LlB5Bo
 0MzSMCIo7jNLupJnDfH8BAZQlLEjBOBWe3Bih8+bfnH0TGQW6YZ/ua0q8+aLF8yqMXZ6qCiSq6EbAs5utjzs/r/fAt+ZhaZY4hG4t8LUcuu9d0vKChME9rBE
 LQiHcw7Gc1y7YGhED78xt3QTAWG0NXlVpB3Xn7H5X0dMZjVX5GPRqUYoI5lYu7OnyP3U6KSXyYgNFyfTHL0wqKCNKdFSwtOHe6CAKecks7UGJYG5YCupjXCo
 4X6BUZ/X5vDnVFJlcLOuGQ30z3/mb8IjUGgWvKOydwI0K3gzvAlRqHgzHvr0IsduwF8M2vrohHJYmhkPPrz1mtlOO3RG5aWiwpqKnY05HVKh/XeP3xTJccw0
 L7gvI/ViUcfJ/nrj7iXB8PpL79P0Z9SRIIzP6Y2TrCILwQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>

I didn't find a real issue. Let's just make it consistent with the
next "case REG_U64:" where %llu is used.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/hv_kvp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index 9fbb15c62c6c..3b8590ff94ba 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -437,7 +437,7 @@ kvp_send_key(struct work_struct *dummy)
 			val32 = in_msg->body.kvp_set.data.value_u32;
 			message->body.kvp_set.data.value_size =
 				sprintf(message->body.kvp_set.data.value,
-					"%d", val32) + 1;
+					"%u", val32) + 1;
 			break;
 
 		case REG_U64:
-- 
2.18.0

