Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42636C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0784A21904
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hOC+psNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387838AbfBMDaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:30:17 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41680 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbfBMDaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 22:30:17 -0500
Received: by mail-qt1-f195.google.com with SMTP id v10so1046842qtp.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 19:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ZMlLMugFOzXU7PxzdCTxvkhaFc7D0k1D+pb0bgN7gg=;
        b=hOC+psNO8kWYyhOjp3s5YJHYdHSiE88fC+wHZmh6HSaHtoE4XaZimcFUM4QT467NiN
         ODD/Juw6876CsDjKviLr5UfysFtkWNFp+sOJvJozCFxZuDo6tgk2Zpoly4PDxrP1mhgc
         8riFUcRoxxJf4IzwjNc4BBoB2YJ+/zJB/odgAVmRXoT9tsWlZW/9iuWWAFdd8pmCN8IP
         PCKdjWT16eYQPGjW96oCkvVbeZBM17K3gOvBe8pJ2gD8vPwmxuqBB1YILi4k9MJW1whN
         7qzJXIkxE0RXJ3p/Iku7sWKX6u14GN6b+Udvxh1c4WQZ7CgQ+FyuH/Q3ID1yzPx5TRzm
         l+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ZMlLMugFOzXU7PxzdCTxvkhaFc7D0k1D+pb0bgN7gg=;
        b=HtZMUSB6e3I0LaRXl9s388dXwXZ5DsdCA0hLy7RcMx59G1Eun6oYOuJcQ++4TMtl4u
         emgnrxGB4LiM2FBDfxrqv470nGPHxd7D+V7OX4kge0EPG/XKPg5SpDyd+q5QZBkD8LBx
         Xl+vo1lR1RmDLpY5LUSe5ypxnz4yEMalnTSkhQ89tyrSjuF9/KXsqgQR6D3SDKxpApFW
         zN4QtyAGS43jj+3nH2WTAyPTnU7qheQKiy4lST4fWyrpVLbrDUxY25hKJyft4OkrXkVD
         lUTH1oHQdRJJddxTeVv+uVidKovm4sXqdJ24yc3cDsDi4YXgnucH4hdwmrbugFtH69ib
         Zbqg==
X-Gm-Message-State: AHQUAub4WmKRip9WWw/acbp5EvfQhoDXY+hDAvjFoXUndu8BClTn+m4B
        69laQxNU225e6W660GfBZUFZUPv7OJaNNkBBnfHW8w==
X-Google-Smtp-Source: AHgI3IbeXXszKtkyBKqeh24sP6rE+RsjVgAR/mKyTT2jKOm0YlBbcN4jm1IKOJEdTaM3rmXHObFduY4J0KhLISqdwGA=
X-Received: by 2002:ac8:312c:: with SMTP id g41mr5613840qtb.22.1550028615582;
 Tue, 12 Feb 2019 19:30:15 -0800 (PST)
MIME-Version: 1.0
References: <1549987097-27937-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1549987097-27937-1-git-send-email-linux@roeck-us.net>
From:   Kyle Tso <kyletso@google.com>
Date:   Wed, 13 Feb 2019 11:30:04 +0800
Message-ID: <CAGZ6i=2s4Xg6ORmgFgrM0KuXcLVZ_nhYvCoRMc4rMNOCKyhv-g@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: Remove unused functions
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 11:58 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> tcpm_update_source_capabilities() and tcpm_update_sink_capabilities()
> are not used anywhere, and I don't recall why I introduced those functions
> in the first place. Effectively that means that we don't know if they even
> work, or ever did. Lets remove them.
>
> Reported-by: Kyle Tso <kyletso@google.com>
> Cc: Kyle Tso <kyletso@google.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Kyle Tso <kyletso@google.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 60 -------------------------------------------
>  include/linux/usb/tcpm.h      |  6 -----
>  2 files changed, 66 deletions(-)
>
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index f1c39a3c7534..a6b2413c59a6 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4435,66 +4435,6 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>         return 0;
>  }
>
> -int tcpm_update_source_capabilities(struct tcpm_port *port, const u32 *pdo,
> -                                   unsigned int nr_pdo)
> -{
> -       if (tcpm_validate_caps(port, pdo, nr_pdo))
> -               return -EINVAL;
> -
> -       mutex_lock(&port->lock);
> -       port->nr_src_pdo = tcpm_copy_pdos(port->src_pdo, pdo, nr_pdo);
> -       switch (port->state) {
> -       case SRC_UNATTACHED:
> -       case SRC_ATTACH_WAIT:
> -       case SRC_TRYWAIT:
> -               tcpm_set_cc(port, tcpm_rp_cc(port));
> -               break;
> -       case SRC_SEND_CAPABILITIES:
> -       case SRC_NEGOTIATE_CAPABILITIES:
> -       case SRC_READY:
> -       case SRC_WAIT_NEW_CAPABILITIES:
> -               tcpm_set_cc(port, tcpm_rp_cc(port));
> -               tcpm_set_state(port, SRC_SEND_CAPABILITIES, 0);
> -               break;
> -       default:
> -               break;
> -       }
> -       mutex_unlock(&port->lock);
> -       return 0;
> -}
> -EXPORT_SYMBOL_GPL(tcpm_update_source_capabilities);
> -
> -int tcpm_update_sink_capabilities(struct tcpm_port *port, const u32 *pdo,
> -                                 unsigned int nr_pdo,
> -                                 unsigned int operating_snk_mw)
> -{
> -       if (tcpm_validate_caps(port, pdo, nr_pdo))
> -               return -EINVAL;
> -
> -       mutex_lock(&port->lock);
> -       port->nr_snk_pdo = tcpm_copy_pdos(port->snk_pdo, pdo, nr_pdo);
> -       port->operating_snk_mw = operating_snk_mw;
> -       port->update_sink_caps = true;
> -
> -       switch (port->state) {
> -       case SNK_NEGOTIATE_CAPABILITIES:
> -       case SNK_NEGOTIATE_PPS_CAPABILITIES:
> -       case SNK_READY:
> -       case SNK_TRANSITION_SINK:
> -       case SNK_TRANSITION_SINK_VBUS:
> -               if (port->pps_data.active)
> -                       tcpm_set_state(port, SNK_NEGOTIATE_PPS_CAPABILITIES, 0);
> -               else
> -                       tcpm_set_state(port, SNK_NEGOTIATE_CAPABILITIES, 0);
> -               break;
> -       default:
> -               break;
> -       }
> -       mutex_unlock(&port->lock);
> -       return 0;
> -}
> -EXPORT_SYMBOL_GPL(tcpm_update_sink_capabilities);
> -
>  /* Power Supply access to expose source power information */
>  enum tcpm_psy_online_states {
>         TCPM_PSY_OFFLINE = 0,
> diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
> index 50c74a77db55..0c532ca3f079 100644
> --- a/include/linux/usb/tcpm.h
> +++ b/include/linux/usb/tcpm.h
> @@ -159,12 +159,6 @@ struct tcpm_port;
>  struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc);
>  void tcpm_unregister_port(struct tcpm_port *port);
>
> -int tcpm_update_source_capabilities(struct tcpm_port *port, const u32 *pdo,
> -                                   unsigned int nr_pdo);
> -int tcpm_update_sink_capabilities(struct tcpm_port *port, const u32 *pdo,
> -                                 unsigned int nr_pdo,
> -                                 unsigned int operating_snk_mw);
> -
>  void tcpm_vbus_change(struct tcpm_port *port);
>  void tcpm_cc_change(struct tcpm_port *port);
>  void tcpm_pd_receive(struct tcpm_port *port,
> --
> 2.7.4
>
