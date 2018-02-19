Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4116716-1519041155-2-648908199593804194
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519041154; b=BW2a9br1KpamrI02Z32Wxohw4CZ/1gRSI+wuavxFhpAH0PH
    /LMsa1Poj0Wxat99I/ktubHV5PmD9vMYT+A7nbKN57PS/aUweL/XTEi28p9VKNut
    +tpgZLRSylx2n/IcDKm1oRGcaGVMm2DL+Xk2gWe6BWKsNBC5vbitUokxbF4jR7su
    D1IK8Iv00jHPylJA2kaxg6e5sVzxAnPzVThKb6hmE+zuVj6Xp+ziyNm1jgbzFRt7
    Nob4jwIElAXjdqPZsfz3DkM33ZG2GTQnezZ9OJtx8bSH4v23y8m6WnV82M5tV/tp
    npiTAv3RN4+EvccT3NF0vtxPZDsIp9idjp/lmMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519041154; bh=a
    3XXI59yIWrrcrZZBSXoIGcRed8gHGcmVbL0Qa1NuQc=; b=Eqq1KOW7cHRJOkEBP
    5Sj0XUI/zW574tGhxJPiTYi2Vg+HK0MO7ETRn2iksn5+QlDHMsmlzvTQrIqqTpd9
    C5IKwm31jmCmqmTjPmrmWETg0btGVdoYs9GfMnxslorpMPGZAxDs3irta/bI1EyR
    NMlHbqJ5er0FGZlSBdplYbsrQGj5yJhZLXL1DcWIZj4SEy+e3A4jV1xcSddhDz7A
    L5+Za2p1SuCAEpympu4EruK5BqYtRJMGZYWjRgt99Sl3U2JI1MB46gTSRu5gLaNr
    vGAbpzXGRyZ5lg9KiZB71gXhVDLjHsidZy7qwSQ5cZZaZZYj1iTDdquYdvjNpLrl
    vOyEA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MYKvbGnN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BCGrjEIp;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MYKvbGnN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BCGrjEIp;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x22447vxP03Azvn5CkAcTsx6dwGkgs+W8IUycp/oovabVTBT10FIg/C4Q/YCssXL8ka6gSJtMJQ==
Date: Mon, 19 Feb 2018 08:52:22 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] staging: iio/meter: add name to function definition
 arguments
Message-ID: <20180219115222.r7uvuhvt2reetd4g@smtp.gmail.com>
References: <20180216125041.qfvg7xtpulc54tk6@smtp.gmail.com>
 <1518785796.9517.25.camel@nxp.com>
 <20180216131658.h7b2y2ckkucetnzj@smtp.gmail.com>
 <20180217140834.2947e5e4@archlinux>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180217140834.2947e5e4@archlinux>
User-Agent: NeoMutt/20171215
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
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>, "knaack.h@gmx.de" <knaack.h@gmx.de>,
 Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Jonathan,

> On Fri, 16 Feb 2018 11:16:58 -0200
> Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:
> =

> > Hi Daniel
> > =

> > > Hi Rodrigo,
> > > =

> > > I think this is a nice finding. One comment inline:
> > > =

> > > On Vi, 2018-02-16 at 10:50 -0200, rodrigosiqueira wrote:  =

> > > > This patch fixes the checkpatch.pl warning:
> > > > =

> > > > drivers/staging/iio/meter/ade7854.h:157: WARNING: function definiti=
on
> > > > argument 'struct device *' should also have an identifier name...
> > > >=A0
> > > > +	int (*read_reg_32)(struct device *dev, u16 reg_address, u32 *val);
> > > > +	int (*write_reg_8)(struct device *dev, u16 reg_address, u8 value)=
;  =

> > > =

> > > =

> > > Any particular reason for using val vs value? I get that one is a poi=
nter
> > > and another a plain type, but I think the name should be the same.  =

> > =

> > Before I selected the name, I figure out that read_reg_* and write_reg_*
> > was assigned inside the iio/meter/ade7754-(i2c|spi).c files by function
> > like ade7754_*_read_reg_* and ade7754_*_write_reg_* .
> > =

> > I considered to use 'value' name for both functions parameters, however,
> > I noticed that function ade7754_*_write_reg_* adopted the name 'value'
> > for the last argument and ade7754_*_read_reg_* named the last argument
> > as 'val'. So, for consistency sake between the header file and the c
> > code, I decided to use the same parameter name patterns.
> > =

> Hohum. It isn't even that consistent ;)
> =

> ade7754_write_reg_8 uses val and ade7754_write_reg_16 uses value.
> =

> I would suggest another patch to make them all val.

Thanks for the review. I will send another patch as you recommended.

Rodrigo Siqueira
 =

> Thanks,
> =

> Jonathan
> > =

> > > thanks,
> > > Daniel.
> > >  =

> > =

> > Thanks =

> =

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
