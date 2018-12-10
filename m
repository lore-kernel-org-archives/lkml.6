Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A37C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD5820821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:25:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD5820821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbeLJVZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:25:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:34006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727665AbeLJVZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:25:18 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7008320821;
        Mon, 10 Dec 2018 21:25:17 +0000 (UTC)
Date:   Mon, 10 Dec 2018 16:25:15 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] tools/lib/traceevent: Fix processing of dereferenced
 args in bprintk events
Message-ID: <20181210162515.4a10d827@gandalf.local.home>
In-Reply-To: <20181210210921.A4C862084C@mail.kernel.org>
References: <20181210134522.3f71e2ca@gandalf.local.home>
        <20181210210921.A4C862084C@mail.kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018 21:09:20 +0000
Sasha Levin <sashal@kernel.org> wrote:

> Hi,
> 
> [This is an automated email]
> 
> This commit has been processed because it contains a "Fixes:" tag,
> fixing commit: .
> 
> The bot has tested the following trees: v4.19.8, v4.14.87, v4.9.144, v4.4.166, v3.18.128, 
> 
> v4.19.8: Build OK!
> v4.14.87: Failed to apply! Possible dependencies:
>     37db96bb4962 ("tools lib traceevent: Handle new pointer processing of bprint strings")

Bah, I cut and pasted incorrectly the sha1. I had:

7db96bb49629 (chopped off the 3)

-- Steve

> 
> v4.9.144: Failed to apply! Possible dependencies:
>     37db96bb4962 ("tools lib traceevent: Handle new pointer processing of bprint strings")
> 
> v4.4.166: Failed to apply! Possible dependencies:
>     37db96bb4962 ("tools lib traceevent: Handle new pointer processing of bprint strings")
> 
> v3.18.128: Failed to apply! Possible dependencies:
>     37db96bb4962 ("tools lib traceevent: Handle new pointer processing of bprint strings")
>     38d70b7ca176 ("tools lib traceevent: Simplify pointer print logic and fix %pF")
>     3d199b5be533 ("tools lib traceevent: Add support for IP address formats")
>     b6bd9c7d543a ("tools lib traceevent: Support %ps/%pS")
> 
> 
> How should we proceed with this patch?
> 
> --
> Thanks,
> Sasha

