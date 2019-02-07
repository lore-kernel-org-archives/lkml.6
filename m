Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9759C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 07:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE28218B0
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 07:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfBGHqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 02:46:34 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:44252 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726410AbfBGHqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 02:46:34 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from eli@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 7 Feb 2019 09:46:31 +0200
Received: from nps-server-21.mtl.labs.mlnx (nps-server-21.mtl.labs.mlnx [10.137.240.120])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x177kVDu026569;
        Thu, 7 Feb 2019 09:46:31 +0200
Received: from nps-server-21.mtl.labs.mlnx (localhost [127.0.0.1])
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id x177kV0c030213;
        Thu, 7 Feb 2019 09:46:31 +0200
Received: (from eli@localhost)
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id x177kPdV030210;
        Thu, 7 Feb 2019 09:46:25 +0200
From:   Eli Cohen <eli@mellanox.com>
To:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     simon.horman@netronome.com, jakub.kicinski@netronome.com,
        dirk.vandermerwe@netronome.com, francois.theron@netronome.com,
        quentin.monnet@netronome.com, john.hurley@netronome.com,
        edwin.peer@netronome.com, Eli Cohen <eli@mellanox.com>
Subject: [PATCH net-next 0/2] Change tc action identifiers to be more consistent
Date:   Thu,  7 Feb 2019 09:45:47 +0200
Message-Id: <20190207074549.29861-1-eli@mellanox.com>
X-Mailer: git-send-email 2.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This two patch series modifies TC actions identifiers to be more consistent and
also puts them in one place so new identifiers numbers can be chosen more
easily.

Eli Cohen (2):
  net: Move all TC actions identifiers to one place
  net: Change TCA_ACT_* to TCA_ID_* to match that of TCA_ID_POLICE

 include/net/act_api.h                     |  2 +-
 include/net/tc_act/tc_csum.h              |  2 +-
 include/net/tc_act/tc_gact.h              |  2 +-
 include/net/tc_act/tc_mirred.h            |  4 +--
 include/net/tc_act/tc_pedit.h             |  2 +-
 include/net/tc_act/tc_sample.h            |  2 +-
 include/net/tc_act/tc_skbedit.h           |  2 +-
 include/net/tc_act/tc_tunnel_key.h        |  4 +--
 include/net/tc_act/tc_vlan.h              |  2 +-
 include/uapi/linux/pkt_cls.h              | 45 ++++++++++++++++++++++++++++---
 include/uapi/linux/tc_act/tc_bpf.h        |  2 --
 include/uapi/linux/tc_act/tc_connmark.h   |  2 --
 include/uapi/linux/tc_act/tc_csum.h       |  2 --
 include/uapi/linux/tc_act/tc_gact.h       |  1 -
 include/uapi/linux/tc_act/tc_ife.h        |  1 -
 include/uapi/linux/tc_act/tc_ipt.h        |  3 ---
 include/uapi/linux/tc_act/tc_mirred.h     |  1 -
 include/uapi/linux/tc_act/tc_nat.h        |  2 --
 include/uapi/linux/tc_act/tc_pedit.h      |  2 --
 include/uapi/linux/tc_act/tc_sample.h     |  2 --
 include/uapi/linux/tc_act/tc_skbedit.h    |  2 --
 include/uapi/linux/tc_act/tc_skbmod.h     |  2 --
 include/uapi/linux/tc_act/tc_tunnel_key.h |  2 --
 include/uapi/linux/tc_act/tc_vlan.h       |  2 --
 net/sched/act_api.c                       |  2 +-
 net/sched/act_bpf.c                       |  2 +-
 net/sched/act_connmark.c                  |  2 +-
 net/sched/act_csum.c                      |  2 +-
 net/sched/act_gact.c                      |  2 +-
 net/sched/act_ife.c                       |  2 +-
 net/sched/act_ipt.c                       |  4 +--
 net/sched/act_mirred.c                    |  2 +-
 net/sched/act_nat.c                       |  2 +-
 net/sched/act_pedit.c                     |  2 +-
 net/sched/act_police.c                    |  2 +-
 net/sched/act_sample.c                    |  2 +-
 net/sched/act_simple.c                    |  4 +--
 net/sched/act_skbedit.c                   |  2 +-
 net/sched/act_skbmod.c                    |  2 +-
 net/sched/act_tunnel_key.c                |  2 +-
 net/sched/act_vlan.c                      |  2 +-
 tools/include/uapi/linux/tc_act/tc_bpf.h  |  2 --
 42 files changed, 70 insertions(+), 63 deletions(-)

-- 
1.8.3.1

