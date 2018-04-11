Return-Path: <kernel-hardening-return-12973-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/6LzdVYtRi5H21UYvlJHLSZK+fXfwtXnLizWWWQzhDi1uZ1w9Z6BgDUXoV5qdMUZpLS5RJ
ARC-Seal: i=1; a=rsa-sha256; t=1523439132; cv=none;
        d=google.com; s=arc-20160816;
        b=0eshE2KeCDD+9FBxiMPI+XxBAJRBADQmV6WAwVdMpYfk+osBICQ9e777MRmlRgBQ0o
         eZmmI2RjbiTZY/IFIl1z8PuqXC4CLn985qb5uojn9C/j2haYlHpHQmrfFqCqnI2WLSj3
         z6h0z6KdWhodWPcHwQWURmUQ2l0g/iKNgpkYpRxHsOFTnSHRtLN+GGJa1Czt1bj1j/Of
         VpO1y87dOo5UVM0wINh9FjOsd5BFo58FEKKjUQZ1nVHhWKVU0IOnZyUrU+aRizmIuNTj
         WoYklOP/gdjzfAYmqWfkAenM9imeEBADqYpkIi/6MlJoAq7W6Vqmr4Hk+ZMrQPvrN2Rw
         UeHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=J9qF3+MhHuEihjN+RUAEfbv6Qwn95siolUU6nnnCKSY=;
        b=AXn0rVwA+Aw2su9A3nfVS6yhUg0VqSP+wPYndlj9DksfUrjIbSNRV2XEibFcfrlLuN
         aoZ6KKyIEE2gtYqTxCiY25qiaVCkKH37FMJBDq8ODMT9IV4vJn44aiHXmVFauf3xgBJA
         yj3mi1eaFYuXIKQhq8m280PLfmgDEfsan8pvQrlH2TlBcbPYhUt7uBtcf3ntWYNS6Zm7
         3dUJvqxq9DIoIm9OqtgQ32+hJEFm1OiaajbpFqd7oH8YFcAcaXygrL1V+TIh3kZ2zw+K
         tb2fvlM92vNV+/aoPcX4uV7c8Pnfsjcn2Y823dtw+YsLU7tdx1S9CZEQj+yKy66kLNtm
         eZUA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@gmail.com header.s=20161025 header.b=iEkl0ZBL;
       spf=pass (google.com: domain of kernel-hardening-return-12973-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12973-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@gmail.com header.s=20161025 header.b=iEkl0ZBL;
       spf=pass (google.com: domain of kernel-hardening-return-12973-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12973-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCHv2] drm/amdkfd: Remove vla
To: Laura Abbott <labbott@redhat.com>, Oded Gabbay <oded.gabbay@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
Cc: Kees Cook <keescook@chromium.org>, kernel-hardening@lists.openwall.com,
 David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20180411010243.17771-1-labbott@redhat.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <5444bdd3-e97f-043e-9032-1a072bcca85d@gmail.com>
Date: Wed, 11 Apr 2018 11:30:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180411010243.17771-1-labbott@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597304222291643357?=
X-GMAIL-MSGID: =?utf-8?q?1597441712502839330?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am 11.04.2018 um 03:02 schrieb Laura Abbott:
> There's an ongoing effort to remove VLAs[1] from the kernel to eventually
> turn on -Wvla. Switch to a constant value that covers all hardware.
>
> [1] https://lkml.org/lkml/2018/3/7/621
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>

It would be nicer to have a define for that somewhere.

Anyway the patch is Acked-by: Christian König <christian.koenig@amd.com> 
for now.

Regards,
Christian.

> ---
> v2: Switch to a larger size to account for other hardware
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
> index 035c351f47c5..c3a5a80e31ae 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
> @@ -139,10 +139,12 @@ static void interrupt_wq(struct work_struct *work)
>   {
>   	struct kfd_dev *dev = container_of(work, struct kfd_dev,
>   						interrupt_work);
> +	uint32_t ih_ring_entry[8];
>   
> -	uint32_t ih_ring_entry[DIV_ROUND_UP(
> -				dev->device_info->ih_ring_entry_size,
> -				sizeof(uint32_t))];
> +	if (dev->device_info->ih_ring_entry_size > (8 * sizeof(uint32_t))) {
> +		dev_err(kfd_chardev(), "Ring entry too small\n");
> +		return;
> +	}
>   
>   	while (dequeue_ih_ring_entry(dev, ih_ring_entry))
>   		dev->device_info->event_interrupt_class->interrupt_wq(dev,
