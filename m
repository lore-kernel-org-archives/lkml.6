Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB2EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 07:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B342087C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 07:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B342087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbeKSRjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 12:39:35 -0500
Received: from lgeamrelo13.lge.com ([156.147.23.53]:42765 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726088AbeKSRjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 12:39:35 -0500
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.53 with ESMTP; 19 Nov 2018 16:16:47 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.151 with ESMTP; 19 Nov 2018 16:16:47 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Mon, 19 Nov 2018 16:16:47 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     David Miller <davem@davemloft.net>
Cc:     jolsa@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, kernel-team@lge.com
Subject: Re: [PATCH RFC] hist lookups
Message-ID: <20181119071647.GC20153@sejong>
References: <20181113104054.GJ30042@krava>
 <20181118.205243.227550158553460819.davem@davemloft.net>
 <20181119062837.GB20153@sejong>
 <20181118.223355.244349385967273824.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181118.223355.244349385967273824.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 10:33:55PM -0800, David Miller wrote:
> From: Namhyung Kim <namhyung@kernel.org>
> Date: Mon, 19 Nov 2018 15:28:37 +0900
> 
> > Hello David,
> > 
> > On Sun, Nov 18, 2018 at 08:52:43PM -0800, David Miller wrote:
> >> From: Jiri Olsa <jolsa@redhat.com>
> >> Date: Tue, 13 Nov 2018 11:40:54 +0100
> >> 
> >> > I pushed/rebased what I have to perf/fixes branch again
> >> > 
> >> > please note I had to change our compile changes, because
> >> > they wouldn't compile on x86, but I can't verify on sparc,
> >> > so you might see some compile fails again
> >> 
> >> I just checked your current perf/fixes branch.
> >> 
> >> It builds on Sparc ;-)
> >> 
> >> And it behaves better too.  I do get tons of drops and lost events,
> >> but it seems to keep going even during the hardest load.
> >> 
> >> Eventually I end up with a lot of unresolvable histogram entries,
> >> so that is something to look into.
> > 
> > Did you record callchains as well?  I'd like to know whether it's
> > related to the children (cumulative) mode or not.
> 
> I did not have callchains on, just plain "./perf top"

OK, I need to think about it more..

Thanks,
Namhyung
