Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2757900-1520411802-2-51592711787956354
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520411801; b=uzpsuqROsf/DhI0HybYoVxLJ0vuf8FtRxAqGVRdQyiJ5iF8
    IYft6YFUhC4rV/AEeNsj4iJDcBhKhNu5fxvjpmUtZS/M87z4W+xsEvQ63qIeLOyf
    sPrxCGVnYX3WOtdqFTYmsIxPExHgfhuNIJ/Bdd515qLHVQY6yU92WoL/iuhRbYqK
    ufPbKc4JC/K6KXTnwDSVwUwyugiI5zbVRa3MzxTc/Rcdg+XPQR/zNasHmkRq/Pfa
    PTAdAhcwRT2r2Ip7mCz2bVY5diOZFKTX8PsSLFWNObREpXkMSv1zIXfmliig9DU7
    U0mcju6LtbHXt7A9Saa0BRLgkfoOI5tL7UTWQ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1520411801; bh=ysu2jpy5EXFHK0O5FEeR8ra7g3w1Hd7ctQS3sdDK3Dc=; b=d
    Csma2NhJXVfm2znm0sooPBvSPboYd3C44HZCJWdQnCa4vogzHBCXv0z1uUiIzrNO
    H6OVfWHWXs0yZBBVircmp4nMHwCpy6GjeqEqcMLfLPISL3X25xe3gctQ2u/L2ZgD
    IyhPbaAsgSIn7Hki+pnvYt0UQXWJb0uJLwaVgePzL24NxiMKM+Nn9Ncts7M7KyXb
    pXdr1XI8Sud8cWS2uaEwQJmG0kox9k6tabl/tEb3tvtTFQhUXKUovGYuAgoOv2x/
    ohNXaHDk+rkuq4fkgimNyCl5+NYko8S46kEpTkU4QL4tMgm0oqpcGnglCpMmf4Ot
    qB+2dVRd8ZzKWXWKMLGAQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microchip.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microchip.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-IronPort-AV: E=Sophos;i="5.47,435,1515481200"; d="scan'208";a="12042633"
Subject: Re: [PATCH] staging: most: Remove unnecessary usage of BUG_ON().
To: Quytelda Kahja <quytelda@tamalin.org>, <gregkh@linuxfoundation.org>,
 <dan.carpenter@oracle.com>
References: <20180306094728.xbhamhpwdphv6kju@mwanda>
 <20180307013141.23080-1-quytelda@tamalin.org>
From: Christian Gromm <christian.gromm@microchip.com>
Organization: Microchip
Message-ID: <60990ed8-9464-96a1-c574-d801ddfffdf1@microchip.com>
Date: Wed, 7 Mar 2018 09:37:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307013141.23080-1-quytelda@tamalin.org>
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
Cc: devel@driverdev.osuosl.org, Michael.Fabry@microchip.com,
 chris@engineersdelight.de, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 07.03.2018 02:31, Quytelda Kahja wrote:
> There is no need for the calls to BUG_ON() in this driver, which are
> used to check if mbo or mbo->context are NULL; mbo is never NULL, and
> if mbo->context is NULL it would have already been dereferenced and
> oopsed before reaching the BUG_ON().
> 
> Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
Acked-by: Christian Gromm <christian.gromm@microchip.com>
> ---
>   drivers/staging/most/core.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/staging/most/core.c b/drivers/staging/most/core.c
> index 0ab2de5ecf18..3afc25a61643 100644
> --- a/drivers/staging/most/core.c
> +++ b/drivers/staging/most/core.c
> @@ -915,7 +915,6 @@ static void arm_mbo(struct mbo *mbo)
>   	unsigned long flags;
>   	struct most_channel *c;
>   
> -	BUG_ON((!mbo) || (!mbo->context));
>   	c = mbo->context;
>   
>   	if (c->is_poisoned) {
> @@ -1018,8 +1017,6 @@ static void most_write_completion(struct mbo *mbo)
>   {
>   	struct most_channel *c;
>   
> -	BUG_ON((!mbo) || (!mbo->context));
> -
>   	c = mbo->context;
>   	if (mbo->status == MBO_E_INVAL)
>   		pr_info("WARN: Tx MBO status: invalid\n");
> 

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
