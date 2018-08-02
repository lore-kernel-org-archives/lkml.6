Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C766C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63642146F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63642146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731857AbeHBKUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:20:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39668 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbeHBKUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:20:44 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 937B1C3A;
        Thu,  2 Aug 2018 08:30:38 +0000 (UTC)
Date:   Thu, 2 Aug 2018 10:30:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/8] char: rtc: remove task handling
Message-ID: <20180802083036.GA12755@kroah.com>
References: <20180726134056.18273-1-alexandre.belloni@bootlin.com>
 <20180726134056.18273-8-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726134056.18273-8-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 03:40:55PM +0200, Alexandre Belloni wrote:
> Since commit 9e7002a70e42 ("char: rtc: remove unused rtc_control() API"),
> it is not possible to set a callback anymore, remove its handling from the
> interrupt handler.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
> Hi,
> 
> My plan is to take that patch through the RTC tree because the next patch relies
> on the rtc_task_t *rtc_callback removal.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
