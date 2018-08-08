Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5BCC46471
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05041216FE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="T57Kiwak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05041216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbeHHEGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 00:06:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36564 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbeHHEGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 00:06:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id h12-v6so298848pgs.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 18:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YGvxTVfrSeb46NmnKlJgLm4BVn46Shy1X50G2+cffQI=;
        b=T57Kiwak2MkBpula0Ui/Rtc0iVDvt5O3jEBwbU2HAwAT1SdJIuuYNSEEkewKmycLwp
         xMCs373XsMmHG2MdZmMtt9GChwVEaCKYI+8g28YMciVvWMRKtIZpG0sMbTMR8ZPh1BYp
         83u3wavzn0jwWTH/a7V8qXTR6jlWKJiZ4oLTM1C6rtq9ciRj3DmncVQNHQxmIg5el5rd
         BKARabobaJYN8InxQ+qwiuZDzYSFtVfmIUFJMxpBljhSpKewpNK3/iHB2OPeBWlwVzBn
         7KKA3uUWlxQPI8DjQDyqMvCkMfljz7901jXoEoFV3UKRDJ0jmhU+b0wJqaTRbCpdbhkg
         7gWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YGvxTVfrSeb46NmnKlJgLm4BVn46Shy1X50G2+cffQI=;
        b=PP54BuYe6HdOmvcFvcAht/pf1HDORXZJJRBY0rJJSQVoxML4Sgff93u8R0WhMa9IIW
         DZkqZ//r6X15hnqllzBDFtpdk2umenHqz6j/oh4DHDhy/TBJvClPwQupLVPNmE1N1Lza
         omlHCkKMSKbYq4iLMueule3jAUBGfsOl/TVY19xQGUuje2DjQKwBcx1XEM9LDYeegSQi
         vcfvA2GFKQAxmvLypn1jXkELQ5qTsw3suEYw86+guCFeDf6SaDsfG80l/RWnp+yoh1nm
         WJ8Dpzm/G43Q2urPQp2doiy5ijCzpdJvodWo36vTT97DY6eUauUyVl7K22lP1C9xeZ/e
         NuEQ==
X-Gm-Message-State: AOUpUlEGIfO4PVH5mLPVxTXhzWUVuY2mUVzSF2ujZ7dga8MhXBNsOPIA
        LSSt+irMzT2XQuQvDsbMVAIGYA==
X-Google-Smtp-Source: AA+uWPw33ArNkUw0O5pLzApuiBaNFlqm8pY37DnxQK5L2r/PeLGn7LVziRtqYPlOPZXOQJZzgJsDFg==
X-Received: by 2002:a62:3856:: with SMTP id f83-v6mr783398pfa.48.1533692941303;
        Tue, 07 Aug 2018 18:49:01 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:6cb2:c0a0:8aa4:2e86? ([2601:646:c200:7429:6cb2:c0a0:8aa4:2e86])
        by smtp.gmail.com with ESMTPSA id h190-v6sm3463531pge.85.2018.08.07.18.48.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 18:48:59 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1 2/3] zinc: Introduce minimal cryptography library
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <CAHmME9qPay3O7Yh-R66EDhon4dJz1cuy69dWUxf3Xkt8seqLZA@mail.gmail.com>
Date:   Tue, 7 Aug 2018 18:48:59 -0700
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arch@vger.kernel.org, Eric Biggers <ebiggers3@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        "Daniel J . Bernstein" <djb@cr.yp.to>,
        Tanja Lange <tanja@hyperelliptic.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Karthikeyan Bhargavan <karthik.bhargavan@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A44CAA94-415C-476C-9523-2D19F28EDC6D@amacapital.net>
References: <20180801072246.GA15677@sol.localdomain> <CALCETrXD_VyoyW5C1U34o-ySJ4nFcO6PQ+ZNBVYxCpJ-f65CHw@mail.gmail.com> <CAHmME9oThR-dE3gTW0UyqAGZO80qu19ktG4YTb4iL6CNpzNNaw@mail.gmail.com> <CALCETrVziUpAU4nTaZ=t5ct=1jsWswWOy7KDNxXGPD1L=tMTGQ@mail.gmail.com> <CAHmME9pt3PxKQmc8E-arA-W0p2tp9z_oJ-uXQwis3qD=Zvpnsg@mail.gmail.com> <CAHmME9rA_nb9Le4VQhtcqCfNSuHpFjZVOV6=vE12FydJD9CmAQ@mail.gmail.com> <CALCETrWo-vCt_bHMBPAEHEr3P4=AJq-95Bf=00aAEAcE839wLw@mail.gmail.com> <CAHmME9qPay3O7Yh-R66EDhon4dJz1cuy69dWUxf3Xkt8seqLZA@mail.gmail.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 7, 2018, at 4:48 PM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>=20
> Hey Andy,
>=20
>> On Tue, Aug 7, 2018 at 12:43 PM Andy Lutomirski <luto@amacapital.net> wro=
te:
>> For "zinc: add simd helper", I think it should be in include/linux,
>> and include/linux/simd.h should (immediately or maybe in the future)
>> include <asm/simd.h> to pick up arch-specific stuff.  And the patch
>> should get sent to linux-arch@vger.kernel.org.
>=20
> I guess you saw my prompt about that in the previous commit message?
> Based on your encouragement, I implemented it:
> https://git.zx2c4.com/linux-dev/commit/?h=3Dsimd This is _far_ more
> invasive than I wanted to be, as I don't want this patch submission to
> grow unwieldy and never be merged, but I guess we can roll with this
> for now...
>=20

I really wish we had a way to see that we use asm-generic=E2=80=99s copy of a=
 header in all cases except where an arch opts out.

>> In your blake2s_arch() implementation, you're not passing in a
>> simd_context_t.  Is that still a work in progress?  I thought the plan
>> was to pass it in rather than doing the check in the _arch()
>> functions.
>=20
> I'm inclined to do the explicit context passing only when a function
> is likely to be used in that kind of environment, and adjust as
> needed. Long term, anyway, that API will be removed once the x86 guys
> figure out lazy FPU restoration and the amortization doesn't add
> anything.

Fair enough.

>=20
> Jason
