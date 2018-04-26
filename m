Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524759155; cv=none;
        d=google.com; s=arc-20160816;
        b=GErp7iyxSEd+JXovM1E9JGIORu9tRK/ncV8+3qNRLGeBP15E8fbNSRrMamrEondpl9
         /Yj5bzulEk80JdNuhaObIWPLEwrxNg0Rirvt4gFnGNXB8UXC9WPlertdskpAsCBFg3eR
         KU8Qxg+/iNDGFTYzg0KJhGyiVBgdPZAbozc3a9IzsIAMmmYZzoF3aEoTMc+IaOGJNcP3
         4pCjYbBw/4I1uyllgI5tx/4jJRh/7ZC4Oa/ewCdcsK0lwtBWeVYYpdZ8W+JRYC9F8VZE
         NE+I6TiMbknkYIKlfXU4IG6gn40WunlL05PX4ISgET03djIXsqWB1Km12G1NTyloJRJ3
         9Tqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:sender:dkim-signature:arc-authentication-results;
        bh=7GGmbaRlNs6UqZvFQ89wDQn5dVJFAFGRRgO0We1MDKI=;
        b=Vzua6xGWa8aOJMbrVdojkNo2Rtk+5KqXaEQaalf0NYbZIJU+vhhhehvJfe9e6PdvEH
         GYOkoW9RuOIgzrRV59aU6EsMG6vrRGF/frIc3W6kiDncztnMa0ilSGddjCoWGs/Iv85E
         Am4+KmUolmBpds3WPj3W1QgltNOfgBRQMh2dhRAxovLc0CBj2E+SKg4Vn4sKGF4f2wM+
         w/YHw7nBrOst6sxlPekzd3TcMGyYfv1JZeZZ6tuOGFuRb6yLB2DKIXshvYSWdf5zfMII
         tl+fFJ1EIIlGp5rf6bkn3wuNs6ieojD4el4TPoKq3x7oqNiUWSos/J3aH7KlJvmUAoXU
         WC9w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Hh9VaxnG;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Hh9VaxnG;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com
X-Google-Smtp-Source: AB8JxZr/svOPtjUA/Pw6/mVLmBj9gEIhpml5XUf2aZn4OczdaMJjRA2ihJ5/c0annR4eEltRhILmkQ==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Thu, 26 Apr 2018 18:12:28 +0200
From: Johan Hovold <johan@kernel.org>
To: Lars Melin <larsm17@gmail.com>
Cc: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	Johan Hovold <johan@kernel.org>,
	SZ Lin =?utf-8?B?KOael+S4iuaZuik=?= <sz.lin@moxa.com>,
	stable <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dan Williams <dcbw@redhat.com>
Subject: Re: [PATCH] USB: serial: option: adding support for ublox R410M
Message-ID: <20180426161228.GW4615@localhost>
References: <20180426062831.320-1-sz.lin@moxa.com>
 <20180426070927.GT4615@localhost>
 <72c63853-aa2d-e74c-1112-36d54ef52a85@gmail.com>
 <20180426081403.GA335@localhost>
 <87r2n25i6i.fsf@miraculix.mork.no>
 <3895ed90-bbb9-e7ce-34c0-a1654646cf83@gmail.com>
 <98b50ae7-b889-6811-476e-9cdc8a62a484@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98b50ae7-b889-6811-476e-9cdc8a62a484@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598789137647329265?=
X-GMAIL-MSGID: =?utf-8?q?1598825856211551547?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 06:40:46PM +0700, Lars Melin wrote:
> On 4/26/2018 18:39, Lars Melin wrote:
> > On 4/26/2018 18:19, Bjørn Mork wrote:
> >> Anyway, Qualcomm based designs are definitely handled by both drivers.
> >> Using qcserial only makes sense if the interface layout matches one of
> >> the defined shared schemes, which currently are:
> >>
> >>     QCSERIAL_G2K = 0,    /* Gobi 2000 */
> >>     QCSERIAL_G1K = 1,    /* Gobi 1000 */
> >>     QCSERIAL_SWI = 2,    /* Sierra Wireless */
> >>     QCSERIAL_HWI = 3,    /* Huawei */
> > 
> > It seems to me that this Quectel device matches the interface layout for 
> > Gobi1K:
> > 
> >           * Gobi 1K USB layout:
> >           * 0: DM/DIAG (use libqcdm from ModemManager for communication)
> >           * 1: serial port (doesn't respond)
> >           * 2: AT-capable modem port
> >           * 3: QMI/net
> >           */

> Ublox, not Quectel..

Yeah, but qcserial appears to select a different altsetting for the DM
port for Gobi 1000, an altsetting which this particular device does not
have.

I didn't re-read the full thread I referred to earlier, but I think in
it, Dan mentioned Gobi 1000 device requiring firmware to be loaded too. 

So if it's not a G1K device, we probably shouldn't be using qcserial
even if the interface layout happens to match.

Thanks,
Johan
