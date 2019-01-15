Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD81C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01DD320656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MUo7ZOWN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfAOFyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 00:54:01 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41549 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbfAOFyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 00:54:00 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so771236pfi.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 21:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BrydfdUXj3ZnvaRHY3mVchnZedVhZ7pBlHf/TdSLhqE=;
        b=MUo7ZOWNn/MCC3ySmxF4OzPTLp3zuM9OPecw6sRAhbE2MSneyWSEbdXWOpTC6A6bUm
         yCJTsMV/oyT7abSJJ6jwvWXAdjahOz7W39daAFEy3C9lb5FuzTqO6sKoulfpqROqOY0O
         C5N+wtTexuXlssAoeZjA/IwoRUj2bHreMU0t8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BrydfdUXj3ZnvaRHY3mVchnZedVhZ7pBlHf/TdSLhqE=;
        b=hucs6eUrznjqcxfbyZUTJgl5SM/5ENRjU5BXSCJen5p24vqH9f4SBoUtMQlNp4Swsa
         04vjguLb/JQSFPpjMFyK849w0YaHFt32fZXHw2T/LbUR8OiTm3P3IN+a48G9KryqvRSi
         me4bAZNruxJjsgUnEkzYT3BeKpmfAjSRjPLCo3Kbj8us7P8YhjM9BG4oH7USvUDQ0zob
         piE3RymOh+bJcp71xdvnK5/yCiRUufhryeghU+LVpCkjtkgtEblNP7wR6NHF8wrL/l5u
         jYdK+RLrTT7wDaTfzPRQ0IA7xJhbtOphLY2vbW9r7N/YJTxv/5PWyBKthYze72HfJqrc
         7kRg==
X-Gm-Message-State: AJcUukdtdYYZFcabEgeuUUGd8lcNE3kx5YuZ4IF/A41+vwMsjeNBZn6T
        71Zkl/NMAUz0EMXyLAMiVb4jyA==
X-Google-Smtp-Source: ALg8bN7RvjEL+pRCxjxRLdT8lvcavt03YFv9m93EcN35fOqGbj7rDeujZIe6I49Myej2UwyjhTHIcQ==
X-Received: by 2002:a63:ef47:: with SMTP id c7mr2288053pgk.386.1547531640119;
        Mon, 14 Jan 2019 21:54:00 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c72sm3520055pfb.107.2019.01.14.21.53.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 21:53:59 -0800 (PST)
Date:   Mon, 14 Jan 2019 21:53:57 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc:     ohad@wizery.com, jrdr.linux@gmail.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: Re: [PATCH] remoteproc/qcom_sysmon.c: Remove duplicate header
Message-ID: <20190115055357.GC25927@tuxbook-pro>
References: <20190109142959.GA29659@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109142959.GA29659@hp-pavilion-15-notebook-pc-brajeswar>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09 Jan 06:29 PST 2019, Brajeswar Ghosh wrote:

> Remove linux/notifier.h which is included more than once
> 

Applied, with Souptick's ack.

Thanks,
Bjorn

> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> ---
>  drivers/remoteproc/qcom_sysmon.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/qcom_sysmon.c b/drivers/remoteproc/qcom_sysmon.c
> index e976a602b015..603b813151f2 100644
> --- a/drivers/remoteproc/qcom_sysmon.c
> +++ b/drivers/remoteproc/qcom_sysmon.c
> @@ -7,7 +7,6 @@
>  #include <linux/notifier.h>
>  #include <linux/slab.h>
>  #include <linux/io.h>
> -#include <linux/notifier.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/remoteproc/qcom_rproc.h>
> -- 
> 2.17.1
> 
