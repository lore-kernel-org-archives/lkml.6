Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC09C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578BC2081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhLOBqSC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 578BC2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389588AbeKGC2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:28:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50649 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389285AbeKGC2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:28:01 -0500
Received: by mail-wm1-f68.google.com with SMTP id 124-v6so6865286wmw.0;
        Tue, 06 Nov 2018 09:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hfJ6QIJupzekRvQJ72ZqwnVWIkHvsfeyPLJ48CzcU6g=;
        b=ZhLOBqSCmrMk0mE+9Q0UsbYDU0xCfVb/aInZBfH/eKUHINytxCSveJK5JOAahYowIU
         2Bw+GCU0/sfVlO7/JxdnjwwZaHd9ASYQ9/8CoKo07R35W3CM8Ps+chFE446d3yF5AU1B
         wHiXLvS0z4JzlGc5niyjSbuGd9KlmbkSSXRpMvTrOzR7OhU5yQ5mi98UTB6SpIvIRFwz
         ylRFJ1hWpQtqbFcBczj+NnjeZWpuVJw8WzpvadMG0bxn3NQ604Q9ynqYs1RXMbE6tbU7
         UnGo6Ek5euK0Iipj1ZWloS3PARRa7AAZg4ZpXdB9ndrgEviyjhOzBqtRoG8dLM7om2Df
         HnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hfJ6QIJupzekRvQJ72ZqwnVWIkHvsfeyPLJ48CzcU6g=;
        b=BnicJFJURZwr/o42l3yG8X8oaj1dfLwgw1XdlokJPDfkks6xxJVjXh2kW2aDwN4tKY
         wY+miLLMEitSEOwwSDNHrRzVPWgQFWJX/JzAcZxg7EgTx9QEB6aQGPmMZz0fX42crV36
         s3O8QmZ+dpqpnWGYzPRUeKt5VoN3dAT9tbWmDIHYE4QvKepSoawoFa53qYPQ65DAkccJ
         WuH7Jz7dY+Kzd1ehRsD0YT6YRoOeLtsqq3qUa2c9e2rbvQmvAwpvtpEL24ZMw2xWrS+u
         0tYv5XQ+Ay1LGyngyK0D82aI+TTVOPxtNsONm7/t0vYfFwmx4n/t5yTMuXKhd218GVIR
         omYg==
X-Gm-Message-State: AGRZ1gIasE1OLIP+0slVaTsvI0Czofw9IhtQiHO4YgeyBdNskol/0CT2
        lY/8g7sMcjclXJvUqtLayA==
X-Google-Smtp-Source: AJdET5fiHRXkYEHoygI7nASd2LSqVny8pTu1J08HstybKOIVjD4xBH9DzMKsUIYV8z4CGkeL9de09Q==
X-Received: by 2002:a1c:8015:: with SMTP id b21-v6mr2776053wmd.60.1541523712012;
        Tue, 06 Nov 2018 09:01:52 -0800 (PST)
Received: from avx2 (nat5-minsk-pool-46-53-217-92.telecom.by. [46.53.217.92])
        by smtp.gmail.com with ESMTPSA id n7-v6sm16908575wrt.60.2018.11.06.09.01.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 09:01:51 -0800 (PST)
Date:   Tue, 6 Nov 2018 20:01:49 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        linux-arch@vger.kernel.org
Subject: Re: + fls-change-parameter-to-unsigned-int.patch added to -mm tree
Message-ID: <20181106170149.GA12947@avx2>
References: <20181105233301.KlgdF%akpm@linux-foundation.org>
 <20181106151444.GA11221@avx2>
 <20181106154437.GF3074@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181106154437.GF3074@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 07:44:37AM -0800, Matthew Wilcox wrote:
> On Tue, Nov 06, 2018 at 06:14:44PM +0300, Alexey Dobriyan wrote:
> > On Mon, Nov 05, 2018 at 03:33:01PM -0800, akpm@linux-foundation.org wrote:
> > 
> > > -static inline int fls(int x)
> > > +static inline int fls(unsigned int x)
> > >  {
> > > -	return fls64((unsigned int) x);
> > > +	return fls64(x);
> > >  }
> > 
> > Should it return "unsigned"? Logically it should.
> > I remember doing this and there was some code size increase :-(
> 
> Yes, it returns a number in the range [0-32], so it can absolutely
> be unsigned.  I'm kind of surprised it made any difference.
> 
> When you say "doing this", what did you try?  unsigned fls(unsigned),
> int fls(unsigned) or unsigned fls(int) ?

I did "unsigned fls()" with and without

	if (rv > 32)
		__builtin_unreachable();

but I didn't send anything because there was something erratic with code
generation.
