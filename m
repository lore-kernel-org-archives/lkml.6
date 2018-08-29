Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04BDC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5438320867
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="w/IznCFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5438320867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbeH2PqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 11:46:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34989 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2PqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 11:46:18 -0400
Received: by mail-pl1-f196.google.com with SMTP id d9-v6so2189136plr.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 04:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EL7aFD6cPEpxZIZf+W5OUZZPGRkYzvzQK24Iw9DPs2I=;
        b=w/IznCFIOC2PcHTTnKQkORXjgVPPSN+omO66V9X8vmQe5YTDFUrX9nLcbEZGwmqEa7
         cfN/wPOCHIEeIAyNWijJRBVXLk+k5Q8/BX1m1DeRSyKJt+qJPoecx1Mwm5XgCk+Lw7KY
         5jpYjZg1TBjtq9aq2PG0TAxd24bCAUG6lPwDjvkrrp+8jmdK5cdMdC98Z4kEBVXD1r2o
         bDXJ9TpvXTp/HrFvvZxSw6Pm8kS2olL4tQvqgOes9q3iqMqf9eNxw3aeNBt3yBodSLfB
         c4/hlumBub0GeGw6dKxWpaqmMFNPKC8gBj+xYtCF+6qsG3360780AsiRYm26r7KuG/zJ
         qv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EL7aFD6cPEpxZIZf+W5OUZZPGRkYzvzQK24Iw9DPs2I=;
        b=MUKx2Y3m/MUbzGJjy1nJqkXfl16DZXvicYy4jHFWv/+vTxYu+b9MjUFVarlbelINWM
         05lbJsL+rX3U5a+oyCy46/BNSAPn8Ua6ZrNayTOeZvcjI41dJ3Yy6oIHAFTLA6E+8mGY
         QWYd5EPuIdV5PC25+vMaembWnc3FIFchXZtfJ37T9f5/c8q7NWyHHRumD+SVWdepJM64
         1NCVgaYPzBDtyrv4oHgGCqNpf7vrKzuz+iXvFVFVUMI8iptl/xaattg6L+iTeL1gaNGw
         TNvT8NF5Ie619KPL5D6uKo7RJdxNfV1dURJSlYdGoBab1bemmntjorTw8Q+yJWJCH+iU
         0PsQ==
X-Gm-Message-State: APzg51ALAJiFn/ZGqzSvJoWPC3z/Dn7RB1sfAbYVNBJThcbXeKnQ2k0D
        fh2MI8yYj4L2t81gmFQkh1n8vg==
X-Google-Smtp-Source: ANB0VdblLx+g6lFS8Eoi2/b6zoUWTJMoSZDIScXXzRakyFJrCzcxMokLEpP9Ct4aJht53Tifcce+3g==
X-Received: by 2002:a17:902:42a5:: with SMTP id h34-v6mr5770874pld.228.1535543385812;
        Wed, 29 Aug 2018 04:49:45 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id 203-v6sm6340963pgb.14.2018.08.29.04.49.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 04:49:44 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 1AE1E3001A3; Wed, 29 Aug 2018 14:49:40 +0300 (+03)
Date:   Wed, 29 Aug 2018 14:49:40 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Baoquan He <bhe@redhat.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        thgarnie@google.com, kirill.shutemov@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/mm/KASLR: Fix the wrong calculation of kalsr
 region initial size
Message-ID: <20180829114940.k36272hhxa7fznva@kshutemo-mobl1>
References: <20180829021754.21850-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829021754.21850-1-bhe@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 10:17:53AM +0800, Baoquan He wrote:
> In memory KASLR, __PHYSICAL_MASK_SHIFT is taken to calculate the
> initial size of the direct mapping region. This is right in the
> old code where __PHYSICAL_MASK_SHIFT was equal to MAX_PHYSMEM_BITS,
> 46bit, and only 4-level mode was supported.
> 
> Later, in commit:
> b83ce5ee91471d ("x86/mm/64: Make __PHYSICAL_MASK_SHIFT always 52"),
> __PHYSICAL_MASK_SHIFT was changed to be 52 always, no matter it's
> 5-level or 4-level. This is wrong for 4-level paging. Then when
> adapt phyiscal memory region size based on available memory, it
> will overflow if the amount of system RAM and the padding is bigger
> than 64TB.
> 
> In fact, here MAX_PHYSMEM_BITS should be used instead. Fix it by
> by replacing __PHYSICAL_MASK_SHIFT with MAX_PHYSMEM_BITS.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
