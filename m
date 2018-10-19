Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E416CECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD7521476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD7521476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbeJTC4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 22:56:39 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:35522 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727770AbeJTC4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 22:56:39 -0400
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w9JInKOU018933
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 14:49:20 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w9JInFlk028836
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 14:49:20 -0400
Received: by mail-qk1-f199.google.com with SMTP id y201-v6so36824160qka.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 11:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=rpWcHs7QjgVgvMYBkCCy+N/bC7/0xCUlUJeesVOVucA=;
        b=b0HMWF3VBzoByj6j3NhGgIOzYDA68W0S2cfHa5N1eGvjGmg85UCPa1yxwHlOKhZoXP
         37IXb0tjMioPbY10tGdi8+iY8QO3tXAq48yCCvrQqS4zEWNCqgbFnl/QN++oKRLgslsq
         a+xE+jf7oUqDgzDlF3hCxxhXGr80RpC7FSkBHAQ8u9duRzVcjop01Ovrx+3qvU4EfqC3
         CqTNFxBP47KpqWIy02pXhH/2QHaUIgDd/8gqpb/22+5Q8Nx/QiFBW2ArvcNoSWBv2qqy
         OClLQJM95fkuMWUr+FuwiTHxk7ibWM5z1VmFQ3pOe7zldY6E8h1+YadZNuLEAsuxVAsi
         HQAg==
X-Gm-Message-State: ABuFfohZd4ThLKVDlwmJj7DPNTpu+N2++XddpqEbB9ahRG6NLLuDkmi8
        GvgtouP105BP+CBoKCdUbnf5TghbIAokCpvEoStFKt9izFRVDB6dLxJ0fmxvOQhdv+hxfAnN4EI
        GNy65/h0PWPIDfWTbBcPeFuJAdcreilg8Tgw=
X-Received: by 2002:a37:2825:: with SMTP id o37-v6mr6693167qkh.350.1539974954944;
        Fri, 19 Oct 2018 11:49:14 -0700 (PDT)
X-Google-Smtp-Source: AJdET5fY5eJY7KhRo4eOXdYZD8iVavTJlGwYdLjbpXnbEmTaFLUZ2rQSmeCJKbzP03lS9o1frCvOgg==
X-Received: by 2002:a37:2825:: with SMTP id o37-v6mr6693140qkh.350.1539974954529;
        Fri, 19 Oct 2018 11:49:14 -0700 (PDT)
Received: from turing-police.cc.vt.edu (turing-police.cc.ipv6.vt.edu. [2001:468:c80:2103:f21f:afff:fe0c:8ada])
        by smtp.gmail.com with ESMTPSA id k39-v6sm4792358qtf.3.2018.10.19.11.49.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 11:49:12 -0700 (PDT)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        John Reck <jreck@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Colascione <dancol@google.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, marcandre.lureau@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/2] mm: Add an F_SEAL_FUTURE_WRITE seal to memfd
In-Reply-To: <CAEXW_YTS2n2tOpXs3eVQZhYu7tmM_at0ZBA-04qYkHw4UE80nw@mail.gmail.com>
References: <20181018065908.254389-1-joel@joelfernandes.org> <42922.1539970322@turing-police.cc.vt.edu>
 <CAEXW_YTS2n2tOpXs3eVQZhYu7tmM_at0ZBA-04qYkHw4UE80nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1539974951_3102P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Fri, 19 Oct 2018 14:49:11 -0400
Message-ID: <118792.1539974951@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1539974951_3102P
Content-Type: text/plain; charset=us-ascii

On Fri, 19 Oct 2018 10:57:31 -0700, Joel Fernandes said:
> On Fri, Oct 19, 2018 at 10:32 AM,  <valdis.kletnieks@vt.edu> wrote:
> > What is supposed to happen if some other process has an already existing R/W
> > mmap of the region?  (For that matter, the test program doesn't seem to
> > actually test that the existing mmap region remains writable?)

> Why would it not remain writable? We don't change anything in the
> mapping that prevents it from being writable, in the patch.

OK, if the meaning here is "if another process races and gets its own R/W mmap
before we seal our mmap, it's OK".  Seems like somewhat shaky security-wise - a
possibly malicious process can fail to get a R/W map because we just sealed it,
but if it had done the attempt a few milliseconds earlier it would have its own
R/W mmap to do as it pleases...

On the other hand, decades of trying have proven that trying to do any sort
of revoke() is a lot harder to do than it looks...

> We do test that existing writable mmaps can continue to exist after
> the seal is set, in a way, because we test that setting of the seal
> succeeds.

Well, if the semantics are "We don't bother trying to deal with existing R/W
maps", then it doesn't really matter - I was thinking along the lines of "If we're
revoking other R/W accesses, we should test that we didn't nuke *this* one in
the bargain"....

--==_Exmh_1539974951_3102P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBW8onJ40DS38y7CIcAQK8gAgAn0hFoG/7NzVOy5Rst3e/VtBaNha/e3V0
N+mOczsxE3dMEijB1Uyu9c9Lzla9XW612XLu/DIgfET40+gYywBE39PQQovZomc3
QEc1GfcRkVUQqncDVvKSAN9JQ7QdWLTvqAva+ChFl8+yAn2Y7hCqg+WHKT7XMqVZ
IQl7IZxHgfik1Id2h5IizZgSeBS91WoYehfIrgH59TcFA+Fjek8beOJpBvC4es3m
jDyp2LTlACh55TkUM3N7pQtKsNGSMUSekMG+ylFykgY76LS+K1rS9KBpABMFZL0Y
+McJX3of+FHEVoJy2W42G6+SRr82+4pVysAeVa8XxGRvS/wvMgTySQ==
=GvDD
-----END PGP SIGNATURE-----

--==_Exmh_1539974951_3102P--
