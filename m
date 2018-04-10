Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751945AbeDJKrq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 06:47:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36426 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751471AbeDJKrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 06:47:46 -0400
Subject: Re: [Xen-devel] [RFC, v2, 1/9] hyper_dmabuf: initial upload of
 hyper_dmabuf drv core framework
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        Dongwon Kim <dongwon.kim@intel.com>, linux-kernel@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, xen-devel@lists.xenproject.org
Cc: mateuszx.potrola@intel.com, dri-devel@lists.freedesktop.org
References: <20180214015008.9513-2-dongwon.kim@intel.com>
 <7647f032-29ee-ef83-d0a6-b625cef00b72@gmail.com>
From: Julien Grall <julien.grall@arm.com>
Message-ID: <05859c14-e4a9-db9e-bb4c-35aa26d04c23@arm.com>
Date: Tue, 10 Apr 2018 11:47:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <7647f032-29ee-ef83-d0a6-b625cef00b72@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04/10/2018 09:53 AM, Oleksandr Andrushchenko wrote:
> On 02/14/2018 03:50 AM, Dongwon Kim wrote:
>> diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_id.h 

[...]

>> +#ifndef __HYPER_DMABUF_ID_H__
>> +#define __HYPER_DMABUF_ID_H__
>> +
>> +#define HYPER_DMABUF_ID_CREATE(domid, cnt) \
>> +    ((((domid) & 0xFF) << 24) | ((cnt) & 0xFFFFFF))
> I would define hyper_dmabuf_id_t.id as a union or 2 separate
> fields to avoid his magic

I am not sure the union would be right here because the layout will 
differs between big and little endian. So does that value will be passed 
to other guest?

Cheers,

-- 
Julien Grall
