Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E82C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1FE125DFF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1FE125DFF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752693AbeGBNnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:43:11 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50710 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752033AbeGBNnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:43:08 -0400
Received: from localhost (unknown [59.29.86.96])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C655F13F8B5DD;
        Mon,  2 Jul 2018 06:43:06 -0700 (PDT)
Date:   Mon, 02 Jul 2018 22:43:05 +0900 (KST)
Message-Id: <20180702.224305.2266842641209029592.davem@davemloft.net>
To:     linux@roeck-us.net
Cc:     isdn@linux-pingi.de, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] TTY: isdn: Replace strncpy with memcpy
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1530478658-23070-1-git-send-email-linux@roeck-us.net>
References: <1530478658-23070-1-git-send-email-linux@roeck-us.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 02 Jul 2018 06:43:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>
Date: Sun,  1 Jul 2018 13:57:38 -0700

> gcc 8.1.0 complains:
> 
> drivers/isdn/i4l/isdn_tty.c: In function 'isdn_tty_suspend.isra.1':
> drivers/isdn/i4l/isdn_tty.c:790:3: warning:
> 	'strncpy' output truncated before terminating nul copying
> 	as many bytes from a string as its length
> drivers/isdn/i4l/isdn_tty.c:778:6: note: length computed here
> 
> drivers/isdn/i4l/isdn_tty.c: In function 'isdn_tty_resume':
> drivers/isdn/i4l/isdn_tty.c:880:3: warning:
> 	'strncpy' output truncated before terminating nul copying
> 	as many bytes from a string as its length
> drivers/isdn/i4l/isdn_tty.c:817:6: note: length computed here
> 
> Using strncpy() is indeed less than perfect since the length of data to
> be copied has already been determined with strlen(). Replace strncpy()
> with memcpy() to address the warning and optimize the code a little.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied.
