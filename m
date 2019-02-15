Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA78DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4400222DC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhGXEdAP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732521AbfBOPHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:07:47 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42681 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfBOPHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:07:46 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so7411104lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 07:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=fCWaYyWj6ae+RJuhOxyp0aA8Ab3XE5DRWBACRgRaPGU=;
        b=ZhGXEdAPbc861+sE/3wnh81IawZ3DZPug1tVzscuqD1TuBV8ci8gve0MBBKCpRl49M
         rW02XrIlJXlI2E1KXogwa627e5VlLAsYMv2XDhRSb1ZJ1nkhk0Wd3dsC90dXIWybS84R
         tsKFM8lc7v9jaNGOaTjErfpJuGahZM//Jx73a41lMEkstGPkFIOV19RUk3a+yhBNSYK2
         Am6C4DZ6rSCo5xWuJoQu3xQIh3xnmkn8D9F28hnClT0mqFCNf2ogxnpRydheaWTraDIW
         32DfakON2ZXRh8OLffnwDJNuW0ez3fk5fVhZadrqd2n9VYHAajAiwiINfQroGN/kmOTv
         pH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fCWaYyWj6ae+RJuhOxyp0aA8Ab3XE5DRWBACRgRaPGU=;
        b=aZ4hOoXnjsULi8hxWRWr4pEhZUPWUEdX6ItsRkE2PiAQUtRNVQOx7QkqCSOaOKQdvb
         fCT8My+wCAtXaZVcd/zHuMrUyvrK17EJz7fXEowfnUnq1PwrXbLEf8IcAtuYeFO1WfU8
         4sHUUPJDRk+Xdm72WSc9d3Pq/7whNoyhr6N1AzOUeOBDOQnmn1mY8qdokQxZyp7Ilq7D
         I62czywKgRFmp7btHTA5FjzCl/xMX7ENbvnlu5IPzKN2ruutMkyemIuIX4Yh5LNL+0ut
         50czi8pBLdYb3gehmA926EAFHl1r8kOlrumLJ+r8EfXZQ6882GNGJK8hIJeD/gULdvM2
         JrUQ==
X-Gm-Message-State: AHQUAuYw77ai8gPQpN0i2tEqlAMnClziJ28CcM8w1orfUl1xizBv4qU2
        SRoi79MAOAVPWNSjHsDV+M4=
X-Google-Smtp-Source: AHgI3IaxXpH7VyNTg0WimjI+Vv2lSyapJJJRNJ4n1fkzsf8/1pNWZFBNZVkTP9mWy1qZcJOZ8lpX5g==
X-Received: by 2002:ac2:4316:: with SMTP id l22mr5770903lfh.11.1550243264214;
        Fri, 15 Feb 2019 07:07:44 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id q123-v6sm1323479ljb.60.2019.02.15.07.07.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 07:07:43 -0800 (PST)
Subject: Re: [Xen-devel][PATCH 1/2] xen/gntdev: Do not destroy context while
 dma-bufs are in use
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        jgross@suse.com
Cc:     Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20190214142321.1138-1-andr2000@gmail.com>
 <143411a8-385d-2cce-9211-22ba7db25a15@oracle.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <1c8d1612-f1b9-b080-2d11-432d811b25d1@gmail.com>
Date:   Fri, 15 Feb 2019 17:07:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <143411a8-385d-2cce-9211-22ba7db25a15@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/19 5:03 PM, Boris Ostrovsky wrote:
> On 2/14/19 9:23 AM, Oleksandr Andrushchenko wrote:
>>   
>>   /* DMA buffer export support. */
>> @@ -311,6 +317,7 @@ static void dmabuf_exp_release(struct kref *kref)
>>   
>>   	dmabuf_exp_wait_obj_signal(gntdev_dmabuf->priv, gntdev_dmabuf);
>>   	list_del(&gntdev_dmabuf->next);
>> +	fput(gntdev_dmabuf->priv->filp);
>>   	kfree(gntdev_dmabuf);
>>   }
>>   
>> @@ -423,6 +430,7 @@ static int dmabuf_exp_from_pages(struct gntdev_dmabuf_export_args *args)
>>   	mutex_lock(&args->dmabuf_priv->lock);
>>   	list_add(&gntdev_dmabuf->next, &args->dmabuf_priv->exp_list);
>>   	mutex_unlock(&args->dmabuf_priv->lock);
>> +	get_file(gntdev_dmabuf->priv->filp);
> Not fget()?
fget wants file descriptor [1] and returns struct file *,
but we already have struct file*, so I use get_file [2]
which does what I need - increments the reference counter
on the file
>
> -boris
>
>
[1] 
https://elixir.bootlin.com/linux/v5.0-rc6/source/include/linux/file.h#L46
[2] https://elixir.bootlin.com/linux/v5.0-rc6/source/include/linux/fs.h#L949
