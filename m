Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4442C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99048208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99048208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeH1AoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 20:44:02 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:40708 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeH1AoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 20:44:02 -0400
Received: by mail-it0-f52.google.com with SMTP id h23-v6so438251ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 13:55:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:organization:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=qMdXzvmEjrOWwt+mhvbzS/E5f8mYs6AXtS0LyKhh5OA=;
        b=XoK+sDMIOoCU+f6/rC7tk884Glhrqqh4qGNuA5RyIPHvo4Fl1XMkL1u3Xocn0NWB3N
         UXspaPf0iYUWy0ZdkBHnp6u7pSUHBR9Tw/YLY4K3sOly7m9WBBXj0SoVS6/K9+aupcf8
         0+WINstF3sbVlqKETHSoApuGqtkFNrP5Lo71WmKtx0lOqt/mJ3qvG5b1qv2aTWJUXtjR
         NulYNg5aAVXWjGWCxWGkD6nx3nYArfHTxrH1F3cIBStBAST5LsfcgLA5RCPmSk33A8xT
         fJlICXCkWbXA2/KKr6BLKoRTE/nZiU56wpsVTcf5Za+zCPq/J3GQqRKnMF2w00KFO6VE
         Cjww==
X-Gm-Message-State: APzg51BA8eaeDPFMN5xr6Q9ysg9COQ3Fbg8xEhUlt64BmaWtr05dnxgC
        6HtqLRWk5/ti752NHiUuw/i0Kg==
X-Google-Smtp-Source: ANB0VdYA00khzC+DYIdOBXgs+7GGdbJTPCKWnr+LTSqsX50qNWNLFrtQj6VXSsf1e0MGRxcUzQ2zxA==
X-Received: by 2002:a02:f41:: with SMTP id h62-v6mr11496585jad.53.1535403345521;
        Mon, 27 Aug 2018 13:55:45 -0700 (PDT)
Received: from masetto.ahs3 (c-67-165-232-89.hsd1.co.comcast.net. [67.165.232.89])
        by smtp.gmail.com with ESMTPSA id 132-v6sm97683itz.10.2018.08.27.13.55.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 13:55:43 -0700 (PDT)
Reply-To: ahs3@redhat.com
Subject: Re: [PATCH] mailbox: PCC: handle parse error
To:     David Arcari <darcari@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>
References: <1535397548-69588-1-git-send-email-darcari@redhat.com>
From:   Al Stone <ahs3@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=ahs3@redhat.com; keydata=
 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
 AeZZwq9vgjZvBA==
Organization: Red Hat, Inc.
Message-ID: <e9d05632-dae6-b904-fe62-d617b3dfe3fd@redhat.com>
Date:   Mon, 27 Aug 2018 14:55:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535397548-69588-1-git-send-email-darcari@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/27/2018 01:19 PM, David Arcari wrote:
> acpi_pcc_probe calls acpi_table_parse_entries_array but fails to check
> for an error return.  This in turn can result in calling kcalloc with
> a negative count as well as emitting the following misleading erorr
> message:
> 
> [    2.642015] Could not allocate space for PCC mbox channels
> 
> Fixes: 8f8027c5f935 ("mailbox: PCC: erroneous error message when parsing ACPI PCCT")
> 
> Signed-off-by: David Arcari <darcari@redhat.com>
> Cc: Al Stone <ahs3@redhat.com>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> ---
>  drivers/mailbox/pcc.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 311e91b..256f18b 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -461,8 +461,11 @@ static int __init acpi_pcc_probe(void)
>  	count = acpi_table_parse_entries_array(ACPI_SIG_PCCT,
>  			sizeof(struct acpi_table_pcct), proc,
>  			ACPI_PCCT_TYPE_RESERVED, MAX_PCC_SUBSPACES);
> -	if (count == 0 || count > MAX_PCC_SUBSPACES) {
> -		pr_warn("Invalid PCCT: %d PCC subspaces\n", count);
> +	if (count <= 0 || count > MAX_PCC_SUBSPACES) {
> +		if (count < 0)
> +			pr_warn("Error parsing PCC subspaces from PCCT\n");
> +		else
> +			pr_warn("Invalid PCCT: %d PCC subspaces\n", count);
>  		return -EINVAL;
>  	}
>  
> 

Thanks, David.  Nice catch.

Reviewed-by: Al Stone <ahs3@redhat.com>

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
