Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031638AbeBNPlg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:41:36 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52986 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031500AbeBNPlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:41:35 -0500
X-Google-Smtp-Source: AH8x224O09FkC03KrBXGiNANR7jztNNmPLW8PC47oHyEYgg0jkjWchoD3K7A0a7yBlHhOaLyGttfPw==
Message-ID: <1518622889.23539.65.camel@redhat.com>
Subject: Re: [PATCH] ALSA: hda/realtek: Limit mic boost on T480
From: Benjamin Berg <bberg@redhat.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        linux-kernel@vger.kernel.org, Peter FP1 Zhang <zhangfp1@lenovo.com>
Date: Wed, 14 Feb 2018 16:41:29 +0100
In-Reply-To: <s5hr2pn6803.wl-tiwai@suse.de>
References: <20180214122939.10069-1-bberg@redhat.com>
         <s5hr2pn6803.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.4 (3.26.4-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Wed, 2018-02-14 at 14:00 +0100, Takashi Iwai wrote:
> On Wed, 14 Feb 2018 13:29:39 +0100,
> Benjamin Berg wrote:
> > 
> > The internal mic boost on the T480 is too high. Fix this by
> > applying the
> > ALC269_FIXUP_LIMIT_INT_MIC_BOOST fixup to the machine to limit the
> > gain.
> > 
> > Signed-off-by: Benjamin Berg <bberg@redhat.com>
> > Tested-by: Benjamin Berg <bberg@redhat.com>
> 
> Applying this quirk itself is OK, but just wonder whether this model
> has a docking station port.  Recently we fixed the dock issue, and it
> required to apply ALC298_FIXUP_TPT470_DOCK.

I assumed that on the T480 and similar models the audio on the dock is
connected through USB (the dock is USB-C + further pins), but I cannot
confirm this myself right now as I only have a T480 currently.

I have now contacted Peter Zhang of Lenovo about this and also to check
if other 80 series models may need the same fixup.

Benjamin

> 
> thanks,
> 
> Takashi
> 
> > ---
> >  sound/pci/hda/patch_realtek.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/sound/pci/hda/patch_realtek.c
> > b/sound/pci/hda/patch_realtek.c
> > index ce28f7ce64e6..8467ce3db767 100644
> > --- a/sound/pci/hda/patch_realtek.c
> > +++ b/sound/pci/hda/patch_realtek.c
> > @@ -6510,6 +6510,7 @@ static const struct snd_pci_quirk
> > alc269_fixup_tbl[] = {
> >  	SND_PCI_QUIRK(0x17aa, 0x224b, "Thinkpad",
> > ALC298_FIXUP_TPT470_DOCK),
> >  	SND_PCI_QUIRK(0x17aa, 0x224c, "Thinkpad",
> > ALC298_FIXUP_TPT470_DOCK),
> >  	SND_PCI_QUIRK(0x17aa, 0x224d, "Thinkpad",
> > ALC298_FIXUP_TPT470_DOCK),
> > +	SND_PCI_QUIRK(0x17aa, 0x225d, "Thinkpad T480",
> > ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
> >  	SND_PCI_QUIRK(0x17aa, 0x30bb, "ThinkCentre AIO",
> > ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
> >  	SND_PCI_QUIRK(0x17aa, 0x30e2, "ThinkCentre AIO",
> > ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
> >  	SND_PCI_QUIRK(0x17aa, 0x310c, "ThinkCentre Station",
> > ALC294_FIXUP_LENOVO_MIC_LOCATION),
> > -- 
> > 2.14.3
> > 
> > 
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEED2NO4vMS33W8E4AFq6ZWhpmFY3AFAlqEWKkACgkQq6ZWhpmF
Y3AEyQ/7B6l4Na1GLDf11P8OdzzcXOy6grjvrLYwq6WFA3M1DirlQsPwjSbnJ7V8
znIX30EK6My9Ip6jyvJQIpiBlaX1FKJuJ3So9mjgUeOcCQMFkwnC1fMMyyWEAWLq
TI1s7F5w4OQwhQpwtlId4AIB7A2ZzQmP/9YqfIPDtIiNJqjd9aRruBJi8A8j3sB5
slY1CYgCQhBUiAkUPisFrt+b4aFU5FlgINQR+6uOSKO0/IaSKq9rFwX76lOTOsBj
kHhywIF9Qef6CvUDaAOFWjQcTA/ooDPifUsfNzo6ZHnNZIks0Cov12JeO5UrxjiD
a3BuG6SZAVm4awfkTj5pIL0DuBAXYhTJd/hU3VMWdV0/kb0OeVONSahMzhSOCM30
WdFKpWC0+n3TEkTWSG9QGwL6wbXiaLNZ0JRgQkcoJ9JqPVngFf9LIRBzqdMyzyCE
UzLu/oQ9XlXQrFx1IG5KS/RJJPUwpJKhXOygSpRZx/HhmaWpPVLCu9GNg+ytoVIL
QEg381jOTTPi+DX0k07WYK+hUEvB83cbtsm+EiEGMa4bxuhYQp2p1moGqOrzv2XK
iEN8LfF97KJ4GtqVWybnstxMxMdS0CwXBPxUZ3OY6C03S3sdVqk/QrEpE4i0+N8P
CcX3g+rEJVUkpsdm17Sf5u4DjeGH7HBPsDmHirrwvFdeOkTiO4E=
=NIZ6
-----END PGP SIGNATURE-----
