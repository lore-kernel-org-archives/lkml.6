Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756070AbeCHSWN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 13:22:13 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:37277 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755624AbeCHSWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 13:22:11 -0500
X-Google-Smtp-Source: AG47ELufRoy4pAXnQr3a0bCuMTYB0ZSsabFJRVKOr3JM1FbRsjKGwWCwUQUcMBCQQJFTi1ZMjEtv43WO0/7HDFWyPmc=
MIME-Version: 1.0
In-Reply-To: <1519842888.8089.88.camel@mtkswgap22>
References: <20180103200114.23922-1-andrew.smirnov@gmail.com>
 <20180103200114.23922-2-andrew.smirnov@gmail.com> <1519842888.8089.88.camel@mtkswgap22>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 8 Mar 2018 10:22:09 -0800
Message-ID: <CAHQ1cqGCX8eFt4x-G=V6YnM64kr8cHXauVjepFi47uaX_hn6Vw@mail.gmail.com>
Subject: Re: [PATCH v3 01/22] nvmem: Document struct nvmem_config
To: Sean Wang <sean.wang@mediatek.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-amlogic@lists.infradead.org, Carlo Caione <carlo@caione.org>,
        Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 10:34 AM, Sean Wang <sean.wang@mediatek.com> wrote:
> On Wed, 2018-01-03 at 12:00 -0800, Andrey Smirnov wrote:
>> Add a simple description of struct nvmem_config and its fields.
>>
>> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Cc: Heiko Stuebner <heiko@sntech.de>
>> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Cc: Carlo Caione <carlo@caione.org>
>> Cc: Kevin Hilman <khilman@baylibre.com>
>> Cc: Matthias Brugger <matthias.bgg@gmail.com>
>> Cc: cphealy@gmail.com
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-mediatek@lists.infradead.org
>> Cc: linux-rockchip@lists.infradead.org
>> Cc: linux-amlogic@lists.infradead.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>  include/linux/nvmem-provider.h | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
>> index 497706f5adca..27e599222ec1 100644
>> --- a/include/linux/nvmem-provider.h
>> +++ b/include/linux/nvmem-provider.h
>> @@ -22,6 +22,28 @@ typedef int (*nvmem_reg_read_t)(void *priv, unsigned int offset,
>>  typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
>>                                void *val, size_t bytes);
>>
>> +/**
>> + * struct nvmem_config - NVMEM device configuration
>> + *
>> + * @dev:     Parent device.
>> + * @name:    Optional name.
>> + * @id:              Optional device ID used in full name. Ignored if name is NULL.
>> + * @owner:   Pointer to exporter module. Used for refcounting.
>> + * @cells:   Optional array of pre-defined NVMEM cells.
>> + * @ncells:  Number of elements in cells.
>> + * @read_only:       Device is read-only.
>> + * @root_only:       Device is accessibly to root only.
>> + * @reg_read:        Callback to read data.
>> + * @reg_write:       Callback to write data.
>> + * @size:    Device size.
>> + * @word_size:       Minimum read/write access granularity.
>> + * @stride:  Minimum read/write access stide.
>
> typo on stide ?

Definitely, will fix in next version.

Thanks,
Andrey Smirnov
