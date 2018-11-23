Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04542C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C282320863
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C282320863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440759AbeKXD6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 22:58:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:36200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732237AbeKXD6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 22:58:02 -0500
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89B5820863;
        Fri, 23 Nov 2018 17:12:55 +0000 (UTC)
Date:   Fri, 23 Nov 2018 12:12:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        linux-parisc@vger.kernel.org, stable@kernel.org,
        stable@vger.kernel.org
Subject: Re: [for-next][PATCH 08/18] parisc: function_graph: Simplify with
 function_graph_entry()
Message-ID: <20181123121253.278146b4@vmware.local.home>
In-Reply-To: <511cb47a-a1bd-bb5d-69ec-0836c6b5abfe@gmx.de>
References: <20181122003332.500796758@goodmis.org>
        <20181123073033.2083020863@mail.kernel.org>
        <511cb47a-a1bd-bb5d-69ec-0836c6b5abfe@gmx.de>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2018 10:06:05 +0100
Helge Deller <deller@gmx.de> wrote:


> > How should we proceed with this patch?  
> 
> My suggestion, although I didn't looked too much on it:
> Apply it to v4.9 and higher only.
> I think I started fixing trace functionality on parisc around 4.6,
> which is probably why applying it fails on v4.4 and v3.x

The problem is, if you backport the generic patches, it will completely
break any arch that isn't updated. This also includes the archs that
are no longer supported upstream, as they were not changed to handle
the generic updates either.

-- Steve
