Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x224z5CKtDiVxOCgcTu/r91HqAt7I35MIX0X4Cg+3gvhnMq11qeFHNigDQLoao3nUzZCpAukG
ARC-Seal: i=1; a=rsa-sha256; t=1519664097; cv=none;
        d=google.com; s=arc-20160816;
        b=l3mAa+KWuFeH/9E8x2hdprK/VOmYg4ih8E33xOIpl7IO35+dHEyIIrp5HitZJUkuRj
         Ho12cmNZUzQEiOLc0sjiOFScui3aJ5T1o3SsZXhkvwHQY1W2FQ3cxs40haGggXezYJej
         NaoaVnw6vCdr2tC9rNsqe2dRbdfJ1t0ZzW63kVakVsuVnPhpTKJyAyRssN+kuw/IjYbJ
         WYDMshxVlx7KsuTEWj0cpZRlwasBJ3Pk8AUSLZBDfpW4Vkttx+yxwigmM1+vSoruz7pW
         5Hg4UyxupPL+lttzUQMb5O6Rxcv/1pvt5lHRstPP+uQRu9Na0Ul/fC+yAdADOA5qURkC
         oa2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:reply-to
         :arc-authentication-results;
        bh=31rWNZ+DpvosaB3UEB3ApmPDgoYMLOUbPBu3U/+K5ew=;
        b=Fn4x1mGB6R3QNGIPXdNJYuUJ5WS0ptrDnhFTlWPd9e3KkDJbcAD6x7VGBy4LRuzWhY
         kNljRSx0B2exlpyObtohgovNhBvlZOkyr/361x0Fty4RhYUuGZMOGAC7asIIrv7hgKjz
         MZpGeUBkS5xeOtVOsGyNpWMidlD1UKz1Om3gPRcmscUhH9BqRICNny+JcgT7wCJ+EJOH
         m9AaAM3iyUGeLxFHuSh6wY80DINsSrq58L2qVRC1GFX7AF+Xpn2T46BkluOmBPfnJK74
         BvJlNHfiymOh+hxZODIPZ8RiLnKJ5t+Fi9QmHHDoRrpdqX5om/OIU9mFWFvuu3SncCNa
         bnrw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750941AbeBZQy5 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 26 Feb 2018 11:54:57 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:59569 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750767AbeBZQy4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Feb 2018 11:54:56 -0500
Reply-To: shuah@kernel.org
Subject: Re: [PATCH 1/2] selftests: ion: Remove some prints
To: Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Kjos <tkjos@android.com>, dri-devel@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Liam Mark <lmark@codeaurora.org>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Shuah Khan <shuah@kernel.org>
References: <20180216012445.17264-1-labbott@redhat.com>
 <20180216012445.17264-2-labbott@redhat.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <f5324fa1-64fe-4b22-944b-c646c662a48f@kernel.org>
Date: Mon, 26 Feb 2018 09:54:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180216012445.17264-2-labbott@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592518834348841549?=
X-GMAIL-MSGID: =?utf-8?q?1593483300634906330?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/15/2018 06:24 PM, Laura Abbott wrote:
> There's no need to print messages each time we alloc and free. Remove them.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  tools/testing/selftests/android/ion/ionutils.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/android/ion/ionutils.c b/tools/testing/selftests/android/ion/ionutils.c
> index ce69c14f51fa..7d1d37c4ef6a 100644
> --- a/tools/testing/selftests/android/ion/ionutils.c
> +++ b/tools/testing/selftests/android/ion/ionutils.c
> @@ -80,11 +80,6 @@ int ion_export_buffer_fd(struct ion_buffer_info *ion_info)
>  	heap_id = MAX_HEAP_COUNT + 1;
>  	for (i = 0; i < query.cnt; i++) {
>  		if (heap_data[i].type == ion_info->heap_type) {
> -			printf("--------------------------------------\n");
> -			printf("heap type: %d\n", heap_data[i].type);
> -			printf("  heap id: %d\n", heap_data[i].heap_id);
> -			printf("heap name: %s\n", heap_data[i].name);
> -			printf("--------------------------------------\n");
>  			heap_id = heap_data[i].heap_id;
>  			break;
>  		}
> @@ -204,7 +199,6 @@ void ion_close_buffer_fd(struct ion_buffer_info *ion_info)
>  		/* Finally, close the client fd */
>  		if (ion_info->ionfd > 0)
>  			close(ion_info->ionfd);
> -		printf("<%s>: buffer release successfully....\n", __func__);
>  	}
>  }
>  
> 
Thanks Laura. I will queue this up for 4.17-rc1.

thanks,
-- Shuah

