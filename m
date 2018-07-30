Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E3AFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCE020881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TZCAXU+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DCE020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeG3LFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:05:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35046 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeG3LFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SbkjBoWInJJMPsFGBAI72P5z7I6y/jfV4DDG6h25E2s=; b=TZCAXU+8fdx6d8wn3pXNXGEii
        BJgxUzwgtGZ4bpe7fDVx+J811UTu+8JWcY2fvahjptKPK+Zh8PxptKlj2S/l2xDA4DO5ywANgd6zq
        seJQ1W9aXtaVd+Wk2CVybBQ+hl/WDrTL1Mogck6qZ+MhNYdtjBqby78bMW3E+fuzsQBLVSnyTFMD4
        LOf5m12pf6SIJAbLug7XRvEevjxtn3Ng6AAZbQljlBEGdEopAjeUj68rBBUcGY36KTb24Ydj38+BX
        CI++aJsEVDVS2NKeZHFMbc/1y4YUC+NhtwVWiTfkLgZtCEK/BjGnVCUnsXElx+WIzawGDwL/kZS0M
        Rt8hOMJIQ==;
Received: from [179.95.0.119] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fk4Wf-0002ky-RN; Mon, 30 Jul 2018 09:31:38 +0000
Date:   Mon, 30 Jul 2018 06:31:30 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     pali.rohar@gmail.com, sre@kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org,
        aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com,
        patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com,
        clayton@craftyguy.net, martijn@brixit.nl,
        sakari.ailus@linux.intel.com,
        Filip =?UTF-8?B?TWF0aWpldmnEhw==?= <filip.matijevic.pz@gmail.com>,
        mchehab@s-opensource.com, sakari.ailus@iki.fi,
        linux-media@vger.kernel.org, hans.verkuil@cisco.com
Subject: Re: new libv4l2 (was Re: [PATCH, libv4l]: Make libv4l2 usable on
 devices with complex pipeline)
Message-ID: <20180730063122.73a20c55@coco.lan>
In-Reply-To: <20180728211110.GB1152@amd>
References: <20180708213258.GA18217@amd>
        <20180719205344.GA12098@amd>
        <20180723153649.73337c0f@coco.lan>
        <20180728211110.GB1152@amd>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, 28 Jul 2018 23:11:10 +0200
Pavel Machek <pavel@ucw.cz> escreveu:

> Hi!
> 
> > > > Add support for opening multiple devices in v4l2_open(), and for
> > > > mapping controls between devices.
> > > > 
> > > > This is necessary for complex devices, such as Nokia N900.
> > > > 
> > > > Signed-off-by: Pavel Machek <pavel@ucw.cz>    
> > > 
> > > Ping?
> > > 
> > > There's a lot of work to do on libv4l2... timely patch handling would
> > > be nice.  
> > 
> > As we're be start working at the new library in order to support
> > complex cameras, and I don't want to prevent you keeping doing your
> > work, IMHO the best way to keep doing it would be to create two
> > libv4l2 forks:  
> 
> BTW.. new library. Was there decision what langauge to use? I know C
> is obvious choice, but while working on libv4l2, I wished it would be
> Rust...
> 
> Rewriting same routine over and over, with slightly different types
> was not too much fun, and it looked like textbook example for
> generics...

Whatever language it uses, the library should provide a standard C API
interface and avoid using libraries that may not be available on
the systems supported by the v4l-utils package, as other packages
and a libv4l-compatible interface should be linked using it.

It should also be something that the existing v4l-utils developers are
familiar with. Right now, we have only C and C++ code inside v4l-utils.

So, I'd say that the language should be either C (the obvious choice)
or C++.

It should also be licensed using the same terms as v4l-utils libraries,
e. g. LGPL 2.1+.

Thanks,
Mauro
