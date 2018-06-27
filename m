Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CCCC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B2625C74
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="qvkdTIm3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O+jRwcHP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B2625C74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965971AbeF0So1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 14:44:27 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:45107 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934387AbeF0SoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 14:44:25 -0400
Received: by mail-yb0-f196.google.com with SMTP id h127-v6so1140070ybg.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 11:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=DwWN4D7EmN8bnJO25lh+67ZuMBwv936a5aQNt3PLnNo=;
        b=qvkdTIm312sgneoUtbg9yYqcOboSvwV63U4em6AS/Sv2jA4WUu1rIwQCNLqwee9VJT
         rxMj9oVZXRF9hB/Cgnd2gflI53ekGNxUQ0G8LgRO6SCD5v0XoubgsWZ+TostrN66/cnh
         4RWlbivF3egCduOYjwrINcfPqsy9NkBpaNlYBAjGM3FSpvy94U+U6DOAPuCOCcptMuiD
         bkUjIsVu6QwoyVAOOtVzPnoppvwYL7c6xyUpN6sPV66yz4K6FpYuzboMn2r6b/q3G/qu
         XkBvb/qy6dxXaT40ZY2glukoFlx2InvAz478Y8cfeDSOc9WEXCF4M5spSALEKLsh5ovb
         +UrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=DwWN4D7EmN8bnJO25lh+67ZuMBwv936a5aQNt3PLnNo=;
        b=O+jRwcHPOqF7qagHJuyihxZrdz8EODvzWS2vviWxF57egAcvHT6o8THWP96QP1Lh4c
         xFthR72SiTIgDzdmafo+t53D82izyVs71rLwJ+mFtZFUCq7M56Hgi27vsUk76IztBx8p
         hpgNNU9QHEJpb5yl/wF9KpWYJWm9pXxfGjkUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=DwWN4D7EmN8bnJO25lh+67ZuMBwv936a5aQNt3PLnNo=;
        b=nInPDKYugJq7EfN8xVzjpmuplj38xDOmt/wIvnTMwRzohrHLb38gYrvCXcuILfvSnT
         7SZ/IpbEw8gYFeAxsJsVPeMh+7wUYRWby2IPm0SqfygwK81WIwUcpLSh4aeBcZxweB9y
         MCkFbxTMMo1DMlnPULNtI9unOwOjonkbuib9F24B1BqXCmBuXaFjzoEU5oTHrObFm941
         1VJ11qaZOjCp7YqcdK7TLObv2kWqi39/zC8OpWMctQ9Bf6wOqvljzX+sHSIUuJPB7gMJ
         GoAySeV2WlN8g0SiafAIlDk6ufJPec1o4B9EZAEzAA8UA1UOsGGVrY2ANet4XB//ax1x
         j2hQ==
X-Gm-Message-State: APt69E0SWLSukq7idJvhLCbnS1X0TWmQ4/sNt/5Jluem2Cvfuj9gNDKa
        02zku0rvJ4//vzgrQew8DePGS0qRWZPkNlhra3Q4/A==
X-Google-Smtp-Source: ADUXVKICeOoq4pz+ZT1IhT3lSuLJa6L/eauxgY2Fzm1yMiw9Ax4aQu5ZJa4ku2ffVoAfiuNNWQAI+4D8x+h52rAq/dM=
X-Received: by 2002:a25:a301:: with SMTP id d1-v6mr3746554ybi.193.1530125064079;
 Wed, 27 Jun 2018 11:44:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 11:44:23
 -0700 (PDT)
In-Reply-To: <20180627181012.GM20754@mellanox.com>
References: <20180624082353.16138-1-leon@kernel.org> <20180624082353.16138-9-leon@kernel.org>
 <CAKwiHFhgsyWYD+q+JFb2HJEphnjiiOp=o4Airv3MW031q2jx8w@mail.gmail.com>
 <20180625171157.GE5356@mellanox.com> <CAKwiHFiRYbyiJqDYCgKXKZYRr0KjCt8q9AwKwfqoCA1sT2KFyQ@mail.gmail.com>
 <20180626175435.GQ5356@mellanox.com> <CAKwiHFgchr+6HYOZ4e4e1vzL9cFabe6eonNNM8NTWZypazcuKA@mail.gmail.com>
 <20180627181012.GM20754@mellanox.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 27 Jun 2018 11:44:23 -0700
X-Google-Sender-Auth: htpl9c3GZax0MEjueck555coYw8
Message-ID: <CAGXu5jL-_o0mQGzWoOg5VHj0sUfrkDH-yrOg0A3BxQRe+VRmDw@mail.gmail.com>
Subject: Re: [PATCH rdma-next 08/12] overflow.h: Add arithmetic shift helper
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Hadar Hen Zion <hadarh@mellanox.com>,
        Matan Barak <matanb@mellanox.com>,
        Michael J Ruhl <michael.j.ruhl@intel.com>,
        Noa Osherovich <noaos@mellanox.com>,
        Raed Salem <raeds@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        linux-netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 11:10 AM, Jason Gunthorpe <jgg@mellanox.com> wrote:
> Leon? Seems like agreement, Can you work with this version?
>
> #include <stdint.h>
> #include <stdbool.h>
> #include <assert.h>
>
> #define u64 uint64_t
>
> /*
>  * Compute *d = (a << s)
>  *
>  * Returns true if '*d' cannot hold the result or 'a << s' doesn't make sense.
>  * - 'a << s' causes bits to be lost when stored in d
>  * - 's' is garbage (eg negative) or so large that a << s is guarenteed to be 0
>  * - 'a' is negative
>  * - 'a << s' sets the sign bit, if any, in '*d'
>  * *d is not defined if false is returned.
>  */
> #define check_shift_overflow(a, s, d)                                          \
>         ({                                                                     \
>                 typeof(a) _a = a;                                              \
>                 typeof(s) _s = s;                                              \
>                 typeof(d) _d = d;                                              \
>                 u64 _a_full = _a;                                              \
>                 unsigned int _to_shift =                                       \
>                         _s >= 0 && _s < 8 * sizeof(*d) ? _s : 0;               \
>                                                                                \
>                 *_d = (_a_full << _to_shift);                                  \
>                                                                                \
>                 (_to_shift != _s || *_d < 0 || _a < 0 ||                       \
>                  (*_d >> _to_shift) != a);                                     \
>         })
>
> int main(int argc, const char *argv[])
> {
>         int32_t s32;
>         uint32_t u32;
>
>         assert(check_shift_overflow(1, 0, &s32) == false && s32 == (1 << 0));
>         assert(check_shift_overflow(1, 1, &s32) == false && s32 == (1 << 1));
>         assert(check_shift_overflow(1, 30, &s32) == false && s32 == (1 << 30));
>         assert(check_shift_overflow(1, 31, &s32) == true);
>         assert(check_shift_overflow(1, 32, &s32) == true);
>         assert(check_shift_overflow(-1, 1, &s32) == true);
>         assert(check_shift_overflow(-1, 0, &s32) == true);
>
>         assert(check_shift_overflow(1, 0, &u32) == false && u32 == (1 << 0));
>         assert(check_shift_overflow(1, 1, &u32) == false && u32 == (1 << 1));
>         assert(check_shift_overflow(1, 30, &u32) == false && u32 == (1 << 30));
>         assert(check_shift_overflow(1, 31, &u32) == false && u32 == (1UL << 31));
>         assert(check_shift_overflow(1, 32, &u32) == true);
>         assert(check_shift_overflow(-1, 1, &u32) == true);
>         assert(check_shift_overflow(-1, 0, &u32) == true);
>
>         assert(check_shift_overflow(0xFFFFFFFF, 0, &u32) == false && u32 == (0xFFFFFFFFUL << 0));
>         assert(check_shift_overflow(0xFFFFFFFF, 1, &u32) == true);
>         assert(check_shift_overflow(0xFFFFFFFF, 0, &s32) == true);
>         assert(check_shift_overflow(0xFFFFFFFF, 1, &s32) == true);
> }

Oh yes, please include these tests in lib/test_overflow.c too! Nice. :)

-Kees

-- 
Kees Cook
Pixel Security
