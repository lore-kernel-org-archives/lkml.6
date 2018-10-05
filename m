Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F8BC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 05:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D4B2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 05:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GjoDU+AR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D4B2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeJEMgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 08:36:14 -0400
Received: from ozlabs.org ([203.11.71.1]:53663 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727179AbeJEMgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 08:36:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42RJTk04XNz9s7W;
        Fri,  5 Oct 2018 15:39:05 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538717946;
        bh=QaKSWpYakEq13gVuchNEHyCjc8ncUz6QWuuEEakN+XQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GjoDU+ARHcwQOp73zFBZyQtlRTK22xPZ7gNXRKFPjie9e/1qJJbm5+KuQY9depLZd
         9UKewC/L/r2WjH9ZIGqY9/CQpfoCy5uod2WicswTckrU5623uDGvlxDY8ZlZkxxLDE
         VRqXBN/p/iH6Dw7ClPceQbQeKLdlv9o3rxFk62tV5JZwgAD16ffvFpCFlV9EGhZWnE
         3cNZjRuNTZvsTb0DH0zj9t4t7+DYg90MYG2z6nRxDZhPva4cm1NUpUVcAelJDW8QFT
         vJSYCPFBNXilSe3MAhYziH4Fbsu73xb8vMOLZbrAIQTnuVCGXys0WT1gNWcp6wwcrj
         ALwfkVYPhc56w==
Date:   Fri, 5 Oct 2018 15:39:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux-Next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus PPC <linuxppc-dev@lists.ozlabs.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: Tree for Oct 4
Message-ID: <20181005153905.126a005e@canb.auug.org.au>
In-Reply-To: <01c4a73c-7901-2fbb-8f87-95ff21dc5126@roeck-us.net>
References: <20181004183449.36bcc93b@canb.auug.org.au>
        <20181004134644.GA9130@roeck-us.net>
        <CAMuHMdXfhbFi8HYtqd6BeACyG64_eQvoiSQ7DMpyOmdXEXPymg@mail.gmail.com>
        <20181005094445.4d0b68bc@canb.auug.org.au>
        <01c4a73c-7901-2fbb-8f87-95ff21dc5126@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/WI7YS39RX_FlyJjOQWG/6Eg"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WI7YS39RX_FlyJjOQWG/6Eg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Thu, 4 Oct 2018 18:33:02 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
>
> Most of the boot failures are hopefully fixed with
> https://lore.kernel.org/patchwork/patch/995254/

I have added that commit to linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/WI7YS39RX_FlyJjOQWG/6Eg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu2+PkACgkQAVBC80lX
0GxQzAgApaFroQMOF/b1oY8XdG0dDLNLqqOUPOKS294M4YJFl+hqZzB7UYdIYX1Y
PMZG8dwYDTQZuwvs3RVTsazCV3tWCvNgjk1VhvkUITwHQMmecDauMXwMr+chePgs
lsjwmnU+e6KojE7M4XdEFKeVhLxdK0LKmeBF6Nv5hYFvverfxl4ABRz4u7m1nxhg
ra4lUBWYjk7j/vbcKkMDU5PHhEZgfa/CQmDmR1idbv4Ceb1Z/EOo+G9v+fkgRZDk
PRH5B57R5x4ibDKbzWXwwtF2fbC1RYmGtkjioOTRQBk9avjxcpOgjn98oCNlHCUG
gd95XlVy2O22aLaUrl300VeJ/d7mpA==
=S9O9
-----END PGP SIGNATURE-----

--Sig_/WI7YS39RX_FlyJjOQWG/6Eg--
