Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D37ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E982147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g7/YUo+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E982147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732453AbeGLWLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 18:11:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55414 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbeGLWLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 18:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=13BzDJZdBVROU81AU4mCNZcH19rhSHagC7cl7Gpy7cU=; b=g7/YUo+j0mKYAP8KH9qbKs2an
        Q5VKOMvd/25O+efN1/uerFXgeRuwgVfw4ivntPZYXMTGFm1c5fnHmKfNkAqr4bUEoDa2iticDT/E0
        ya5qPF0Yvhy9aEp+X4p2aePs4mQfDl1h88QMfiL9wy5C44k4m0M7qpzli22374EAJSrn1Oel+/sCq
        Nkqp3tN9IXvvEggP5xGsC0Gcv7nA+qzXBMOVYXq6DrQst+3/8DAvlUFeaA5FGqtxbMD6Ph+lVkeWV
        aiHQ3a9Hh1y2nDq7NsoCwku32LDzUSQ2U5dRcaJH8WpGJ4Ww5iZ4TcWTJQ99HR1vUd7IXXmn8xMGp
        WTHzzbvNA==;
Received: from 177.157.125.74.dynamic.adsl.gvt.net.br ([177.157.125.74] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdjcw-0000bl-2b; Thu, 12 Jul 2018 21:59:54 +0000
Date:   Thu, 12 Jul 2018 18:59:44 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, Crt Mori <cmo@melexis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-integrity@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v2 00/10] Split i2c_lock_adapter into i2c_lock_root and
 i2c_lock_segment
Message-ID: <20180712185944.62219cf6@coco.lan>
In-Reply-To: <20180712212850.axi3rrfwivqymqh5@ninjato>
References: <20180620051803.12206-1-peda@axentia.se>
        <20180626023735.xj7aqhvw7ta2lq6s@ninjato>
        <20180712212850.axi3rrfwivqymqh5@ninjato>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 12 Jul 2018 23:28:51 +0200
Wolfram Sang <wsa@the-dreams.de> escreveu:

> On Tue, Jun 26, 2018 at 11:37:36AM +0900, Wolfram Sang wrote:
> > On Wed, Jun 20, 2018 at 07:17:53AM +0200, Peter Rosin wrote:  
> > > Hi!
> > > 
> > > With the introduction of mux-locked I2C muxes, the concept of
> > > locking only a segment of the I2C adapter tree was added. At the
> > > time, I did not want to cause a lot of extra churn, so left most
> > > users of i2c_lock_adapter alone and apparently didn't think enough
> > > about it; they simply continued to lock the whole adapter tree.
> > > However, i2c_lock_adapter is in fact wrong for almost every caller
> > > (there is naturally an exception) that is itself not a driver for
> > > a root adapter. What normal drivers generally want is to only
> > > lock the segment of the adapter tree that their device sits on.
> > > 
> > > In fact, if a device sits behind a mux-locked I2C mux, and its
> > > driver calls i2c_lock_adapter followed by an unlocked I2C transfer,
> > > things will deadlock (since even a mux-locked I2C adapter will lock
> > > its parent at some point). If the device is not sitting behind a
> > > mux-locked I2C mux (i.e. either directly on the root adapter or
> > > behind a (chain of) parent-locked I2C muxes) the root/segment
> > > distinction is of no consequence; the root adapter is locked either
> > > way.
> > > 
> > > Mux-locked I2C muxes are probably not that common, and putting any
> > > of the affected devices behind one is probably even rarer, which
> > > is why we have not seen any deadlocks. At least not that I know
> > > of...
> > > 
> > > Since silently changing the semantics of i2c_lock_adapter might
> > > be quite a surprise, especially for out-of-tree users, this series
> > > instead removes the function and forces all users to explicitly
> > > name I2C_LOCK_SEGMENT or I2C_LOCK_ROOT_ADAPTER in a call to
> > > i2c_lock_bus, as suggested by Wolfram. Yes, users will be a teensy
> > > bit more wordy, but open-coding I2C locking from random drivers
> > > should be avoided, so it's perhaps a good thing if it doesn't look
> > > too neat?
> > > 
> > > I suggest that Wolfram takes this series through the I2C tree and
> > > creates an immutable branch for the other subsystems. The series
> > > is based on v4.18-r1.  
> > 
> > Applied to a seperate branch named "i2c/precise-locking-names" which I
> > will merge into for-next, so it will get proper testing already. Once we
> > get the missing acks from media, MFD, and IIO maintainers, I will merge
> > it into for-4.19.  
> 
> Ping for media related acks.

For the media-related ones:

Acked-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> 
> Thanks,
> 
>    Wolfram
> 



Thanks,
Mauro
