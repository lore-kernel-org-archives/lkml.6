Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753066AbeDFNDD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:03:03 -0400
Received: from mail-ot0-f182.google.com ([74.125.82.182]:36711 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753050AbeDFNDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:03:01 -0400
X-Google-Smtp-Source: AIpwx4+4a/B176lqUrkPCn9R9slHTXgG6gOEiXY3o2XTFOO+0EQiyp0+VG6+TyLufNYFv5WkDByD3w==
Subject: Re: [PATCH v3] dell_rbu: make firmware payload memory uncachable
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, Douglas_Warzecha@Dell.com
References: <26829bed-39e5-c35d-8800-7116adaea603@gmail.com>
 <s5hsh8ayasq.wl-tiwai@suse.de>
From: Stuart Hayes <stuart.w.hayes@gmail.com>
Message-ID: <e94e085f-6b66-5a2f-9654-0ba47d13249b@gmail.com>
Date: Fri, 6 Apr 2018 08:02:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <s5hsh8ayasq.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/4/2018 3:30 PM, Takashi Iwai wrote:
> On Wed, 28 Mar 2018 17:07:47 +0200,
> Stuart Hayes wrote:
>>
>> @@ -180,6 +181,12 @@ static int create_packet(void *data, size_t length)
>>  			invalid_addr_packet_array[idx++] = packet_data_temp_buf;
>>  			packet_data_temp_buf = NULL;
>>  		}
>> +		/*
>> +		 * set to uncachable or it may never get written back before
>> +		 * reboot
>> +		 */
>> +		set_memory_uc((unsigned long)packet_data_temp_buf,
>> +			1 << ordernum);
> 
> Won't this cause Oops when the if-condition above meets?
> Namely packet_data_temp_buf is set to NULL there.
> 
> Maybe better to try a fault injection to check the error handling.
> 
> 
> thanks,
> 
> Takashi
> 

Yes, thank you for catching my mistake.
Stuart
