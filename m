Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2419000-1524741594-2-16432713446107137573
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='no',
  MailFrom='org'
X-Spam-charsets: from='utf-8', cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524741593; b=TGDi+f6CNVjkyzXAEzv2L0FYzaXOyMPDexjHDoaoTXtzrxX4tD
    b4ODEpad/52mwtYEDW/ENb8jAJl61KMYYHWu3ohfTGFe54epEZoZehBfawmZ3++s
    WdnpyWo/oz/GnOJ5ECFEPS5laGsVmDdzs9t6pHXnAaPPHg3ux7ZNeIhn296aDaCe
    h7Of5/cJD8oQbkWmusVqWU161sklzvP/3juz4oeZLj1UNSkRvKOYV25DOjb3Qk6f
    y5JElyJcxjwQqzcvd33HSjy2PAL74SnPADQkSo9s14AWqd6sddSETvkIuiclI5vc
    wUS1tBE0oXDti93LrpAPiLOj/Varh/qs91tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:references:date
    :in-reply-to:message-id:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524741593;
    bh=6tozkBK2r4i/VdIiIYJfAo9PCis5uQPsH0PSz0WROVs=; b=KkZE/P1vVsf1
    B5KkDcqYKQAd7s90E9aDTAEQ9zXZSCId/EKRlHhlxqF0gg20S2MXp8HNFL9pm/nN
    Z6/rCAzuVDfgFmp7MtHxR3NhTD6kZeZ1rX2wf1Ct+famfJWLltXFoVdtBA0qtlSj
    ZAJlsN6KmTgwgCMDMFBis9YxuOUNmmz/fS4OflNv1jbdtncWZkazEW3wDOghsxVZ
    2B38t9y7OrzPugepnsrVYj99MJdwk4gguUZjfhpxQ6tkTRAgAQoCAC13hztSP+x0
    2Ug4WHlA30lVd7bTIZANpJyR/JOioCYokhLF9xuF/4niri43n3q2dJJnKAMKnkyU
    t8aVW6oTeQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=mork.no header.i=@mork.no header.b=fa+10wR7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=b;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mork.no;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mork.no header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=mork.no header.i=@mork.no header.b=fa+10wR7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=b;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mork.no;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mork.no header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAlgnjG4mw1RLH4KT+AWPY/FPoJWPXpZssxELQthotAcPgtVQqZBh/8bhtNOwHagS7QOAWt0p17Gt42nKXGP9zJJO+qd9v00Jq+zVp9meWOmmL80/aLe
    rY38hudVJym2AB/chRJ4nruFIpE2qjGjTIFJxqv0q2V8e2xuTJUJxhRJX9q50ZIeR2qTPWED2WtNh0SvDethBKPWhcWzv0EmzlIFJ6vCPqgGY2G8/yajV7H3
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=dZ7Af3Q_AAAA:8 a=AHV2S9Efd_1u0aw_7AMA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=xnyMoErWsJe9py2mg6Iw:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755245AbeDZLTk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 07:19:40 -0400
Received: from canardo.mork.no ([148.122.252.1]:48831 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754295AbeDZLTi (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 26 Apr 2018 07:19:38 -0400
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Johan Hovold <johan@kernel.org>
Cc: Lars Melin <larsm17@gmail.com>,
        SZ Lin =?utf-8?B?KOael+S4iuaZuik=?= <sz.lin@moxa.com>,
        stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Williams <dcbw@redhat.com>
Subject: Re: [PATCH] USB: serial: option: adding support for ublox R410M
Organization: m
References: <20180426062831.320-1-sz.lin@moxa.com>
        <20180426070927.GT4615@localhost>
        <72c63853-aa2d-e74c-1112-36d54ef52a85@gmail.com>
        <20180426081403.GA335@localhost>
Date: Thu, 26 Apr 2018 13:19:17 +0200
In-Reply-To: <20180426081403.GA335@localhost> (Johan Hovold's message of "Thu,
        26 Apr 2018 10:14:03 +0200")
Message-ID: <87r2n25i6i.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Johan Hovold <johan@kernel.org> writes:
> On Thu, Apr 26, 2018 at 02:48:54PM +0700, Lars Melin wrote:
>> On 4/26/2018 14:09, Johan Hovold wrote:
>> > On Thu, Apr 26, 2018 at 02:28:31PM +0800, SZ Lin (=E6=9E=97=E4=B8=8A=
=E6=99=BA) wrote:
>> >> This patch adds support for ublox R410M PID 0x90b2 USB modem to option
>> >> driver, this module supports LTE Cat M1 / NB1.
>> >>
>> >> Interface layout:
>> >> 0: QCDM/DIAG
>> >> 1: ADB
>> >> 2: AT
>> >> 3: RMNET
>> >>
>> >> Signed-off-by: SZ Lin (=E6=9E=97=E4=B8=8A=E6=99=BA) <sz.lin@moxa.com>
>> >> Cc: stable <stable@vger.kernel.org>
>> >=20
>> > Applied, thanks.
>> >=20
>> > Johan
>>=20
>> With a Qualcomm Device Management interface, shouldn't this modem be=20
>> driven by qcserial?
>
> Hmm, we already have some QCDM interfaces handled by option and qcaux so
> it's not that clear-cut.
>
> Dan and Bj=C3=B6rn had a discussion about this a while back, so adding th=
em
> on CC. It seems to me that this device does not fit the intended use (or
> Gobi 1000 layout) for qcserial, but I may be mistaken.

tl;dr; I don't think qcserial is relevant unless a device matches one of
the pre-defined layout schemes.

But I'm too new in this game to say anything about the initial
intentions...=20

My view of the present situation is that qcserial handles interface
layouts shared among many devices, while option handles interface
layouts which are unique per device, and vendor+class based function
mappings.  But I could be wrong.

Anyway, Qualcomm based designs are definitely handled by both drivers.
Using qcserial only makes sense if the interface layout matches one of
the defined shared schemes, which currently are:

	QCSERIAL_G2K =3D 0,	/* Gobi 2000 */
	QCSERIAL_G1K =3D 1,	/* Gobi 1000 */
	QCSERIAL_SWI =3D 2,	/* Sierra Wireless */
	QCSERIAL_HWI =3D 3,	/* Huawei */

or if similar logic is added for a new vendor/shceme

And I see multi-vendor-id usage as the main reason for these
schemes. There isn't much reason if you can make it a single match
against a vendor-id.

The original Gobi devices are obviously multi-vendor, and Sierra
Wireless and Huwaei are OEMs making devices for a number of laptop
vendors. This causes traditional vendor-id matching to fail, as e.g. a
HP device can be made by either OEMs (or others). qcserial has become a
convenient way to map a long list of full device IDs to a specific OEM
layout.


Bj=C3=B8rn



