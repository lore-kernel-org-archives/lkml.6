Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF29BC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98DC32238F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98DC32238F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbeHIW0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 18:26:05 -0400
Received: from smtprelay0149.hostedemail.com ([216.40.44.149]:54371 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726931AbeHIW0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 18:26:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id D562952B7;
        Thu,  9 Aug 2018 19:59:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: feet03_71c4c409a994d
X-Filterd-Recvd-Size: 1526
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Thu,  9 Aug 2018 19:59:41 +0000 (UTC)
Message-ID: <d7334c13f85c0fe7e4abd2154bcdf693269e2353.camel@perches.com>
Subject: Re: [PATCH 3/5] staging: rtl8188eu: use is_multicast_ether_addr in
 rtw_xmit.c
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 09 Aug 2018 12:59:40 -0700
In-Reply-To: <20180809194642.p7ruiwap5fufno35@mwanda>
References: <20180809170131.29279-1-straube.linux@gmail.com>
         <20180809170131.29279-3-straube.linux@gmail.com>
         <e1c49e8a5c93b07542899f1e8b238a70ec89801b.camel@perches.com>
         <d1f2ab32-ff10-9575-ad61-0286ee3811ae@gmail.com>
         <cf3e257702a93e4fcfab666e42e49f363eb447f7.camel@perches.com>
         <6da72965-8228-46bf-9c5b-981d761836bb@gmail.com>
         <a640bab5-af3e-6d65-e34c-1dbcdaa9851a@gmail.com>
         <20180809194642.p7ruiwap5fufno35@mwanda>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-09 at 22:46 +0300, Dan Carpenter wrote:
> On Thu, Aug 09, 2018 at 09:44:54PM +0200, Michael Straube wrote:
> > Is the memory pointed to by sk_buff->data (always) __aligned(2) ?
> Yes.

Yup.

It's actually set by ARCH_KMALLOC_MINALIGN,
which is normally 8.

