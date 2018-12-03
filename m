Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FF1C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95AF820834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PlVZZo3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95AF820834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbeLCM5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 07:57:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43325 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbeLCM5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 07:57:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so12028428wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 04:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9KBrBoOrO+XfJILgtl4j7qnaWuKkBcCyWQk1f6mH+Ns=;
        b=PlVZZo3c2gO9uLCfUZVVJpr16CniYdmelENBbOOWAlPNiC+/UN/G4hRbnNrnAedrZS
         1PImzadWgPPbLyxc/EpgdqP8AlagbZpOyK8c3Huzt8wv3X4BYVgVwMspZ4UQu6tbP3CB
         jisR0EmVStHYJUr1BfUmWN6FYjDWBLg3qt8Vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9KBrBoOrO+XfJILgtl4j7qnaWuKkBcCyWQk1f6mH+Ns=;
        b=VIV0BSRLeR0Y6Ml7S+Sy8Vf/6qD9AfzZqCsyI5QFRELJlu9oqKtBpfJbEHcRH3FlKz
         o2Wh9y1pW4uahVBEAZuMpuTsCgqYrXWOQymh5x3M1nx3D/o7d3D6WXlYmD9b6YuFk5FZ
         8SC4FrRPcXUPVyFfSaBD1JTx8RssIkWWCV2bOp301skvWP3jWzJ8Gn4FlH9cPrU2WUet
         tcVY5Lo6/HoN1Qx10H18cY3RFb75L9OIOUBDtVw6iUkxyT6KlKKxdD8NbkVaM2Rf92yk
         JXrRYI9V3duFrqmKKDQCdOjjQVieVvj8WWBJ4XpU2npzDsY1BJ5ksPgLgNUAqLdEiYhW
         elkA==
X-Gm-Message-State: AA+aEWYApz0TUM1/SayPXEv5R92dD0VJ7TqbTPUNBIiYpVJhA/zjyT+q
        J4ld/lWj85/jnMffDLvcf9Sdyw==
X-Google-Smtp-Source: AFSGD/Uq6JtGohyQ33oJfLxSqhdxAMWAtzz5RfNgfzCyq4KUoPhWt7h9nG/xmPBcWDabsL90f8d69g==
X-Received: by 2002:a05:6000:10d1:: with SMTP id b17mr13881949wrx.306.1543841773676;
        Mon, 03 Dec 2018 04:56:13 -0800 (PST)
Received: from dell ([2.31.167.218])
        by smtp.gmail.com with ESMTPSA id c10sm9814882wrw.49.2018.12.03.04.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 04:56:12 -0800 (PST)
Date:   Mon, 3 Dec 2018 12:56:11 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, mturquette@baylibre.com,
        sboyd@kernel.org, cw00.choi@samsung.com, krzk@kernel.org,
        b.zolnierkie@samsung.com, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, pavel@ucw.cz,
        andrew.smirnov@gmail.com, pombredanne@nexb.com,
        sjhuang@iluvatar.ai, akshu.agrawal@amd.com, djkurtz@chromium.org,
        rafael.j.wysocki@intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 0/9] clk: clkdev: managed clk lookup and provider
 registrations
Message-ID: <20181203125611.GQ26661@dell>
References: <cover.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
 <20181203121951.GP26661@dell>
 <20181203123558.GD15388@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181203123558.GD15388@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Dec 2018, Matti Vaittinen wrote:

> 
> Hi de Ho Lee,
> 
> On Mon, Dec 03, 2018 at 12:19:51PM +0000, Lee Jones wrote:
> > > Series add bd71837/bd71837 PMIC clock support + managed interfaces
> > 
> > You've send me a cover letter and no patches.
> > 
> I am afraid the patches may be still on their way... I added recipients
> to git format-patch via command-line so you are probably included also
> in patch mails :(

Ah I see.  Yes, I see that they have started to come through.

> > I suggest that I should not be on the addressee list at all for this.
> 
> I'm terribly sorry for spamming! I must've done some mistake with the
> get_maintainer.pl as I copied the recipients from that output. I may
> have accidentally included some old patch to maintainer query.

No problem.  If you could remove me from future mails though, that
would be appreciated.  The torrent it fierce enough without receiving
correspondence that is not relevant to me.  Thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
