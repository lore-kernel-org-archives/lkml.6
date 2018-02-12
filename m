Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1250878-1518435680-2-17064934060361365888
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518435679; b=TDG9Tdw0LkW23/KtylbwBdLSDjgGQRvCXFyMAk+p/g6UtG1
    oh6zzhvTG1vy2cCXXEjnwlublHuw4XjcJZDDuc2sobzPsZI9fsAAx3RNEhNHTWIj
    hmdDBkGmBDT1HkZtVC9xm6oywcqiAhDhOyu4wRT5L3bY4SsCJoAJEPDXA6HF/ouT
    lCZ2xf8gHOcofpcz0dqDyCsqmvL63A4sDOyWb9ivJAhm/ywZwnWaUon1MALkvnEd
    CGXcM+jiNgBGRj54mBS1RqP9so3H3Uu7sjisAqnOvtqEhKOr30n+Z7dpGNTu6HWR
    OQlQo73EbMxR4L9KW7+es1lUPy+zKVY9HeINWaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518435679; bh=5
    15/fyvJCSB2zytDRa1z/cmW/kNlDqbKHudLLRyaWvw=; b=f/vPug/XUsMyjfbm0
    ZvvqCu06BvNcQ/fc6YAmvKLQGVKWf3XX8PiRrkwfsBA3R96oClFWlycB4UpiiNOB
    Mn9bQ9thNQaWuM2KCdA4OVColHE0S0I0vq86uI9/Ru32N9k02KOjOOaP2w2fVqDD
    3KoDjqRC0gwK9aKPdoypzpr0HIphmmjJIiEzW8KTvzAy0IdQUdCoYot04oJPC3k1
    P3KtiUOk1mcJyf6X9XpCfgnUvujlyApn3rHtkDgB+TyuzVOIpp1jR8i4a1Va5Sf6
    q9HhzfbldXImIDHu7gym8GZ8lvoMzgIYzwyM9kZrhBCBaCFJNBEhgAW4ceXZxR2P
    iYXfQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Subject: Re: [PATCH 1/2] staging: android: ion: Avoid NULL point in error path
To: <gregkh@linuxfoundation.org>
References: <1517488447-41252-1-git-send-email-xieyisheng1@huawei.com>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <1ac2eea4-83ef-d170-f115-7ce8e5d7503c@huawei.com>
Date: Mon, 12 Feb 2018 19:40:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <1517488447-41252-1-git-send-email-xieyisheng1@huawei.com>
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

JFYI, I have rebase this patchset to v4.15-rc1.[1]

[1] https://lkml.org/lkml/2018/2/12/204

Thanks
Yisheng

On 2018/2/1 20:34, Yisheng Xie wrote:
> If we failed to create debugfs for ion at ion_device_create, the
> debug_root of ion_device will be NULL, and then when try to create debug
> file for shrinker of heap it will be create on the top of debugfs. If we
> also failed to create this the debug file, it call dentry_path to found
> the path of debug_root, then a NULL point will occur.
> 
> Fix this by avoiding call dentry_path, but show the debug name only when
> failed to create debug file for shrinker.
> 
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>  drivers/staging/android/ion/ion.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
> index f480885..3e41644 100644
> --- a/drivers/staging/android/ion/ion.c
> +++ b/drivers/staging/android/ion/ion.c
> @@ -570,13 +570,9 @@ void ion_device_add_heap(struct ion_heap *heap)
>  		debug_file = debugfs_create_file(
>  			debug_name, 0644, dev->debug_root, heap,
>  			&debug_shrink_fops);
> -		if (!debug_file) {
> -			char buf[256], *path;
> -
> -			path = dentry_path(dev->debug_root, buf, 256);
> -			pr_err("Failed to create heap shrinker debugfs at %s/%s\n",
> -			       path, debug_name);
> -		}
> +		if (!debug_file)
> +			pr_err("Failed to create ion heap shrinker debugfs at %s\n",
> +			       debug_name);
>  	}
>  
>  	dev->heap_cnt++;
> 

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
