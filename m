Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A0BECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3A3214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Xiw0QJUl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF3A3214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbeIQVf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:35:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39684 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728536AbeIQVf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:35:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id q8-v6so10323943wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 09:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pNqwqQnz4EGOq1/TTURRKnrXuhvIAHkMglQNn8uJk4Q=;
        b=Xiw0QJUl/GH0zoQiQmk4+RLnDjSa5++CnMI3To4SxZS1YdappA99SOW6lJLt5iXell
         srS4itb23rrv/S9UI4e/XprFjWG6R4yhhuqASv9o7Mjqcgl1GeVmLFmvW7lvE5prs4f9
         JpwR/mMta4iIXxV2QzWqF5EDuCikG2hELHLzqRuUjku5kD49G01QRwRrcVTEPGmjNcdR
         5OrZ5e5cdgm5lJftkpzRq6t6FYG9i+prcUvoCMAYBjeyE6WLqLrxmwuYE9+rI9e7n1kT
         F+4766xrreDvGOUDfEA0yb2OIQO3nPXCaD4DZsUEWkqWxdf7qcttCndJdAFkvPEYEwPl
         z7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pNqwqQnz4EGOq1/TTURRKnrXuhvIAHkMglQNn8uJk4Q=;
        b=UUXA3xipgjX0KfkwaqVW2kqE/HH8XL41z70DyT3HmH1DlX83I7y9HXuH4tUyDfJKf4
         E7y5dn9XJGJy374CwDbphht+qSEQuMskeuxWSwqhuadXFjVyNw0zrbh5IIsleU9i4fIg
         7exu/SsQIOnkZ0thUsKGHteHwcL/6icIFd5hoOqPlEeTGW7QE4JrOTRG54ami7rA4d10
         aH6gZ6ytEBYjxioxPLX88Az/Sl9KR0IOYnhvT7/NKa9cqmTJs8Gm47LzIP1X3MvX0Krx
         SzRHz0cGTueIxat5ZSYk4Q33URSM0HQ3zEKpIl7NZprA8RFTqas83uKpFD1U3PhxtaAo
         EEvQ==
X-Gm-Message-State: APzg51D9P6Cpkipjekfz7Yd9pQYV2hIxYNklFNk5hE+qUivnU65Bvn5y
        Z9cFKwEF+TmODsRXyHZVnfhD3QQHUzQGU4P+JXTIQw==
X-Google-Smtp-Source: ANB0VdYCx3LspjFFpGQ0OW3483AmNlkZX5JqlGxACVIn59ug7vGEZXv+P8tdEPB5T1IcOOqCepF53JPeM9j6Blcb8zI=
X-Received: by 2002:a1c:cbc1:: with SMTP id b184-v6mr12281012wmg.149.1537200476040;
 Mon, 17 Sep 2018 09:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180911214737.GA81235@gmail.com> <CAHmME9rFUruF-VN1pmU-k5nFsb9ppAPhPpW-5Ho9dKL2HCg4kA@mail.gmail.com>
 <20180911233015.GD11474@lunn.ch> <20180911.165739.2032677219588723041.davem@davemloft.net>
 <CALCETrXrJPcs3h9CtF50N4k2AGx3qzspJd_UW3t+KGYOj7+p=Q@mail.gmail.com>
 <CAKv+Gu8QgRo-Oex2Sk5unET3FMq+1Cp2btAWXCB8xsALxjatHg@mail.gmail.com>
 <35BC21D7-01F4-4F91-A7E9-8D15DE5B95D6@amacapital.net> <CAHmME9o2sB-rQo0DRh56AFe7ZLJJh+CU6Z1m5XZ4tA8vATCy1g@mail.gmail.com>
In-Reply-To: <CAHmME9o2sB-rQo0DRh56AFe7ZLJJh+CU6Z1m5XZ4tA8vATCy1g@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 17 Sep 2018 09:07:43 -0700
Message-ID: <CALCETrWHWZibRev=hZeE1_YFjktnpV9VBN_QmvHJfakb-saRuA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Lutomirski <luto@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, andrew@lunn.ch,
        Eric Biggers <ebiggers@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 8:32 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Mon, Sep 17, 2018 at 4:52 PM Andy Lutomirski <luto@amacapital.net> wrote:
> > I think the module organization needs to change. It needs to be possible to have chacha20 built in but AES or whatever as a module.
>
> Okay, I'll do that for v5.
>
> > I might have agreed before Spectre :(. Unfortunately, unless we do some magic, I think the code would look something like:
> >
> > if (static_branch_likely(have_simd)) arch_chacha20();
> >
> > ...where arch_chacha20 is a *pointer*. And that will generate a retpoline and run very, very slowly.  (I just rewrote some of the x86 entry code to eliminate one retpoline. I got a 5% speedup on some tests according to the kbuild bot.)
>
> Actually, the way it works now benefits from the compilers inliner and
> the branch predictor. I benchmarked this without any retpoline
> slowdowns, and the branch predictor becomes correct pretty much all
> the time. We can tinker with this after the initial merge, if you
> really want, but avoiding function pointers and instead using ordinary
> branches really winds up being quite fast.

Indeed.  What I'm saying is that you shouldn't refactor it this way
because it will be slow.  I agree it would be conceptually nice to be
able to blacklist a chacha20_x86_64 module to disable the asm, but I
think it would be very hard to get good performance.

--Andy
