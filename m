Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0572C43444
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 17:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77EAE20872
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 17:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547315527;
	bh=TnMhz+UqgUAfFY6OLg+QUEnCJtRgLzYWTLzSaOiksRM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Yt7k8hu/jATzR1FIHbdLxlsAXRFJwvX3AREevn0wO1+0ZR/odAjUaJv37c5mh4XE+
	 RmHnd3m9JhWjMcEBS5/+nP4kL43qCMPNnF0PHvb/wh4QbufZxdAe+T4UD73t9sJfKp
	 BiVX73E3Q2sViL01iT+ALmj7zlJmF62V4bYMMuDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbfALRwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 12:52:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:48322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbfALRwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 12:52:06 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05F352084C;
        Sat, 12 Jan 2019 17:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547315525;
        bh=TnMhz+UqgUAfFY6OLg+QUEnCJtRgLzYWTLzSaOiksRM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j7CBm2maHqmDQP6zImqWDL0wQ0wOCcpmA7fNwFSiX58bhAq23sNUQaRCBoXrwTxKw
         FwIxeNEyRdq7dWAJzoTk1mYkwNi8mnX6A6wYyqFMoHnum3Uovg4cMlYCDERvzMXmf/
         acQEJbEctDhbde95xgQ2jlBir8kdoOfHixn80heA=
Date:   Sat, 12 Jan 2019 17:51:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: New IIO/counter driver
Message-ID: <20190112175159.3dac7a70@archlinux>
In-Reply-To: <8b2bb569-a6e0-25ec-740d-48083b30fe60@st.com>
References: <CAKKE0ZHmODzhvjPNJFVgT2cF_F=f2kNKr5K_CGP+0XgA5XZokw@mail.gmail.com>
        <20190108004632.GA3247@icarus>
        <CA+M3ks7wX6MxvapDi_5SQ0rkJWoV+BcmzmbvtiqHVBzrrwAp4g@mail.gmail.com>
        <8b2bb569-a6e0-25ec-740d-48083b30fe60@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2019 12:01:57 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> On 1/8/19 11:57 AM, Benjamin Gaignard wrote:
> > Le mar. 8 janv. 2019 =C3=A0 01:46, William Breathitt Gray
> > <vilhelm.gray@gmail.com> a =C3=A9crit : =20
> >>
> >> On Mon, Jan 07, 2019 at 02:45:37PM +0100, Patrick Havelange wrote: =20
> >>> Hello,
> >>>
> >>> I'm in the process of adding a new IIO/counter driver, however I also=
 saw
> >>> that there was a work in progress to have a separate counter subsyste=
m (
> >>> https://marc.info/?l=3Dlinux-iio&m=3D153974167727206 ). But it seems =
there is
> >>> no recent progress on it.
> >>> What is the state of those patches ? Is it still interesting to devel=
op the
> >>> driver as an IIO/counter , or should I use already that new subsystem=
 ?
> >>>
> >>> Best Regards,
> >>>
> >>> Patrick Havelange. =20
> >>
> >> Hello,
> >>
> >> I am still open to merging this patchset and maintaining the Counter
> >> subsystem. However, I took the lack of response for my latest
> >> submission to indicate a loss of interest in this patchset's approach.
> >> If there are still people who want this, I can rebase and resend this
> >> patchset for submission; the past few versions have primarily been code
> >> clarity and documentation changes so I believe the core design itself =
is
> >> somewhat stable now.
> >>
> >> Just let me know how best to proceed and I shall be happy to oblige --
> >> whether to continue maintaining this patchset or to drop this design in
> >> favor of improving the existing IIO Counter code in the kernel.
> >>
> >> I'll CC those from the patchset submission to keep them in the loop. =
=20
> >=20
> > I confirm that I still interested to get those patches merged.
> >=20
> > Regards,
> > Benjamin =20
> Hi,
>=20
> Same for me,
In a more abstract fashion (I don't have any hardware of this type!)
I'm still keen for the counter subsystem to go in.  Hopefully, if
Greg or anyone else wants to take a detailed look they will have time
this cycle to do so.

I was pretty happy with the last version I read through.  There will
always be things to improved, but as long a we are happy with
the userspace inteface, the little things can happen later.

Jonathan

>=20
> Regards,
> Fabrice
> >>
> >> Sincerely,
> >>
> >> William Breathitt Gray
> >>
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel =20
> >=20
> >=20
> >  =20

