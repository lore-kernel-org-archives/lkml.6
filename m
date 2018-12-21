Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF67C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941D121928
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="a/KXPV7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391559AbeLUTN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:13:29 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34928 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391558AbeLUTN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:13:28 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so5678082ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 11:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=GoaAF/5YI5Z45IZvCYu5JL7bMo3j0XtljW+8zGPMK0s=;
        b=a/KXPV7n0rvMsJnMnbJzEBym23mlzA+RFBmS6UI5Xw56BbHkyLfli0p+TgOAq9tDpm
         FSJh8wHalcdAXf4r2n0okZfdsHaNnHuL3Tv+TqYO1LSXu3qkOLqW/WgVGI1OBD20u2Ip
         u4DUX8tLzYgLqRkKDJvDE4Vjp3Wp6hOTk2bBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=GoaAF/5YI5Z45IZvCYu5JL7bMo3j0XtljW+8zGPMK0s=;
        b=btiDrcH9Gz+6iOci4Nxw1zlZpdYWGKj3zkGm7YX2FkduUbGVtnbjUpGoIs2eW2A0uH
         UK/ZjoOwajtt+pU/Z4617rDkad/dBO/ShFKJmEXD5biaI+GeRCt6reRcK3OIfgy4KEmJ
         iUoYFIXPtpQtGITmH86NIv3v6vB0JbknEyN13rZCy6IqE93Uy3XjkvnLCTJRMpYYWcsR
         8jwwqapSGACYD8wcKKIDd5HWwIlnIEmknVhJCTYlW9tv+C0W3eUSlI58CampAKTVHSY+
         ZPdxN4zNaY3fOULgCosiJ41XkIW4tVgFe05ezZMRCWgu41AVYrR6EQiiqHY+T0sax9uR
         pzeg==
X-Gm-Message-State: AJcUukc0UacfCBioRjtQtppuGFZ167oDBhM9t9jqHxeI2RiposdnZ9E5
        qwiAM2gA4WecY26ahNc9BkvxVrf2yC8=
X-Google-Smtp-Source: ALg8bN51It94ofsHsB5rtVIO3t/QaFNVGghzszoAgh8ZsSZ4P6Jc6Qg0UeFwiOyP9gEX8dmNUwUe5Q==
X-Received: by 2002:a2e:1b47:: with SMTP id b68-v6mr2031085ljb.104.1545419606588;
        Fri, 21 Dec 2018 11:13:26 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 12-v6sm4754679ljf.96.2018.12.21.11.13.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 11:13:24 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id k19-v6so5644394lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 11:13:23 -0800 (PST)
X-Received: by 2002:a2e:2c02:: with SMTP id s2-v6mr2429758ljs.118.1545419603234;
 Fri, 21 Dec 2018 11:13:23 -0800 (PST)
MIME-Version: 1.0
References: <20181219071420.GC2628@infradead.org> <20181219021953.GD31274@dastard>
 <20181219193005.GB6889@mit.edu> <20181219213552.GO6311@dastard>
 <20181220220158.GC2360@mit.edu> <20181221070447.GA21687@infradead.org> <20181221154714.GA26547@mit.edu>
In-Reply-To: <20181221154714.GA26547@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Dec 2018 11:13:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgdzWgoPSuHeVcqmGE1hB3Gan72r2_AhtC14e60=z45yg@mail.gmail.com>
Message-ID: <CAHk-=wgdzWgoPSuHeVcqmGE1hB3Gan72r2_AhtC14e60=z45yg@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] fs-verity: add a documentation file
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 7:47 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> Linus --- we're going round and round, and I don't think this is
> really a technical dispute at this point, but rather an aesthetics
> one.

Grr.

So honestly, I personally *like* the model of "the file contains its
own validation data" model. I think that's the right model, so that
you can then basically just do "enable verification on this file, and
verify that the root hash is this".

So that part I like. I think the people who argue for "let's have a
separate interface that writes the merkle tree data" are completely
wrong.

HOWEVER.

I do agree that your particular model is pretty damn broken in lots of ways.

Why is it filesystem specific? If the whole point is that the file
itself has its own verification data (which I like), then I don't see
why this is then documented as some filesystem-specific layout model.
That's complete and utter garbage.

In other words: either the model is that the file *itself* contains
its own merkle tree that validates the file, or it isn't. You can't
have it two ways. No silly "layout changes when you apply the hash"
garbage. That's just crazy talk and invalidates the whole model.

And honestly, I still think that it's very odd to add the merge data
to the end, when the filesystem already supports xattrs. It would have
made much more sense to just make one xattr contain the merkle tree
validation data.

So why is this sold as some unholy mess of "filesystem-specific" and
"generic"? That part just annoys the hell out of me. Why isn't this
sold as an *actual* generic model, where you just say "append the
merkle tree to the file, then enable verity testing of the end result
and validate the top-level hash".

That kind of thing could be done with absolutely _zero_ per-filesystem
code, and made 100% generic, and we'd just verify the merge data in
readpages().

So what's the excuse for doing the crazy odd "let's just support one
single filesystem" model?

                    Linus
