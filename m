Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AABC6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF962084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPzK0G4l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF962084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbeLKV6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:58:33 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34527 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLKV6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:58:33 -0500
Received: by mail-pg1-f194.google.com with SMTP id 17so7284032pgg.1;
        Tue, 11 Dec 2018 13:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JsizWuxivQwCor4f18/Dzhh5JdhzgqGGUKMUTx0zDIw=;
        b=QPzK0G4lussss1f7j7yBd9IhovSVNXeu0kE4XXlrurIaPgODoNRJL0gSQcMGhBAFNP
         F5t/m1p5iTbAw/yBCPBW+sWXa4HDdFvOlsQQfuco46k2qXqfhs/GD95qtf63DBZCL926
         Od7/TdeDefD93TXph91VrWxyO6TSU/sUR+RYIJcGtfjzef3gbyQGHZgtGmOeezOVn/Bg
         iuuTBedPBY8XmqXZXFHNSBCGMsA5x4uUsdOn4vMgLe/ERqRtch8m4zesnYfCPwc8oMxd
         nf+HA2RJ32rra6On9T4uIrQkPmgGw8lPuccrvbgW7cMq5ByD02ukwAaqlEYWqEdf8vbq
         KeQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JsizWuxivQwCor4f18/Dzhh5JdhzgqGGUKMUTx0zDIw=;
        b=GUY0465A7Jx1xvvmkTjdWOi5kAeCntyX6IWco0fL6HtLewJ2U1H/uR0X6oK6a+YVeF
         N8MME/R8OrNh2eg8Bu/C+B3tiB/0rlljoSU6LAqaAHjqBSFwcjc2D1NjpcOotgl8WHNs
         2oKxSEiSyL/XADuOyocamptdhASWzLmSScfkuLQVrKNWN3loBcpSHZ7gaH3m2Nf+O68F
         lFtrmEiA1wJLW1LCFvF/Gjo2rXUGYM0lYkxMM61X6l4Up2N2zyoWbNk/sKV0pr/9QO3W
         rSzCvwM+YwdX432zeytbL1l8yrKY3sAqLYXYFs/qvVBZqKfITWvK37iSshZODgmNv2NZ
         xihg==
X-Gm-Message-State: AA+aEWZ5Nh1+hXcYBTG+PeHKa+wQfc6QXtUyIgyYJ32mNTjgeEaBEfaw
        I3xVuyTD45v4+UPGU4F7Uw2uvdUB
X-Google-Smtp-Source: AFSGD/W8slIh3kRiCmY5kFUb06t+EqglhUuAg+6xZizNyfzgi4MABJZZr81vZQRohLFaacKwGZYvPw==
X-Received: by 2002:aa7:8354:: with SMTP id z20mr17642302pfm.81.1544565512259;
        Tue, 11 Dec 2018 13:58:32 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id r83sm26342337pfc.115.2018.12.11.13.58.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 13:58:31 -0800 (PST)
Subject: Re: [PATCH] of: add dtc annotations functionality to dtx_diff
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>
References: <1543233669-8696-1-git-send-email-frowand.list@gmail.com>
Message-ID: <deded1fc-1e3c-01b3-1325-51b1636b0b63@gmail.com>
Date:   Tue, 11 Dec 2018 13:58:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543233669-8696-1-git-send-email-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,


On 11/26/18 4:01 AM, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Add -T and --annotations command line arguments to dtx_diff.  These
> arguments will be passed through to dtc.  dtc will then add source
> location annotations to its output.
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> 
> This feature depends upon commit 5667e7ef9a9a ("annotations: add the
> annotation functionality") in the dtc git repository.  To use the

Ping. Your subsequent patch on 11/30, "[PATCH 1/3] scripts/dtc:
Update to upstream version v1.4.7-57-gf267e674d145" adds the required
commit.

-Frank


> new flags before the new version of dtc is imported to the linux
> kernel, download the dtc repository, compile dtc with the make command,
> then add the path of the dtc repository to the shell PATH variable.> 
>  scripts/dtc/dtx_diff | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/dtc/dtx_diff b/scripts/dtc/dtx_diff
> index 8c4fbad2055e..0d8572008729 100755
> --- a/scripts/dtc/dtx_diff
> +++ b/scripts/dtc/dtx_diff
> @@ -21,6 +21,7 @@ Usage:
>          diff DTx_1 and DTx_2
>  
>  
> +      --annotate    synonym for -T
>         -f           print full dts in diff (--unified=99999)
>         -h           synonym for --help
>         -help        synonym for --help
> @@ -28,6 +29,7 @@ Usage:
>         -s SRCTREE   linux kernel source tree is at path SRCTREE
>                          (default is current directory)
>         -S           linux kernel source tree is at root of current git repo
> +       -T           Annotate output .dts with input source file and line (-T -T for more details)
>         -u           unsorted, do not sort DTx
>  
>  
> @@ -174,6 +176,7 @@ compile_to_dts() {
>  
>  # -----  start of script
>  
> +annotate=""
>  cmd_diff=0
>  diff_flags="-u"
>  dtx_file_1=""
> @@ -208,6 +211,14 @@ while [ $# -gt 0 ] ; do
>  		shift
>  		;;
>  
> +	-T | --annotate )
> +		if [ "${annotate}"  = "" ] ; then
> +			annotate="-T"
> +		elif [ "${annotate}"  = "-T" ] ; then
> +			annotate="-T -T"
> +		fi
> +		shift
> +		;;
>  	-u )
>  		dtc_sort=""
>  		shift
> @@ -327,7 +338,7 @@ cpp_flags="\
>  DTC="\
>  	${DTC}                                     \
>  	-i ${srctree}/scripts/dtc/include-prefixes \
> -	-O dts -qq -f ${dtc_sort} -o -"
> +	-O dts -qq -f ${dtc_sort} ${annotate} -o -"
>  
>  
>  # -----  do the diff or decompile
> 

