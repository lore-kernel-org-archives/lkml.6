Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69AAC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F12721479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIqzcM5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbfACIza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 03:55:30 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:56168 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730218AbfACIza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 03:55:30 -0500
Received: by mail-wm1-f51.google.com with SMTP id y139so28463108wmc.5;
        Thu, 03 Jan 2019 00:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J/LTMlvfERM+z7dRrvodH4XuA0FQDQjf94VnVMdwak4=;
        b=JIqzcM5lDpPCs671j1lUKjJTKk+qfEf+ioRli8hD8eM05xInmA/mcuc7Oq27q8/9wH
         dnhKrcsTfMuffp1g+Q/dyTYHMmVTa7xE7+GIOd7xyc5Dmt/KakmavHx/BeDHCHOiiQVe
         ail/+cnkXEJKE55HxwqLIcOrGM4nZvx9CWm+Bck2301KrnOvLgVT6y+WGbKarnGf2lHq
         iFeT4V97ScujTKPtPd3rEgorKWsRe1XjV9okToO9+Z1/yvZUTFRt51ZRecCwtY+Ss+Sz
         yHUSo6kC1SM3uG3pp55F00jRYExAc0swyj6QuFfyqyIhbzOYeg7JhtahQ5tizOGLL0jN
         Lj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J/LTMlvfERM+z7dRrvodH4XuA0FQDQjf94VnVMdwak4=;
        b=dwBx0FJT+UZVzqVsR1gf0Py4QDlPW7JdwTVG3r9LM8fB2fIMLyoULb3z+kdedcfq/q
         hIvrfG7SnA0/Xfm3a7cWc8DR0SeDXpDv/Bt1DO6G2sat2+IzmGUVTK8ZhezIMTGCHc3g
         9B8uKV0hsUA3nbve1IaZ4ZhVNwyVTEPAzO8ikf0UFIIYucNizEtgwq1ceeWOSYk/gbx3
         Svib+0vHhCulxeZ+knouYvQsZTHZdo37/qfklkfZtIA4vE/ap12brLQ8U2oTqnmQXoXp
         ES+AUllGqLB5iGnXViSWPWagtLceD2lGTtpEL5Bw8rKqHqcGVEjTNj1eSxKtiTZ274vg
         uYLQ==
X-Gm-Message-State: AJcUukeNDPZmDQrZXUWCJlamI/T4IWQgZxKM+yJhO9Q1VB1OazL26XFU
        FXldzz9lJmiTYWZVzzp9AmRU6RbS
X-Google-Smtp-Source: ALg8bN77B4ipmYT6aQQTLdOraO4Ziqy3K7kXhd68e3ccEyi61etfqaqBqWK5UgwV/FtU/JuXwtP1Tw==
X-Received: by 2002:a7b:c76b:: with SMTP id x11mr9641717wmk.37.1546505728217;
        Thu, 03 Jan 2019 00:55:28 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id d11sm15305764wrw.25.2019.01.03.00.55.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 00:55:27 -0800 (PST)
Date:   Thu, 3 Jan 2019 09:55:26 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH V3] i2c: tegra: Fix Maximum transfer size
Message-ID: <20190103085526.GA9287@ulmo>
References: <1546472423-31366-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <1546472423-31366-1-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 03:40:23PM -0800, Sowjanya Komatineni wrote:
> Tegra194 supports maximum 64K Bytes transfer per packet.
> Tegra186 and prior supports maximum 4K Bytes transfer per packet.
>=20
> This patch fixes this payload difference between Tegra194 and prior
> tegra chipsets using separate i2c_adapter_quirks.

Nit: tegra -> Tegra. Otherwise, this looks good, thanks for fixing this:

Acked-by: Thierry Reding <treding@nvidia.com>

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwtzfsACgkQ3SOs138+
s6FVvxAAs+rLBxy3s/FyAfXLpOMjYae1qqNaZp+hR43PD1b707auo3m0ZlKQVhiM
xMbja+Ego1lHvZ+E2LmlqBAgTe3mVbG7lfQHQYAQzhpEhocSai7PPN8v1UblxpJd
7Dm5DEo0ruwgmB91vVAbVdox5hfXh0nvf/MLVmUTwllaCQMVD/eYphGMCgWxMJHE
xc9eRb8cSsszPgDDiLlDIh2jIogPBUEtO10HXVG0hIftWA6p/ddww1nbmrF0Qod1
cIxydCw57/JXV5L3VvzGm04+uq9Iwk9wPhCNpnTvrXFjXxcHuSw1AsOTFJKAJGRQ
t6B4J1Bk9k1gto9m8+D1updzLy5MJmIvicI2RIdbdDxwrnXjJztvjORy4zjS1kCo
qdTwwZg0HTM/fiG/2j+ouMqL+ov+HJ4epg1wcRideziGQypnjXwSNtPDXlgyUd55
WXnmNXn/9E8oDTTc2hSwfOTmHCiBfGFv6kuaaTNklZ+/0WM2KjQdYGx/ECEIZJFP
26RZqTKSiIwzb/XeodhAYS4slaG6TV1xR0xAEis5FDSTTzusC/WPszwNi0VMu945
kFnztKIKEzP6SrkoaXmvV9E8p9PSMuYky/+WLXXrx0uhqdJTsCX3yZeVhYmqAjSP
f21ZrThraNKUlaOBWj711mi6utA2cMOnzXtQ4zAmzQzr7Lr7XB4=
=XPLB
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
