Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3C9ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 19:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238C3208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 19:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="fhOquIgq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238C3208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeIPBSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 21:18:34 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38840 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbeIPBSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 21:18:33 -0400
Received: by mail-pl1-f195.google.com with SMTP id u11-v6so5656014plq.5
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 12:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Hz1gf38z/x7qPN6bSE11FNVRsPuUS609D7FsSWqoOTI=;
        b=fhOquIgqyIx6Cmkc6QKltR0TvUMQZiiLxU+vSNzU84e7hcyuLgPo/yWeqMGJ7Eh7zc
         U4LtSM+C4aQWEMKXh8Ljehl6RqaC9HbkUtXggfuDY5Wpad3TjdlXKss0SxUSuKtLlgDe
         cSd/32nkwjNdiOfWdMDVWdaKuZ7Nf6ATkG510iAjsp7vCPkGRAQxtt8Q0hqXKjILB8dP
         4JyqxwfVhPZnibtZG4MGjjuoBDMuD32NsOmqBMIW2StJnrj6ziGut90rikHQNDK7bXMv
         a2TnGbwfCyRi78uunE3Zf5XbvVIilIqB4hh/vyuDotvqBDxaPUtUkSCvLTA9NNfZcpHN
         LcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Hz1gf38z/x7qPN6bSE11FNVRsPuUS609D7FsSWqoOTI=;
        b=tkc0Ngltu/lBbAg2iu8hXvxgvkc+SPR+g48XCBRr3Uutv/QsjFo/z43KVICuTQHBDj
         jzvGnh8XrSEXqr7fXEwvYw3VzyiKM2aNp9ZbS7hdkle5jsMRJdjcPe4FESpoL+xY8o5n
         kI2EZxwVSyLkEDCs4wc6PRY1FkblPf63FFGI9bmSduE320Ra12pFXQa901/3JFIz+fVn
         0rAd7G3yFkPCd8kpVHICwA/C9E2f4pwFc7X9es3WkaIDxsBEf+4I5Fkl3EPpZ10VfId1
         Y8ItUNYY6tEgsVdR8FTp1toCF03iPdpE6LnB9EqCRAXCtWIsvFdNzD59fodpCVz6DH/I
         5KfQ==
X-Gm-Message-State: APzg51BpYtoNGkmmngdyeFm3zxFyMcq6bG+WWCl5HwBwKPsuLyra4e/Q
        1i3X40B3ix2IZ/U6MDSJXA3FBA==
X-Google-Smtp-Source: ANB0VdZuaPWCwx31g8czGuvznmUSTp3UeJrQrvfj0gWV04H29+YlBL3VkwEzF3G7962NO4q9K9q8tg==
X-Received: by 2002:a17:902:8e86:: with SMTP id bg6-v6mr18009258plb.108.1537041504411;
        Sat, 15 Sep 2018 12:58:24 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:e00c:94b8:58e8:8ffb? ([2601:646:c200:7429:e00c:94b8:58e8:8ffb])
        by smtp.gmail.com with ESMTPSA id v19-v6sm15420019pgn.94.2018.09.15.12.58.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 12:58:22 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH net-next v3 01/17] asm: simd context helper API
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <CAHmME9rMg_2eHBnfP6j9Y3O7-At90HF=ToTWeFL_Qc4nGURORg@mail.gmail.com>
Date:   Sat, 15 Sep 2018 12:58:21 -0700
Cc:     kevin@guarana.org, Andrew Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <61B4DFD6-9BB5-4B81-BD0E-ACF112EA8AF7@amacapital.net>
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-2-Jason@zx2c4.com> <20180912061433.GA8484@ip-172-31-15-78> <CAHmME9pmgu_xWJ0rvdS4RhzwjKPiNdkQ9nc6mqTNeb6A8xT8Eg@mail.gmail.com> <20180913050301.GA26367@ip-172-31-15-78> <CAHmME9rMg_2eHBnfP6j9Y3O7-At90HF=ToTWeFL_Qc4nGURORg@mail.gmail.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sep 13, 2018, at 6:52 AM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>=20
>> On Thu, Sep 13, 2018 at 7:03 AM Kevin Easton <kevin@guarana.org> wrote:
>> Yes.  It's also how most get/put APIs already work in the kernel, eg
>> kref_get/put (mostly because they tend to be 'getting/putting' an
>> already-initialized object, though).
>=20
> Right; in this case the object wouldn't be initialized yet, which
> might defeat the purpose, since one advantage of the & way you
> mentioned is _put modifies the context.
>=20
> Andy - any opinions on this? The tl;dr is:
>=20
> 1) what we have now:
>=20
> simd_context_t simd_context =3D simd_get();
> for (item in items) {
>    do_something(item);
>    simd_context =3D simd_relax(simd_context);
> }
> simd_put();
>=20
> 2) what kevin is proposing:
>=20
> simd_context_t simd_context;
>=20
> simd_get(&simd_context);
> for (item in items) {
>    do_something(item);
>    simd_relax(&simd_context);
> }
> simd_put(&simd_context);
>=20
> I can see pros and cons of each approach.

I have no strong opinion, except that, if you paint the bikeshed =E2=80=9Cpa=
ss by value=E2=80=9D, then simd_get and simd_relax should probably have warn=
_unused_result set.=
