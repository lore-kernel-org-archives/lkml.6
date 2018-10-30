Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E57C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348392075D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITPcJ5fs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 348392075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbeJaB4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:56:54 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35480 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbeJaB4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:56:53 -0400
Received: by mail-yb1-f195.google.com with SMTP id k132-v6so5347565ybc.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 10:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u2mePoA+nojcVy58AkGqsv4fyMjLL5fMupNWy9ys66E=;
        b=ITPcJ5fst5XNNpEipd4DOrIb4XfsJqfzbMglaCDR6c4K9jU4y9z008TxQmo9ckwVgl
         myeSLK7UfUPTxcSlWxkDSutUsC6wbZXFB/xYdTJipe2KhpoGuZJYhGJ06xDN1GuTBxaM
         fYF1p3e1DDtH2ODZGobNFG7JiRwjrqjKyQuJ2k3NZf1x3lmY5bKb/CUmf0Dmg/4T9x/E
         dJG7JJ1bi/TEssn3Rib1sblUz3QDXseYGH8yWktH3gWru90k5N5bBz4D3f7CRdCq68Tk
         8XtyqUpV4r7iWMTntvbQnqfbN4wRgCk2CJee66+F0gqSdB7SKUiduBc+mQslM2PmHqUQ
         3OEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=u2mePoA+nojcVy58AkGqsv4fyMjLL5fMupNWy9ys66E=;
        b=cnh74Q8OsuE8mMFhxnlefpfPZ9+eBfHlsUhynNCb2GGz7NOfPgD7DjQ5STLp8H/BQg
         qI+oSVgpwQeyIkoxtTDvlZKbNU9dhEEv/BBOboVGLlUqk4Fsme88WQ9NhsfCXTSYGO+O
         tBvy7wbN1GEK4ZJnU+58ysv1he3UItOSQwfMo0/012/lnNSi8JWPEb20ps8PX8ptj6NZ
         0KN+UYO1QfeV7Zsl0exzzGTOlVXB4CAVSkdPNsu+SRIFLL7n48eKKRXefNlCNZKFNfLt
         ODrXkkOSmPx0bo1rJMY0Cg9Wg17N27ixjz38XXd4XD8MRyZvCSdpvcDCl9ccWLvvlgsU
         +tDg==
X-Gm-Message-State: AGRZ1gK4i+0tAx5PPPiJzGjBrprrnmraFywBGMEqiBtzrrqhQr8RLQb0
        pACX3wAREZi0whLOVo/a2og=
X-Google-Smtp-Source: AJdET5fRqvoO3dJLwCIWiX/cPqWVHl7N9MGPgwTtE0RE+48XMVFZ8496mp/iCu4IMBAqRzrP2DnAyA==
X-Received: by 2002:a25:aea1:: with SMTP id b33-v6mr19227433ybj.257.1540918954627;
        Tue, 30 Oct 2018 10:02:34 -0700 (PDT)
Received: from [10.67.49.121] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id m16-v6sm2594587ywh.18.2018.10.30.10.02.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 10:02:33 -0700 (PDT)
Subject: Re: [PATCH] soc: ti: QMSS: Fix usage of irq_set_affinity_hint
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20181030111103.12110-1-marc.zyngier@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 xsDiBEjPuBIRBACW9MxSJU9fvEOCTnRNqG/13rAGsj+vJqontvoDSNxRgmafP8d3nesnqPyR
 xGlkaOSDuu09rxuW+69Y2f1TzjFuGpBk4ysWOR85O2Nx8AJ6fYGCoeTbovrNlGT1M9obSFGQ
 X3IzRnWoqlfudjTO5TKoqkbOgpYqIo5n1QbEjCCwCwCg3DOH/4ug2AUUlcIT9/l3pGvoRJ0E
 AICDzi3l7pmC5IWn2n1mvP5247urtHFs/uusE827DDj3K8Upn2vYiOFMBhGsxAk6YKV6IP0d
 ZdWX6fqkJJlu9cSDvWtO1hXeHIfQIE/xcqvlRH783KrihLcsmnBqOiS6rJDO2x1eAgC8meAX
 SAgsrBhcgGl2Rl5gh/jkeA5ykwbxA/9u1eEuL70Qzt5APJmqVXR+kWvrqdBVPoUNy/tQ8mYc
 nzJJ63ng3tHhnwHXZOu8hL4nqwlYHRa9eeglXYhBqja4ZvIvCEqSmEukfivk+DlIgVoOAJbh
 qIWgvr3SIEuR6ayY3f5j0f2ejUMYlYYnKdiHXFlF9uXm1ELrb0YX4GMHz80nRmxvcmlhbiBG
 YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+wmYEExECACYCGyMGCwkIBwMCBBUCCAME
 FgIDAQIeAQIXgAUCVF/S8QUJHlwd3wAKCRBhV5kVtWN2DvCVAJ4u4/bPF4P3jxb4qEY8I2gS
 6hG0gACffNWlqJ2T4wSSn+3o7CCZNd7SLSDOw00ESM+4EhAQAL/o09boR9D3Vk1Tt7+gpYr3
 WQ6hgYVON905q2ndEoA2J0dQxJNRw3snabHDDzQBAcqOvdi7YidfBVdKi0wxHhSuRBfuOppu
 pdXkb7zxuPQuSveCLqqZWRQ+Cc2QgF7SBqgznbe6Ngout5qXY5Dcagk9LqFNGhJQzUGHAsIs
 hap1f0B1PoUyUNeEInV98D8Xd/edM3mhO9nRpUXRK9Bvt4iEZUXGuVtZLT52nK6Wv2EZ1TiT
 OiqZlf1P+vxYLBx9eKmabPdm3yjalhY8yr1S1vL0gSA/C6W1o/TowdieF1rWN/MYHlkpyj9c
 Rpc281gAO0AP3V1G00YzBEdYyi0gaJbCEQnq8Vz1vDXFxHzyhgGz7umBsVKmYwZgA8DrrB0M
 oaP35wuGR3RJcaG30AnJpEDkBYHznI2apxdcuTPOHZyEilIRrBGzDwGtAhldzlBoBwE3Z3MY
 31TOpACu1ZpNOMysZ6xiE35pWkwc0KYm4hJA5GFfmWSN6DniimW3pmdDIiw4Ifcx8b3mFrRO
 BbDIW13E51j9RjbO/nAaK9ndZ5LRO1B/8Fwat7bLzmsCiEXOJY7NNpIEpkoNoEUfCcZwmLrU
 +eOTPzaF6drw6ayewEi5yzPg3TAT6FV3oBsNg3xlwU0gPK3v6gYPX5w9+ovPZ1/qqNfOrbsE
 FRuiSVsZQ5s3AAMFD/9XjlnnVDh9GX/r/6hjmr4U9tEsM+VQXaVXqZuHKaSmojOLUCP/YVQo
 7IiYaNssCS4FCPe4yrL4FJJfJAsbeyDykMN7wAnBcOkbZ9BPJPNCbqU6dowLOiy8AuTYQ48m
 vIyQ4Ijnb6GTrtxIUDQeOBNuQC/gyyx3nbL/lVlHbxr4tb6YkhkO6shjXhQh7nQb33FjGO4P
 WU11Nr9i/qoV8QCo12MQEo244RRA6VMud06y/E449rWZFSTwGqb0FS0seTcYNvxt8PB2izX+
 HZA8SL54j479ubxhfuoTu5nXdtFYFj5Lj5x34LKPx7MpgAmj0H7SDhpFWF2FzcC1bjiW9mjW
 HaKaX23Awt97AqQZXegbfkJwX2Y53ufq8Np3e1542lh3/mpiGSilCsaTahEGrHK+lIusl6mz
 Joil+u3k01ofvJMK0ZdzGUZ/aPMZ16LofjFA+MNxWrZFrkYmiGdv+LG45zSlZyIvzSiG2lKy
 kuVag+IijCIom78P9jRtB1q1Q5lwZp2TLAJlz92DmFwBg1hyFzwDADjZ2nrDxKUiybXIgZp9
 aU2d++ptEGCVJOfEW4qpWCCLPbOT7XBr+g/4H3qWbs3j/cDDq7LuVYIe+wchy/iXEJaQVeTC
 y5arMQorqTFWlEOgRA8OP47L9knl9i4xuR0euV6DChDrguup2aJVU8JPBBgRAgAPAhsMBQJU
 X9LxBQkeXB3fAAoJEGFXmRW1Y3YOj4UAn3nrFLPZekMeqX5aD/aq/dsbXSfyAKC45Go0YyxV
 HGuUuzv+GKZ6nsysJw==
Message-ID: <1d813bdf-3161-1514-0368-48fbe24f2205@gmail.com>
Date:   Tue, 30 Oct 2018 10:02:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030111103.12110-1-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/18 4:11 AM, Marc Zyngier wrote:
> The Keystone QMSS driver is pretty damaged, in the sense that it
> does things like this:
> 
> 	irq_set_affinity_hint(irq, to_cpumask(&cpu_map));
> 
> where cpu_map is a local variable. As we leave the function, this
> will point to nowhere-land, and things will end-up badly.
> 
> Instead, let's use a proper cpumask that gets allocated, giving
> the driver a chance to actually work with things like irqbalance
> as well as have a hypothetical 64bit future.

Since this is at least the second patch from you that I can see in this
area, would it make sense to sprinkle object_is_on_stack() checks
throughout irq_set_affinity_hint() to help catch offenders?

> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> I found this one by inspection after finding a similar bug in an
> unrelated driver. It is only compile-tested. It would probably
> a Cc stable, but that's Santosh's decision.
> 
>  drivers/soc/ti/knav_qmss.h       |  4 ++--
>  drivers/soc/ti/knav_qmss_acc.c   | 10 +++++-----
>  drivers/soc/ti/knav_qmss_queue.c | 22 +++++++++++++++-------
>  3 files changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/soc/ti/knav_qmss.h b/drivers/soc/ti/knav_qmss.h
> index 3efc47e82973..bd040c29c4bf 100644
> --- a/drivers/soc/ti/knav_qmss.h
> +++ b/drivers/soc/ti/knav_qmss.h
> @@ -329,8 +329,8 @@ struct knav_range_ops {
>  };
>  
>  struct knav_irq_info {
> -	int	irq;
> -	u32	cpu_map;
> +	int		irq;
> +	struct cpumask	*cpu_mask;
>  };
>  
>  struct knav_range_info {
> diff --git a/drivers/soc/ti/knav_qmss_acc.c b/drivers/soc/ti/knav_qmss_acc.c
> index 316e82e46f6c..2f7fb2dcc1d6 100644
> --- a/drivers/soc/ti/knav_qmss_acc.c
> +++ b/drivers/soc/ti/knav_qmss_acc.c
> @@ -205,18 +205,18 @@ static int knav_range_setup_acc_irq(struct knav_range_info *range,
>  {
>  	struct knav_device *kdev = range->kdev;
>  	struct knav_acc_channel *acc;
> -	unsigned long cpu_map;
> +	struct cpumask *cpu_mask;
>  	int ret = 0, irq;
>  	u32 old, new;
>  
>  	if (range->flags & RANGE_MULTI_QUEUE) {
>  		acc = range->acc;
>  		irq = range->irqs[0].irq;
> -		cpu_map = range->irqs[0].cpu_map;
> +		cpu_mask = range->irqs[0].cpu_mask;
>  	} else {
>  		acc = range->acc + queue;
>  		irq = range->irqs[queue].irq;
> -		cpu_map = range->irqs[queue].cpu_map;
> +		cpu_mask = range->irqs[queue].cpu_mask;
>  	}
>  
>  	old = acc->open_mask;
> @@ -239,8 +239,8 @@ static int knav_range_setup_acc_irq(struct knav_range_info *range,
>  			acc->name, acc->name);
>  		ret = request_irq(irq, knav_acc_int_handler, 0, acc->name,
>  				  range);
> -		if (!ret && cpu_map) {
> -			ret = irq_set_affinity_hint(irq, to_cpumask(&cpu_map));
> +		if (!ret && cpu_mask) {
> +			ret = irq_set_affinity_hint(irq, cpu_mask);
>  			if (ret) {
>  				dev_warn(range->kdev->dev,
>  					 "Failed to set IRQ affinity\n");
> diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
> index b5d5673c255c..8b418379272d 100644
> --- a/drivers/soc/ti/knav_qmss_queue.c
> +++ b/drivers/soc/ti/knav_qmss_queue.c
> @@ -118,19 +118,17 @@ static int knav_queue_setup_irq(struct knav_range_info *range,
>  			  struct knav_queue_inst *inst)
>  {
>  	unsigned queue = inst->id - range->queue_base;
> -	unsigned long cpu_map;
>  	int ret = 0, irq;
>  
>  	if (range->flags & RANGE_HAS_IRQ) {
>  		irq = range->irqs[queue].irq;
> -		cpu_map = range->irqs[queue].cpu_map;
>  		ret = request_irq(irq, knav_queue_int_handler, 0,
>  					inst->irq_name, inst);
>  		if (ret)
>  			return ret;
>  		disable_irq(irq);
> -		if (cpu_map) {
> -			ret = irq_set_affinity_hint(irq, to_cpumask(&cpu_map));
> +		if (range->irqs[queue].cpu_mask) {
> +			ret = irq_set_affinity_hint(irq, range->irqs[queue].cpu_mask);
>  			if (ret) {
>  				dev_warn(range->kdev->dev,
>  					 "Failed to set IRQ affinity\n");
> @@ -1262,9 +1260,19 @@ static int knav_setup_queue_range(struct knav_device *kdev,
>  
>  		range->num_irqs++;
>  
> -		if (IS_ENABLED(CONFIG_SMP) && oirq.args_count == 3)
> -			range->irqs[i].cpu_map =
> -				(oirq.args[2] & 0x0000ff00) >> 8;
> +		if (IS_ENABLED(CONFIG_SMP) && oirq.args_count == 3) {
> +			unsigned long mask;
> +			int bit;
> +
> +			range->irqs[i].cpu_mask = devm_kzalloc(dev,
> +							       cpumask_size(), GFP_KERNEL);
> +			if (!range->irqs[i].cpu_mask)
> +				return -ENOMEM;
> +
> +			mask = (oirq.args[2] & 0x0000ff00) >> 8;
> +			for_each_set_bit(bit, &mask, BITS_PER_LONG)
> +				cpumask_set_cpu(bit, range->irqs[i].cpu_mask);
> +		}
>  	}
>  
>  	range->num_irqs = min(range->num_irqs, range->num_queues);
> 


-- 
Florian
