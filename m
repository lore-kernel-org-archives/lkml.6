Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E83C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153102098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IR6a76iN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153102098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbeJLAQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:16:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44126 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729991AbeJLAP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 20:15:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id 63-v6so10455310wra.11;
        Thu, 11 Oct 2018 09:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZMgumD2EoBCtvZwsGowMwd442rqt9QKn5YK+Mh8oECg=;
        b=IR6a76iNT7MVEO3a1J1dVqfXwpZR/U2YDI280nTDcsZijO0h9ou6CfE5f2J/ifXHUS
         bu8OQV6cMWPDyUWsAPxNLoTCKoXXabLNswgKfZiFLX23Z8ZUPL3lZvp3NBXlVrZCCLIM
         0/yyvnFmswM27atcNOeI1SjYkX2DVALYEtNoAzXATG+w4b0hDWkXNQCZSLsh5/G8ItJ0
         uT4OouZ8eCtKSWzFuCHEG8frTkTJiLq5Dr45YqoPrJWR9g8Dkxl4kp3hGIjDTJm+dDmg
         iSq2HPF/DOwerWlx0vu3FAObiOk0aqNbEfig3KfVLdkzrIanBvqVwJFmj95q/tG0Nqhd
         dnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZMgumD2EoBCtvZwsGowMwd442rqt9QKn5YK+Mh8oECg=;
        b=dVnqv79JU96UjxD6tgGaf4+emC1l9ii8P4cehr8JtBKZm+Sx0sD+2DrvB4NGRmTZ3T
         6VIK69vNMtShUs7nP3jT2CWwSpHXVztHdWYwIayAZWHc9tQPiuYjzn6No0ctWftiKhQS
         EyWSqVtCFDWTlOg7eWXUh59V0GRfz4M4cdAcp1g0/SlpDEchd/ih37E9z8jPkZOnvb9O
         VkrFPe8aYNinjzZbG/G701bkLM1wE4Y669i2etRVQCzYMBLZmRo931tE5qxnJliZ+y54
         UGiLiOOcYrxi5snavuZvizmQ9uZMCkv4S8zcprWz2WwkdlDUs0r9dqLWqQqamIJvLM3d
         hVrA==
X-Gm-Message-State: ABuFfoiJKtJXpZZ5AmyFe1W98GLtWoHUai1xiZKHrm7yjw9K9xTVOcfT
        fA5bzTHfdxNPXkbTYlZ2xwc=
X-Google-Smtp-Source: ACcGV601pso+2NR75zdWi2A157cmTPsum7oGnwaGrMdmcnySHHyBJfUUsYFieY2j3pvr6UQQsWvXGg==
X-Received: by 2002:adf:9792:: with SMTP id s18-v6mr2402159wrb.283.1539276475783;
        Thu, 11 Oct 2018 09:47:55 -0700 (PDT)
Received: from localhost (p2E5BEEEA.dip0.t-ipconnect.de. [46.91.238.234])
        by smtp.gmail.com with ESMTPSA id 18-v6sm35434072wmw.26.2018.10.11.09.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 09:47:54 -0700 (PDT)
Date:   Thu, 11 Oct 2018 18:47:53 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 3/5] usb: xhci: tegra: Add genpd support
Message-ID: <20181011164753.GA7393@ulmo>
References: <1538143910-24400-1-git-send-email-jonathanh@nvidia.com>
 <1538143910-24400-4-git-send-email-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <1538143910-24400-4-git-send-email-jonathanh@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 28, 2018 at 03:11:48PM +0100, Jon Hunter wrote:
> The generic power-domain framework has been updated to allow devices
> that require more than one power-domain to create a new device for
> each power-domain required and then link these new power-domain
> devices to the consumer device.
>=20
> Update the Tegra xHCI driver to use the new APIs provided by the
> generic power-domain framework so we can use the generic power-domain
> framework for managing the xHCI controllers power-domains. Please
> note that to maintain backward compatibility with older device-tree
> blobs these new generic power-domain APIs are only used if the
> 'power-domains' property is present and otherwise we fall back to
> using the legacy Tegra APIs for managing the power-domains.
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/usb/host/xhci-tegra.c | 89 +++++++++++++++++++++++++++++++++++++=
------
>  1 file changed, 77 insertions(+), 12 deletions(-)

It'd be nice if we could eventually get rid of the legacy Tegra APIs,
but that's a separate issue, and this patch looks fine as-is:

Acked-by: Thierry Reding <treding@nvidia.com>

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlu/frYACgkQ3SOs138+
s6FKUw//UiZXqBWAdR5Ot6XX321n53Ig86IZzDMLB7iDWbzi+BtsKGGDqs+AwnY3
ETXJdwG7YI0WfdiPhh3gjE6uOx6/l0fvwLz82oFIxetwbsxb7QqbQWZJoVxm3Hcp
RhaB+mgN8PmFdd8TgaL6K0wmLyE1qA+XcBJPYqRHhQoFVp4K6bn2Rl0Gl5XshnS+
tUfyLMiJy15Zr25NIkhWBu+BfqmDHjqf6jdyp94p1vbXUlw4ApGcYlED82eLVn91
1yTKuOCG4xGKDpL7fQs2HF9KdPCgbKu8LvawLSkRVbNXBavLmWblOuPBWPa4Sm0a
g6eAJOssYStmznwNWT88+DvC2xfmi4eKlNhJt7fxykOsPKsQ2cOOw6yfco1R2GPf
B1Sfulqbx3/w3jBpzrwUn8dLmTP6Dxb8fhQqL/EkaB+bPL5qQWFjADAgRsDDLFZY
sbb7tvjx9OBSQ93LyzkbsYDavdUiAFjDjtRj6XPk3KEY2FSfbsXF8zmOk3OrTwJ9
eCfQw0en8RKpBdQgd81Utq0y24guei8lYbVho5pO+ehNXEyA2x1WrLVhkM4TH+ZP
kXdmamgVhc+MmKGpOaYkAQakA6f2UWd9VErCWoRNnLDzMlks/BFvYcZeyutuKJOe
NLf9Vb+t5qwQgl3Qj0LFYoTdG7LsQ3G9Eygl/QeIFL0p1Jzp71g=
=pzTh
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
