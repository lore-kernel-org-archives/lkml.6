Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA105C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5A020652
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loBc6E/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5A020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbeJLW2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:28:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40870 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbeJLW2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:28:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id d2-v6so13786265wro.7;
        Fri, 12 Oct 2018 07:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XJevRoZGKZ1/mVP15Q7uhNhNbWb2qp8w9iWHdcWf5B0=;
        b=loBc6E/ycEr/yI1Xaf9rHjPViMVRrbVlZL8P1KWWWoRzIhVSPLtvpMEQixRDTGRz0B
         iS/gWRFEYsQc7muFn2WmOdFfQ7JGQ5RRggwO0mAlgoZazRUhkULxo6W+9dIsrZkY9RzW
         u5fxxEClMXtVHJ0r9fcVhfdpdxfy5RwnFakmeJV/56MNuvoNlJ29DuiBZsh8fYvTmPK/
         fj+qd1b2NeTwGjJ83e7Dc//AZjMeMXanTafkICmUzUfmFXnO1zIrR7jvvrM7ROufZqLQ
         00Nttq7FknWWxWQpV/gF8bKLk9LWZYIKP/MqcMhWYCXlZ40FubdVB3roQGeJ9k54+Hvy
         l4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XJevRoZGKZ1/mVP15Q7uhNhNbWb2qp8w9iWHdcWf5B0=;
        b=ZTQlBXgYcuJ258/U0LzA60praYARMCz+Asz/NerSkadzcRPhZG6xrPPkd2Rjl2QUhv
         tG9JRIoRXoiPwFR4jdkqaOR7capMYlEQ2LphDs0oYG8Jv3lni8okQN5meUxXwo4e8wjI
         cyFbrpO//BWAS1zrA3i469dtjLqFuR2kgujtMjfbGfLQ8iQ3OjsDEZb8je8KW7p8VPWA
         sh71GbScrV6eaeeK2wqc1Q/DB02odff9Hs8FLfL3G1Uo7q5nkonkEa5YB0GhHYgiMeTd
         qxDyLB+IFgt/5/8jIkl3ab16N6OfFjNZQtaIujwieEFexhpQ0nAEt9dkdPxHvIe13Qrz
         ZLkQ==
X-Gm-Message-State: ABuFfoiTowaWWM2hXaJ8b0+rU6A5XfUCm+KG1iimBKYsgs2egcjJcJ0T
        noSvvur6P8FgaejetMDlHIo=
X-Google-Smtp-Source: ACcGV63xNnLPbNAEWcO6I7lFBhNtLc2UqNdsml0dnagepvxH6eKITvEGHxxnBDLmLYNHpWEvkT+B/Q==
X-Received: by 2002:adf:9b12:: with SMTP id b18-v6mr5696490wrc.35.1539356153259;
        Fri, 12 Oct 2018 07:55:53 -0700 (PDT)
Received: from localhost ([51.15.41.238])
        by smtp.gmail.com with ESMTPSA id t24-v6sm1322046wra.5.2018.10.12.07.55.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 07:55:51 -0700 (PDT)
Date:   Fri, 12 Oct 2018 15:55:50 +0100
From:   Stefan Hajnoczi <stefanha@gmail.com>
To:     piaojun <piaojun@huawei.com>
Cc:     pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        rusty@rustcorp.com.au, kvm@vger.kernel.org, penberg@kernel.org,
        mst@redhat.com, michaelc@cs.wisc.edu
Subject: Re: [PATCH] scsi/virio_scsi.c: do not call virtscsi_remove_vqs() in
 virtscsi_init() to avoid crash bug
Message-ID: <20181012145550.GK24267@stefanha-x1.localdomain>
References: <5B7E1AFA.8030506@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sU4rRG038CsJurvk"
Content-Disposition: inline
In-Reply-To: <5B7E1AFA.8030506@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sU4rRG038CsJurvk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 23, 2018 at 10:24:58AM +0800, piaojun wrote:
> If some error happened before find_vqs, error branch will goto
> virtscsi_remove_vqs to free vqs. Actually the vqs have not been allocated
> successfully, so this will cause wild-pointer-free problem. So
> virtscsi_remove_vqs could be deleted as no error will happen after
> find_vqs.
>=20
> Signed-off-by: Jun Piao <piaojun@huawei.com>
> ---
>  drivers/scsi/virtio_scsi.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index 1c72db9..da0fd74 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -833,8 +833,6 @@ static int virtscsi_init(struct virtio_device *vdev,
>  	kfree(names);
>  	kfree(callbacks);
>  	kfree(vqs);
> -	if (err)
> -		virtscsi_remove_vqs(vdev);

Can you provide more details about the problem?

drivers/virtio/virtio_pci_common.c:vp_del_vqs() looks fine to me, it
iterates over vdev->vqs.  The vdev->vqs list has been initialized in
drivers/virtio/virtio.c:register_virtio_device() and it's empty.

Stefan

--sU4rRG038CsJurvk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbwLX2AAoJEJykq7OBq3PIHPUH/R8uWZ/PQztf5OpFMjs/unVf
v+1840hOhxyCkb7otc+976KbDbDpc/RizlufgZyLoBsE+3mEjRFwg7A3wh9nYUwj
cXEO2Hu4uKO59N9/PLPRoDpLLwVE//24vtx7IfFjKjkcNrcnY+PNhJgD97FccPKT
bkU6IPRpUq63nQl8ZS0UcW9Ho6BCgaNePTIyGysLgviG32Ofkr1lEco4y3S9OsF7
AvqFJM1nQk+FxBaH7QmV1b7PLT7Rpq3DmvpKo5ay+HgLaY11cq+msP9p0YlpKQLI
A07Fo833XET9vu/IR18pwTSKHf1aZ/mfFHDKCyS6sLRX2mQ+mHWpubNkZko4FVc=
=6xR2
-----END PGP SIGNATURE-----

--sU4rRG038CsJurvk--
