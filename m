Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030B1C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9BB926EE3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9BB926EE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934129AbeFZSiK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:38:10 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33425 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753135AbeFZSiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:38:08 -0400
Received: by mail-wr0-f193.google.com with SMTP id k16-v6so18256993wro.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 11:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oTXwBtxwySX+nORClgtcdjUKbLz7P/w6h26iV3grRnc=;
        b=tYHtnXges7n/nKOdkRwfs1x70RMAQIjDOTPzPQ5vRYQxMuj9k2/IqUi+qvZR6wKE6e
         frVTqXONK/JJ2zRZFXSxwbbDcKxhxFv7Es0C5oV/lTf/wduFsCA4PUuq5OqpKXro7FM5
         89GxHvkIKNa6zT7NpLUIdTd1NdvO5pe5cAeZkVYJ4xC+dqQ+Z2PG2G93z5l6O+f+ZCis
         vx0gsKfH7aHBd6L4bebs6DKCQeUyhJRONwXs4mqFa7h03TKGRbP3hiKYyAhPQ20bGvxo
         WEQzdMDu8URHan7IU7hVAvL2Nei+jh0MDgnJaIZTPNGzIvsBV4uHA9pqJJV4CPT3k9UZ
         JYqA==
X-Gm-Message-State: APt69E0+80aR1DQZ2NFi3pVH3PvG9nGgaQBFSt93Jzn/EvQii5VL6Mcv
        d95D1IssJ29IlOAS0manzFJ7UA0YT44=
X-Google-Smtp-Source: AAOMgpfe3Q4OgrC+KTUJfSueN4nnkv50S1rPxUZoyDHZBcNEENcLFidZXcmuViL+aDdr/HCuUdW8zA==
X-Received: by 2002:adf:b69c:: with SMTP id j28-v6mr2340186wre.200.1530038287549;
        Tue, 26 Jun 2018 11:38:07 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id c18-v6sm3956068wrq.17.2018.06.26.11.38.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 11:38:06 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] printk: Export is_console_locked
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
References: <20180626183612.321-1-hdegoede@redhat.com>
 <20180626183612.321-2-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <562ee932-f163-d085-818d-2f8545da546f@redhat.com>
Date:   Tue, 26 Jun 2018 20:38:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180626183612.321-2-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As the cover letter's subject correctly indicates this is v4 of the
patch-set, I forgot to bump the subject-prefix when sending, so the
v3 in the subject here really should be v4.

Regards,

Hans


On 26-06-18 20:36, Hans de Goede wrote:
> This is a preparation patch for adding a number of WARN_CONSOLE_UNLOCKED()
> calls to the fbcon code, which may be built as a module (event though
> usually it is not).
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v3:
> -New patch in v3 of this patchset
> ---
>   kernel/printk/printk.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 247808333ba4..3f041e7cbfc9 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2243,6 +2243,7 @@ int is_console_locked(void)
>   {
>   	return console_locked;
>   }
> +EXPORT_SYMBOL(is_console_locked);
>   
>   /*
>    * Check if we have any console that is capable of printing while cpu is
> 
