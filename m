Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-437838-1525250598-2-1633997249692186814
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525250598; b=jeVqVjIQ7/2dCJfUQ6VjPmoFDJyggYVsyRRIvaq/Vo/FclZkIK
    TrvcsOhCb/L73Y8WMWfap/jkharj0Sa7+0GPEKUMZAl2VaiENjLBXSXh1aFu7B2h
    w6/ogcx9Qnqo7AvlaIHRXBTHf6RNisseXcPBd5FMbcFloN026IYTbnp2qxed/Zer
    ft9hRuQJoHH8AbFx+hKpbkKMAfxq62VgKhkj+RCtHBSJyeF0U9NKNZ9DRiE4sH8y
    672RlM+fWicXW7kyyQ+5M59UGnmw7yuB13EBBHR1LCusbPf2qOwhgXOc+vnTpjcM
    054LcR44KI/dL9EJnMEZC+uN5ymRBkbHuWFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525250598; bh=oO2TS
    v0qdgSGWJoGTMldf3e3uLzzZx78Lwb1sa/loPg=; b=ApeIpN41gP58CpDVUuifO
    kMZu2gsD6tuVJlsrovs8rXc8XaDTx3oSwfD/ldC0UjnLioOJn5JMhzdojFTy4BdH
    qbMsr2zsKVQTCB62laqaXEqdCt/dPJFNpxP+9AkLjVuZRfAFU/mPn8u9iKOKlKOZ
    2W+fsDogDa1htcTXVAfjp/2tOWEz292s09Jyo1tRz2GhHLSPBrCYuekv/9VRVh90
    /zfwIC+tiqiYZq3YliSg6RkurkZYiwg0XQ0f+D17TN0lVY62jZUzFmeHkLjGov3b
    Rpw0+8aXXfTqfv8ReaF/nYN5WsKNLyQoIBhAdVvG+j9a4qdDvDccuwcSZTeEKW++
    A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=pdLI6Z+H x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine)
    header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=qQ6gF6l7;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=pdLI6Z+H x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine)
      header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=qQ6gF6l7;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ5QyHjnhYFy3YOSIJpf8W/KW1AwU/wIsp14VXYV0GZMkZ8RXg5yPj/lKWDaGQhywdkQh0XSCfiWda2WxcqMND/lFIoXPc4SDCPNBT87rp5o+6N9cEvF
    5NohqH8K2+j4X5kBz6Umj4IOIvF8Np/h3XlO6PDgUW2QV97CmkV8iPer0CemLzbNNf5bEbuaJU+klyhgWn1ZgpnnLiTo7KnyIXXwwacKJv8bV+/dmTwWB3lH
    6HUnPHRUkBeMPwrrJfFdRw==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8
    a=8-unw0mUqhDrxinWb1UA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZow4ht5XfPuFLCTr5vi6EwC7oEEzJNX1aY3uP7xYYYvhehSEZhP9N8xm5lQG+OeaXzwEngWHA==
Date: Wed, 2 May 2018 10:43:08 +0200
From: Johan Hovold <johan@kernel.org>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH v2] staging: greybus: Use gpio_is_valid()
Message-ID: <20180502084308.GF2285@localhost>
References: <5c8c96b1971bc09a2a2bfa62c343973ab986aec8.1524889296.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5c8c96b1971bc09a2a2bfa62c343973ab986aec8.1524889296.git.arvind.yadav.cs@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
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
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org, johan@kernel.org,
 linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 28, 2018 at 10:05:39AM +0530, Arvind Yadav wrote:
> Replace the manual validity checks for the GPIO with the
> gpio_is_valid().
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
> chnage in v2 :
>              Returning invalid gpio as error instead of -ENODEV.
> 
>  drivers/staging/greybus/arche-platform.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> index 83254a7..c3a7da5 100644
> --- a/drivers/staging/greybus/arche-platform.c
> +++ b/drivers/staging/greybus/arche-platform.c
> @@ -448,7 +448,7 @@ static int arche_platform_probe(struct platform_device *pdev)
>  	arche_pdata->svc_reset_gpio = of_get_named_gpio(np,
>  							"svc,reset-gpio",
>  							0);
> -	if (arche_pdata->svc_reset_gpio < 0) {
> +	if (!gpio_is_valid(arche_pdata->svc_reset_gpio)) {
>  		dev_err(dev, "failed to get reset-gpio\n");
>  		return arche_pdata->svc_reset_gpio;

I'm sorry, but I don't this change is desirable. of_get_named_gpio()
returns a valid gpio number or a negative errno, so there's no need to
use the legacy gpio_is_valid() helper here.

If you grep for of_get_named_gpio() you'll find that some drivers indeed
use that helper this way, but they are in a clear minority.

And ultimately, we want to move to using gpio descriptors anyway.

>  	}
> @@ -468,7 +468,7 @@ static int arche_platform_probe(struct platform_device *pdev)
>  	arche_pdata->svc_sysboot_gpio = of_get_named_gpio(np,
>  							  "svc,sysboot-gpio",
>  							  0);
> -	if (arche_pdata->svc_sysboot_gpio < 0) {
> +	if (!gpio_is_valid(arche_pdata->svc_sysboot_gpio)) {
>  		dev_err(dev, "failed to get sysboot gpio\n");
>  		return arche_pdata->svc_sysboot_gpio;
>  	}
> @@ -487,7 +487,7 @@ static int arche_platform_probe(struct platform_device *pdev)
>  	arche_pdata->svc_refclk_req = of_get_named_gpio(np,
>  							"svc,refclk-req-gpio",
>  							0);
> -	if (arche_pdata->svc_refclk_req < 0) {
> +	if (!gpio_is_valid(arche_pdata->svc_refclk_req)) {
>  		dev_err(dev, "failed to get svc clock-req gpio\n");
>  		return arche_pdata->svc_refclk_req;
>  	}

But if this were to be changed, you'd need to update also the fourth
call to of_get_named_gpio() in this function.

Thanks,
Johan
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
