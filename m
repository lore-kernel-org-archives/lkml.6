Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934036AbeCMQS1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:18:27 -0400
Received: from gateway36.websitewelcome.com ([192.185.193.12]:37427 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933466AbeCMQSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:18:08 -0400
Subject: Re: [PATCH] drm/nouveau/secboot: remove VLA usage
To: David Laight <David.Laight@ACULAB.COM>,
        Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180313144812.GA30043@embeddedgus>
 <6977788dfbac4b70b54fd56310cc27fe@AcuMS.aculab.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <ba264656-6e56-e907-97c0-8cdd28ce8340@embeddedor.com>
Date: Tue, 13 Mar 2018 11:18:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6977788dfbac4b70b54fd56310cc27fe@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1evmcp-002fVM-Cl
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.117.58]:51778
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 03/13/2018 11:10 AM, David Laight wrote:
> From: Gustavo A. R. Silva
>> Sent: 13 March 2018 14:48
>> In preparation to enabling -Wvla, remove VLA. In this particular
>> case directly use macro NVKM_MSGQUEUE_CMDLINE_SIZE instead of local
>> variable cmdline_size. Also, remove cmdline_size as it is not
>> actually useful anymore.
> ...
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/ls_ucode_msgqueue.c
>> b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/ls_ucode_msgqueue.c
>> index 6f10b09..2da147b 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/ls_ucode_msgqueue.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/ls_ucode_msgqueue.c
>> @@ -80,12 +80,12 @@ acr_ls_msgqueue_post_run(struct nvkm_msgqueue *queue,
>>   			 struct nvkm_falcon *falcon, u32 addr_args)
>>   {
>>   	struct nvkm_device *device = falcon->owner->device;
>> -	u32 cmdline_size = NVKM_MSGQUEUE_CMDLINE_SIZE;
>> -	u8 buf[cmdline_size];
>> +	u8 buf[NVKM_MSGQUEUE_CMDLINE_SIZE];
>>
>> -	memset(buf, 0, cmdline_size);
>> +	memset(buf, 0, NVKM_MSGQUEUE_CMDLINE_SIZE);
>>   	nvkm_msgqueue_write_cmdline(queue, buf);
>> -	nvkm_falcon_load_dmem(falcon, buf, addr_args, cmdline_size, 0);
>> +	nvkm_falcon_load_dmem(falcon, buf, addr_args,
>> +			      NVKM_MSGQUEUE_CMDLINE_SIZE, 0);
> 
> I think I'd use 'sizeof (buf)' in both those lines.
> 

Yeah. I like it.

I'll send v2 with that change shortly.

Thanks
--
Gustavo
