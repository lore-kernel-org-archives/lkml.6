Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4098462-1520452965-2-11291239909351257385
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520452965; b=d2ZdQ7eFSs03ujQbyRAOjZBEexyYyosi3mnwAz/C7452hnG
    sFcQpJdUk2S0pkROwgD/aQMFMivYz4ojct0W/sTWgz8m/IELWH+b6UCvXLnsNdGG
    6h6R8nKskF3amcQ2u2HOUsc/kjK4rYFiFDOow6yialuiN3qi0kHnfMtNj3+Sf309
    EwJjxEOMWwoG3TWXivcYfLQaP7zO8Ut2aKVRxkV39zuITSkHtQdaV6LGkzo9IEuc
    /wncM5cT/CN7RoVhbRjFRD2s0MRjUVE4f7SpTBLwkyuWprfjt9PpjWL3u9TpeYpp
    mEpcTZ1AkX2DZD+j6rLo4+/Q4g3pSWTDLi+RuqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520452965; bh=Tpr8rUE4P2FMKdEeqozeI8ZBAi
    7YnoUeKg7QT0cubFM=; b=BFWuNouFXnk0XKlqmo6wwPZa4r3vG/D7nwjzdDS1je
    YNLxebbBkZkL4q3GMEaPHjbiA1C33HTceakIXQMaSB/KP1SPjuGxPIq4fbkAk27G
    YHeyGCSbjX4xNkR0XcMI3UOoBQbU6dAXyrJDYvsAnW60JZ4N4qVbFhckShzzyII5
    e4LhJtrTRj+Lh5aMD4ZOcsM7rsuwwE7DgBtA++T8O6ocwKy6/JQFRRe+3J6aFeM3
    nKJQ5+4txe+P2PmsgnZG6Dhxx1aQPTxJcN6k0kc7ZKU9sOQR3aju8ki05p5xBcbW
    D1N3Om3xSC26WJcqVurGsfxZgp+FzJzfDaChSFvNGtOw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965607AbeCGTqr (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:46:47 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44754 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965606AbeCGTqq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:46:46 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        Alexander Petrovskiy <alexpe@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 069/110] mlxsw: spectrum_router: Do not unconditionally clear route offload indication
Date: Wed,  7 Mar 2018 11:38:52 -0800
Message-Id: <20180307191048.449350680@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@mellanox.com>


[ Upstream commit d1c95af366961101819f07e3c64d44f3be7f0367 ]

When mlxsw replaces (or deletes) a route it removes the offload
indication from the replaced route. This is problematic for IPv4 routes,
as the offload indication is stored in the fib_info which is usually
shared between multiple routes.

Instead of unconditionally clearing the offload indication, only clear
it if no other route is using the fib_info.

Fixes: 3984d1a89fe7 ("mlxsw: spectrum_router: Provide offload indication using nexthop flags")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reported-by: Alexander Petrovskiy <alexpe@mellanox.com>
Tested-by: Alexander Petrovskiy <alexpe@mellanox.com>
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -3032,6 +3032,9 @@ mlxsw_sp_fib4_entry_offload_unset(struct
 	struct mlxsw_sp_nexthop_group *nh_grp = fib_entry->nh_group;
 	int i;
 
+	if (!list_is_singular(&nh_grp->fib_list))
+		return;
+
 	for (i = 0; i < nh_grp->count; i++) {
 		struct mlxsw_sp_nexthop *nh = &nh_grp->nexthops[i];
 
