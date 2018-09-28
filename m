Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7CBC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058EF206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058EF206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeI2E1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:27:03 -0400
Received: from smtprelay0198.hostedemail.com ([216.40.44.198]:35003 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbeI2E1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:27:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 660F7180A8862;
        Fri, 28 Sep 2018 22:01:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shake07_b4f4d0b10d04
X-Filterd-Recvd-Size: 2771
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 22:01:17 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sridhar Samudrala <sridhar.samudrala@intel.com>,
        netdev@vger.kernel.org
Subject: Bad MAINTAINERS pattern in section 'NET_FAILOVER MODULE'
Date:   Fri, 28 Sep 2018 15:01:16 -0700
Message-Id: <20180928220116.30923-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	10085	NET_FAILOVER MODULE
	10086	M:	Sridhar Samudrala <sridhar.samudrala@intel.com>
	10087	L:	netdev@vger.kernel.org
	10088	S:	Supported
-->	10089	F:	driver/net/net_failover.c
	10090	F:	include/net/net_failover.h
	10091	F:	Documentation/networking/net_failover.rst

Commit that introduced this:

commit cfc80d9a11635404a40199a1c9471c96890f3f74
 Author: Sridhar Samudrala <sridhar.samudrala@intel.com>
 Date:   Thu May 24 09:55:15 2018 -0700
 
     net: Introduce net_failover driver
     
     The net_failover driver provides an automated failover mechanism via APIs
     to create and destroy a failover master netdev and manages a primary and
     standby slave netdevs that get registered via the generic failover
     infrastructure.
     
     The failover netdev acts a master device and controls 2 slave devices. The
     original paravirtual interface gets registered as 'standby' slave netdev and
     a passthru/vf device with the same MAC gets registered as 'primary' slave
     netdev. Both 'standby' and 'failover' netdevs are associated with the same
     'pci' device. The user accesses the network interface via 'failover' netdev.
     The 'failover' netdev chooses 'primary' netdev as default for transmits when
     it is available with link up and running.
     
     This can be used by paravirtual drivers to enable an alternate low latency
     datapath. It also enables hypervisor controlled live migration of a VM with
     direct attached VF by failing over to the paravirtual datapath when the VF
     is unplugged.
     
     Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
     Signed-off-by: David S. Miller <davem@davemloft.net>
 
  Documentation/networking/net_failover.rst |  26 +
  MAINTAINERS                               |   8 +
  drivers/net/Kconfig                       |  12 +
  drivers/net/Makefile                      |   1 +
  drivers/net/net_failover.c                | 836 ++++++++++++++++++++++++++++++
  include/net/net_failover.h                |  40 ++
  6 files changed, 923 insertions(+)

No commit with driver/net/net_failover.c found

