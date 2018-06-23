Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9464C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 16:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F3224C90
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 16:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Uk2hZbEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F3224C90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751877AbeFWQxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 12:53:44 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38716 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751708AbeFWQxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 12:53:43 -0400
Received: by mail-pg0-f67.google.com with SMTP id c9-v6so4280776pgf.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jun 2018 09:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=5f5KKfC8SwRaze6xNnJdyaqDQNYUVd/rjwqeeEZApDs=;
        b=Uk2hZbEvWoMlkSg8QGcs5lDiqTQW8y/9sz46rcyaIOyDNDy8RGelHIofhpBbOCuyGl
         g++DrgdZA/DIb7JwcMhWIXjBHkuixBjulTRJFYsTgZgurH1kISRpakYuW7kF7FRWYyTZ
         VUC4zTv8IU2eGw5dOwkRotQiRBwh3wFBQJId1YvSVKHKEqP+wBl3t4t+Q3rOho9guWBx
         iRNj8WIDnPkzpWWBiKYfapuJLDY32Ugv14M40X59qC++/EpyEsN2ylEBZ23aBPYWSeG9
         8tWBR1XKerIN+FNPobe45e9KYqiOpI0QadDED/92NxEAnv7f3oyAXRplbKZT0sFFN+Kr
         60pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=5f5KKfC8SwRaze6xNnJdyaqDQNYUVd/rjwqeeEZApDs=;
        b=uA/sUkgHp7cy01tDY1tp97OZj6QjvIgdzJFBFBbwwKIaFm0iCkAqeND76pktDidJFf
         vlaSEHhRVWEHwZqEQl/gZ7c31zYMWqqbzfN12yM0JmpgnV1GJeCcl4gVw6FBhy9Kv5sG
         luo2SaGJuSwJZaLiiKi87MREpKRJCLClXDPpHj2VLcb5+pkbL0cNJZBRhv/GhbYaDRSC
         gGabiJZnrWmjjABRXljQYcjMWOV5hyhpnV0VcnLD26M4EPTqwjznAyzmXvgKI1xLOuuF
         SfUY/bAg8E+Nq5FstvQhieLh9jBoS4h0EmqAxB7sGzqKHSPI1bBK/PqLY/nK4wYkXQyO
         YM+w==
X-Gm-Message-State: APt69E2HK5ThYtCKb58nqvf5J3UKjhzJJ4HLjaRGxsqC6jAFuYELArMc
        0fXvohNuyc77eh5nvPCnvfFqaQ==
X-Google-Smtp-Source: ADUXVKLoiIPaw3jIw0t+KTgkQgCAKv3fl/jFTnjxbMCTVl+GA7BVZi2CHWAC7gfCrQU/HmGz22mtXQ==
X-Received: by 2002:a62:8a83:: with SMTP id o3-v6mr6560935pfk.12.1529772822333;
        Sat, 23 Jun 2018 09:53:42 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id s19-v6sm26734624pfe.97.2018.06.23.09.53.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jun 2018 09:53:41 -0700 (PDT)
Date:   Sat, 23 Jun 2018 09:53:41 -0700 (PDT)
X-Google-Original-Date: Sat, 23 Jun 2018 09:51:14 PDT (-0700)
Subject:     Re: [PATCH] MAINTAINERS: Add Daniel Lustig as a LKMM reviewer
In-Reply-To: <20180623164645.GB3593@linux.vnet.ibm.com>
CC:     andrea.parri@amarulasolutions.com,
        Daniel Lustig <dlustig@nvidia.com>, stern@rowland.harvard.edu,
        Will Deacon <will.deacon@arm.com>, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        akpm@linux-foundation.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     paulmck@linux.vnet.ibm.com
Message-ID: <mhng-ab979604-6177-4acf-802a-c615f7c5afc7@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jun 2018 09:46:45 PDT (-0700), paulmck@linux.vnet.ibm.com wrote:
> On Sat, Jun 23, 2018 at 03:10:17AM +0200, Andrea Parri wrote:
>> > > Thanks.  Unless anyone has any opposition I'll submit the fixed
>> > > patch as part of my next pull request.
>> >
>> > Works for me, especially if this means that Daniel is RISC-V's official
>> > representative.  ;-)
>>
>> I'd rather the "fixed patch" go through the LKMM's tree.  If not for
>> other, we tend to use get_maintainer.pl on your (TBD ;/) development
>> branch...
>
> True, but that is only an issue for a few weeks until it goes upstream.
>
> I am OK either way.

I'm happy to have the patch go through the LKMM tree.  The fixed patch is here

https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/patch/?id=778c83c0bf1e1dcc6054c40945ed05b42b71c97c

>
> 							Thanx, Paul
>
>> > Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>> >
>> > > commit 9d01337e4724be4d34bfe848a7c64d14bfdb89ea
>> > > gpg: Signature made Fri 22 Jun 2018 03:35:24 PM PDT
>> > > gpg:                using RSA key 00CE76D1834960DFCE886DF8EF4CA1502CCBAB41
>> > > gpg:                issuer "palmer@dabbelt.com"
>> > > gpg: Good signature from "Palmer Dabbelt <palmer@dabbelt.com>" [ultimate]
>> > > gpg:                 aka "Palmer Dabbelt <palmer@sifive.com>" [ultimate]
>> > > Author: Palmer Dabbelt <palmer@sifive.com>
>> > > Date:   Fri Jun 22 14:04:42 2018 -0700
>> > >
>> > >    MAINTAINERS: Add Daniel Lustig as a LKMM reviewer
>>
>> Nit: an LKMM
>>
>>
>> > >
>> > >    Dan runs the RISC-V memory model working group.  I've been forwarding
>> > >    him LKMM emails that end up in my inbox, but I'm far from an expert in
>> > >    this stuff.  He requested to be added as a reviewer, which seem sane to
>>
>> Nit: which seems
>>
>>
>> > >    me as it'll take a human out of the loop.
>> > >
>> > >    CC: Daniel Lustig <dlustig@nvidia.com>
>> > >    Acked-by: Daniel Lustig <dlustig@nvidia.com>
>> > >    Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>>
>> Glad to read this!  Please feel free to add:
>>
>> Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>
>>
>>   Andrea
>>
>>
>> > >
>> > > diff --git a/MAINTAINERS b/MAINTAINERS
>> > > index 9d5eeff51b5f..ac8ed55dbe9b 100644
>> > > --- a/MAINTAINERS
>> > > +++ b/MAINTAINERS
>> > > @@ -8316,6 +8316,7 @@ M:	Jade Alglave <j.alglave@ucl.ac.uk>
>> > > M:	Luc Maranget <luc.maranget@inria.fr>
>> > > M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
>> > > R:	Akira Yokosawa <akiyks@gmail.com>
>> > > +R:	Daniel Lustig <dlustig@nvidia.com>
>> > > L:	linux-kernel@vger.kernel.org
>> > > S:	Supported
>> > > T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>>
