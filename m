Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DB6C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8109C206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8109C206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbeH1Ai2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 20:38:28 -0400
Received: from smtprelay0237.hostedemail.com ([216.40.44.237]:51810 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726958AbeH1Ai2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 20:38:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 436DA100E806B;
        Mon, 27 Aug 2018 20:50:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: land23_18293fe8c928
X-Filterd-Recvd-Size: 2091
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Mon, 27 Aug 2018 20:50:10 +0000 (UTC)
Message-ID: <0c3d98ffd218e455eb864fdfd7715af19d43230c.camel@perches.com>
Subject: Re: [PATCH 1/4] iio: gyro: add support for fxas21002c
From:   Joe Perches <joe@perches.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Afonso Bordado <afonsobordado@az8.co>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Mon, 27 Aug 2018 13:50:08 -0700
In-Reply-To: <20180827180805.7d4b9f4e@archlinux>
References: <20180825211910.22929-1-afonsobordado@az8.co>
         <20180827180805.7d4b9f4e@archlinux>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-27 at 18:08 +0100, Jonathan Cameron wrote:
> On Sat, 25 Aug 2018 22:19:07 +0100
> Afonso Bordado <afonsobordado@az8.co> wrote:
> 
> > FXAS21002C is a 3 axis gyroscope with integrated temperature sensor
> > 
> > Signed-off-by: Afonso Bordado <afonsobordado@az8.co>
> 
> Hi,
> 
> Driver is pretty clean so only a few minor comments inline.
> If we were late in a cycle I'd probably just have taken it and fixed up
> but as we have lots of time and I'm inherently lazy I'll let you do a v2 :)
> 
> Good job, thanks!
[]
> > diff --git a/drivers/iio/gyro/fxas21002c.c b/drivers/iio/gyro/fxas21002c.c
[]
> /* ... */
> 
> Please run checkpatch as IIRC it complains about this.

Running checkpatch and paying attention to what it bleats
is generally a good idea, as long as its bleats aren't
mindlessly followed.

And c99 style // comments have been ignored since:

commit dadf680de3c2eb4cba9840619991eda0cfe98778
Author: Joe Perches <joe@perches.com>
Date:   Tue Aug 2 14:04:33 2016 -0700

    checkpatch: allow c99 style // comments
    
    Sanitise the lines that contain c99 comments so that the error doesn't
    get emitted.

