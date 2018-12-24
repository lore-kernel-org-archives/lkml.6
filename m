Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBD9C64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 18:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6AF21736
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 18:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="XqeXoOya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbeLXSqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 13:46:36 -0500
Received: from narfation.org ([79.140.41.39]:35398 "EHLO v3-1039.vlinux.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbeLXSqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 13:46:36 -0500
Received: from sven-edge.localnet (unknown [IPv6:2a02:2454:8871:1700:6a17:29ff:fee0:e6ec])
        by v3-1039.vlinux.de (Postfix) with ESMTPSA id 741C6110134;
        Mon, 24 Dec 2018 19:46:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=narfation.org;
        s=20121; t=1545677193;
        bh=E2y/qlvCTA2zswxENpfuVSHvwJw3tCps8L6n3n86wO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XqeXoOyaaqDrAaudkuQJFtApTqQ9+mZz68jsUyHqy/KmRRtjlB0bmII0hgdoIET7L
         4O/7rAiH5AeUGY99yGLbknz9zduUQPrgBbOXm8n46MsK9hUxEVh2HVgVh/qidckzpD
         BFSix9VlIVOtNHuvA44DoSqL1nRXP54FkTRcyt+0=
From:   Sven Eckelmann <sven@narfation.org>
To:     b.a.t.m.a.n@lists.open-mesh.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Marek Lindner <mareklindner@neomailbox.ch>, kjlu@umn.edu,
        Antonio Quartulli <a@unstable.cc>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv/main: Fix check on return value of rtnl_link_register
Date:   Mon, 24 Dec 2018 19:46:32 +0100
Message-ID: <3515548.IyJqbIalli@sven-edge>
In-Reply-To: <20181224174926.20321-1-pakki001@umn.edu>
References: <20181224174926.20321-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart140518754.v2Ycy2XqpW"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart140518754.v2Ycy2XqpW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 24 December 2018 18.49.26 CET Aditya Pakki wrote:
> rtnl_link_register() may fail and can impact registering the device.
> The fix checks the return value and pushes the error upstream.

Regarding the commit message - what is "batman-adv/main"? Shouldn't this be 
"batman-adv: "?

And the device can still be registered without batadv_link_ops - just not 
using rtnl.

Kind regards,
	Sven

--nextPart140518754.v2Ycy2XqpW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlwhKYgACgkQXYcKB8Em
e0ZL0RAAxtawbTcwqlL8r79AWaXuiWh9o+J0ZZVRd+9hjfA0RnJpRgf66Q7Itas2
EjXOaPjvEwNXG3fNORRMjvaFrjitPTjahyJiYVjlsF8D09rZkCRBQ2DtkEFKuQFG
GvYYbtd0zB1FYEQuA6P7j+TMi9Iocpy+afeVTFdgKzJfRe9n1uiqSiNxvLyTdv8g
DpZ054QKXhD2EpJxDT5RF6mJMeWnHqj4DYQ9jWyLk0IYicPYrByIN1QPBlwYYBR7
fHYXGT2g+4IWIOPZa2slbmr/U5FEK8kjAqtfhK98zR+MnsRH2oB+JGONmELzINRb
aGcGgw7pDmvVEX+myqFPWI6hPWwvYOyLIeVwW7qdTSMpmZyT1r5znw2hx7TzFwMj
jRplEh3kUkP1wVn+D91G9JxAvMxbZyecCv9rLgEnLRk86aqH5e+mKTt/UmM1bcOp
zKrw8VnSzC/e6VURdGE1ZTAu3XOerQpD7tW+ZSW39zJ/uZNWM0nxHhHdX4qyW2wu
Hn/V11b8uwzzZZ6ZCfq2LLucdNqk2rwQx/a5hYneWsx+3t7tQE2PUo2uLzRRjBhU
OQaIdZQZQPwOpXv57xKWUAzZdyt8VRf4qtXFCzxScHtGPd6tuk+aRdUKbj4DgIl9
HRhcp6U5ZIaJijiFbi6gvpAGFtv0lz04jxqSgz3MvaLiTVNLUFk=
=8Nd8
-----END PGP SIGNATURE-----

--nextPart140518754.v2Ycy2XqpW--



