Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF51C04EBB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288BE20851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBAcMslt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 288BE20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbeKTU0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:26:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:57306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbeKTU0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:26:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E565206BB;
        Tue, 20 Nov 2018 09:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542707873;
        bh=BIbBG4YYTTgzDEuYGUlCPq+arJLPQqjQ8FJkj+0eh8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NBAcMsltBMmIK2D4sHBUMErTrP6Wnd9805Gd8SXvZxNYMUTZQDR7pRqhkly+sz1JG
         zYHMalSHfDvbSK5Q9BnoLBLKfensGPZjHckk1KZeaUftcMPQp770iEMP3ISY2u+fqD
         S4ScuJis9hh5jFm95+mPT5PffCsNiKaYj7oOL8bM=
Date:   Tue, 20 Nov 2018 10:57:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        eric@anholt.net, linux-rpi-kernel@lists.infradead.org,
        dave.stevenson@raspberrypi.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/16] staging: vchiq: dead code removal & misc fixes
Message-ID: <20181120095751.GB17738@kroah.com>
References: <20181114125942.25163-1-nsaenzjulienne@suse.de>
 <1128999886.40745.1542556549581@email.ionos.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128999886.40745.1542556549581@email.ionos.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 04:55:49PM +0100, Stefan Wahren wrote:
> Hi Nicolas,
> 
> > Nicolas Saenz Julienne <nsaenzjulienne@suse.de> hat am 14. November 2018 um 13:59 geschrieben:
> > 
> > 
> > Hi All,
> > 
> > This series was written in parallel with reading and understanding the
> > vchiq code. So excuse me for the lack of logic in the sequence of
> > patches.
> > 
> > The main focus was to delete as much code as possible, I've counted
> > around 550 lines, which is not bad. Apart from that there are some
> > patches enforcing proper kernel APIs usage.
> > 
> > The only patch that really changes code is the
> > vchiq_ioc_copy_element_data() rewrite.
> > 
> > The last commit updates the TODO list with some of my observations, I
> > realise some of the might be a little opinionated. If anything it's
> > going to force a discussion on the topic, which is nice.
> > 
> > It was developed on top of the latest linux-next, and was tested on a
> > RPIv3B+ with audio, video and running vchiq_test.
> > 
> > Regards,
> > Nicolas
> > 
> 
> without a changelog i won't start a review.

What do you mean by this?  The individual patches have a "changelog" in
them, this is just a summary of the overall changes.

What do you feel is missing here?

thanks,

greg k-h
