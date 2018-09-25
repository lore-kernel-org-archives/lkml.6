Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D57CC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 05:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BFD208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 05:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="TbkUgGdJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6BFD208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeIYLdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 07:33:32 -0400
Received: from mail.andi.de1.cc ([85.214.239.24]:34096 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbeIYLdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 07:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Pt/cm/keKRdmKj9xCQaxfR1uE38+MHROvQmkNqtWhUE=; b=TbkUgGdJOM8pGw0QlsNc6jCyg
        WtLWomu0fUsJUkG3/OfH64sycjvahyDVmJK4wmWR7C9zJ87lFQ4m9gXrqJcASFGFC95D2HIxYmESr
        mlaj7W28h8UR9PrVPaLyLAi+kqdSrPXhbf7vooFN0QaVMcjtArSxV6kNWmaiikRxE08cw=;
Received: from [77.247.85.102] (helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1g4fsk-0006sy-U5; Tue, 25 Sep 2018 07:27:40 +0200
Received: from [::1] (helo=localhost)
        by eeepc with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1g4frv-0002N2-Bq; Tue, 25 Sep 2018 07:26:43 +0200
Date:   Tue, 25 Sep 2018 07:26:36 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tony Lindgren <tony@atomide.com>
Cc:     =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Subject: Re: [PATCH] ARM: dts: gta04: add serial console wakeup irq
Message-ID: <20180925072550.424e82e7@kemnade.info>
In-Reply-To: <20180924220345.GG5662@atomide.com>
References: <20180923150719.8211-1-andreas@kemnade.info>
        <20180924220345.GG5662@atomide.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/U736Hjz4msrhS5TIRMcCICx"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/U736Hjz4msrhS5TIRMcCICx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Mon, 24 Sep 2018 15:03:45 -0700
Tony Lindgren <tony@atomide.com> wrote:

> * Andreas Kemnade <andreas@kemnade.info> [180923 08:12]:
> > This enables the possibility to have more aggressive runtime pm
> > by providing proper wakeup irq for the serial console. =20
>=20
> Thanks applying to omap-for-v4.20/dt.
>=20
> FYI, you can now grep wake /proc/interrupts and see the
> wakeirq counts increase when they trigger. Might be handy
> for debugging PM stuff.
>=20
thanks for that information, you also had a patch for checking
pm which was explicitely marked as not-to-merge. Is there
any up-to-date version of it?

Well, for debugging I check first average currents via bq27000
attached to omap_hdq. omap_hdq gets stuck after first transaction
after idling uarts which does not happen when CM_AUTOIDLE1_CORE.AUTO_HDQ
is cleared. Reloading the omap_hdq module to try to fix things
makes w1 really freak out (patch already sent for that).
Well, will do some rtfm and hopefully come back with a patch.
afaicr there was something special...
The result are power management problem in /dev/brain ;-)

Regards,
Andreas

--Sig_/U736Hjz4msrhS5TIRMcCICx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlupxwwACgkQfb1qx03i
kySfrhAAl4iNzNHtUh9FwtewvuB/4HVtX5zn/mbujKtPE3pQnKPLtpn4UNkLJQZU
OaymyjkUnbPl6Y2ZO7G1ASZ6kBy7xC2FXaSgkrITTe8Sc7V1HsNxUX84OKiAo1QC
EMliiQNZwY3KT0+hHVrA9JboV4J5bM6LJ/OwUbsfuBHZzffZOx4KtrebSj/5Rljy
Emip5N3mbsa/k2tAPsRAOFovMSWt0t2IeXpKHomoRP353Nzkz3B4a/LFTZeci8sO
f8gOJvKbZ+7+AItXhrRHnIrSqmSCqZW1ugz9Z1M9F6S1DQpWmfhX0ra/QyLPNQ40
2gRD7kp5wum99lhs1AzXuwtOvA9nWSxMd69WiSQlYWam2usDdi30bLDLufQGhD0f
CWWIFEcfV/sakACkaePh9C6Q2gWUVxPZuTj1PwVoy6gLk/vDC+v7/YgZCaQKEYSY
vlcwKfvALa9baYtmUl87j046A6WbrA5A20GAfz1BUCIbLfY7n7SnA032OzLzlbZK
r78UdX+vXkMCBvzZAUK5qUzmlWxS0jv6RkW0xY/o/I3YCpVLPJlGLdTIMDYQ+MEH
oI430AMe6DbDKGjczeaMldunNcmrBj9Lw/nWx1bP0jKQNVHVdeoGRmcQKNBS0q4w
8D8lhwE2JLy27c5Fc/Ch4LWTEjaQ6ExVs4Gk4IPq+9cZ7T0Y46U=
=px2V
-----END PGP SIGNATURE-----

--Sig_/U736Hjz4msrhS5TIRMcCICx--
