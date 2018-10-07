Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6B1C65C30
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 08:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526552088F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 08:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526552088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=corsac.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbeJGQBZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 12:01:25 -0400
Received: from pic75-3-78-194-244-226.fbxo.proxad.net ([78.194.244.226]:33458
        "EHLO mail.corsac.net" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbeJGQBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 12:01:25 -0400
Received: from scapa.corsac.net (unknown [IPv6:2a01:e34:ec2f:4e20:6af7:28ff:fe8d:2119])
        by mail.corsac.net (Postfix) with ESMTPS id E055D8E
        for <linux-kernel@vger.kernel.org>; Sun,  7 Oct 2018 10:54:47 +0200 (CEST)
Received: from corsac (uid 1000)
        (envelope-from corsac@corsac.net)
        id a0205
        by scapa.corsac.net (DragonFly Mail Agent v0.11);
        Sun, 07 Oct 2018 10:54:46 +0200
Message-ID: <5b06d90e5fd23633af4dfbb5f9c6cfa7607152cc.camel@corsac.net>
Subject: Re: [PATCH] yama: clarify ptrace_scope=2 in Yama documentation
From:   Yves-Alexis Perez <corsac@corsac.net>
To:     Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, trivial@kernel.org
Date:   Sun, 07 Oct 2018 10:54:42 +0200
In-Reply-To: <be02c1974b028efcc2a0ec49dfedff456a78e156.camel@corsac.net>
References: <20181002204722.GA9610@scapa.corsac.net>
         <20181002205259.GA16090@bombadil.infradead.org>
         <be02c1974b028efcc2a0ec49dfedff456a78e156.camel@corsac.net>
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1-1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On Tue, 2018-10-02 at 23:08 +0200, Yves-Alexis Perez wrote:
> On Tue, 2018-10-02 at 13:52 -0700, Matthew Wilcox wrote:
> > On Tue, Oct 02, 2018 at 10:47:23PM +0200, Yves-Alexis Perez wrote:
> > > Current phrasing is ambiguous since it's unclear if attaching to a
> > > children through PTRACE_TRACEME requires CAP_SYS_PTRACE. Rephrase the
> > > sentence to make that clear.
> > 
> > I disagree that your sentence makes that clear.  How about:
> > 
> > >  2 - admin-only attach:
> > > -    only processes with ``CAP_SYS_PTRACE`` may use ptrace
> > > -    with ``PTRACE_ATTACH``, or through children calling
> > > ``PTRACE_TRACEME``.
> > > +    only processes with ``CAP_SYS_PTRACE`` may use ptrace, either with
> > > +    ``PTRACE_ATTACH`` or through children calling ``PTRACE_TRACEME``.
> > 
> > +    only processes with ``CAP_SYS_PTRACE`` may use ptrace.  This
> > +    restricts both ``PTRACE_ATTACH`` and ``PTRACE_TRACEME``.
> 
> Hi Matthew,
> 
> I'm no native speaker, both versions are fine by me but I liked keeping the
> “children calling” part since the semantics are quite different for
> PTRACE_ATTACH and PTRACE_TRACEME.
> 
Hi Kees, Matthew,

so what's the status on this? Who needs to acknowledge one wording or another?

Regards,
- -- 
Yves-Alexis
-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8vi34Qgfo83x35gF3rYcyPpXRFsFAlu5ydIACgkQ3rYcyPpX
RFt7oAgAued/FsFiGvk6U/RG3JEj5p5aRu6harAXqK/Mw8n1gEu0nGvZvFJn31eY
fcU8quTtbmiNR2oYrAxjri2dhVd2JLsKDZU1bhpcKk33jDOzhUjeKnJgLGY38Z01
5idfKSy0CEZ0FvYvpt7gOm3loFlbM0au9JgFszVwFM8Yartr5vH1mPlZUwGbrroH
RORqAkwVI+g8iK1vqq9fdCf9J5mwcYu0DR8STvP8Nx12zEDNeiCShvXDNNt5VKg3
BHVNPHvE8uKaZmlyYt1oy9ZKjjcHn6veVkKEKFRz/TVc+q/Z7G1cORzVb7GzIPGj
9GoIZP2+Wi+7KUqUYQnHZSfujd5BzQ==
=jfBM
-----END PGP SIGNATURE-----
