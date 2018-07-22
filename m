Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945F6C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 18:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4FC20858
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 18:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C4FC20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbeGVTeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 15:34:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38072 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730331AbeGVTeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 15:34:44 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8BB10BC8;
        Sun, 22 Jul 2018 18:37:08 +0000 (UTC)
Date:   Sun, 22 Jul 2018 20:37:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhaoxiu Zeng <zengzhaoxiu@163.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-kernel@vger.kernel.org, Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
Subject: Re: [PATCH 1/1] lib: use sunday algorithm to do strstr() and
 strnstr()
Message-ID: <20180722183706.GA7979@kroah.com>
References: <20180722173715.25327-1-zengzhaoxiu@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180722173715.25327-1-zengzhaoxiu@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 01:37:15AM +0800, Zhaoxiu Zeng wrote:
> From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
> 
> The Sunday algorithm is a variation of Boyer-Moore algorithm, it is easy and fast.
> For the Sunday algorithm, to see
> 	http://www.inf.fh-flensburg.de/lang/algorithmen/pattern/sundayen.htm

So you say, but what does this really buy us?  Why make this change?
How was it tested?  What is the downside of not taking this?

thanks,

greg k-h
