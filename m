Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632ABC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F8920856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547734210;
	bh=5YlUr57zv8XqCa7zf8NOmQ/7h1jqkC+jn2IfErFQcU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lrTqD9YaWxrBbg1vjLtyblTgU/bv3bAIKxyqDQCmlhxUaDETsb0qvw1IIbuQL0K4V
	 /JIDU18NYeVunQxLQRac20cM8JnehaW0WACXKU/ox4ss5AkyMnTPDtA3hVqH71V2dD
	 R16/Bc2UJHK2dL6uM1SP2ImEm/yojjjHqr1TmeD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfAQOKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:10:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbfAQOKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 09:10:08 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E665205C9;
        Thu, 17 Jan 2019 14:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547734207;
        bh=5YlUr57zv8XqCa7zf8NOmQ/7h1jqkC+jn2IfErFQcU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pZKiw3diz+ogHwu2Mf1/Q/zkS4lSulGyHoFaO/i0a21qPx495f+Z2fvXLGvsTybUD
         H+MDXg+w06eil1vENafU3mWVRSnINAxwNux2Mwq2t17o74odSIipN+rsKK9d+ZEEQK
         qZ8pdt+niqdDA0fwL8oCgyf0/3ulG8NPkwkslur0=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0188241AB5; Thu, 17 Jan 2019 11:10:04 -0300 (-03)
Date:   Thu, 17 Jan 2019 11:10:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] perf: remove duplicated include from perf_event.h
Message-ID: <20190117141004.GB5823@kernel.org>
References: <20190117072504.14428-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117072504.14428-1-yuehaibing@huawei.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 17, 2019 at 03:25:04PM +0800, YueHaibing escreveu:
> Remove duplicated include.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  include/linux/perf_event.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 1d5c551..19baf4a 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -53,7 +53,6 @@ struct perf_guest_info_callbacks {
>  #include <linux/atomic.h>
>  #include <linux/sysfs.h>
>  #include <linux/perf_regs.h>
> -#include <linux/workqueue.h>
>  #include <linux/cgroup.h>
>  #include <asm/local.h>
>  
> -- 
> 2.7.0
> 

-- 

- Arnaldo
