Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407EBC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0632020866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0632020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbeIKBHr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 21:07:47 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36422 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbeIKBHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 21:07:46 -0400
Received: by mail-oi0-f67.google.com with SMTP id r69-v6so42735710oie.3;
        Mon, 10 Sep 2018 13:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sT20PZ54dCACcQWX92l1lSp48amw5UL+mgbW0oqM/z8=;
        b=iENkUjjz5g3At8MlLfgU3rHXtdQD5HiLNvWZVaYE8LUm7FUq5XogTa38IPAE86KSC2
         Yn2Dr3qNHZnqMeCKdhvivMPl+F4vh4sqvpLiwjZviGou+XALdG8Qv+zOLjaC/kCyoE9p
         tlYgzu4VEqw5EtAl3/2ApEkNYbRD1BoKjFBvjLlKPjnuKx2cymH0Dz4ypyiP3SgMmBfn
         eXxkFRBT8h8ObU7ARsB/7aLINxdszshZcT39g/3yyPx8W2avWdw9j0AqgamGjsoIa+1/
         hD4CFtQJ1my8LeVhMS1HfKmY+RbXz0Psuf3H7lWvUZ1BrNrRA45ZhRdwEgrnZOt3gQqc
         jPmw==
X-Gm-Message-State: APzg51AADHNHrc/fQa78z3xM0XPidgjVb7H0KfRdXthZj4jYWJAHUqlr
        1XIwF17qDdEIHIeM0rHmjratL5jWVb0=
X-Google-Smtp-Source: ANB0VdZKA+pl9swugMIfSJzE6qA2JSqrMGdfazAux5ZFzHOU7uVb5KbSwDjSX4h+nyb0LJPUv5wBXA==
X-Received: by 2002:aca:bcc1:: with SMTP id m184-v6mr22519370oif.19.1536610321242;
        Mon, 10 Sep 2018 13:12:01 -0700 (PDT)
Received: from mail-oi0-f46.google.com (mail-oi0-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id o206-v6sm19902813oif.7.2018.09.10.13.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 13:12:00 -0700 (PDT)
Received: by mail-oi0-f46.google.com with SMTP id b15-v6so42691838oib.10;
        Mon, 10 Sep 2018 13:12:00 -0700 (PDT)
X-Received: by 2002:a54:4d9d:: with SMTP id y29-v6mr24430959oix.273.1536610320134;
 Mon, 10 Sep 2018 13:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180910171550.5659-1-horia.geanta@nxp.com> <20180910171550.5659-5-horia.geanta@nxp.com>
In-Reply-To: <20180910171550.5659-5-horia.geanta@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Mon, 10 Sep 2018 15:11:48 -0500
X-Gmail-Original-Message-ID: <CADRPPNQ=sw-3=LO5SmUnhQnixNUUDgTz6oCweORtbyahNLizUg@mail.gmail.com>
Message-ID: <CADRPPNQ=sw-3=LO5SmUnhQnixNUUDgTz6oCweORtbyahNLizUg@mail.gmail.com>
Subject: Re: [PATCH 04/11] soc: fsl: dpio: add congestion notification support
To:     Horia Geanta <horia.geanta@nxp.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Miller <davem@davemloft.net>, aymen.sghaier@nxp.com,
        linux-crypto@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 12:19 PM Horia Geantă <horia.geanta@nxp.com> wrote:
>
> Add support for Congestion State Change Notifications (CSCN), which
> allow DPIO users to be notified when a congestion group changes its
> state (due to hitting the entrance / exit threshold).
>
> Signed-off-by: Horia Geantă <horia.geanta@nxp.com>

Acked-by: Li Yang <leoyang.li@nxp.com>
> ---
>  include/soc/fsl/dpaa2-global.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/include/soc/fsl/dpaa2-global.h b/include/soc/fsl/dpaa2-global.h
> index 9bc0713346a8..2bfc379d3dc9 100644
> --- a/include/soc/fsl/dpaa2-global.h
> +++ b/include/soc/fsl/dpaa2-global.h
> @@ -174,4 +174,19 @@ static inline const struct dpaa2_fd *dpaa2_dq_fd(const struct dpaa2_dq *dq)
>         return (const struct dpaa2_fd *)&dq->dq.fd[0];
>  }
>
> +#define DPAA2_CSCN_SIZE                sizeof(struct dpaa2_dq)
> +#define DPAA2_CSCN_ALIGN       16
> +#define DPAA2_CSCN_STATE_CG    BIT(0)
> +
> +/**
> + * dpaa2_cscn_state_congested() - Check congestion state
> + * @cscn: congestion SCN (delivered to WQ or memory)
> + *
> +i * Return true is congested.
> + */
> +static inline bool dpaa2_cscn_state_congested(struct dpaa2_dq *cscn)
> +{
> +       return !!(cscn->scn.state & DPAA2_CSCN_STATE_CG);
> +}
> +
>  #endif /* __FSL_DPAA2_GLOBAL_H */
> --
> 2.16.2
>
