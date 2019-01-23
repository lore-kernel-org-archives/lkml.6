Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB12C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE5820870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="guvo7xyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfAWKF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:05:29 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44166 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbfAWKF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:05:27 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so838304pgr.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 02:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vJtz3hfM+p125zxJRV32uw+CMJlXl4S2cS6zvFBDMv0=;
        b=guvo7xyVefd0sNCIzYE1h+ha+rSDHAacMj10/CfEY9pVdrdXLRclTQuITvG+9YfMHq
         3LjqVFF7xivWs2KgBnSAjJiS4h3L75ae78wDs52oIht65C7oRohrfu0fxGFvZVzM7uxA
         oVNJ4wAn96giUBnCXmvCPEDXp2Y86DTcH5t3ZQ7eLJxe7QYa+lEmEAwU8mPRkUqVPe/w
         TBuaz1vSEPy5h7mUua2z73cIPqv6kqpo278hFyLT077vCejuiXH6XWQ0k21xmkfxElZo
         nmxD/UXHSZRTcrWtGQlQ6BeAArehsB9ldN1vPbR+Uw0wgTtdlSRIGHeSFZbOPMpP4HFu
         aGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vJtz3hfM+p125zxJRV32uw+CMJlXl4S2cS6zvFBDMv0=;
        b=sd0CsyHrb7b//74bt3yfyXyanf/2azHyO/g08XYavuJ5OeRh0OJGvRxywOKePJ6tGe
         dONfef5z4iZirZN//xrVkpuh0n6wkXBW+6KhYIjxRMWGPJ3dw+cm1QE8ggmFjbpM4nX5
         eOvMEZqabKh4bqwpZ7cxK77z5mGCjt1YMrG1L/fQwjeeg3LxqBYMuBUOROc4zokpa+0W
         YZWZFea+ZWD2LXzzF4UGxZoz2dYCrdzbbLJXeet+6D0amDw2rZJlYAyBbGC/Un6/1sal
         aKE7twGfEA6Z/5Z5D/nwI+AIQpzkIZzt48tNpX1nwRgAM/qGkqZC5EZ7bP165pgCEuTY
         fjZQ==
X-Gm-Message-State: AJcUukednqa/5sZlBD3Qdotx8CG3vBI1O6PX5u2uIS7FNK9N7NddIhum
        L063vYnPb7U1LpHti7+H+6mm3Q==
X-Google-Smtp-Source: ALg8bN4hCMrh72Cc2vi3SHRTR59WGj31TZ72MwOKeM0dBGcWDkbWYlN9aNjQ3TyxOo4CjdCvop6BqA==
X-Received: by 2002:a63:2b82:: with SMTP id r124mr1401626pgr.300.1548237926793;
        Wed, 23 Jan 2019 02:05:26 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id k15sm28312389pfb.147.2019.01.23.02.05.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 02:05:26 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id A88D0301A3F; Wed, 23 Jan 2019 13:05:21 +0300 (+03)
Date:   Wed, 23 Jan 2019 13:05:21 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Cao jin <caoj.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH] x86/boot: save several bytes in decompressor
Message-ID: <20190123100521.wv6tzar5mzyraoqn@kshutemo-mobl1>
References: <20190123100014.23721-1-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123100014.23721-1-caoj.fnst@cn.fujitsu.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 06:00:14PM +0800, Cao jin wrote:
> gdt64 represents the content of GDTR under x86-64, which actually needs
> 10 bytes only, ".long" & ".word" is superfluous.
> 
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
