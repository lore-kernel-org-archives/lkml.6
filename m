Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A284AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A1E21924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDf3GHth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395317AbfBOPfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:35:42 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38370 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437254AbfBOPfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:35:39 -0500
Received: by mail-lf1-f67.google.com with SMTP id n15so7494379lfe.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 07:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8Zo4AXsP0umX0JaYRcr4jO/N1bZPnsPvjYbdDTv2kNc=;
        b=SDf3GHthIiQGOQRcUE6epGaRnjBMzQpJGugtvlD/SFtJTspflEto8qbSfrQ5wzvTz2
         IOoBlulUF5z4DCpG8B+na35KcxzuwB1+i74m4mfAFLGHYl2Ujo1shLIG3cen8dbUzTAX
         o7u5GRYQmFApMIMkAxDWxtQJge+j7Tetu68uu1rYwnK57kZWvQh1j210WpY1xmWE5jB2
         xLUVpinFH4j8sVpMcDDuROfjAKTQFDze1FHnEi5lLbRy6jkcS7ARlQZONvf5Zmic7fYc
         EG6zj5uM7qiHbIhnYWG/9/WJDINPXpCJKxBLC2BguQFEKCEHKWW4Y62YQYDygT4+VXS/
         0XWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8Zo4AXsP0umX0JaYRcr4jO/N1bZPnsPvjYbdDTv2kNc=;
        b=oRUyAnO6WIXeBUnn01CNlsO8tdLTDSbNkQkw3nttLBYM9J3wCpWBuUdHjn8/5iX/u+
         N45pye+agK0jU2hysrAHVtu/IKEO/3uv1na+b2ADXMEreQRRkdJtSHwrpXrWpWB8Wtgr
         ucZjgF3S1YyNoBeuMIgR9yk6oMQR8XviVUnxhXlQgGXyoeKd+2dR7RMQTC/vR3lbOq0c
         42baalYAhc4sHBj341nu+nvl75VPXIzatrKi7FluPc65RJISa5B0L8CINymRzszAxiIV
         eZpxZTIt5eJxvsnLW1IyB5YT51/sM8uOIJNYXKGoSTe7mn2qJcczOvUF8p4s7cWqpXCb
         2bBw==
X-Gm-Message-State: AHQUAuY7oK9kYL6BcC8hEBb16Law4IXbSy49RWt3JO8BXu6iB07CWwM1
        IsCx+P0tGrrngWmLMqUMwyM=
X-Google-Smtp-Source: AHgI3IamULRNCUsr/9rtT5I4Tcu+yC/ZXkvTH8P34kb7/Nmwkgfya0ojxyYnNsR6lGg1ISCrXad5FA==
X-Received: by 2002:a19:cf4f:: with SMTP id f76mr5841316lfg.125.1550244937042;
        Fri, 15 Feb 2019 07:35:37 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id p5sm1252240ljg.44.2019.02.15.07.35.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 07:35:36 -0800 (PST)
Subject: Re: [Xen-devel][PATCH 1/2] xen/gntdev: Do not destroy context while
 dma-bufs are in use
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        jgross@suse.com
Cc:     Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20190214142321.1138-1-andr2000@gmail.com>
 <143411a8-385d-2cce-9211-22ba7db25a15@oracle.com>
 <1c8d1612-f1b9-b080-2d11-432d811b25d1@gmail.com>
 <eddff494-8cc7-f796-156e-e2e9e3d2daae@oracle.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <6e9f502c-3d60-32fb-d737-b016cfa5a7f1@gmail.com>
Date:   Fri, 15 Feb 2019 17:35:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <eddff494-8cc7-f796-156e-e2e9e3d2daae@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/19 5:28 PM, Boris Ostrovsky wrote:
> On 2/15/19 10:07 AM, Oleksandr Andrushchenko wrote:
>> On 2/15/19 5:03 PM, Boris Ostrovsky wrote:
>>> On 2/14/19 9:23 AM, Oleksandr Andrushchenko wrote:
>>>>      /* DMA buffer export support. */
>>>> @@ -311,6 +317,7 @@ static void dmabuf_exp_release(struct kref *kref)
>>>>          dmabuf_exp_wait_obj_signal(gntdev_dmabuf->priv, gntdev_dmabuf);
>>>>        list_del(&gntdev_dmabuf->next);
>>>> +    fput(gntdev_dmabuf->priv->filp);
>>>>        kfree(gntdev_dmabuf);
>>>>    }
>>>>    @@ -423,6 +430,7 @@ static int dmabuf_exp_from_pages(struct
>>>> gntdev_dmabuf_export_args *args)
>>>>        mutex_lock(&args->dmabuf_priv->lock);
>>>>        list_add(&gntdev_dmabuf->next, &args->dmabuf_priv->exp_list);
>>>>        mutex_unlock(&args->dmabuf_priv->lock);
>>>> +    get_file(gntdev_dmabuf->priv->filp);
>>> Not fget()?
>> fget wants file descriptor [1] and returns struct file *,
>> but we already have struct file*, so I use get_file [2]
>> which does what I need - increments the reference counter
>> on the file
>
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Thank you,
any chance we can get this for 5.1?
