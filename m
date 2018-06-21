Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCF9C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5490E20837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4gZcyU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5490E20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933558AbeFUM0g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:26:36 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:40309 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933357AbeFUM0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:26:33 -0400
Received: by mail-wr0-f172.google.com with SMTP id g18-v6so2993277wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 05:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NgQoeCznyvGft9rmv2h4RqfvdwIYINUPogGDbSQRsB4=;
        b=U4gZcyU5xwsNyAQBpIALXDh8OELfmt5G+d4JNScLRFH35b2N0hpfn5fqmxsZuc+N7w
         VnbyU83LPpABoO/zu5rL3JF0ylQ5QX02/WOPLTMCnLBo5JsVtZeJa/Micc6Si/uBfm2v
         iYHgoy5FLSzNUVu+Xq+HDkYeEhANj6pO08ljNb1a/fL3SYRqxsJqMb+Fc70GIyqhqiLR
         1CDcFUGT6Eh8UZQxI51d7F2pZomIw7po06yO7mLWLmGoL7ga+3T8n/6i9rZ1lbsnTg7p
         xvdb4pZ1Haardw37FH+gxqR9EiKaFcH/TLwiY9ki/A1Jse8zf8KmaL5xGR2SaEC5o5v0
         ur4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NgQoeCznyvGft9rmv2h4RqfvdwIYINUPogGDbSQRsB4=;
        b=TfbuoIegXlssf34gu4DmMPfXckLlqzJ75TYGkm9dfSw2RyRf0c7ivzaLBPixPHUubP
         eVVRjoc14edTZ2NDRjiJi/MtOQ+/+VHxxt/e4Tf/KWE7LFxy6lj8RBn10aLkN00bUTXa
         dhIvJs6Zn57QjwwexX8kVZUA8TbuHXfzxE+zRojOGuhCRiOE20E31lSspRrHNNHxMZIX
         Ukx0EEivKCKLjelMC+5plw5TH9UY0BP85UPxQDbFNG9EGOVkegmMFBxlWBq3imUEw9nk
         8f4PpVQKLnLA1N8RXf1+XxvJBy7fSFHehLRQ7j8zA4PakOSqwsVSBjJcHftYSsCYXBgr
         QBCw==
X-Gm-Message-State: APt69E2qgi+ZfC/WPFLh/m4Bcy06g8CFC6fwEAXHBXs/2KJy/f/slSfD
        WL5BWRgvWFRWI6MSrKzHVXg=
X-Google-Smtp-Source: ADUXVKLEXBMsrZsU5eviQ+jA3iF6tYON9jnzzM80mLWvTQZiDft0ds/EMV9iEojNmuap7aB2aVVz/A==
X-Received: by 2002:adf:fd88:: with SMTP id d8-v6mr20304995wrr.276.1529583992859;
        Thu, 21 Jun 2018 05:26:32 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v138-v6sm7099315wmd.47.2018.06.21.05.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 05:26:32 -0700 (PDT)
Date:   Thu, 21 Jun 2018 14:26:30 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     will.deacon@arm.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv4 08/18] atomics/generic: define
 atomic64_fetch_add_unless()
Message-ID: <20180621122630.GA22578@gmail.com>
References: <20180621121321.4761-1-mark.rutland@arm.com>
 <20180621121321.4761-9-mark.rutland@arm.com>
 <20180621122103.7k2ozjyc64b4zdjc@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621122103.7k2ozjyc64b4zdjc@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark Rutland <mark.rutland@arm.com> wrote:

> On Thu, Jun 21, 2018 at 01:13:11PM +0100, Mark Rutland wrote:
> > -	if (v->counter != u) {
> > +	val = v->counter;
> > +	if (val != u)
> >  		v->counter += a;
> > -		ret = true;
> >  	}
> 
> Ugh, I thought I had fixed this up and removed the trailing brace.
> 
> This will break some 32-bit arches as-is.
> 
> Ingo, would you be hapyp to fix this up, or would you prefer that I fix
> and resend?

I fixed it up, no need to resend unless I find other problems in testing.

> Sorry about this.

No problem!

Thanks,

	Ingo
