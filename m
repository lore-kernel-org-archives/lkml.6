Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FC4ECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B472075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dev-mellanox-co-il.20150623.gappssmtp.com header.i=@dev-mellanox-co-il.20150623.gappssmtp.com header.b="QFQnRzPk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B472075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dev.mellanox.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731477AbeGRBR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 21:17:58 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40854 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730043AbeGRBR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 21:17:57 -0400
Received: by mail-lj1-f193.google.com with SMTP id j19-v6so2524174ljc.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 17:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2dNx3H0Dmuw0LcIKouvWIijgzoiHgrH8+LOP6sk+AZo=;
        b=QFQnRzPk/QTYzxi+UJM32OhyliyDMr9nOh8xO57o4/H9AXtfxZnbNAa2pUGwnZsaWL
         fFlshTyyCEwPdeuYPhI2e+8iQxuLMjetWu/SQ+M2eVPbMg6xAJEqzi6NOl6LCeIOMIz5
         RViYFOtFst98LQdpe1t2E39nxUxQAtPWJlUESK+YSb4brl9u4nerI++l9DJlzRRIcUqW
         9iWO1vdD0yLIhQ0ms3CEEjtRefj6LnODaJMNwcV/e8CsUuLGAHXMFuybSvkjx5nT/Bmh
         9H1hvZ9rK+nyAYSbUpNLouzuDsp+Ns8m2x3iNLVtlbsFuXl3YV2zf6l5S1xDA233aa1A
         VTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2dNx3H0Dmuw0LcIKouvWIijgzoiHgrH8+LOP6sk+AZo=;
        b=mCabWncyd2oGB84QNo0Ht0MYcXJbm0KZxTMCrPGgG3TO3z8FgHpoocsLwuJcKAxkK2
         TlaGx4148HHqDF8+XWAFmE/G3YAzX9RV8LMriBfwWs55e+vMDpnZoJCuZA54KUz9fvoZ
         SuZgFVZJya+YP2p/3Ll4MZ7VY8lhqAyNBzyt0nzE+JZiCwMV2xu0N6qPOtUT4nDWzD2V
         xeR5eslBs6cs41YqV/wGmlMp9Z6wGJzcX6Tg5hWMUCAyjxm3bpBfWTVLLBkBRQ8+g7G2
         Jni4x8HSGWIgzjgkgQ0z788+v9ftRvSLb6AaXAZSKAC1S31ESy3uJ2d6GPYTe25F5Wa7
         1ctg==
X-Gm-Message-State: AOUpUlFC962EBCO9oPXFLovbrbeWg8CIjr8BdVhKuGbF5DsxPiNfwxEy
        +AgD1dFm50tbdeGsJ+QjZptue0OvCQOzsaFH5+b16A==
X-Google-Smtp-Source: AAOMgpeJYBzY5hvpfBxPK2fEn+VCiJH2AkqIQ54Vy6g85cuzraKKxqjfiByr7ojr39JGukmtlpXpPA+0SkWfCIh+AGQ=
X-Received: by 2002:a2e:2114:: with SMTP id h20-v6mr3052961ljh.135.1531874566371;
 Tue, 17 Jul 2018 17:42:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:29d3:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 17:42:25
 -0700 (PDT)
In-Reply-To: <20180717135009.3584984-1-arnd@arndb.de>
References: <20180717135009.3584984-1-arnd@arndb.de>
From:   Saeed Mahameed <saeedm@dev.mellanox.co.il>
Date:   Tue, 17 Jul 2018 17:42:25 -0700
Message-ID: <CALzJLG_r5pkBWGvyE+e7PVtPOnLnXS8oee_ka+=UEAkbqDP-Kg@mail.gmail.com>
Subject: Re: [PATCH net-next] net/mlx5: fix an unused-function warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Boris Pismenny <borisp@mellanox.com>,
        Linux Netdev List <netdev@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 6:49 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> These dummy helpers are all intended to be inline functions,
> but one of them by accident came without the 'inline' keyword,
> causing a harmless warning:
>
> In file included from drivers/net/ethernet/mellanox/mlx5/core/main.c:63:
> drivers/net/ethernet/mellanox/mlx5/core/accel/tls.h:79:1: error: 'mlx5_accel_tls_add_flow' defined but not used [-Werror=unused-function]
>  mlx5_accel_tls_add_flow(struct mlx5_core_dev *mdev, void *flow,
>
> Fixes: ab412e1dd7db ("net/mlx5: Accel, add TLS rx offload routines")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Saeed Mahameed <saeedm@mellanox.com>

Dave, you can take this one to net-next.

Thanks!

> ---
>  drivers/net/ethernet/mellanox/mlx5/core/accel/tls.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/accel/tls.h b/drivers/net/ethernet/mellanox/mlx5/core/accel/tls.h
> index 2228c1083528..def4093ebfae 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/accel/tls.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/accel/tls.h
> @@ -75,7 +75,7 @@ void mlx5_accel_tls_cleanup(struct mlx5_core_dev *mdev);
>
>  #else
>
> -static int
> +static inline int
>  mlx5_accel_tls_add_flow(struct mlx5_core_dev *mdev, void *flow,
>                         struct tls_crypto_info *crypto_info,
>                         u32 start_offload_tcp_sn, u32 *p_swid,
> --
> 2.9.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
