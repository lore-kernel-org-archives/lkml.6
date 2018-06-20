Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B5CC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720102083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720102083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754341AbeFTQO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 12:14:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754138AbeFTQOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 12:14:53 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55EF42075E;
        Wed, 20 Jun 2018 16:14:52 +0000 (UTC)
Date:   Wed, 20 Jun 2018 12:14:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Byungchul Park <max.byungchul.park@gmail.com>
Cc:     Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Byungchul Park <byungchul.park@lge.com>,
        jiangshanlai@gmail.com, josh@joshtriplett.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [RFC 1/2] rcu: Do prepare and cleanup idle depending on
 in_nmi()
Message-ID: <20180620121450.31724b69@gandalf.local.home>
In-Reply-To: <CANrsvRMW_LF1W3-OerHbXm1nqPBLGhQYP6ZsTMapGnfiT7-W3w@mail.gmail.com>
References: <1529484440-20634-1-git-send-email-byungchul.park@lge.com>
        <20180620145058.GP3593@linux.vnet.ibm.com>
        <20180620114335.7a314642@gandalf.local.home>
        <20180620155658.GU3593@linux.vnet.ibm.com>
        <CANrsvRMW_LF1W3-OerHbXm1nqPBLGhQYP6ZsTMapGnfiT7-W3w@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2018 01:11:36 +0900
Byungchul Park <max.byungchul.park@gmail.com> wrote:

> > Byungchul, is there any reason to make this change other than preparation
> > for your second patch?  
> 
> Sorry again I didn't explain it fully in advance. The only reason is to
> prepare for the 2nd. It was harder to read the patch when I made them
> into one. But I can make them into one if you don't think so.

Please keep them as separate patches. It's fine to say in one patch
that it is needed for a following patch. Not exactly in those words
though.

Each patch should be a stand alone patch, such that a git blame comes
to it, we don't need to go searching further to see why a change was
made.

What a change log should say is something like.

"In order to do X, we need to do Y, because of Z" Where X is a
description of what is to come, Y is a description of what the current
commit is doing, and Z is the rational for that change.

Thanks,

-- Steve
