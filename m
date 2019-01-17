Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD197C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BB620652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547739396;
	bh=t2FBn0J/BcupMwYzFMIBEh3ZJ9ldVENzDMZtzpN5Q0Y=;
	h=Date:From:To:Subject:List-ID:From;
	b=I1ikoSxp1QRSImL9fgQtDBQjNsFybp08M0vP1ZnrnBXD81r81c8ugQrB6XfYICJ3N
	 atEhEi4HMxg1XJ1Rt+DC64CTSIbRl1zE2tGe3P4PdY7PPf9QKL4wfopwnB/iiwpCIZ
	 My/q+M/IjbvL+LBRwTWwZq2XQp/kwJ4ryrt/AlA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfAQPge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:36:34 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46986 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfAQPge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:36:34 -0500
Received: by mail-qk1-f196.google.com with SMTP id q1so6186995qkf.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 07:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ng2CIeLikQVApX6+ZAVaiSUGIm+YtUIYnDD+RTA5Fv0=;
        b=rZzJXXWJuK3QDnAH2vhh8Ff0B8rdUgvSHYyg3aOk6r7FMWRIwK4hfTyMonyiR5p+Ze
         DEdLm2li3B4ctUayanU7tTwg8kotXtcWPvDmZE8YM2YYPrhP7YrgUWW/YSbuXdqXAGSh
         h6CyGY+NZt6J4G4UyP9TIVDvALb00+lvlVxRXkB/rAS5dX7blWH7WBHKBUHbyWHzhwSi
         wIzZeg1lv0ALfqMBEKXvJ+H7drf871mAuLs9S5YTOvvt7LM11lYl7V61qCrNv3FcPqN6
         KeWZFXRHgRibWn2/SuERoCvMjSuhILEsWszyaPbL3qdiF9fg+U/Wpa14pG1FoIKIvKOl
         wQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=ng2CIeLikQVApX6+ZAVaiSUGIm+YtUIYnDD+RTA5Fv0=;
        b=K7akbOZWJNHHfqRSrc7uWI12TIIgZ4i9E8pbxZ7zGec/j4emVungWklMqsaE5zc6O7
         tD8WHjQ+BhW7ZhRdiQt5QbJu6sMqEjr7tYS2+s6wmjrBfuEDL+bRM7tYGpbMzWe9vk7l
         YuodiIxZml7zaRRK1cirRUsn08WM6J47rQVSbb/44ijXbkFGezL53ENz3X1T0rFrWr4Q
         tCrDv5YwHv42Ybk562LazIKxDgi52ysk+y0VB8EmSgvNAfFF/RJIG72W1yDdb+17PKoX
         CUXf9fP3b4BcffzsAHthffpZ+zVmKwneYm3TFKO0TGhdH7eDd9X0tiOn8isNvyGgJi9C
         Mp2Q==
X-Gm-Message-State: AJcUukfPgnb0eDY8fnIeomU3dc2OUbXztGoLs4FckQH54HN7Qx9qUJKI
        lRYUQT73vyN6Pfqy1KGNbCp72Pd9HDUGsQ==
X-Google-Smtp-Source: ALg8bN5so0x/vPKn4Xbrv5GxLsNQv86kHBPI41NTpdTMHWMeRhLYa+Eu2WLYJG3JU6URLC0M6dAneA==
X-Received: by 2002:a37:8383:: with SMTP id f125mr11254225qkd.49.1547739392917;
        Thu, 17 Jan 2019 07:36:32 -0800 (PST)
Received: from localhost.localdomain (198-0-156-163-static.hfc.comcastbusiness.net. [198.0.156.163])
        by smtp.gmail.com with ESMTPSA id y12sm66368662qta.13.2019.01.17.07.36.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 07:36:32 -0800 (PST)
Date:   Thu, 17 Jan 2019 10:36:30 -0500
From:   Konrad Rzeszutek Wilk <konrad@kernel.org>
To:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        hch@lst.de
Subject: [GIT PULL] (swiotbl) tiny fix for 5.0rc2
Message-ID: <20190117153629.GA24883@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Linus,

Please pull a tiny fix for v5.0-rc2:

 git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git stable/for-linus-5.0

This fixes an issue with GPU cards not working anymore with the DMA
mapping work Christopher did - as the SWIOTLB is initialized first
and then free-ed (as IOMMU is available) but we forgot to clear our
start and end entries which are used and BOOM.

Thank you!

 kernel/dma/swiotlb.c | 2 ++
 1 file changed, 2 insertions(+)

Christoph Hellwig (1):
      swiotlb: clear io_tlb_start and io_tlb_end in swiotlb_exit


--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcQKD9AAoJEFKlDoTx2wm/tUAQAJYB2CaPd09ddhCw0X/WZCWD
wX3/ERgkCLHfcE7+5bc5U5l+BFJHUqkozCCtsqgLA2qUKfo9WJoiem2dk8lTVZcC
4V4GVo7O/ViA8mT+emiNJe44ncYtGwwD92ewVZH1XLXk/0TMfMxiXAu7/Dmu0L8i
WcbpPqZDe1gkwe8TDp9hYKTd8xfre6ILiYPgxT8zV1uj2FzGE1oV18u2nHY08qi6
S7qjfgjMN8f37CKEtbXJcgRPay+oPsP9zi8j0tFwfwAKexEd4oCwnaYSyyDYFy3i
iHXkUEiMycbBPh1kLIwnwLPFQDSkppTVX48EJwpVqrrpxsfAh4h31+4vuIKjj1pM
vg6yo4yobYvc5j3FdS8ZDetRJjvbQjjqQ8YjrABevavE9xHJ9CBY5o0rfR04PYZG
4i3BXzFWMhRBcHSEjvvK2SbCVJYIVbCKbclzmKITwxJZ2bf26GYpeL2n+ZbB2ySX
xqHQCscJagt1juQQ3dbd8lFR1tXNkHCy2mqSWOcql/AZdc0ocrta6ygMVF+JyTNI
4bIslFc0t8M1tuSx8uJvrwmDUqFHIHiyC7hmgfHUzyKsZmmAS+s1azJqNgLDEDvc
je8aRIb3gcUpqdmgdQoErNu148zUHkoBBuDoRjPfrB00smco7PPC4H+kL8qrLoK3
TIhZOP9s2ImnR71uC1cC
=fZZ9
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
