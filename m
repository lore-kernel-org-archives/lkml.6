Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA11C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A861920883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547816348;
	bh=RvA9lA2OCGbK3FV4TwO1VeLPNa6fBsc8mH2j4JhIOVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jl9gOPIh1ujSvuhxY4XziYyvX2K5KJv85rSBs+sA0crTwySf2ZTlTWfy2tuC7FOkL
	 GB1wuETv4zP7C9aur9ZgYklZJkqGfysTY38hws4iSHmq7C1s0H6h9FuVJtCfzn03hI
	 zRGcedtV+hV+T2Yy1JQZHqz0rd9mskmc5l9dX5FE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfARM7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:59:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:38284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfARM7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:59:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD2D52087E;
        Fri, 18 Jan 2019 12:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547816345;
        bh=RvA9lA2OCGbK3FV4TwO1VeLPNa6fBsc8mH2j4JhIOVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sgoCeRnmEjk2/3ebPa9CP0X9h45DnbbUCq3IKopEGJTomLUXc7RdleE8ZGUoVJ0ZT
         p1JGQeiel80JzdOCQZCRjWWYdb01xOICjsOaqp0fXhhQU3EhFZDoCdyIKeQwh7ibzX
         7defUW3LLq3+txENJdvXLZvvrzSKqiezhA2PdbE4=
Date:   Fri, 18 Jan 2019 13:59:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin Hostettler <textshell@uchuujin.de>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Egmont Koblinger <egmont@gmail.com>
Subject: Re: vt: Improve CSI parsing
Message-ID: <20190118125903.GA18489@kroah.com>
References: <20181215143423.4556-1-textshell@uchuujin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181215143423.4556-1-textshell@uchuujin.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 03:34:19PM +0100, Martin Hostettler wrote:
> This patch series improves parsing of csi sequences to be more compliant
> with current practice.
> 
> ECMA-64 defines the format of CSI sequences which allow more characters
> than what the vt parser currently accepts. More importantly many of
> these characters are used in sequences that more capable terminal
> terminal implementations use.
> 
> Adjust the parsing of CSI sequences to match xterm* by ignoring all
> unknown sequences of the form
>    (ESC [)|CSI [\x20-\x3f]*[\x40-\x7e]
> 
> This avoids printing unwanted characters when application send valid
> sequences not supported by linux either while querying the terminal for
> it's identity or when applications print sequences without knowing what
> terminal implementation they are connected to (e.g. when connected over
> serial lines, android's adb, simple tcp connects, etc)
> 
> * and other common terminals

Thanks for these, now queued up.

greg k-h
