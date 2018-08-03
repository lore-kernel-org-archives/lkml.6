Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70718C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224722176D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 224722176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbeHCSX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 14:23:57 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:37374 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727171AbeHCSX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 14:23:57 -0400
Received: from mr5.cc.vt.edu (mr5.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:72:232:758b])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w73GQvAa016863
        for <linux-kernel@vger.kernel.org>; Fri, 3 Aug 2018 12:26:57 -0400
Received: from mail-qk0-f197.google.com (mail-qk0-f197.google.com [209.85.220.197])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w73GQqE4030463
        for <linux-kernel@vger.kernel.org>; Fri, 3 Aug 2018 12:26:57 -0400
Received: by mail-qk0-f197.google.com with SMTP id w14-v6so5770725qkw.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 09:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=FaZqsIkUsL37KoYQQFQiPtyCUC3/GCTedIjEhKCNvss=;
        b=Z1EGalkdgov89A/khxh2yg0dAgyLc6CPfeY5Ad+uimgoXwTvjT890exUWTWbIlwTaN
         TSks4ixIU8ak77ByznIHmOHual79UE55Ysix/pL8Tte7k0UCpO5MXMM/Wzsoa0qLuYKq
         creDvAsy+1UG1e2L9JntD4nc5+LFkPAbx8HnmF/sSDGza8QKjm6XeI3i1unVTRSNWcoI
         4S+CB2F5EGTHDesF7pn5hw9Uab4z0g3nF1WZCllSeJq6LQHHZil6+0SbNEJEkQMqzsTf
         vFA3zS+zejLtdtk3P3BmwFAeEISk/ualtvJCMyLj/UfBM2LnLjwb9Tqjbykip6ne+eIj
         toYw==
X-Gm-Message-State: AOUpUlGJ/QXiEDM4XeopoRNYFIJ3ZvXmqjLah9DWe6vpLWpGg32GWa73
        +3Pl1njg+Uu8lJcP9PxFyyGz5lyO0bN3Ny2feciYSXh8OrOrVNx1sBg4U8uYAX7PYSlBX8EJTmP
        D3rBXLsiF2AndHfVohFXhVm3lB27YTznUFMk=
X-Received: by 2002:a37:2990:: with SMTP id p16-v6mr4356130qkp.386.1533313612146;
        Fri, 03 Aug 2018 09:26:52 -0700 (PDT)
X-Google-Smtp-Source: AAOMgpeM+j3z8MI9KiajQ0/XFv9OFmolNj1ABAqkMvtrl8iZvNWW/M6YGsVu5YK2SqxsVnO8PG3T3A==
X-Received: by 2002:a37:2990:: with SMTP id p16-v6mr4356116qkp.386.1533313611927;
        Fri, 03 Aug 2018 09:26:51 -0700 (PDT)
Received: from turing-police.cc.vt.edu (turing-police.cc.ipv6.vt.edu. [2001:468:c80:2103:f21f:afff:fe0c:8ada])
        by smtp.gmail.com with ESMTPSA id o26-v6sm4757110qtk.4.2018.08.03.09.26.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 09:26:50 -0700 (PDT)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 11/11] ASoC: wm8994: Mark expected switch fall-through
In-Reply-To: <8e3df79b1dca92d49fd9d5c97391d31814ab40f9.1533151956.git.gustavo@embeddedor.com>
References: <cover.1533151956.git.gustavo@embeddedor.com>
 <8e3df79b1dca92d49fd9d5c97391d31814ab40f9.1533151956.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1533313609_3353P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Fri, 03 Aug 2018 12:26:49 -0400
Message-ID: <30613.1533313609@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1533313609_3353P
Content-Type: text/plain; charset=us-ascii

On Wed, 01 Aug 2018 14:56:16 -0500, "Gustavo A. R. Silva" said:

> diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
> index 7fdfdf3..62f8c5b 100644
> --- a/sound/soc/codecs/wm8994.c
> +++ b/sound/soc/codecs/wm8994.c
> @@ -2432,6 +2432,7 @@ static int wm8994_set_dai_sysclk(struct snd_soc_dai *dai,
>  			snd_soc_component_update_bits(component, WM8994_POWER_MANAGEMENT_2,
>  					    WM8994_OPCLK_ENA, 0);
>  		}
> +		/* fall through */
>
>  	default:
>  		return -EINVAL;

Wait, what? This looks like the sort of bug -Wimplicit-fallthrough is supposed
to catch.  Unless for 'case WM8994_SYSCLK_OPCLK:' we actually do want to do a
whole bunch of snd_soc_component_update_bits() calls and then return -EINVAL
whether or not that case succeeded?



--==_Exmh_1533313609_3353P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBW2SCSY0DS38y7CIcAQLkVAgAnBZwfgNeHjXkgKpbmkH97cvtiknlB8cM
XzXz8o32fyAfDSWNJFRaymMPigJ0+PnyiEqX0Tcr9dMcwBOzLEBkvVC2BWxNkD80
KwnnE6hJfT/oVg4Ugn6UFboqkqTHMeu3np5WysjFH++2l53Zp0MxNWpZAV/qYo+4
31eysJLdoWVgspMESFkMu9wJyBiM2sNRHu1dDUM95CfgmLnQVUAfNhmhdg+JQTJu
RTLdNrTcxbV47Dac3giaatfk0cTjJ7b8Qp+N9r7EQlucvcQzsemgvI/8YMo96e89
l1FtSzU0VtZyYk5CDXLKs4OXNSVaojXyfIFfp5jojFhYmDetDoSl3A==
=x0wR
-----END PGP SIGNATURE-----

--==_Exmh_1533313609_3353P--
