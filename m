Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3795FECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C8D2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C8D2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=skynet.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbeJSQY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:24:58 -0400
Received: from mailrelay101.isp.belgacom.be ([195.238.20.128]:36125 "EHLO
        mailrelay101.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726609AbeJSQY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:24:57 -0400
X-Belgacom-Dynamic: yes
IronPort-PHdr: =?us-ascii?q?9a23=3ALEGQdxQG3BhN9i/LBxHQjzRa/dpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6zbB2N2/xhgRfzUJnB7Loc0qyK6/+mATRIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfbF/IA+qoQnNq8IbnZZsJqEtxx?=
 =?us-ascii?q?XTv3BGYf5WxWRmJVKSmxbz+MK994N9/ipTpvws6ddOXb31cKokQ7NYCi8mM3?=
 =?us-ascii?q?0u683wqRbDVwqP6WACXWgQjxFFHhLK7BD+Xpf2ryv6qu9w0zSUMMHqUbw5Xy?=
 =?us-ascii?q?mp4qF2QxHqlSgHLSY0/mHJhMJtgqxVoxWvqgdjz4LIeoyZKOBzcr/Bcd4cWG?=
 =?us-ascii?q?FPXtxRVytEAo6kb4UAFfEOPedCoIn7ulAArQG+ChexC+zx0D9Ih2P53a4n2O?=
 =?us-ascii?q?kmHwHJxhcvH9wVvXTPr9X0NKESXv6pzKXS1jrMcepb1DHg44bLahAsufKBUL?=
 =?us-ascii?q?BqfcfQyEQjDQHIg1GKpYD4PD6Y2OIAuHWB4eV6T+KgkWsnphl0ojio28gjlJ?=
 =?us-ascii?q?HEhpkQylDY7SV5x5s1JcGgRE57f9GkFJxQujmeN4txXswtWWVouCY9yr0dpZ?=
 =?us-ascii?q?63ZiwKyJM7yBHFb/yIbo+I4hf5W+aQJzd0nHNleLShiBau6UWtye/xWtO13V?=
 =?us-ascii?q?tLtCZIkN3BumoQ2xHQ5MWLUv598V2g2TaL2QDT8OZEIUUsmKrVMZEu2bAwm4?=
 =?us-ascii?q?EIsUTAHi72nlv5jLOMeko/5Oek8/7nban+pp+AK490jRnzPb4tmsynBOQ1KQ?=
 =?us-ascii?q?wOX2md+eSh27zv5EP5QLJXjv0wj6bWqozaJcUcpq6/GQNV1Zwj6xmnBTe8zN?=
 =?us-ascii?q?sYhWUHLE5CeB+fjYjmIVHOL+riDfe8nVusiyxmyOzdPrH7HprNK2XDnK3/cr?=
 =?us-ascii?q?lg9k5W0BAzwsxH55JIFrEBJ+r+VVP2tNPFFBA0KBC7w/39BNph04MeRHiDDb?=
 =?us-ascii?q?GEP6PPqVWI/P4gI/GQZI8JvzbwM/wl5//ojX8kll4RZKep3YAKZ3+mAPRpPU?=
 =?us-ascii?q?GZbGHygtcOD2gKpBAyTO/0h12YVz5ceXKyU7g75jEhB4KsFZ3DSZy1gLydwC?=
 =?us-ascii?q?e7GYVbZmRHClCKDHfpeJyIW/QSZyKIJM9ujDgEWKO/S48uyx6urhX2y7l5Ie?=
 =?us-ascii?q?rO/C0Xq5bj2MJy5+3JmhE47SZ0ANiF02GRU2F0mXsFRzEs069kr0xw0UyD0a?=
 =?us-ascii?q?t4gvxeC9NT++lFXRwkOs2U8+svAtPqXyrFf9GUWBOoRcigDTgtT9U3hdgUbB?=
 =?us-ascii?q?VTAdKn2z7K1SujBfc7jbGHCYY1+aGUi3b4LchV0HXX0qQ9yVMrFJgcfVa6j7?=
 =?us-ascii?q?JyolCAT7XClF+Uwv6n?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AxAACMkslb/7dPQldjHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUQcBAQsBgQh8gVMSjDVfjX4BiFCOCYF6OAGEQIUFIjQNDQEDAQECAQE?=
 =?us-ascii?q?CAWwogjYigz4jgRqDWIF1EagNg32GJ4cshDqBQT+JboUNAohtlVQJhiGKSwI?=
 =?us-ascii?q?VkCmYFTiBVU0gGIMokFg9gTMBPQGKMgEB?=
X-IPAS-Result: =?us-ascii?q?A2AxAACMkslb/7dPQldjHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?Qh8gVMSjDVfjX4BiFCOCYF6OAGEQIUFIjQNDQEDAQECAQECAWwogjYigz4jg?=
 =?us-ascii?q?RqDWIF1EagNg32GJ4cshDqBQT+JboUNAohtlVQJhiGKSwIVkCmYFTiBVU0gG?=
 =?us-ascii?q?IMokFg9gTMBPQGKMgEB?=
Received: from 183.79-66-87.adsl-dyn.isp.belgacom.be (HELO localhost.localdomain) ([87.66.79.183])
  by relay.skynet.be with ESMTP; 19 Oct 2018 10:19:54 +0200
From:   Fabian Frederick <fabf@skynet.be>
To:     akpm@linux-foundation.org
Cc:     jaharkes@cs.cmu.edu, coda@cs.cmu.edu,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        fabf@skynet.be
Subject: [PATCH 0/7 linux-next] coda: fs clean-up
Date:   Fri, 19 Oct 2018 10:19:26 +0200
Message-Id: <1539937173-26260-1-git-send-email-fabf@skynet.be>
X-Mailer: git-send-email 2.4.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small patchset applies some sparse clean-up / optimizations

Fabian Frederick (7):
  coda: remove CODA_FREE
  coda: destroy mutex in put_super()
  coda: use SIZE() for stat
  coda: add __init to init_coda_psdev()
  coda: remove sysctl object from module when unused
  coda: remove sb test in coda_fid_to_inode()
  coda: ftoc validity check integration

 fs/coda/Makefile     |  3 ++-
 fs/coda/cnode.c      | 15 ++++++++++-----
 fs/coda/coda_fs_i.h  |  3 +--
 fs/coda/coda_int.h   | 10 ++++++++++
 fs/coda/coda_linux.h |  6 ------
 fs/coda/dir.c        |  6 ++----
 fs/coda/file.c       | 17 +++++------------
 fs/coda/inode.c      |  1 +
 fs/coda/psdev.c      | 10 +++++-----
 fs/coda/sysctl.c     | 11 -----------
 fs/coda/upcall.c     | 38 +++++++++++++++++++-------------------
 11 files changed, 55 insertions(+), 65 deletions(-)

-- 
2.4.11

