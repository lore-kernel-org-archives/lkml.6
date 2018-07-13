Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0905ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE6120871
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE6120871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbeGMLEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:04:24 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:37410 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727307AbeGMLEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:04:24 -0400
X-IronPort-AV: E=Sophos;i="5.51,347,1526335200"; 
   d="scan'208";a="338772611"
Received: from unknown (HELO hadrien.local) ([38.97.127.241])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2018 12:50:14 +0200
Date:   Fri, 13 Jul 2018 06:50:13 -0400 (EDT)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Himanshu Jha <himanshujha199640@gmail.com>
cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org,
        =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        yamada.masahiro@socionext.com, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH 01/18] coccinelle: change strncpy+truncation to
 strlcpy
In-Reply-To: <20180713102103.GA12972@himanshu-Vostro-3559>
Message-ID: <alpine.DEB.2.20.1807130647460.3063@hadrien>
References: <1531444483-17338-1-git-send-email-asmadeus@codewreck.org> <20180713074455.GA6859@himanshu-Vostro-3559> <20180713080023.GB9638@nautica> <20180713091412.GA11250@himanshu-Vostro-3559> <alpine.DEB.2.20.1807130540270.3044@hadrien>
 <20180713102103.GA12972@himanshu-Vostro-3559>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the file drivers/net/wireless/ti/wl1251/acx.c, the following keeps the
comment before the buf update and moves the strlcpy call below it.  It
does however drop the comment just before the original call to strncpy.

julia


@r@
expression dest, src;
expression f;
@@

- strncpy(dest,src,f);
  dest[f - 1] = '\0'
+ + strlcpy(dest,src,f)
  ;

@@
expression r.dest, r.src;
expression r.f;
@@

- dest[f - 1] = '\0' + strlcpy(dest,src,f);
+ strlcpy(dest,src,f);

