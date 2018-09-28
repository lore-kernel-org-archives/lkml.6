Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E4FC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37A421748
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kmrrgPxu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37A421748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbeI1OOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 10:14:35 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37970 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728887AbeI1OOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 10:14:35 -0400
Received: by mail-io1-f68.google.com with SMTP id y3-v6so3644412ioc.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 00:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OeE+9BUf7RqihFWpPfYlglNu//86pyZceNokPhcXor4=;
        b=kmrrgPxu3XQFL0pi03UtucUMR/8H0CB4DunK1J1JManVEFp1vvFclzCLxU64nhfIfw
         2sidxIBdqFewNXkbWDQUQYHiqGDOWhxY3yQNPHVlLeIufdBQ5bLcu2H72VhCCKfXA4bC
         YxxcQ8qTUDL7WRd/kE4Xqpd3hT9ydcLs1wxXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OeE+9BUf7RqihFWpPfYlglNu//86pyZceNokPhcXor4=;
        b=EZMl6FXNbuWEXE+ZE1avZgoDlKNHvmDx7tTCEGAn3jmaqV1o5z26T243kahQaS9ATS
         dqkAIqcG1H1aTcpY9MKNICT5oOYhsJvlPNkT2VbABdX1p2zVJBKMRjzKjzSATfpxJGtn
         f0YjOayh6Ymrju6/VfobNdXzF38+TAy7gzInTi9+Uu74K3PsWKFzQ8mejvReCfA7I6Yp
         A26nvOTsM1xf9C2dsn/zw2XXNi0VvDvC3mFbyEiGCMZqpB+kQYC6W3DLT2kS86utGXWS
         RTxPAfSkwUN52uXxI/iW3k2iqpgNoG8iMdwKRIrbWWznLLCAKDtrvRInueLQj7slmS71
         jvdg==
X-Gm-Message-State: ABuFfoi6VF1oPQyTuDAA4ocfFZ+v7FE3sBA0o3hwrGu/vtWE0v4pshDs
        DWpJ/SF5mIZ1sKhPXKsLnTSxta81JjjS+z6NyQP0CQ==
X-Google-Smtp-Source: ACcGV63IaV6IhMI9I6eWd9y7V/BdimwvpXDbedyqcvFF9uibtLbQ45FZofzAQkqndNi2XuQJpNkYOgXiGziNPVl7hJw=
X-Received: by 2002:a6b:5d12:: with SMTP id r18-v6mr10919046iob.170.1538121126009;
 Fri, 28 Sep 2018 00:52:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Fri, 28 Sep 2018 00:52:05
 -0700 (PDT)
In-Reply-To: <CAHmME9rJ4CewfDEqWh00ZowjWg9TaYpksVSzKSSxoKya-M8_LA@mail.gmail.com>
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180927182944.GA22921@gmail.com>
 <20180927213537.GA27576@zx2c4.com> <20180928011726.GA98113@gmail.com>
 <20180928023546.GA20765@zx2c4.com> <20180928045542.GA545@zzz.localdomain> <CAHmME9rJ4CewfDEqWh00ZowjWg9TaYpksVSzKSSxoKya-M8_LA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 28 Sep 2018 09:52:05 +0200
Message-ID: <CAKv+Gu-ZMR7zEAKv6_2tyD3OqnjVugOzKHzBEXW3pQs5W-SvLw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 00/23] WireGuard: Secure Network Tunnel
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 September 2018 at 07:46, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Hi Eric,
>
> On Fri, Sep 28, 2018 at 6:55 AM Eric Biggers <ebiggers@kernel.org> wrote:
>> And you still haven't answered my question about adding a new algorithm that is
>> useful to have in both APIs.  You're proposing that in most cases the crypto API
>> part will need to go through Herbert while the implementation will need to go
>> through you/Greg, right?  Or will you/Greg be taking both?  Or will Herbert take
>> both?
>
> If an implementation enters Zinc, it will go through my tree. If it
> enters the crypto API, it will go through Herbert's tree. If there
> wind up being messy tree dependency and merge timing issues, I can
> work this out in the usual way with Herbert. I'll be sure to discuss
> these edge cases with him when we discuss. I think there's a way to
> handle that with minimum friction.
>

I would also strongly prefer that all crypto work is taken through
Herbert's tree, so we have a coherent view of it before it goes
upstream.

>> A documentation file for Zinc is a good idea.  Some of the information in your
>> commit messages should be moved there too.
>
> Will do.
>
>> I'm not trying to "politicize" this, but rather determine your criteria for
>> including algorithms in Zinc, which you haven't made clear.  Since for the
>> second time you've avoided answering my question about whether you'd allow the
>> SM4 cipher in Zinc, and you designed WireGuard to be "cryptographically
>> opinionated", and you were one of the loudest voices calling for the Speck
>> cipher to be removed, and your justification for Zinc complains about cipher
>> modes from "90s cryptographers", I think it's reasonable for people to wonder
>> whether as the Zinc (i.e. Linux crypto library) maintainer you will restrict the
>> inclusion of crypto algorithms to the ones you prefer, rather than the ones that
>> users need.  Note that the kernel is used by people all over the world and needs
>> to support various standards, protocols, and APIs that use different crypto
>> algorithms, not always the ones we'd like; and different users have different
>> preferences.  People need to know whether the Linux kernel's crypto library will
>> meet (or be allowed to meet) their crypto needs.
>
> WireGuard is indeed quite opinionated in its primitive choices, but I
> don't think it'd be wise to apply the same design to Zinc. There are
> APIs where the goal is to have a limited set of high-level functions,
> and have those implemented in only a preferred set of primitives. NaCl
> is a good example of this -- functions like "crypto_secretbox" that
> are actually xsalsapoly under the hood. Zinc doesn't intend to become
> an API like those, but rather to provide the actual primitives for use
> cases where that specific primitive is used. Sometimes the kernel is
> in the business of being able to pick its own crypto -- random.c, tcp
> sequence numbers, big_key.c, etc -- but most of the time the kernel is
> in the business of implementing other people's crypto, for specific
> devices/protocols/diskformats. And for those use cases we need not
> some high-level API like NaCl, but rather direct access to the
> primitives that are required to implement those drivers. WireGuard is
> one such example, but so would be Bluetooth, CIFS/SMB, WiFi, and so
> on. We're in the business of writing drivers, after all. So, no, I
> don't think I'd knock down the addition of a primitive because of a
> simple preference for a different primitive, if it was clearly the
> case that the driver requiring it really benefited from having
> accessible via the plain Zinc function calls. Sorry if I hadn't made
> this clear earlier -- I thought Ard had asked more or less the same
> thing about DES and I answered accordingly, but maybe that wasn't made
> clear enough there.
>
>> > For example, check out the avx blocks function. The radix conversion
>> > happens in a few different places throughout. The reason we need it
>> > separately here is because, unlike userspace, it's possible the kernel
>> > code will transition from 2^26 back to 2^64 as a result of the FPU
>> > context changing.
>>
>> IOW, you had to rewrite the x86 assembly algorithm in C and make it use a
>> different Poly1305 context format.  That's a major change, where bugs can be
>> introduced -- and at least one was introduced, in fact.  I'd appreciate it if
>> you were more accurate in describing your modifications and the potential risks
>> involved.
>
> A different Poly1305 context format? Not at all - it's using the exact
> same context struct as the assembly. And it's making the same
> conversion that the assembly is. There's not something "different"
> happening; that's the whole point.
>
> Also, this is not some process of frightfully transcribing assembly to
> C and hoping it all works out. This is a careful process of reasoning
> about the limbs, proving that the carries are correct, and that the
> arithmetic done in C actually corresponds to what we want. And then
> finally we check that what we've implemented is indeed the same as
> what the assembly implemented. Finally, as I mentioned, hopefully Andy
> will be folding this back into his implementations sometime soon
> anyway.
>
>> > That's a good idea. I can include some discussion about this as well in
>> > the commit message that introduces the glue code, too, I guess? I've
>> > been hesitant to fill these commit messages up even more, given there
>> > are already so many walls of text and whatnot, but if you think that'd
>> > be useful, I'll do that for v7, and also add comments.
>>
>> Please prefer to put information in the code or documentation rather than in
>> commit messages, when appropriate.
>
> Okay, no problem.
>
>> > This is complete and utter garbage, and I find its insinuations insulting
>> > and ridiculous. There is absolutely no lack of honesty and no double
>> > standard being applied whatsoever. Your attempt to cast doubt about the
>> > quality of standards applied and the integrity of the process is wholly
>> > inappropriate. When I tell you that high standards were applied and that
>> > due-diligence was done in developing a particular patch, I mean what I
>> > say.
>>
>> I
>> disagree that my concerns are "complete and utter garbage".  And I think that
>> the fact that you prefer to respond by attacking me, rather than committing to
>> be more accurate in your claims and to treat all contributions fairly, is
>> problematic.
>
> I believe you have the sequence of events wrong. I've stated and made
> that there isn't a double standard, that the standards intend to be
> evenly rigorous, and I solicited your feedback on how I could best
> communicate changes in pre-merged patch series; I did the things
> you've said one should do. But your rhetoric then moved to questioning
> my integrity, and I believe that was uncalled for, inappropriate, and
> not a useful contribution to this mostly productive discussion --
> hence garbage. In other words, I provided an acceptable defense, not
> an attack. But can we move past all this schoolyard nonsense? Cut the
> rhetoric, please; it's really quite overwhelming.
>
>> It's great that you found and fixed this
>> bug on your own, and of course that raises my level of confidence in your work.
>
> Good.
>
>> Still, the v6 patchset still includes your claim that "All implementations have
>> been extensively tested and fuzzed"; so that claim was objectively wrong.
>
> I don't think that claim is wrong. The fuzzing and testing that's been
> done has been extensive, and the fuzzing and testing that continues to
> occur is extensive. As mentioned, the bug was fixed pretty much right
> after git-send-email. If you'd like I can try to space out the patch
> submissions by a little bit longer -- that would probably have various
> benefits -- but given that the netdev code is yet to receive a
> thorough review, I think we've got a bit of time before this is
> merged. The faster-paced patch cycles might inadvertently introduce
> things that get fixed immediately after sending then, unfortunately,
> but I don't think this will be the case with the final series that's
> merged. Though I'm incorporating tons and tons of feedback right now,
> I do look forward to the structure of the series settling down a
> little bit and the pace of suggestions decreasing, so that I can focus
> on auditing and verifying again. But given the dynamism and
> interesting insights of the reviews so far, I think the fast pace has
> actually been useful for elucidating the various expectations and
> suggestions of reviewers. It's most certainly improved this patchset
> in terrific ways.
>
>> Well, it doesn't help that you yourself claim that Zinc stands for
>> "Zx2c4's INsane Cryptolib"...
>
> This expansion of the acronym was intended as a totally ridiculous
> joke. I guess it wasn't received well. I'll remove it from the next
> series. Sorry.
>

As I understood from someone who was at your Kernel Recipes talk, you
mentioned that it actually stands for 'zinc is not crypto/' (note the
slash)

That is needlessly divisive and condescending, so if you want to move
past the rhetoric and the schoolyard nonsense, perhaps you can find a
better name for it? Or just put your stuff into crypto/base/,
crypto/core/ or something like that.
