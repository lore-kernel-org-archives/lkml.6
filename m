Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5945C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9172082C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TK9woC2w";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LzM1rES+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9172082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbeH3SnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:43:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51080 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbeH3SnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:43:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6A2D960388; Thu, 30 Aug 2018 14:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535640042;
        bh=gu5qe3RnPUWCsVYyYOgUi09FFa136wIbvQedHfU1rMY=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=TK9woC2w0gn9BNqua/XaNjzW508FPTOb2nflJDAjIGHTYc6m3iJv1TRLQW7oUukPv
         88gSPLQj8KZqNH6wc3htaw8asPo+i5kVz8RvGo97TQ2sf/s15cB/qmAK7JyswdYN2I
         j3ycWN0/gkeVTKxlwjCgd1EuHcaflcsriXxxM87Y=
Received: from WUFANW10 (c-71-205-14-210.hsd1.co.comcast.net [71.205.14.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wufan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EF024606DB;
        Thu, 30 Aug 2018 14:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535640041;
        bh=gu5qe3RnPUWCsVYyYOgUi09FFa136wIbvQedHfU1rMY=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=LzM1rES+j1qDGCcZHAotIseDRNPZ4jBC6F2Lyvti42xEWvF6E4eKIw1kHMoWcEmIM
         Go9RsoizKlL7mub9gA/ngn/gVNSyNmW8SiNKIHXKSsEBLg2Cwn5d5V17PpUN7r3Bte
         huqla3QX8VMGUXa8VelkDYdnTt4VJpHdHtF41qgI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EF024606DB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wufan@codeaurora.org
From:   "wufan" <wufan@codeaurora.org>
To:     "'James Morse'" <james.morse@arm.com>
Cc:     <mchehab@kernel.org>, <bp@alien8.de>, <baicar.tyler@gmail.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1535567632-18089-1-git-send-email-wufan@codeaurora.org> <c70fa799-bc9f-64c8-e151-088ca8c3ed3e@arm.com>
In-Reply-To: <c70fa799-bc9f-64c8-e151-088ca8c3ed3e@arm.com>
Subject: RE: [PATCH] EDAC, ghes: use CPER module handles to locate DIMMs
Date:   Thu, 30 Aug 2018 08:40:40 -0600
Message-ID: <000f01d4406f$6ce8f160$46bad420$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHcLsFbwflxxBzVeG17JegIRw3gmAF/6qNxpLx8bJA=
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

> > The current ghes_edac driver does not update per-dimm error counters
> > when reporting memory errors, because there is no =
platform-independent
> > way to find DIMMs based on the error information provided by =
firmware.
>=20
> I'd argue there is: its in the CPER records, we just didn't do =
anything useful
> with the information in the past!

Agreed. Will update the wording.=20
=20
> > +static int ghes_edac_dimm_index(u16 handle) {
> > +	struct mem_ctl_info *mci;
> > +	int i;
> > +
> > +	if (!ghes_pvt)
> > +		return -1;
>=20
> ghes_edac_report_mem_error() already checked this, as its the only =
caller
> there is no need to check it again.

Will remove.
=20
>=20
> > +	mci =3D ghes_pvt->mci;
> > +
> > +	if (!mci)
> > +		return -1;
>=20
> Can this happen? ghes_edac_report_mem_error() would have
> dereferenced this already!
>=20
> If you need the struct mem_ctl_info, you may as well pass it in as the =
only
> caller has it to hand.

Will remove.
>=20
> > +
> > +	for (i =3D 0; i < mci->tot_dimms; i++) {
> > +		if (mci->dimms[i]->smbios_handle =3D=3D handle)
> > +			return i;
> > +	}
> > +	return -1;
> > +}
> > +
> >  static void ghes_edac_dmidecode(const struct dmi_header *dh, void
> > *arg)  {
> >  	struct ghes_edac_dimm_fill *dimm_fill =3D arg; @@ -177,6 +197,8 @@
> > static void ghes_edac_dmidecode(const struct dmi_header *dh, void =
*arg)
> >  				entry->total_width, entry->data_width);
> >  		}
> >
> > +		dimm->smbios_handle =3D entry->handle;
>=20
> We aren't checking for duplicate handles, (e.g. they're all zero). I =
think this is
> fine as chances are firmware on those systems won't set
> CPER_MEM_VALID_MODULE_HANDLE. If it does, the handle it gives us is
> ambiguous, and we pick a dimm, instead of whine-ing about broken
> firmware tables.
>=20
> (I'm just drawing attention to it in case someone disagrees)

SBMIOS tables are typically automatically generated so chances for =
duplicate
handles are small.=20

>=20
> >  		dimm_fill->count++;
> >  	}
> >  }
> > @@ -327,12 +349,20 @@ void ghes_edac_report_mem_error(int sev,
> struct cper_sec_mem_err *mem_err)
> >  		p +=3D sprintf(p, "bit_pos:%d ", mem_err->bit_pos);
> >  	if (mem_err->validation_bits &
> CPER_MEM_VALID_MODULE_HANDLE) {
> >  		const char *bank =3D NULL, *device =3D NULL;
> > +		int index =3D -1;
> > +
> >  		dmi_memdev_name(mem_err->mem_dev_handle, &bank,
> &device);
>=20
> > +		p +=3D sprintf(p, "DIMM DMI handle: 0x%.4x ",
> > +			     mem_err->mem_dev_handle);
> >  		if (bank !=3D NULL && device !=3D NULL)
> >  			p +=3D sprintf(p, "DIMM location:%s %s ", bank, device);
> > -		else
> > -			p +=3D sprintf(p, "DIMM DMI handle: 0x%.4x ",
> > -				     mem_err->mem_dev_handle);
>=20
> Why do we now print the handle every time? The handle is pretty
> meaningless, it can only be used to find the location-strings, if we =
get those
> we print them instead.

For ghes_edac the bank/device is informational, and nothing would go =
wrong
if the bank/device numbers are the same as another entry. But the handle
is now critical for DIMM lookup, thus pull it out.

Thanks!
Fan

