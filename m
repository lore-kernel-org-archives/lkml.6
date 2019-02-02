Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90F1C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7409B218FD
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549101129;
	bh=0jkox7BZtHrNQVrqmLCO7RaDDy6CIxlHshB1lmHJBVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1fObBG3LtSB4iIcA/ME6G04mSW4HW6VGTak8fOmIn8TQa9hFGivJOC/qcv/bAgEqr
	 /mAVVwNGqETHzuPVandnKV1026i5+y71eOnpOWTtrjLf4AyhJoHuLG+61bJRKWcJ8X
	 6HRvQeISQ1J062lpzQQZG7mCUvqdZA6IaNQQEFes=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfBBJwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 04:52:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:46348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbfBBJwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 04:52:07 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C1E7218F0;
        Sat,  2 Feb 2019 09:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549101126;
        bh=0jkox7BZtHrNQVrqmLCO7RaDDy6CIxlHshB1lmHJBVM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QlDIF+lDcNBatE/BRm151/VAKmDui400kqwfyXq3LoHkw2NpBH9LFvVcmbph7IUu1
         lQPUwI1wycGh9hVAlKPwd9rBDIvW+yv8RoUclnEj0zKVUvCftDjzH8sS9gFHa8HduC
         ppboUPGDd+z6Uqr90gyLVvpxsEUPq4rPCC9ohK6I=
Date:   Sat, 2 Feb 2019 09:52:00 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Randolph =?UTF-8?B?TWFhw59lbg==?= <gaireg@gaireg.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Masney <masneyb@onstation.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Douglas Fischer <fischerdouglasc@gmail.com>,
        Martin Kelly <mkelly@xevo.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: imu: add icm20602 bindings to
 mpu6050
Message-ID: <20190202095200.2180f701@archlinux>
In-Reply-To: <20190130194942.GA30767@bogus>
References: <20190128185010.8275-1-gaireg@gaireg.de>
        <20190130194942.GA30767@bogus>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 13:49:42 -0600
Rob Herring <robh@kernel.org> wrote:

> On Mon, 28 Jan 2019 19:50:02 +0100, =3D?UTF-8?q?Randolph=3D20Maa=3DC3=3D9=
Fen?=3D wrote:
> > Adding the invensense ICM-20602 to the compatible list of the mpu6050
> > driver
> >=20
> > Signed-off-by: Randolph Maa=C3=9Fen <gaireg@gaireg.de>
> >=20
> > ---
> > Changes in v2:
> > - write i2c disable register using reg_set instead of define
> > - decide to write to i2c disable register based on reg_set instead of
> >   chip type
> > ---
> >  Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >  =20
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan


