Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204D3C46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B2320870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B2320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeG3JEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:04:13 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:47481 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbeG3JEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:04:13 -0400
X-Originating-IP: 2.224.242.101
Received: from w540 (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 0E8DAC0004;
        Mon, 30 Jul 2018 07:30:31 +0000 (UTC)
Date:   Mon, 30 Jul 2018 09:30:30 +0200
From:   jacopo mondi <jacopo@jmondi.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: Re: linux-next: build warning after merge of the pm tree
Message-ID: <20180730073030.GD7615@w540>
References: <20180730120053.62732d27@canb.auug.org.au>
 <20180730072445.kt2yxxifx4i7y3fr@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="//IivP0gvsAy3Can"
Content-Disposition: inline
In-Reply-To: <20180730072445.kt2yxxifx4i7y3fr@paasikivi.fi.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--//IivP0gvsAy3Can
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

On Mon, Jul 30, 2018 at 10:24:45AM +0300, Sakari Ailus wrote:
> Hi folks,
>
> On Mon, Jul 30, 2018 at 12:00:53PM +1000, Stephen Rothwell wrote:
> > Hi Rafael,
> >
> > After merging the pm tree, today's linux-next build (x86_64 allmodconfig)
> > produced this warning:
> >
> > drivers/media/i2c/mt9v111.c: In function 'mt9v111_set_format':
> > drivers/media/i2c/mt9v111.c:887:15: warning: 'idx' may be used uninitialized in this function [-Wmaybe-uninitialized]
> >   unsigned int idx;
> >                ^~~
> >
> > Introduced by commit
> >
> >   aab7ed1c3927 ("media: i2c: Add driver for Aptina MT9V111")
> >
> > Looks like a false positive, but not something that gcc can easily see.
>
> This must be coming from a new driver merged to media tree recently. Thanks
> for reporting this.
>

Yes, my bad, it is a false positive and I ignored it,
sorry about that. There is already a patch sent to linux-media to fix
this on top of the driver.

https://patchwork.kernel.org/patch/10547983/

Thanks
   j

> --
> Regards,
>
> Sakari Ailus
> sakari.ailus@linux.intel.com

--//IivP0gvsAy3Can
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJbXr6OAAoJEHI0Bo8WoVY8IDsP/3hFbCH3LzcrhijYeA+kEfiG
U/N6VKDxz+TK2Oq7U5TItpEFTqpWFyDBRpM2Wrd+9WWw1VZOWKQwc1X1xz77TtQX
P25K+BQbxlkSASNpkSq4z8Gmxae6KueFDpYyg87Blc2NUvfUFv2QfTK/n4YZwavV
eSv18h7vhPqApImHnhDhPssGkWMhKHA9dufqwGCEalCvfnHK7oy/tQLmo+9RqFEm
eNqUztBmpDEomGMrYwWEZqNioDuNPHX+O2h9/VSUE+pOQA+zWkhVwQBFKChVTsFd
5tpKv3l3gq21Az0bnkFbJHTrz/RRRsdillnx4Re181rhezj9JMld9VizZDFqeIt1
y6+XL89JGNiHJdWj3NzQY19bkIo1gRCXy1xOD8j8fJicqgXHAFsLJBtH3kI1M5tw
3NYnZV8Gv+2/9jN3ZuLvi3EtacdJmLR3+zHADgZV9HxXxTZiFOpam27iXZ9qBUuC
Vxkl+e3AA+HAvD1c8ZuAC/Xgmw31ep+hpP3OUaNNSV3yK9JWc/2akoI+YHBtNMnI
B7nlwHXt4YmWksEj2I3Sbt6AOG6qglXiCzCi5PKUmT/kiVDZbhWabs44iaL8T0Xy
KyHApSMtmgaJJGrNukX2kQbNVHCdbYls6NDg4tpWDsrKs3vF5rXYQKSnZTuBcOC0
K0i9cD7fzfZkm1iWhp5e
=NsrG
-----END PGP SIGNATURE-----

--//IivP0gvsAy3Can--
