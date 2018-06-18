Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920B7C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F59208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="KNnEk3p5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F59208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030397AbeFRIqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:46:21 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35369 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966886AbeFRIqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:46:18 -0400
Received: by mail-lf0-f65.google.com with SMTP id i15-v6so23376268lfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 01:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=avEkCVSoB7fAFq8ejOcE1OORh7QBpsbAiByo0iynTO8=;
        b=KNnEk3p5Y79KYgrhCeQmTk+pBQh1C9ac1Z3gxCa/mnn3FqsMZo5OFc9mC459f7XTr0
         YX1P1YHVtMM4f27kiHuzzHm3TJMBTSV1SJb3x3ul9ErLFSYmw211CSibLPf/94xU3A+4
         KMMdSZVBQYQqdfCO1cf6/BzO3/vthyX8yYaX9S/S60LkkYc9enMcb6DgJcCi2f1SYA00
         IdG6HqARvz3UFYq66R1xLAPDA/p094dJxcNcKhuBq6pClbspYjGrYAiFSs/lXy2XetXz
         5VE5g9lSDDEcHDwhIlCUcAv6Sa4xyww9kgETcGQvEIJX6Jj5q+b+hQZ6yF2z1spdoFRT
         xVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=avEkCVSoB7fAFq8ejOcE1OORh7QBpsbAiByo0iynTO8=;
        b=HpPZDtNvRBZWr55E0t+gaWDvYlEzjh4BBgPgyWL6hhmtg6u3TfdNBKMiEdcV3hzy7u
         z6tMoVGuqjPyAnoPgoz5mrMW8T/uTq2DHZumcl/+5v+cPebVnX7SP94DjltcLv6X5Ude
         EzdFZSr9RoYPAMgsAW9gtcXm9XO8YPlU/wxF8HHUPjONmyBYtdKQ8mH9vHT+L0+HEk4U
         s42r90f1CHoEJmrlv7WdhqP5KDEbt4dO9YbazdybfIMTYihhbiJ1xJcRN02781kodGDC
         Sej6J8badbBDImfSYdtn1wqoSbziabSM6e3rPsdxWy9MNLpJwlegt1QMcpqWHgzz/YAn
         3wqA==
X-Gm-Message-State: APt69E3vBiG1BPxiCVU+slANfvaBZ1fjg3iRHrDG/yDC2znNwzqypsKY
        C2J4tcp1kLGd7yC6krJ3KG2Ibg==
X-Google-Smtp-Source: ADUXVKIbsy7OmXDyY4vuHC4bJmDULwRjsRa4sphugZFrcEgHf9OjjZlMlL2eQWwXbhssGY4pYBlwzw==
X-Received: by 2002:a19:4a53:: with SMTP id x80-v6mr3024440lfa.69.1529311576605;
        Mon, 18 Jun 2018 01:46:16 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.82.169])
        by smtp.gmail.com with ESMTPSA id s5-v6sm2629566ljh.9.2018.06.18.01.46.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 01:46:15 -0700 (PDT)
Subject: Re: [PATCH 4.16 020/279] dt-bindings: net: ravb: Add support for
 r8a77965 SoC
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Rob Herring <robh@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
References: <20180618080608.851973560@linuxfoundation.org>
 <20180618080609.641888971@linuxfoundation.org>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <b00cf160-5457-1a2c-2020-4b2fffe047cc@cogentembedded.com>
Date:   Mon, 18 Jun 2018 11:46:17 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180618080609.641888971@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/2018 11:10 AM, Greg Kroah-Hartman wrote:

> 4.16-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Jacopo Mondi <jacopo+renesas@jmondi.org>
> 
> [ Upstream commit 1a862488729a6ea9cfd285d2c90f8738949ae7d2 ]
> 
> Add documentation for r8a77965 compatible string to renesas ravb device
> tree bindings documentation.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   Documentation/devicetree/bindings/net/renesas,ravb.txt |    1 +
>   1 file changed, 1 insertion(+)
> 
> --- a/Documentation/devicetree/bindings/net/renesas,ravb.txt
> +++ b/Documentation/devicetree/bindings/net/renesas,ravb.txt
> @@ -17,6 +17,7 @@ Required properties:
>   
>         - "renesas,etheravb-r8a7795" for the R8A7795 SoC.
>         - "renesas,etheravb-r8a7796" for the R8A7796 SoC.
> +      - "renesas,etheravb-r8a77965" for the R8A77965 SoC.
>         - "renesas,etheravb-r8a77970" for the R8A77970 SoC.
>         - "renesas,etheravb-r8a77980" for the R8A77980 SoC.
>         - "renesas,etheravb-r8a77995" for the R8A77995 SoC.

    Seeing the bindings update in -stable for the 1st time, and I highly doubt 
that it's necessary here.

MBR, Sergei
