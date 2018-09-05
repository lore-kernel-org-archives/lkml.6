Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A65C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7432077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4kSnlCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7432077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeIEXVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:21:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37529 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbeIEXVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:21:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so8732742wrr.4;
        Wed, 05 Sep 2018 11:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KBCNhzZ/1y0IZLrCq0CnyykiG7DxAhHQkX9wokbODak=;
        b=D4kSnlCDx21MwMNAcDuLvmECDjyGGNo7evGPnx/TRlbhRO2J4MFYGH5XZOBzF1Qq/v
         Im9Drail4gnjzp/G68NwXc2LjaiOPlqxx6jyWOeKeL9bY7MZ5cmyLn6wAFaDw/SJ+rQf
         4XYlBR+OlMu2MzfaO/2L0qqhl3pDYMULrwAYS/TAJyejj45z1RDYtJBXhLMxDwJLAXmu
         a4433BN2vs3cTtFnOvWrizvIrJCSBRUFXIsCwfki71ikFn7HcuN55piK/0PQF3+1/zjV
         HELLvXz3PFYDxiuGr/j4+n//XpDbkhHIbPTmJ0GuRuqFtT3FseKwDHUZO9CrmECsCp5J
         HwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KBCNhzZ/1y0IZLrCq0CnyykiG7DxAhHQkX9wokbODak=;
        b=CULp9VYs7vN3JDUe8pfuDANtCpZ4cN1tdLu79nyAkTtrF7EbJ5XIe9pDnOpRErg2xv
         3rFuvcxtkjjIVzfeLJ869nL7lSmIrGS/VTZ7vG3jZs+UnDDtyQAl9HSJ+T7cg8C1YqpR
         5rSJEl+lqmXBtss0pGAJOae1cJ52XezSfshgv0Zjll+FJH0XVnB2Bo/zSO+gMjn5Hu6f
         idjALQg0Ml+j7aTH+QlM5AxTwE0v3mwkvwPZPbLgbgGd80/Lo8NHHCIKbTiHkBdKPj1L
         AYSnLJ25Lez+XJbPPOyFBbENwkGvxgo7vnhcvlYr5t7lJnta1cNg3hFWyWSOOtc/AEzZ
         HXLg==
X-Gm-Message-State: APzg51CpSclKAFf2xWILiC3nHfB9Smhot7kANtILRfE3IxWBgYiLSjf2
        62YnrsYccMNRdTLXYYx0bcI=
X-Google-Smtp-Source: ANB0VdbUBgGbYVy8fHq6POCH5mAEnJrUb+trxfS1qH0W7IrraPbDI/cECQfkngA1eABY2UlRu+zP6Q==
X-Received: by 2002:adf:a4d1:: with SMTP id h17-v6mr26380121wrb.167.1536173416372;
        Wed, 05 Sep 2018 11:50:16 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id m68-v6sm5140706wmb.10.2018.09.05.11.50.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 11:50:15 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
X-Google-Original-From: Florian Fainelli <fainelli@broadcom.com>
Subject: Re: [PATCH 4.9 52/66] Revert "perf tests: Decompress kernel module
 before objdump"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>
Cc:     stable@vger.kernel.org,
        Pavlos Parissis <pavlos.parissis@gmail.com>,
        Lei Chen <chenl.lei@gmail.com>,
        Maxime Hadjinlian <maxime.hadjinlian@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Wang Nan <wangnan0@huawei.com>, kernel-team@lge.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20180417155648.152933169@linuxfoundation.org>
Openpgp: preference=signencrypt
Autocrypt: addr=fainelli@broadcom.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <eff5b3dd-5a43-a424-d32d-b9065fd6424c@broadcom.com>
Date:   Wed, 5 Sep 2018 11:50:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180417155648.152933169@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/2018 08:59 AM, Greg Kroah-Hartman wrote:
> 4.9-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> This reverts commit 7525a238be8f46617cdda29d1be5b85ffe3b042d which is
> commit 94df1040b1e6aacd8dec0ba3c61d7e77cd695f26 upstream.
> 
> It breaks the build of perf on 4.9.y, so I'm dropping it.

Sorry to hijack this thread, I was not able to find the original email
when the offending patch was included in 4.1.52. So kernel 4.1.52 also
has the same problem, can you push a 4.1.53 tag with that patch reverted
as well?

Thank you!

> 
> Reported-by: Pavlos Parissis <pavlos.parissis@gmail.com>
> Reported-by: Lei Chen <chenl.lei@gmail.com>
> Reported-by: Maxime Hadjinlian <maxime.hadjinlian@gmail.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Wang Nan <wangnan0@huawei.com>
> Cc: kernel-team@lge.com
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  tools/perf/tests/code-reading.c |   20 +-------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)
> 
> --- a/tools/perf/tests/code-reading.c
> +++ b/tools/perf/tests/code-reading.c
> @@ -224,8 +224,6 @@ static int read_object_code(u64 addr, si
>  	unsigned char buf2[BUFSZ];
>  	size_t ret_len;
>  	u64 objdump_addr;
> -	const char *objdump_name;
> -	char decomp_name[KMOD_DECOMP_LEN];
>  	int ret;
>  
>  	pr_debug("Reading object code for memory address: %#"PRIx64"\n", addr);
> @@ -286,25 +284,9 @@ static int read_object_code(u64 addr, si
>  		state->done[state->done_cnt++] = al.map->start;
>  	}
>  
> -	objdump_name = al.map->dso->long_name;
> -	if (dso__needs_decompress(al.map->dso)) {
> -		if (dso__decompress_kmodule_path(al.map->dso, objdump_name,
> -						 decomp_name,
> -						 sizeof(decomp_name)) < 0) {
> -			pr_debug("decompression failed\n");
> -			return -1;
> -		}
> -
> -		objdump_name = decomp_name;
> -	}
> -
>  	/* Read the object code using objdump */
>  	objdump_addr = map__rip_2objdump(al.map, al.addr);
> -	ret = read_via_objdump(objdump_name, objdump_addr, buf2, len);
> -
> -	if (dso__needs_decompress(al.map->dso))
> -		unlink(objdump_name);
> -
> +	ret = read_via_objdump(al.map->dso->long_name, objdump_addr, buf2, len);
>  	if (ret > 0) {
>  		/*
>  		 * The kernel maps are inaccurate - assume objdump is right in
> 
> 


-- 
Florian
