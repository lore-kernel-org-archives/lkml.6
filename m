Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF06DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEDC720661
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdZpE3R8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfAISvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:51:31 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32783 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfAISvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:51:31 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so4092220pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 10:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YkoW1gL7hsj7KTI0vvS0qJj0mnhFctPDX2a+8UMkWZM=;
        b=RdZpE3R8r9PA0FA6JlF36WOe5jmAnwGttpGcV7Mov59p9TAFekp2UBTbxAXfFvFJnH
         kXBWSgbX9rCIjVlYNhS8q0wC9a894rwbJ0KtHOxMMCRcqhpmyfTr9KbgkL5VX7cwib3a
         n6roDZlfDMdB5neTUkyawPJizZ/7AH/9JnH8ppIGc6raUZRAqx8CRxZfJoJIPc+Jq4Sq
         yB+vTPXt/tyqnoBCir3wHn7yTVUZpIIG0KxfnlxoMacRk3BPlLIfMmOKnARz6mRU6QJH
         E/RJcExb7RXnAxpBq4GtculEGn7QfI3oGa//8aalXHck7Qk4uOXUIJ6So+OfdwxrMI5b
         cjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YkoW1gL7hsj7KTI0vvS0qJj0mnhFctPDX2a+8UMkWZM=;
        b=Xwcjoz3mcyeKdiDDvW9HBQQPLH63iphVZTs4czpgBg5pBbo+t20Un1ZBwbRJsPFOZn
         t++ZBGkyCMxyzQN9H/f0XHwlTPtJgu+IqRfuL28ZheNn/vdbbiIFWN6joYgSVwKi4Cgh
         Dy+Z0ReETBpA8OqAQuy1toi50H6XefKziTVXwTBjO3HAIXuFRaOugO8jf+8Zu4LhwtRQ
         3jY/lAuhcqwC+SCxule1H7tSbhM33oPd6D3+bngDGJpFcbs7NimRUvl7/eQkqlApYU25
         jSHnHLpydr0Rcai58GBO03j1PC2LRnZXRKo/nrT/CtBLZALNihq4MkTJWyhIowssZZdy
         hF7g==
X-Gm-Message-State: AJcUukdEgdwugNFUaV1S1S1lYxZszMh3khDqP5D1joe5LKiefgum9C+H
        su/tlNEWz3iiGFu6HHFibglNu7S/P+o=
X-Google-Smtp-Source: ALg8bN5rmpsZbWPc64pmrg1Un4Y9lJ7ysfzaRgsWYO5SlnmmWxoian7KLyrePmNjLH8E8pmsfBqsLw==
X-Received: by 2002:a62:5d0c:: with SMTP id r12mr7374759pfb.0.1547059890083;
        Wed, 09 Jan 2019 10:51:30 -0800 (PST)
Received: from Ideapad-330S ([49.206.13.149])
        by smtp.gmail.com with ESMTPSA id r66sm114392116pfk.157.2019.01.09.10.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 10:51:29 -0800 (PST)
Date:   Thu, 10 Jan 2019 00:21:24 +0530
From:   b-ak <anur.bhargav@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: tlv320aic32x4: SND_SOC_DAPM_MICBIAS is deprecated
Message-ID: <20190109185124.GA15153@Ideapad-330S>
References: <20190109171121.GA12810@Ideapad-330S>
 <20190109183836.GI10405@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109183836.GI10405@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 06:38:36PM +0000, Mark Brown wrote:
> On Wed, Jan 09, 2019 at 10:41:21PM +0530, b-ak wrote:
> > SND_SOC_DAPM_MICBIAS is deprecated, replace it with SND_SOC_DAPM_SUPPLY.
> > 
> > MICBIAS voltage wasn't supplied to the microphone with the older
> > SND_SOC_DAPM_MICBIAS widget, hence the microphone wouldn't work.
> > 
> > This patch fixes the problem.
> 
> Note that the reason we've not done that already for everything is that
> the DAPM graph needs updating for the new routing in machine drivers as
> the two widgets are wired differently.  However this is fine here as
> there aren't any in tree users I can see so I'll apply, thanks!

Hello Mark,

Thank you so much for that.

And can you please point me to some documentation of the new updates talking about the
differences in the routing?

- Bhargav

