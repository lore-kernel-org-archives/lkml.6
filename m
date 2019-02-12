Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E47CC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 22:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A636222C1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 22:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KCefmLnY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732772AbfBLWJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 17:09:06 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:41023 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732475AbfBLWJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 17:09:03 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0446421FCF;
        Tue, 12 Feb 2019 17:09:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 12 Feb 2019 17:09:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=jjsJfDJ5AeozBndfILDk41FzdMwQALwKz0c3yRLMG
        dM=; b=KCefmLnYnjaLEH4mUsHeLE9vuu+y260fD8mOmM+CrZDU+u7PSr0xvyn4W
        BZAhtP8JIgKLSLU+oYuosRA59yLZj0P4qWEYuFYooi0cuLTx7eF7GYxK7x/sHAc+
        tORQ0ZmLnJHGersNOeeTnfo/Qn2fQ2kL5qrAfowyLOlRtiYjrsjPsAC0ssrHPZXj
        eN+0phRns9aFLAG/8uJEsGl+kCnUtIf+fru5FOW1j0ztP9D9P+wVh6kCbYs0JwRV
        OGjnz7aIeTzdT067F14g+IEl9X3wlSloje+k3HfmnmH0tANRU8C4syuwQ8B0VKlM
        rKH5bcR53Jmsvofp8Xt+ExyOeH28A==
X-ME-Sender: <xms:_UNjXOY_SLA01i6VtIWBlSGqzM3isuXHyh2Oc50aemvwTylvhE80Nw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddtuddgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
    fedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhfff
    gjkfgfgggtgfesthhqredttderjeenucfhrhhomhepuegvnhcuhfhinhhnvgihuceosghi
    ghhnohhsvgesuggvsghirghnrdhorhhgqeenucfkphepuddutddrvdefvddrudduvddrud
    eileenucfrrghrrghmpehmrghilhhfrhhomhepsghighhnohhsvgesuggvsghirghnrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:_UNjXP7DmB24fusz0PuIB5fVDOT5CJr1fYTC4-mu4wcpY6ORCGjZCg>
    <xmx:_UNjXPQrwMAocjL4bTQwIAPchBXxa3CM93PSIYOxjd8B4OXaCgbxbw>
    <xmx:_UNjXHMqwRuB1xy4_2dbEOLclf4Js9kZUxfDt06l14NQSpAbSeRqSg>
    <xmx:_kNjXEno4wsPi9QhkIgUtugWeOM8zlMkqZOtC7vov0RW2yeAgyrTiw>
Received: from localhost (illuin.whitetree.org [110.232.112.169])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9F41DE4669;
        Tue, 12 Feb 2019 17:09:00 -0500 (EST)
From:   Ben Finney <bignose@debian.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ben Finney <bignose@debian.org>,
        Martin Steigerwald <Martin.Steigerwald@proact.de>,
        Domenico Andreoli <cavok@debian.org>, 919356@bugs.debian.org,
        Kristian Fiskerstrand <k_f@gentoo.org>,
        Nadia Yvette Chambers <nyc@holomorphy.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "debian-legal\@lists.debian.org" <debian-legal@lists.debian.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <jens.axboe@oracle.com>
Subject: Re: Bug#919356: Licensing of include/linux/hash.h
References: <20190115170017.5gxarqxzfezgr5ld@dumbo>
        <c3aa1b37-60bb-aceb-10ba-9768157a2a5a@gentoo.org>
        <20190211072259.GA19224@nouveau>
        <20190115083241.6c6ftrw73xuv26j6@dumbo> <2977287.v5rPGuGa1n@merkaba>
        <86va1p7c7z.fsf@benfinney.id.au>
        <8a87da85-3aef-a113-f93f-c96ab465c96f@kernel.dk>
X-Public-Key-ID: 0xAC128405
X-Public-Key-Fingerprint: 517C F14B B2F3 98B0 CB35  4855 B8B2 4C06 AC12 8405
X-Public-Key-URL: http://www.benfinney.id.au/contact/bfinney-pubkey.asc
Date:   Wed, 13 Feb 2019 09:08:57 +1100
In-Reply-To: <8a87da85-3aef-a113-f93f-c96ab465c96f@kernel.dk> (Jens Axboe's
        message of "Tue, 12 Feb 2019 09:16:00 -0700")
Message-ID: <86k1i47j7q.fsf@benfinney.id.au>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 2/11/19 11:27 PM, Ben Finney wrote:
> > If, on the other hand, the file is to be free software, there would need
> > to be a clear grant of some free software license to that work.
>
> FWIW, fio.c includes the following mention:
>
>  * The license below covers all files distributed with fio unless otherwi=
se
>  * noted in the file itself.
>
> followed by the GPL v2 license.

Great! That does appear to be a positive assertion from the copyright
holder, that we have a grant to use that work under GPLv2.

That written grant of license can be used in the Debian package to
demonstrate our license to the work.

> I'll go through and add SPDX headers to everything to avoid wasting
> anymore time on this nonsense.

Not necessary from my point of view for this specific case, because we
have the clear explicit grant of license. Don't let me stop you from
doing the good work of documenting more clearly :-)

--=20
 \       =E2=80=9CCome on Milhouse, there=E2=80=99s no such thing as a soul=
! It=E2=80=99s just |
  `\      something they made up to scare kids, like the Boogie Man or |
_o__)                          Michael Jackson.=E2=80=9D =E2=80=94Bart, _Th=
e Simpsons_ |
Ben Finney
