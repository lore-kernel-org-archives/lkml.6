Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DF1C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F5C2175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549547888;
	bh=ql2kZK1LekoC4t5pOZXv7zKdHUi7q0D2YrztATb1mzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iWW+7Y3JWgF6LqiBATbK0RjpPQzn1Eg4vJfDHIbM23XMzXr2Mn0uqN9h4PDcTbZS0
	 lDp6IqFTx/TutTbDhXW2ygUAai+YAQleef98l1QAdpQx3nk9ZZYMZSeueiZ022QJN/
	 Vz5MYctkBk0aNKJAUJIZwbp6v2tc0YduYUP262Zg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfBGN6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:58:06 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:33345 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfBGN6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:58:06 -0500
Received: by mail-lf1-f50.google.com with SMTP id q12so247541lfm.0;
        Thu, 07 Feb 2019 05:58:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ql2kZK1LekoC4t5pOZXv7zKdHUi7q0D2YrztATb1mzk=;
        b=BS9XFK8MPrXWXOVNXPBcbYf86OQlJXaQBlq5yXtUu+xS2U8S8m3MMgKHRel3J2hIEj
         /RodHzj6v2LzrQlYIkLHfrGCZVT+sbbnnTXExDE8QVL2qu0oV4YIqwEdhWz6+N9Kegk8
         w7e7b3AEMXw7MzHftatoIrMzxQp1fleu9txbR5XLq+SAQMogrJ9rM3G4CS7xcQdrGMuo
         dopmC69wYs/vAHKyIm5iCgoEkGawlJmb1bXjhECmQ8iEGiH4IxqZ/Y4TLwvpygEfhTK5
         MbSFciYEmkjOkpCai6EgTbiO8RJna+ZXsSco8+z1Qa0kf6Y8xscpT7wS8POFKtvqoecH
         6RsA==
X-Gm-Message-State: AHQUAuZyScPA478VeSDJAY/me2P8FxODYSHDXuPLnYV7kfQF/xdNZiCo
        C7DFLQLsF7B6PFlI0CtJNkXFBY8K
X-Google-Smtp-Source: AHgI3IZIX5sYzgLaR/FC1PJ/fMMFviwJ1qt7oWPWRC5ka2I6WjHJ1TuTt+R7TJdfSM/ATTIUvPZb3g==
X-Received: by 2002:ac2:4116:: with SMTP id b22mr9947385lfi.19.1549547883752;
        Thu, 07 Feb 2019 05:58:03 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id d70sm2682550lfe.14.2019.02.07.05.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 05:58:02 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1grkBj-0005yo-Tw; Thu, 07 Feb 2019 14:57:59 +0100
Date:   Thu, 7 Feb 2019 14:57:59 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: cp210x: Fix GPIO in autosuspend
Message-ID: <20190207135759.GL4686@localhost>
References: <20190204160944.GH4686@localhost>
 <20190115085743.GL3691@localhost>
 <20190114194352.4579-1-pados@pados.hu>
 <15f71a61af66817847d4b11b9e2e60e8@pados.hu>
 <20190115092607.GN3691@localhost>
 <20190115102942.GO3691@localhost>
 <7af148c7c37e625525141bfa7d23754a@pados.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7af148c7c37e625525141bfa7d23754a@pados.hu>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 09:43:36PM +0000, Karoly Pados wrote:
> Uhm, yes, sorry, it kind of went out of my head. I am doing a lot of
> travelling lately (in the past 48 hours I've been on 3 airplanes), and
> I had travels on earlier weeks too, mixed with some project releases
> and family celebrations. So my head is just somewhere else.
> Realistically, I'll submit something by the weekend when I'm home
> again.

Sounds good. Just want to make sure this gets fixed in 5.1 (i.e. before
5.0 is released).

And just let me know if you can't find the time.

Johan
