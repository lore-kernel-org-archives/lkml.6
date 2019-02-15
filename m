Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337FCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0182B222DB
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="ty/rwedp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392038AbfBOVRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 16:17:46 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40916 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391989AbfBOVRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 16:17:44 -0500
Received: by mail-pl1-f193.google.com with SMTP id bj4so5530994plb.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 13:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z1uyvqXrQXSc3rwNLm0+e7l6LqHeD5zT+elzxuoWcjk=;
        b=ty/rwedp34mDQEgOzJS45T9dmUZ0GKuG3idqkjg6TLazmQyUlDkINR/cdaEaagBQYt
         4MvkKESa2BPuQS4Op2ZCFtpreOxstdtpStCmHBP6lMIixyqYN/WbNypxWojVPP9gmObH
         hXtcdmBIqOLGqRDu/kdgIRyP2lWO5DPWoC5o8M7hyxlAF1Qn4DMvJoxmEdhcWRTvVBl2
         Njpvlk6shD6M96Itafm4sqs6KiwDSI6mFuSkqNN10U7WjyjroYVuruALp2AKNx2RCGSg
         3blSnsx/ytFuwiGirssZGaKFqFPWVkALYlsJmzOFtah5mbKqQWSLcpCWZMcqXWGcv7Qz
         LGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z1uyvqXrQXSc3rwNLm0+e7l6LqHeD5zT+elzxuoWcjk=;
        b=W0iGxXlEQA4kRPI4rR1crIkWtRw7A0+MVSPPter1tB4aoA+9mBveM44Qhey52logDG
         JpTuitxAP5+NyURvc2wMi3O4SJBZbremkHXynb3JpVZRCAuc4aRmyuDZzUGNi2SiZDmM
         hJlj2MDtgpWZT1GZDxXtKrqMuaJdhx3QzjFkQIJdS0u7k2tERln4iJdxCm1kvKsxUhhm
         HZDRNbulo8AI4zwa8ay+J+T7RGU5uWfBQpg7x4uSdMBljljqAMFcIhlz3b/VYqhaBKKo
         iPDsMI545Oxb5s3gbhXo+WYfYbSYznYIeK4KVqVakgLYgqg7ZSep0I+xatbFBKNEjyAd
         aEIg==
X-Gm-Message-State: AHQUAuYpS4omX/FG9yIvTjcYAX+PxaczpJFQ9LAhvnr9hE5xxboxn+iL
        AVrEnlu9uNh5w/HUQIdnTvgw09WcVKcWlw==
X-Google-Smtp-Source: AHgI3IaeDUcZ2lkAt1807uEGaPCN7vEpWtQa1sFCBcPGSgINsgZanwP8wKQQM33RgHM8iibOZDwLkQ==
X-Received: by 2002:a17:902:7c8a:: with SMTP id y10mr11977436pll.71.1550265464148;
        Fri, 15 Feb 2019 13:17:44 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id w185sm10199147pfb.135.2019.02.15.13.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 13:17:43 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id C13AF3008A8; Sat, 16 Feb 2019 00:17:39 +0300 (+03)
Date:   Sat, 16 Feb 2019 00:17:39 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v2] page cache: Store only head pages in i_pages
Message-ID: <20190215211739.44qnml4uk6vtku5p@kshutemo-mobl1>
References: <20190212183454.26062-1-willy@infradead.org>
 <20190214133004.js7s42igiqc5pgwf@kshutemo-mobl1>
 <20190214224115.4edwl7x72abztajb@kshutemo-mobl1>
 <20190215202056.GK12668@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215202056.GK12668@bombadil.infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 12:20:57PM -0800, Matthew Wilcox wrote:
> On Fri, Feb 15, 2019 at 01:41:15AM +0300, Kirill A. Shutemov wrote:
> >   - __delete_from_swap_cache() will blow up on
> > 
> > 	VM_BUG_ON_PAGE(entry != page + i, entry);
> 
> Right.

Thanks. I think this is the last one I found.

Could you send v3 with all fixups applied?

-- 
 Kirill A. Shutemov
