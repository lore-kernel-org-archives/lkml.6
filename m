Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EA0C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3891A272D9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3891A272D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753664AbeF1LpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 07:45:16 -0400
Received: from smtp1.de.adit-jv.com ([62.225.105.245]:56272 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750802AbeF1LpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 07:45:15 -0400
X-Greylist: delayed 333 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jun 2018 07:45:15 EDT
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 53B413C015C;
        Thu, 28 Jun 2018 13:39:40 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nKkzd3NgLGpN; Thu, 28 Jun 2018 13:39:33 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id DA6493C0162;
        Thu, 28 Jun 2018 13:39:33 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.399.0; Thu, 28 Jun
 2018 13:39:33 +0200
Date:   Thu, 28 Jun 2018 13:39:30 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
CC:     Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Daniel Mack <zonque@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Robert Baldyga <r.baldyga@samsung.com>,
        Peter Chen <peter.chen@nxp.com>,
        Christoph Hellwig <hch@lst.de>,
        Eugeniu Rosca <rosca.eugeniu@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Joshua Frkuska <joshua_frkuska@mentor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] Fix issues in UAC2 gadget driver
Message-ID: <20180628113930.GA8176@vmlxhi-102.adit-jv.com>
References: <20180621152252.8313-1-erosca@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180621152252.8313-1-erosca@de.adit-jv.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

Friendly reminder. May I have some feedback on the shared USB fixes?

Best regards,
Eugeniu.

On Thu, Jun 21, 2018 at 05:22:45PM +0200, Eugeniu Rosca wrote:
> Hello Felipe and linux-usb community,
> 
> This is a collection of UAC fixes, some of which have been written back
> in 2016 on top of v3.14. v4.13-rc1 commit eb9fecb9e69b ("usb: gadget:
> f_uac2: split out audio core") made forward-porting of these patches to
> recent kernels quite painful and time-consuming, so we decided to
> re-base them against v4.18-rc1, re-test and share them with community.
> 
> These changes have already undergone internal review, which includes:
> * static analysis:
>  - checkpatch --strict, cppcheck, smatch, sparse, coccicheck, make W=1
> * dynamic testing:
>  - Audio playback on host side and recording on gadget side, where the
>    latter is RCAR Gen3 Salvator-X arm64 target and the former is a
>    Ubuntu PC or an appropriate USB port on the same RCAR target.
>    The kernel was compiled with and w/o KA/UB sanitizers.
> 
> The "older" patches actually live in real Customer products.
> 
> Thank you in advance for any feedback/review comments.
> 
> Best regards,
> Eugeniu.
> 
> Contributors (auto-generated by git)
> 
> Andreas Pape (1):
>   usb: gadget: f_uac2: disable IN/OUT ep if unused
> 
> Eugeniu Rosca (2):
>   usb: gadget: f_uac2: fix error handling in afunc_bind (again)
>   usb: gadget: u_audio: fix pcm/card naming in g_audio_setup()
> 
> Joshua Frkuska (1):
>   usb: gadget: u_audio: update hw_ptr in iso_complete after data copied
> 
> Vladimir Zapolskiy (3):
>   usb: gadget: u_audio: remove caching of stream buffer parameters
>   usb: gadget: u_audio: remove cached period bytes value
>   usb: gadget: u_audio: protect stream runtime fields with stream
>     spinlock
> 
>  drivers/usb/gadget/function/f_uac2.c  | 216 ++++++++++++++++++++------
>  drivers/usb/gadget/function/u_audio.c |  88 ++++-------
>  2 files changed, 205 insertions(+), 99 deletions(-)
> 
> -- 
> 2.17.0
> 
