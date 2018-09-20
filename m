Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1A0ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C1321531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C1321531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732949AbeITUig convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:38:36 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:59531 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbeITUig (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:5:1>);
        Thu, 20 Sep 2018 16:38:36 -0400
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Thu, 20 Sep 2018 08:54:45 -0600
Message-Id: <5BA3B4B202000078001EA517@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.2 
Date:   Thu, 20 Sep 2018 08:54:42 -0600
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Jason Andryuk" <jandryuk@gmail.com>
Cc:     "xen-devel" <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH] xen: Make XEN_BACKEND selectable by
 DomU
References: <20180920143237.10000-1-jandryuk@gmail.com>
In-Reply-To: <20180920143237.10000-1-jandryuk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 20.09.18 at 16:32, <jandryuk@gmail.com> wrote:
> --- a/drivers/xen/Kconfig
> +++ b/drivers/xen/Kconfig
> @@ -101,8 +101,7 @@ config XEN_DEV_EVTCHN
>  
>  config XEN_BACKEND
>  	bool "Backend driver support"
> -	depends on XEN_DOM0
> -	default y
> +	default y if XEN_DOM0

Why not the simpler "default XEN_DOM0"?

Jan


