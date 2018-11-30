Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB91C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565262146F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 565262146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbeK3Oik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 09:38:40 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33600 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeK3Oik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 09:38:40 -0500
Received: by mail-pl1-f193.google.com with SMTP id z23so2096277plo.0;
        Thu, 29 Nov 2018 19:30:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KjeHe8eUk1crL1KhnUad0GdnVkq/dSDy8qq3J8TSfAA=;
        b=SWZAR1MYk7wp1VZ1YHiQoe303KbyZr43CsgdS2678O/0wM6qSlVIa31IV4jlqOr6HZ
         5E6mLJ2LfNSteA/GCpkKSdugHlHH0GXG2jzoY9hRgwCzizm5yVVTdOZw3i9dLlw63UPC
         wTdaYRuSys7snC1YLzWqeKSfPN7nKZ10+0Jhuf+sL8TWtTEcBx0QxwLGNj4WYDWUQ/76
         tBVD9KrTXryiu4cDRBPrqHLNyFRq0NVDM+Srx9XLPwHJ/hgFcSjiV+LCDrFjUhzoAIr0
         5tvFiTxfA+c2/x0pT3iT5jhLa2jbe5jYkv4H11jJ7J+MDqLnxG3XyjkuPIm/ARlsHTrt
         6OZg==
X-Gm-Message-State: AA+aEWYIOK/OGclf0rFWoo7+L0CPmOQ78FTRMFzW3TN6NPlDs/OqfmJi
        GkMiX8iDUQILdoanfzS6NYg=
X-Google-Smtp-Source: AFSGD/Uaa1wxM+NzC/hQ67OWDGpF8L8bM+r+UH/zUZCP9byn+FOG1Y6fuhi9bfYilFpkAhR4MWxkrg==
X-Received: by 2002:a17:902:e18c:: with SMTP id cd12mr3809717plb.279.1543548650775;
        Thu, 29 Nov 2018 19:30:50 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id m67sm7999579pfb.25.2018.11.29.19.30.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 19:30:49 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Thu, 29 Nov 2018 19:30:46 -0800
Date:   Thu, 29 Nov 2018 19:30:46 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     gregkh@linuxfoundation.org, keescook@google.com, shuah@kernel.org,
        joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org, robh@kernel.org,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com, frowand.list@gmail.com,
        knut.omang@oracle.com
Subject: Re: [RFC v3 06/19] arch: um: enable running kunit from User Mode
 Linux
Message-ID: <20181130033046.GI18410@garbanzo.do-not-panic.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-7-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128193636.254378-7-brendanhiggins@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 11:36:23AM -0800, Brendan Higgins wrote:
> Make minimum number of changes outside of the KUnit directories for
> KUnit to build and run using UML.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  Kconfig  | 2 ++
>  Makefile | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Kconfig b/Kconfig
> index 48a80beab6853..10428501edb78 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -30,3 +30,5 @@ source "crypto/Kconfig"
>  source "lib/Kconfig"
>  
>  source "lib/Kconfig.debug"
> +
> +source "kunit/Kconfig"

Since this is all UML why not source it from arch/um/Kconfig instead?

  Luis
