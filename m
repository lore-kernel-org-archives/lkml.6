Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BC1C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C6F20838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="SFeJm7ly";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p921Bb9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C6F20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbeLFLJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 06:09:08 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48771 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727575AbeLFLJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 06:09:06 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9D44121C24;
        Thu,  6 Dec 2018 06:09:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 06 Dec 2018 06:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=L2D3+lLPQSJrqy/Gm7kaF1fqscj
        lK24PoFhIlhImJDk=; b=SFeJm7lyKQNZ5mZdo5r++Mxag+/jVgraYvToL0midGi
        Cx9XvasgpMevluz2uRsb/7VHGUZG1LZPFTrthDG5Xxh2zieD+lrOuAW8aFuVJbfT
        VROkZx+jgTO3ok8wj7k+26q+pAQfaXMkKROCAYzWet/R/IfN1mek+wsPgsESD01V
        YOu3AQK1iO7yN8H1NmqN7VFSZXcINE+hEr6xPdGlnXR0QGl+y7vuQYQUS65C6xEs
        NOL2JqAdurm7Fka4cYmlq2GMIzuxBbtZUTJbvYJYks2WSRFFMLDVT6FRLLyAM8fa
        N8VuxwoAQ9bDb02uPCTZjg4Qg9HTKZbtJ0F31HM09Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=L2D3+l
        LPQSJrqy/Gm7kaF1fqscjlK24PoFhIlhImJDk=; b=p921Bb9gNB8xI6dJZH3XfH
        W+gnC2tnQ2OpyiYm1YtRrT826DlPzeWriUwnFJ/SoBcbnYjKa+kYt3nXsIF1C0Yk
        1xpdOv0OI5DM/wFYya7OfJby9No7ms++B6h2qOt5XzeCdmfDxXNBbEXScvZo+Q1R
        465VMJOioIz6OpRNOwEy5BHI8pbA8u9mLeuQ+lELv/Z7dOLSOXhdO9+w8Fy9/33r
        7VJ8xS1BbNSRgTciY/jbYWRxC5unGuUGwDcbmZpTDMoxhzQ0m7z2w7oFaVwDCEWo
        uetTb0miMekE7Mu5KwaS+rQOecygxgZJWQ1qEqJhydWOC4sJC067ZwIeGRVdlkew
        ==
X-ME-Sender: <xms:TwMJXEdXodfGe1P7CNUWXjDV-PcU5Nazp0s7RhqfhNNWsamNvYPTvA>
X-ME-Proxy: <xmx:TwMJXAK-DjgczT4iIWHB-7XlHEBYJ1uk8UpFVpf5KnajHQ_KIp2NSg>
    <xmx:TwMJXGvzHKlth92C87RW6exBX5tUt9RF-wH_VX7xmNR4MmFYkVdfgQ>
    <xmx:TwMJXN7yMqYsFh6buwdtTVUXfTVuefWOdzIDiO1Ge4ppKSomp0D0HQ>
    <xmx:TwMJXPe9wf8evX85AmLOQTiiQQ4g7pwS1lVXP5yY90L2eeKcGhnzBQ>
    <xmx:TwMJXAW9xL5mJpnUN6HUnh8LX5eOUZyAy88Morr4ApIHT_x9fqwz7w>
    <xmx:UQMJXLE3ejmfXwlZYkR9Y8b58z0BnL0ZysnwD8Ku1EQDat7nvtYqvw>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id D9A9AE49E8;
        Thu,  6 Dec 2018 06:09:02 -0500 (EST)
Date:   Thu, 6 Dec 2018 12:09:01 +0100
From:   Greg KH <greg@kroah.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Martin Kepplinger <martin.kepplinger@ginzinger.com>,
        stable@vger.kernel.org, dedekind1@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Juergen <juergen.lachmann@harman.com>
Subject: Re: [PATCH] ubi: fastmap: Check each mapping only once
Message-ID: <20181206110901.GN19891@kroah.com>
References: <20181126103842.3249-1-martin.kepplinger@ginzinger.com>
 <20181129080923.GE13859@kroah.com>
 <1676802.TThbbZSlzy@blindfold>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1676802.TThbbZSlzy@blindfold>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 09:51:34AM +0100, Richard Weinberger wrote:
> Greg,
> 
> Am Donnerstag, 29. November 2018, 09:09:23 CET schrieb Greg KH:
> > On Mon, Nov 26, 2018 at 11:38:42AM +0100, Martin Kepplinger wrote:
> > > From: Richard Weinberger <richard@nod.at>
> > > 
> > > [ Upstream commit 34653fd8c46e771585fce5975e4243f8fd401914 ]
> > > 
> > > This commit got merged along with commit 781932375ffc
> > > ("ubi: fastmap: Correctly handle interrupted erasures in EBA") upstream but
> > > only the latter has been applied to stable v4.14.54 as commit a23cf10d9abb.
> > > This resulted in a performance regression. Startup on i.MX platforms is
> > > delayed for up to a few seconds depending on the platform.
> > > This fixes ubi fastmap to be of the same performance as it has been before
> > > said fastmap changes.
> > > 
> > > Fixes: a23cf10d9abb ("ubi: fastmap: Correctly handle interrupted erasures in EBA")
> > > Signed-off-by: Richard Weinberger <richard@nod.at>
> > > Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> > > ---
> > > 
> > > Richard, although this fixes a major slowdown regression in -stable, do you
> > > consider this "stable" too?
> > > 
> > > This applies and is tested only for the 4.14 stable tree. It seems to be
> > > equally relevant for 4.9 and 4.4 though.
> > 
> > Now queued up for 4.14.y, thanks.
> 
> can you *please* slow a little down?
> 
> There are times (e.g. when I travel, visit customers on-site, being sick, etc...)
> where I don't have the resources to monitor the mailinglists
> in detail. Adding patches to stable on shout asks for trouble.
> 
> As Sudip points out, this patch needs a further fix patch:
> 25677478474a ("ubi: Initialize Fastmap checkmapping correctly")

This is now in 4.14.86 so all should be fine now.

As for "speed", most of the time people are complaining that I move too
slow in getting fixes backported and to their patches.  Rarely am I told
I am moving too fast, that's a nice change :)

As for doing releases on a "regular" schedule, I've tried it, and it
didn't work any better/worse than what I'm doing now as everyone who
consumes these kernels have their own cadence / acceptance process and I
can never get in sync with _everyone_ let alone almost _anyone_.

And due to travel and other things (like security issues coming up),
trying to nail down a specific day-of-the-week doesn't work out at all
either.

thanks,

greg k-h
