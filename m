Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F7DC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE792075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIExhZYM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE792075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbeJLXTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:19:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37871 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729302AbeJLXTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:19:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id y11-v6so13934718wrd.4;
        Fri, 12 Oct 2018 08:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j3yC52M6I2Vmvn+RHlxHcnZkRqRLHKjwCM0LL96FKE0=;
        b=qIExhZYM4i0GdfetZSBetbVQ52moF7iWqAVO5V35+wvzl/KcO06q+y4DKykFF67p9N
         rO1/oVXdbOCEnjZe4J7vA1qjTlSKEdZVustrsdSohTkgMjs/D8ERahZ74ysydyLvf7fL
         Tlurde0kC2nEqyWqE6kCgZSkFTV+DarKSbW7sO1iQzSMJuxPWnt5DV5xNx8lWBV3doDq
         8Fu6PQeGtZClmWuIka3NF5gJEGgxDGuieqiTSGb0TzTTeC64iJeUce0Jtj7op4pa74hU
         qnlyUFjPJhtoZgLYLxISTY6x8tHcCqWrK/0U7fkpqaTVIkL3B43QRgSgb10rEoYcVOSq
         Tw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j3yC52M6I2Vmvn+RHlxHcnZkRqRLHKjwCM0LL96FKE0=;
        b=lGewYchptz6LfboS20n782nYHMi98qtBa9q2n/H9brGzegQw8NAAeSqEkfU2U9ilQa
         jdKYG/izKctlL71W0bcYg93LgF3YabxZ8MtzxgqSGGHJm8kmm7fxQPRbp3Ynwe7kTHNl
         ypU1yGgcUuE895857Svt354+LbwnKTPETyYz6UC2XZgRsJAD1oc3eOjlpELHCABpJ3FX
         deUGAWo+sps/jcoiIV4DY+k4YZLsv/OyyT04N9sDx4ACMcrvujn0FVgwhrZ1y7hQEL2m
         MdyIuWoe44X+i842r7AEklzC17sg/x+RufFKfqfJe4UAjRa8bmWLPwbJXci4kJxGz4y9
         Oqsg==
X-Gm-Message-State: ABuFfogg03ebOYoNPm5E3DGRS0cYEEuQ2KAgO0NYN5nG5fsz5qx98IdF
        Ibtk2Q/wnge9PulV4nJDOD8=
X-Google-Smtp-Source: ACcGV63I2MM8HDbb5QbivsCxB6xTHufBViUsVIzp0yvGSqmFyiOp4C2DqX0mnmdD3ANDxa6fsw1NZw==
X-Received: by 2002:adf:fdc2:: with SMTP id i2-v6mr6218906wrs.276.1539359206924;
        Fri, 12 Oct 2018 08:46:46 -0700 (PDT)
Received: from localhost ([51.15.41.238])
        by smtp.gmail.com with ESMTPSA id s7-v6sm9269852wmd.0.2018.10.12.08.46.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 08:46:45 -0700 (PDT)
Date:   Fri, 12 Oct 2018 16:46:44 +0100
From:   Stefan Hajnoczi <stefanha@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: Bad MAINTAINERS pattern in section 'VIRTIO AND VHOST VSOCK
 DRIVER'
Message-ID: <20181012154644.GM24267@stefanha-x1.localdomain>
References: <20180928220527.32038-1-joe@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ICrdrp3pM9DyZLTK"
Content-Disposition: inline
In-Reply-To: <20180928220527.32038-1-joe@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ICrdrp3pM9DyZLTK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 28, 2018 at 03:05:26PM -0700, Joe Perches wrote:
> Please fix this defect appropriately.
>=20
> linux-next MAINTAINERS section:
>=20
> 	15660	VIRTIO AND VHOST VSOCK DRIVER
> 	15661	M:	Stefan Hajnoczi <stefanha@redhat.com>
> 	15662	L:	kvm@vger.kernel.org
> 	15663	L:	virtualization@lists.linux-foundation.org
> 	15664	L:	netdev@vger.kernel.org
> 	15665	S:	Maintained
> 	15666	F:	include/linux/virtio_vsock.h
> 	15667	F:	include/uapi/linux/virtio_vsock.h
> 	15668	F:	include/uapi/linux/vsockmon.h
> 	15669	F:	include/uapi/linux/vm_sockets_diag.h
> 	15670	F:	net/vmw_vsock/diag.c
> 	15671	F:	net/vmw_vsock/af_vsock_tap.c
> 	15672	F:	net/vmw_vsock/virtio_transport_common.c
> 	15673	F:	net/vmw_vsock/virtio_transport.c
> 	15674	F:	drivers/net/vsockmon.c
> 	15675	F:	drivers/vhost/vsock.c
> -->	15676	F:	drivers/vhost/vsock.h

Hi Joe,
Thanks for pointing this out and sorry for the late response.  I have
sent a patch.

Stefan

--ICrdrp3pM9DyZLTK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbwMHkAAoJEJykq7OBq3PIdksIAKUz2BUlUnQ3YnlTgD2wZn0i
veEMPWYwfS3SlO16zUiW/gd+9iPXxtLK2her0WbpMrLWsNO151ha0YotNjV3RR3O
WImt57CO3RC9SA5B7J2KmsXwwgZZpRGvefcOe0PsaAU0SBIZ/m4aXScJJ3elNLSP
HguzrrdJFVA91kRnbq5kolpia05hr39LcrrBztEhFESdZrUdEtm63nlDlpJ+592O
KU163lV8YoWBI795p4NaABxvpExJe2K4Woytk9FnIUGWs+efN+TU2bO2UBnaw3ud
b8YfMpA+Oh+1PYY1gD8zwINxyzzhscXXZkThOBqlk3tWoFiQxE8AD0STARljg58=
=eJpJ
-----END PGP SIGNATURE-----

--ICrdrp3pM9DyZLTK--
