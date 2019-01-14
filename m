Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8CAC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 06:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD1E20663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 06:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmZGGobM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfANGwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 01:52:38 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46505 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfANGwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 01:52:38 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so9876697pfe.13;
        Sun, 13 Jan 2019 22:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eI1P4E2yI8ems4grYV5HYlHCRxtEgB2NKoxdLszE95s=;
        b=OmZGGobMP5E4YfUJjI0q6MedykdC6igrgK9PnjPKi6fJVdUy+w3LSProf9R1zjQnXS
         NwbPznWkJQP8wRaa7HthuAtWAJ6Hrg7C0q9j/98Hf1LPyDN7uXCTEjr/FlLbQspwQ+EN
         7lkPqJvdB45MmK5CFdPSyTFB1wtLJE58fJSfuhBJIjKdhMzMwcR1kjc6pBYGzwKHK2kO
         /ynahax5OuCCf8N74+DtOBzzdCPMZLvib0ezYZy16hxgXHpADSSDM1SuTBZZEANil/Q/
         Mg3lHOp/B81glb+E5QwT4XhrXkEifzjQ3xjKxh1BjRFdn4a5rMvq4ofQrSR/Ig9nOSEI
         Yu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eI1P4E2yI8ems4grYV5HYlHCRxtEgB2NKoxdLszE95s=;
        b=t84bxNL2gl8wXcPbrDiuImfmIllkNVrcUj/5e/u/Ndno6DlfaWiK0ZSYejONg3iCTO
         pMJ2b5NKom0ajCdT4M6BJftMnCkWWXHVeS2qgsZDwyyoyT4N2zAk9p+hDm+fY8W+iyW7
         NbOCAe90rcU0SJTKhiaeUWkbvgxwP6BinK/++RD/o8xYdGc4kdKa2vaaskE8hP2hvPmf
         tSLPS5/6k+9grmm0mDRuU5HxlRzAMbtrwcHbfXvgR58G9zJOHD23/IjVyIrcuQGguvrN
         xrTxrfFmlIOeWNXxUVukfAi99WzNnmnzSFOke9QwbafF+WWXls7HXOPtzOX7U+2Sr2bJ
         LtLw==
X-Gm-Message-State: AJcUukemVUJ+LQ5bAumDlypJaRlBU2/yGTXOrApDUAl4ENQq5pVmf1Y/
        nDAD3EGCRm/+UlO3eW+q8qQ=
X-Google-Smtp-Source: ALg8bN6qInwlb8uQnAa1Df4dZWbgSQ91CBGRn6+H50eFJp7L0sHBKR4zq+PQqR19h8DZUmYUb2fKGw==
X-Received: by 2002:a63:2109:: with SMTP id h9mr21559042pgh.277.1547448756587;
        Sun, 13 Jan 2019 22:52:36 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id a90sm152253295pfj.109.2019.01.13.22.52.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 Jan 2019 22:52:35 -0800 (PST)
Date:   Sun, 13 Jan 2019 22:52:33 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, davem@davemloft.net, y2038@lists.linaro.org
Subject: Re: [PATCH] input_event: Provide override for sparc64
Message-ID: <20190114065233.GB217283@dtor-ws>
References: <20181229183514.24644-1-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181229183514.24644-1-deepa.kernel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2018 at 10:35:14AM -0800, Deepa Dinamani wrote:
> The usec part of the timeval is defined as
> __kernel_suseconds_t	tv_usec; /* microseconds */
> 
> Arnd noticed that sparc64 is the only architecture
> that defines __kernel_suseconds_t as int rather than long.
> 
> This breaks the current y2038 fix for kernel as we only
> access and define the timeval struct for non-kernel use cases.
> But, this was hidden by an another typo in the use of __KERNEL__
> qualifier.
> 
> Fix the typo, and provide an override for sparc64.
> 
> Fixes: 152194fe9c3f ("Input: extend usable life of event timestamps to 2106 on 32 bit systems")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>

Applied, thank you.

> ---
>  include/uapi/linux/input.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index fb78f6f500f3..ffab958bc512 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -26,13 +26,17 @@
>   */
>  
>  struct input_event {
> -#if (__BITS_PER_LONG != 32 || !defined(__USE_TIME_BITS64)) && !defined(__KERNEL)
> +#if (__BITS_PER_LONG != 32 || !defined(__USE_TIME_BITS64)) && !defined(__KERNEL__)
>  	struct timeval time;
>  #define input_event_sec time.tv_sec
>  #define input_event_usec time.tv_usec
>  #else
>  	__kernel_ulong_t __sec;
> +#ifdef CONFIG_SPARC64
> +	unsigned int __usec;
> +#else
>  	__kernel_ulong_t __usec;
> +#endif
>  #define input_event_sec  __sec
>  #define input_event_usec __usec
>  #endif
> -- 
> 2.17.1
> 

-- 
Dmitry
