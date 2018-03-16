Return-Path: <leechu729@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521207586; cv=none;
        d=google.com; s=arc-20160816;
        b=IWkHI0oE+MDgyyj4cLj4sEqLWQpByndVSYDkehBz2CW2PLWKtkFtF1FShfiKHroFZ9
         s7wEVm9FvgP4HTiXBdnpBUN12ZMqAXv4Okd0X/IPSFX/6VCFQPvt8pfumGAMw78dt2oy
         QCFfw7soyFRPS24GNt5D5zJ28RJrei9BwmNtUcY35vnYLQzET3PqvdmlQ/6RxGMEuojI
         +t+S7xRHUq7YwAc3lCKNaOpqEzc797lPZpRaWB/S2T+P4vMAjhd9TwDIRVO4xuRbeXBW
         3NxbdZp6egv1NTjRZ0InFjbuSgKEefG6ejwmGNkd3jvlHt/3H1b6Aak3u/rQzhwmeoDw
         LovQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=u3DNvdbIsyV6V+ydqkf3oglYjzgOtoqFIsl8iDMVBpc=;
        b=CnaPrUWjHvC02RK7Sy+2ch4b7EizTQaw0Wi2TgDskKezrk1YZmYTQKkmfEdkWffiy1
         pzKVtQDjmyItMxKdfg7ppZ9IVBFI7MHpaBm1MHvvuusUbZKloP43PunYzBkjTLpPaAbP
         5nnuGUT8HoKDkmlK2xP74A0iuF77mQ+9caxogjyKzZxxWkTyKBbUF8NN6vpDI3NKaBfB
         wheOUHFjr5RLhq8hsnOOLQPrpLw9ohBnuDt3EgS26fZQo6xdsUmGLazZa9kTCh4PvGfd
         ODUdpTaq2uI9hL7ID0EB5usr1Qo9+Jb8ChcHAbHLBzpUlgcVDZAESAzrLEaIQSyNX/hP
         qfdA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ihlHDchZ;
       spf=pass (google.com: domain of leechu729@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=leechu729@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ihlHDchZ;
       spf=pass (google.com: domain of leechu729@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=leechu729@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuUj6D2bnJ1tqaDULXhUkKRdS+lHr7udvErHRBI8hPGoNcja/i+416N2KnNUjd6VxRnGzbIFcQwdOjqdmYilxw=
MIME-Version: 1.0
In-Reply-To: <aa838cdd-6333-68fc-0ead-8ad9e7fd8ff9@gmail.com>
References: <1521191569-21221-1-git-send-email-leechu729@gmail.com>
 <20180316125811.GB22994@kroah.com> <aa838cdd-6333-68fc-0ead-8ad9e7fd8ff9@gmail.com>
From: =?UTF-8?B?5p2O5pu45biG?= <leechu729@gmail.com>
Date: Fri, 16 Mar 2018 21:39:45 +0800
Message-ID: <CAFaeLdRkjy+fsYny4kXjsq2qOZqL9o8iqPn7hPP5wbeTrEHypw@mail.gmail.com>
Subject: Re: [PATCH] staging: typec: rt1711h typec chip driver
To: Mats Karrman <mats.dev.list@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, heikki.krogerus@linux.intel.com,
	Guenter Roeck <linux@roeck-us.net>, =?UTF-8?B?c2h1ZmFuX2xlZSjmnY7mm7jluIYp?= <shufan_lee@richtek.com>,
	=?UTF-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>,
	Jun Li <jun.li@nxp.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1595101134568694264?=
X-GMAIL-MSGID: =?utf-8?q?1595101766068067196?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

2018-03-16 21:29 GMT+08:00 Mats Karrman <mats.dev.list@gmail.com>:
> Hi,
>
> On 2018-03-16 13:58, Greg KH wrote:
>
>> On Fri, Mar 16, 2018 at 05:12:49PM +0800, ShuFan Lee wrote:
>>>
>>> From: ShuFan Lee <shufan_lee@richtek.com>
>>>
>>> Richtek RT1711H Type-C chip driver that works with
>>> Type-C Port Controller Manager to provide USB PD and
>>> USB Type-C functionalities.
>>> Add definition of TCPC_CC_STATUS_TOGGLING.
>>>
>>> Signed-off-by: ShuFan Lee <shufan_lee@richtek.com>
>>> ---
>>>   drivers/staging/typec/Kconfig         |   8 +
>>>   drivers/staging/typec/Makefile        |   1 +
>>>   drivers/staging/typec/tcpci.h         |   1 +
>>>   drivers/staging/typec/tcpci_rt1711h.c | 344
>>> ++++++++++++++++++++++++++++++++++
>>>   4 files changed, 354 insertions(+)
>>>   create mode 100644 drivers/staging/typec/tcpci_rt1711h.c
>>
>> This looks nice and simple to me, any reason it has to live in
>> drivers/staging/ and we can't just move it to drivers/usb/typec/ now?
>>
>> Or are there still api things that need to be resolved with the existing
>> drivers/staging/typec/ code?
>
>
> For one thing it depends on the tcpci driver that is still in staging unt=
il
> Jun Li's patches, [1], comes through.
>
> // Mats
>
> [1] https://marc.info/?l=3Dlinux-usb&m=3D152093458605648&w=3D2
>
>> thanks,
>>
>> greg k-h
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>

Just like Mats said. Because tcpci_rt1711h.c depends on tcpci driver.
I'm not sure if I can put it to drivers/usb/typec/. So, I put it
staging first and move out after Jun's patches.

--=20
Best Regards,
=E6=9B=B8=E5=B8=86
