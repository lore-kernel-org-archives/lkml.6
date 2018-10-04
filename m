Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF9DC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 22:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25AF2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 22:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFShBZ/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B25AF2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbeJEFb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 01:31:29 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36641 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeJEFb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 01:31:29 -0400
Received: by mail-yb1-f193.google.com with SMTP id 5-v6so4648024ybf.3;
        Thu, 04 Oct 2018 15:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H+F7n2XLPMj9ktJEd1UNah1x5MDeYZsyHaDZcw0IZSc=;
        b=FFShBZ/STyRNIUAPxXVnegGawXrtuTybD+Ym3BLpd5BC7irn2SWk5ePkq9JUBcm49p
         kghjU4hRgKSgqHl7MvKz3nUgt+iZ+zi1ISg7sDQvTJmn5LTbynBMs2oxoFT0Rmv0cIU8
         IzNnsQgbidrS9xDArsJm3V2/5zfXkfizuUJPoFW/rgAyB2oIXK5D7OK3JjJfekMSIO+D
         QQLm9nGaqQuBxeL3WI9/eWZJ9pmq1Sfhc7knrvUzhM4V09NOPEMt0csGmU+saozeqfP9
         J+fk2ieRhqFImFooCBZIU/zoW8w7M++QuM9O+sVqLmRJ9TyrX/CgysJwfC0QSSTPz8Zf
         Jg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H+F7n2XLPMj9ktJEd1UNah1x5MDeYZsyHaDZcw0IZSc=;
        b=cb4fzHs6krO7gmGoXnudMsbnWgrYjMhHLDot0bP1QAZIAFGdP0vktLVymnRl+C7vRY
         KQ9axYP6PVri8hQzTCyRu9wOOFYGhio4b+KHa6+XBrisR2/04YLVsQ5WKvDKvmaA66Pg
         P/sCVSGzdEaenz6gyH3AOhI3uJ1OmDWJiWKk+YnJ683VvZpgQwYSF0zsW4Jn2pptrJwg
         tJtyVUxdty5LFsUXzJemCC/9NJhsONkEhrvVvsLbc/vcbMpdepkxuPhrx+x1FaX40Wfb
         /v2FnMVlvgsVt/RFmsaUGkRrJ/tHbPtidGdtG7aDzsB/2EhLa7OZ8ZtyZtZX4MNYQEZo
         /GVA==
X-Gm-Message-State: ABuFfohiT9AS64gocDkm6jaUFdNom6947SB8J1U3kktvXfDSfFU+GwqD
        KR4STL7z7XPfby8mam3+z9sh3DOFJEZA27WRneHbDI6nKhg=
X-Google-Smtp-Source: ACcGV63pc4COftZwFk2++dCLZu0GBJSuA1PpWDY9ANgk5glL9qNOD0YPJRWkPan5SZMDTb5f8IlH3gVh3SRxvtx2mYQ=
X-Received: by 2002:a25:6788:: with SMTP id b130-v6mr4994070ybc.84.1538692555367;
 Thu, 04 Oct 2018 15:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181004222953.2229-1-hpa@zytor.com> <20181004222953.2229-6-hpa@zytor.com>
In-Reply-To: <20181004222953.2229-6-hpa@zytor.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 4 Oct 2018 15:35:33 -0700
Message-ID: <CAMo8BfJRvmNu=oHb4MaB_M7mdR5dMZRgfHb-Me8En3OoUe5m8g@mail.gmail.com>
Subject: Re: [PATCH 5/5] arch/xtensa, termios: use <asm-generic/termbits.h>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-serial@vger.kernel.org, Chris Zankel <chris@zankel.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        linux-xtensa@linux-xtensa.org, Jiri Slaby <jslaby@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 3:30 PM H. Peter Anvin (Intel) <hpa@zytor.com> wrote:
>
> The Xtensa definition of termbits.h is identical to the generic one.
>
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: <linux-xtensa@linux-xtensa.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> ---
>  arch/xtensa/include/uapi/asm/termbits.h | 222 +-------------------------------
>  1 file changed, 1 insertion(+), 221 deletions(-)

Looks good. But why not removing the header entirely and adding
generic-y += termbits.h
to arch/xtensa/include/uapi/asm/Kbuild?

-- 
Thanks.
-- Max
