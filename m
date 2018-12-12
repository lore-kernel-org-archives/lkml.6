Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6314EC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1978020811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="AgoLzZSb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1978020811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbeLLTEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 14:04:09 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40835 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbeLLTEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 14:04:08 -0500
Received: by mail-qt1-f193.google.com with SMTP id k12so21722246qtf.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 11:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=6W5yTdyAwVMfku+FcLlPD2DPto1M6P4yLf16sK5e4sg=;
        b=AgoLzZSbk25K4PvijSOCzLdia6op741JwqMT6mRO2jSrWakI8F+aVlNtH6i3AvZKzn
         hgdI5ZpV7tbxnu1fi/JODsdO6wECdzegVRJrHcStPpHXVCjztrTL+AVlHyiRtrQGz5QU
         BCxhU80OvhVq0Lp0K69NRcW5jj+FwkSlwjPay67lSKbYEIkWQX0OT1uZhQjo02M/+Hf6
         pNaePNkP86BNL01L+gvQlnNVnTgSdS2oDGiLReU9029gjEmXl1uQudhmewdVp2fkVXkD
         Jb7OcHgxUB4v2XfPHERlrpUoTA79usvs5TCtfDfAhU7mJ/iCrlR1LTPjC7y+w/WQdPL5
         ViLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=6W5yTdyAwVMfku+FcLlPD2DPto1M6P4yLf16sK5e4sg=;
        b=oBx+KD41vENkkihponYMPol9s7jqVJVeAfu2idjKx1IIfy8UHnJ7oh8W2nuYIXhHdb
         iiAWmgeUKqQJuD78m1QySBtEx2+XKefp7Su85D71xlhIkc83tVFBzatGYpQ9EYjPM7kU
         q3+bypyk2IF2CdOpulfsidRZSfj9JE86zCvjJTjTdmftV1ieQOLmNgTOo9sDUcULL0BS
         2M/nQhAL81F7L2nb8Qf9LpO7iAP8RJV95X/w+AyR8on3QLoGdQT5k/wQOmK7r6QN1CuR
         VJiMXEZ/XTgaKCZ7Sckvr76Fmxd8UZv2aHt6VinPvZf7oKRbqICI+PrVya0vqWOI/KJu
         rFCQ==
X-Gm-Message-State: AA+aEWboOSQ/3Igkp2chnUlobt7edQviUa+Uk3CpzeKWEeT5iJMb7Evk
        /njamJ7dRFvsWCt0hGGft5aT5A==
X-Google-Smtp-Source: AFSGD/U5uCYAxf1/cRrLEZY2d4czMoxmhEPwNeG5hTZnL/WF7+IH9Gw6LQnt2czEspk+VlMAxhBRGw==
X-Received: by 2002:aed:2cc4:: with SMTP id g62mr12964672qtd.192.1544641447624;
        Wed, 12 Dec 2018 11:04:07 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id e26sm11659241qtg.69.2018.12.12.11.04.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 11:04:07 -0800 (PST)
Date:   Wed, 12 Dec 2018 11:04:04 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Alice Ferrazzi <alice.ferrazzi@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] selftest/bpf: remove redundant parenthesis
Message-ID: <20181212110404.2e211ef1@cakuba.netronome.com>
In-Reply-To: <20181211115607.13774-7-alice.ferrazzi@gmail.com>
References: <20181211115607.13774-1-alice.ferrazzi@gmail.com>
        <20181211115607.13774-7-alice.ferrazzi@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018 20:56:06 +0900, Alice Ferrazzi wrote:
> Signed-off-by: Alice Ferrazzi <alice.ferrazzi@gmail.com>
> ---
>  tools/testing/selftests/bpf/test_offload.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_offload.py b/tools/testing/selftests/bpf/test_offload.py
> index 0f9130ebfd2c..b06cc0eea0eb 100755
> --- a/tools/testing/selftests/bpf/test_offload.py
> +++ b/tools/testing/selftests/bpf/test_offload.py
> @@ -140,7 +140,7 @@ def cmd_result(proc, include_stderr=False, fail=False):
>  
>  
>  def rm(f):
> -    cmd("rm -f %s" % (f))
> +    cmd("rm -f %s" % f)
>      if f in files:
>          files.remove(f)
>  

Is this in PEP8, too?
