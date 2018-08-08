Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E366C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD70C21ADE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dev-mellanox-co-il.20150623.gappssmtp.com header.i=@dev-mellanox-co-il.20150623.gappssmtp.com header.b="acRJq6ZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD70C21ADE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dev.mellanox.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731232AbeHIAsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 20:48:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36164 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbeHIAsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 20:48:31 -0400
Received: by mail-lj1-f193.google.com with SMTP id u7-v6so2963753lji.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 15:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NWLh2sbe9wk0ZGfGjrIy+Ad/qCPkImVBlM5d8V4We9c=;
        b=acRJq6ZR0G01hjJAdDRGGUcMf/nFAMkU7cANzqMoG0YzGzDZmHqF1iPHOrMiLo2e4F
         zpDHS5k3WviAFFIsmaTDhS1X2/XGlAKf5rWMXr4QMOQRUU9p3q0bOvNJ9af2V/aMurUI
         uIhA690DSkdm4VPhcWnogTnnWtjO9XFZEOQJaIY0c8g/F440M+WUsBhg0hCv+jzm3xDx
         VjFip9Fn9PoFCkUYtNFcTO4qmz+zDvt/QuIECevEHciUMp8AaFjo1RnTWiBR+XWn3ZkQ
         KxesvUOPYrXGIBNaz8TAIyRXzD48NTyocKS3ZCXLUaC5xV/23IQeMfAVXyRY49Yvvo7C
         cQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NWLh2sbe9wk0ZGfGjrIy+Ad/qCPkImVBlM5d8V4We9c=;
        b=hTLF/4PkOqrR4gGrl3gBetJUgIgXuPrJd9LfW8gmMQ0t0jG9WWnpUISufrpZb5+aU8
         ov3IqPULx5YRcibDpZOK08wICIdjPY2fMvKvi/Dv99WgvDn+z5ytQjbEe5fRHvul2VqH
         jBjkBKZfzpvAYI3wzYgXsaeMwaYyDDPHTMjFnt83SVjRnEfdfplBhFDD8zUKi6O6t6FC
         9/Ibt2ESn3a9JQgWaqgtSSzp/GFBdB+j2iX7z/vTWtdsBmbRlVXEsEdxGFtQnpSvsTVU
         J9LeDjHxUVdyLtFKSkGxbRY9TNNyHAlE5VNgxpMV+1eqqTlEyRNQmBCZ+Co6VodO9mJm
         zXbw==
X-Gm-Message-State: AOUpUlEPXDVEtmiOjnnbONIywqH+03m/ADYJSYm4eoh4IGVOPDIuex3u
        b3pTn9sfUYL97u0kgip/etDMk6mTlMAxwqrY4TGEdQ==
X-Google-Smtp-Source: AA+uWPyPg/FeVS9gOv25ZxqPbZ7yxyY4ob03t0Tz+s0TFvXin/coERU7C8UIhccEOQwN+ubtglR3Mi4Rl2aHVnb/bd0=
X-Received: by 2002:a2e:558c:: with SMTP id g12-v6mr3132059lje.4.1533767207614;
 Wed, 08 Aug 2018 15:26:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:29d3:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 15:26:27 -0700 (PDT)
In-Reply-To: <3c523c58a8e3f3d240d4ff9363d672fb977c9d93.1533675546.git.gustavo@embeddedor.com>
References: <cover.1533675546.git.gustavo@embeddedor.com> <3c523c58a8e3f3d240d4ff9363d672fb977c9d93.1533675546.git.gustavo@embeddedor.com>
From:   Saeed Mahameed <saeedm@dev.mellanox.co.il>
Date:   Wed, 8 Aug 2018 15:26:27 -0700
Message-ID: <CALzJLG-P9mZfF_kauDTd4R09a0Wq4pPvKTbyNt1KA_1654N9_Q@mail.gmail.com>
Subject: Re: [PATCH 24/33] net/mlx5e: Mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Linux Netdev List <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 4:25 PM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> Addresses-Coverity-ID: 114808 ("Missing break in switch")
> Addresses-Coverity-ID: 114802 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Saeed Mahameed <saeedm@mellanox.com>

> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> index 1881468..ad6d471 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> @@ -91,9 +91,11 @@ bool mlx5e_xdp_handle(struct mlx5e_rq *rq, struct mlx5e_dma_info *di,
>                 return true;
>         default:
>                 bpf_warn_invalid_xdp_action(act);
> +               /* fall through */
>         case XDP_ABORTED:
>  xdp_abort:
>                 trace_xdp_exception(rq->netdev, prog, act);
> +               /* fall through */
>         case XDP_DROP:
>                 rq->stats->xdp_drop++;
>                 return true;
> --
> 2.7.4
>
