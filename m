Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF75CECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF1D206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="BRI1sB6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF1D206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbeIQVqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:46:38 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33070 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeIQVqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:46:38 -0400
Received: by mail-pl1-f196.google.com with SMTP id b97-v6so2449251plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 09:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rKwDFds+R815fgVqk6dVVU7OfH0OEI9W7bz4sjFkD0A=;
        b=BRI1sB6remy0nxSsQxTpYOTXoJMPjt8JjaMpj1LG8A8AwUik+A2u/ZPhuKZeyZ98c7
         HmOy4AQCRxQWfdiMp8kSmgl3fZfv4BmYESL07UhAXuI1Xg+ctUjmWlkSlnfyVC4tZRus
         yMdK6TS9Msgv9dMUcMEOuibrnbElntUgYxOXRs2jVgUB6dRJ/jV/STvJaG0UMtrQhL7O
         mYlLGhn+27c59enHGz7Wfswck5P84cZIZxq3k000ganuNB4oO3WcSMnNH89d1yKbOxNl
         5Z2OfkuqlZWcGC6QM0vd9zwtkYjNWXpB284eOmABLAdjNdu45+sAA5etqaaHPDxbA76F
         lmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rKwDFds+R815fgVqk6dVVU7OfH0OEI9W7bz4sjFkD0A=;
        b=joRMKyvA2ewQLxsf7QtpZRluIHlC+FbHawtM9/UWLPttOgEjhR5Xf2FLYGQAV38KGx
         HrItn3Jj0Vh/5q6VSD3ziRhW8tZe1v2v8DmSNmVEiLTj3pAWYhHjAML972Fme4n/MdRN
         y8wzdiOap8bug+yIAHyEQO9k7c3In8gFkv0mDe0we7LGZNE90z5URZKRpfVQjWHIt52t
         MaHB0YxhtC+U6Tu6K/UHSbS7/2T4ZK0BvSxFTHvK+Ut85nXv506FvZBqGB9ooPiyKJTt
         PzXlkdC+D1X2TQptNSTao0L3xUAaZwvNqiBXULiGOXOAuJNMyYgNcqtf3yyKarXuOHrL
         0bKQ==
X-Gm-Message-State: APzg51CdTZTUjuOyCPCT/1YvPQAD7L+oLQySWyBtVXKZToBseOdP6t6v
        OF7/Md65C0SCcKvHeCdN7qDA+A==
X-Google-Smtp-Source: ANB0VdY3aTxJCJYcD00QceFd2mq0nlBLqUigO4dGUcgzVcu8SUkduQwS7GrbVfIW36nqANk5ZwBxvA==
X-Received: by 2002:a17:902:714f:: with SMTP id u15-v6mr26068218plm.154.1537201114700;
        Mon, 17 Sep 2018 09:18:34 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:a154:73d6:9f8f:3ad? ([2601:646:c200:7429:a154:73d6:9f8f:3ad])
        by smtp.gmail.com with ESMTPSA id j5-v6sm19210400pff.139.2018.09.17.09.18.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 09:18:33 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <CAHmME9o+Q25t8c2Yk5_5ob2yJsu=7OA7WeAM71S5krP8KMY5GQ@mail.gmail.com>
Date:   Mon, 17 Sep 2018 09:18:32 -0700
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Lutomirski <luto@kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Biggers <ebiggers@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <63AAE78E-25D7-46E7-84AB-5D0DFD0F1BF2@amacapital.net>
References: <20180911214737.GA81235@gmail.com> <CAHmME9rFUruF-VN1pmU-k5nFsb9ppAPhPpW-5Ho9dKL2HCg4kA@mail.gmail.com> <20180911233015.GD11474@lunn.ch> <20180911.165739.2032677219588723041.davem@davemloft.net> <CALCETrXrJPcs3h9CtF50N4k2AGx3qzspJd_UW3t+KGYOj7+p=Q@mail.gmail.com> <CAKv+Gu8QgRo-Oex2Sk5unET3FMq+1Cp2btAWXCB8xsALxjatHg@mail.gmail.com> <35BC21D7-01F4-4F91-A7E9-8D15DE5B95D6@amacapital.net> <CAHmME9o2sB-rQo0DRh56AFe7ZLJJh+CU6Z1m5XZ4tA8vATCy1g@mail.gmail.com> <CALCETrWHWZibRev=hZeE1_YFjktnpV9VBN_QmvHJfakb-saRuA@mail.gmail.com> <CAHmME9o+Q25t8c2Yk5_5ob2yJsu=7OA7WeAM71S5krP8KMY5GQ@mail.gmail.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 17, 2018, at 9:16 AM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>=20
>> On Mon, Sep 17, 2018 at 6:14 PM Andy Lutomirski <luto@amacapital.net> wro=
te:
>> Indeed.  What I'm saying is that you shouldn't refactor it this way
>> because it will be slow.  I agree it would be conceptually nice to be
>> able to blacklist a chacha20_x86_64 module to disable the asm, but I
>> think it would be very hard to get good performance.
>=20
> I hadn't understood your nosimd=3D1 command line suggestion the first
> time through, but now I see what you were after. This would be really
> easy to add. And I can do it for v5 if you want. But I'm kind of loath
> to add too much stuff to the initial patchset. Do you think this is an
> important feature to have for it? Or should I leave it for later?

I think it=E2=80=99s fine for later. It=E2=80=99s potentially useful for ben=
chmarking and debugging.=
