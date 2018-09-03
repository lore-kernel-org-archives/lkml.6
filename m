Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD6FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51B420862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E51B420862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbeICVZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:25:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39360 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbeICVZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:25:44 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0B961D00;
        Mon,  3 Sep 2018 17:04:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 005/107] nl80211: Add a missing break in parse_station_flags
Date:   Mon,  3 Sep 2018 18:55:29 +0200
Message-Id: <20180903165637.564673966@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165637.293735109@linuxfoundation.org>
References: <20180903165637.293735109@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bernd Edlinger <bernd.edlinger@hotmail.de>

[ Upstream commit 5cf3006cc81d9aa09a10aa781fc065546b12919d ]

I was looking at usually suppressed gcc warnings,
[-Wimplicit-fallthrough=] in this case:

The code definitely looks like a break is missing here.
However I am not able to test the NL80211_IFTYPE_MESH_POINT,
nor do I actually know what might be :)
So please use this patch with caution and only if you are
able to do some testing.

Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
[johannes: looks obvious enough to apply as is, interesting
 though that it never seems to have been a problem]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/wireless/nl80211.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4058,6 +4058,7 @@ static int parse_station_flags(struct ge
 		params->sta_flags_mask = BIT(NL80211_STA_FLAG_AUTHENTICATED) |
 					 BIT(NL80211_STA_FLAG_MFP) |
 					 BIT(NL80211_STA_FLAG_AUTHORIZED);
+		break;
 	default:
 		return -EINVAL;
 	}


