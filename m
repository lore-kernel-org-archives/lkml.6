Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-775307-1524470953-2-2110714558102792931
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524470953; b=cFU2OdOpi4o7bnGfbJybInjeO24OATT/0zjpHw2nD1tNG9hcHe
    yZTT6ksnO4dohlYR5ywRVbND38opBlULDb4Df/VG6WY7QPARidTnE5slkPm/0/MW
    spFohgGIoW2ueS80orhpuNnxQtYX0QfoXBRHvlzBWqZqFDt7HC9mvQCcwEgn7QTu
    MO7vGs5W+xQJ6ugHHCsWyyrs0tCjKQcX9UDnECkq4HOUsOlWTRtH6BmjKMihUsNS
    NY3rHAHzBwuW55Bx4QQPgqYpn8TZF4ulKpTQ/S0/QW4ZUupPSnvSQIIWNfQf5XI1
    1rMHKQjsiccaH9QAbgYALtDDC89PyXM16XSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524470953; bh=gURHk
    u2CIzHxWmb184uOGWzSLdSJ5yT4VqAp3UZkCK8=; b=pXQwyN/g0oUfPs4PmMFyN
    1NMW7PiLUvEdVvGcEJqNQvCJALRkbzRL3Smac8MPG6+RzOr/qraptooqKv7BOPUC
    KzBkUMYR78CshGXiVN305uhTqhCW4RgSGzNSmK5WkIY/b21PUbx8hXZ3yHw/ulB6
    dpnTT492i1zg3PTzPCpKAzVAJjqK+lCuYGO6mLWDtt1jTtYInWmYWlo3GiGfSpdo
    nw4ku/UCmnQPD4vXag0ut9bTDsfaolLkYI2mhORht/ZvKjoj3hDenBZiPOzVRbPj
    YCBcOw9iYqYtx4MbGt31jL7lfCfYqSq2NrxHZ+Ma+uzzD4JOuYdAvFcL9l7CY95M
    Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=uoL8g3XO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hMmIWHf/;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=uoL8g3XO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hMmIWHf/;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJEL5BaVm5y9H9nZGRuk7ZCbg05JhckqRcrNLJZAsXs2Qzs6uEEVR/fBvcMCtTAIdKHjYr6okX59ywBHEGbOT/EocBA/SShgE3bFOidOZ/qq9mlxhEnF
    GslfFdDbZicgKtfr8kPm11iPUeJPReV5pgFC7MIniwUZmMyVLXLJ3kvBMQNtzJ0LcnIdtNnrpfkofLjvNE2wua1S20GconEFq3Ia55vVu4qxYx34YhY/yrJz
    AY7+s4ViOv5jcf38t8ar3A==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=P1BnusSwAAAA:8 a=tBb2bbeoAAAA:8
    a=DDOyTI_5AAAA:8 a=gM8nZuZnHEkB0YwCZcgA:9 a=CjuIK1q_8ugA:10
    a=D0XLA9XvdZm18NrgonBM:22 a=Oj-tNtZlA1e06AYgeCfH:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4/cXxyZZJTNvqj0KVyzheXSg/Q2EpAmRViOl1i2KgZWgXO9o1jvKF6uhQU1rc88N4r1f3Se3c6O8duOaQkn65c=
MIME-Version: 1.0
In-Reply-To: <1700954.Qkp7xggMnX@avalon>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
 <1524230914-10175-4-git-send-email-geert+renesas@glider.be>
 <3039853.rivznOVBTv@avalon> <1700954.Qkp7xggMnX@avalon>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Apr 2018 10:08:55 +0200
X-Google-Sender-Auth: iwwZ7oIsVAnPedjXkTwukEbXlKg
Message-ID: <CAMuHMdUv6Gb6D0qAnDMRYhS8Uzriv1rALXpuzuMm6ndGk24GNg@mail.gmail.com>
Subject: Re: [PATCH 3/8] [media] v4l: rcar_fdp1: Change platform dependency to
 ARCH_RENESAS
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Liam Girdwood <lgirdwood@gmail.com>, driverdevel <devel@driverdev.osuosl.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Jaroslav Kysela <perex@perex.cz>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Simon Horman <horms@verge.net.au>, netdev <netdev@vger.kernel.org>,
 dmaengine@vger.kernel.org, "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Laurent,

On Sun, Apr 22, 2018 at 10:46 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Saturday, 21 April 2018 11:07:11 EEST Laurent Pinchart wrote:
>> On Friday, 20 April 2018 16:28:29 EEST Geert Uytterhoeven wrote:
>> > The Renesas Fine Display Processor driver is used on Renesas R-Car SoCs
>> > only.  Since commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce
>> > ARCH_RENESAS") is ARCH_RENESAS a more appropriate platform dependency
>> > than the legacy ARCH_SHMOBILE, hence use the former.
>> >
>> > This will allow to drop ARCH_SHMOBILE on ARM and ARM64 in the near
>> > future.
>> >
>> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>
>> How would you like to get this merged ?
>
> Unless you would like to merge the whole series in one go, I'll take this in
> my tree as I have a conflicting patch I would like to submit for v4.18.

Please take it in your tree, thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
