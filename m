Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81A3C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E76D20846
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjESO+eq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E76D20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeH1L44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 07:56:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38769 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbeH1L44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 07:56:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id w11-v6so640624wrc.5;
        Tue, 28 Aug 2018 01:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ibpJo3mS9ZCqy6elOIKakRAx623820KtQe0/ak395EM=;
        b=SjESO+eqLuswBePoNUqLu41BUounh+NqpLVYcrCNQawipFJaxL+Qezic8FYQzZIQ2/
         0MXGjWpQMYxoRD7tbSSs2xBEQqGlUU58ufspgvShB2hfkkB1iDhQX8DSMXKtTa76J9fI
         3KHHXYmZQoeDsE9FttUMI+0BNCzLdZmaM7j2InP181hBlVXPqKGjTvKo6VYxL5nuWhoZ
         9jbcEARWfHPMKwSVIapOeTI9GGFLeqJtTB0FlOGZGaJ3ei/U3ZQyZ2QcEbaa4hgAQd+0
         UY4sm0m2wpqGmEQgRywpWHPpNeJ/ZROXH1yl9odZtOKLzIyO2WmsjmrmTxmsC4WJXbyC
         0fxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ibpJo3mS9ZCqy6elOIKakRAx623820KtQe0/ak395EM=;
        b=FHloBk7p2SnYCH0ZTVnj94m10LBwv6gm06zcZ/vh+Ca7Ql7Il5yoZOTlgC6poHN1Oo
         OQtFvVMhDMCtcrf9zdQ8UiEZCJPxdU1uq0aWu4iotvbceeCsUHmrJXjtRUB+JDzGTmnU
         /a7CcwRLss3LpJon8VO1tHvfqeOS3ecZSgOi0krd/7sjJznlD7twmWOgQTp9StfXkXvt
         2OjZ5EATujmyLjvKiv+nHD2eADpMdIirjMQtP1YNZdTX9DEpTTw6I2IE6ENIBrXNZKgA
         ao0yFKn6K8EUbR14L2lTfl2fVfQS774tJnpe1BOz613NVt4VA6JHLLge4baLQRfOdxDU
         oCbA==
X-Gm-Message-State: APzg51BeYjGlPH3PkqkJNrY/CXjQdTVZeOJwr49Y3w+d2aaCc0BBDgWX
        WcpRdN7YRCarlasyWGc9eCI=
X-Google-Smtp-Source: ANB0VdYW9niNBy6QqgP2qbVkeqv3ObnRdy3D0WO1a68LZ/lINhgedgYNXSaZo6rC0RbvZpItAb+aWw==
X-Received: by 2002:a5d:4401:: with SMTP id z1-v6mr329117wrq.227.1535443587907;
        Tue, 28 Aug 2018 01:06:27 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id z184-v6sm1689677wmz.0.2018.08.28.01.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 01:06:27 -0700 (PDT)
Date:   Tue, 28 Aug 2018 10:06:24 +0200
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
        "David S . Miller" <davem@davemloft.net>,
        maxime.ripard@bootlin.com, wens@csie.org
Subject: Re: [PATCH v2 7/9] net: stmmac: dwmac-sun8i: fix OF child-node lookup
Message-ID: <20180828080624.GA25644@Red>
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

You should have CCed sunxi maintainers 
Maxime Ripard <maxime.ripard@bootlin.com> (maintainer:ARM/Allwinner sunXi SoC support)
Chen-Yu Tsai <wens@csie.org> (maintainer:ARM/Allwinner sunXi SoC support)

Since I am just back from holidays, I will test this patch this week.

Regards
