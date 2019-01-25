Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2758EC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 05:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBECE21872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 05:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfAYF14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 00:27:56 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43848 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfAYF14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 00:27:56 -0500
Received: by mail-pg1-f194.google.com with SMTP id v28so3710808pgk.10;
        Thu, 24 Jan 2019 21:27:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AazxMwswwxM1xU4axiuXpJdgtWxgeH5uwdI+Roy00ZM=;
        b=Uvg4vEKUfFYbpx1TXIF2yr7w4gNAsev6DyQHoVGJSxtbkB808BgJuHIbVyuMVgfqRw
         IJYBE03z7XZZjpJxF4ZRRDplMslv4fCUPNDIgaIpAHYSFqev/IbEKizjwpLAElVisRO+
         B4v+iZZoA/InjHfKv3cySZpcHYuyJ2sfrHCIaq6rmbSq05dV92S3ajQZgkNQQXo/dHX7
         IIRIQmHJumDkvGHgcygEw0sgqHWNPPn/ES2zioPI4RgG15/kBr1yqzuqXxHWmyCBJNR3
         eSm97moOLi3ExYGCpLmmUBFZj/hgUU/cMvzDqHGlWhdjeTSpsY+TzpqaFl1HxFHZlM9c
         eHKg==
X-Gm-Message-State: AJcUukcD6Wvhz3FDJFcs0LbJItx5zSUiUerxh4zK2wj0pxn/fBbZNIGi
        upraW+NoEnsRmD6KQegG6vmcj0Ej
X-Google-Smtp-Source: ALg8bN4pjN2RM6ljcA9hWOhTrBulBfQdknp/cFm6OceEVDS/krV4jJGJqGc6rYH1+siIP7YqA1lNoA==
X-Received: by 2002:a63:ed03:: with SMTP id d3mr8580481pgi.275.1548394075232;
        Thu, 24 Jan 2019 21:27:55 -0800 (PST)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id x11sm63609948pfe.72.2019.01.24.21.27.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 21:27:53 -0800 (PST)
Subject: Re: [PATCH 1/2] infiniband: remove unneeded header search paths
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel@vger.kernel.org, target-devel@vger.kernel.org
References: <1548391171-6407-1-git-send-email-yamada.masahiro@socionext.com>
 <1548391171-6407-2-git-send-email-yamada.masahiro@socionext.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <8563eb16-0740-536e-3c35-2ebcff76ba71@acm.org>
Date:   Thu, 24 Jan 2019 21:27:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548391171-6407-2-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/19 8:39 PM, Masahiro Yamada wrote:
> The included headers are located in include/target/. I was able to
> build these drivers without the extra header search paths.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>   drivers/infiniband/ulp/isert/Makefile | 1 -
>   drivers/infiniband/ulp/srpt/Makefile  | 1 -
>   2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/isert/Makefile b/drivers/infiniband/ulp/isert/Makefile
> index c8bf242..a4a4766 100644
> --- a/drivers/infiniband/ulp/isert/Makefile
> +++ b/drivers/infiniband/ulp/isert/Makefile
> @@ -1,2 +1 @@
> -ccflags-y		:= -Idrivers/target -Idrivers/target/iscsi
>   obj-$(CONFIG_INFINIBAND_ISERT)	+= ib_isert.o
> diff --git a/drivers/infiniband/ulp/srpt/Makefile b/drivers/infiniband/ulp/srpt/Makefile
> index e3ee4bd..43fbde4 100644
> --- a/drivers/infiniband/ulp/srpt/Makefile
> +++ b/drivers/infiniband/ulp/srpt/Makefile
> @@ -1,2 +1 @@
> -ccflags-y			:= -Idrivers/target
>   obj-$(CONFIG_INFINIBAND_SRPT)	+= ib_srpt.o

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
