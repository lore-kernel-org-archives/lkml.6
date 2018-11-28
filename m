Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB77C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE5B2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6t6RMlL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE5B2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbeK2ElI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:41:08 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:34677 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbeK2ElH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:41:07 -0500
Received: by mail-pl1-f170.google.com with SMTP id w4so705498plz.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 09:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PW/eRxyvSaK3B187MCh97URiQ9KAPjXSfKNetDYd1w4=;
        b=p6t6RMlLAJwp6DzX9FYWRqi3Unsh4/+7xJzAdpsuj4r5RIxM41prsm6ll7ad6+Nmgq
         pmQBMcd0oZ1S/ZYkS+jDoPPNV6V3RK/Zp7z4L64F+YbkbNPg7hQxNJciXwTSJiiRyfGa
         wjBVvNsSy3fCq0bb0avdDUkHWe3HTOTTOPo2rVFH1clq1KnLcY6a8i6iU6/WlFqDXVMJ
         O5QlHJtVAQspP8ZC7dZCKICZo0JhbL3ZlQojeJvzhwX+EStlevw82IQjrx5RcLevNikz
         EFHizfg0/kycheScVy8YkdqE7b3E4PHPuKWG9tdfNX+wHdWVQSOBl7Q+j7+7vEgaKwAI
         nvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=PW/eRxyvSaK3B187MCh97URiQ9KAPjXSfKNetDYd1w4=;
        b=GO2ktX1BgxWOBI+xaf8Y7A4WxUQPvomxSYY4qKyKjkj0z24wMd4aLMaGXpa0lvdxGc
         9QNZ4hLeJjcamCoXPmhgzEpy0OJo4I8UA/qPkAl800aOYsNfraGa65OcJIklw3soSlp3
         c6x9YSN/tp0i1jqy4RwT20bd4wzQZ7BmxV3twRYJzWpByj+DZJy2z8xRxo9ut7K4cqj+
         5usb9xMFGav9IApcj9rWNk8UfxzO5/nF6xNpnBzmEADvf/UIlcE5pM/kFU7bdHYimr9h
         zhL0IKvPC9ZSIn5ehcmaeLE+Uec8ORHgt9WS5oXHOwEm54mWkixw1RSfu6terE32l9E5
         5HXA==
X-Gm-Message-State: AA+aEWb65y8vWEpykYCT8KTdIT9w7VUXY0fBpfBPxqaMUVIotuTGB2nX
        EgJ2gRbg0fHwNsWyYXOjJPAEwGxXjMMuXA==
X-Google-Smtp-Source: AFSGD/WSblJc8jIzlvmaUZSFyU8VaKq2NDSDTWibgVw3irATzzN9yoEDR3+kzSVbBtHRCVOelD3Yww==
X-Received: by 2002:a17:902:82c2:: with SMTP id u2mr90756plz.110.1543426723342;
        Wed, 28 Nov 2018 09:38:43 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id m198sm8805345pga.10.2018.11.28.09.38.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 09:38:42 -0800 (PST)
Date:   Wed, 28 Nov 2018 07:38:40 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Srikanth Boddepalli <boddepalli.srikanth@gmail.com>
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH] xen: xlate_mmu: add missing header to fix 'W=1' warning
Message-ID: <20181128173840.wdulfu75d3mwdd2i@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        Srikanth Boddepalli <boddepalli.srikanth@gmail.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <1543328607-10546-1-git-send-email-boddepalli.srikanth@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ctfnzmxuhvk5aoiq"
Content-Disposition: inline
In-Reply-To: <1543328607-10546-1-git-send-email-boddepalli.srikanth@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ctfnzmxuhvk5aoiq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2018 at 07:53:27PM +0530, Srikanth Boddepalli wrote:
> Add a missing header otherwise compiler warns about missed prototype:
>=20
> drivers/xen/xlate_mmu.c:183:5: warning: no previous prototype for 'xen_xl=
ate_unmap_gfn_range?' [-Wmissing-prototypes]
>   int xen_xlate_unmap_gfn_range(struct vm_area_struct *vma,
>       ^~~~~~~~~~~~~~~~~~~~~~~~~

Reviewed-by: Joey Pabalinas <joeypabalinas@gmail.com>

--=20
Cheers,
Joey Pabalinas

--ctfnzmxuhvk5aoiq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlv+0p8ACgkQ2rGdfm9D
tVIzGRAAm1uz+/E+KPd+YrX2tYdQn1FmmnwD1cOGubXDLjs1g/ongTN7MzEFgjta
GukfJQN/94bdqTwOmKQCouwk+s8AMa8wrUbVPYUKb4kwglnJon46msXrfvNjzIwm
/jpwWePXP6h+HGem90zaxAXI626bojLMI1PcyMrBockXs/qY8bj/8Y5HCfwbRgWI
6xaWmr/oMoaWaFDl2IcsfpiMEvOuAub9XRzVLJmG5n574dRaLDwEf3ozDEE+da+a
Rk6Ti+6Hy6RFz22LjwU2xrEP5yrnHl6rnNFX1/4XdDEcwuFPaDaNjrCmduWMVqjJ
+D6TjETS+IUrO/E9w3YcqpsCot/z05BODx8OI2d0PFlArK2MTXnG27NyrVkmCL8L
5F5ypIPocgG/2fWhPq7u8ImbxVocvZXoaIKzNoRf2HK80WlTbYpVdgXB/dljZAee
kNVnEh+5nXhp8+4F0ked7z32Tskqwe6CfOkdNYsv0UfnmlMHLdCYvcYynMtYdxIi
5lw8+qZA4h4Mzx+NmuE/gPHqEdDL2zm0CY3JnF1lncTtQunFvHOo6OPPixuFuON8
V83LoB+0PVVrM5FEWrMcL5YSl5Sa6nZcah/v2MZpRav1Rc9OoJpS2iaGDwAGnJD1
tzjtLM4peKZNjU1M2R0X3CrTZf8x/Ulpds9HiyAap3PU3xZNq0c=
=WeLl
-----END PGP SIGNATURE-----

--ctfnzmxuhvk5aoiq--
