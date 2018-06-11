Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id NVwBBy76HVv0OgAAmS7hNA
	; Mon, 11 Jun 2018 04:34:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B0D5760792; Mon, 11 Jun 2018 04:34:33 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W770NeD6"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 365EC601D2;
	Mon, 11 Jun 2018 04:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 365EC601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932311AbeFKEea (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 00:34:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753736AbeFKEe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 00:34:29 -0400
Received: from localhost (unknown [5.29.173.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C1202087E;
        Mon, 11 Jun 2018 04:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528691668;
        bh=c7B3k/s09DDBUC3zbvKJqiVeHAG7jK6poExxvAei3hc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W770NeD6TFOl2Bdn5SQful9SGwNC80Hjg+45muzw1u8M8r1AJC1gvs5TmtEgbwF+I
         euxg4zb2bwn4IqZUG7Ak9QC+Di5AS15DnOmotKpvqxP15tisbe1VqDf+U6NWHHoFUm
         qlVpE/YhSSORPT2/LDR3hv+/v6tubUQ98HHOCaTc=
Date: Mon, 11 Jun 2018 07:34:25 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: Matthew Wilcox <willy@infradead.org>, hans.westgaard.ry@oracle.com,
        Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        linux-rdma@vger.kernel.org,
        =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
        Parav Pandit <parav@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] IB/mad: Use IDR for agent IDs
Message-ID: <20180611043425.GA21382@mtr-leonro.mtl.com>
References: <20180608174218.32455-1-willy@infradead.org>
 <20180608174218.32455-3-willy@infradead.org>
 <20180610063028.GH12407@mtr-leonro.mtl.com>
 <20180610104305.GA9284@bombadil.infradead.org>
 <20180610122505.GM12407@mtr-leonro.mtl.com>
 <20180610203027.GF5560@mellanox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <20180610203027.GF5560@mellanox.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 10, 2018 at 02:30:27PM -0600, Jason Gunthorpe wrote:
> On Sun, Jun 10, 2018 at 03:25:05PM +0300, Leon Romanovsky wrote:
> > On Sun, Jun 10, 2018 at 03:43:05AM -0700, Matthew Wilcox wrote:
> > > On Sun, Jun 10, 2018 at 09:30:28AM +0300, Leon Romanovsky wrote:
> > > > 1. IBTA spec doesn't talk at all about the size of TransactionID, more
> > > > on that in section "13.4.6.4 TRANSACTION ID USAGE", the specification
> > > > says: "The contents of the TransactionID (TID) field are implementation-
> > > > dependent. So let's don't call it mlx4 bug.
> > >
> > > I was loosely paraphrasing the original bug report; suggested rewording
> > > of the comments gratefully accepted.
> >
> > Just replace "mlx4 bug" with something like "to comply with mlx4
> > implementation".
>
> Well, it is a bug. Blindly replacing the upper 8 bits of the TID in a
> driver without accommodation from the core is totally, bonkers wrong.

I provided cite from spec that says that TID can be whatever you want as
long as you success to do it unique.

>
> The original concept was that the 1<<24 limit would come from the
> driver and only mlx4 would have less than 1<<32, because only mlx4
> does this thing..
>
> Thanks Matt,
> Jason
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbHfvRAAoJEORje4g2clink8EQAMv8h8rJtH/TZ5k8S1PM3SR7
SY1qRYNfEmigAWjwP2PwJu6Um314Azrap93axOdAIVkPFfErfQdbg3vAAVq+RN3n
FgshwxAzoqUAlfDWN0O///rNFg2f4t2ynrzuw4v43JowjwaUq3MPJzt/4EiZx4SN
nGiTUmtAa+aHcxTLo7/j55+ACRF1CfcADGDeDJ7F5LI6FBqqztduqtydpbS5QxgP
eraDcrpm2NP1fNlflnY+Xc05tAUJGKOWc0f9qrM6/evA6o6zmVMN5pnmTgyS8diG
yo8HuKzjDnCGEAAuS8kapS7zJMvshMsgHZWqeh7wvjkot9736RfdnCrbsnp31/aO
E3mSPtMW5AkKrLD+ZOOd0Qk2YE0oO6HirRHwYmdI0108V4pon9V18gIn7NmWa/AB
MfCwz5CjL1K7dE0/FNso/GIMSN3VPc3k654P3IH9ZbZZIPv7yLOhwvMiqu0NPC2Z
/SMzInu+FXdAZy8Kf0p+fc6FTjGStUpBasuPJj8lsLfIW14hA0sMWFT37boS9OCt
ipWvsqtmd7TcXoHb5Mgk68jmZ6tZ+m2+oSNsh2bqum1AxCOFNVOPisQFNRvMJ42I
rPNBiDHH9six4p6X5k7wxP79dTPA9EoAzsmtVIllRV+D2WP1ejdM99QOVVtgIxKu
WMCaFGuhsHjoiQ8CRZUR
=l0ox
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
