Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BBDC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371C320685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IO7rRKEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371C320685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439736AbeKWXyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:54:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:48262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394696AbeKWXyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:54:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7325F20685;
        Fri, 23 Nov 2018 13:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542978638;
        bh=IRNVbAofLNbD3p5wsosrut7GJ5fWV+etyBCl6UfK52A=;
        h=Date:From:To:Cc:Subject:From;
        b=IO7rRKEuRgnJt3OVSIYroXett34dL4mrmWn6y5+2kjMMebz/GjNI2jrPHdY4s4/25
         K2KGVv/R8rQq9TqC9hG1ZP6u7IHlROdQYb1m8VzKSofY5wurazflBM5oQFLsYd70LX
         1zAI/ZIXRprynZWNCruh2Yetv7Avd93vRAXaflPU=
Date:   Fri, 23 Nov 2018 14:10:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.140
Message-ID: <20181123131036.GA15416@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Sorry for the quick follow-on release, but this resolves two reported
issues that should have gotten into the previous release.

I'm announcing the release of the 4.9.140 kernel.

All users of the 4.9 kernel series must upgrade.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.9.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                   |    2 -
 arch/x86/kernel/cpu/bugs.c |   57 ++++-----------------------------------------
 kernel/cpu.c               |   11 --------
 net/ipv6/route.c           |   11 ++++++--
 4 files changed, 16 insertions(+), 65 deletions(-)

Greg Kroah-Hartman (3):
      Revert "x86/speculation: Enable cross-hyperthread spectre v2 STIBP mitigation"
      Revert "ipv6: set rt6i_protocol properly in the route when it is installed"
      Linux 4.9.140


--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlv3/EoACgkQONu9yGCS
aT6QPg//V5soxHPKjJYmvA/Q2YcXAQU5+b6H4ikjeSoFclK4YsHylNZ3QjiJGgXQ
PwklgVckl+DiXXiVJR/+wkrY/x/2Ir/2J6lkDKYcI0SY0lpeCJEfo8uZzCqQ3irC
vSMI0Ry9XDpBx+vcQiWVBrwKkc6iSZhIUeMRvYuWfcEQB71KLkjkRYTB+uC+fn7f
kh1b2tbBfSk34mgY4pZEVq3cP7FWVJw1RcD79ZLXTqCzRRGDaXWxuiM99X4WQog5
ChyvW8fO5MwCWDNDhUv0pfyDwcPnFoXJAGsxettseiF59jWZ98hNNTemUjZRdln5
ZmxYlC6RVe0WXu9z57vDHOxnIlS6zSdbrAWRPTYJqI3D3CNDOZhh+RWzb3/9qXzJ
iRDSdX8g6bKo9sf7yArtjzj49xmsXIii/xPASD91hFbPLpH5Cyv8jrGZFTzPnWxg
3G+LpvjhpWuxWrFfAkUvYq8pHYVHGcK2sUJKRVJF6QixsDwVZHCxWwWmP+L8YD0m
tGN2M9Hq9wX8kbEc/dm3Ut7sNzx4C7AB5Aodxhq/Cm/00SwjjaPq/lD3yx5rclYW
Ukima1EKFCYvy4JATULX7EVeQK4w+16+5k+Ed/8Gv0v76HWeYm8C8PuolcBjQ6ri
0N7pdh/Z19+raqHy/YL5XkLq+TpVXVTiFDyjYuvhnw2ytncCMj0=
=mvyT
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
