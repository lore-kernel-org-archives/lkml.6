Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E46C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96EB92168B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="CyEIEhW3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96EB92168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbeI1ATI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:19:08 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45349 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728623AbeI1ATG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:19:06 -0400
Received: by mail-ed1-f65.google.com with SMTP id h6-v6so4378275eds.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 10:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YmXqigRf7MfAJWZebhXsQvKzthN4owk6/gKa5Zoooq0=;
        b=CyEIEhW3dT+9ySGJeYFgzZtQ5alkC47y8dUzfcXK8YkWal3m10U3JQVmSMzVNBmg+A
         zFiOhPRUkQZWc+PZcc2gWJm1f9Jh8Npa5ffqtt5SVrhcy65GXEaFZyq2dKYcoa51HXLu
         uAyPyIWrSUamLgSolJtHjrKWHTFXhALFCLfuB8cpjYpMKDEohBTY7xVpiinWib9z+3GC
         4+S53gXtw3pepZEn3Zkr9OPczKxtUwH3XfuIHRnAV53sT/BnkcZ8YqGWFdYWswsOTOaI
         WRh4UFM6GkRbJlcg423TaNnHaHE4rqcsbGviczbWFKe9X/IwN6Xy4LJ+tLgL0QNCcEdb
         d9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YmXqigRf7MfAJWZebhXsQvKzthN4owk6/gKa5Zoooq0=;
        b=g0ZdXosYoHIrAMohhpqrBhbtIH6Je+9w1NJ5U2wbVSm1H2ta06zkAthvbz7ZnPVWrT
         0Q9XVH7+LTqqrxrE6cDnmbx5IyuVGQAre3LYTBsVCklhoYBXSWEVoCGF8fBD7/40MRXI
         7dHpOpjVh3iiCx14tnx5wxqoh4LsogzJE17L6RmX23dqrGZsx6TNYnqPaVRnJ4d+7Xl0
         ulTgWXWeLBDqB9AN9nD2rMpbg/wsRUx80lhmhh8Ye3H2wDhQ3iZE/hRBxXPxQ1qPDPlc
         5alzWBmYfmolDhGrNn+7Ht+Rs8i31Fk4/4tn2c6SB3Hl+ybDJvo4S9anAQATTtpk9e6L
         hNlg==
X-Gm-Message-State: ABuFfogJ+hfPXVWCHSMt1KpWVpHW7RE5nHCoLWLzqxfkOupiA+pZtc/G
        pLzplVqMuKukY4JaNnd45bWk3A==
X-Google-Smtp-Source: ACcGV62gr2+Olm8NzrDZqC07NtlAPorXCWBmiGr/u3JnM1ybFnPfARmz+f2bSG/dGYVP7f7fI2CrsA==
X-Received: by 2002:a17:906:619a:: with SMTP id q26-v6mr2888167ejk.127.1538071178879;
        Thu, 27 Sep 2018 10:59:38 -0700 (PDT)
Received: from localhost.localdomain (fa-padur-binz.ediscom.de. [212.204.40.18])
        by smtp.gmail.com with ESMTPSA id a9-v6sm1532606edi.26.2018.09.27.10.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 10:59:37 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     jbenc@redhat.com, davem@davemloft.net, dsahern@gmail.com,
        stephen@networkplumber.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Brauner <christian@brauner.io>
Subject: [PATCH net-next 5/7] phonet: add RTM_GETADDR2
Date:   Thu, 27 Sep 2018 19:58:55 +0200
Message-Id: <20180927175857.3511-6-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180927175857.3511-1-christian@brauner.io>
References: <20180927175857.3511-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various userspace programs (e.g. iproute2) have sent RTM_GETADDR
requests with struct ifinfomsg. This is wrong and should have been
struct ifaddrmsg all along as mandated by the manpages. However, dump
requests so far didn't parse the netlink message that was sent and
succeeded even when a wrong struct was passed along.

Currently, the message is parsed under the assumption that the correct
struct ifaddrmsg is sent down. If the parsing fails the kernel will
still fulfill the request to preserve backwards compatability but a
rate-limited message that there were leftover bytes after parsing the
message is recorded in dmesg. It has been argued that this is
unacceptable [1].

But various new features that got and will get added to RTM_GETADDR make
it necessary to definitely know what header was passed along.
This is currently not possible without resorting to (likely unreliable)
hacks such as introducing a nested attribute that ensures that
RTM_GETADDR which pass along properties such as IFA_TARGET_NETNSID
always exceed RTM_GETADDR requests that send down the wrong struct
ifinfomsg [2]. Basically, multiple approaches to solve this have been
shut down. Furthermore, the API expressed via RTM_GETADDR is apparently
frozen [3] so the wiggle room at this point seems very much zero.

The correct solution at this point seems to me to introduce a new
RTM_GETADDR2 request. This way we can parse the message and fail hard if
the struct is not struct ifaddrmsg and can safely extend it in the
future. Userspace tools that rely on the buggy RTM_GETADDR API will
still keep working without even having to see any log messages and new
userspace tools that want to make user of new features can make use of
the new RTM_GETADDR2 requests.

[1]: https://lists.openwall.net/netdev/2018/09/25/59
[2]: https://lists.openwall.net/netdev/2018/09/25/75
[3]: https://lists.openwall.net/netdev/2018/09/26/166

Signed-off-by: Christian Brauner <christian@brauner.io>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Benc <jbenc@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>
---
 net/phonet/pn_netlink.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/net/phonet/pn_netlink.c b/net/phonet/pn_netlink.c
index 871eaf2cb85e..acba4fe9a612 100644
--- a/net/phonet/pn_netlink.c
+++ b/net/phonet/pn_netlink.c
@@ -131,13 +131,22 @@ static int fill_addr(struct sk_buff *skb, struct net_device *dev, u8 addr,
 	return -EMSGSIZE;
 }
 
-static int getaddr_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+static int getaddr_dumpit_common(struct sk_buff *skb,
+				 struct netlink_callback *cb, int rtm_type)
 {
 	struct phonet_device_list *pndevs;
+	struct nlattr *tb[IFA_MAX+1];
 	struct phonet_device *pnd;
-	int dev_idx = 0, dev_start_idx = cb->args[0];
+	int err, dev_idx = 0, dev_start_idx = cb->args[0];
 	int addr_idx = 0, addr_start_idx = cb->args[1];
 
+	if (rtm_type == RTM_GETADDR2) {
+		err = nlmsg_parse(cb->nlh, sizeof(struct ifaddrmsg), tb,
+				  IFA_MAX, ifa_phonet_policy, NULL);
+		if (err < 0)
+			return err;
+	}
+
 	pndevs = phonet_device_list(sock_net(skb->sk));
 	rcu_read_lock();
 	list_for_each_entry_rcu(pnd, &pndevs->list, list) {
@@ -168,6 +177,16 @@ static int getaddr_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	return skb->len;
 }
 
+static int getaddr_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	return getaddr_dumpit_common(skb, cb, RTM_GETADDR);
+}
+
+static int getaddr_dumpit2(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	return getaddr_dumpit_common(skb, cb, RTM_GETADDR2);
+}
+
 /* Routes handling */
 
 static int fill_route(struct sk_buff *skb, struct net_device *dev, u8 dst,
@@ -309,6 +328,8 @@ int __init phonet_netlink_register(void)
 			     addr_doit, NULL, 0);
 	rtnl_register_module(THIS_MODULE, PF_PHONET, RTM_GETADDR,
 			     NULL, getaddr_dumpit, 0);
+	rtnl_register_module(THIS_MODULE, PF_PHONET, RTM_GETADDR2,
+			     NULL, getaddr_dumpit2, 0);
 	rtnl_register_module(THIS_MODULE, PF_PHONET, RTM_NEWROUTE,
 			     route_doit, NULL, 0);
 	rtnl_register_module(THIS_MODULE, PF_PHONET, RTM_DELROUTE,
-- 
2.17.1

