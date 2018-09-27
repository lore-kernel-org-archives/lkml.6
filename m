Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF777C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A542168B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="b4IDmz4M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A542168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbeI1AS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:18:57 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38975 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbeI1AS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:18:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id h4-v6so5850029edi.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 10:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KBabLfXMvZ0zVRF1vvLQDVpIyjO9ZMSkPuV3qspR5A8=;
        b=b4IDmz4M4AmXXjn6AJlRxNR98YYNaA/w7XdP8g9OKXYAQazTR+KgN1tqv/AeVSR9+n
         ZgzeICGrQGqPrqEvTnZ0wujzybUJh92sQbmOv3wzoaGbpRiPNbru20qBAUkhq3dPOsIo
         cXOaE4A0KIg51yTzkmVrVMdL9XBty6jEHPtiRDIa9Nr1arEyLN0fPW9c29Z3LTmKYOho
         1WJq/uLvnHuzYuPFPlqjrpVpDfNSFiRRhYvzEchFkBMvoUrl/HlkaXkhrXKge+X9SKiK
         r0CqixL/K559lG8SPnw5ZCrzya/kPRwIeVRzzRYBa9MuKBxBGm4TslQ4BzNL8x6Pbqih
         tP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KBabLfXMvZ0zVRF1vvLQDVpIyjO9ZMSkPuV3qspR5A8=;
        b=Pc06nj8Rb8iGK71BIqzqkY9jXpfACQy3PKG+m0KuUIcq0h1gRVUAZ2tOD8le70Gorp
         1/MfAHLvH9J5NZirjTbrxk5pcT20W+A4y4o/aE3QemjjiB689TmWpF0Q+08VUiJWRYlE
         iIJK9L5+MP2DJyzXFokJuDZhO4qQWcdT2M0swjRVDwLiaF0lDSJ4HHqV1+yWYA1IIRd/
         i+jV06Qm1uIKx795xuGfLo763F3f75uNcXEJXatCeCL5We3m2wrdBoNn0Z5SDCCRwT+I
         faDN47XGKj2Hm5ltpxU3JP+fazOgg+re6TRspQ7Eb2+MF/XEPUyjgds7oOvLoUt8McII
         klBQ==
X-Gm-Message-State: ABuFfoibflXGOgZFAbZYCCvIid8HSpHXPgPjUD41Ye51DMV7x4XuONgu
        cBPZSYwZSQ1nm+7/HgffBjqpPA==
X-Google-Smtp-Source: ACcGV61YWbwUFT1MHj4cHMYYCVqfZBdyv6MpA3xkxYu0qNBYD6z5CTg8ShjoQN6Qqm9ioVilvxQihQ==
X-Received: by 2002:a50:a0a6:: with SMTP id 35-v6mr19615497edo.280.1538071169791;
        Thu, 27 Sep 2018 10:59:29 -0700 (PDT)
Received: from localhost.localdomain (fa-padur-binz.ediscom.de. [212.204.40.18])
        by smtp.gmail.com with ESMTPSA id a9-v6sm1532606edi.26.2018.09.27.10.59.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 10:59:28 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     jbenc@redhat.com, davem@davemloft.net, dsahern@gmail.com,
        stephen@networkplumber.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Brauner <christian@brauner.io>
Subject: [PATCH net-next 0/7] rtnetlink: add RTM_GETADDR2
Date:   Thu, 27 Sep 2018 19:58:50 +0200
Message-Id: <20180927175857.3511-1-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
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

Christian Brauner (7):
  rtnetlink: add RTM_GETADDR2
  ipv4: add RTM_GETADDR2
  ipv6: add RTM_GETADDR2
  decnet: add RTM_GETADDR2
  phonet: add RTM_GETADDR2
  selinux: add RTM_GETADDR2
  rtnetlink: enable RTM_GETADDR2

 include/uapi/linux/rtnetlink.h |  3 +++
 net/core/rtnetlink.c           |  1 +
 net/decnet/dn_dev.c            | 25 +++++++++++++++++++++++--
 net/ipv4/devinet.c             | 24 +++++++++++++++++++++---
 net/ipv6/addrconf.c            | 30 ++++++++++++++++++++++++------
 net/phonet/pn_netlink.c        | 25 +++++++++++++++++++++++--
 security/selinux/nlmsgtab.c    |  3 ++-
 7 files changed, 97 insertions(+), 14 deletions(-)

-- 
2.17.1

