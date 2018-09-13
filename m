Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5697EFA3751
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C09420881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NIyecWJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C09420881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeIMUxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 16:53:03 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:32818 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbeIMUxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 16:53:03 -0400
Received: by mail-io1-f49.google.com with SMTP id r196-v6so3546180iod.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 08:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tEf4SmJ/m3MuEYMCYriasC6mhFVOVmCk2r36nlDLxaU=;
        b=NIyecWJOUT+d7Mju6fhw4dQQBiTP0MmgsLvn0tarMhGnGVcVYojctUyZpvmiE5vl6y
         o4E6PgOXcmiYg+IRA5jcxUiTLrgo3fysufnH7ACQXpED+tnnE7tMSPUOp1gTskGh9+v9
         bXx2R6Sum1pYQlNjtwy1pczPtvHbUT+sleahE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tEf4SmJ/m3MuEYMCYriasC6mhFVOVmCk2r36nlDLxaU=;
        b=AxnC9HCztUM93oQtg5jlDq7XiGTCGCKrjyfwhORlHACB4Zcu0gf0qyu5C+K1tHxW7o
         R+5uZqCxmwUSPvYwS0h8KW4syXtPqBP+za/hBvTUQlP5RRWvwu9b9jrP+2y0LY43NRGx
         7P33UVzmnDmT8iamx9M6wlfq75XjX3EzGQg47pQEi4E8vAODaNXZowrOZ7xDHnOozDib
         oJ9plsdt9QpfSqwBmI00guT2ziXqrmjHgU7IiRc5l28+cTZIkAEQaqs2LhhyjwURPTV8
         dy2Wi82yl7mVRuCueXW7dgSmoYDiolFf6Xh1jbdQxxi6Ubhdn3AmcOAD4MvnsynpIXBe
         InSA==
X-Gm-Message-State: APzg51CYenKmvXPcYX+AGSgfMx0g91HO25xqF8s1gxvGOMDqoW/hQyeb
        dtXi3s/wn9Vb2bfqVmzp8ZzixzofvTD7WkgSPUHpEQ==
X-Google-Smtp-Source: ANB0VdZhPxZdUplEnHevZunVcenKkeV/nKM5v2RUJzl6L3e1JDdc3b5uh2bVie179GFdfpwHGc4ZaGBH2pplpVD4oaU=
X-Received: by 2002:a6b:4516:: with SMTP id s22-v6mr6952867ioa.60.1536853379126;
 Thu, 13 Sep 2018 08:42:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Thu, 13 Sep 2018 08:42:58
 -0700 (PDT)
In-Reply-To: <CAHmME9pcODNc2m26DH1cQY6R+grxYW5dvFpNDpz_GiugM3qufw@mail.gmail.com>
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-3-Jason@zx2c4.com>
 <CAKv+Gu9nSeo4PFVrtjtqGQ32eqyxUp3xVCczZfu+dhFz5yLM0A@mail.gmail.com>
 <CAHmME9rTEFLaYmzFrc719LW2DWS2Ua_vL6by1UXZ9uDvMpbhYw@mail.gmail.com>
 <CAKv+Gu9RGo9rtGsmwMLZ_=-WSQ_h7har4agXP-2XOKupq-KYtA@mail.gmail.com>
 <CALCETrU2qkLVaxC=cpU5iAeT5B7xGsR+m2ZWtLVK37jMMWtcAA@mail.gmail.com>
 <CAKv+Gu8z1r7F_wbR6-e0Vbryqby7djDy2OR6JJURCsTo6ZMa2g@mail.gmail.com> <CAHmME9pcODNc2m26DH1cQY6R+grxYW5dvFpNDpz_GiugM3qufw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 13 Sep 2018 17:42:58 +0200
Message-ID: <CAKv+Gu9GVbSETjp01tANMwJgA6O9aexhnH+47836KjZg+71q2A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 September 2018 at 16:32, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Thu, Sep 13, 2018 at 7:41 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> But one of the supposed selling points of this crypto library is that
>> it gives engineers who are frightened of crypto in general and the
>> crypto API in particular simple and easy to use crypto primitives
>> rather than having to jump through the crypto API's hoops.
>
> The goal is for engineers who want to specifically use algorithm X
> from within the kernel in a non-dynamic way to be able to then use
> algorithm X with a simple function call. The goal is not to open it up
> to people who have no idea what they're doing; for that a NaCL-like
> library with functions like "crypto_box_open" or something would fit
> the bill; but that's also not what we're trying to do here. Please
> don't confuse the design goals. The rest of your email is therefore a
> bit of a straw man; cut the rhetoric out.
>
>> A crypto library whose only encryption algorithm is a stream cipher
>> does *not* deliver on that promise, since it is only suitable for
>> cases where IVs are guaranteed not to be reused.
>
> False. We also offer XChaCha20Poly1305, which takes a massive nonce,
> suitable for random generation.
>
> If there became a useful case for AES-PMAC-SIV or even AES-GCM or
> something to that extent, then Zinc would add that as required. But
> we're not going to start adding random ciphers unless they're needed.
>

I'd prefer it if all the accelerated software implementations live in
the same place. But I do strongly prefer arch code to live in
arch/$arch, simply because of the maintenance scope for arch
developers and maintainers.

I think AES-GCM is a useful example here. I really like the SIMD token
abstraction a lot, but I would like to understand how this would work
in Zinc if you have
a) a generic implementation
b) perhaps an arch specific scalar implementation
c) a pure NEON implementation
d) an implementation using AES instructions but not the PMULL instructions
e) an implementation that uses AES and PMULL instructions.

On arch/arm64 we support code patching, on other arches it may be
different. We also support udev loading of modules depending on CPU
capabilities, which means only the implementation you are likely to
use will be loaded, and other modules are disregarded.

I am not asking you to implement this now. But I do want to understand
how these use cases fit into Zinc. And note that this has nothing to
do with the crypto API: this could simply be a synchronous
aes_gcm_encrypt() library function that maps to any of the above at
runtime depending on the platform's capabilities.

>> You yourself were
>> bitten by the clunkiness of the crypto API when attempting to use the
>> SHA26 code, right? So shouldn't we move that into this crypto library
>> as well?
>
> As stated in the initial commit, and in numerous other emails
> stretching back a year, yes, sha256 and other things in lib/ are going
> to be put into Zinc following the initial merge of Zinc. These changes
> will happen incrementally, like everything else that happens in the
> kernel. Sha256, in particular, is probably the first thing I'll port
> post-merge.
>

Excellent.

>> I think it is reasonable for WireGuard to standardize on
>> ChaCha20/Poly1305 only, although I have my concerns about the flag day
>> that will be required if this 'one true cipher' ever does turn out to
>> be compromised (either that, or we will have to go back in time and
>> add some kind of protocol versioning to existing deployments of
>> WireGuard)
>
> Those concerns are not valid and have already been addressed (to you,
> I believe) on this mailing list and elsewhere. WireGuard is versioned,
> hence there's no need to "add" versioning, and it is prepared to roll
> out new cryptography in a subsequent version should there be any
> issues. In other words, your concern is based on a misunderstanding of
> the protocol. If you have issues, however, with the design decisions
> of WireGuard, something that's been heavily discussed with members of
> the linux kernel community, networking community, cryptography
> community, and so forth, for the last 3 years, I invite you to bring
> them up on <wireguard@lists.zx2c4.com>.
>

I'd prefer to have the discussion here, if you don't mind.

IIUC clients and servers need to run the same version of the protocol.
So does it require a flag day to switch the world over to the new
version when the old one is deprecated?

>> And frankly, if the code were as good as the prose, we wouldn't be
>> having this discussion.
>
> Please cut out this rhetoric. That's an obviously unprovable
> statement, but it probably isn't true anyway. I wish you'd stick to
> technical concerns only, rather than what appears to be a desire to
> derail this by any means necessary.
>

I apologize if I hit a nerve there, that was not my intention.

I am not an 'entrenched crypto API guy that is out to get you'. I am a
core ARM developer that takes an interest in crypto, shares your
concern about the usability of the crypto API, and tries to ensure
that what we end up is maintainable and usable for everybody.

>> Zinc adds its own clunky ways to mix arch and
>> generic code, involving GCC -include command line arguments and
>> #ifdefs everywhere. My review comments on this were completely ignored
>> by Jason.
>
> No, they were not ignored. v2 cleaned up the #ifdefs. v4 has already
> cleaned up the makefile stuff and will be even cleaner. Good things
> await, don't worry.
>

You know what? If you're up for it, let's not wait until Plumbers, but
instead, let's collaborate off list to get this into shape.
