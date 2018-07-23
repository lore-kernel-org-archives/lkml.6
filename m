Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3891CECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB27220671
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z4rkj4kj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB27220671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388076AbeGWTjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 15:39:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59118 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388012AbeGWTjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 15:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cXjbJbCCdqudrGYots11vdQIWwURgKOxoWes9lvTPBU=; b=Z4rkj4kjYSel0LsyblscGSzom
        g6diQjO0OhUhPV2nWdGtwXI5nTLlWnZJ3O/yTmnPHCd2lWVADRr6eAFf6YePk7KyYrquMSFooo8Nm
        0oy8D/O5mppH3vWYIPcZdjtHy8pewA7n6e9q6lGGSvG80njCzCTARx47zGOLDD05gTNjCJXz9Trdb
        SZw6rd39vdJm9cfhFEG9P9WOrgcAEolMOQuz9KRK9AfJX4P07vuXQZWo2/tnMtodcfSdOt/nCH0PZ
        GMw05/Tvk5xDeRGH7hy4KaG3EzgyX7fKVa0etv8YxQ5E3WVxGrFPNB8Rwm24WwZ07SRSLc47K9Y4L
        pWs+OVz2w==;
Received: from 177.41.135.13.dynamic.adsl.gvt.net.br ([177.41.135.13] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhfhg-0002Pq-82; Mon, 23 Jul 2018 18:37:04 +0000
Date:   Mon, 23 Jul 2018 15:36:57 -0300
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
Subject: Re: [PATCH, libv4l]: Make libv4l2 usable on devices with complex
 pipeline
Message-ID: <20180723153649.73337c0f@coco.lan>
In-Reply-To: <20180719205344.GA12098@amd>
References: <20180708213258.GA18217@amd>
        <20180719205344.GA12098@amd>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

Em Thu, 19 Jul 2018 22:53:44 +0200
Pavel Machek <pavel@ucw.cz> escreveu:

> On Sun 2018-07-08 23:32:58, Pavel Machek wrote:
> > 
> > Add support for opening multiple devices in v4l2_open(), and for
> > mapping controls between devices.
> > 
> > This is necessary for complex devices, such as Nokia N900.
> > 
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>  
> 
> Ping?
> 
> There's a lot of work to do on libv4l2... timely patch handling would
> be nice.

As we're be start working at the new library in order to support
complex cameras, and I don't want to prevent you keeping doing your
work, IMHO the best way to keep doing it would be to create two
libv4l2 forks:

	- one to be used by you - meant to support N900 camera;
	- another one to be used by Google/Intel people that will
	  be working at the Complex camera.

This way, we can proceed with the development without causing
instability to v4l-utils. Once we have the projects done at the
separate repositories, we can work on merging them back upstream.

So, please send me, in priv, a .ssh key for me to add you an
account at linuxtv.org. I'll send you instructions about how to
use the new account.

Thanks,
Mauro
