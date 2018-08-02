Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14C7C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652E2208DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vbE/zplH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 652E2208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387583AbeHBO7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:59:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43190 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387421AbeHBO7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:59:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id d17-v6so1157798pgv.10;
        Thu, 02 Aug 2018 06:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VuW86wa96t3ez7wcmNMogdD0V44YmRXIyDyX3komb7E=;
        b=vbE/zplHti1cpSgLhG5Il5RhM4rKi/1gW+0HPsIIikvx/7+NPRu0sP3WXoKWRMB/bC
         eDNOlpwy1ICtgVyfFpvE5K7YzkOHwbe2oR//NBmHbKO2Bx1WOfBvOnOBRyKsfBWVkm32
         HbLOx3ZVVd0TDzd8gTSq0+20bUQsYA3lC4GObTFXysVPKNVlDawnn/go3HW2Hg5AvVGE
         YOrPs5E5Eyj7ldCMtAyLxZ8xyUESkFJGK1s1GKN5uYrE03QblQrpd7YOe2JDrZfopi/u
         VFqTTVJIci/BZN38IcPEtEWCCy9G/zkoo/9z97kFCFfsmTUDGvFzID67yGCapPBNUgOK
         64mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VuW86wa96t3ez7wcmNMogdD0V44YmRXIyDyX3komb7E=;
        b=SHKHpgBysyWR4XOLFfDneUzqXySMUB2boOKr/ZDQ3bj8hzqOjgxE1uf9OO2TfylNMn
         JFhjcqLdZCSFZVzzd1RoqvsOp7SglLCm6Me21uNxLZIEjXOKSFAfl6YOii8hKiUISrc3
         pVasLefhkjN2Bgo8tvRTxXa4ORhkiMyD7EeV3mr6jn2ktJN29ySGjToXyzreU0uzfZyh
         eo58KfoY/Quz7AoMwM0djImTVCADvIMBhzo5ulPLC/seuHOe9vGxNJNueHFCrkUqPB7C
         YVLIbDe95hcBAy0z2uiKmpeBwqu1a4c78VHvmL0llczAYmE80ZdgaNskTWa7Eg+ztBJc
         vktQ==
X-Gm-Message-State: AOUpUlEHEk8wO5rCdToaP9d9avWyhub9k4ME3tedfhT7amKY/X6TjGv/
        kVaSkL+KNkvy/d5753Wn+uA=
X-Google-Smtp-Source: AAOMgpeXhqHeEMghICKfHTkMTouL7boHint8U6UGm4luirzW6CsF0OyFEvmIy97WUJ6gYvZsy10G1w==
X-Received: by 2002:a63:5025:: with SMTP id e37-v6mr2754096pgb.341.1533215316552;
        Thu, 02 Aug 2018 06:08:36 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id z184-v6sm2605028pgd.83.2018.08.02.06.08.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 06:08:35 -0700 (PDT)
Subject: Re: [PATCH 1/1] selftest/net: fix FILE_SIZE for 32 bit architecture.
To:     Maninder Singh <maninder1.s@samsung.com>, davem@davemloft.net,
        shuahkh@osg.samsung.com
Cc:     netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, edumazet@google.com,
        pankaj.m@samsung.com, a.sahrawat@samsung.com,
        Vaneet Narang <v.narang@samsung.com>
References: <CGME20180802103616epcas5p48ec1e2ea3568b11683aa7b55254dffb0@epcas5p4.samsung.com>
 <20180802103616epcas5p48ec1e2ea3568b11683aa7b55254dffb0~HCuTv0d7l2131721317epcas5p4u@epcas5p4.samsung.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <4a412194-99aa-7969-54a4-727368fbf82c@gmail.com>
Date:   Thu, 2 Aug 2018 06:08:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180802103616epcas5p48ec1e2ea3568b11683aa7b55254dffb0~HCuTv0d7l2131721317epcas5p4u@epcas5p4.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/02/2018 03:31 AM, Maninder Singh wrote:
> FILE_SZ is defined as (1UL << 35), it will overflow
> for 32 bit system and logic will break.
> 
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> ---
>  tools/testing/selftests/net/tcp_mmap.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/tcp_mmap.c b/tools/testing/selftests/net/tcp_mmap.c
> index e8c5dff..1d6ca12 100644
> --- a/tools/testing/selftests/net/tcp_mmap.c
> +++ b/tools/testing/selftests/net/tcp_mmap.c
> @@ -85,7 +85,7 @@
>  #define MSG_ZEROCOPY    0x4000000
>  #endif
>  
> -#define FILE_SZ (1UL << 35)
> +#define FILE_SZ (1ULL << 35)
>  static int cfg_family = AF_INET6;
>  static socklen_t cfg_alen = sizeof(struct sockaddr_in6);
>  static int cfg_port = 8787;
> @@ -134,7 +134,7 @@ void hash_zone(void *zone, unsigned int length)
>  
>  void *child_thread(void *arg)
>  {
> -	unsigned long total_mmap = 0, total = 0;
> +	unsigned long long total_mmap = 0, total = 0;
>  	struct tcp_zerocopy_receive zc;
>  	unsigned long delta_usec;
>  	int flags = MAP_SHARED;
> @@ -316,7 +316,7 @@ int main(int argc, char *argv[])
>  {
>  	struct sockaddr_storage listenaddr, addr;
>  	unsigned int max_pacing_rate = 0;
> -	unsigned long total = 0;
> +	unsigned long long total = 0;
>  	char *host = NULL;
>  	int fd, c, on = 1;
>  	char *buffer;
> @@ -431,7 +431,7 @@ int main(int argc, char *argv[])
>  		zflg = 0;
>  	}
>  	while (total < FILE_SZ) {
> -		long wr = FILE_SZ - total;
> +		unsigned long long wr = FILE_SZ - total;
>  
>  		if (wr > chunk_size)
>  			wr = chunk_size;
> 

What about using more conventional size_t instead of "unsigned long long" ?

