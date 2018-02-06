Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2292549-1517958032-2-5541634069417185379
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517958031; b=LzVnkE6VQG/ODhJD3cMA6bgoK19fuF+WOTVloKQDtJdi9Vt
    zjIWn6Vnn0koSbBf004O01I88A993Uf53pLBrfpdzTxNKJsNDuM7KgOr2haolcWA
    O6Jd8wsimwGnqpC6aZ48t0rYWIMEvdh+egBLSFAQ/CvCqjdmwrtomXFHKDOcv1WA
    d+XhKDK93z1d7xn7Q4LBg+HxfY9zSebU+B5t6vPD71pkJWeNIz+55gRzEyg1O8fs
    lXTwq4/d72ROIAWRgjkMVg0COOMHnKISZXP4OtYv7IMXitQmHyJHdj8LzGDlWFDg
    oERTFbDVBlikUzLDETP57laoNk9zaoXTIzHNSYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1517958031; bh=IDnBV7fALjDIshNvfySJvn2SDIGpJnLJy+6Dk4dX5RE=; b=L
    xuGew9SDYHk+YLg1fOj9lbPs5xhE4R07IGA3iYZILMwwWLCHiL/sxwn6O9ai+fxB
    ihQnLSWqC01zVGvtdQXD4BZ16AZ7YXXSDwMQegCN/l5YOM1Go15qSkSm0mtSfPm+
    H5rog00hJgK4d3HIvZ13klqAa4+tT1PU2vD3UJkHV/Y73iYYsLigitkwMMwLQJWU
    S27NlAUlwYqGoJpgTm2la2Va91DjHsNCoQ/yVaDLdTbNMqnmPaYCUUp09pIuQkeG
    GwP06Gtv4dd5c/Lmish4zxd9PPPGO6389k0qe22O7n3iEMa4vXnsQ+goKAn4H46U
    q1s0examvrIfDdH/VNmlQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=roV9Fdn8;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=roV9Fdn8;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x225ppwqH64gg8g6TQigeBQ1HQCH0XUsQDpc1kbX5J0NWA2mBQ4nSB1Ghut/ZVgw10puiWJSjeA==
Subject: Re: [PATCH 2/2] staging: android: ion: Remove lable debugfs_done
To: Yisheng Xie <xieyisheng1@huawei.com>, gregkh@linuxfoundation.org
References: <1517488447-41252-1-git-send-email-xieyisheng1@huawei.com>
 <1517488447-41252-2-git-send-email-xieyisheng1@huawei.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <6fa110ed-afab-b707-a2e9-7a1a94ccf92f@redhat.com>
Date: Tue, 6 Feb 2018 15:00:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1517488447-41252-2-git-send-email-xieyisheng1@huawei.com>
Content-Language: en-US
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, sumit.semwal@linaro.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/01/2018 04:34 AM, Yisheng Xie wrote:
> When failed to create debug_root, we will go on initail other part of
> ion, so we can just info this message to user and do not need a lable
> to jump.
> 

Acked-by: Laura Abbott <labbott@redhat.com>

> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>   drivers/staging/android/ion/ion.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
> index 3e41644..70a70f5 100644
> --- a/drivers/staging/android/ion/ion.c
> +++ b/drivers/staging/android/ion/ion.c
> @@ -601,12 +601,9 @@ static int ion_device_create(void)
>   	}
>   
>   	idev->debug_root = debugfs_create_dir("ion", NULL);
> -	if (!idev->debug_root) {
> +	if (!idev->debug_root)
>   		pr_err("ion: failed to create debugfs root directory.\n");
> -		goto debugfs_done;
> -	}
>   
> -debugfs_done:
>   	idev->buffers = RB_ROOT;
>   	mutex_init(&idev->buffer_lock);
>   	init_rwsem(&idev->lock);
> 

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
