Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-460864-1524330274-2-4230294237127888800
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524330274; b=Gr7MLiDjLMYPqNnP+Q2NuGjxCn9TkFEv/IsVDVomkfnwsw8RF5
    Z6Fgi1dktCVbqKX6O0p6pFXhu18ZWVireGBuf9maJsACFVpxk8BEGlgmvQAPdFyh
    aI0B96TUTe84WoEKOTy3bMyjx2o7SB1jlhO5KmX2Xbrn81fQL4EXtVovE48rs2cM
    AOiknOh60s8tyGEyNjGNmgIEvaZbMYZykd73lJNbgLCxcXWxWasiiVflT0oubrHD
    17JCzeJkYt1Rcof31u46NeU6/tB2zRlcVixeudPWdu99vHnMjW7VADS32MoCnYJn
    /EQGx/svbkCRGDR2+D8IhcZNMC1wmm2XsYuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524330274; bh=lEJSV
    amq6IWIPfNOMsBZGBi0TLD9u55WYWITfhafRQs=; b=uKPydDACpQ5iBT+XX1wY2
    MbWZz+isGrD+5Ab+vrbwnj55eq7Gnt1+PEOj1dL6jutm4QTot2rpx2PcRLlrrpMy
    xLM6al2mku8Cd1reMrvsbe6PaXLGXz0FRsLTyKQB4Gy4J3dXLezU7WCiZKmX9uiX
    8hs+p90ghJe0XOB8olHtKs7t7Jpexe4m9U/NR7bGz+XkJ7G63ty70zZ1zsvww6nz
    BMvyHaNMYtpn1q6xo2uhQBsqPyGzylzCcSUsMFv+EhDnqXwiAC/K87S4FI8AbSeC
    grWe7HS+qcDwEp3pvNhQDzilDJCByGvZX3y18FzFwjDjzLpaSVvqLZpCSZz6b1Hx
    A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=pCWd+NwW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=onstation.org header.i=@onstation.org header.b=pCWd+NwW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=onstation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=onstation.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMxSplTFPb3Jv/0V/ZPp4eUk0qJdK50ekekFM4H49n+Qz373kr87f/73LZkJ1UwaMyCH2J5OoanAyR5/VBdETR5Nm+qWFSEUa0IpnnJEis/keUuiLJG7
    wgUkF0ylj+XYID8IC3DbXQtVqvEpQ+FrC91u1j3JuQ0Y5195q4b5OthmYoAQsWGa/+SZERknYefGVxvW/5hnX4N6RD9Zs2Vtv+GwuTEWgKLa8qrnLn7CmPck
    28ByndR+fsqFbNxqv9WyeQ==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=71GR_KF1BwUtR_EYfnkA:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sat, 21 Apr 2018 13:04:26 -0400
From: Brian Masney <masneyb@onstation.org>
To: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 02/13] staging: iio: tsl2x7x: use GPL-2.0+ SPDX license
 identifier
Message-ID: <20180421170426.huexk7adftsofkua@af1a4438606c>
References: <20180421004153.19073-1-masneyb@onstation.org>
 <20180421004153.19073-3-masneyb@onstation.org>
 <20180421171638.13443ed8@archlinux>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180421171638.13443ed8@archlinux>
User-Agent: NeoMutt/20170113 (1.7.2)
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
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, Jon.Brenner@ams.com,
 pmeerw@pmeerw.net, knaack.h@gmx.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 21, 2018 at 05:16:38PM +0100, Jonathan Cameron wrote:
> On Fri, 20 Apr 2018 20:41:42 -0400
> Brian Masney <masneyb@onstation.org> wrote:
> 
> > The summary text for the GPL is not needed since the SPDX identifier
> > is a legally binding shorthand that can be used instead.
> > 
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> I sanity checked against other drivers because I wasn't 100% sure
> this wasn't a valid formatting for SPDX.  It doesn't seem to be.
> Normally convention is
> //SPDX... 
> On the first line of the file.
> C style comments also fine, but it needs to be a comment line on it's
> own.  This is all about making it trivial for automated tools to find.

The style that you referenced is the most common style, however I saw
quite a few places in the kernel use the style used by this patch so I
thought that it may be acceptable.

$ grep -r SPDX arch/ drivers/ include/ | grep \* | grep -v ":\/"

I'll resubmit the patch next week with hopefully the last bit of
cleanups to get this driver out of staging.

Brian



> > ---
> >  drivers/staging/iio/light/tsl2x7x.c | 10 +---------
> >  drivers/staging/iio/light/tsl2x7x.h | 14 +-------------
> >  2 files changed, 2 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> > index eeccfbb0eb1f..9cdcc8c9e812 100644
> > --- a/drivers/staging/iio/light/tsl2x7x.c
> > +++ b/drivers/staging/iio/light/tsl2x7x.c
> > @@ -5,15 +5,7 @@
> >   * Copyright (c) 2012, TAOS Corporation.
> >   * Copyright (c) 2017-2018 Brian Masney <masneyb@onstation.org>
> >   *
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License as published by
> > - * the Free Software Foundation; either version 2 of the License, or
> > - * (at your option) any later version.
> > - *
> > - * This program is distributed in the hope that it will be useful, but WITHOUT
> > - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> > - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> > - * more details.
> > + * SPDX-License-Identifier: GPL-2.0+
> >   */
> >  
> >  #include <linux/delay.h>
> > diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
> > index d382cdbb976e..992ee2465609 100644
> > --- a/drivers/staging/iio/light/tsl2x7x.h
> > +++ b/drivers/staging/iio/light/tsl2x7x.h
> > @@ -4,19 +4,7 @@
> >   *
> >   * Copyright (c) 2012, TAOS Corporation.
> >   *
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License as published by
> > - * the Free Software Foundation; either version 2 of the License, or
> > - * (at your option) any later version.
> > - *
> > - * This program is distributed in the hope that it will be useful, but WITHOUT
> > - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> > - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> > - * more details.
> > - *
> > - * You should have received a copy of the GNU General Public License along
> > - * with this program; if not, write to the Free Software Foundation, Inc.,
> > - * 51 Franklin Street, Fifth Floor, Boston, MA	02110-1301, USA.
> > + * SPDX-License-Identifier: GPL-2.0+
> >   */
> >  
> >  #ifndef __TSL2X7X_H
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
