Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0D2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DBF217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/6zVg/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfBOAKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:10:45 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39926 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfBOAKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:10:44 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so4011707pld.6;
        Thu, 14 Feb 2019 16:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yUt0k+djJpk1EXZf+gLjhm0M3fjeKZol9KaZ/TPziG8=;
        b=h/6zVg/u7psWL8BW09M/qiu0NMbgOtxFxTya4WhGfP65s5wUWlZp/TVADC8U2K3ku4
         bVAb/3N+ezLhT6mbmIoz0e0jZqi12fSthc53yMPbc0bBAIKAOqG1K3DZu+0O2cljS5Mk
         REZ+w/XqGcg9QVrYhA3k8ujbKDGLS3JaIoeLXV/LUwmQcigg0j+QZ1kEYbsmU+eW/QxW
         zEIjbX9H5dUfnzsg1LNQaINwMLIbW09ZQXF8RFX4lGwluyt4tVk2vIvqHPBvdCGMBcZ9
         Z6rn6BQY0bz+d+CQGVBELktTptMsLMebmVwHjzU3XF1MUhCbuPOPY0LtrHpOpEKwNs3v
         A2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yUt0k+djJpk1EXZf+gLjhm0M3fjeKZol9KaZ/TPziG8=;
        b=kDjYXCjrXBusNm0NYB2uRBEPTXs7rNNdcSQAFB3+b+5Z65lr8ldlhcFpdUxEyp0hAD
         txhhKMGLFF7FCZj32dSfPCt7feUynJLwvAuDlZ5VygpJEpJxjQq8i+2b5UOBR4UdPw3t
         Z2GR+lPhergDM0/JA1kFQYxhDUlUEHcwWg90di4aupPDohMicEXOXoL8r6z96wKR4ejt
         tZlHykOpzlUteDO2WFxAv2XFDNW47icSyxml+qwtFcqRpg69WRKagf4FuLtNSfy4L7pq
         QXlcbNJ0ZBSc/XEP0Zp4YZRJ3ybepX1xJbKtAlDvK2gRnpkHg9jPcQrcPcTWB60+LDBR
         8mEw==
X-Gm-Message-State: AHQUAuZBKnncbvympij3mty0T/xgnWThyJB+Cw2LyBFoRXNkmpb8xlYq
        OVOO0pm8GjStOQtICx9Zueh11zho
X-Google-Smtp-Source: AHgI3IYS2jUf7ThJI7euRCR80jESss1VQk5uSm4TTJ+uABIkrxAUELTTkGRV5NV8Bc/q9vF2ckBE1w==
X-Received: by 2002:a17:902:264:: with SMTP id 91mr7202737plc.108.1550189444013;
        Thu, 14 Feb 2019 16:10:44 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id a90sm8316681pfj.109.2019.02.14.16.10.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 16:10:43 -0800 (PST)
Subject: Re: [PATCH v1 1/1] of: unittest: unflatten device tree on UML when
 testing
To:     Brendan Higgins <brendanhiggins@google.com>, robh+dt@kernel.org,
        mcgrof@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190212185305.112847-1-brendanhiggins@google.com>
 <20190212185305.112847-2-brendanhiggins@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <4cb7ca12-ce60-7516-b7eb-aef08f607acc@gmail.com>
Date:   Thu, 14 Feb 2019 16:10:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190212185305.112847-2-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/19 10:53 AM, Brendan Higgins wrote:
> UML supports enabling OF, and is useful for running the device tree
> tests, so add support for unflattening device tree blobs so we can
> actually use it.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  drivers/of/unittest.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index 84427384654d5..effa4e2b9d992 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -2527,6 +2527,9 @@ static int __init of_unittest(void)
>  	}
>  	of_node_put(np);
>  
> +	if (IS_ENABLED(CONFIG_UML))
> +		unflatten_device_tree();
> +
>  	pr_info("start of unittest - you will see error messages\n");
>  	of_unittest_check_tree_linkage();
>  	of_unittest_check_phandles();
> 

(Insert my usual disclaimer that I am clueless about UML, I still need to learn
about it...)

This does not look correct to me.

A few lines earlier in of_unittest(), the live devicetree needs to exist for
unittest_data_data() and a few of_*() functions to succeed.  So it seems
that the unflatten_device_tree() for uml should be at the beginning of
of_unittest().

Rob, if I am correct please revert this patch.

-Frank
