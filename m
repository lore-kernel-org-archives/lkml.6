Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967A4C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3CC5206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mL5lGmKn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3CC5206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbeKUEAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:00:08 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45030 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbeKUEAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:00:07 -0500
Received: by mail-pl1-f194.google.com with SMTP id s5-v6so1318749plq.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 09:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=ZUZu1XwZ8f7g6NqpBSd3lwgL1/UqWz9FgIimF7IiiBU=;
        b=mL5lGmKnmVqKTv+RoxLHuXmZVppJcsdNOft5F5ISDYcBmW4G+R/AwJfXd8KpXg2q+T
         guUtaHQaHlcq7x7PulayiauXMYWRr67bROQzwflJoA7emOAxvpJHgq2qUAGtdmuQwOCO
         +2vLPJl1cFch16mXDDOJqWaA+Ks8akJPclCAsF5okIhEHYVkobwN0A6EI5At2CvFZIM/
         iLvzvwkRF7NB3Hn9fBtr+XeUchUKv9gc9Maa4hqqbaBRaMECZsvr2j9XBXd8h4TfWI+j
         //SZIZfUNNFysnkjoJNVUHbX8xEay4AMtb8dMdBm0SNNDoZTVPc16GWpfbKZErO5r/R+
         R0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ZUZu1XwZ8f7g6NqpBSd3lwgL1/UqWz9FgIimF7IiiBU=;
        b=hW1krlaedzVHiHjw41wUQr9fisJS6osaZ9AvReexL3cOLixCx3KpubSC2Sk3ynSzEa
         6Ba13kw9f1rf/pRT/n7dOSzGjJrHRysiEWHw78+nBMf6orEK73QI2GxmTa6wt5G11YU1
         r99BGMNX6axjaIOd9emXYoYcZfJAH8LmUKXxUqpVd7gzubM/2C/NzbPWYwkPWFXaiugs
         JAmr49pKIzUaWaLQmPMVmY5/MCkgV3GjPhlTUPLxb0Gkmrr5mdVxQmeMbkAp6d2UhHJj
         zXnz/lUdfWG51ENp4aODLqeDAeiwoX1sFIhAXiXsn+cw4P424Dx9coyaqJXgTjXR8bE2
         q/8A==
X-Gm-Message-State: AA+aEWbSqlDhWQDF1ZKK0Ws2eEXj+llW17ysm8+ZLtEXOJrHA183Eqv+
        rOaWVWAC+oJWhXnSNPSDZ8J8XQ==
X-Google-Smtp-Source: AFSGD/VUg0xRNh0DS+Ae1OGZam8imMIpsFVGVpUksfK7DwpMpJ+fde/Ext79VjmiqpKFGbFfmNOPHw==
X-Received: by 2002:a17:902:b611:: with SMTP id b17-v6mr3169581pls.31.1542734991154;
        Tue, 20 Nov 2018 09:29:51 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id g5sm42969593pgu.57.2018.11.20.09.29.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 09:29:50 -0800 (PST)
Date:   Tue, 20 Nov 2018 09:29:50 -0800 (PST)
X-Google-Original-Date: Tue, 20 Nov 2018 09:29:31 PST (-0800)
Subject:     Re: [PATCH] RISC-V: add of_node_put()
In-Reply-To: <20181120141102.20534-1-tiny.windzz@gmail.com>
CC:     aou@eecs.berkeley.edu, dmitriy@oss-tech.org, atish.patra@wdc.com,
        tglx@linutronix.de, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, tiny.windzz@gmail.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     tiny.windzz@gmail.com
Message-ID: <mhng-f6900077-f39d-46e8-8fce-e5f7af872ced@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018 06:11:02 PST (-0800), tiny.windzz@gmail.com wrote:
> use of_node_put() to release the refcount.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  arch/riscv/kernel/time.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
> index 1911c8f6b8a6..40470e669a35 100644
> --- a/arch/riscv/kernel/time.c
> +++ b/arch/riscv/kernel/time.c
> @@ -26,6 +26,7 @@ void __init time_init(void)
>  	cpu = of_find_node_by_path("/cpus");
>  	if (!cpu || of_property_read_u32(cpu, "timebase-frequency", &prop))
>  		panic(KERN_WARNING "RISC-V system with no 'timebase-frequency' in DTS\n");
> +	of_node_put(cpu);
>  	riscv_timebase = prop;
>
>  	lpj_fine = riscv_timebase / HZ;

Thanks.  I'm going to target this for next week's PR.
