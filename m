Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4BBC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E867B218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tUp506XM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbfAXLHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 06:07:14 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34894 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfAXLHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 06:07:13 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so2734731plo.2;
        Thu, 24 Jan 2019 03:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NGpXACB+TvxMIVTHy5sF2awWmQdG9HVXfrNZhc7o6B8=;
        b=tUp506XM/B5lkFOdzRb39EBqK2P0O+cM44mDdLOr5ivAO03fM83dypa5C++WHK8HzR
         XduM8PASXIzFwKdaJTvzicU8ZCgx1KJ71YzuB2GZ/BGmLsl9xdoSUQGQMk0ymtBACM1l
         DLpvXGJX8hWrrAgs0HdEdaC6F9wFgf/40p/zixC6k8v/zLWjbJyBxg2FtPqEC3QzNur7
         LA2d6O4lTsavlEkbXkp3IHd/kpRw/6s3r+Y2JhEhaLKJXeAhzyD6nM6+jQWuxgh3HXz+
         yfjm2cBpAX6LeUW5S1r0IU2pDeLrDbOQGQnnhVktEpsX6egKOH2+k8HKSpqbGalMkidr
         F9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NGpXACB+TvxMIVTHy5sF2awWmQdG9HVXfrNZhc7o6B8=;
        b=NiOArE8pLAhpq/O51TEQBnBK8H+yUl0ONBLQ0dsfhMrAo8+ayEnXyR2jbb4OMBn5xK
         nTkgL759nWZaabDza5Qt7SYina4dqcWb7s3IgQbqn5dviVR8kGPTueyamf2XXNio+iY9
         PXLfC0nye6CJL+U2cdfgHO+SwwSZrnqEbCxI3F5H0BlpZvhTO2ElS1qUn9wS6ps3EGhN
         s8oSaKlXiKsAd63DmvuCNRdr2tCU+UOuRC3qEHNH9wjnp/W/u3+i0BLJBPG65Sr3yIAF
         eKx/6sJjwe6s8jXXP0f7vRhmhfEXzRPn52h2FDS/pKAUATc2BUIEOI37jcfXVm3KxMSw
         n4yQ==
X-Gm-Message-State: AJcUukdndC24BadTXRmRySqODecpM+rm+g6CJCXFNJ/i0iSplNRJA5ja
        RXvyRt0J3aXOBiBKdx0r1o8=
X-Google-Smtp-Source: ALg8bN7H/eWCtmiBgtmEzx/OO3DqbAW9lWzfuwsCerrGBYC9beKVMpwdtF6xVLxTxgQCLysfLWC7cg==
X-Received: by 2002:a17:902:934a:: with SMTP id g10mr5843027plp.172.1548328032984;
        Thu, 24 Jan 2019 03:07:12 -0800 (PST)
Received: from athina.mtv.corp.google.com ([2620:0:1000:1601:d7a4:903f:6d6b:ec10])
        by smtp.gmail.com with ESMTPSA id j197sm28294512pgc.76.2019.01.24.03.07.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 03:07:11 -0800 (PST)
From:   =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <zenczykowski@gmail.com>
To:     =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] net: dev_is_mac_header_xmit() true for ARPHRD_RAWIP
Date:   Thu, 24 Jan 2019 03:07:02 -0800
Message-Id: <20190124110702.140834-1-zenczykowski@gmail.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej Żenczykowski <maze@google.com>

__bpf_redirect() and act_mirred checks this boolean
to determine whether to prefix an ethernet header.

Signed-off-by: Maciej Żenczykowski <maze@google.com>
---
 include/linux/if_arp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/if_arp.h b/include/linux/if_arp.h
index 6756fea18b69..e44746de95cd 100644
--- a/include/linux/if_arp.h
+++ b/include/linux/if_arp.h
@@ -54,6 +54,7 @@ static inline bool dev_is_mac_header_xmit(const struct net_device *dev)
 	case ARPHRD_IPGRE:
 	case ARPHRD_VOID:
 	case ARPHRD_NONE:
+	case ARPHRD_RAWIP:
 		return false;
 	default:
 		return true;
-- 
2.20.1.321.g9e740568ce-goog

