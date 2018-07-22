Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D95C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 17:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FC120671
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 17:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdBZTlUx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8FC120671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbeGVSNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 14:13:53 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45509 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730078AbeGVSNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 14:13:53 -0400
Received: by mail-pl0-f68.google.com with SMTP id 94-v6so7221102ple.12
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 10:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vbl8XJcNv+LNha7rsoKG3X3W5cyUW2JS1HnF+XGvjII=;
        b=fdBZTlUxCsPnNMziJTF+Kr8a5Gn/z/8I+tv5UOnS2yeGahSmUtd8yqLwhXPBM3Zjl5
         RQsJBmTwdwBy/gsUHopFlA+Gdtzt5EU4xbedNuEpRUEjl4r0v6FgbFanyF/ZMnWbgrtr
         GF6sZqsVwOyQsDOFNp8x+ckcMjFmaeif635qihFh1TUYthoFF1I96/wNTnE8bR+ogVDL
         lRBWnYURxVOMPxQ6tV44N4DABd1NBYENxvkMUijRA9vsC5h46PMx8GqC1trphDeQQOzC
         l85L2C0503fMoohDPmJxKwii5KYbO6fqOC1LKWk4VQLuKTHDj8Otv88W5C7ccGWTso3W
         VT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vbl8XJcNv+LNha7rsoKG3X3W5cyUW2JS1HnF+XGvjII=;
        b=IjdbSRTFUty77ZcCZkSsP5TJCuWYPc9aAWT34QzER5fNGXbzCbhKl5/2Evbzre9USg
         kXSf5Ko03f72VsuCkDuz2liMwwNPoNP4BdoWvZBnireNSVjRW1fg/1AJFpAwr39mqsJb
         iQUSUiSb18U5SGprEDmjIqFJhP0F5QeIscBtGKlUx1NARqGrvL4b9YyNx8c2qINCbPKC
         xA5nlgih5qqr9zrLvJBSfISVXUiQ2hJiDAn4TGDcNcRxcx1ZDlqeMiwek+aGO0iq28oV
         VYAS/tFlZwMKQClctQXGvUbMhByZmMmA86kNpnFFpZEwD7BsDtlnQLHW6LbJ5yNGxb8p
         h9Cw==
X-Gm-Message-State: AOUpUlFR/5sPDdGthp+Ktx8gfXSazEp+1WDwHdYmAm8Q+/eAEeURAPRt
        NbJmWnfxkyNtn2tW00mkrU0=
X-Google-Smtp-Source: AAOMgpdll5woct3Of8kp3wX9iWEzz3QE5ZaZchktx1NU4EQ3VS5wdM3U+HPah+mLgw8ZZixyNUbaTg==
X-Received: by 2002:a17:902:28a6:: with SMTP id f35-v6mr9770542plb.110.1532279791459;
        Sun, 22 Jul 2018 10:16:31 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id 16-v6sm10468913pfp.6.2018.07.22.10.16.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Jul 2018 10:16:30 -0700 (PDT)
Date:   Sun, 22 Jul 2018 22:46:24 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Joe Perches <joe@perches.com>,
        Lidza Louina <lidza.louina@gmail.com>,
        Mark Hounschell <markh@compro.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     driverdev-devel@linuxdriverproject.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: dgnc: dgnc_tty.c: Avoid '(' at the end of line
Message-ID: <20180722171620.GA20134@nishad>
References: <20180722040912.GA18833@nishad>
 <f512941f3dba2b5f3bf3434bb2b0b4b1602c5122.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f512941f3dba2b5f3bf3434bb2b0b4b1602c5122.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 22, 2018 at 12:50:25AM -0700, Joe Perches wrote:
> On Sun, 2018-07-22 at 09:39 +0530, Nishad Kamdar wrote:
> > Bring the first argument to the previous line and
> > align the other lines to match open parenthesis.
> []
> > diff --git a/drivers/staging/dgnc/dgnc_tty.c b/drivers/staging/dgnc/dgnc_tty.c
> []
> > @@ -883,10 +883,9 @@ static int dgnc_tty_open(struct tty_struct *tty, struct file *file)
> >  	 * touched safely, the close routine will signal the
> >  	 * ch_flags_wait to wake us back up.
> >  	 */
> > -	rc = wait_event_interruptible(
> > -				ch->ch_flags_wait,
> > -				(((ch->ch_tun.un_flags |
> > -				ch->ch_pun.un_flags) & UN_CLOSING) == 0));
> > +	rc = wait_event_interruptible(ch->ch_flags_wait,
> > +				      (((ch->ch_tun.un_flags |
> > +				      ch->ch_pun.un_flags) & UN_CLOSING) == 0));
> 
> 
> This would be better without the superfluous () and perhaps use !
> 
> 	rc = wait_event_interruptible(ch->ch_flags_wait,
> 				      !((ch->ch_tun.un_flags |
> 					 ch->ch_pun.un_flags) & UN_CLOSING));
> 
> 

Ok, I will revise the patch.
Thanks for the review.

regards,
nishad kamdar
