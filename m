Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4E3C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 16:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E82B2086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 16:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547312386;
	bh=hulV5sPXet9pEokAbxnrMAD/RYPwyBi6bPx2wuN4cHY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Csx3UPOsmxmZiRY9OOu6Y+3MOQWICN+ZWHWDLektxbYb6CQwhKJPmPb7xpgn9/LEk
	 xjm6vQGZoW6ZIFOFvWsahk35gfbdoxUi6UuxyJMrk9LNOlx6z3ogMlKIGyR0Z4h5N5
	 gnTrY6JFybvrz0yWHRmNkFHYypjQPoMKqArrq/E0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfALQ7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 11:59:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:47802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbfALQ7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 11:59:45 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4E1E2084C;
        Sat, 12 Jan 2019 16:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547312383;
        bh=hulV5sPXet9pEokAbxnrMAD/RYPwyBi6bPx2wuN4cHY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ALT2ilrWFHjk4y00kGjSr0GUD4+Me3/Q3OOieM9nlobvyPsWFbiCFXMfLZrmQuRTr
         CKKhkMgYZ5+8Eov/c/usgbEf+7PToUlYhV8Zue9bqPgbwrDvkkxPd5f2qUbPJEKcIS
         mWMD2ahYp4bOW6umbNsHALZjmnn01OeOAPiUpQc0=
Date:   Sat, 12 Jan 2019 16:59:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     Matt Ranostay <matt.ranostay@konsulko.com>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: iio: ad7192: replaced bool in struct
Message-ID: <20190112165938.0a7baa50@archlinux>
In-Reply-To: <20190107175748.GA29220@himanshu-Vostro-3559>
References: <1545434786-15220-1-git-send-email-indigoomega021@gmail.com>
        <20181224095823.GA17061@himanshu-Vostro-3559>
        <8E720BF2-7AFC-4FFA-8FA2-5A403FD5DD1D@konsulko.com>
        <20190107175748.GA29220@himanshu-Vostro-3559>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2019 23:27:48 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> On Wed, Jan 02, 2019 at 01:25:27PM -0800, Matt Ranostay wrote:
> >  =20
> > > On Dec 24, 2018, at 01:58, Himanshu Jha <himanshujha199640@gmail.com>=
 wrote:
> > >  =20
> > >> On Fri, Dec 21, 2018 at 03:26:26PM -0800, Amir Mahdi Ghorbanian wrot=
e:
> > >> Replaced bool in struct with unsigned int bitfield to conserve space=
 and
> > >> more clearly define size of varibales =20
> >=20
> > Important thing to note is depending on padding, alignment, and positio=
n of field it probably won=E2=80=99t save any space. =20
>=20
> Well, then what do you say about the following results ;-)
>=20
> Before:
> ------
>=20
> himanshu@himanshu-Vostro-3559:~/gsoc/linux$ pahole -C ad7192_platform_dat=
a drivers/staging/iio/adc/ad7192.o
> struct ad7192_platform_data {
> 	u16                        vref_mv;              /*     0     2 */
> 	u8                         clock_source_sel;     /*     2     1 */
>=20
> 	/* XXX 1 byte hole, try to pack */
>=20
> 	u32                        ext_clk_hz;           /*     4     4 */
> 	bool                       refin2_en;            /*     8     1 */
> 	bool                       rej60_en;             /*     9     1 */
> 	bool                       sinc3_en;             /*    10     1 */
> 	bool                       chop_en;              /*    11     1 */
> 	bool                       buf_en;               /*    12     1 */
> 	bool                       unipolar_en;          /*    13     1 */
> 	bool                       burnout_curr_en;      /*    14     1 */
>=20
> 	/* size: 16, cachelines: 1, members: 10 */
> 	/* sum members: 14, holes: 1, sum holes: 1 */
> 	/* padding: 1 */
> 	/* last cacheline: 16 bytes */
> };
>=20
> After:
> -----
>=20
> himanshu@himanshu-Vostro-3559:~/gsoc/linux$ pahole -C ad7192_platform_dat=
a drivers/staging/iio/adc/ad7192.o
> struct ad7192_platform_data {
> 	u16                        vref_mv;              /*     0     2 */
> 	u8                         clock_source_sel;     /*     2     1 */
>=20
> 	/* XXX 1 byte hole, try to pack */
>=20
> 	u32                        ext_clk_hz;           /*     4     4 */
> 	unsigned int               refin2_en:1;          /*     8:31  4 */
> 	unsigned int               rej60_en:1;           /*     8:30  4 */
> 	unsigned int               sinc3_en:1;           /*     8:29  4 */
> 	unsigned int               chop_en:1;            /*     8:28  4 */
> 	unsigned int               buf_en:1;             /*     8:27  4 */
> 	unsigned int               unipolar_en:1;        /*     8:26  4 */
> 	unsigned int               burnout_curr_en:1;    /*     8:25  4 */
>=20
> 	/* size: 12, cachelines: 1, members: 10 */
> 	/* sum members: 11, holes: 1, sum holes: 1 */
> 	/* bit_padding: 25 bits */
> 	/* last cacheline: 12 bytes */
> };
>=20
> > Also for internal unpacked structures it really makes little sense to s=
ave a few bytes of data. Don=E2=80=99t read into that packed structures are=
 good.. they usually aren=E2=80=99t :) =20
>=20
> Yes, agreed, but I often see patches to save few bytes by marking
> array as static.
>=20
> There is some effort in this direction:
> https://lore.kernel.org/lkml/20181221235230.GC13168@ziepe.ca/
>=20
> Very likely to get more patches if the above patch gets merged.
>=20
The one additional thing that is relevant here is that we will probably
drop the whole structure anyway as part of moving it out of staging.
There might be some equivalent elements stored elsewhere, but quite
likely it won't be all of them.  As a result I'm not particularly keen
on patches to clean platform data up.

+ we really are dealing with trivial amounts of data here..

J
