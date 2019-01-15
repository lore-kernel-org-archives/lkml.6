Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB335C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944D020657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Lz8/VpBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732625AbfAORRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:17:42 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:32993 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728886AbfAORRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:17:42 -0500
Received: by mail-io1-f67.google.com with SMTP id t24so2700293ioi.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 09:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OyTWDGjB04njMwsJJg++MJFclcQB0WwiuSGTWP72bao=;
        b=Lz8/VpBQBg9euPlPuE3cH1KxMTOGd5Rv1KU30bRzWfQOgpwAWL4UmW9ioOyUm22N6P
         ZLjksmvypvb0QuQe5TlvppW0ws6ereoHPJm3+CtmmFBo2hygTe3M+fOS7fYixDal8+wB
         g8HPWZtWJwsTKKPb+eO5tKXi+1AtJD1Tq+7tIoJrNNEZH6auJ4QmIhrcxHJBPIFg8Qk2
         n942cAdmSPaZZTIU0PJMVLWTNDVjAjrVWXKbqU1LowvHfhzmeOCa8W9YIDUqHlEgG0k9
         mM4BCog/mblnuF2+BFAnWtIrHaptDAi123wS2RG+phIi+h7/TQNiOqFTbsESuR+rUNVh
         3G5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OyTWDGjB04njMwsJJg++MJFclcQB0WwiuSGTWP72bao=;
        b=X7QMjnLeCD6K3FJsAsv7Y3tOuDc41THqor/XHpXHRjIXnBgEl30WSUotBLaLEMgfnm
         ct10akaxgSsMgGpU75YRsEU00fEE/W1J8YT7P3Mzxp6B90nQrbYZA8WV1YtNRpVzuHub
         OYFkVwcZrcXRR5mZAFsRk7Ghlwfy02oNVAF9tij89r30/70+VrxHNRSPGKA0KedvXJdW
         SYdtT6W0IqDgzGgsawTM/TvcCo0zRCmghyq38wd+hPK1KN4iBaTfrw8pjqnBfor7mF2O
         ZdoYUK5Vsm4tUIgaS9AoNCWrgWxJlw8TWJetliKfrYUrQ/lb6aa5eANgfhcShfGx5SOc
         PMcQ==
X-Gm-Message-State: AJcUukesZA9kxV5xn0QemVpKBqlWJVuoss5AXt03aG55XOZEe8ZRigpr
        mIfG3zFnXdW+xn3/zu8TtmSW5/jNaFRvlo5UTzmK+g==
X-Google-Smtp-Source: ALg8bN6+NkI4MSEtHcJA5JExc6UAEsP+8T2ckmtM7ADijpiq1c3056xWHNsqJfLW60/Xd6baPbF/C8nYFc88HBLV04I=
X-Received: by 2002:a5e:c107:: with SMTP id v7mr2805592iol.155.1547572661412;
 Tue, 15 Jan 2019 09:17:41 -0800 (PST)
MIME-Version: 1.0
References: <20190115164435.8423-1-olof@lixom.net> <20190115170510.GA4274@infradead.org>
In-Reply-To: <20190115170510.GA4274@infradead.org>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 15 Jan 2019 09:17:30 -0800
Message-ID: <CAOesGMg4hd8z=2FVDTYMiuKzHnobNLnncV37j77BA+gQGg=heg@mail.gmail.com>
Subject: Re: [PATCH] mm: Make CONFIG_FRAME_VECTOR a visible option
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 9:05 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Jan 15, 2019 at 08:44:35AM -0800, Olof Johansson wrote:
> > CONFIG_FRAME_VECTOR was made an option to avoid including the bloat on
> > platforms that try to keep footprint down, which makes sense.
> >
> > The problem with this is external modules that aren't built in-tree.
> > Since they don't have in-tree Kconfig, whether they can be loaded now
> > depends on whether your kernel config enabled some completely unrelated
> > driver that happened to select it. That's a weird and unpredictable
> > situation, and makes for some awkward requirements for the standalone
> > modules.
> >
> > For these reasons, give someone the option to manually enable this when
> > configuring the kernel.
>
> NAK, we should not confuse kernel users for stuff that is out of tree.

I'd argue it's *more* confusing to expect users to know about and
enable some random V4L driver to get this exported kernel API included
or not. Happy to add "If in doubt, say 'n' here" help text, like we do
for many many other kernel config options.

In this particular case, a module (under early development and not yet
ready to upstream, but will be) worked with a random distro kernel
that enables the kitchen sink of drivers, but not with a more slimmed
down kernel config. Having to enable a driver you'll never use, just
to enable some generic exported helpers, is just backwards.


-Olof
