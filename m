Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A485C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D68B2081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D68B2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387553AbeKFBcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 20:32:41 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:52838 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387465AbeKFBcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 20:32:41 -0500
Received: from mr1.cc.vt.edu (mr1.cc.vt.edu [IPv6:2607:b400:92:8300:0:31:1732:8aa4])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id wA5GCGFB021589
        for <linux-kernel@vger.kernel.org>; Mon, 5 Nov 2018 11:12:16 -0500
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id wA5GCBtD005097
        for <linux-kernel@vger.kernel.org>; Mon, 5 Nov 2018 11:12:16 -0500
Received: by mail-qk1-f197.google.com with SMTP id v70so21904547qka.17
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 08:12:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=iuH12R5uMSLHIhmH0OLUQPBkmNCWDBSHAW9X9Pa5tCM=;
        b=QNc3KWXEjSntIfz1PqpF6hX52TK9+ecsIjR1CfABT9lqgocOD/vvUI2pyebtw/Xu4w
         /fZcLcfhN746osYoegIuGl0KEvFx5S0uNMH5hifezsA9sUUQXnXXQhbXc2g/zKE3WDUM
         qy/tPq8usLVad+zmGR+w4GQbfwjvazTukwJgsMUyh1YPusn54fzj2Xxd2erDqkymWo07
         Ho3Fk9lqBL9RBhi1t9gp9GtB4oCWBpZzdLDWcRgTF7176SMvmL7zhaowqC5soRh9C+f+
         tzmqFx+awnsnBcrt6JRNbnw185dYNCYCor4Qq5alanWEdwlwmqY3Z/sUr7lfAx0MHA0T
         Hr4Q==
X-Gm-Message-State: AGRZ1gK2Zy7MAdSZrxlcFNdFkfNPleY2vZ0kpk3YSvZFCdhIK2Ni7OlT
        ZxfRMtf4ps07zr8Ra8qIEoPNo2dPAe8/DpXnHNG1XHx6CWXJGaW8s8oLWGzWMLTpnB09HgKUWSp
        b6hKTSSrq4bhjuTtjIdDzuXYV3QpiO9/hu3s=
X-Received: by 2002:a0c:9c89:: with SMTP id i9mr14243488qvf.153.1541434331449;
        Mon, 05 Nov 2018 08:12:11 -0800 (PST)
X-Google-Smtp-Source: AJdET5dfnI/vJm7Orf8wF/iHuZwZ81D5OEnUlTYiDUVPAOU5W4W3euB6QmoBHMFkhTlBOUyZDPHicw==
X-Received: by 2002:a0c:9c89:: with SMTP id i9mr14243448qvf.153.1541434330946;
        Mon, 05 Nov 2018 08:12:10 -0800 (PST)
Received: from turing-police.cc.vt.edu (turing-police.cc.ipv6.vt.edu. [2001:468:c80:2103:f21f:afff:fe0c:8ada])
        by smtp.gmail.com with ESMTPSA id h66-v6sm27315453qkc.53.2018.11.05.08.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 08:12:09 -0800 (PST)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     linux-mm@kvack.org, open list <linux-kernel@vger.kernel.org>,
        kernelnewbies@kernelnewbies.org
Subject: Re: Creating compressed backing_store as swapfile
In-Reply-To: <CAOuPNLjuM5qq3go9ZFZcK0G5pQxTQb0DY36xu+8SL4vC4zJntw@mail.gmail.com>
References: <CAOuPNLjuM5qq3go9ZFZcK0G5pQxTQb0DY36xu+8SL4vC4zJntw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1541434328_4003P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Mon, 05 Nov 2018 11:12:08 -0500
Message-ID: <40880.1541434328@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1541434328_4003P
Content-Type: text/plain; charset=us-ascii

On Mon, 05 Nov 2018 20:31:46 +0530, Pintu Agarwal said:
> I wanted to have a swapfile (64MB to 256MB) on my system.
> But I wanted the data to be compressed and stored on the disk in my swapfile.
> [Similar to zram, but compressed data should be moved to disk, instead of RAM].

What platform are you on that you're both storage constrained enough to need
swap, and also so short on disk space that compressing it makes sense?
Understanding the hardware constraints here would help in advising you.

> Note: I wanted to optimize RAM space, so performance is not important
> right now for our requirement.
>
> So, what are the options available, to perform this in 4.x kernel version.
> My Kernel: 4.9.x

Given that this is a greenfield development, why are you picking a kernel
that's 2 years out of date?  You *do* realize that 4.9.135 does *not* contain
all the bugfixes since then, only that relatively small subset that qualify for
'stable' (see Documentation/process/stable-kernel-rules.rst for the gory
details).

One possible total hack would be to simply use a file-based swap area,
but put the file on a filesystem that supports automatic inline compression.

Note that this will probably *totally* suck on performance, because there's
no good way to find where 4K block 11,493 starts inside the compressed
file, so it would have to read/decompress from the file beginning.  Also,
if you write data to a previously unused location (or even a previously used
spot that compressed the 4K page to a different length), you have a bad time
inserting it.  (Note that zram can avoid most of this because it can (a) keep
a table of pointers to where each page starts and (b) it isn't constrained to
writing to 4K blocks on disk, so if the current compression takes a 4K page down
to 1,283 bytes, it doesn't have to care *too* much if it stores that someplace
that crosses a page boundary.

Another thing that you will need to worry about is what happens in low-memory
situations - the time you *most* need to do a swap operation, you may not have
enough memory to do the I/O.  zram basically makes sure it *has* the memory
needed beforehand, and swap directly to pre-allocated disk doesn't need much
additional memory.

--==_Exmh_1541434328_4003P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBW+Br2I0DS38y7CIcAQJnHwf/Qs6+ukFbpph4XreLTFTClbciDiZRmurD
2m4lrYl698x3E1MfatqrWUgVyjv6hSrfja1rlxHboSEwxhQu5tCXIyTZhMf3JUi8
UYZeuHBA+2tTr8WCqje9zUAIk4L/fKWFcv6KWJMxXSYQVQsHhFG/zXOMAn7EieDH
xRGECm7Uv4BQJ20S6krgYLEvAPVOBBwXQzFHGUfuNZ6AwjGMGBGlAN92xCg/Ojao
aVU/qGXtjcCsnv3+iEY/ZKN4RqTgE3F0OH+D3UKY7FsT1hXNdGcQTltXQ8CZ7Se+
ZE7RurVFEKvoxdIFswYqwwrD4a+g9mwevwvzt5vRAJE4cimwfwxHWA==
=ThRu
-----END PGP SIGNATURE-----

--==_Exmh_1541434328_4003P--
