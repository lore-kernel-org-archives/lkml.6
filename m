Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66E6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BBF20578
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551139138;
	bh=OFdePKI5nQP61DUz3AbJrd7hba7ozwch4a6PIQUj8lM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=A0sKPhZHT9e3AhCwINwGLHF1/oXU+eaRoTM0wEK1SJaSK8PAPMGlA2A8JqADsS0C2
	 xRA2SuWy3pje9phnXsuFKAljqPBNUjQa4F3Zho25JUSFzOe1Lb+N2lPWDYawN9xh/R
	 Le9D2QmNXdI2Vr8pGdtl2MyxgiNIDniDCppg95wI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfBYX65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 18:58:57 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44475 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728740AbfBYX6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 18:58:55 -0500
Received: by mail-lf1-f68.google.com with SMTP id g2so8241295lfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 15:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JdMBJp49ET+JbqiN0APUDRxceNUGJT3yhKuE4Z6Bj6M=;
        b=KX6+mdqixHQDHTf6Nn4nwti+VpkJ3ZTXMVx73uY5MalHv6i7kUYR1TMoDqUitpuwPH
         gNQFROKAnk3ioJiU2gWEckCWAVq6RahdpbjaCFuqnNoRwE/gvsSOzcP8jDPJ6cjq4Hts
         tNEk4tomZ+hmt0bjRBrF1Ybldwex65nwY0qek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JdMBJp49ET+JbqiN0APUDRxceNUGJT3yhKuE4Z6Bj6M=;
        b=Gecv7Rfy3d8gmFHAfZPyarT6z9MFjP3dDTDDbN96JfIAFNdgDU+E9bAnA09mtMsoDH
         a2dL2pL0B591/p1yylY0d+fmK+HJIJrrqV+02XRL7Oaa3zI2JcR7oDRbkRAcsr6SDmx1
         m3DpFrHX0JFb+ZkEHUn0GAcy6AuSmNzvVTv+0pKG8eZHlFaVuJAPDck3XWsV/msc6r3D
         Yr+94cTi2TJhxPr1Ojd5czwqEXjHSbNUwNBnUPa7ynRwWIossxNvoSSN82HfP67C+W5P
         QtKNqhzRVTeN7DeNY0lb9qM7wBzRvDddE8fk9YKDZiWOzwU3UZ2gSohmicd+wPiScUOF
         5oKw==
X-Gm-Message-State: AHQUAuZz/kcG2vLDNUbcK5EhCrlJNj6z6g3juxjUCi+AY34tm8vLcE+/
        MJqtyv+VD1elZhplW3lV552kKspPXdg=
X-Google-Smtp-Source: AHgI3IZK2S0PnjOhW+EjngUaDDMqHaYel3qUCBhywIomsoCFOoTXi9JfBXbNHHrlQPmY/qB5QV0/OA==
X-Received: by 2002:a19:5209:: with SMTP id m9mr11229898lfb.51.1551139132547;
        Mon, 25 Feb 2019 15:58:52 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 13sm2780263lju.27.2019.02.25.15.58.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 15:58:51 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id a17so9096338ljd.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 15:58:51 -0800 (PST)
X-Received: by 2002:a2e:8510:: with SMTP id j16mr11347039lji.2.1551139130909;
 Mon, 25 Feb 2019 15:58:50 -0800 (PST)
MIME-Version: 1.0
References: <20190221222123.GC6474@magnolia> <alpine.LSU.2.11.1902222222570.1594@eggly.anvils>
 <CAHk-=wgO3MPjPpf_ARyW6zpwwPZtxXYQgMLbmj2bnbOLnR+6Cg@mail.gmail.com>
 <alpine.LSU.2.11.1902251214220.8973@eggly.anvils> <CAHk-=whP-9yPAWuJDwA6+rQ-9owuYZgmrMA9AqO3EGJVefe8vg@mail.gmail.com>
In-Reply-To: <CAHk-=whP-9yPAWuJDwA6+rQ-9owuYZgmrMA9AqO3EGJVefe8vg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Feb 2019 15:58:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiwAXaRXjHxasNMy5DHEMiui5XBTL3aO1i6Ja04qhY4gA@mail.gmail.com>
Message-ID: <CAHk-=wiwAXaRXjHxasNMy5DHEMiui5XBTL3aO1i6Ja04qhY4gA@mail.gmail.com>
Subject: Re: [PATCH] tmpfs: fix uninitialized return value in shmem_link
To:     Hugh Dickins <hughd@google.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matej Kupljen <matej.kupljen@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 2:34 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Feb 25, 2019 at 12:34 PM Hugh Dickins <hughd@google.com> wrote:
> >
> > Seems like a gcc bug? But I don't have a decent recent gcc to hand
> > to submit a proper report, hope someone else can shed light on it.
>
> I don't have a _very_ recent gcc either [..]

Well, that was quick. Yup, it's considered a gcc bug.

Sadly, it's just a different version of a really old bug:

    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=18501

which goes back to 2004.

Which I guess means we should not expect this to be fixed in gcc any time soon.

The *good* news (I guess) is that if we have other situations with
that pattern, and that lack of warning, it really is because gcc will
have generated code as if it was initialized (to the value that we
tested it must have been in the one basic block where it *was*
initialized).

So it won't leak random kernel data, and with the common error
condition case (like in this example - checking that we didn't have an
error) it will actually end up doing the right thing.

Entirely by mistake, and without a warniing, but still.. It could have
been much worse. Basically at least for this pattern, "lack of
warning" ends up meaning "it got initialized to the expected value".

Of course, that's just gcc. I have no idea what llvm ends up doing.

               Linus
