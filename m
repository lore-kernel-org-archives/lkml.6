Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752746AbeDJLEu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 07:04:50 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:34354 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751943AbeDJLEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 07:04:48 -0400
X-Google-Smtp-Source: AIpwx48sCijvR45PolkiBuo1hu25sR6IRea7tBAo5KyGWIHDl+daoak8WhsCej7P0eyNxQbRgIZPig==
Subject: Re: [Xen-devel] [RFC, v2, 1/9] hyper_dmabuf: initial upload of
 hyper_dmabuf drv core framework
To: Julien Grall <julien.grall@arm.com>,
        Dongwon Kim <dongwon.kim@intel.com>, linux-kernel@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, xen-devel@lists.xenproject.org
Cc: mateuszx.potrola@intel.com, dri-devel@lists.freedesktop.org
References: <20180214015008.9513-2-dongwon.kim@intel.com>
 <7647f032-29ee-ef83-d0a6-b625cef00b72@gmail.com>
 <05859c14-e4a9-db9e-bb4c-35aa26d04c23@arm.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <2cc94762-d027-95bb-9e0d-c72e98da082c@gmail.com>
Date: Tue, 10 Apr 2018 14:04:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <05859c14-e4a9-db9e-bb4c-35aa26d04c23@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2018 01:47 PM, Julien Grall wrote:
> Hi,
>
> On 04/10/2018 09:53 AM, Oleksandr Andrushchenko wrote:
>> On 02/14/2018 03:50 AM, Dongwon Kim wrote:
>>> diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_id.h 
>
> [...]
>
>>> +#ifndef __HYPER_DMABUF_ID_H__
>>> +#define __HYPER_DMABUF_ID_H__
>>> +
>>> +#define HYPER_DMABUF_ID_CREATE(domid, cnt) \
>>> +    ((((domid) & 0xFF) << 24) | ((cnt) & 0xFFFFFF))
>> I would define hyper_dmabuf_id_t.id as a union or 2 separate
>> fields to avoid his magic
>
> I am not sure the union would be right here because the layout will 
> differs between big and little endian.
Agree
> So does that value will be passed to other guest?
As per my understanding yes, with HYPER_DMABUF_EXPORT request
>
> Cheers,
>
