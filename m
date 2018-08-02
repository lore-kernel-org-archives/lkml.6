Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CC1C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D9721564
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D9721564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387548AbeHBTgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 15:36:08 -0400
Received: from mout.gmx.net ([212.227.17.21]:35105 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387423AbeHBTgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 15:36:08 -0400
Received: from homer.simpson.net ([185.221.150.28]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MIQlv-1fnlo61n5T-004DZv; Thu, 02
 Aug 2018 19:43:37 +0200
Message-ID: <1533231816.12550.54.camel@gmx.de>
Subject: Re: [rt-patch 4/3] arm,KVM: Move phys_timer handling to hard irq
 context
From:   Mike Galbraith <efault@gmx.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Thu, 02 Aug 2018 19:43:36 +0200
In-Reply-To: <1533228650.12550.15.camel@gmx.de>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
         <1532764179.9882.14.camel@gmx.de> <1532768853.9882.73.camel@gmx.de>
         <1533192980.11791.8.camel@gmx.de>
         <20180802123104.7fed73b4@gandalf.local.home>
         <1533228650.12550.15.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:85jmNUmV3Uh8zik6wlxYligp1ohTiMrkgUOylJoYgy5mu1j8Hfs
 KprBc36HZuJ2pBtu3ixB6+79+MVLCiLjxFsUwZ4RuW4LbuRU/c/+KUQbE0KOGHu5T0RmonE
 UtCNla46dYJ6hbmEA1D83o/HphhF+16KNRgUGGIpT/LQz+J1siKe1fU1AXDFuLxpS0gD2gg
 NCGHno83Ku3hC7tFoOeWw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0IC9WfFRl8s=:Rp81Tb4/rwaMU9L1fq5mny
 UnjJxfax4A07b5orC+NB0WtdBIw4HEMs4E/ItZcIIQbuO7H1n5EP73tSS1x+LJn5E5Vv1Hw4O
 pSqbEuUUBFbunsIxP8rbkPZwaEa0dBSAgHBt03mD6CsiXrj063asUnVJqWplMyn63wUzeojGR
 gXPGfTuipDNqbG0w0dmENjAdDGguOS/MbRxX6/Hb104mHIqaLY0RREHU5uvjzVDPkLTFKizJz
 efNb6VWUU6GGfuvJeYu76F4ipVLY1sUTRIC0EbNVaDskP3SqVSctcFMZupr8W+yHs7XJvcp8l
 vtmwUWbBzHq3O0LpwTRW3knaHwdPxXPY0LFjIM+FM+QTmUMatgAstOB66f9eDflt3VlhXiGez
 PLuN18KLDf14hI6VR3QBPRKXOCflFN6Sn6tUiSTzpOs4txT4BrKXUCfmjB2xkyTCk4+ImQtKh
 ErzgDWE/OrR9kSbFxguzxdZEtAslLKRkil0K5XTQdK0LlFEg8TrtKJLRf9+V4nYJBugAVlsSH
 iboutXUrexgB1XL7s5VUTQ2BelFpijgqcIIylEUNy91wILZV+lgAVwelq7CviC0ujPro/oQlJ
 E2mtNlZ7wavu/ePzKl/REQFrG9nsZGQs1ZDnHQDdgpe1fiQ8+huoPch1VKkyQ5wbE8xv4/a0/
 ZKQTNzp3SiA8eo2stWsRlhw3dZbwgY87O0U3i4i5udD0jwzoYscUmpwAkJf/OBAi0s5yLLSoT
 MArKGv1/wqYLoBQtsE3gItra4fEBJbEcGB//TV3Ayu2vyvgcMZVwwZIglbl8UUlM/fuB2UUJS
 VQ4EBax
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-02 at 18:50 +0200, Mike Galbraith wrote:
> On Thu, 2018-08-02 at 12:31 -0400, Steven Rostedt wrote:
> > On Thu, 02 Aug 2018 08:56:20 +0200
> > Mike Galbraith <efault@gmx.de> wrote:
> > 
> > > (arm-land adventures 1/3 take2 will have to wait, my cup runeth over) 
> > > 
> > > v4.14..v4.15 timer handling changes including calling kvm_timer_vcpu_load()
> > 
> > I take it that this should be added to v4.16-rt and marked stable-rt?
> 
> Yeah, barring way sexier ideas of course.

Gah, wait.  WRT marking for stable-rt, only the pmu allocation splat
fix is applicable to @stable-rt, kvm locking woes start at 4.15.

	-Mike
