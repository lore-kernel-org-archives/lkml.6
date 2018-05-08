Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755525AbeEHQVx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:21:53 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:39483 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755501AbeEHQVo (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 8 May 2018 12:21:44 -0400
From: Davidlohr Bueso <dave@stgolabs.net>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net
Subject: [PATCH -next 0/6] net: Update static keys to modern api
Date: Tue,  8 May 2018 09:06:57 -0700
Message-Id: <20180508160703.8125-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patches update pretty much all core net static key users
to the modern api. Changes are mostly trivial conversion without affecting
any semantics. The motivation is a resend of patches 1 and 2 from a while[1]
back, and the rest are added patches, specific for -net.

Applies against today's linux-next. Compile tested only.

[1] lkml.kernel.org/r/20180326210929.5244-1-dave@stgolabs.net

Thanks!

Davidlohr Bueso (6):
  net/ipv4: Update ip_tunnel_metadata_cnt static key to modern api
  net/sock: Update memalloc_socks static key to modern api
  net: Update [e/in]gress_needed static key to modern api
  net: Update netstamp_needed static key to modern api
  net: Update generic_xdp_needed static key to modern api
  net/udp: Update udp_encap_needed static key to modern api

 include/net/ip_tunnels.h  |  4 ++--
 include/net/sock.h        |  4 ++--
 net/core/dev.c            | 48 +++++++++++++++++++++++------------------------
 net/core/sock.c           |  8 ++++----
 net/ipv4/ip_tunnel_core.c |  6 +++---
 net/ipv4/udp.c            |  8 ++++----
 net/ipv6/udp.c            |  8 ++++----
 7 files changed, 43 insertions(+), 43 deletions(-)

-- 
2.13.6
