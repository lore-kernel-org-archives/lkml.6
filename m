Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6494C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 11:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717D52148E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 11:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mHn5xxjG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 717D52148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391328AbeHPOns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 10:43:48 -0400
Received: from ozlabs.org ([203.11.71.1]:40447 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730270AbeHPOns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 10:43:48 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41rkzd4BQjz9s4Z;
        Thu, 16 Aug 2018 21:45:33 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534419943;
        bh=Ho2vxPf3nmYYIKPfxs1B+dbALwve1vK9Az/gcptX5Ck=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mHn5xxjG5IzhkH1fdpL11LvtD0bffd11ooPgXVCSTX4GqDKuZdIt7/NtWJVnAUzKC
         HFJlY3VrBV4niLPfesVsj/+1ngeQTC2mFeaG3w7/Y0ZOuwsveNT4QOAF/dF/UT5HoG
         3CzyEXTKpgl+QDpS7DJsw+4MqjC3qtjxdGWurws74AxAVqLivnF68AZ1YOhe0AUd3G
         bCYOaKKe/5jUoyfq7JSwuq19spmSrw7ufs/X1aiBsWgIlFm4ASndJUvwat41FV5OO6
         83dW2gDL/4VmqbBCnXn5VhQFQ7i00xzh9BE2HHYXm89gSHGHOZwqoGYvcUmKa9sQf8
         H1RTdYEFoziVg==
Date:   Thu, 16 Aug 2018 21:44:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Kemi Wang <kemi.wang@intel.com>,
        David Rientjes <rientjes@google.com>,
        Jia He <jia.he@hxt-semitech.com>,
        Oscar Salvador <osalvador@suse.de>,
        Petr Tesarik <ptesarik@suse.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mathieu Malaterre <malat@debian.org>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Ross Zwisler <zwisler@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v1 1/5] mm/memory_hotplug: drop intermediate
 __offline_pages
Message-ID: <20180816214459.64a7cec3@canb.auug.org.au>
In-Reply-To: <20180816100628.26428-2-david@redhat.com>
References: <20180816100628.26428-1-david@redhat.com>
        <20180816100628.26428-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/NCvGZErSBmGvgFoB+bM4K8L"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NCvGZErSBmGvgFoB+bM4K8L
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Thu, 16 Aug 2018 12:06:24 +0200 David Hildenbrand <david@redhat.com> wro=
te:
>
> -static int __ref __offline_pages(unsigned long start_pfn,
> -		  unsigned long end_pfn)
> +/* Must be protected by mem_hotplug_begin() or a device_lock */
> +int offline_pages(unsigned long start_pfn, unsigned long nr_pages)

You lose the __ref marking.  Does this introduce warnings since
offline_pages() calls (at least) zone_pcp_update() which is marked
__meminit.

--=20
Cheers,
Stephen Rothwell

--Sig_/NCvGZErSBmGvgFoB+bM4K8L
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt1Y7sACgkQAVBC80lX
0GwD0Qf+IdwJnk7wIRcDbGn1AP6dqdsp2hpWrSr+qxhJbpz5F1d9SI1xYVt4NEqG
tOoWCPi57NIHRD4sQpJFaGKtzgczPMLXfmQiA54KBOkJGRcepvxIj6a6Kb5tzemu
d1Ix+NBiQ+ZJqfudhpq/AcrcOA0EZjNG4hlSmUGWwuwNe0PM6Hd2b+MDvrwNgNjz
BAEh0pTczP4d8JnB/r7TpzuiZ0cIo8dy0VIAsaVmC6Nc08TZ+xaT98U94ltX6wg0
eOlW2p0QPcskaeo0dsPmPB2dNI2RMkXf3hGL3hv3K8J5IDt6K4PUEFzrlMPHm+2A
+me39SLCp8ZfCqU0TdRUccD23BwZQA==
=wOyX
-----END PGP SIGNATURE-----

--Sig_/NCvGZErSBmGvgFoB+bM4K8L--
