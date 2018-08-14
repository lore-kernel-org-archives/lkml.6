Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C48C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41CD2172C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41CD2172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbeHNQve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 12:51:34 -0400
Received: from smtprelay0137.hostedemail.com ([216.40.44.137]:36723 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728458AbeHNQve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 12:51:34 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id 3EA2A180238A6;
        Tue, 14 Aug 2018 14:04:15 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 55E3618028911;
        Tue, 14 Aug 2018 14:04:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: geese80_41e3d3e908601
X-Filterd-Recvd-Size: 1831
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Tue, 14 Aug 2018 14:04:12 +0000 (UTC)
Message-ID: <1678613360b7aebbf1ab42dd89139cb666ee8cd9.camel@perches.com>
Subject: Re: [PATCH v2 2/2] kgdboc: Change printk to the right fashion
From:   Joe Perches <golf@perches.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>, zhe.he@windriver.com
Cc:     jason.wessel@windriver.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, kgdb-bugreport@lists.sourceforge.net,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 14 Aug 2018 07:04:11 -0700
In-Reply-To: <20180814133536.bfpygzwnmlqfsee5@holly.lan>
References: <1534250761-824-1-git-send-email-zhe.he@windriver.com>
         <1534250761-824-2-git-send-email-zhe.he@windriver.com>
         <20180814133536.bfpygzwnmlqfsee5@holly.lan>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-14 at 14:35 +0100, Daniel Thompson wrote:
> On Tue, Aug 14, 2018 at 08:46:01PM +0800, zhe.he@windriver.com wrote:
> > From: He Zhe <zhe.he@windriver.com>
> > 
> > pr_* is preferred according to scripts/checkpatch.pl.
[]
> > diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
[]
> > @@ -136,7 +136,7 @@ static int kgdboc_option_setup(char *opt)
> >  	}
> >  
> >  	if (strlen(opt) >= MAX_CONFIG_LEN) {
> > -		printk(KERN_ERR "kgdboc: config string too long\n");
> > +		pr_err("kgdboc: config string too long\n");
> 
> Looks like you should remove the tags from pr_err and use pr_fmt(fmt) to
> put tags on the messages:
> 
> #define pr_fmt(fmt) "kgdboc: " fmt

True and it's probably better to use:

#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

