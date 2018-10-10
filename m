Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32782C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E496521479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FO43QfQ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E496521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeJJLng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 07:43:36 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44723 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeJJLng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 07:43:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id r9-v6so1935654pff.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 21:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=qxdb/oF5RsodmRM/DNMewifoX3jBrGAT8goJnVuoOms=;
        b=FO43QfQ8zmlvEjlWIVhQcWOlgo7SGEoU0ZtVT2ew8Or9fH5AfCuus470hpGHG3lQW1
         jZ65Dwn/0vNPsP7WpbYCsWUzp/qs+Hk3G0ClAv/CdnW+D2q5qOMoC/fAs+Fns8o7uR+6
         tsCDKTES+g0nggwHjDJTthLb5aqJCD/0nKu+AQyibIxU5GV5wrpPvM5mohiJcE8GfSMU
         EOzpAMa6C09Cmo2qEeu9K4gScbR6TAKcUHlm2usHGFklsTHrNbzWVdTQU3hrZDTTfjWk
         1ApN+e8VeARz+cKp3L+ExUUkEjdOdvaGC3d8RMpBaTuUewM5cRP43x1AfTeOB5WFtvyR
         UbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=qxdb/oF5RsodmRM/DNMewifoX3jBrGAT8goJnVuoOms=;
        b=IxJ9/J0vNuGq0GinYyJy0i7SDiaMAJFwPtwWMEPZ078Arel8CaG64Kx+yVOSPoTUoH
         Zny9304vudJizYfTweBS0bYjUW3RCUnsXKjlHHMIhsVZTuiZ9H+xAu4QZCTNIQcSER+l
         0qGRJvchaROxR5/549XKnYgfT2+NGOCuhTjG06sBVfbqv/0c1pQyLZj2eRp6JYG5AIMu
         YwmwC3sfoHIWSTxnx4VUT+QzaHqnDRjlWxMW7QbPn2UmxZTUnkI+SoaxmjOQpBYlWqE6
         T9I0NJ+LiRozJnqhpaNu9Xwb2UZ1XTQSQ8c4MZ3+g4F2zrHYL2aPEWxOj08fJP0rRR4e
         nyeA==
X-Gm-Message-State: ABuFfoj3cvO3JlpfnyT5f2RoKBTI0hYHGEd4TasoPkMJ9SLukuLtgQ06
        +decyXpKs066unIgjW25DL67ig==
X-Google-Smtp-Source: ACcGV63z+3mN1kdo8ohRQRupgb2ixVcNACu6nqiKxNQuYx/+3OwiYBVIMkiuARW0qNEX6eaxCzrUug==
X-Received: by 2002:a62:302:: with SMTP id 2-v6mr32367034pfd.145.1539145401461;
        Tue, 09 Oct 2018 21:23:21 -0700 (PDT)
Received: from decatoncale.mtv.corp.google.com ([2620:15c:202:1:c562:226a:6d78:2ae4])
        by smtp.gmail.com with ESMTPSA id a14-v6sm24206714pgi.75.2018.10.09.21.23.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 21:23:20 -0700 (PDT)
Date:   Tue, 9 Oct 2018 21:23:18 -0700
From:   Benson Leung <bleung@google.com>
To:     bleung@chromium.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, jekarlson@gmail.com,
        narmstrong@baylibre.com, enric.balletbo@collabora.com,
        olof@lixom.net
Subject: [GIT PULL] chrome-platform fixes for v4.19-rc8
Message-ID: <20181010042318.GA142005@decatoncale.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Sorry for the late in the cycle request, but this one is fairly urgent.

Please pull thi fix to chrome platform. A patch that landed
for 4.19 broke cros_ec based chromebooks' keyboards, and this fixes them.

Thanks,
Benson

The following changes since commit 0238df646e6224016a45505d2c111a24669ebe21:

  Linux 4.19-rc7 (2018-10-07 17:26:02 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git =
tags/tag-chrome-platform-fixes-for-v4.19-rc8

for you to fetch changes up to d4d2313a3c17eff4aef9a544023c2df5b9f5bedc:

  mfd: cros-ec: copy the whole event in get_next_event_xfer (2018-10-09 20:=
57:30 -0700)

----------------------------------------------------------------
chrome-platform-fixes-for-v4.19-rc8

This contains a fix to 57e94c8b974db2d83c60e1139c89a70806abbea0, which caus=
ed
cros_ec based chromebooks to truncate an entire column of their built-in
keyboard.

----------------------------------------------------------------
Emil Karlson (1):
      mfd: cros-ec: copy the whole event in get_next_event_xfer

 drivers/platform/chrome/cros_ec_proto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlu9frUACgkQHwn1ewov
5lhPsA/6A/3ajQGVPbOWb/AS58GqcZSwzyjO/umwfrMu4QpneyPEwhIQpBr6J8P0
BHlKOnGzUDmoa83vbgo+MMpMcDy8tkL8FmGd7o4wPeTiWFqpakg1yUJQYiS/TLRC
hnHzG/o3XWg9Pas8tDBf1J/72U5Mj7qJ2NrpPgRkNSBw5ql2UN4wwW/vMQPoBXMK
HgGNzmfHLsXj+Kd7maADUGaTFvjecjFxzkpZdzvELVz0BTR5yM+1vEXeQTk9R62n
mtIwwDAKDgjwuPeNG7h21/5Iwk4gz0/LvHUjoYFDJnD8+EHG+U8PRw7HJtz9KV0O
QNBFyoBvCCq7Gz/rOjuEaimlIFEXsryTvQdSeWVlXMgE5HDZBTvcPVvzxCF6APy+
8XkCp0tLYIyLbp37gkXeSWSlK/Thq9+QTj5QHFX5/849vkJC3LRMDr+O/BOg0F03
awr8mmv1+cbS3Ntqf1GH/7GQXT6k2UtnadPtu3F/UhUEGxK1LOb0u24KFTUJa5l9
0r11AA9cwPyA18kwzcNeVNSs5JSwma57yHf0A43MYlSEMLrGi9RKJ8+pTFAG7GCA
2hKsZF0lLyIx2NjlzShLHznWNS9Dw9yoWMgdjJVdRK5vUFFqJdcBwk5rEMyKVNO6
wl2HGv6qW71dyayTHj9pL4kZh1K4FRiqSkcqFE0q7eV3Xdvn1k8=
=XJaS
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
