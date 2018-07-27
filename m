Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF96C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE2C20857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE2C20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389657AbeG0Vx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 17:53:27 -0400
Received: from smtprelay0199.hostedemail.com ([216.40.44.199]:59746 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389371AbeG0Vx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 17:53:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 441BB100E86C9;
        Fri, 27 Jul 2018 20:29:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: thing68_3958720ba7e3f
X-Filterd-Recvd-Size: 1630
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Fri, 27 Jul 2018 20:29:53 +0000 (UTC)
Message-ID: <1ccdead80a3a4c7a4032f393f3f9a73623c6656f.camel@perches.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: replace unnecessarily
 macroses on functions
From:   Joe Perches <joe@perches.com>
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc:     grygorii.strashko@ti.com, davem@davemloft.net,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 27 Jul 2018 13:29:52 -0700
In-Reply-To: <20180727202348.GC2619@khorivan>
References: <20180727191318.18698-1-ivan.khoronzhuk@linaro.org>
         <98a6d1cd4d313512d66ced3fc25f438449b3c310.camel@perches.com>
         <20180727193641.GA2619@khorivan>
         <f22d3024773abbd811673c4eb957e4a5ffca1387.camel@perches.com>
         <20180727202348.GC2619@khorivan>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-27 at 23:23 +0300, Ivan Khoronzhuk wrote:
> For ARM, situation a little bit different:
> $ arm-linux-gnueabihf-gcc -c -O2 -DSWITCH foo.c
> $ size foo.o
>    text	   data	    bss	    dec	    hex	filename
>      32	      0	      0	     32	     20	foo.o
[]
> $ arm-linux-gnueabihf-gcc -c -O2 foo.c
> $ size foo.o
>    text	   data	    bss	    dec	    hex	filename
>      28	      0	      0	     28	     1c	foo.o
[]
> So, it's shorter.

No worries.

I was kinda surprised the object code wasn't identical anyway.

cheers, Joe
