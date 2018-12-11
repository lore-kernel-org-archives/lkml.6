Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3AEC6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4177720851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tnlifvSG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4177720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbeLKWhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:37:54 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:35902 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeLKWhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:37:54 -0500
Received: by mail-yb1-f196.google.com with SMTP id 64so4749711ybe.3;
        Tue, 11 Dec 2018 14:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IgHZsYWBUSPpRqlTq2GxFGMxXaov4E9wXVEaBfjsNmk=;
        b=tnlifvSGMAj4BCpvyz/cOj+4gmkqfDXAJosnp79Tj+1P9ZLeFUMS1Q92Clt8u9HBD+
         icNQjhfRB9pzbCCxFHv9W8ioh4dvSCS9qvLbhSZu/8SM/Zo/PR/j/Aj5NEW4/cYGWnqs
         0M6PWmCh2e81FSJjkRMCwrQMo+p2OKryb/Uze1h3MLJqCPsK3WpmLJaJDXwgwnd1FJlJ
         nTX2vkYZ7BMvgpFP3a2cobL1S6D/EVW0bJHSnduBCJwlqXIMT6PjIT7PwhHRRQNo7laP
         jQeQaAf1oEW1QYsOm5bSdqoZV+gvfNx7CskWXlNW96TXSp378yg0Lat1dO2GvHvoEVqM
         pqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IgHZsYWBUSPpRqlTq2GxFGMxXaov4E9wXVEaBfjsNmk=;
        b=Mpz1ZHo9xaxkmnA5O0pY4RiM9rENtBJ37TMHq15fNASX7WuOpO0+xZINHhhYsZY7Au
         PHtvOTDBw+EwWqR8r4MosEWBxPLaR2lUWYwn/evEWwg7dfTP67SiIIB1x1tWtwXieRaZ
         Cklm/4uXHAo/VOgk+PCgNZtcPNkb5U87Mt2JNn8PVPCA8BXzq7O0HynJaCTbushA8k1z
         JNp1cvue2r22j0JMRP5uN0LbqTI+0h7Nwb+TcjE/zWJM+nb0F40RHf6CMtxSZHn/pi3F
         mT7Cdejh2XmZLT3uMfuWh3bU4cJlOBxK1nbkdCoopDz/8Y7HtlImMqmfpYl97Nps8hVL
         +7LQ==
X-Gm-Message-State: AA+aEWZeeGEnOLsNLZYob/2OGq8FVMy5xFdQyj7edtVAiHl3f+jQjcU1
        d7bDgYFhXlaDbsfMEuDHvjg=
X-Google-Smtp-Source: AFSGD/Uu8BXGqJayJz1OF04/fEsueZQQUEUJwxMaC/Mn2w3rYt0eKZNeTLPmXR6Uejync5y4vx5NFQ==
X-Received: by 2002:a5b:108:: with SMTP id 8mr17876938ybx.111.1544567873093;
        Tue, 11 Dec 2018 14:37:53 -0800 (PST)
Received: from [10.67.49.9] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id u127sm4884639ywa.109.2018.12.11.14.37.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 14:37:52 -0800 (PST)
Subject: Re: [PATCH 1/7] [DSA] adding fields for holding information about
 upstream-port
To:     Frank Wunderlich <frank-w@public-files.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20181211193314.10695-1-frank-w@public-files.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <63046efc-820c-aabf-a6f9-9393550b7056@gmail.com>
Date:   Tue, 11 Dec 2018 14:37:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181211193314.10695-1-frank-w@public-files.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,,

On 12/11/18 11:33 AM, Frank Wunderlich wrote:
> based on
> https://github.com/openwrt/openwrt/blob/master/target/linux/mediatek/patches-4.14/0033-dsa-multi-cpu.patch

There are several stylistic as well as logistical/technical issues with
this patch series, so please address those before we can start doing the
technical review:

- this is a multi patch series, so a cover letter should be provided
(can be done with git format-patch --cover-letter)

- subject for the patches should be prefixed with net: dsa: <subject>

- commit messages explaining what is being achieved, how and what
problem/feature this is providing is mandatory, you cannot just take
patches from OpenWrt and provide no context what so ever except from the
subject

Please fix that so we can do a meaningful and constructive technical
review of the patches.

Thank you

> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  include/net/dsa.h  | 4 ++++
>  net/dsa/dsa_priv.h | 5 +++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index 23690c44e167..3efa81e08993 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -203,6 +203,10 @@ struct dsa_port {
>  	struct net_device	*bridge_dev;
>  	struct devlink_port	devlink_port;
>  	struct phylink		*pl;
> +
> +	struct net_device	*ethernet;
> +	int			upstream;
> +
>  	/*
>  	 * Original copy of the master netdev ethtool_ops
>  	 */
> diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
> index 9e4fd04ab53c..cc0cd7675117 100644
> --- a/net/dsa/dsa_priv.h
> +++ b/net/dsa/dsa_priv.h
> @@ -81,6 +81,8 @@ struct dsa_slave_priv {
>  
>  	/* TC context */
>  	struct list_head	mall_tc_list;
> +
> +	struct net_device       *master;
>  };
>  
>  /* dsa.c */
> @@ -188,7 +190,10 @@ static inline struct net_device *
>  dsa_slave_to_master(const struct net_device *dev)
>  {
>  	struct dsa_port *dp = dsa_slave_to_port(dev);
> +	struct dsa_slave_priv *p = netdev_priv(dev);
>  
> +	if (p->master)
> +		return p->master;
>  	return dp->cpu_dp->master;
>  }
>  
> 


-- 
Florian
