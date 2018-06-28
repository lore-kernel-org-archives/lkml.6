Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5803C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC596275BB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC596275BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967313AbeF1PiV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:38:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33126 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965381AbeF1PiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:38:20 -0400
Received: from localhost (unknown [104.153.224.166])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 53195C18;
        Thu, 28 Jun 2018 15:38:18 +0000 (UTC)
Date:   Thu, 28 Jun 2018 22:54:46 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, ben.whitten@gmail.com,
        geert+renesas@glider.be, w@1wt.eu, pombredanne@nexb.com,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH] leds: ledtrig-morse: send out morse code
Message-ID: <20180628135446.GA18287@kroah.com>
References: <20180628134227.GA1719@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628134227.GA1719@arbeit>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 03:42:27PM +0200, Andreas Klinger wrote:
> Send out a morse code by using LEDs.
> 
> This is useful especially on embedded systems without displays to tell the
> user about error conditions and status information.
> 
> The trigger will be called "morse"
> 
> The string to be send is written into the file morse_string and sent out
> with a workqueue. Supported are letters and digits.
> 
> With the file dot_unit the minimal time unit can be adjusted in
> milliseconds.

This is great stuff, nice work.

But you need to document your new sysfs files in Documentation/ABI/
somewhere, so that people know how to use this.

thanks,

greg k-h
