Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752147AbeCYWTG (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:19:06 -0400
Received: from smtprelay0253.hostedemail.com ([216.40.44.253]:50193 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751938AbeCYWTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:19:02 -0400
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,shea@shealevy.com,:::::::::::::::::::::::::,RULES_HIT:41:355:379:541:966:973:988:989:1260:1345:1359:1381:1437:1534:1538:1567:1711:1714:1730:1747:1777:1792:1978:1981:2194:2196:2199:2200:2393:2559:2562:3138:3139:3140:3141:3142:3865:3867:3868:3870:3871:3874:4385:5007:6261:6737:10004:10848:11026:11658:11914:12048:12533:13069:13149:13230:13311:13357:14384:14394:21080:21627:30012:30054:30062,0,RBL:71.235.10.46:@shealevy.com:.lbl8.mailshell.net-62.4.0.191 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:ff,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: hands90_318eeee3fbb23
X-Filterd-Recvd-Size: 1482
From: Shea Levy <shea@shealevy.com>
To: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH v2 00/16] Generic infrastructure for unloading initramfs
Date: Sun, 25 Mar 2018 18:18:37 -0400
Message-Id: <20180325221853.10839-1-shea@shealevy.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180324174458.26423-1-shea@shealevy.com>
References: <20180324174458.26423-1-shea@shealevy.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series extracts out code for unloading the initramfs that
was identical across 14 architectures, and moves those architectures
to the common code path. Additionally, RISC-V is newly moved to the
common code path.

In addition to reducing duplication, this allows us to bring future
improvements (such as generalizing existing "keep initrd" command line
options) to multiple architectures at once.

v2: Mark generic free_initrd_mem __init.
