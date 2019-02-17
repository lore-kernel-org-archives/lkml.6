Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5734C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 05:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704D32196F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 05:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCSxkc5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfBQFaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 00:30:03 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35326 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfBQFaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 00:30:03 -0500
Received: by mail-pf1-f195.google.com with SMTP id j5so2397808pfa.2;
        Sat, 16 Feb 2019 21:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WFv1F886txVaDqA81dffNFX1SWI0vcyda3Niu2lkSjQ=;
        b=LCSxkc5ZqshuLVGqK+Xmb5KoFjGy/dS9He5sfhHWCQcDoOt+wXDbTcVAXp+QckefRx
         PpUnAf6out7nb1jf86yF/Z3GdI8Qfk5gh1U000vQVW+RBPvSshQ4CAZzR0n5vzzSUmnp
         lGtD8JgNzEcTqQa90pVGZTXbFgQvPrZOpbfEmNWEn6530CK+xV1oCt0ZvdKdO1ZBOjgC
         7vOAOYFv9ZgBQZl0wBBAs3RdowV6CRq516IhAcC9KsWCzSPU2up7dcFS9SIH56C1M8E5
         45b0NLwwww/8spcFa+jHp11SWRBb7N3+Chzjb9hJH+7wU9HBw3QE1XUK0suifck28li/
         UdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WFv1F886txVaDqA81dffNFX1SWI0vcyda3Niu2lkSjQ=;
        b=VS5bnPI2GDg+2U7weWfjnFzmKRilCCqifszx7UNhbcIaBbmm2dQOHcwEWW+YKFTrFC
         euHOwK8v6IGzB9K/Rt7pLMLmxn+vSzHXiMyBU8No5lCLMZrcpn35Wz0VuoFR7gzy4jqA
         cYdDyYYcSlG0PSi6oRNZdTiRnzQif6wO7eoNG2luHusIMDNLbVoQ+lJ9HcSc8viV9+f+
         cWywdjvHEyaGF6Kf2Hk/vvvZPlM02XyI7zIiczUD+PbKDf253YVSvKd5wPRama2zfrDy
         AnQcK61zaxSdA1kM8S+BUBReprL91QvbiLQ6w0fPU3B5cKbOcG5hHhYim+uLgOdMnzAF
         A6MQ==
X-Gm-Message-State: AHQUAuYjKvEsdPGt1kkIwGUfT1W4w8TJKsde5ksap36eVTzk4TciYDov
        ogZl0gxeWsmJuxqj0D8jP1qBmGFW
X-Google-Smtp-Source: AHgI3IYu3QdZIhS05426TWPwrISskGNlmERY7ZEdxn6L5Tudm8N4kmn+jf5RAz/+1LbVASDTq+HDGg==
X-Received: by 2002:a62:4b11:: with SMTP id y17mr18138522pfa.124.1550381402138;
        Sat, 16 Feb 2019 21:30:02 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id x2sm14495003pfx.78.2019.02.16.21.30.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Feb 2019 21:30:01 -0800 (PST)
Date:   Sat, 16 Feb 2019 21:29:59 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     thesven73@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] Input: synaptics_i2c - remove redundant spinlock
Message-ID: <20190217052959.GB107793@dtor-ws>
References: <20190212013442.26030-1-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212013442.26030-1-TheSven73@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

On Mon, Feb 11, 2019 at 08:34:42PM -0500, thesven73@gmail.com wrote:
> @@ -372,13 +371,7 @@ static bool synaptics_i2c_get_input(struct synaptics_i2c *touch)
>  static void synaptics_i2c_reschedule_work(struct synaptics_i2c *touch,
>  					  unsigned long delay)
>  {
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&touch->lock, flags);
> -
>  	mod_delayed_work(system_wq, &touch->dwork, delay);
> -
> -	spin_unlock_irqrestore(&touch->lock, flags);
>  }

This makes synaptics_i2c_reschedule_work() a useless wrapper for
mod_delayed_work(). Can we get rid of it?

Thanks.

-- 
Dmitry
