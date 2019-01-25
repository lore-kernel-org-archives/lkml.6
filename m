Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9705C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E02218DE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dq6SWCA9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfAYLji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:39:38 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39746 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfAYLjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:39:37 -0500
Received: by mail-lf1-f68.google.com with SMTP id n18so6702767lfh.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 03:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lL+ZS/fRD9ZcacHB0crQpdSxoRtgx8tCRTMbNabO9KE=;
        b=dq6SWCA9TOkWoH1jxBgwspRoaRwFgomzc6D6fCe51P8yQI9NiC61XkiqRhygbf/Ns7
         1QObKThtJ0OwLlkXQ8VOLSstwpOA/G7e2heMbkovFRFB7VkPBl6yB2y4tpFYyFG0GvNO
         Y4B9mzW9k/a5zduAgsMOuKnLX6nF8Fbr3nw9+u2nAEW7L2iKiTP+BXgzRWh0FEYskM7E
         ULfnVmDfDTqsb22GGCtip+53Vm37qN1rHU7cbX8BGa9x1Ikvee+tnF36WT3+uW3yanXP
         49Kt1LBNXZcwP2ca5Z/gR/XsP2b/Abvx9f3yu6cUcaGrtFBk3+ctwOxxmaWXTU39qKdS
         BaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lL+ZS/fRD9ZcacHB0crQpdSxoRtgx8tCRTMbNabO9KE=;
        b=Wes2LEbIIuTuD95h1jcyA5W8wLJR3RVUcKnGyEr1PJwSEJaVWT8E/90iPP15t9CjIA
         hvaPk0LfAo69J38zF/2sbZUf1WaXenGyFmi2b0DHdFDdbI/baqOwqSe8HlAT+iQyE0cn
         wnxF6dTovccOKTC6ai22PcB+q/SjeR/6KX4O4bXJA9TUuZkjEB21mhbUjvRqaZwtJivJ
         36VVdneeZ1PaYPym84bV0dwaHTtpq/UJhT5Pzjwg7jbmNgcUNYfhQ6twO7NilgHwHZrL
         FOLA0fby5Wl6/WM2PBy9pHFw2Yn03TYFRopITirgCYi+KYQ/QJ7SfWHALlrwYc9Q1VLd
         ZLzQ==
X-Gm-Message-State: AJcUukekZHUPM1hOHDKHpCgjGfFdaMXnbGOlgC+EEU/D37CDn7H7mWrp
        bKRbNs6u0nuQ/CUbWU0Sw+gC81Xib44qqJKy5bs=
X-Google-Smtp-Source: ALg8bN6xboiBCBEuEvYyAjczKxJB2bn2qIOEpjIyxh8HLCsARB1WXcn72Tme39TlkM4PplZMYJ9Ljhi4uvJ14kWQdlI=
X-Received: by 2002:a19:a84e:: with SMTP id r75mr7537595lfe.45.1548416375852;
 Fri, 25 Jan 2019 03:39:35 -0800 (PST)
MIME-Version: 1.0
References: <20190125104353.2791-1-labbott@redhat.com> <CAK8P3a0xnc7RNbGhG7-hj+ay2keR7dh7MmDiUNKxfewsnatsgA@mail.gmail.com>
In-Reply-To: <CAK8P3a0xnc7RNbGhG7-hj+ay2keR7dh7MmDiUNKxfewsnatsgA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 25 Jan 2019 12:39:24 +0100
Message-ID: <CANiq72=nMYcohMk29fzs3bMut1PXwfqYLZdbRh_AeTN-Z4FpxQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] Update -Wattribute-alias for gcc9
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Laura Abbott <labbott@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Martin Sebor <msebor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 11:58 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Jan 25, 2019 at 11:43 AM Laura Abbott <labbott@redhat.com> wrote:
> >
> > Commit bee20031772a ("disable -Wattribute-alias warning for
> > SYSCALL_DEFINEx()") disabled -Wattribute-alias with gcc8.
> > gcc9 changed the format of -Wattribute-alias to take a parameter.
> > This doesn't quite match with the existing disabling mechanism
> > so update for gcc9 to match with the default (-Wattribute-alias=1).
> >
> > Signed-off-by: Laura Abbott <labbott@redhat.com>
> > ---
> > This is RFC because it feels ugly. I went ahead and did the obvious fixup
> > but it's worth discussing if we're going to end up with an explosion or
> > if there's a better way to handle this in one macro.
>
> Bernd Edlinger has sent a patch to gcc for this:
> https://gcc.gnu.org/ml/gcc-patches/2019-01/msg01120.html
>
> and Miguel Ojeda said he wanted to send a patch for it to the
> kernel as well, not sure if he wanted to take a different
> approach there, so adding both to Cc here.

Thanks Arnd (I was working with Martin on the expanded
-Wmissing-attribute warnings, not on this, but thanks nevertheless :).

Martin/Bernd: from the GCC mailing list I am not sure if we should
expect the old behavior to be maintained or not.

Cheers,
Miguel
