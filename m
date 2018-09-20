Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F4BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B810121523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fwgBnfSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B810121523
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732189AbeITWcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:32:19 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37378 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbeITWcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:32:19 -0400
Received: by mail-pl1-f196.google.com with SMTP id q5-v6so1144650pli.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 09:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kReLGVNrs9tiIkaA47+ljM25/W15cf3ZC1aQvRVZzUc=;
        b=fwgBnfSKNjj2RbNM6auuNgC5JboIhVn/AIrLcQYhcUj6uUh61HKEkR3VYRIIy4ZAfl
         CPnLNt0SRHdzPObF+JjE2iGyBJFxZprZmS6+CbEaUBU5LxOGJqD66U74MXEjVIsMy5Rz
         jG45sYvRAul1TnQl0nEQvAzvUxy7J9RaTLemfblnS30aZofgDcd5UnYGbFPxO5Bdsg2q
         xIQKJ3z1IBfDXsO9eBFAKGwn+E8sJIqXZzaNI+IpFZYgp9k+NMWDcowP+ti6v2hvOC9P
         dUfRY7AHFPXRlxy6pDo44BGvihtPOl1sHRNkU3P29R6Xm69/63SRhJZ7AmTVP+7NbXiD
         U2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kReLGVNrs9tiIkaA47+ljM25/W15cf3ZC1aQvRVZzUc=;
        b=XWH4iDtEaLjel328NgejXf7C0L8y2+dlzj6hzTFXMbIuw1OEZRcMxOV6jxek2zgfsk
         ICTTjrQKermBNmBCiwx78yEHySJXjEPxu4ZqtJroUAe+dHeXtWIUVpyTEI+WXiJcR0Xv
         LDUtQE56mb/Eq+uVEWoKND7b6Hy1sNewAJQqVtr+ZS4CGKPEhUisZEmrZV7jKPU+QpVI
         vII854VD85KctJqfUJKB2iw0MCi3lrSOR35XuFhdDCDqDD1OpqrcqBG1sVetIgg/z7bC
         VlsI0zkkHygNMQzOlB6wPzQKzwKdZWZUjMUPGHDl0mwmX3rPhS3eBb80atxGFfdZznbq
         5HGg==
X-Gm-Message-State: APzg51CVCkNMaxS3oAV7gLdckrA628APc3d1lNxg9MbutK8tzpjBLbdz
        bUJcf8vLkJnU+kpKkh7w4tNjoMErmJKAIm0u3JL9aQ==
X-Google-Smtp-Source: ANB0VdYeTflYay/37jj7pbWnHzMulekDwC1FWFe6m0H28ub5dSfM9Tz397bRqzl7E/2l6t/XMF2UnofD0iidsLMfDjc=
X-Received: by 2002:a17:902:561:: with SMTP id 88-v6mr40040098plf.320.1537462077114;
 Thu, 20 Sep 2018 09:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180920032956.14360-1-natechancellor@gmail.com>
In-Reply-To: <20180920032956.14360-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 20 Sep 2018 09:47:45 -0700
Message-ID: <CAKwvOdnB32mZ900adeMmBpXTa6LjzAOooaGS+w96vkjZR=G_HQ@mail.gmail.com>
Subject: Re: [PATCH] IB/nes: Remove unnecessary parentheses
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     faisal.latif@intel.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 8:30 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when more than one set of parentheses are used in single
> conditional statements.
>
> drivers/infiniband/hw/nes/nes_hw.c:1446:27: warning: equality comparison
> with extraneous parentheses [-Wparentheses-equality]
>         } while ((temp_phy_data2 == temp_phy_data));
>                   ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~
> drivers/infiniband/hw/nes/nes_hw.c:1446:27: note: remove extraneous
> parentheses around the comparison to silence this warning
>         } while ((temp_phy_data2 == temp_phy_data));
>                  ~               ^               ~
> drivers/infiniband/hw/nes/nes_hw.c:1446:27: note: use '=' to turn this
> equality comparison into an assignment
>         } while ((temp_phy_data2 == temp_phy_data));
>                                  ^~
>                                  =
>
> Remove the unnecessary parentheses to silence this warning.
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/infiniband/hw/nes/nes_hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/hw/nes/nes_hw.c b/drivers/infiniband/hw/nes/nes_hw.c
> index bd0675d8f298..5517e392bc01 100644
> --- a/drivers/infiniband/hw/nes/nes_hw.c
> +++ b/drivers/infiniband/hw/nes/nes_hw.c
> @@ -1443,7 +1443,7 @@ static int nes_init_2025_phy(struct nes_device *nesdev, u8 phy_type, u8 phy_inde
>                 mdelay(1);
>                 nes_read_10G_phy_reg(nesdev, phy_index, 0x3, 0xd7ee);
>                 temp_phy_data2 = (u16)nes_read_indexed(nesdev, NES_IDX_MAC_MDIO_CONTROL);
> -       } while ((temp_phy_data2 == temp_phy_data));
> +       } while (temp_phy_data2 == temp_phy_data);
>
>         /* wait for tracking */
>         counter = 0;
> --
> 2.19.0
>

Nathan, thanks for this patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>


-- 
Thanks,
~Nick Desaulniers
