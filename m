Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE28C67837
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8A42075B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQJWVtDp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8A42075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbeJLEZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 00:25:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34931 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbeJLEZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 00:25:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id w5-v6so11176733wrt.2;
        Thu, 11 Oct 2018 13:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fg+CN/dzACMuXytyg7G7bLZ//PjBQZAAjHDxsioR8WQ=;
        b=WQJWVtDpABXBB3k3hADTdvEXfLgoCYl+HOiu3x9SLovnRJfs3WT8cKjlc3gnQb+Yqy
         xxe47oYhhwpVxPfsVWrXHG4nEFWC97NYKmRo6qX//Xn+0vR5gMj0KgHVSacxbG0kGtIO
         RpjVntJ71D/Qu88cQTdoxpu9EEDk5N+gz3+2zwK+xE2KM9dcqoapbolWnKFWfe21YfXD
         UY9aQ8XUCtcociusAj+Wbcq2jx+2O/6EA4MiwABuq68E5uRYxktFa4oO7X6Z7WMJfig2
         LJGCSDwzGqnavZ9vs9wVX/L9JXbsA+JVQfd6+1vjLY+m/7fooFpBtt0Lqty9hR+SNcsi
         01IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fg+CN/dzACMuXytyg7G7bLZ//PjBQZAAjHDxsioR8WQ=;
        b=qr/OmScWAXpD3lqoyiQC2F+RzedAFPQNgfTyP7HOoAeMhpHnFxtU6BF3b9SWDLzPJx
         z/WkcQ2oBDOniPJ5libTofxhNGSufa7CEeDgXMBNxEKdLYJ4ELZJPiR7VATpPfpxmz38
         lKk6cM7S7dFZDMLLoZkw8slIotvy7v9hyFCX3LppqTJVRej+34wTVeaJtl5rzqHlyW6l
         I6jTOAQrCPWr2EfupWniOwPxZOMpS29UR3JfB7oIun2bKq4RbwyFa6Q9oRfiBFVYEGnh
         0ZvxXfBa0vcRc13+n7NthB2x013v1dhUYZ9GEVMV+vd02+Ssk5KWPr3hAp98WlRYypSM
         c1nA==
X-Gm-Message-State: ABuFfogu1IV6pCF08weO07GfRHNNFiZqlZS5v6iCYUCVZgY99lJ9hzzz
        AJDaG3aC9QvbROJhXoSw4Q==
X-Google-Smtp-Source: ACcGV60GUuDyKjhb/nnywdVCxfPktSQykhEaMXr02svm8v50J49rfcghmvRTZhlZicDdaZJ0BapAnQ==
X-Received: by 2002:a05:6000:12c5:: with SMTP id l5mr2844206wrx.215.1539291365150;
        Thu, 11 Oct 2018 13:56:05 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id 201-v6sm21946138wmf.30.2018.10.11.13.56.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 13:56:04 -0700 (PDT)
Date:   Thu, 11 Oct 2018 23:56:01 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc:     linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, gorcunov@gmail.com,
        akpm@linux-foundation.org, shuah@kernel.org
Subject: Re: [PATCH] proc: fix proc-self-map-files selftest for arm
Message-ID: <20181011205601.GA32757@avx2>
References: <20181011184359.15627-1-rafael.tinoco@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181011184359.15627-1-rafael.tinoco@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 03:43:59PM -0300, Rafael David Tinoco wrote:
> MAP_FIXED is important for this test but, unfortunately, lowest virtual
> address for user space mapping on arm is (PAGE_SIZE * 2) and NULL hint
> does not seem to guarantee that when MAP_FIXED is given. This patch sets
> the virtual address that will hold the mapping for the test, fixing the
> issue.
> 
> Link: https://bugs.linaro.org/show_bug.cgi?id=3782
> Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
> ---
>  tools/testing/selftests/proc/proc-self-map-files-002.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/proc/proc-self-map-files-002.c b/tools/testing/selftests/proc/proc-self-map-files-002.c
> index 6f1f4a6e1ecb..0a47eaca732a 100644
> --- a/tools/testing/selftests/proc/proc-self-map-files-002.c
> +++ b/tools/testing/selftests/proc/proc-self-map-files-002.c
> @@ -55,7 +55,9 @@ int main(void)
>  	if (fd == -1)
>  		return 1;
>  
> -	p = mmap(NULL, PAGE_SIZE, PROT_NONE, MAP_PRIVATE|MAP_FILE|MAP_FIXED, fd, 0);
> +	p = mmap((void *) (2 * PAGE_SIZE), PAGE_SIZE, PROT_NONE,
> +			MAP_PRIVATE|MAP_FILE|MAP_FIXED, fd, 0);

As the comment in the beginning says this test is specifically for addresss 0.
Maybe it should be ifdeffed with __arm__ then.
