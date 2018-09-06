Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504D8C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDED020659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftyRHhUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDED020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbeIGAkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 20:40:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36333 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728536AbeIGAkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 20:40:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id e1-v6so3606034wrt.3;
        Thu, 06 Sep 2018 13:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/FSeL6BvcRvtxQyFxd5qx+rKXm5LdgfFVrmNhSPJV+0=;
        b=ftyRHhUFiHmroFzYqzQZAFqh7j7reXrHPiwCmx0FSG2j2WPxBCakQJWKo7HVUY2G7w
         p/zzzpOUlnK7uLit57EiKrP6BRtf71ApVJ9MXxy9t1mIAMc4D7l0w6iPDynl1cM/Dqj9
         Fly8ovX4nNY7mq6wNBYal+PnijJkvCfbSPthvfKPZFSPGufI1Ppd07KlhfrCbWp75l3m
         zeC6Q/RqfpyAAi4zOlLr10aM424WQ5h+2aq/hKOyi7Oys4U7beDQwMmpZtUkYEc1kPr1
         aqdvlf+hIp9P59qQ6SJDAf7/2HBAIy6Jc+pb/37f9hYDPZ4aVLBlSJkp4rpD6lAbav41
         qGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/FSeL6BvcRvtxQyFxd5qx+rKXm5LdgfFVrmNhSPJV+0=;
        b=cAV0xOag1XRBDWuk68yemp5l44CzIxD08UxCVvcnQ3SUZHfmoFKOO+DTzqOxQpKbOH
         MjzELZZYAiJdwFmKPW0UtCSDlX2Q4kcJGqahLXhrppLuXaZI4UMT9+5J98oAmiQoo47D
         LjKilx2pvwYXfP5fVfYYFWzsWf7BeU/duHsGjEP1D7YkssxwmUzKzTgRU6MFNU0Y9pVb
         pkhir5NIvoLFWCB7AzoXH/BqQn3wX/irjduDC5bVpO9hDT7jaQD2/NsRX94+wJ3GEAm5
         0TlXp4XgADPX2b2ufA1l72Drx4Yk2BMbG7FzqlJpemNskN7HlGLVAZQkrSisErk+YwAf
         VKkA==
X-Gm-Message-State: APzg51AfdCR3GMXNpmB1wKrz9SEG9T/2orBiZ87wevrmfl5jLsX6thCJ
        1FxPEmMBFGpeZTycpMTeCQI=
X-Google-Smtp-Source: ANB0VdawlFrnvmpzURosXvlP5RnxmW5m4n5vfiNQ5Ql4bp7llAlY6y6bLFNrCY37lB8vAlObGz8zDA==
X-Received: by 2002:adf:9d81:: with SMTP id p1-v6mr3529575wre.12.1536264220898;
        Thu, 06 Sep 2018 13:03:40 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id j133-v6sm5368831wmd.12.2018.09.06.13.03.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 13:03:40 -0700 (PDT)
Date:   Thu, 6 Sep 2018 22:03:37 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2 7/9] net: stmmac: dwmac-sun8i: fix OF child-node lookup
Message-ID: <20180906200337.GA15390@Red>
References: <20180827082153.22537-1-johan@kernel.org>
 <20180827082153.22537-8-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827082153.22537-8-johan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 10:21:51AM +0200, Johan Hovold wrote:
> Use the new of_get_compatible_child() helper to lookup the mdio-internal
> child node instead of using of_find_compatible_node(), which searches
> the entire tree from a given start node and thus can return an unrelated
> (i.e. non-child) node.
> 
> This also addresses a potential use-after-free (e.g. after probe
> deferral) as the tree-wide helper drops a reference to its first
> argument (i.e. the mdio-mux node). Fortunately, this was inadvertently
> balanced by a failure to drop the mdio-mux reference after lookup.
> 
> While at it, also fix the related mdio-internal- and phy-node reference
> leaks.
> 
> Fixes: 634db83b8265 ("net: stmmac: dwmac-sun8i: Handle integrated/external MDIOs")
> Cc: Corentin Labbe <clabbe.montjoie@gmail.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Jose Abreu <joabreu@synopsys.com>
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index f9a61f90cfbc..0f660af01a4b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> @@ -714,8 +714,9 @@ static int get_ephy_nodes(struct stmmac_priv *priv)
>  		return -ENODEV;
>  	}
>  
> -	mdio_internal = of_find_compatible_node(mdio_mux, NULL,
> +	mdio_internal = of_get_compatible_child(mdio_mux,
>  						"allwinner,sun8i-h3-mdio-internal");
> +	of_node_put(mdio_mux);
>  	if (!mdio_internal) {
>  		dev_err(priv->device, "Cannot get internal_mdio node\n");
>  		return -ENODEV;
> @@ -729,13 +730,20 @@ static int get_ephy_nodes(struct stmmac_priv *priv)
>  		gmac->rst_ephy = of_reset_control_get_exclusive(iphynode, NULL);
>  		if (IS_ERR(gmac->rst_ephy)) {
>  			ret = PTR_ERR(gmac->rst_ephy);
> -			if (ret == -EPROBE_DEFER)
> +			if (ret == -EPROBE_DEFER) {
> +				of_node_put(iphynode);
> +				of_node_put(mdio_internal);
>  				return ret;
> +			}
>  			continue;
>  		}
>  		dev_info(priv->device, "Found internal PHY node\n");
> +		of_node_put(iphynode);
> +		of_node_put(mdio_internal);
>  		return 0;
>  	}
> +
> +	of_node_put(mdio_internal);
>  	return -ENODEV;
>  }
>  
> -- 
> 2.18.0
> 

Sorry for the delay
Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
