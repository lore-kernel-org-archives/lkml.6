Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17134C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C407421076
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZ4h3Qos"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C407421076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965030AbeFYTua (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 15:50:30 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37879 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964981AbeFYTu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 15:50:28 -0400
Received: by mail-wm0-f67.google.com with SMTP id r125-v6so11259411wmg.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 12:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ekBfIAOWDHXm5e1aQvPJ190ydTFHhhSOypixLtEoA+c=;
        b=JZ4h3Qos2mfWhJcxbVqhccAVHw3fNraLEhN+0SiuugdHLeYUJBvZp8BJNGULnHfEAj
         wDUzAP9C2r7M54HX6EZeMncLpjmY4Fh3bfh5Cs9ZOo1t0TF7QtpmXtD1gR9NFrPa2NT+
         jr8ZIhPAvU+Xe9GxVeHxBfw6lDUAfdJO4Up6s6mUHi1crEdTQ3pEnyPxYIW2to3tSQB8
         W6MGIlu11G+6aS50GdLbrYfrD/9FjSCgXQ3aFmAurLm0yA/1bpYeIz27WLabqO/zYkig
         nW4+C3wYeAoK8cnW51Hs23mBuxJVJpS4Rn2oOOFr59wOZSjMnXesYehtUyBOcO/4/jgt
         Laiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ekBfIAOWDHXm5e1aQvPJ190ydTFHhhSOypixLtEoA+c=;
        b=AS5KMb4H4C1bwfI9ESCxY4rxP5ly0LqDvRpgXrbtAsZoqUUYF6+fTZHMbJctmEzJ6X
         ENunaiEBYL3ymz+ziPAQbZQqLpL9WMxEcRlo+bV+W1+9rKGWBGjO5ioCQA9fvq2zV8Qo
         GwkVWnCOichwG9ESrlLv5iTcU3cGvbjLG1WCOZNTWqR3z1RKzTJOZqvvLrngpMffufRE
         xVa/87aG0yPKcS3GuGgtzrotMrFKeqfitob4Boptoi5M17BzOXh0FgGCN3pz+i8/1clz
         yp6VaEuHna1dO9cbE8iAxXqqnZ/po7AcTQNfIPqDuVG/jOffW7rrlrDfFZPQKvIHGwrK
         48dA==
X-Gm-Message-State: APt69E3N1+GqDp2ojJYehFmACJEPA+vHr5oNxuiz0sgC/jMKwbHiavJN
        bergwUIG3e1wpozXrlAJhb4=
X-Google-Smtp-Source: ADUXVKIjvaIucvbv5BX3E2r8+MBictsEWOug8TCymjGldWIqB/e7Z+oGluBZQrpoFmhFXG8iCa7L5g==
X-Received: by 2002:a1c:c14d:: with SMTP id r74-v6mr1979954wmf.8.1529956227573;
        Mon, 25 Jun 2018 12:50:27 -0700 (PDT)
Received: from xux707-tw ([109.76.172.189])
        by smtp.gmail.com with ESMTPSA id r75-v6sm53557wmg.31.2018.06.25.12.50.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 12:50:26 -0700 (PDT)
Date:   Mon, 25 Jun 2018 20:50:26 +0100
From:   John Whitmore <arigead@gmail.com>
To:     Justin Skists <justin.skists@juzza.co.uk>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Whitmore <johnfwhitmore@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/8] staging: rtl8192u: User memset to initialize
 memory, instead of loop.
Message-ID: <20180625195025.xfbrlj7citq3qx6s@xux707-tw>
References: <20180624153454.27356-1-johnfwhitmore@gmail.com>
 <20180624153454.27356-4-johnfwhitmore@gmail.com>
 <CAHp75VegybTJJ8GruGORxB3NChgsEKN+kJF55UjU0OvP2svuQQ@mail.gmail.com>
 <20180625123559.pvjrpmbtk6z24uew@xux707-tw>
 <848175111.798938.1529931904819@email.1and1.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <848175111.798938.1529931904819@email.1and1.co.uk>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 02:05:04PM +0100, Justin Skists wrote:
> 
> > On 25 June 2018 at 13:36 John Whitmore <arigead@gmail.com> wrote:
> > 
> > 
> > On Mon, Jun 25, 2018 at 12:06:30PM +0300, Andy Shevchenko wrote:
> > > On Sun, Jun 24, 2018 at 6:34 PM, John Whitmore <johnfwhitmore@gmail.com> wrote:
> > > > Replaced memory initialising loop with memset, as suggested by Andy Shevchenko
> > > >
> > > 
> > > Suggested-by ?
> > >
> > 
> > Em, not sure how to respond, it certainly wasn't my idea. I was just making
> > coding style changes, badly. ;)
> 
> Suggested-by is a tag for patches, to give credit. For example:
> 
> https://elixir.bootlin.com/linux/v4.18-rc1/source/Documentation/process/submitting-patches.rst
> 
> See section "13) Using Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:"
> 
> Hope that helps,
> Justin.

Oops... that helps thank you. I have to re-read that document, it obvioiusly
didn't all sink in :(

thanks again.
