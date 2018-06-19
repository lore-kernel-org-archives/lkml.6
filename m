Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B486C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AA720874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHmNs6t0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00AA720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965681AbeFSGPz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 02:15:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965628AbeFSGPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 02:15:51 -0400
Received: from localhost (unknown [5.29.173.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D04A20661;
        Tue, 19 Jun 2018 06:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529388951;
        bh=2rXwaeCoJtxv0wC5UH1amBJANT5ZUv5FmaKRz9zKIRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mHmNs6t06ztD7Q/rTyZ9fLtsvTNOO8JOIQZN60pW2w5tavxp2fpCbYFHRiQmX9sbj
         w9Udr2DS8TU8I43HeySNVqOsLb36cnXdcpGj875W/yb1Io6r32d9fOLWhxD+ugYTYn
         Ayz1XM+CqBPJu3z/N8PJp4edPe5OY/a893MNFVq8=
Date:   Tue, 19 Jun 2018 09:15:48 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, john.hubbard@gmail.com,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>, Jan Kara <jack@suse.cz>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 2/2] mm: set PG_dma_pinned on get_user_pages*()
Message-ID: <20180619061548.GC7557@mtr-leonro.mtl.com>
References: <20180617012510.20139-1-jhubbard@nvidia.com>
 <20180617012510.20139-3-jhubbard@nvidia.com>
 <CAPcyv4i=eky-QrPcLUEqjsASuRUrFEWqf79hWe0mU8xtz6Jk-w@mail.gmail.com>
 <20180617200432.krw36wrcwidb25cj@ziepe.ca>
 <CAPcyv4gayKk_zHDYAvntware12qMXWjnnL_FDJNUQsJS_zNfDw@mail.gmail.com>
 <20180618081113.GA16991@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
In-Reply-To: <20180618081113.GA16991@lst.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 18, 2018 at 10:11:13AM +0200, Christoph Hellwig wrote:
> On Sun, Jun 17, 2018 at 01:10:04PM -0700, Dan Williams wrote:
> > I believe kernel behavior regression is a primary concern as now
> > fallocate() and truncate() can randomly fail where they didn't before.
>
> Fail or block forever due to actions of other unprivileged users.
>
> That is a complete no-go.

They will fail "properly" with some error, which is better than current
situation where those unprivileged users can trigger oops.

Thanks

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbKJ+UAAoJEORje4g2clin69QP/jWFR8E7MKYfBqiosGF6OPVf
qxjEVTcaIMnnC6GrMykfAnOg7ApYKitetux5SV3+h+EChVTck2nQacbNKGC+kRJ1
bPKSM2qVPUSgcsfj5kDPXHslVZdhnuYp066rnGkc7CJEfnrMTpcexgOkCQW7iQb/
B+dpa2VaC5G14XoxVBpONweQ+NedTSX8lLemYazAsY6nm8uwVDAQqdk8bu2F0ayp
zoarTVCwYV7ENdv0rTkhLyPtB207GHoeCweSU/kj7mdj8Pbaf1CDzxIlOvY4djSC
Ia5fscHImRT29r8oIIlTI7JfLwsQaPye03o0AZ++qPhwmlGfspJy1dwYea0eMChl
CvgSigrS22txh367GZ70hn9lpHIAeuUP85RVVODN3tXokJS5cJNHT4n5lwdItcii
GDaXUzVx+a1Qio3J/mb/4MvLstCbE1Y4r2nYj2ag5gL1XuLPdqp8icYM6OEPQ2lf
B6z8OF6uQu0bzXj/m//Rep1bhwRnVjgrTVDzc67+hscq/BswhhAx04+COquTEXxv
TpHOraax/ZLN31lLQ/3QUIMKUZNvuhWVl2ARQJXtb8hmbPo+zQYkuP+ip8DmD5ny
wvtHqR04dCCwDEp1VmoPFe3PJy+zQvBHe18OyjyuarokNQNZCVAO0pNfivzibwFm
m1W/BwqX6Z3QRrQrQtYA
=LD7E
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
