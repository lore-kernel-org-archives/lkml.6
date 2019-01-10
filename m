Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED001C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3CF20675
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQYvjy/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbfAJRjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:39:55 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41626 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729890AbfAJRjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:39:51 -0500
Received: by mail-pg1-f193.google.com with SMTP id m1so5110947pgq.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8EglagjgHRjqiKEl1aStRYWWxeOmncYa5YZWXHo+q0s=;
        b=kQYvjy/0YWhgTWX47JgyaTGmIhbqQW5PWiVgOt0guZ8lHGz69/76TRHmpyJ/kEhmKc
         qM1ZF3zp5UsNd0dHLzhHwzQ/k8s23Y3cSoWqzJaKwiCdKwAirVWm8otgVi5uiFHJFPgo
         kBj2TYK5ybCuEIeL81ngI8dqJ7/Hu8pvP0WfdbpvKefsyIDDGDUt8yfUzIloJNxvfuhS
         uTCm68INE4xULI9QYqYgtFBKDG9F/OTrXKVmJbSE510p1uy8dPnEfvUf6ef4wxmMB6V7
         bbRfcp+W2ZC3zXTRkdnycjkdKhkvxD1SPSxQR89dvmkai7EKzzdM0RCuZaVlYpfInyZ0
         amlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8EglagjgHRjqiKEl1aStRYWWxeOmncYa5YZWXHo+q0s=;
        b=MWSLiXFxIUnUC9edHq0HhTbB0rRASj+pu2bAeSk0cJqiAx1QGbjejOxFObKPlQMXZc
         +P+DQRL4bR47e8sB4Z8R6PBwNERDPdNyLrQ5FJM0fBQOKMWzaOrMCC9mHZRwM3QFUiBD
         RP1A5THFoFNZjzO7nePenKRUr2X27bawasvOa6OsA7edoVZlukVzEh3eEwfmi2pXjG7O
         HuB74y3bADKfZeXEtOSoxhwjfWP/Ihuc40EVF8OBQN+vfU/U7fa3SHO6cMFCbHjc46Cc
         vF5LszuDPtCMDCfK57giqv6Uz66VLrliH0YEy4b6jREJoUib9ubvLN6QIeuVVGaE7Kmn
         ePqA==
X-Gm-Message-State: AJcUukeAOhDoVvbVMnJa9oVMDUDCsPYmBVuaCiG5gl36g18s7j8/kJsc
        mLzsx10LgK6GCtVSbIyOSJg=
X-Google-Smtp-Source: ALg8bN4HEC/daoJ8T8frPoqB4jsgfXoZrF69ssm6+WlTlOcOmabT00YBa2JYOHWIBPZlFU62Hc2Afg==
X-Received: by 2002:a63:fd0a:: with SMTP id d10mr10282850pgh.164.1547141990338;
        Thu, 10 Jan 2019 09:39:50 -0800 (PST)
Received: from nishad ([106.51.25.107])
        by smtp.gmail.com with ESMTPSA id r12sm91498740pgv.83.2019.01.10.09.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 09:39:49 -0800 (PST)
Date:   Thu, 10 Jan 2019 23:09:42 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, nishadkamdar@gmail.com
Subject: Re: [PATCH v4 2/4] staging: greybus: gpio: Use gpiochip_get_data()
 in place of gpio_chip_to_gb_gpio_controller()
Message-ID: <20190110173941.GB24566@nishad>
References: <cover.1545488665.git.nishadkamdar@gmail.com>
 <03b274a2b5777d67e9d9b6318b5b2f13ce5c2b66.1545488665.git.nishadkamdar@gmail.com>
 <20190109105824.GJ14782@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109105824.GJ14782@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 11:58:24AM +0100, Johan Hovold wrote:
> On Sat, Dec 22, 2018 at 08:21:00PM +0530, Nishad Kamdar wrote:
> > This patch drops gpio_chip_to_gb_gpio_controller(),
> > and uses gpiochip_get_data() to retrieve the container
> > of struct gpio_chip.
> 
> So this will break the driver, since gpiochip_add() sets the data
> pointer to NULL.
> 
> These kind of changes are getting too complicated to do without
> something to test against. We had a module simulator at one point, but
> not sure what the state of that is now.
> 
Ok, I get it.
> I appreciate the effort though, and since we already started, let's try
> to finish, but please drop this patch for now.
> 
Ok I'll do that.
> Johan

Thanks for the review.

Regards,
Nishad
