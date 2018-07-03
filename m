Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E45AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45B52409E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="voXQjSqX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fgw9s55f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45B52409E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752882AbeGCTrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:47:49 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:45501 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752105AbeGCTrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:47:45 -0400
Received: by mail-yw0-f195.google.com with SMTP id 139-v6so1115692ywg.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 12:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=KD+HOwwNalxBCmzQCfW128ExrNZBpJ3xfT+/mpHfl6k=;
        b=voXQjSqXK9rRqxY5QDljiYx6KSM4+Z1jJEWWHbaFy7KpGpTnPKxxmFR1ulCjgXt3WN
         ybep39sBZq6tuGVZTwsfCBkwEK3pNl9f9r/4/pDZKrRRRSkc+iP9Gq/dnCWBZZI9ovu4
         cLoxycM3Vf5HQpDaEuVOzBmEhhrAPX1HOu0JQKXOxJ8bOOC9LQiH2y+xpNRWuwmmzhjw
         k4w9wNL3gxri/kdigtIu9w7jT03Fxm90XEMqzDgqWFjKncxiFV9egx/qGsYts3hJ530N
         pfltw+SdNzGgDg0N5CTRRhJkgLY2VoOcPzSdjRc68dYDGZ29SvS+WudpAWcuZgFFvUeD
         K36w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=KD+HOwwNalxBCmzQCfW128ExrNZBpJ3xfT+/mpHfl6k=;
        b=Fgw9s55fIg9E1E78jWIsMWYkHAh65n1K0Zhx82o1O3MKSyCVXES2Izm4/y2QgZDn9n
         j6b+YmPTopgbH2dfXHqKqRZXfN5ASfb53fks+3BFac8DeKx5wj9SxG5W7FmBhaLYKtgi
         BLq/F/oIPYNbPtY5kG1nnSl3JQbuRFTDCzJZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=KD+HOwwNalxBCmzQCfW128ExrNZBpJ3xfT+/mpHfl6k=;
        b=kVvntJaIqdjSqtsjjAanActtRHXG8iE7LoXvEow1wNu27VY5Zl8PJ2oMbnW4eRt8iv
         tlVRdZtOIihuvs07Aixu5fWwsm4nAtciq8qNHBYEKhrkcvrO/SoO9QmIc9klqm4FnGcK
         vYbwRS5W6XIFX3BFceO+lB+hzK425MIzFaqrOqWqx9TPncssXwnEzrDPPZktYpO60e0P
         mhVsZ7qCFbW+74LZ25bHsheyNPC0ze7jWyISE2ykKdax//AidSWiv0SEx828ksyA726Q
         BymJxadX2FsWAjuhYST7Y+HpLHZKPfew8S5SoaT5ryQGtsYl1E0OBnlMsIvX2eI/0wdB
         q+pA==
X-Gm-Message-State: APt69E1DmLJSJnTiFhfhlwtvvJUYwkHkkKN4FbXtfnfP8D1N6tMNpDkl
        iBW8Tt7imY1hDa6iKF5vuediieikEt8grgXWpARUwA==
X-Google-Smtp-Source: AAOMgpf4lXDwlLKY/66mqaY6XCkETlQ4eFKJCg7DmHnJVpMPrVBA+j/T48Ww72aGEgertMBKwPQJUVPioTcYo+sfKIY=
X-Received: by 2002:a81:39d7:: with SMTP id g206-v6mr8836541ywa.416.1530647265006;
 Tue, 03 Jul 2018 12:47:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 12:47:44 -0700 (PDT)
In-Reply-To: <20180703194354.21614-1-willy@infradead.org>
References: <20180703194354.21614-1-willy@infradead.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 3 Jul 2018 12:47:44 -0700
X-Google-Sender-Auth: Ghn_9WD_45oOKAM9O06_vNeAUAc
Message-ID: <CAGXu5jKN2HTno=1MfAug+pn0yf82tV-YAWURpx6v_xk7spc4mA@mail.gmail.com>
Subject: Re: [PATCH] reed_solomon: Fix kernel-doc
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 12:43 PM, Matthew Wilcox <willy@infradead.org> wrote:
> The current doc build warns:
> ./lib/reed_solomon/reed_solomon.c:287: WARNING: Unknown target name: "gfp".
>
> This is because it misinterprets the "GFP_" that is part of the
> description.  Change the description to avoid the problem.
>
> Signed-off-by: Matthew Wilcox <willy@infradead.org>

Acked-by: Kees Cook <keescook@chromium.org>

Jon can you take this?

-Kees

> ---
>  lib/reed_solomon/reed_solomon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/reed_solomon/reed_solomon.c b/lib/reed_solomon/reed_solomon.c
> index d8bb1a1eba72..e5fdc8b9e856 100644
> --- a/lib/reed_solomon/reed_solomon.c
> +++ b/lib/reed_solomon/reed_solomon.c
> @@ -283,7 +283,7 @@ static struct rs_control *init_rs_internal(int symsize, int gfpoly,
>   *             in index form
>   *  @prim:     primitive element to generate polynomial roots
>   *  @nroots:   RS code generator polynomial degree (number of roots)
> - *  @gfp:      GFP_ flags for allocations
> + *  @gfp:      Memory allocation flags.
>   */
>  struct rs_control *init_rs_gfp(int symsize, int gfpoly, int fcr, int prim,
>                                int nroots, gfp_t gfp)
> --
> 2.18.0
>



-- 
Kees Cook
Pixel Security
