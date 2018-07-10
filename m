Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3976C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A761C20883
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eq46rB4Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A761C20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754089AbeGJLCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 07:02:41 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37625 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751427AbeGJLCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 07:02:39 -0400
Received: by mail-wm0-f68.google.com with SMTP id n17-v6so23877883wmh.2;
        Tue, 10 Jul 2018 04:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9ABMHwQSDnc/rnUHVwqwLuVruMDJJUjxTDbhCW9icSs=;
        b=Eq46rB4YbuLpd0NShZ/LXNy250bFD1IcSswZjfDfw+apJyjcTS3nwd/Q7sRzK00jPu
         hNy/aDMil1yueZLV00saOLwN/I1w8lXm+u+LVPAssUGobCSIfQ1Gj9FP0CfTES4GLHEC
         zFzbfz2xIzenDLZWtNaHUm4nbB0b93pobuojnLnWuBnY241J6vcFe0GVJBu9IKKYb5td
         Go2p81XdOXFTFeSzsp90mIrL+m6AQI0Z9mY8oBGfPNMwBo+E+zkFf7vfNhfTEiwoHnNG
         1BR5jdleJFQ0daKk1bBxmS/pvU95LOuKMApLL26qW1ljzQi/RClJ6URuST3IxkehZVAj
         NTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9ABMHwQSDnc/rnUHVwqwLuVruMDJJUjxTDbhCW9icSs=;
        b=K0o6/0bwHx5+ob/ofL2rBYR51L1+dclVEqqHg0GJ73+lijSSMS6ngsLHa+16rwlEfF
         GfIPQBIrNLmLRa/5KtkzRe351mIFkNY6VnNYhrexf+VVPrZYxchgwdZC4dWwGhIAkDqO
         /uPyEesLrzxDWgOQzukmNMngHvmnjtRA9craGwNQodo2mCfaglGup1/Z/91N5txkIDXl
         UJoLwhJCN1NdTbGTtBLsuxKC3hak9UAEo1vHX41AlLsQo2YhEjV41ErW94ud5IYcjZ5S
         oBGFhHJvuDjhqKarfgNqCvu9qt2bcxOZRDcjYE5mR9VddGi2Bo31EmsWPXU5WTcKTyK5
         KfKQ==
X-Gm-Message-State: APt69E1g/SGe+98e17v/dHOYilffr2WmqseNjhtxTsBab2bt9qwblJ4O
        S9hI+M3f2OHJ0bknafGcqXQ=
X-Google-Smtp-Source: AAOMgpfv6o83cAU50GNsg3gnmcILJqPFiT1HmwW4fi/rDmXXFYOya6rLYyNHgvkd7KvmTZQB7P10sA==
X-Received: by 2002:a1c:2dc5:: with SMTP id t188-v6mr1704273wmt.0.1531220558326;
        Tue, 10 Jul 2018 04:02:38 -0700 (PDT)
Received: from localhost (pD9E51B8F.dip0.t-ipconnect.de. [217.229.27.143])
        by smtp.gmail.com with ESMTPSA id t10-v6sm13236584wrs.59.2018.07.10.04.02.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 04:02:37 -0700 (PDT)
Date:   Tue, 10 Jul 2018 13:02:36 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, seanpaul@chromium.org,
        briannorris@chromium.org, hl@rock-chips.com,
        nickey.yang@rock-chips.com
Subject: Re: [PATCH v2 1/3] dt-bindings: Add vendor prefix for kingdisplay
Message-ID: <20180710110236.GO1504@ulmo>
References: <20180702103229.3952-1-heiko@sntech.de>
 <20180702103229.3952-2-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="S0GG+JvAI2G0KxBG"
Content-Disposition: inline
In-Reply-To: <20180702103229.3952-2-heiko@sntech.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--S0GG+JvAI2G0KxBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 12:32:27PM +0200, Heiko Stuebner wrote:
> From: Nickey Yang <nickey.yang@rock-chips.com>
>=20
> Kingdisplay Technology Co., Ltd, established in
> China Shenzhen in 2006, is a national high-tech
> enterprise specializing in the R&D, manufacturing
> and marketing of TFT-LCM and touch panel.
>=20
> Signed-off-by: Nickey Yang <nickey.yang@rock-chips.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry

--S0GG+JvAI2G0KxBG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltEkkwACgkQ3SOs138+
s6FxhA//RKpbJ4uu0h9qO5HXJX1aavxEObb+AZ9W3wGO9vvsLa0J4KQuObC41aUp
zg8eZgIEh04avxx/UAVik62rKwfKE+Hhcw/715/eONlMFJROH+tIxUSpuipEcBWN
xngKlA8VNTBnqpBWMsdasBABYpvK/LlzhRmWS5ihKV3ePd+jcHWUu5Mv87GB3aXG
wACVxMYiJ4k9wVs2v7tKMFRWfHo947ZEZEHJQ07G8o3Ph0OoGg0Xex59JwrAe+Gh
gGAOyPM0O26nhXqsEsq2ithK75zyxaJXsJFEDzkTbYvm0RMsAuXsAOA8xSLCA1v4
2gVKbUOIBfkY0b71iIJrs2k7wmyVzMaAC86wNN6MijpDjW10Mxh55bw7tg15Bi1m
TIEDRdFbmtIm0c8x/ENzlwJgEFv7zu1YQixXrTuxmAFE3SGOqbamkjg3Y7qi/qYk
dAoSy2edyEMk1+FiCMlSDyquGqulyuGNTNjtCH10FFz0Ti5QnkJVlWJd2at9A4Tv
8ZS1oRwymR875HU4nGo2IEeyfBr/5CkDBwLpXZ/sSNSAiMp4owQunz6UoAawdjMT
jj4qezCe/MOj6OMxdFZv70kI9fcMjqTgiLTL59qKMNQHZFxqK/EK5bTzUCB2gg5f
clbu9+EI99LaSFXl09Xa8SL9HUOCmYEIJMSqs2b9q5AXZjoC9O8=
=8khc
-----END PGP SIGNATURE-----

--S0GG+JvAI2G0KxBG--
