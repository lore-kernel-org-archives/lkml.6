Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E53C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E155206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544814445;
	bh=lqH78WUgb87nxhQUGMydz1PSkoA3uqMoODa2urXCQns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NTC6yYViVUG3vI8+O2Vehsri6+g5NtCEEwfIHDI9H6mvR7rTgySwJSiHvUWBV6elQ
	 225OrbneadbZZt0tQGJj7v4wkZJ++KElvLmb3dtXQo/ddFyopIaUNCwoGYSH8Av5qH
	 YDnECapK6dHk8SS74ioRVvp8ftTTuV7hJ3hmNONA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbeLNTHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 14:07:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:37378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730123AbeLNTHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 14:07:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C939206C0;
        Fri, 14 Dec 2018 19:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544814443;
        bh=lqH78WUgb87nxhQUGMydz1PSkoA3uqMoODa2urXCQns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gCLMosVCPE9TgcAOihRI2y0ILUbVL52aBOrv44tYG0S8zVU/giRZa6V/xcoaU+g+i
         RHpobnEAbwb6mnhxmq1RmktlHHyVd2mlx3/tiWGfoNRqKup6pWpfHGepIZyBw+IVQ6
         TS8lhqftWu8JMf5q1ziqWI5mjIS0t8guVtMnzKCs=
Date:   Fri, 14 Dec 2018 20:07:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Miller <davem@davemloft.net>
Cc:     edumazet@google.com, sudipm.mukherjee@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        soheil@google.com, ycheng@google.com
Subject: Re: [PATCH 4.14 12/89] tcp: Do not underestimate rwnd_limited
Message-ID: <20181214190719.GA4430@kroah.com>
References: <20181214142621.GA28340@kroah.com>
 <CANn89iKnuwQAybYEtXwvRFfQ8Rp8VihO16bVucAjDn1GRBtv9w@mail.gmail.com>
 <20181214143614.GA29266@kroah.com>
 <20181214.110309.1172531312891958180.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214.110309.1172531312891958180.davem@davemloft.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 11:03:09AM -0800, David Miller wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date: Fri, 14 Dec 2018 15:36:14 +0100
> 
> > On Fri, Dec 14, 2018 at 06:29:54AM -0800, Eric Dumazet wrote:
> >> I ack it, I guess David had this queued already.
> >> 
> >> No big deal, that is only for tcp_info instrumentation accuracy.
> > 
> > If this is already queued for the next round of stable patches, and it's
> > not a major issue, I'll just wait and take it when it shows up in a week
> > or so.
> 
> Turns out I actually didn't have it queued, so Greg if you could toss
> this into your trees now it would save me a bunch of coordinating and
> work.

now queued up, thanks everyone!

greg k-h
