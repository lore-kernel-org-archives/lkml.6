Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3952077-1521898478-2-7786746845008416635
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521898477; b=c8wlHh1xmHVDW+TlosMgUV8ePvScjT9Vf0tHqKo7wbAY5Fp
    Gg5AiUAZKk6lmi5OGZCBtJJyr133/YUKdCzqCaCJj4/P6G5X6qddTFHEy7fT57Ww
    ZBdnQvjqhxyjvQKE4EUr/pFeYvtZFH+p8lPZdIqX8jUKEf9s0/jgFkkN+LL1govq
    pgUW43d8DnA68kdDY3UOGNtuCNxuMsvXB+PtmIKGRXjVWVFHkvdbPAQhmmPLMchi
    ZQxiXNqod6MpgRu8ZSANlVltQIA8a1l4tmBihKbn7bltveOjQpyyoB4qjCcjeKgR
    Gk9d6BjdrtZIlx+rJmv9YGhpU3tEYa2gPSIAxfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521898477; bh=1
    nfputvje92hJ1ulIQorsruPzAkQLJGFhdXdFaVvxSc=; b=wuImxzU048CauNQiL
    8CMWC3FV6db92OtBg3iBn6J86BOSEzZRNtpuTWfrmXkn9pcol94AzB5hZRn8hgwl
    kK0q1XFaCkPWGuD/KoQXSWuLoB29qHlQaL3XXdy87aHPVPuo1mzE4kjn9NefsJYx
    U58D2ZkoNZ5yXWA4xK2Xe5s2JpJMiGQzXdF767b8e/7baTAz5zMR2jkoYXYAVhuW
    tJfkzbHllPwQTyGo6HzQ/6Sl4VLlnyto4yg1sW5PSHHfv8ZMs+lxXGYPEtPLvfph
    /AiFCFbGh1JH8k8t3B9Efi/kz5izQKCPDA4h3nPvBq3ybmsGGW7XUK17D+LhEslJ
    ldrRw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 552C821772
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Mar 2018 13:34:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 03/11] staging: iio: tsl2x7x: no need to clear interrupt
 flag when getting lux
Message-ID: <20180324133426.6d0053f7@archlinux>
In-Reply-To: <20180321102912.5130-4-masneyb@onstation.org>
References: <20180321102912.5130-1-masneyb@onstation.org>
 <20180321102912.5130-4-masneyb@onstation.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
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
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, Jon.Brenner@ams.com,
 pmeerw@pmeerw.net, knaack.h@gmx.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 21 Mar 2018 06:29:04 -0400
Brian Masney <masneyb@onstation.org> wrote:

> tsl2x7x_get_lux() does not need to clear the interrupt flag when
> querying the ALS. The interrupt flag is cleared in
> tsl2x7x_event_handler(). This patches removes the unnecessary code.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 59921850a226..9c929e273135 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -387,10 +387,6 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  		buf[i] = ret;
>  	}
>  
> -	ret = tsl2x7x_clear_interrupts(chip, TSL2X7X_CMD_ALS_INT_CLR);
> -	if (ret < 0)
> -		goto out_unlock;
> -
>  	/* extract ALS/lux data */
>  	ch0 = le16_to_cpup((const __le16 *)&buf[0]);
>  	ch1 = le16_to_cpup((const __le16 *)&buf[2]);

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
