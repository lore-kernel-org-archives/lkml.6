Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933196AbeEHIgA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 04:36:00 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44584 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932661AbeEHIf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 04:35:57 -0400
X-Google-Smtp-Source: AB8JxZpALLFRWeHvpH3xQSonAB1EV+JgBb8gIM+4U5KSCq/nKUxklYLIR9sOj+C148fDeID6P8nQ8A==
Subject: Re: [PATCH RFC] drivers: nvmem: Export nvmem_add_cells()
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org, andrew.smirnov@gmail.com
References: <1525547507-1428-1-git-send-email-andrew@lunn.ch>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e36b58db-d8e3-cd89-e7d3-adca01991732@linaro.org>
Date: Tue, 8 May 2018 09:35:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1525547507-1428-1-git-send-email-andrew@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/05/18 20:11, Andrew Lunn wrote:
> Not all platforms use device tree. It is useful to be able to add
> cells to a NVMEM device from code. Export nvmem_add_cells() so making
> this possible.
> 
> This required changing the parameters a bit, so that just the cells
> and the number of cells are passed, not the whole nvmem config
> structure.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

> ---
> 
> This is an RFC.
> 
> I have an intel platform with an AT24 EEPROM. I want to make use of
> nvmem, but don't have device tree to be able to specify cells. I have
> an x86 platform driver which does:
> 
> struct nvmem_cell_info nameplate_cells[] = {
>         {
>                 .name = "checksum",
>                 .offset = 2,
>                 .bytes = 1,
>         },
>         {
>                 .name = "part_number",
>                 .offset = 11,
>                 .bytes = 11,
>         },
> };
> 
>         err = nvmem_add_cells(nvmem, nameplate_cells,
>                               ARRAY_SIZE(nameplate_cells));
>         if (err) {
>                 dev_err(dev, "Error adding cells to nameplate nvmem device\n");
>                 return;
>         }
> 
>         cell = nvmem_cell_get(NULL, "checksum");
> 
> 
> drivers/nvmem/core.c           | 15 ++++++++-------
>   include/linux/nvmem-provider.h | 11 +++++++++++
>   2 files changed, 19 insertions(+), 7 deletions(-)
> 


Thanks Andrew for the patch,

Overall the patch looks good to me,
I would like to see some kernel doc for this new exported function

Thanks,
srini
