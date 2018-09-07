Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64AFC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF9C20861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fICs13b+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF9C20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbeIGMvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:51:17 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42713 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbeIGMvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:51:17 -0400
Received: by mail-ed1-f66.google.com with SMTP id l5so10898860edw.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 01:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GgNwtJo1vPC7U/PtvAGAwPdDMSa7hPG7vco+1yqUmCg=;
        b=fICs13b+/YAM+gKqXwS6mCw3gdV5+Wkq5HuHdPs9gnqLQGbinkXylWqJr2e3NjdVQ2
         CR9jjlHRVVVUMlNQ/IX0QakbNbUu+gAQ4opq2qdBAUilak/VmrjxGC40V6hqd4QjiLEs
         GvC0lDD5me+R7j3PjAkPJNYYdbTuYfCx0yDB+xJvOjxmqhtLQJdY0A8E/02jfnvW4cHZ
         CumgtFIhVztGk1fMQDULXkIKFMvd2sdAA79N+xMdHLopPEA72BSqRz5xgKNFDWQVhgPK
         jPrNg+hLGFk9Jq3TxeWm7bXC3kW5ZyV8pPrLroUCOzMq18zpSjh4+4TIWHnDrLWW8c2q
         ouyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GgNwtJo1vPC7U/PtvAGAwPdDMSa7hPG7vco+1yqUmCg=;
        b=UEl7jz/vnukJ3DBjvkk5aXE42i7IXVFP5kQYs1dE42W8yN5QqvMod0hQrxOpUfOyKg
         6FOVSz5rDYKDvxi7It1aW9QkxXp5M9a02/+j9mOes+v4pXl2w+jxDL78EyNlTw3+kXPL
         xK4cC1UC/RusrZKpAo6Rmc01gfnbIRIY95KlMQpcQGScHkUFike7PhGbogSZ2hRav5NW
         gaoG8Zs5h4uBUHWMUrMrRmGmfXgAwRHjHJuAX5V7rqoupiEDNlBwUG0HwcCDp2RNPB43
         pyFO3tzEanf0vdHjJap1E9iaQLVfzSqpTqD1mCAtU/s/185UpI2pU66mYeKJegESbnxw
         wveg==
X-Gm-Message-State: APzg51CUvKnHZZdlt4r7MKcYA+cLigJ2lEJ8B4r0YGJUK7/PMg5nHzJP
        iqfabZhxBxcH5aMoicDaVWW++95d
X-Google-Smtp-Source: ANB0VdY3BvQueOeRK4WRqGICsnk0YUnIEQNrK8VmrhiyXzYpWgebS08YoYBzkkR4/37JfT6QHDX9Mg==
X-Received: by 2002:aa7:d4d5:: with SMTP id t21-v6mr7705701edr.292.1536307888608;
        Fri, 07 Sep 2018 01:11:28 -0700 (PDT)
Received: from dell.be.48ers.dk (d51A5BC31.access.telenet.be. [81.165.188.49])
        by smtp.gmail.com with ESMTPSA id g4-v6sm4380010eda.86.2018.09.07.01.11.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 01:11:27 -0700 (PDT)
Received: from peko by dell.be.48ers.dk with local (Exim 4.89)
        (envelope-from <peter@korsgaard.com>)
        id 1fyBrO-0004bi-2J; Fri, 07 Sep 2018 10:11:22 +0200
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Joe Perches <joe@perches.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ttyprintk: make the printk log level configurable
References: <20180821172822.30975-1-peter@korsgaard.com>
        <CACXmViaj6XWUXmdFov_1-exCd5idDx2s-2_kfmDFydN75wUNNQ@mail.gmail.com>
        <bc10850410b2c58c2bfbfa4f412403db7c82b535.camel@perches.com>
Date:   Fri, 07 Sep 2018 10:11:22 +0200
In-Reply-To: <bc10850410b2c58c2bfbfa4f412403db7c82b535.camel@perches.com> (Joe
        Perches's message of "Fri, 07 Sep 2018 01:03:12 -0700")
Message-ID: <87zhwt682d.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Joe" == Joe Perches <joe@perches.com> writes:

 > On Fri, 2018-09-07 at 09:50 +0200, Peter Korsgaard wrote:
 >> On Tue, Aug 21, 2018 at 7:28 PM Peter Korsgaard <peter@korsgaard.com> wrote:
 >> > 
 >> > For some use cases it is handy to use a different printk log level than the
 >> > default (info) for the messages written to ttyprintk, so add a Kconfig
 >> > option similar to what we have for default console loglevel.
 >> 
 >> Ping? Feedback, comments?

 > I think it is moving "[U]" into TPK_LEVEL is an
 > unnecessary and a tad obfuscating change.

It is arguably part of the prefix, but OK - I have no problem leaving it
in the printk line.

 > This also adds a leading space for unknown reasons
 > after the KERN_SOH <level>.

True. I'll fix that and send a v2 - Thanks.

 >> > diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
 >> > index ce277ee0a28a..14a7f023f20b 100644
 >> > --- a/drivers/char/Kconfig
 >> > +++ b/drivers/char/Kconfig
 >> > @@ -66,6 +66,14 @@ config TTY_PRINTK
 >> > 
 >> >           If unsure, say N.
 >> > 
 >> > +config TTY_PRINTK_LEVEL
 >> > +       depends on TTY_PRINTK
 >> > +       int "ttyprintk log level (1-7)"
 >> > +       range 1 7
 >> > +       default "6"
 >> > +       help
 >> > +         Printk log level to use for ttyprintk messages.
 >> > +
 >> >  config PRINTER
 >> >         tristate "Parallel printer support"
 >> >         depends on PARPORT
 >> > diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
 >> > index 67549ce88cc9..22fbd483b5dc 100644
 >> > --- a/drivers/char/ttyprintk.c
 >> > +++ b/drivers/char/ttyprintk.c
 >> > @@ -37,6 +37,8 @@ static struct ttyprintk_port tpk_port;
 >> >   */
 >> >  #define TPK_STR_SIZE 508 /* should be bigger then max expected line length */
 >> >  #define TPK_MAX_ROOM 4096 /* we could assume 4K for instance */
 >> > +#define TPK_PREFIX KERN_SOH __stringify(CONFIG_TTY_PRINTK_LEVEL) " [U]"

 > I think this should be

 > #define TPK_PREFIX KERN_SOH __stringify(CONFIG_TTY_PRINTK_LEVEL)

 >> > +
 >> >  static int tpk_curr;
 >> > 
 >> >  static char tpk_buffer[TPK_STR_SIZE + 4];
 >> > @@ -45,7 +47,7 @@ static void tpk_flush(void)
 >> >  {
 >> >         if (tpk_curr > 0) {
 >> >                 tpk_buffer[tpk_curr] = '\0';
 >> > -               pr_info("[U] %s\n", tpk_buffer);
 >> > +               printk(TPK_PREFIX " %s\n", tpk_buffer);

 > and this

 > 		printk(TPK_PREFIX "[U] %s\n", tpk_buffer);

 >> >                 tpk_curr = 0;
 >> >         }
 >> >  }
 >> > --
 >> > 2.11.0
 >> > 
 >> 
 >> 

-- 
Bye, Peter Korsgaard
