Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA79C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F20821501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tTdORfBS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F20821501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387584AbeHBOyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:54:22 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34678 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387469AbeHBOyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:54:22 -0400
Received: by mail-pl0-f68.google.com with SMTP id f6-v6so1007506plo.1;
        Thu, 02 Aug 2018 06:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O4XHT4t3AiikZr+66dkHznDJWTyTNlWCpe9chdfEqqc=;
        b=tTdORfBSXdGVsQw2TbD4m6bgEyH2e6434N2B6+AGNTlGv692DIU3sgM6Ai8tFtZsJp
         wieRp9nodMtRH54/1ptxxhypiFWeon18dixkP5m1fRkMnK703IfVYaO6J9zuwXSOQx41
         EgytnaiyiebvlA7G2z+VVDY+h1j369vrHuqdJxeYzdaukMz3pnHiThRuZni8uNhhSRST
         aMiNcU/6QMBkRbZ8ZVQyHySKryUlazGl0aEtXVdxhu8Xa5ncqG50ZeeoLBppklFsrOPe
         CEQLEJ8joa4fZHuQzSeq4cNNRpJq7WibGdXQEq6oBSeM0Ifl/TnAi4fQWrN3od1+IGEC
         alXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O4XHT4t3AiikZr+66dkHznDJWTyTNlWCpe9chdfEqqc=;
        b=B9WmZqafKiVH9rLaG6t+taFl8lgoUknbkyhcsgXy1dt2M7u0vflAQijtDu09Y4BR73
         azRs4HkrZ/EzzsHYdEYJhxm66QqN/KhJorSVX3hk37lZkgYYa+AqoE8e748284CWecWE
         vNYiH9fiykZKqzQQqD2jOXlgTVF6XK9zumwjvsXJ8WUNFyOXUWR6M8C+2sgwSCW5aW53
         jY4P6oe/CR0DU6eZoG4y9U/RFzUxQP7dcKNvnhYP5INrENcJICSsHCinonpMtXa0QaZy
         wJT4VD59n0RlKXK0iFA+EahaLy8pWmJTwcyuTrtc5DlEvngzrJzqD2+Z8Fp2ix5vwhQF
         cR3w==
X-Gm-Message-State: AOUpUlF+d+z+5D7FIe2W6di7HFzPvabTkW4NgCUmhjhSgwYgIWVCALYV
        98gT9JKiz0/vB7/4O9B3f2Ll1HUX
X-Google-Smtp-Source: AAOMgpe/4pDkfRuvC37ZBkQKw0yQUEMZQfujUWlrkKc4VPRNZJZn6J/TPcaUpb7nluZxFiaLokqk+g==
X-Received: by 2002:a17:902:7106:: with SMTP id a6-v6mr2418603pll.28.1533214995824;
        Thu, 02 Aug 2018 06:03:15 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id e21-v6sm3221247pfl.187.2018.08.02.06.03.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 06:03:15 -0700 (PDT)
Subject: Re: [PATCH 1/1] selftest/net: fix protocol family to work for IPv4.
To:     Maninder Singh <maninder1.s@samsung.com>, davem@davemloft.net,
        shuahkh@osg.samsung.com
Cc:     netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, edumazet@google.com,
        pankaj.m@samsung.com, a.sahrawat@samsung.com,
        Vaneet Narang <v.narang@samsung.com>
References: <CGME20180802100201epcas5p390bb362ccabaa99087eff88af37bffb2@epcas5p3.samsung.com>
 <20180802100201epcas5p390bb362ccabaa99087eff88af37bffb2~HCQZjTEZd0101301013epcas5p3C@epcas5p3.samsung.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <bd39eee1-ff9f-db4e-2948-2cb9a7a651f7@gmail.com>
Date:   Thu, 2 Aug 2018 06:03:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180802100201epcas5p390bb362ccabaa99087eff88af37bffb2~HCQZjTEZd0101301013epcas5p3C@epcas5p3.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/02/2018 02:57 AM, Maninder Singh wrote:
> use actual protocol family passed by user rather than hardcoded
> AF_INTE6 to cerate sockets.
> current code is not working for IPv4.
> 
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> ---
>  tools/testing/selftests/net/tcp_mmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/tcp_mmap.c b/tools/testing/selftests/net/tcp_mmap.c
> index 77f7627..e8c5dff 100644
> --- a/tools/testing/selftests/net/tcp_mmap.c
> +++ b/tools/testing/selftests/net/tcp_mmap.c
> @@ -402,7 +402,7 @@ int main(int argc, char *argv[])
>  		exit(1);
>  	}
>  
> -	fd = socket(AF_INET6, SOCK_STREAM, 0);
> +	fd = socket(cfg_family, SOCK_STREAM, 0);
>  	if (fd == -1) {
>  		perror("socket");
>  		exit(1);
> 


Darn, someone spotted my hidden attempt to kill IPv4 ;)

Reviewed-by: Eric Dumazet <edumazet@google.com>
