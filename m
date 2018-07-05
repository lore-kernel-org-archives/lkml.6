Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846B4C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D36323C23
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D36323C23
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754143AbeGEUmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:42:51 -0400
Received: from gateway34.websitewelcome.com ([192.185.149.101]:39939 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754053AbeGEUmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:42:49 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 1897D88F56E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jul 2018 15:42:49 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id bB55fc1DPbXuJbB5Kfm4yg; Thu, 05 Jul 2018 15:42:48 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=58678 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fbB54-0022SE-FC; Thu, 05 Jul 2018 15:42:22 -0500
Date:   Thu, 5 Jul 2018 15:42:21 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "Lee, Chun-Yi" <jlee@suse.com>, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] platform/x86: acer-wmi: mark expected switch fall-throughs
Message-ID: <20180705204221.GA11336@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1fbB54-0022SE-FC
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:58678
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Warning level 2 was used: -Wimplicit-fallthrough=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/platform/x86/acer-wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 8952173..114b028 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1018,6 +1018,7 @@ static acpi_status WMID_get_u32(u32 *value, u32 cap)
 			*value = tmp & 0x1;
 			return 0;
 		}
+		/* else: fall through */
 	default:
 		return AE_ERROR;
 	}
@@ -1344,6 +1345,7 @@ static acpi_status get_u32(u32 *value, u32 cap)
 			status = AMW0_get_u32(value, cap);
 			break;
 		}
+		/* else: fall through */
 	case ACER_WMID:
 		status = WMID_get_u32(value, cap);
 		break;
@@ -1386,6 +1388,7 @@ static acpi_status set_u32(u32 value, u32 cap)
 
 				return AMW0_set_u32(value, cap);
 			}
+			/* else: fall through */
 		case ACER_WMID:
 			return WMID_set_u32(value, cap);
 		case ACER_WMID_v2:
@@ -1395,6 +1398,7 @@ static acpi_status set_u32(u32 value, u32 cap)
 				return wmid_v2_set_u32(value, cap);
 			else if (wmi_has_guid(WMID_GUID2))
 				return WMID_set_u32(value, cap);
+			/* else: fall through */
 		default:
 			return AE_BAD_PARAMETER;
 		}
-- 
2.7.4

