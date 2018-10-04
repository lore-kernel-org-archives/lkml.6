Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64C7C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E882084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E882084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbeJEBFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:05:25 -0400
Received: from smtprelay0063.hostedemail.com ([216.40.44.63]:40866 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727691AbeJEBFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:05:25 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave03.hostedemail.com (Postfix) with ESMTP id B76DC180A6069
        for <linux-kernel@vger.kernel.org>; Thu,  4 Oct 2018 18:11:00 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 100F2181D340F;
        Thu,  4 Oct 2018 18:11:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: quilt86_5fe0ea6e38658
X-Filterd-Recvd-Size: 1960
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Thu,  4 Oct 2018 18:10:58 +0000 (UTC)
Message-ID: <db9a3df1947223f317198f383af6024fe5ee76f4.camel@perches.com>
Subject: Re: [PATCH 2/3] staging: rtl8188eu: cleanup array declaration -
 style
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Thu, 04 Oct 2018 11:10:57 -0700
In-Reply-To: <e2c8ffb7-4c62-8da9-9f78-00edb4edcb5e@gmail.com>
References: <20181003204359.30676-1-straube.linux@gmail.com>
         <20181003204359.30676-2-straube.linux@gmail.com>
         <223920513380c40710a833be02d86d8d6258cdab.camel@perches.com>
         <e2c8ffb7-4c62-8da9-9f78-00edb4edcb5e@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-04 at 14:12 +0200, Michael Straube wrote:
> On 10/3/18 11:30 PM, Joe Perches wrote:
>    
> > >   static struct mlme_handler mlme_sta_tbl[] = {
> > 
> > Perhaps const here too, and as well, the struct
> > declaration could use const char * instead of char *
> > 
> 
> Making it const gives following warning.
> 
> drivers/staging/rtl8188eu/core/rtw_mlme_ext.c: In function 'mgt_dispatcher':
> drivers/staging/rtl8188eu/core/rtw_mlme_ext.c:4114:9: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>    ptable = mlme_sta_tbl;

No worries, then it's not appropriate to use const.

It's just most common for this sort of table to be const
but if this driver is reassigning values in the table,
then it can't be const.

It is possible though that the code might not be suitable
for multiple simultaneous instances of the device type.

Dunno.  I don't use it nor have I inspected the code.

