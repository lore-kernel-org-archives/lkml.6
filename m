Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BFAC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986CC2087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uIPECjwy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986CC2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbeJEUZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 16:25:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40055 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbeJEUZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 16:25:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id s5-v6so5086442pfj.7;
        Fri, 05 Oct 2018 06:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UqUL9SkpdJz9RMWiehPVKTpihQd+cH0u1dIADWyIUYc=;
        b=uIPECjwyICsYfVHlBsBAmw3FzqEaxWMs3feoxEhwlDDOIFCSEZIUPg4wQY96HcRxur
         tVzxAwiinxN/L/N9inR/RwUZBup1Vb4/TLq5eX2tDYJzl+RKrTRoO+5HcwFwpc9sloFf
         y3y6vC/kVeZ0ZQUJW5Dv3HME5x9cHb7UFuYkkHex8AbFa+iQyI7h304OIzCpNNflHwvL
         2FMzgQ0iQJkFReTscHJX6rOCRoJKrd8zhpqJA99hMZiR8OOK51ZmBZMTfs9q8ojjRqeP
         DL9qYIs+vJmvOL8qYILQ8VGcMYACXtwoif28/JpSs4Xh7vK//XRdXuLEa2N+xh4giUCd
         rNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UqUL9SkpdJz9RMWiehPVKTpihQd+cH0u1dIADWyIUYc=;
        b=QbWD9A8RPsizT6LW5l/Am2RWZ9HWsv0M9ru84Bx5HpKYBPr7V/B67eMwWG1Tiz7LFr
         adNmteSgNXasWFWvIDXfBYrVPe6NdsYjUYXPODaHU1C0UzQRuTkMRHwBLk6xTRt/bnJv
         a5mZbYfnyDDB0kGPifGGJzWZmKP0zg7pfjMotWjJk2f8etfu7UetzoJOQKYWhM1zwBBV
         O2lA701H5/HtxzAVtOihzRBVCFl2FbSnZRvtIt7I7KPvMF+MQ8ooboCdK/QZtt10gtrA
         5u182KMfwKzrZqNm/2j/KQaPWtGQeynghwwyPflNR7YXyRSucBFAO9RJxko5ebvaPDQL
         yPeg==
X-Gm-Message-State: ABuFfojlX6Pnh7j3wAWFj8bJLeHOGxfev/pGFFMaR8ocAw4Um2rh2MhP
        WJNOnViXFnAKKo+M9ApLa1vnryMa
X-Google-Smtp-Source: ACcGV62Qd2brmznz6MFZ8e7pmOtgaouZpKNpf+oknrajkwogtA+t1wNZRRVtOfv0rEAwmLtQkg1KhQ==
X-Received: by 2002:a63:1148:: with SMTP id 8-v6mr10397630pgr.172.1538745985550;
        Fri, 05 Oct 2018 06:26:25 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id n80-v6sm14580331pfh.166.2018.10.05.06.26.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 06:26:24 -0700 (PDT)
Subject: Re: [PATCH 15/16] of: unittest: initialize args before calling
 of_irq_parse_one()
To:     frowand.list@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
 <1538712767-30394-16-git-send-email-frowand.list@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <7fc4b9da-5fdf-11c9-e168-ccb2d960adea@roeck-us.net>
Date:   Fri, 5 Oct 2018 06:26:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538712767-30394-16-git-send-email-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2018 09:12 PM, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Callers of of_irq_parse_one() blindly use the pointer args.np
> without checking whether of_irq_parse_one() had an error and
> thus did not set the value of args.np.  Initialize args to
> zero so that using the format "%pOF" to show the value of
> args.np will show "(null)" when of_irq_parse_one() has an
> error and does not set args.np instead of trying to
> dereference a random value.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

The same problem exists when of_parse_phandle_with_args() reports an error.

Guenter

> ---
>   drivers/of/unittest.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index 6d80f474c8f2..b61a33f30a56 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -780,7 +780,7 @@ static void __init of_unittest_parse_interrupts(void)
>   	for (i = 0; i < 4; i++) {
>   		bool passed = true;
>   
> -		args.args_count = 0;
> +		memset(&args, 0, sizeof(args));
>   		rc = of_irq_parse_one(np, i, &args);
>   
>   		passed &= !rc;
> @@ -801,7 +801,7 @@ static void __init of_unittest_parse_interrupts(void)
>   	for (i = 0; i < 4; i++) {
>   		bool passed = true;
>   
> -		args.args_count = 0;
> +		memset(&args, 0, sizeof(args));
>   		rc = of_irq_parse_one(np, i, &args);
>   
>   		/* Test the values from tests-phandle.dtsi */
> @@ -854,6 +854,7 @@ static void __init of_unittest_parse_interrupts_extended(void)
>   	for (i = 0; i < 7; i++) {
>   		bool passed = true;
>   
> +		memset(&args, 0, sizeof(args));
>   		rc = of_irq_parse_one(np, i, &args);
>   
>   		/* Test the values from tests-phandle.dtsi */
> 

