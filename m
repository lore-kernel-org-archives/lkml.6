Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752924AbeC1UhQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 16:37:16 -0400
Received: from smtprelay0226.hostedemail.com ([216.40.44.226]:51861 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752090AbeC1UhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 16:37:15 -0400
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,shea@shealevy.com,:::,RULES_HIT:41:355:379:541:965:966:973:988:989:1260:1345:1359:1381:1437:1534:1538:1711:1714:1730:1747:1777:1792:1978:1981:2194:2196:2199:2200:2393:2559:2562:3138:3139:3140:3141:3142:3350:3865:3866:3867:3868:3870:3871:3874:4385:4390:4395:5007:6261:10004:10848:11026:11658:11914:13069:13149:13230:13311:13357:14384:14394:14721:21080:21627:30012:30054:30062,0,RBL:71.235.10.46:@shealevy.com:.lbl8.mailshell.net-62.4.0.191 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:ff,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: move62_3f44dd3d25a23
X-Filterd-Recvd-Size: 1167
From: Shea Levy <shea@shealevy.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/16] Generic initrd_free_mem
Date: Wed, 28 Mar 2018 16:36:43 -0400
Message-Id: <20180328203659.18692-1-shea@shealevy.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180328152714.6103-1-shea@shealevy.com>
References: <20180328152714.6103-1-shea@shealevy.com>
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

v4: Use weak symbols instead of Kconfig.
v3: Make the generic path opt-out instead of opt-in.
v2: Mark generic free_initrd_mem __init.
