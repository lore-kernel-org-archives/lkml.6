Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD37ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9FB2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pados.hu header.i=@pados.hu header.b="xYkD7GfR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D9FB2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=pados.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeINWKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:10:00 -0400
Received: from erza.pados.hu ([176.9.136.194]:50162 "EHLO erza.pados.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbeINWKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pados.hu;
         s=february2016; h=References:In-Reply-To:Cc:To:Subject:Message-ID:From:
        Content-Type:Date:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Wwl6pFCdxTf1wEmGHyMBYMxV9Iy+CNLLcjAgcj9yD1s=; b=xYkD7GfRlcaJBMdR+vhntutava
        4jf///+L0giAefpFYMjODJ30nG40jo4qCZpjYxygBBp3wREOU8e2/vgGXPu+WshsVDSU3BzJx7Wzl
        IAl2F+4Zx+f6KswrgIuHf2DhmrB77o0eQCKXpG9RGuZRLrSPeySynmJukWqQT/aA9URAKbk1uKRZE
        jxoWaYsELvy9z6rhupQHQe8jXxBbYa8Xv/niRyGNoEucpSzXb22iJE6nQCsZqTp5Yf5lK5LycN54q
        6nrHMhqLiy3oUqQPEBAX1eJKDWQQ1qgL3gqfdBA7CL7bj/6m81T6JPVcSYLPYGJSMcPnAQ1lsDH47
        W7dM6Umg==;
Received: from localhost ([127.0.0.1] helo=webmail.pados.hu)
        by erza with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <pados@pados.hu>)
        id 1g0rMa-0007ls-Sl; Fri, 14 Sep 2018 18:54:37 +0200
MIME-Version: 1.0
Date:   Fri, 14 Sep 2018 16:54:34 +0000
Content-Type: multipart/mixed;
 boundary="--=_RainLoop_446_230891182.1536944074"
X-Mailer: RainLoop/1.12.0
From:   "Karoly Pados" <pados@pados.hu>
Message-ID: <538e77cf9622664f3e9d79a90269cf7d@pados.hu>
Subject: Re: [PATCH v3] USB: serial: ftdi_sio: implement GPIO support for
 FT-X devices
To:     "Johan Hovold" <johan@kernel.org>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Loic Poulain" <loic.poulain@linaro.org>
In-Reply-To: <20180914161155.GB3443@localhost>
References: <20180914161155.GB3443@localhost>
 <20180910174322.1042-1-pados@pados.hu>
X-Spam_score: -2.9
X-Spam_report: Spam detection software, running on the system "erza",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  Hi, Thanks again for the review. >> #include <linux/usb/serial.h>
    >> +#if defined(CONFIG_GPIOLIB) >> +#include <linux/gpio/driver.h> >> +#endif
    > > Hmm. I already commented on this in v1. [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


----=_RainLoop_446_230891182.1536944074
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,=0A=0AThanks again for the review.=0A=0A>> #include <linux/usb/serial.=
h>=0A>> +#if defined(CONFIG_GPIOLIB)=0A>> +#include <linux/gpio/driver.h>=
=0A>> +#endif=0A> =0A> Hmm. I already commented on this in v1.=0A=0AYeah,=
 and I changed it too, but I now realized I misunderstood your intentions=
.=0AYou want me to remove the conditional compilation completely, while I=
 thought=0Ayou just prefer the #if defined() style instead of #ifdef. A m=
isunderstanding=0Aon my part.=0A=0A> =0A>> #include "ftdi_sio.h"=0A>> #in=
clude "ftdi_sio_ids.h"=0A>> =0A>> @@ -72,6 +75,14 @@ struct ftdi_private =
{=0A>> unsigned int latency; /* latency setting in use */=0A>> unsigned s=
hort max_packet_size;=0A>> struct mutex cfg_lock; /* Avoid mess by parall=
el calls of config ioctl() and change_speed() */=0A>> +#if defined(CONFIG=
_GPIOLIB)=0A>> + struct gpio_chip gc;=0A>> + bool gpio_registered; /* is =
the gpiochip in kernel registered */=0A>> + bool gpio_used; /* true if th=
e user requested a gpio */=0A>> + u8 gpio_altfunc; /* which pins are in g=
pio mode */=0A>> + u8 gpio_input; /* pin directions cache */=0A> =0A> And=
 I asked you to invert this one (i.e. replace with gpio_output).=0A=0ALat=
er when we discussed and you replied to my comments, I interpreted your r=
esponse=0Ait can stay this way. Another misunderstanding, sorry.=0A=0A>> =
+/* Returns the number of bytes read */=0A>> +static int ftdi_read_eeprom=
(struct usb_serial *serial,=0A>> + void *dst, /* must be kmalloc'd using =
GFP_KERNEL*/=0A> =0A> Whether GFP_KERNEL was used is not really relevant,=
 but highlighting=0A> that the buffer needs to be DMA-able is good.=0A> =
=0A>> + u16 addr, /* must be aligned to 16 bits */=0A>> + u16 nbytes) /* =
must be a multiple of 16 bits */=0A> =0A> I think checkpatch gets confuse=
d by you odd argument comments here. Use=0A> a kernel doc comment, if you=
 want to be this specific instead.=0A=0AI'll just remove the comments on =
the parameters of this function. The =0Asb_control_msg is a dead giveaway=
 the buffer must be DMA-able, and the=0Aerror checks at the start make th=
e requirements on the other parameters also=0Aobvious.=0A=0A>> +=0A>> + /=
* Chip-type guessing logic based on libftdi. */=0A>> + priv->gc.ngpio =3D=
 4; /* FT230X, FT231X */=0A>> + if (le16_to_cpu(serial->dev->descriptor.b=
cdDevice) !=3D 0x1000)=0A>> + priv->gc.ngpio =3D 1; /* FT234XD */=0A> =0A=
> No known way to identify FT234XD here?=0A> =0A> After taking a quick pe=
ek at libftdi, it seems we really have no clue=0A> how to detect these de=
vice types and 0x1000 could be for all FTX=0A> devices. Heck, the current=
 kernel driver just assumes anything we don't=0A> recognise to be an FTX,=
 something which would now hit this code path...=0A> =0A> What devices di=
d you and Loic have? Could you post the lsusb -v output=0A> for these? Pe=
rhaps someone with an FT234XD can chime in as well.=0A> =0A=0ANo clue abo=
ut this one. I only own FT230X and FT231X devices, but it looks=0Alike th=
ey cannot be told apart, except for eeprom strings which are reconfigurab=
le=0Aby the user. I wouldn't rely on such things. Anyway, lsusb -v output=
s attached.=0A=0AKaroly

----=_RainLoop_446_230891182.1536944074
Content-Type: application/octet-stream; name="ft230x"
Content-Disposition: attachment; filename="ft230x"
Content-Transfer-Encoding: base64

QnVzIDAwMSBEZXZpY2UgMDEyOiBJRCAwNDAzOjYwMTUgRnV0dXJlIFRlY2hub2xvZ3kgRGV2
aWNlcyBJbnRlcm5hdGlvbmFsLCBMdGQgQnJpZGdlKEkyQy9TUEkvVUFSVC9GSUZPKQpEZXZp
Y2UgRGVzY3JpcHRvcjoKICBiTGVuZ3RoICAgICAgICAgICAgICAgIDE4CiAgYkRlc2NyaXB0
b3JUeXBlICAgICAgICAgMQogIGJjZFVTQiAgICAgICAgICAgICAgIDIuMDAKICBiRGV2aWNl
Q2xhc3MgICAgICAgICAgICAwIAogIGJEZXZpY2VTdWJDbGFzcyAgICAgICAgIDAgCiAgYkRl
dmljZVByb3RvY29sICAgICAgICAgMCAKICBiTWF4UGFja2V0U2l6ZTAgICAgICAgICA4CiAg
aWRWZW5kb3IgICAgICAgICAgIDB4MDQwMyBGdXR1cmUgVGVjaG5vbG9neSBEZXZpY2VzIElu
dGVybmF0aW9uYWwsIEx0ZAogIGlkUHJvZHVjdCAgICAgICAgICAweDYwMTUgQnJpZGdlKEky
Qy9TUEkvVUFSVC9GSUZPKQogIGJjZERldmljZSAgICAgICAgICAgMTAuMDAKICBpTWFudWZh
Y3R1cmVyICAgICAgICAgICAxIEZUREkKICBpUHJvZHVjdCAgICAgICAgICAgICAgICAyIEZU
MjMwWCBCYXNpYyBVQVJUCiAgaVNlcmlhbCAgICAgICAgICAgICAgICAgMyBEQVowVzE1QQog
IGJOdW1Db25maWd1cmF0aW9ucyAgICAgIDEKICBDb25maWd1cmF0aW9uIERlc2NyaXB0b3I6
CiAgICBiTGVuZ3RoICAgICAgICAgICAgICAgICA5CiAgICBiRGVzY3JpcHRvclR5cGUgICAg
ICAgICAyCiAgICB3VG90YWxMZW5ndGggICAgICAgMHgwMDIwCiAgICBiTnVtSW50ZXJmYWNl
cyAgICAgICAgICAxCiAgICBiQ29uZmlndXJhdGlvblZhbHVlICAgICAxCiAgICBpQ29uZmln
dXJhdGlvbiAgICAgICAgICAwIAogICAgYm1BdHRyaWJ1dGVzICAgICAgICAgMHg4MAogICAg
ICAoQnVzIFBvd2VyZWQpCiAgICBNYXhQb3dlciAgICAgICAgICAgICAgNTAwbUEKICAgIElu
dGVyZmFjZSBEZXNjcmlwdG9yOgogICAgICBiTGVuZ3RoICAgICAgICAgICAgICAgICA5CiAg
ICAgIGJEZXNjcmlwdG9yVHlwZSAgICAgICAgIDQKICAgICAgYkludGVyZmFjZU51bWJlciAg
ICAgICAgMAogICAgICBiQWx0ZXJuYXRlU2V0dGluZyAgICAgICAwCiAgICAgIGJOdW1FbmRw
b2ludHMgICAgICAgICAgIDIKICAgICAgYkludGVyZmFjZUNsYXNzICAgICAgIDI1NSBWZW5k
b3IgU3BlY2lmaWMgQ2xhc3MKICAgICAgYkludGVyZmFjZVN1YkNsYXNzICAgIDI1NSBWZW5k
b3IgU3BlY2lmaWMgU3ViY2xhc3MKICAgICAgYkludGVyZmFjZVByb3RvY29sICAgIDI1NSBW
ZW5kb3IgU3BlY2lmaWMgUHJvdG9jb2wKICAgICAgaUludGVyZmFjZSAgICAgICAgICAgICAg
MiBGVDIzMFggQmFzaWMgVUFSVAogICAgICBFbmRwb2ludCBEZXNjcmlwdG9yOgogICAgICAg
IGJMZW5ndGggICAgICAgICAgICAgICAgIDcKICAgICAgICBiRGVzY3JpcHRvclR5cGUgICAg
ICAgICA1CiAgICAgICAgYkVuZHBvaW50QWRkcmVzcyAgICAgMHg4MSAgRVAgMSBJTgogICAg
ICAgIGJtQXR0cmlidXRlcyAgICAgICAgICAgIDIKICAgICAgICAgIFRyYW5zZmVyIFR5cGUg
ICAgICAgICAgICBCdWxrCiAgICAgICAgICBTeW5jaCBUeXBlICAgICAgICAgICAgICAgTm9u
ZQogICAgICAgICAgVXNhZ2UgVHlwZSAgICAgICAgICAgICAgIERhdGEKICAgICAgICB3TWF4
UGFja2V0U2l6ZSAgICAgMHgwMDQwICAxeCA2NCBieXRlcwogICAgICAgIGJJbnRlcnZhbCAg
ICAgICAgICAgICAgIDAKICAgICAgRW5kcG9pbnQgRGVzY3JpcHRvcjoKICAgICAgICBiTGVu
Z3RoICAgICAgICAgICAgICAgICA3CiAgICAgICAgYkRlc2NyaXB0b3JUeXBlICAgICAgICAg
NQogICAgICAgIGJFbmRwb2ludEFkZHJlc3MgICAgIDB4MDIgIEVQIDIgT1VUCiAgICAgICAg
Ym1BdHRyaWJ1dGVzICAgICAgICAgICAgMgogICAgICAgICAgVHJhbnNmZXIgVHlwZSAgICAg
ICAgICAgIEJ1bGsKICAgICAgICAgIFN5bmNoIFR5cGUgICAgICAgICAgICAgICBOb25lCiAg
ICAgICAgICBVc2FnZSBUeXBlICAgICAgICAgICAgICAgRGF0YQogICAgICAgIHdNYXhQYWNr
ZXRTaXplICAgICAweDAwNDAgIDF4IDY0IGJ5dGVzCiAgICAgICAgYkludGVydmFsICAgICAg
ICAgICAgICAgMApjYW4ndCBnZXQgZGV2aWNlIHF1YWxpZmllcjogUmVzb3VyY2UgdGVtcG9y
YXJpbHkgdW5hdmFpbGFibGUKY2FuJ3QgZ2V0IGRlYnVnIGRlc2NyaXB0b3I6IFJlc291cmNl
IHRlbXBvcmFyaWx5IHVuYXZhaWxhYmxlCkRldmljZSBTdGF0dXM6ICAgICAweDAwMDAKICAo
QnVzIFBvd2VyZWQpCg==

----=_RainLoop_446_230891182.1536944074
Content-Type: application/octet-stream; name="ft231x"
Content-Disposition: attachment; filename="ft231x"
Content-Transfer-Encoding: base64

QnVzIDAwMSBEZXZpY2UgMDA2OiBJRCAwNDAzOjYwMTUgRnV0dXJlIFRlY2hub2xvZ3kgRGV2
aWNlcyBJbnRlcm5hdGlvbmFsLCBMdGQgQnJpZGdlKEkyQy9TUEkvVUFSVC9GSUZPKQpEZXZp
Y2UgRGVzY3JpcHRvcjoKICBiTGVuZ3RoICAgICAgICAgICAgICAgIDE4CiAgYkRlc2NyaXB0
b3JUeXBlICAgICAgICAgMQogIGJjZFVTQiAgICAgICAgICAgICAgIDIuMDAKICBiRGV2aWNl
Q2xhc3MgICAgICAgICAgICAwIAogIGJEZXZpY2VTdWJDbGFzcyAgICAgICAgIDAgCiAgYkRl
dmljZVByb3RvY29sICAgICAgICAgMCAKICBiTWF4UGFja2V0U2l6ZTAgICAgICAgICA4CiAg
aWRWZW5kb3IgICAgICAgICAgIDB4MDQwMyBGdXR1cmUgVGVjaG5vbG9neSBEZXZpY2VzIElu
dGVybmF0aW9uYWwsIEx0ZAogIGlkUHJvZHVjdCAgICAgICAgICAweDYwMTUgQnJpZGdlKEky
Qy9TUEkvVUFSVC9GSUZPKQogIGJjZERldmljZSAgICAgICAgICAgMTAuMDAKICBpTWFudWZh
Y3R1cmVyICAgICAgICAgICAxIEZUREkKICBpUHJvZHVjdCAgICAgICAgICAgICAgICAyIExD
MjMxWAogIGlTZXJpYWwgICAgICAgICAgICAgICAgIDMgRlQzNzcwNjUKICBiTnVtQ29uZmln
dXJhdGlvbnMgICAgICAxCiAgQ29uZmlndXJhdGlvbiBEZXNjcmlwdG9yOgogICAgYkxlbmd0
aCAgICAgICAgICAgICAgICAgOQogICAgYkRlc2NyaXB0b3JUeXBlICAgICAgICAgMgogICAg
d1RvdGFsTGVuZ3RoICAgICAgIDB4MDAyMAogICAgYk51bUludGVyZmFjZXMgICAgICAgICAg
MQogICAgYkNvbmZpZ3VyYXRpb25WYWx1ZSAgICAgMQogICAgaUNvbmZpZ3VyYXRpb24gICAg
ICAgICAgMCAKICAgIGJtQXR0cmlidXRlcyAgICAgICAgIDB4ODAKICAgICAgKEJ1cyBQb3dl
cmVkKQogICAgTWF4UG93ZXIgICAgICAgICAgICAgICA5MG1BCiAgICBJbnRlcmZhY2UgRGVz
Y3JpcHRvcjoKICAgICAgYkxlbmd0aCAgICAgICAgICAgICAgICAgOQogICAgICBiRGVzY3Jp
cHRvclR5cGUgICAgICAgICA0CiAgICAgIGJJbnRlcmZhY2VOdW1iZXIgICAgICAgIDAKICAg
ICAgYkFsdGVybmF0ZVNldHRpbmcgICAgICAgMAogICAgICBiTnVtRW5kcG9pbnRzICAgICAg
ICAgICAyCiAgICAgIGJJbnRlcmZhY2VDbGFzcyAgICAgICAyNTUgVmVuZG9yIFNwZWNpZmlj
IENsYXNzCiAgICAgIGJJbnRlcmZhY2VTdWJDbGFzcyAgICAyNTUgVmVuZG9yIFNwZWNpZmlj
IFN1YmNsYXNzCiAgICAgIGJJbnRlcmZhY2VQcm90b2NvbCAgICAyNTUgVmVuZG9yIFNwZWNp
ZmljIFByb3RvY29sCiAgICAgIGlJbnRlcmZhY2UgICAgICAgICAgICAgIDIgTEMyMzFYCiAg
ICAgIEVuZHBvaW50IERlc2NyaXB0b3I6CiAgICAgICAgYkxlbmd0aCAgICAgICAgICAgICAg
ICAgNwogICAgICAgIGJEZXNjcmlwdG9yVHlwZSAgICAgICAgIDUKICAgICAgICBiRW5kcG9p
bnRBZGRyZXNzICAgICAweDgxICBFUCAxIElOCiAgICAgICAgYm1BdHRyaWJ1dGVzICAgICAg
ICAgICAgMgogICAgICAgICAgVHJhbnNmZXIgVHlwZSAgICAgICAgICAgIEJ1bGsKICAgICAg
ICAgIFN5bmNoIFR5cGUgICAgICAgICAgICAgICBOb25lCiAgICAgICAgICBVc2FnZSBUeXBl
ICAgICAgICAgICAgICAgRGF0YQogICAgICAgIHdNYXhQYWNrZXRTaXplICAgICAweDAwNDAg
IDF4IDY0IGJ5dGVzCiAgICAgICAgYkludGVydmFsICAgICAgICAgICAgICAgMAogICAgICBF
bmRwb2ludCBEZXNjcmlwdG9yOgogICAgICAgIGJMZW5ndGggICAgICAgICAgICAgICAgIDcK
ICAgICAgICBiRGVzY3JpcHRvclR5cGUgICAgICAgICA1CiAgICAgICAgYkVuZHBvaW50QWRk
cmVzcyAgICAgMHgwMiAgRVAgMiBPVVQKICAgICAgICBibUF0dHJpYnV0ZXMgICAgICAgICAg
ICAyCiAgICAgICAgICBUcmFuc2ZlciBUeXBlICAgICAgICAgICAgQnVsawogICAgICAgICAg
U3luY2ggVHlwZSAgICAgICAgICAgICAgIE5vbmUKICAgICAgICAgIFVzYWdlIFR5cGUgICAg
ICAgICAgICAgICBEYXRhCiAgICAgICAgd01heFBhY2tldFNpemUgICAgIDB4MDA0MCAgMXgg
NjQgYnl0ZXMKICAgICAgICBiSW50ZXJ2YWwgICAgICAgICAgICAgICAwCmNhbid0IGdldCBk
ZXZpY2UgcXVhbGlmaWVyOiBSZXNvdXJjZSB0ZW1wb3JhcmlseSB1bmF2YWlsYWJsZQpjYW4n
dCBnZXQgZGVidWcgZGVzY3JpcHRvcjogUmVzb3VyY2UgdGVtcG9yYXJpbHkgdW5hdmFpbGFi
bGUKRGV2aWNlIFN0YXR1czogICAgIDB4MDAwMAogIChCdXMgUG93ZXJlZCkK

----=_RainLoop_446_230891182.1536944074--
