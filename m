Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32112C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17B020865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="g1usjAYK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17B020865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbeILECx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 00:02:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39025 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725740AbeILECw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 00:02:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id j8-v6so12947444pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 16:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YrSYa/2yjcAWd2Sa2WXRg1IT45FqYdZx2smgKFAAn+U=;
        b=g1usjAYKckwytxvPf7k+WplL8BDCFvRXfYdc95RvBz4ocYWJVFf8pruXWvgKwuq7E3
         mzDF2w9RD7OohLhEmTK2fM1++jOXKx5bhgOYyBgrBNh0LWANY4eRWYtf05G1A01gb7Ab
         e3eSa0NOb96EIClvwXs8znW6RjmndYFzzPn49bbDO7mHaKFm0szr++oHIc5c71hHsjJd
         MAiQ7NEPLyfC8zev9zihfos/9E2HzWU0o0KUbbyTzSd//y8T23mhS7nRdN61PXUiOxEV
         jkxPfq4bgcpeMQ1EOoQ+Gj/qXyr6uAhZqnoJYmXXONZmOPOC4jcGa4Mv8LYjnYNROgQG
         Q6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YrSYa/2yjcAWd2Sa2WXRg1IT45FqYdZx2smgKFAAn+U=;
        b=CckofcR10eLg1i9WGgztI6iGN0Mo10IOpYDM/yY5J8vGgrMnYu6jXmF+bPhyN/cTnB
         uBPyeGs2kc27xZgyiMuzpOk4FIMCvp3s3LlY5qvzfhiP9OfylEx7FSVUFwOtvH7WlhQe
         sGhaJN7G1OcJBp40TASGIy1Mfx6qJW429atgkbn04BSxWJaLsLtMQX1GYK0jAEYBqQYt
         ZSUPMC7bVrhpjT1bKfmkEx6PH6vjfKLauzJLDaxqzAW+6mQl3Tx+M+XvDx7OicRLn6u/
         y3yHDYG1e8j0MomTZL7VzAgeg9kSvT3Q0uGwUwxGkkAzTYI6eBse2R9jVfKbWRm5CgEW
         IEoQ==
X-Gm-Message-State: APzg51D6O3/Tsf/UyueOrXmanz6T8pcFipeYqJ2itXfc9o3i2tDqjup/
        nD16KoRIk+k0FlOPHIvNKsYimQ==
X-Google-Smtp-Source: ANB0VdbYjpyYlrTIaszypMmlA8sUN+Hfj2sV1ddfUqlkYtpv7WJ8q1+hP8G7ss0wRf7BAcn1E0JUCg==
X-Received: by 2002:a63:d150:: with SMTP id c16-v6mr30865254pgj.188.1536706882058;
        Tue, 11 Sep 2018 16:01:22 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:c031:82db:734e:842e? ([2601:646:c200:7429:c031:82db:734e:842e])
        by smtp.gmail.com with ESMTPSA id y128-v6sm28800152pfb.56.2018.09.11.16.01.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 16:01:20 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <CAHmME9q+mqT+vtM1FdBvf8=nAFu=u+wN48sOxqLcFthxYVn7NQ@mail.gmail.com>
Date:   Tue, 11 Sep 2018 16:01:19 -0700
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lutomirski <luto@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2E01FBB6-030A-40AB-8BEE-F8F271A57568@amacapital.net>
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-3-Jason@zx2c4.com> <CAKv+Gu9nSeo4PFVrtjtqGQ32eqyxUp3xVCczZfu+dhFz5yLM0A@mail.gmail.com> <20180911145624.GA21635@kroah.com> <20180911214737.GA81235@gmail.com> <49BAF465-B3DC-4155-BFF9-DB6C386C1878@amacapital.net> <CAHmME9q+mqT+vtM1FdBvf8=nAFu=u+wN48sOxqLcFthxYVn7NQ@mail.gmail.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 11, 2018, at 3:18 PM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>=20
>> On Tue, Sep 11, 2018 at 4:16 PM Andy Lutomirski <luto@amacapital.net> wro=
te:
>> Jason, can you do one of these conversions as an example?
>=20
> My preference is really to leave that to a different patch series. But
> if you think I *must*, then I shall.
>=20
>=20

I think Ard=E2=80=99s point is valid: in the long run we don=E2=80=99t want t=
wo competing software implementations of each primitive. It clearly *should*=
 be possible to make crypto API call into zinc for synchronous software oper=
ations, but a demonstration of how this actually works and that there isn=E2=
=80=99t some change to zinc to make it would well would be in order, I think=
.

IMO the right approach is do one conversion right away and save the rest for=
 later.=
