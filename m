Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25877C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 20:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D377E208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 20:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QHY9cqEg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D377E208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405113AbeKWHQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 02:16:57 -0500
Received: from casper.infradead.org ([85.118.1.10]:47932 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730632AbeKWHQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 02:16:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gPXhfSh7YtHd0eTt0Kr8G0AH7JX63P7S4BhOWRASTMQ=; b=QHY9cqEghBCLztan5bmkurShFY
        zu0pvKoxPRsL+564kj8vMCvcgL3b+fRF/7Nqo97A6TsGQcemS7/brna66F9KCFzPmcmZA8h3vskYJ
        WJoFZ05RMn0LVldqqy3LZcDi7EWP+i039wwz4EZLHB9qYqZ/9/5v6J/7JU2acbCa+ArusMmnjt2yw
        XMKh4F037IUZFNWHODKulpxVMJTpaD7Ojp5E7ohNI0Jr571wCYLZJqCWxqE8D8oyvPC0NqBd8Oycl
        tdo8ZRP4aTLYQBnN13acYeQbiXTLEp5/J9lvjEA8VXqFpgCwAos5bBYIweOQhkOIVNsgWMIw1oWHO
        iBLtSeJQ==;
Received: from 201.47.163.210.dynamic.adsl.gvt.net.br ([201.47.163.210] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPvhZ-0006L0-BM; Thu, 22 Nov 2018 20:35:53 +0000
Date:   Thu, 22 Nov 2018 18:35:49 -0200
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     stakanov <stakanov@eclipso.eu>
Cc:     Takashi Iwai <tiwai@suse.de>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: DVB-S PCI card regression on 4.19 / 4.20
Message-ID: <20181122183549.331ecbc4@coco.lan>
In-Reply-To: <12757009.r0OKxgvFl0@roadrunner.suse>
References: <4e0356d6303c128a3e6d0bcc453ba1be@mail.eclipso.de>
        <2836654.gWKGMNFOG2@roadrunner.suse>
        <20181122180611.2e7f1123@coco.lan>
        <12757009.r0OKxgvFl0@roadrunner.suse>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 22 Nov 2018 21:19:49 +0100
stakanov <stakanov@eclipso.eu> escreveu:

> Hello Mauro.=20
>=20
> Thank you so much, for this fast reply and especially for the detailed=20
> indications. I expected to have a lack of knowledge.=20
>=20
> Well,  I am replying to the question as of below: (for convenience I did =
cut=20
> the before text, if you deem it useful for the list I can then correct th=
at in=20
> the next posts).
>=20
> In data gioved=C3=AC 22 novembre 2018 21:06:11 CET, Mauro Carvalho Chehab=
 ha=20
> scritto:
> > Are you sure that the difference is just the Kernel version? Perhaps you
> > also updated some other package. =20
>=20
> To be clear: I had the same system(!) with all three kernel 4.18.15-1, 4.=
19.1 =20
> (when the problem did arise) and 4.20.2 rc3 from Takashi's repo) installe=
d.=20

Ok, so rebooting to 4.18.15-1 solves the issue?

Also, what GPU driver are you using?

In any case, by using the old "Universal" LNBf, you're likely missing some
transponders, and missing several channels.

> In this very configuration: if one booted in 4.18 (that is in perfect par=
ity=20
> with all other packages) the card worked. 4.19.1 no. And the last kernel =
the=20
> same. So whatever might be different, forcefully it has to be in the kern=
el.=20
> (Which is not really a problem if I manage to make it work, so settings w=
ill=20
> be known to others or, if not, we will find out what is different, and al=
l=20
> will be happy. As you see I am still optimist). =20

Well, we don't want regressions in Kernel. If there's an issue there,
it should be fixed. However, I can't think on any other changes since
4.18 that would be causing troubles for b2c2 driver.

See, the only change at the driver itself is just a simple API
replacement that wouldn't cause this kind of problems:

	$ git log --oneline v4.18.. drivers/media/common/b2c2/
	c0decac19da3 media: use strscpy() instead of strlcpy()

There were a few changes at the DVB core:

	$ git log --no-merges --oneline v4.18.. drivers/media/dvb-core/
	f3efe15a2f05 media: dvb: use signal types to discover pads
	b5d3206112dd media: dvb: dmxdev: move compat_ioctl handling to dmxdev.c
	cc1e6315e83d media: replace strcpy() by strscpy()
	c0decac19da3 media: use strscpy() instead of strlcpy()
	fd89e0bb6ebf media: videobuf2-core: integrate with media requests
	db6e8d57e2cd media: vb2: store userspace data in vb2_v4l2_buffer
	6a2a1ca34ca6 media: dvb_frontend: ensure that the step is ok for both FE a=
nd tuner
	f1b1eabff0eb media: dvb: represent min/max/step/tolerance freqs in Hz
	a3f90c75b833 media: dvb: convert tuner_info frequencies to Hz
	6706fe55af6f media: dvb_ca_en50221: off by one in dvb_ca_en50221_io_do_ioc=
tl()
	4d1e4545a659 media: mark entity-intf links as IMMUTABLE

But, on a first glance, the only ones that has potential to cause issues
were the ones addressed that the patch I wrote (merged by Takashi).

If you're really receiving data from EPG (you may just have it
cached), it means that the DVB driver is doing the right thing.

Btw, to be sure that you're not just seeing the old EPG data, you
should move or remove this file:

	~/.local/share/kaffeine/epgdata.dvb

Kaffeine will generate a new one again once it tunes into a TV channel.

> I will proceed as indicated and report back here tomorrow.=20

Ok.

Thanks,
Mauro
