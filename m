Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2829FC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11EB217B4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iTpPgZrX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11EB217B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbeHMTpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 15:45:41 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:48769 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729029AbeHMTpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 15:45:41 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 335be67d;
        Mon, 13 Aug 2018 16:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :in-reply-to:references:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=OuB3aLv7uwiV4HV3KpoGgZgMBQU=; b=iTpPgZ
        rXaJhxrBk+AGJV6nmuCIhwQX7EJGUmqpOeg8oYHcPz8aucnZM96DtgmQLSbjSEjs
        auTAX9ovK3qYhj93IiqEfki/QhU2LtmYm0f3Qgzn0RB5Apj+e3qYhZ+F/0DhmsmK
        aN/lPW7DMQ6FcuF1gVLBg9cQuU+h0X5wdarbinKsVMsHHA6Cca1Rz8GEexlyN7MD
        UR8WOCOgD+usjDhuzau8kpwYMfQdwlJgKZPngKcP6W/St64wRfYcePY6y7oOKv9a
        jD/0jLnqsSFqhjmWzGr26K7ET+qbHKev1I10BCcVffaeiqH4AqyV0TelVBio1A13
        5U94mo7jY9dqTOXg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0efba98b (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Mon, 13 Aug 2018 16:49:34 +0000 (UTC)
Received: by mail-oi0-f53.google.com with SMTP id j205-v6so28536189oib.4;
        Mon, 13 Aug 2018 10:02:34 -0700 (PDT)
X-Gm-Message-State: AOUpUlFcHSL61B5K5N3QBbBUqE542ux265VpKbwQIvuzK9F3HZ2QmCzl
        SYOVTYt5kzzgVBWWT262ylG7jywKyMShGxtrlLk=
X-Google-Smtp-Source: AA+uWPz2Vzf/YLzaL/Jm6WeYsudnxrLZhIn/ppsryIXHmmhxv8Z+XwwW3V8fjfj0YmoitnVrizwddX8kGStXoT4HYqY=
X-Received: by 2002:aca:bec2:: with SMTP id o185-v6mr19801656oif.22.1534179753641;
 Mon, 13 Aug 2018 10:02:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:a025:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 10:02:32
 -0700 (PDT)
In-Reply-To: <1534174811.7872.3.camel@HansenPartnership.com>
References: <20180731191102.2434-1-Jason@zx2c4.com> <1534174811.7872.3.camel@HansenPartnership.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 13 Aug 2018 10:02:32 -0700
X-Gmail-Original-Message-ID: <CAHmME9raa81A_hH_Zykp2r8zOk0ySroFEsk+8384vnVOCuSa=g@mail.gmail.com>
Message-ID: <CAHmME9raa81A_hH_Zykp2r8zOk0ySroFEsk+8384vnVOCuSa=g@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] WireGuard: Secure Network Tunnel
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 8/13/18, James Bottomley <James.Bottomley@hansenpartnership.com> wrote:
>> Ample information, including documentation, installation
>> instructions,
>> and project details, is available at:
>>
>>   * https://www.wireguard.com/
>>   * https://www.wireguard.com/papers/wireguard.pdf
>
> In your paper you say this:
>
>> Finally, WireGuard is cryptographically opinionated. It intentionally
>> lacks cipher and protocol agility. If
>> holes are found in the underlying primitives, all endpoints will be
>> required to update.
>
> The only thing that's certain (beyond death and taxes) is that your
> crypto choice will one day need updating; either in response to an
> urgent CVE because an algorithm is compromised or in response to a less
> urgent one because it is deprecated.  Assuming wireguard is reasonably
> successful we'll have a large ecosystem dependent on it.  On this day,
> we're going to have the choice of either breaking the entire ecosystem
> by rolling out a change that can't connect to lower protocol versions
> or trying to wedge version agility into wireguard in a hurry.  The
> former is too awful to contemplate because of the almost universal
> ecosystem breakage it would cause and the latter is going to lead to
> additional bugs because people in a hurry aren't as careful as they
> should be.
>
> Could we please build planning for this crypto failure day into
> wireguard now rather than have to do it later?  It doesn't need to be
> full cipher agility, it just needs to be the ability to handle multiple
> protocol versions ... two should do it because that gives a template to
> follow (and test version to try to find bugs in the implementation).
> It looks like the protocol could simply be updated to put the version
> into one (or more) of the three reserved bytes in the handshake
> headers, so perhaps doing this before they get used for something else
> would be a good first step?
>
> James
>
>

Indeed the answer is in fact along the lines of what you've suggested
in your question: the protocol is very strictly versioned. This means
that while there intentionally isn't negotiation of ciphers --
something historically very bug-prone -- there is ample room for
updating the protocol. This is enabled via 4 aspects of the protocol:

- An explicit "identifier" string is hashed in as part of the first
step of cryptographic operations, containing a "v1" as well as the
protocol designer's email.
- An explicit "construction" string is hashed in as part of the first
step of cryptographic operations, containing the Noise handshake
pattern and a list of the cryptographic primitives used.
- A type field at the beginning of each message. Newer message types
(corresponding with newer versions) can easily be introduced via this
field, and they can even coexist with older ones need be.
- Three unused reserved fields ready to be utilised in the event they're needed.

In other words, there's ample room for such contingency measures
within the protocol.

Jason
