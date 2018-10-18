Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61323C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327BD208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327BD208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeJRNVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 09:21:02 -0400
Received: from a2nlsmtp01-04.prod.iad2.secureserver.net ([198.71.225.38]:49668
        "EHLO a2nlsmtp01-04.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727328AbeJRNVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 09:21:01 -0400
X-Greylist: delayed 677 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Oct 2018 09:20:04 EDT
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id D0YwgQ5o5CT0vD0Ywg5fab; Wed, 17 Oct 2018 22:09:34 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1gD0Yw-0007HY-8s; Wed, 17 Oct 2018 22:09:34 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     Dexuan Cui <decui@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH V2 4/5] Drivers: hv: kvp: Use %u to print U32
Date:   Thu, 18 Oct 2018 05:09:31 +0000
Message-Id: <20181018050932.27932-4-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181018050932.27932-1-kys@linuxonhyperv.com>
References: <20181018050835.27828-1-kys@linuxonhyperv.com>
 <20181018050932.27932-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfJbTiuNGTPomJQdGJNRkfgKGYubBcOElpjXylFhd08E4jMOor935orxaD194k5mCbvPLVO0o9qasEPtDfqJclSWynci63EgKkNH6rzciS/FN2W7//C89
 CAhl2GaGBzaO7NJ6jsUL9EoRS+qzNC5oqHH/PPPRa9x6hk4Tti2UORgAYtCfrKEgxzSyswi/rbXXJse85KqHejoMfPi3Q/YGH7+bqXGwt2DCshnefTTrvHvB
 9ZbomQGULGRnTeZiJy9eIRWcm3XaX0hLMJDwa2kAdlLGhJXutpsWoATPokDs3HFuPu+YtMCimljl93no6cZRhFyoLR4aHotl/Nt7zHCOZjt4+418zVmoK9Jg
 yIOx1MLcXKfhcJCl+IMz8myc+y53YehEoadwPLUELSUygMHcwjzBm2aE52oPO9Co5MVIxgan9T0djUh2gVMhCKpm+gmgE0Lzxnxp/NFA4SNS90YB22qEm8l1
 gkZ1efQnYj7dUd5As27H/vLqK2cdL7eEBUsL6/rQTrWs8yqZ0IzOqyYD7kgN+iBBDHrgad0JdnvvUrphylqM7X27lk9/hCInAVQqxqY2Z27Br2OhwUAaTnGM
 gBEvOeXiH/gXLbM/CosODl4R
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
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/hv_kvp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index d6106e1a0d4a..5054d1105236 100644
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

