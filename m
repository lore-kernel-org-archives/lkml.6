Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-66263-1520586333-2-4078923104187805892
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520586331; b=OuoPp/LT35GfFTm226TbN17JeIKRbQhr2Wed/7M8o/2PkR/
    vbuXDH+ucA2SXRlzUZxyW6z5n3FyQCwWcVKOTWQ9U4Vhdm73O7Ezv5x/p8kaZcOI
    y/XFMzQ2YspJseRV7mH6D4B6etlV9P1fpGr5TabTvEETZxKxfDAmrktD8sxFlhfP
    9Zsm8Rz0YdsYg6jCzgO08hL831S0IqF3imGm71oO59vQJwrvIAsy50Xq1IZ3FE1z
    4OdNe2f/l/mAtLu7QoxE6hRFybMrYESqx4Iw9cY9Im55w6VDs8x44G4sOqLHYRtn
    M2aygL+/ItFINrGTVgTPb3C5HGUkru4v6UOYS1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    arctest; t=1520586331; bh=CwGVcNQoZYfHzD0TB66CGEyiZr9CeBbk05fyjR
    nOTwk=; b=vwpGHFP+iGcDvdcop+PvlZXB5p0N52G98yAvAJKdSHW1eXheFJ7Uxm
    keiMZ2BeajmNd9UC13QORPQGgjuMrnLh8Awk3MstrtKXynRf1akhnyu4uMftkAbL
    /GRf64qBPbCXeu7KrM1+UVykbmX6VVA2zMfUFms6PO/7H9KzhKmGcH+xRMPBuD6o
    Bt14/yvHF3TsXQ8rZxR6OMDqMRqDFakURYOwXowVwLvLZQ6z6uhBhLwfnX/Ve7L2
    Yr0koGYNdt+I/7b/Ua7kK0ZBUsTfak7RFV8KiLicgp8pSMlF71JxHTVofg/w6VqI
    BuWf44JVNBYwuSAmnBnkgifkap04ooHQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751337AbeCIJFM (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 04:05:12 -0500
Received: from mga14.intel.com ([192.55.52.115]:55377 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751045AbeCIJFK (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 9 Mar 2018 04:05:10 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,444,1515484800";
   d="asc'?scan'208";a="210176191"
From: Felipe Balbi <balbi@kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 2/4] usb: dwc3: add dwc3 glue layer for UniPhier SoCs
In-Reply-To: <CAK7LNARE0YT8HQ-shz=Kg9eaB0pZzaefoqMe-ZnE=eqSQWFp-w@mail.gmail.com>
References: <1516712454-2915-3-git-send-email-hayashi.kunihiko@socionext.com> <87o9lklnwb.fsf@linux.intel.com> <20180124215228.ED43.4A936039@socionext.com> <87a7x3l8gr.fsf@linux.intel.com> <CAK7LNARE0YT8HQ-shz=Kg9eaB0pZzaefoqMe-ZnE=eqSQWFp-w@mail.gmail.com>
Date: Fri, 09 Mar 2018 11:04:58 +0200
Message-ID: <87y3j1aabp.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Masahiro Yamada <yamada.masahiro@socionext.com> writes:
>>>> > +static void dwc3u_reset_init(struct dwc3u_priv *priv)
>>>> > +{
>>>> > +  dwc3u_maskwrite(priv, RESET_CTL, LINK_RESET, 0);
>>>> > +  usleep_range(1000, 2000);
>>>> > +  dwc3u_maskwrite(priv, RESET_CTL, LINK_RESET, LINK_RESET);
>>>> > +}
>>>> > +
>>>> > +static void dwc3u_reset_clear(struct dwc3u_priv *priv)
>>>> > +{
>>>> > +  dwc3u_maskwrite(priv, RESET_CTL, LINK_RESET, 0);
>>>> > +}
>>>>
>>>> drivers/reset ?
>>>
>>> The reset driver manages "sysctrl" IO map area in our SoC.
>>>
>>> RESET_CTL register belongs to "dwc3-glue" IO map area,
>>> and the kernel can't access this area until enabling usb clocks and
>>> deasserting usb resets in "sysctrl".
>>>
>>> I think that "dwc3-glue" register control should be separated from
>>> "sysctrl".
>>
>> Just split your address space and treat your glue as a device with
>> several children:
>>
>> glue@65b00000 {
>>         compatible =3D "foo"
>>
>>         phy@bar {
>>                 ...
>>         };
>>
>>         sysctrl@baz {
>>                 ...
>>         };
>>
>>         dwc3@foo {
>>                 compatible =3D "snps, dwc3";
>>                 ...
>>         };
>> };
>>
>> Then you know that you can let dwc3/core.c handle the PHY for you. If we
>> need to teach dwc3/core.c about regulators, we can do that. But we don't
>> need SoC-specific hacks ;-)
>>
>> --
>> balbi
>
>
> Slightly related question.
>
>
> Why don't we put clocks and resets to dwc3/core.c?

We can do that for the simpler platforms, no worries.

> dwc3-of-simple.c only handles clocks and resets.
> This is generic enough to be added to dwc3/core.c, I think.
>
>
> I checked the two instances of dwc3-of-simple.
>
> "qcom,dwc3"
> https://github.com/torvalds/linux/blob/v4.16-rc3/arch/arm64/boot/dts/qcom=
/msm8996.dtsi#L780
>
> "rockchip,rk3399-dwc3"
> https://github.com/torvalds/linux/blob/v4.16-rc3/arch/arm64/boot/dts/rock=
chip/rk3399.dtsi#L395
>
>
> They just contain clocks, resets, and "snps,dwc3" sub-node.
>
>
> If we do that,
>
> usb@7600000 {
>         compatible =3D "qcom,dwc3";
>         clocks =3D ...;
>
>         dwc3@7600000 {
>                 compatible =3D "snps,dwc3";
>                 reg =3D ...;
>                 interrupts =3D ...;
>                 phys =3D ...;
>         }
> };
>
>
> will be turned into
>
>
> dwc3@7600000 {
>         compatible =3D "qcom,dwc3", "snps,dwc3";
>         reg =3D ...;
>         clocks =3D ...;
>         interrupts =3D ...;
>         phys =3D ...;
> };
>
>
> This looks simpler.

yup. This will only work for the simpler platforms, though. TI platforms
and PCI-based platforms, this really won't work :-)

> Also, dwc3/core.c and dwc3-of-simple.c
> duplicate runtime PM.

they "kinda" duplicate :-) Some platforms have platform-specific clocks
which are not generic enough to be stuffed into dwc3/core.c. Some of
those clocks may need special handling of some sorts. It's best to keep
the option for peculiar clock tree setups available.

If your platform is simple enough that you can get away without a glue
layer, sure thing. More power for you :-)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlqiTjoACgkQzL64meEa
mQYPCA/+P7rcXMx5aWldt2WPSal5A+KgDrwM7Bmw35toDIEgnMGzSHyuxVMEofIU
tNiCKsZtmbk8X5NtZbXpjKHkKkCQp1fflFL0m4Lo901NJTB1oDTz5JdhlF8Bqjl4
ok7i6Ir7qG/hIgMqeR99EsXW+78VNN5AM96HNYRxZ9ZIQx4Fs+55Z6Q3U/z1UbMh
ACQoXr9M+Bsk/bN9YMhoRJbyz4BMzm1UPFXutPsqgaMjXXJHCiiXDaQ1shn/ZDUd
Z91KIF+KQCEB1RuSh/euU4x/JroeyJw39egeDXfGZjbGZAYnIJuwLEo7J9TJGQc2
Vzs0c4QYYOZZaGBdgNfX1Fp3Tu6qQb2CDhQLkRwACkD0ro2mlYHxM8zqy1c0jdVO
ocW62XBWgPAXoGTtcr8G1f3QP/4Cmc5fKOeukAQ60nJ11NPzAZ9h0o0IEwlGllrp
T/SDeGox+SdQ83tIhZ8fKwWJ+/N9uAQYbdffCzouL/nE5VIcpoG9x1LMspzVW7PM
3QdZGTs2ToQO5OpDTLlhwkZJwDrInLst8OWra1LpigIY0P06bLgG1Iakuta3BD+q
bNKSa4/tGbdKcYQR0Z91p2QnLoGWjrymrZNWM5tecGlna7cbazhy3QgOvFckYSBE
9Y6IlyMOXvpq8J+2l9dF2+vFxl6h+4gPjlC2hCuOj6ccPb484KM=
=kNAK
-----END PGP SIGNATURE-----
--=-=-=--
