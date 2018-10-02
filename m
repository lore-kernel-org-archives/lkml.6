Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82980C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347FE20684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N/J0/eiN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347FE20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeJCFkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:40:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37522 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeJCFkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:40:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id j23-v6so686151pfi.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 15:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fcNqPMZ/7mmomTXFADbTDu4kQbO/WCOudVHQEbw3XIc=;
        b=N/J0/eiNir/DB78AaQ8HaGzGK+4z/4HoM6VobDayZHEJ0U35GXaZJXhmvJ3xF5mIKU
         mKx/KRPZuXb60XDIzuSrOKw0+j5RrGj1UtKS5W1pbjpDYuiBgAjMwZRQAa1yyQOTywel
         WjWaBA8HLXLYLYtA+6a5qPpE0EVcNa57QSN1lqpmi1YvbEaXJrYSsMB4MWYQV/L7nBkk
         XlX/EAEVNPsnjgsSTD+s/hfsQr4LFvbU52m/DjnoC5n7d4NsW7mH8gzmJsBUdsWrLAN0
         hsxY+XgR9oF6J5rf0JYPLJsnBNW91EK+osZD1oAqVK9g+QW4ijcQKx7bo5kSk4fwNGZt
         N0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fcNqPMZ/7mmomTXFADbTDu4kQbO/WCOudVHQEbw3XIc=;
        b=kwAm1Bv1/0EVZ8LghFdHQCnyNlveT9/EU9IbXeQrWaezBq8GkQpSUGntVJxUUMPtFy
         30uaGa/6vZfPcLQeL3o+2G92jUZdU4aQgdNHNmzoEc4tZdOfl3+eiGHbQqZLO4K1lEOe
         Q8mVcE2pjlcNHzhsYsGHpeV7he2jasgITOgcsHTHafHo+dMIyHO0iOiSzSg7E2bhU4oI
         jf4j0Iz0rniMs03xcOTnqUKNVSUhoYsP7DDrUxDBqjufnrJ1Ulzk0tsk/y6/tqk94Znx
         CvHiY9YCyCQoM9bO2v1lQn/i+5cIlPc9tTY422QLTMtz3DCxLImZXY6s7aNVPMZXZFEd
         ODNQ==
X-Gm-Message-State: ABuFfoiMjV00e/A+ZVDYwQwpPKJxL45d3bOOMBGSRv9QOw23O2sRVJLA
        fLoOjHCotQyFNkmvdg8hsHQ7hh84dJTaLpVg9LFydg==
X-Google-Smtp-Source: ACcGV620NMY3I97dK7LkGADzjZAYuvKgAuEFifEmzyWg01T4bHNhodZwfGooHHq24sdealhnZ2hotwwwf5wgdbD++aY=
X-Received: by 2002:a63:1921:: with SMTP id z33-v6mr16471761pgl.302.1538520878534;
 Tue, 02 Oct 2018 15:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20181001035143.30670-1-natechancellor@gmail.com>
In-Reply-To: <20181001035143.30670-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 2 Oct 2018 15:54:27 -0700
Message-ID: <CAKwvOdknwESEUK2UTZoTfC9U8vXcVrmpx_1=4jpMxQ25hM=vKA@mail.gmail.com>
Subject: Re: [PATCH] cxgb4: Use proper enum in cxgb4_dcb_handle_fw_update
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     ganeshgr@chelsio.com, "David S. Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 8:54 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when one enumerated type is implicitly converted to another.
>
> drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.c:303:7: warning: implicit
> conversion from enumeration type 'enum cxgb4_dcb_state' to different
> enumeration type 'enum cxgb4_dcb_state_input' [-Wenum-conversion]
>                          ? CXGB4_DCB_STATE_FW_ALLSYNCED
>                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.c:304:7: warning: implicit
> conversion from enumeration type 'enum cxgb4_dcb_state' to different
> enumeration type 'enum cxgb4_dcb_state_input' [-Wenum-conversion]
>                          : CXGB4_DCB_STATE_FW_INCOMPLETE);
>                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 2 warnings generated.
>
> Use the equivalent value of the expected type to silence Clang while
> resulting in no functional change.
>
> CXGB4_DCB_STATE_FW_INCOMPLETE = CXGB4_DCB_INPUT_FW_INCOMPLETE = 2
> CXGB4_DCB_STATE_FW_ALLSYNCED = CXGB4_DCB_INPUT_FW_ALLSYNCED = 3

Yep looks good.  There's not too many users of cxgb4_dcb_state_input
in the kernel.  I wonder if it could even be replaced entirely with
cxgb4_dcb_state?  But for now this patch fixes the warning correctly.
Thanks for sending it.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Looks like this was the second case of this warning in this code (I
thought I was having Deja Vu; that I had already reviewed this patch
earlier): https://lkml.org/lkml/2018/10/1/255 Probably could have been
a single patch, but that's ok.

>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.c
> index 6ba3104ff7eb..9bd5f755a0e0 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_dcb.c
> @@ -300,8 +300,8 @@ void cxgb4_dcb_handle_fw_update(struct adapter *adap,
>                 enum cxgb4_dcb_state_input input =
>                         ((pcmd->u.dcb.control.all_syncd_pkd &
>                           FW_PORT_CMD_ALL_SYNCD_F)
> -                        ? CXGB4_DCB_STATE_FW_ALLSYNCED
> -                        : CXGB4_DCB_STATE_FW_INCOMPLETE);
> +                        ? CXGB4_DCB_INPUT_FW_ALLSYNCED
> +                        : CXGB4_DCB_INPUT_FW_INCOMPLETE);
>
>                 if (dcb->dcb_version != FW_PORT_DCB_VER_UNKNOWN) {
>                         dcb_running_version = FW_PORT_CMD_DCB_VERSION_G(
> --
> 2.19.0
>


-- 
Thanks,
~Nick Desaulniers
