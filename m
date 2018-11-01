Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93871C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB9720821
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20150623.gappssmtp.com header.i=@dilger-ca.20150623.gappssmtp.com header.b="BDDDlL2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB9720821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbeKAJmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 05:42:49 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37062 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbeKAJms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 05:42:48 -0400
Received: by mail-it1-f194.google.com with SMTP id e74-v6so20871676ita.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 17:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=uQXlImkrl2nTjz9JBL6YVGlrwL7X11elajqEQpmyrQs=;
        b=BDDDlL2PEJu5oGxw5kEIKRT/kLWhZh5I3VBcRGWZNnt0a787l1lKJV9XaZupuJvfj1
         zFa8zJZbqNbHEv6HgEJF223aFkBCd0223TgK+4CoRxCr+ho5UnzYUjOGBbVfITt30anV
         EeQbl27MUb1xXI6eH0ydmtxBLmFgpxCMEh2RAWvbUT4p5aHn+0gASu8mx9iPEsduDCxT
         DsWyePa7Q2MpnpZMUTvhifz91X87H+IxL1HNv4dd6rprNfDj+aIKrfHp3uFIFt6EQYTv
         3VQrqy4rNXQM2RTAhrbDh01G46cLkJS5+EHPSzK8bSmG7jz5l330WqE5foXVgjnoRnVB
         xTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=uQXlImkrl2nTjz9JBL6YVGlrwL7X11elajqEQpmyrQs=;
        b=UiAXkPFe+Bixlkzcap9F9gtVhxLiSZNditfnrP1syyMiLrSoH+4yzBgzqkGb3WyvYr
         a9AKp6/deVbIDBO5ZYc9KNu32Zecjsr67kdnpp4HLyzJnP/drjWtHyCLNEwCOuuhX79C
         OXyCNBsFwoxeY4wDmKycFiKsBTcxA8gfW3ABfSKx9rExLp2PFHpqQgS88UDa8yNAFvCr
         kDBDqGqpP79eiO/ugnkhrBuq3Ec5jNrWO38gzXMtoJJ7pzd+mJhgOTkHVRluYRqYJWp0
         qA3ERdIX5erMvunz/eSVZdQdXWud/189Q82yo/5CZO0qeJUMWsK5XkQgGuar8WlotZLv
         ZB+A==
X-Gm-Message-State: AGRZ1gI1e9QD+H3KKfmGyQERgd/J/jBYYW/Qlok73XbBN2/LaQQPhNxb
        OmHdDtdfepqsRh9iJx9w+ACNDQ==
X-Google-Smtp-Source: AJdET5egB11hsgsHAz3uXfzo8OpgM5UInzm0GV7fapHGMUNVVhnqTNRJfFaMjGdipLM9PqobPxMALw==
X-Received: by 2002:a24:61cc:: with SMTP id s195-v6mr3726168itc.140.1541032932112;
        Wed, 31 Oct 2018 17:42:12 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id v204-v6sm1142581itb.6.2018.10.31.17.42.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 17:42:10 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <0C3DF51C-F627-47F7-879B-0A0D5BC143C0@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_6DAA99BE-CD7D-493C-85AD-DD18080505DA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 11/11] ext4: access to uninitialized bh fields in
 ext4_xattr_set_handle()
Date:   Wed, 31 Oct 2018 18:42:01 -0600
In-Reply-To: <0db97e14-c87d-9507-4c87-875835b64212@virtuozzo.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>
To:     Vasily Averin <vvs@virtuozzo.com>
References: <cover.1540935522.git.vvs@virtuozzo.com>
 <b8523c3a-0eb2-3aeb-fdf9-2e9d6d320d5c@virtuozzo.com>
 <48BA929C-9BF7-4092-BDD3-BECB64AF0599@dilger.ca>
 <0db97e14-c87d-9507-4c87-875835b64212@virtuozzo.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_6DAA99BE-CD7D-493C-85AD-DD18080505DA
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Oct 30, 2018, at 9:39 PM, Vasily Averin <vvs@virtuozzo.com> wrote:
> 
> On 10/31/2018 04:30 AM, Andreas Dilger wrote:
>> Could you please explain your statement below that on-stack
>> initialization does not zero unspecified fields?  According
>> to documents I found, for example:
>> 
>> https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html
>> 
>> they *are* initialized to zero.
> 
> I did not know it,
> I re-checked it in generated assembler code and found that you
> are right and I was wrong.
> 
> Please drop this patch,
> should I resend of rest of this patch set once again?

I don't think it is necessary to resend the whole patch series.
Ted should notice these emails on this patch and not apply it.

Cheers, Andreas






--Apple-Mail=_6DAA99BE-CD7D-493C-85AD-DD18080505DA
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlvaS9kACgkQcqXauRfM
H+APEQ/+LKwBcyDcl5jacJue16RzP2SkekzEfNoBT7Im5yphpPaqVHj2mnrMkeKZ
SZ47lyRwtLTSahMGOK3jur1AIBg4pcdcBZzM8ydtIXnqs9Yqq3oCGQX1F0oz2aGQ
FlLKwNRphxhHlv2GfTpKs0eCkhZXlgWiLCfTZW++w/Xi7mypDYenQFLaTaZfVIgC
5z45X0KDaBy3oJWKT61EVAMlGVDJzD5oaFXUJyloi8iMgSGTV/Hlzrh+U7mw75nE
ENfmSqMb5CHBaFVkFhlNUCg8VUvJJr1X/kR4UXdsN48xlnDkKDTNwXMVyat4NOCH
6PX9cTAzRnngbjSxuvOvMy3/Ybov5K1mPWSr3FeKJFbXf0E2krMp8TjxOUGglsH5
F9Eefhr+33zufHYnkO3NMiCBXqe+Wyoaw7SuoRZGvaRJzHlEDKjgT/xOBhs/eWWE
iM/02LkXL2DGEmTS6WdW/BUMyNcCQWOWcZ11SsE04K1SpaKFhCWEr+dEMF+QDrYH
h9phvwVGwCczEHDdMaisj2/t81nFeqiYBimSaYGIMo8Qvoe6Y6ozadlJw3iShNmP
W+g2BOpii2Fl2KQq5WR+Cwewd9b+RpAsYELYqxiGtJL7Rw/zzCbsy9GMbRxO7hkU
eClUvYutAekvi7CutkHIu0ngeHFAK/ti+zbeabJNlokHZUXkwnE=
=aigz
-----END PGP SIGNATURE-----

--Apple-Mail=_6DAA99BE-CD7D-493C-85AD-DD18080505DA--
