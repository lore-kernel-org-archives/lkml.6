Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E1FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CF020665
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="cldmgWYs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfAJWCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:02:42 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:38924 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfAJWCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:02:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jDR8KUP5+Zj5vYcKCaNQ6pY0LhxN+q4A4WL+sKibH9g=; b=cldmgWYs/PW6aMzP62KwIImVD
        WFjru/WF8EhC81ZXaSAGiJRAUPHfXa7n3SEkLILCl/I0DUsTJt2MBEL2gXM8w/tkNGwmPL6c+iPHw
        RbedRe7LjA3TReqzWBr5XgZJ10ful+ya7N5fCMM64WD5jEva/tzRcbLXaKjlvRUQqEOS8=;
Received: from p200300ccfbdcb9007ee9d3fffe1fa246.dip0.t-ipconnect.de ([2003:cc:fbdc:b900:7ee9:d3ff:fe1f:a246] helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1ghiPO-0005XO-Dx; Thu, 10 Jan 2019 23:02:38 +0100
Received: from [::1] (helo=localhost)
        by eeepc with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1ghiPN-0007MY-Dw; Thu, 10 Jan 2019 23:02:37 +0100
Date:   Thu, 10 Jan 2019 23:02:23 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Johan Hovold <johan@kernel.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH v2 2/5] gnss: sirf: power on logic for devices without
 wakeup signal
Message-ID: <20190110230223.18ecbd87@kemnade.info>
In-Reply-To: <20190110121038.GA9725@localhost>
References: <20181209195150.5192-1-andreas@kemnade.info>
        <20181209195150.5192-3-andreas@kemnade.info>
        <20190110121038.GA9725@localhost>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Z4bAl0SI8H2jq793e+XJap3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Z4bAl0SI8H2jq793e+XJap3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Thu, 10 Jan 2019 13:10:38 +0100
Johan Hovold <johan@kernel.org> wrote:

> Please change the commit summary to something more descriptive like
>=20
> 	gnss: sirf: add support for configurations without wakeup signal
>=20
> On Sun, Dec 09, 2018 at 08:51:47PM +0100, Andreas Kemnade wrote:
> > Some Wi2Wi devices do not have a wakeup output, so device state can
> > only be indirectly detected by looking whether there is communitcation
> > over the serial lines. =20
>=20
> > Additionally it checks for the initial state of the device during
> > probing to ensure it is off. =20
>=20
> Is this really needed? If so, it should probably go in a separate patch.
>=20
Well, it is the main motivation for the new try of upstreaming this again.
You know the loooong history...
It has several times messed up my power consumption statistics. As I try
to test patches on top of mainline, this has often led to false alarms
regarding pm bugs in other drivers.

We could also come from another kernel here via kexec having the device in
another state.=20

And why we do not want to check for uncommon things here? We e.g. do multip=
le tries
for changing power state.=20

> > Timeout values need to be increased, because the reaction on serial line
> > is slower and are in line  with previous patches by =20
>=20
> I don't think this is an accurate description, but more on that below.
>=20
I do not think so, but I do not have a too strong opinion here.

> > Neil Brown <neilb@suse.de> and  H. Nikolaus Schaller <hns@goldelico.com=
>.
> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> > Changes in v2:
> >  - style cleanup
> >  - do not keep serdev open just because runtime is active,
> >    only when needed (gnss device is opened or state is changed)
> >  - clearer timeout semantics
> >=20
> >  drivers/gnss/sirf.c | 114 +++++++++++++++++++++++++++++++++++++++++---=
--------
> >  1 file changed, 91 insertions(+), 23 deletions(-)
> >=20
> > diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
> > index ba663de1db49..c64369494afb 100644
> > --- a/drivers/gnss/sirf.c
> > +++ b/drivers/gnss/sirf.c
> > @@ -23,8 +23,13 @@
> > =20
> >  #define SIRF_BOOT_DELAY			500
> >  #define SIRF_ON_OFF_PULSE_TIME		100
> > +/* activate till reaction of wakeup pin */
> >  #define SIRF_ACTIVATE_TIMEOUT		200
> > +/* activate till reception of data */
> > +#define SIRF_ACTIVATE_TILL_OUTPUT_TIMEOUT	1000
> >  #define SIRF_HIBERNATE_TIMEOUT		200
> > +/* If no data arrives for this time, we expect the chip to be off. */
> > +#define SIRF_MIN_SILENCE	1000 =20
>=20
> You only need to add one new define for the no-wakeup case and it should
> reflect the report cycle (e.g. name it SIRF_NOWAKEUP_REPORT_CYCLE).
> Specifically, it is the time we must wait in order to infer that a
> device has failed to be activated, or succeeded to hibernate.
>=20
GPS chips will have usually some boot messages. So it is not the
"send nmea data set every X seconds" for the wakeup case, it is
another situation deserving IMHO another name.

> In pseudo code we have:
>=20
>   activate:
>    - toggle on-off
>    - wait(data-received, ACTIVATE_TIMEOUT + REPORT_CYCLE)
>      - reception: success=20

Note: we can also get the goodbye/shutdown message from the chip here
so there are chances of a false success, but since we initially power down,
we will rule out wrong state here.

>      - timeout: failure
>=20
>   hibernate:
>    - toggle on-off
>    - sleep(HIBERNATE_TIMEOUT)
we could also additionally check here for=20
   if (last_bytes_received =3D=3D GOODBYE_MSG)
or alternatively check for
   if (!BOOTUP_MSG_RECEIVED)
     - return success

>    - wait(data-received, REPORT_CYCLE)
>      - reception: failure
>      - timeout: success
>=20
> A problem with your implementation, is that you assume a report cycle
> of one second, but this need to be the case. Judging from a quick look
> at the sirf protocols (sirf nmea and sirf binary) report cycles can be
> configured to be as long as 30s (sirf binary) or even 255s (sirf nmea).
> [ To make things worse these numbers can be even higher in some
> low-power modes it seems. ]
>=20
As far as I see we will only might have a problem if=20
  - those settings are nonvolatile (or we come in with those
    settings on another way)
  - or a state change lateron fails which we cannot properly detect


> Adding just a one-second timeout (the minimum supported cycle length)
> seems way too low, even if whatever value we choose will be reflected
> directly in the time it takes to hibernate (suspend) the device.
>=20
> And since this is configurable at runtime, the only safe value would be
> the maximum one...
>=20
> Perhaps we can say that no-wakeup support depends on having reasonably
> short report cycles, but this needs to be documented.
>=20
Where should it be documented? Comment in code?
devicetree bindings?

So in general I see these possibilities:
1. just document tho problem with low cycle length requirement
   lateron we might improve the solution

2. do the data parsing like above just for the first or/and last bytes
   if these things really come reliable, we would catch the low-power
   corner cases like only data reports if you move around.
   I have to do some research here.

3. monitor serial output in off state and send a pulse if data arrives
  this would require the serial device to do aggressive power saving
  in that time(you send an example patch for that) or giving a gpio interru=
pt
  coming from the rx line to the gnss driver.
  Those things look like more restructuring work (or having a separate driv=
er
  which is not that practical for further extensions) and would not
  catch low-power modes

My personal opinion here
is
first 1.
later improve to 2. (and do some more tests in regards of 2.)

Just for the general things first.

Regards,
Andreas

--Sig_/Z4bAl0SI8H2jq793e+XJap3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlw3wPAACgkQfb1qx03i
kyShZhAAk94icWm87/LLaq2a43dTtw4TV/ladWPH4J0U2MlGFZrII4erCg56Ay0z
hrny7qIULCG84gS8fATV74UpZ8rakVhWSIZchhknAj69yiotqZGrcAYMwG9xxMbv
HBXdBi74jJt1fQ4Cy105fvouNOevOwhEGdCgdYHEVT0E+6PcIh5CWHB/Jjm9hQlW
AY/8btXdZmWfb+WGP8aupZAakmyStGDYuDgxBiqBD/ZBjF2cq5Efa+DOdi4W5jgD
QKmflMVH0v1FmsyuxubN1zxxxYnkHjiz4JxVPtfnAVlf+9aWBv0kF5fJ/437lzxF
LSHVEWNjr4KlMyJ2HI8To/aNq+Nk3H/RAQ0D1ql9bp1NZrnOFOWFNSnO6tvQ08Xj
StEYEZJQxEICp6s6BxElJ2Blb8ST1QSbZQ50FGGZT6JOqqEPYWFHPiKClKiRMPda
rI7n8wp3abtVnp182A3YcO9eF0iIzEpwfFf/k0W+fw1SDoAoE9aj/z53B9xS8IqS
JrS6mvsAPaUVy2QZAVgug+dx/dfMRSVHDxM/etk12uLt/MLaS2OCNR14Ci9kFv6z
QjYqezXCjGK3jlF3IMTVLXFdJYdqcqUiPeioNCmVwGSzLI3kdmkr++jiaZQISq0D
kjjmtjuGVwuXuderggBmCIfPfdOKh6rAwG6TOthVaWBwwwCBNkk=
=5cDC
-----END PGP SIGNATURE-----

--Sig_/Z4bAl0SI8H2jq793e+XJap3--
