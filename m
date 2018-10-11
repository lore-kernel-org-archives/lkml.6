Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0D1C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606172075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sBvqxrjl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 606172075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeJLDK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:10:57 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36388 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeJLDK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:10:57 -0400
Received: by mail-lj1-f195.google.com with SMTP id p89-v6so9341351ljb.3;
        Thu, 11 Oct 2018 12:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SSUi+Av98L3TIMFLKlsYUKvJrp+c1yJsOo0BGDnNQ7A=;
        b=sBvqxrjl8n/UYUHGlt9TvxMa4gvkn5GtpUjZimsHgeCuYMOUj49JiKJH0/8hUqSOJj
         mgIYeYogyHMbB1k/aR3wcFiacETgFQrQQ6BPTZwLHBhAzTyDupJycN88nsonPbN/yRG2
         +QUEic469CIebUtb7H/X9Fv6p3RcEDmhKvMHl/B7Lc0rHr33T6HIDcoSkRxUxMVTFm72
         yHyMLy4u4oKGFXOmKnDt2Y6v4NVryZcOdjAnGeuDCx+6/Cy+38i7EIx4fV/VmzF7RIdS
         c8E99/Qqi5IkoY7zqmo0MnajzQlh7oYyuQ48b65vG4reZEDo0QLEIWEoQ4xTpZmls2L5
         nVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SSUi+Av98L3TIMFLKlsYUKvJrp+c1yJsOo0BGDnNQ7A=;
        b=j+OpCXWamFwkZJIdIp+0ED4nS1z30Pevf7rlme9H65ni03NiNryDvoZvP/IVIsGQAK
         ySTkqr5Ubp1TsjPetDYgXQQuXWUOi+yfKEAblbgs6MN1Fey5XnQ3c9sFHbH6MVSBuCRs
         jp+W+iBkomABZIwpzXHGJzWgT/L4WcsU0nTkOfTE5hYxzJ4ZsqxCzXLWALrZfg/agx8p
         TJdSaU7AWbV4ZJG7Rj43P168boR577S4W59v0lZldPe2arQhcywaK4z0ViOYAcTIrDbZ
         /1Hdp0f72U09f8YAB12mrdaydOUeFg0lZVqFVMWLIFkKr3Eyo8yxLKB5DwViNNDdMjoA
         ryFw==
X-Gm-Message-State: ABuFfoiwBRHpq+eXjfiYYlBUKyRsscQckM/NPMGN9XvckaNyTheBzJ0K
        liavF83DrnM3WzaTQJAr6EY=
X-Google-Smtp-Source: ACcGV63/aZ+/cXerikPJ9t+1V1EGnBf636MTDJpeLsrSDNureGTISXBV/l8qW7DMzCIVvJ71zFyZ+A==
X-Received: by 2002:a2e:458b:: with SMTP id s133-v6mr2268633lja.60.1539286931982;
        Thu, 11 Oct 2018 12:42:11 -0700 (PDT)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id f73-v6sm5932876lfl.80.2018.10.11.12.42.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 12:42:11 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 5074246072D; Thu, 11 Oct 2018 22:42:10 +0300 (MSK)
Date:   Thu, 11 Oct 2018 22:42:10 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc:     linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org, adobriyan@gmail.com
Subject: Re: [PATCH] proc: fix proc-self-map-files selftest for arm
Message-ID: <20181011194210.GD2401@uranus.lan>
References: <20181011184359.15627-1-rafael.tinoco@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
> +
>  	if (p == MAP_FAILED) {
>  		if (errno == EPERM)
>  			return 2;

As far as I remember nil virtual address has been there only to be sure the
vma allocated won't be merged with another vmas. Fore sure most of x86
standart application won't be using 8K address as well, so should do the
trick I think.

(Strictlly speaking the test should be rather parsing own maps first and
 find unused address instead but whatever :)

Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
