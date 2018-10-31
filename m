Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD58ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BF82080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3BF82080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbeKAHKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 03:10:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49357 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725755AbeKAHKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 03:10:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9VMAVx22561403
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 31 Oct 2018 15:10:31 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9VMAVlB2561400;
        Wed, 31 Oct 2018 15:10:31 -0700
Date:   Wed, 31 Oct 2018 15:10:31 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-1xymkfjpmhxfzrs46t8z8mjw@git.kernel.org>
Cc:     dsahern@gmail.com, ast@kernel.org, tglx@linutronix.de,
        eric@regit.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, davem@davemloft.net, acme@redhat.com
Reply-To: ast@kernel.org, dsahern@gmail.com, acme@redhat.com,
          davem@davemloft.net, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, eric@regit.org,
          tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers uapi: Update linux/netlink.h header
 copy
Git-Commit-ID: d45a57fff0a657045a77b395ae713ffae0cb4e46
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d45a57fff0a657045a77b395ae713ffae0cb4e46
Gitweb:     https://git.kernel.org/tip/d45a57fff0a657045a77b395ae713ffae0cb4e46
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 30 Oct 2018 17:04:47 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 31 Oct 2018 09:57:54 -0300

tools headers uapi: Update linux/netlink.h header copy

Picking the changes from:

  89d35528d17d ("netlink: Add new socket option to enable strict checking on dumps")

To silence this build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/netlink.h' differs from latest version at 'include/uapi/linux/netlink.h'

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Leblond <eric@regit.org>
Link: https://lkml.kernel.org/n/tip-1xymkfjpmhxfzrs46t8z8mjw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/netlink.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/linux/netlink.h b/tools/include/uapi/linux/netlink.h
index 776bc92e9118..486ed1f0c0bc 100644
--- a/tools/include/uapi/linux/netlink.h
+++ b/tools/include/uapi/linux/netlink.h
@@ -155,6 +155,7 @@ enum nlmsgerr_attrs {
 #define NETLINK_LIST_MEMBERSHIPS	9
 #define NETLINK_CAP_ACK			10
 #define NETLINK_EXT_ACK			11
+#define NETLINK_DUMP_STRICT_CHK		12
 
 struct nl_pktinfo {
 	__u32	group;
