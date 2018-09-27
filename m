Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44991C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30E02168B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="TyGovieV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F30E02168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbeI1ATK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:19:10 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41210 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbeI1ATJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:19:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id f38-v6so5849913edd.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 10:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=arazljuNqXrVl7csMU1Hah8nOZ2HJXqpSiK6JCvosbY=;
        b=TyGovieVXCWeibJxznT15RBYZXciuCeCKP290ehBD+z09UYdNy7G77Y62Z3YKSdxUE
         +xvYuiy3VlgYATIjCP4WelLcJJzcrHcvQ4KyTuxxFgbfsTAVkMF09tkIp3RYEG5ic2tJ
         G53fDJei4oSiqNnLtDwnL3BWKMT22+FCWYd4OTLYD6MUoPTNv+dirdJKOiXe7pktlmYZ
         0DuIlu/CgVP5vFpAV6NdVu2kpONlJSVTggwgqLTEPBft1FVS0rfp9RDWyS5CNMnBpLW4
         1DbhmOJRzT1HeUMLYxupVowTotFMaJkQYUPwJCDJ8oc21YLdiLqQzc94G2crknse8MEa
         WCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=arazljuNqXrVl7csMU1Hah8nOZ2HJXqpSiK6JCvosbY=;
        b=kakI69k2tUdFZYXkOHOleFM86fnyMIw0cqWw7xS0wJrdTEH0juMLAs6jB1CKu4scy2
         G1o9qASy+lj2apokrUjoOJHZYT1ic8CQGXFHQ1mXbfmGNr9bunkGd+uKyydh+oc14soR
         u+qAMW83NXEL2E70AsaDH7zpJkiATGvRJABYNejrLMvqmhpDH4yCfzhqQ2YNUiuj9U7L
         z6Be2GN79Sg2EtYr/XFSrLcPDaLudWHybT2au03ugIYET2CYJjADXF5gLgp9Uua0++4o
         NuL3BA+P0mfWsxWNiz/NWg348BJLiKti51fnyv1kPUTW2JboF357INL4vwzNrRmJDkQO
         swtQ==
X-Gm-Message-State: ABuFfoiY9sqoaXLiI6ZfRMKeBJ/2VHhOYOalaPMFvaXl5gfudP8PxFn/
        TNCnswsIoVbjvz5SHVVIG/vqLQ==
X-Google-Smtp-Source: ACcGV62hgH6i+r9RZeXkSXR3xD1QeYcsx8Alz9XHVVLN2HZuRtIaS4zQELlqQhO5urvtS01MAdFUug==
X-Received: by 2002:a05:6402:884:: with SMTP id e4mr20104001edy.1.1538071182326;
        Thu, 27 Sep 2018 10:59:42 -0700 (PDT)
Received: from localhost.localdomain (fa-padur-binz.ediscom.de. [212.204.40.18])
        by smtp.gmail.com with ESMTPSA id a9-v6sm1532606edi.26.2018.09.27.10.59.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 10:59:41 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     jbenc@redhat.com, davem@davemloft.net, dsahern@gmail.com,
        stephen@networkplumber.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Brauner <christian@brauner.io>
Subject: [PATCH net-next 7/7] rtnetlink: enable RTM_GETADDR2
Date:   Thu, 27 Sep 2018 19:58:57 +0200
Message-Id: <20180927175857.3511-8-christian@brauner.io>
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
 net/core/rtnetlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 35162e1b06ad..2ec020236053 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4835,6 +4835,7 @@ void __init rtnetlink_init(void)
 	rtnl_register(PF_UNSPEC, RTM_DELLINK, rtnl_dellink, NULL, 0);
 
 	rtnl_register(PF_UNSPEC, RTM_GETADDR, NULL, rtnl_dump_all, 0);
+	rtnl_register(PF_UNSPEC, RTM_GETADDR2, NULL, rtnl_dump_all, 0);
 	rtnl_register(PF_UNSPEC, RTM_GETROUTE, NULL, rtnl_dump_all, 0);
 	rtnl_register(PF_UNSPEC, RTM_GETNETCONF, NULL, rtnl_dump_all, 0);
 
-- 
2.17.1

