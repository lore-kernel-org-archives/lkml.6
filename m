Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-497716-1518798482-2-7783241200902582482
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518798482; b=NU3TNxvVqj1x5yDXPILlZ5wgz0sVqp+zYEuVEk52DZSyWKh
    64WSOLDoiYz6GjgpM7ygrp933ts7NxoegEpQs8POp6Ztf/Ybxuve+UjkZvNZM5os
    OV1Kyqvvsvp/Eh44514JArz9lqL1cWjlvPvKDotqCM7mCc7Wp9iPYSs0yolg8cIJ
    gJ5dZz+tFx8o0s63BCxSihWpE++Au6elrT1iWb8qnYaZGkKLDfXPIGVhUsu/Rzu7
    xVUOOeI4Qidw1MOBWUvfTjJHEvzV7X+wdmahOfDNNwtY+bdThC2enFT+iePspONc
    IxYQvKLtzcM0P/ZCGVOc/Zlg0s8PAfepS3AI48w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518798482; bh=E
    FHZMVAbokp8lmwis4k7Rh5AneGq5yi6QJPTvYva1K0=; b=D4lTgl8kX4CtR/Oc0
    1DlVRPYqPa4kb4LYkGqBkEgxCtasHZtbnlHDM/IKJHsq/qvzPQlQOhz53ednKMsr
    gurpeTaGox5ousifRAuaQNyiitTOyPNz9a3NCkWg13ULtp12hPgddl/qkfQ9JLna
    ssc+XFLwYvHoioavlY/XAQv3nkQmikkQVYzodexK1iXkNwdbm40GIOOoJV6q1rYQ
    GF2VUHwuWv4NFJX7NsPmV9HjabmjOD2deeERKiJMG7Mnf1q8NQz8D6xJ2q5mqlDP
    ZzxZ2zaY2zxWS+NY/JvaRp1cAMsWQBStnywngYkwXTD6H9FDlbAzwgVx30PW92ix
    UlbOg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 16 Feb 2018 17:27:56 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yisheng Xie <xieyisheng1@huawei.com>
Subject: Re: [PATCH v2 5/9] staging: android: ion: Remove lable debugfs_done
Message-ID: <20180216162756.GB18688@kroah.com>
References: <1518432194-41536-1-git-send-email-xieyisheng1@huawei.com>
 <1518432194-41536-6-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1518432194-41536-6-git-send-email-xieyisheng1@huawei.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
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

On Mon, Feb 12, 2018 at 06:43:10PM +0800, Yisheng Xie wrote:
> When failed to create debug_root, we will go on initail other part of
> ion, so we can just info this message to user and do not need a lable
> to jump.
> 
> Acked-by: Laura Abbott <labbott@redhat.com>
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>  drivers/staging/android/ion/ion.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
> index 4b69372..461b193 100644
> --- a/drivers/staging/android/ion/ion.c
> +++ b/drivers/staging/android/ion/ion.c
> @@ -595,12 +595,9 @@ static int ion_device_create(void)
>  	}
>  
>  	idev->debug_root = debugfs_create_dir("ion", NULL);
> -	if (!idev->debug_root) {
> +	if (!idev->debug_root)
>  		pr_err("ion: failed to create debugfs root directory.\n");
> -		goto debugfs_done;
> -	}

Again, does not matter to check the return value of any debugfs call.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
