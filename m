Return-Path: <phil@raspberrypi.org>
X-Google-Smtp-Source: AG47ELvyxZO5fhARg/pHiVc8rrcUm6vzRHM/4VDvuF77OK7UFWzBjGzhiAucfTlphxQsiJdTiXUE
ARC-Seal: i=1; a=rsa-sha256; t=1520409764; cv=none;
        d=google.com; s=arc-20160816;
        b=PIssaXz8ik/p7kH+XDCUTodOZhqLsnOq1aFZpE6RoV4vQ1VX0eOfGb5ECJ+TgKylLi
         tkVBUZS5yEQwyjwh8LKO0JwFjB7zFT/gPavp4LqjCelTL8+6mdIOEP1C0goHFMIor9Ne
         Ig9hHYavDIKql9yzAswH7dyZwqVU0Bbfk/DpgwTmHyuJlb0heaIq4ftG9+pOoxRfumdS
         M5WvtDWBPurIM1SloVNu4hzleHiFipc9g3xTEMz+BA7tS7O5ZBFcVUcw0oRmSm/2HgHH
         1DAADetcEw5JHjgGuwT/GS+YUH/g7ZdsPCYeXHFdslRyab7bzSAm33SegIF/nk4Cx6lr
         vGkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=luSs04f2W7nQXtHlT82IJAf9w3Y4WchwfSLY+lizG4w=;
        b=lGeonwft6iMDSTr45Q990SSp/rMwi9nov7e5RS083xzZqCUYrxeD4QrU4XRlNaehIj
         WmddJBDdgQNzIipC1Qemug/myFPtuPWxO9DV8xyJfxTogsKOlnwEYXJdeNUA/ftWQ8Du
         el2qf5tHFUDmjP5gbUdbjNO/IFf5bnOk0jmrnJcRoAh5K4h8kUguSMmLpY6OkbTieBvo
         jZ6L75Rp+LhwyAUpreeO+M9rqrWzZ5llfgBdW64XIyUiHOBT+8GYM4TnXdgSbl6pzB9+
         riXJI7YOF6VCysjw3mL7s11jDJ1v+q4kddq4p9QA30P7lEHYq9VfkUoRt/kwRYpZOCL+
         SIAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@raspberrypi.org header.s=pp header.b=rwY59/QL;
       dkim=pass header.i=@raspberrypi-org.20150623.gappssmtp.com header.s=20150623 header.b=OYMh41kO;
       spf=pass (google.com: domain of phil@raspberrypi.org designates 62.209.51.214 as permitted sender) smtp.mailfrom=phil@raspberrypi.org
Authentication-Results: mx.google.com;
       dkim=fail header.i=@raspberrypi.org header.s=pp header.b=rwY59/QL;
       dkim=pass header.i=@raspberrypi-org.20150623.gappssmtp.com header.s=20150623 header.b=OYMh41kO;
       spf=pass (google.com: domain of phil@raspberrypi.org designates 62.209.51.214 as permitted sender) smtp.mailfrom=phil@raspberrypi.org
Subject: Re: [PATCH 2/5] staging: vc04_services: Remove cache-line-size
 property.
To: Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Mark Rutland
 <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20180305202806.21219-1-eric@anholt.net>
 <20180305202806.21219-3-eric@anholt.net>
 <a8f369f5-691c-c05f-4c7c-2eadcf4c48c8@i2se.com> <87muzl9ger.fsf@anholt.net>
From: Phil Elwell <phil@raspberrypi.org>
Message-ID: <638bd870-bb17-a0e1-d2aa-30a364b53279@raspberrypi.org>
Date: Wed, 7 Mar 2018 08:02:49 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87muzl9ger.fsf@anholt.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_03:,,
 signatures=0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594130896333791997?=
X-GMAIL-MSGID: =?utf-8?q?1594265189031333402?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Eric,

On 06/03/2018 19:02, Eric Anholt wrote:
> Stefan Wahren <stefan.wahren@i2se.com> writes:
> 
>> Hi Eric,
>>
>>
>> Am 05.03.2018 um 21:28 schrieb Eric Anholt:
>>> This was just a way for the DT-passed value to get out of sync with
>>> what Linux has configured the ARM for.
>>>
>>> Signed-off-by: Eric Anholt <eric@anholt.net>
>>> ---
>>>    .../interface/vchiq_arm/vchiq_2835_arm.c           | 25 +++++++---------------
>>>    .../interface/vchiq_arm/vchiq_pagelist.h           |  1 -
>>>    2 files changed, 8 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
>>> index b59ef14890aa..e0e01c812036 100644
>>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
>>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
>>> @@ -77,7 +77,6 @@ struct vchiq_pagelist_info {
>>>    };
>>>    
>>>    static void __iomem *g_regs;
>>> -static unsigned int g_cache_line_size = sizeof(CACHE_LINE_SIZE);
>>>    static unsigned int g_fragments_size;
>>>    static char *g_fragments_base;
>>>    static char *g_free_fragments;
>>> @@ -117,15 +116,7 @@ int vchiq_platform_init(struct platform_device *pdev, VCHIQ_STATE_T *state)
>>>    	if (err < 0)
>>>    		return err;
>>>    
>>> -	err = of_property_read_u32(dev->of_node, "cache-line-size",
>>> -				   &g_cache_line_size);
>>> -
>>> -	if (err) {
>>> -		dev_err(dev, "Missing cache-line-size property\n");
>>> -		return -ENODEV;
>>> -	}
>>> -
>>> -	g_fragments_size = 2 * g_cache_line_size;
>>> +	g_fragments_size = 2 * cache_line_size();
>>>    
>>>    	/* Allocate space for the channels in coherent memory */
>>>    	slot_mem_size = PAGE_ALIGN(TOTAL_SLOTS * VCHIQ_SLOT_SIZE);
>>> @@ -548,9 +539,9 @@ create_pagelist(char __user *buf, size_t count, unsigned short type)
>>>    
>>>    	/* Partial cache lines (fragments) require special measures */
>>>    	if ((type == PAGELIST_READ) &&
>>> -		((pagelist->offset & (g_cache_line_size - 1)) ||
>>> +		((pagelist->offset & (cache_line_size() - 1)) ||
>>>    		((pagelist->offset + pagelist->length) &
>>> -		(g_cache_line_size - 1)))) {
>>> +		 (cache_line_size() - 1)))) {
>>>    		char *fragments;
>>>    
>>>    		if (down_interruptible(&g_free_fragments_sema) != 0) {
>>> @@ -598,10 +589,10 @@ free_pagelist(struct vchiq_pagelist_info *pagelistinfo,
>>>    			g_fragments_size;
>>>    		int head_bytes, tail_bytes;
>>>    
>>> -		head_bytes = (g_cache_line_size - pagelist->offset) &
>>> -			(g_cache_line_size - 1);
>>> +		head_bytes = (cache_line_size() - pagelist->offset) &
>>> +			(cache_line_size() - 1);
>>>    		tail_bytes = (pagelist->offset + actual) &
>>> -			(g_cache_line_size - 1);
>>> +			(cache_line_size() - 1);
>>
>> should it be so easy? Back in 2016 we said that cache_line_size() won't
>> work. I always thought that we need the cache line size of L2 not of the
>> L1 one.
>>
>> Did you already test the behavior for these combinations?
>> BCM2835 ARM32, expected cache line size = 32
>> BCM2836 ARM32, expected cache line size = 64
>> BCM2837 ARM32, expected cache line size = 64
>> BCM2837 ARM64, expected cache line size = 64
> 
> I didn't explicitly test, but was going by:
> 
> config ARM_L1_CACHE_SHIFT_6
> 	bool
> 	default y if CPU_V7
> 	help
> 	  Setting ARM L1 cache line size to 64 Bytes.
> 
> config ARM_L1_CACHE_SHIFT_7
> 	bool
> 	help
> 	  Setting ARM L1 cache line size to 128 Bytes.
> 
> config ARM_L1_CACHE_SHIFT
> 	int
> 	default 7 if ARM_L1_CACHE_SHIFT_7
> 	default 6 if ARM_L1_CACHE_SHIFT_6
> 	default 5
> 
> and only L1_CACHE_SHIFT_7 gets selected by UNIPHIER and neither one is
> accessible by menus.
> 
> I think you're technically correct that it's the size of L2 that matters
> (or, specifically, the hardcoded value that the firmware is using on its
> side for the fragments list handling.  It overrides a cache-line-size DT
> property with that number if present).  However, I think L1==L2 cache
> line size this should be a safe assumption for us.
> 
> Phil, any opinion?

It is the L2 cache line size that matters, but as long as you end up with
the numbers Stefan mentioned - 32 on BCM2835, 64 on BCM2836 and BCM2837 -
I'm not too bothered how you get there.

Phil
