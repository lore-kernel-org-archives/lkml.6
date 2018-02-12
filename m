Return-Path: <xieyisheng1@huawei.com>
X-Google-Smtp-Source: AH8x225ozMuQlv3VSNKgc7eOq/UVxiOpvYsBi8gtQP/UVjDMs8MfXYncJ908PLq2VMDQTLgxroeh
ARC-Seal: i=1; a=rsa-sha256; t=1518435684; cv=none;
        d=google.com; s=arc-20160816;
        b=kJzLDRjipMcTcEslL566OcLEvXZSF0k1RHEKTBG/QoKdTU/WV2cb+ORBFB5BGcv1Sb
         r/qQAmzYJV/LNsD4kpvEar92lUVoczbvODDHl/xLvcZ+tWDY4rOiQ4ZYyDDPpggrn49a
         egDJTotlCz8uUKJWkkpixT6Od1pS3b4WNFbu4S7XxXj/vlWn/F9HYcweChQAtm0wWMuy
         tN20ZqRz9vmws/7xUPP42QKYZganbtDF+vCJU4RHgve5GsG4AIEtQj2l8JXUMgdZL9IC
         G+tFlzrmBTVaG+9Eoq06TBpvPlvEjrK15TSFS+q5XC/G2AWG+9Pe6XEtEBR36q9y9XsK
         /uMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=ENQniBzWuoqFmfB1GKUelElCf93glh9NTqXhnh8qpbc=;
        b=Ez3ACBHd/pIql/8S12AZ/uWg27tFiuIDmGwsM3HDdF8cweVn897bXqLitrMBeO/fHS
         zd/vyIyG4rzNJjs5wmolARIPdFg/HMxdLErfF1VeFbcdySOWbOMIKRjH7z+vLMSONbsK
         YRbbCH9J6qCLFcOJ1OwxCeX+XhuVNDrM4RCeHs8PoHbWkYyoRz2Fvnw279/+60wDQiyu
         pUalM4H4wcHr+iQdq4s+uCxuYbcwg60QDr4q69W8pvDEWqjM2Is08gF3Mz4VQhOelZp/
         GizvtPc95HYB0pjQDOyfjcWGCa+iFkvfO3a/NJ+kf2d12Xoy+O3OybcYd4NZKbMwNDS2
         S+CQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of xieyisheng1@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=xieyisheng1@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of xieyisheng1@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=xieyisheng1@huawei.com
Subject: Re: [PATCH 1/2] staging: android: ion: Remove dead code in
 ion_page_pool_free
To: <gregkh@linuxfoundation.org>, <labbott@redhat.com>
References: <1517801177-37021-1-git-send-email-xieyisheng1@huawei.com>
CC: <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <e20bda6d-9132-57d7-e6d5-638b03efc97d@huawei.com>
Date: Mon, 12 Feb 2018 19:40:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <1517801177-37021-1-git-send-email-xieyisheng1@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591530516279929787?=
X-GMAIL-MSGID: =?utf-8?q?1592195215766086506?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

JFYI, I have rebase this patchset to v4.15-rc1.[1]

[1] https://lkml.org/lkml/2018/2/12/204

Thanks
Yisheng

On 2018/2/5 11:26, Yisheng Xie wrote:
> ion_page_pool_add will always return 0, however ion_page_pool_free will
> call ion_page_pool_free_pages when ion_page_pool_add's return value is
> not 0, so it is a dead code which can be removed.
> 
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>  drivers/staging/android/ion/ion_page_pool.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
> index 4452e28..150626f 100644
> --- a/drivers/staging/android/ion/ion_page_pool.c
> +++ b/drivers/staging/android/ion/ion_page_pool.c
> @@ -79,13 +79,9 @@ struct page *ion_page_pool_alloc(struct ion_page_pool *pool)
>  
>  void ion_page_pool_free(struct ion_page_pool *pool, struct page *page)
>  {
> -	int ret;
> -
>  	BUG_ON(pool->order != compound_order(page));
>  
> -	ret = ion_page_pool_add(pool, page);
> -	if (ret)
> -		ion_page_pool_free_pages(pool, page);
> +	ion_page_pool_add(pool, page);
>  }
>  
>  static int ion_page_pool_total(struct ion_page_pool *pool, bool high)
> 
