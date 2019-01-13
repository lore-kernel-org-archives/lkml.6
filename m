Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E184C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 05:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2005620873
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 05:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpIL+yjV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfAMFMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 00:12:05 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43496 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfAMFME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 00:12:04 -0500
Received: by mail-oi1-f196.google.com with SMTP id u18so15424521oie.10;
        Sat, 12 Jan 2019 21:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:in-reply-to:references:mime-version:content-transfer-encoding
         :autocrypt:subject:to:cc:from:message-id;
        bh=T+yLIJ4zF+KVhxL5Waqss53ifeYQXkMIORoTJnVoX4s=;
        b=GpIL+yjVkPQmgzNV0dnOzokJo/vEZmvvuGZO/ZVHYZyAIaiDVVVq3E82TyWlsYfTv+
         tchLmmHcEgtuRrxmPsrZbHrQAW0aERGVKibMB6ylPSpROyO4AErYqduP1t83IB7By/BM
         m29/zEYAolRht4mlFiQxj3LvhVXegUZNdI9VygQr9CegilV/NnYmJ3DVChUI0DIn8cbj
         uTfCB1v9d/TLKAW9yWrCcuIn6Uy+sYNP/clUO0vWUA8Xop8S49FZ+b9GzZpEQ+8Fabnb
         IzoTGg9jZJLcH83dzDzyecAxHyg7tnkZ9WXUMdfldXClLLLj3asfJbgzMQyw28649i5x
         gOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:references:mime-version
         :content-transfer-encoding:autocrypt:subject:to:cc:from:message-id;
        bh=T+yLIJ4zF+KVhxL5Waqss53ifeYQXkMIORoTJnVoX4s=;
        b=gVEIVlYA0/Cr4Jr/oijfxUAequ+JnMPi9dwfhcXrdcxoAoDnUZwrewn//FBBHvIb9y
         AxThToZD2cGkFddQgoc/J5RrIZ7b2IknqonMladTwCOxTVJOiX8Ri3hoH5UtZjCE+/yB
         rvJBUJ0jQYP2Y3otFB5ezuj24wQ+iC8Hsc6f07ItAb3StzpDLNIZ51As2cyIfbol+Jdh
         wmjqBtiGNciREHDit3tK2aJte3F/1+TKUaREUMHcNYaO4mYgzSlwgUzv+vYWaL3WjRk5
         vX/pvWLNa2QxPasptCAZb7RGyuTnbAlX6pIqSZUiEQhKChGF9wLGTs6uBCWdelY65lXK
         XLBQ==
X-Gm-Message-State: AJcUuke5t1+I6RCmBR/tOHfsR+2PmfY2vqDM9SVrNOSvs9IPKw4wZMRa
        uEvapWDdOh+zg4+BMSscnFc=
X-Google-Smtp-Source: ALg8bN6txq5E/U6AdNLn39Zef0heBQfjQL2Nnr1v1BzakC0hYFjUCegjjya8Bbb+0Iw+NGYdP5SHzw==
X-Received: by 2002:aca:2ecf:: with SMTP id u198mr13420527oiu.338.1547356323189;
        Sat, 12 Jan 2019 21:12:03 -0800 (PST)
Received: from localhost (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id g138sm79302230oib.26.2019.01.12.21.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 21:12:02 -0800 (PST)
Date:   Sat, 12 Jan 2019 21:11:56 -0800
In-Reply-To: <20190113002255.15310-1-timotej.lazar@araneo.si>
References: <20190113002255.15310-1-timotej.lazar@araneo.si>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
Subject: Re: [PATCH net] net: phy: meson-gxl: Use the genphy_soft_reset callback
To:     Timotej Lazar <timotej.lazar@araneo.si>,
        "David S. Miller" <davem@davemloft.net>
CC:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <024ED7A3-A9D3-433C-BDB8-1F85301300F3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On January 12, 2019 4:22:55 PM PST, Timotej Lazar <timotej=2Elazar@araneo=
=2Esi> wrote:
>Since the referenced commit, Ethernet fails to come up at boot on the
>board meson-gxl-s905x-libretech-cc=2E Fix this by re-enabling the
>genphy_soft_reset callback for the Amlogic Meson GXL PHY driver=2E
>
>Fixes: 6e2d85ec0559 ("net: phy: Stop with excessive soft reset")
>Signed-off-by: Timotej Lazar <timotej=2Elazar@araneo=2Esi>

Reviewed-by: Florian Fainelli <f=2Efainelli@gmail=2Ecom>
--=20
Florian
