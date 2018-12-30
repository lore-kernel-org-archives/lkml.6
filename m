Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE7BC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 04:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9309120866
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 04:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjM7damH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbeL3EDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 23:03:45 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46272 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeL3EDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 23:03:45 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so11557196pgp.13;
        Sat, 29 Dec 2018 20:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7Xpa0k7vWbYF3wTAa2aHbeIbeh7JAItDvdmSPEayglM=;
        b=ZjM7damHutE31GueVvdObkagX0aeVdxHneSsNRs2OX0XwDiNr1IXUWIZklviRiavMM
         dRCfEZqQkIusgdCMVBFibv9YWH7zUWpm22969xzR3kwq+cDvYgUTUVshCnXvHFyMh9+I
         qO6awfnMnzGS9BApVSeSjM9brXXLd806+KfjonCVesVwLiQdzOh17NRVvrISB9bLUuy3
         GRh6Z+5+XLZeM6J7h9JUO1MiOl67km1P5eRdsG5hUyt0sSSc/3EnDAYzSr7seBX3MZHS
         CTMfDL83TGREeiur+nzWpGdoIwIDbwav2hZcOECsr2piH5Fqnt7O/28qt7/MhYpopqkg
         sAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7Xpa0k7vWbYF3wTAa2aHbeIbeh7JAItDvdmSPEayglM=;
        b=VOlRkYZCUmDKTC6SB5W/69nixXTt9LIklEuHmJp8ZTdX+Hb3HMGavITSAWmymTpe/J
         Z7N3kL/PpFn7bNQm+0Mf49QSq8YVsc+tW6W7+/NjarECNAl5vnHOK+ehMxqS4cGSM2oq
         IdYUVXdpj28wc3eehaWplVzkUMgH5jbjOfvCO2ut5ka1U4bYnZWmQoPy80q+IQ2DpcBl
         nzDTDPQ0XAjYsoCs9SNADjBRTnb2EJHE3jJHKa1Lnsk8xpiYEZ8QCAYVvya6WKoHZfsv
         VBMG7WaJiF2XAMmVMJBXmmatOcsDMvqmiUM58Z7HfI6D78bG9OVm0cmYPgm6dHK8JqAC
         W23A==
X-Gm-Message-State: AJcUukepzo2Vi89gwsJWiJqS2b2MejQu6+mjPwNUjKTvtOTx2nqcj5W7
        YI/iZ1RzQ04VvzcQVXo9jIc=
X-Google-Smtp-Source: ALg8bN7871f4vEOHD26Y2xj7b78c3XnjOGues36ok5C+7+7i/E0WBRd5alr2GOn1uodxz4w59WrE9Q==
X-Received: by 2002:a63:a41:: with SMTP id z1mr3493928pgk.117.1546142623184;
        Sat, 29 Dec 2018 20:03:43 -0800 (PST)
Received: from localhost (node-hau.pool-101-108.dynamic.totbb.net. [101.108.87.150])
        by smtp.gmail.com with ESMTPSA id r2sm70132276pgo.18.2018.12.29.20.03.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Dec 2018 20:03:42 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Sun, 30 Dec 2018 13:02:44 +0900
To:     akpm@linux-foundation.org
Cc:     bp@suse.de, keescook@chromium.org, mm-commits@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky.work@gmail.com, yuehaibing@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: + taint-fix-debugfs_simple_attrcocci-warnings.patch added to -mm
 tree
Message-ID: <20181230040244.GD5082@tigerII.localdomain>
References: <20181228215406.5_p7tLTSr%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228215406.5_p7tLTSr%akpm@linux-foundation.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/28/18 13:54), akpm@linux-foundation.org wrote:
>
> Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE
> for debugfs files.
>
> Semantic patch information:
> Rationale: DEFINE_SIMPLE_ATTRIBUTE + debugfs_create_file()
> imposes some significant overhead as compared to
> DEFINE_DEBUGFS_ATTRIBUTE + debugfs_create_file_unsafe().

Looks OK to me.

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>

>  static __init int register_warn_debugfs(void)
>  {
>  	/* Don't care about failure */
> -	debugfs_create_file("clear_warn_once", 0200, NULL,
> -			    NULL, &clear_warn_once_fops);
> +	debugfs_create_file_unsafe("clear_warn_once", 0200, NULL, NULL,
> +				   &clear_warn_once_fops);
>  	return 0;
>  }

The commit message probably can be better.

The _unsafe() part suggests that some of them "safeness responsibilities"
are now panic.c responsibilities. The patch is OK since panic's
clear_warn_once_fops struct file_operations is safe against removal, so we
don't have to use otherwise necessary debugfs_file_get()/debugfs_file_put().

	-ss
