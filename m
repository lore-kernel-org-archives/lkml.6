Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC08C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A3F217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dev-mellanox-co-il.20150623.gappssmtp.com header.i=@dev-mellanox-co-il.20150623.gappssmtp.com header.b="ZU31igy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfBFSCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:02:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53144 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbfBFSCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:02:34 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so3454173wml.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 10:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=QXTfHkeFrG0ex4wvMhI+j3yv4z1h9CI012ygXRer8OE=;
        b=ZU31igy1rYxPtd9veBDtLCPDar7NCvcvoT7nOR2PFJw+60elStCcMdh3T0vNYHCArs
         tqEPSg+woZg3g4vnfkRCnR3JhYgkTD9FKyCn1ksBfFwb2QuQkP60fOosISG+nDrWPiJM
         /1YnDQl0gP2zX1UyfK1SiuJ2HleHI/0XKi9qvAT1JwZAxmjTnIhJRwKO0qgUXwW9R16G
         ENVuF1FQM+KI6BkH3RuM926/GNhDTep5FeBXxDbygBYQ6bj7ppX4I11LaEGMM1YHkyZd
         EXh2vS6xyHZWtKsqvoW/10IP0EIVFdF/bU9unGmiRgUL4VawN3G1QKeg5W2phXhNQs8X
         cu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=QXTfHkeFrG0ex4wvMhI+j3yv4z1h9CI012ygXRer8OE=;
        b=VAVVg/f09Gi4KkjAdNdN1BCYAeAoda7IRW7RNMVs9VEFps5Fe3S9TRJ35XoJLfENRc
         RBPXp8eEfW3B9ujiOQvtBESFf8+VYY3aDSjOjQExIU5uLMEUZDPSVL4V4oPdzL2Rs4mx
         2Ag0Vf6a8JC+/fWEtN0BwviIfUJw+SF6ZP4WfYJqF0z/2dKdu/LYAPru7DqMveAQhKVv
         jQYbVahWJ0j2TipY5HMXbBbWv+ykWWuHnNMIRAjRV9Q8OE12wffHoqXnzgIbozu5K5fD
         VoOW72Raz+N6vsetisDhrh/RoPg4fluEWqUgTFLIYMQ+I26kDUBa7oTT92FFVti/vUd3
         3lAw==
X-Gm-Message-State: AHQUAuasASW8CWOJXRGEOv3NI0liVJqL8JqWdXAHtV5nnSNac65WmeFQ
        XplvAd18M4/tNvIqlAmnydOckQ==
X-Google-Smtp-Source: AHgI3IZTBTO1/K+G/v/3h6EK+iiQ1MmJ7+zaTEcGmjRZdoyZtKeib7Rx/2Bd/fixP2qejcyHdrBznA==
X-Received: by 2002:a1c:ed17:: with SMTP id l23mr4237612wmh.51.1549476153007;
        Wed, 06 Feb 2019 10:02:33 -0800 (PST)
Received: from localhost ([5.102.238.15])
        by smtp.gmail.com with ESMTPSA id z17sm17140910wrv.2.2019.02.06.10.02.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 10:02:32 -0800 (PST)
Date:   Wed, 6 Feb 2019 20:02:29 +0200
From:   jackm <jackm@dev.mellanox.co.il>
To:     =?ISO-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, netdev@vger.kernel.org,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mlx4_ib: Increase the timeout for CM cache
Message-ID: <20190206200229.00002e2f@dev.mellanox.co.il>
In-Reply-To: <FF460501-80BA-44B9-AD59-84F64A338D67@oracle.com>
References: <20190131170951.178676-1-haakon.bugge@oracle.com>
        <20190205223608.GA23110@ziepe.ca>
        <13750147-482A-4F90-976A-033C52DCF85E@oracle.com>
        <FF460501-80BA-44B9-AD59-84F64A338D67@oracle.com>
Organization: Mellanox
X-Mailer: Claws Mail 3.15.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2019 16:40:14 +0100
H=E5kon Bugge <haakon.bugge@oracle.com> wrote:

> Jack,
>=20
> A major contributor to the long processing time in the PF driver
> proxying QP1 packets is:
>=20
> create_pv_resources
>    -> ib_create_cq(ctx->ib_dev, mlx4_ib_tunnel_comp_handler, =20
>                                NULL, ctx, cq_size, 0);
>=20
> That is, comp_vector is zero.
>=20
> Due to commit 6ba1eb776461 ("IB/mlx4: Scatter CQs to different EQs"),
> the zero comp_vector has the intent of let the mlx4_core driver
> select the least used vector.
>=20
> But, in mlx4_ib_create_cq(), we have:
>=20
>         pr_info("eq_table: %p\n", dev->eq_table);
>         if (dev->eq_table) {
> 		vector =3D dev->eq_table[mlx4_choose_vector(dev->dev,
> vector, ibdev->num_comp_vectors)];
>         }
>=20
>         cq->vector =3D vector;
>=20
> and dev->eq_table is NULL, so all the CQs for the proxy QPs get
> comp_vector zero.
>=20
> I have to make some reservations, as this analysis is based on uek4,
> but I think the code here is equal upstream, but need to double check.
>=20
>=20
> Thxs, H=E5kon
>=20
Hi Hakon and Jason,
I was ill today (bad cold, took antihistamines all day, which knocked
me out).
I'll get to this tomorrow.

-Jack

