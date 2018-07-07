Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B85C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 16:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1440E2175C
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 16:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ja4E3oPO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1440E2175C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754309AbeGGQpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 12:45:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753949AbeGGQps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 12:45:48 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EABF21076;
        Sat,  7 Jul 2018 16:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530981948;
        bh=fB3bFjX/m/bkaOHxTFl9NHsH0rY6uHG3/2SfSnNKKh0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ja4E3oPOi2jmslgAh79ucd1DwlDTg3fwEA4wTBOXRtloRRmwW+UKoPzdXBnPz2A0t
         AtFJ5T3TJuWCbOrUMq8Hrlzdj4P6xb/4Q7/RPOfaxq45Er3hVhR9Yz/9P1e9cfLeWh
         ofK3qkKCPpGeK0HTMf+BoJy6S7enLitGuJrPTwlc=
Date:   Sat, 7 Jul 2018 17:45:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean =?UTF-8?B?Tnlla2rDpnI=?= <sean.nyekjaer@prevas.dk>
Cc:     Colin King <colin.king@canonical.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: remove redundant variable 'shift'
Message-ID: <20180707174543.1f67e22d@archlinux>
In-Reply-To: <62141c55-575a-d068-360a-e0ea53df6f17@prevas.dk>
References: <20180702102435.16724-1-colin.king@canonical.com>
        <62141c55-575a-d068-360a-e0ea53df6f17@prevas.dk>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jul 2018 12:43:20 +0200
Sean Nyekj=C3=A6r <sean.nyekjaer@prevas.dk> wrote:

> On 2018-07-02 12:24, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >=20
> > Variable shift is being assigned but is never used hence it is
> > redundant and can be removed.
> >=20
> > Cleans up two clang warnings:
> > warning: variable =E2=80=98shift=E2=80=99 set but not used [-Wunused-bu=
t-set-variable]
> >=20
> > Signed-off-by: Colin Ian King <colin.king@canonical.com> =20
> Reviewed-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
>=20
> Good catch :-)
>=20
> BR
> /Sean
Hi Colin,

As ever, thanks for the patch!

If you wouldn't mind putting the name of the driver in question in patches
like these that would be great.    There are enough drivers, that I doubt
anyone (other than me) looks at all patches for DACs.  They only look at
the particular parts they actually have on boards ;)

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan


