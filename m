Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A38C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 02:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3152089D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 02:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E3152089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754594AbeGJC2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 22:28:25 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:54178 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754463AbeGJC2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 22:28:23 -0400
Received: from mr4.cc.vt.edu (mr4.cc.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w6A2SMV5005660
        for <linux-kernel@vger.kernel.org>; Mon, 9 Jul 2018 22:28:22 -0400
Received: from mail-qk0-f197.google.com (mail-qk0-f197.google.com [209.85.220.197])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w6A2SH4F017635
        for <linux-kernel@vger.kernel.org>; Mon, 9 Jul 2018 22:28:22 -0400
Received: by mail-qk0-f197.google.com with SMTP id v65-v6so6194436qka.23
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 19:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=M53H5psWoZsH5E5ciJxFG99Ocu8WlYB41mFen2OEly8=;
        b=Uw522IW4uwfbAQCWPYv2gTd/RWfwOAR+GDk+88EAxmRiA9MtNpm8ncZ1RWoE5Yn/xx
         /unsJMwhnA2PeYyNTJF5qUCGdZsVjbt6jJyg2rljb56vxa43X6tt00QElvgKA0tS+GSw
         qzqOXflRfkeUbRLawR36ce/nnVpEuf+RNG9MELWtioLaB4W1pWQlrX7KpaJKwXDaZc0j
         ik1T3nW4vfSVXhzKATBjCXpropNasI9COorZkpsR7TcYK5jFg9Ci91HfppLx37EtBa1M
         kU3Thy8f0xnzbbljfLfpJL7HH04GQ+VpBlTuJCyUF8UWNsavyktT7T3UZ3d0i1sbi7Gj
         dznw==
X-Gm-Message-State: APt69E3dEXaue3iP4OEzre+0wnULn3RBobGvYntXNXAgq/KekdE8OhCg
        x71JeahkJv3rVSBuf5qXRbsZW8TykV9u/PYjHVVby6/o0TsLnNMLULYQoKMdW/CyctDbz+DiF+B
        2CtZKN4DG81GK2Sw2m3yx6WQVHi8x83WUtP8=
X-Received: by 2002:a37:cc8d:: with SMTP id n13-v6mr13456497qkl.223.1531189697460;
        Mon, 09 Jul 2018 19:28:17 -0700 (PDT)
X-Google-Smtp-Source: AAOMgpe+PLcyHdYuDxO3wLwgSzQiTMbyUeOcTywIq2ZwY8plYWuRB2Ht9BCZHhUXohGqpLz1xT5Wmg==
X-Received: by 2002:a37:cc8d:: with SMTP id n13-v6mr13456485qkl.223.1531189697256;
        Mon, 09 Jul 2018 19:28:17 -0700 (PDT)
Received: from turing-police.cc.vt.edu ([2601:5c0:c001:4341:c4ae:bf24:a9e5:e44c])
        by smtp.gmail.com with ESMTPSA id p133-v6sm76814qka.32.2018.07.09.19.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 19:28:15 -0700 (PDT)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        kernelnewbies@kernelnewbies.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] vsprintf: fix build warning
In-Reply-To: <20180709234203.GG4447@eros>
References: <20180706134724.563799-1-arnd@arndb.de> <20180706144213.GA411@tigerII.localdomain> <20180706114951.6e739180@gandalf.local.home>
 <20180709234203.GG4447@eros>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1531189694_3044P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Jul 2018 22:28:14 -0400
Message-ID: <7018.1531189694@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1531189694_3044P
Content-Type: text/plain; charset=us-ascii

On Tue, 10 Jul 2018 09:42:03 +1000, "Tobin C. Harding" said:

> I was under the impression that each maintainer constantly rebased their
> next branches and that was why one has to checkout the tagged linux-next
> each day instead of just pulling.

Close, but no cigar.  The maintainers don't rebase their -next branches, but
due to the way linux-next merges 200+ trees on top of current Linus tree,
*that* ends up rebasing every day.

--==_Exmh_1531189694_3044P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBW0QZvo0DS38y7CIcAQL0bAf+LS5eTYq7gB1e4GW+QfBY1ZEmUWkgBQ4W
Y1PPE/EJgw9EbhzlNJ7eb6QlLZRFhOov5sKC8YqFsjhpOPGq2nWiJF0obxIcAk41
nNwP//cBs2wHAWhk2zqBxcWTvTr+khIWPZgq+KojSKkdrLlcUmDDmr2YBnHVKqv0
Ij+GPxjEwg1SRGH7+OU5Ga+dAq2/bcUs2RHc1qRxDXC26WJurzoTXHFv320JPAW2
A1FPfg8fev3nGLIa5QtIf2D9gPmcGdTJ0b+Xcji2IsiDZX2ZL45xA1lTkTtud3BS
Qq1fFs+GiIknsJsDQfHK98CQ+l1DtSEF2HJZvwzFuZi19Qr3bjxJig==
=anXB
-----END PGP SIGNATURE-----

--==_Exmh_1531189694_3044P--
