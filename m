Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1183928-1524213968-2-280039168372891207
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524213967; b=EHDYCYsSY3OR3utFP1mwsxDMrZazWJpJBs8egniSfl7xXK106s
    lJsC9kXQL59i1oL8tvlVHWzWzZXsAksZMq7c1ViybaA035Gpe45C1dfKtcOzkxRu
    FFzrqA+eJ61BEE4z3pR9TdHgYl8nWSWOTNnC72oamgqXaRxSU1IgbyjRc+tiYAgO
    Gi3xQ1S2N8V22XURdvbtU+qSOamxrx88+hY2Wowl2QhKn/xgzmI3z9RS4p3h4YXH
    YOKJXFh43yS1ZTTGt4dgWogvahBQkLm/YEdlBiy8gvI6uKlc5QOwkA3NbgjrpKlW
    zMUk09Upd1KgCc0w2DSjsx6ooRMLRHOFkgkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524213967; bh=FTlhp
    Y4utEqV73S6PEewT0iegJPiiA7+ebe/iowc9EY=; b=CGTXJTKA3BoougMpCn+5y
    3WntS+qB1P9l6YrcthT64OtgA1n3qZRq3GDC9BiMmowLeRsAne4HYNzCbKbjBguk
    Bs4q7B6wCgRe/acHMHUw5pMXDr75dyiTmkql39YJ9UJkIGG9vaowBWheSCL3j4G/
    1XkWXdrYVLbMKs0RoJh8zrdp7+sbbMR3ZE2c+RCa7cyCy6vCK5MjY8KhPve9bqx/
    gs3PiCy/qbgMr117Av7NyUC1pbFQ6yKpnGE/f3j3QAbTaaMcugvW7G0w/TeH5ZUq
    hlCemtp5KZw/paEhu7d/DG3ll/MRIciXo3sJ9vRmvCQVMK4xCXT0KTC0aMEVokli
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gmx.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmx.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gmx.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmx.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNZowQ85lgi5jsIy2I8oZpMaBLLtllqwEixsITzDRqiMjIUPONzjzjLVXhjSDPwJazoPv0jGWUiWT/4c6EHpr09n5TqPF8qCKiqjGuVyWlp1ELJOrN2x
    XSU+28LL+PHzgAJPGVjSE917pt2WWLqEk9QQkyhd1elOzKiZgIo3aRDS26vh8vC8oi7/lsgRZs6WguyVXvWu0+pOS2w+NBps26NfzwoqwYmNAMmQnI2vtAx7
    zfDZag3s87rgwKzm3raqOA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=LDBv8-xUAAAA:8 a=DDOyTI_5AAAA:8
    a=yebBGWKk3JKTryifi4wA:9 a=CjuIK1q_8ugA:10 a=DZeXCJrVpAJBw65Qk4Ds:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Marc Dietrich <marvin24@gmx.de>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH 49/61] staging: nvec: simplify getting .drvdata
Date: Fri, 20 Apr 2018 10:45:42 +0200
Message-ID: <1534139.KRlJX3jJQi@ax5200p>
In-Reply-To: <20180419140641.27926-50-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-50-wsa+renesas@sang-engineering.com>
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
 ac100@lists.launchpad.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am Donnerstag, 19. April 2018, 16:06:19 CEST schrieb Wolfram Sang:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Marc Dietrich <marvin24@gmx.de>

> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  drivers/staging/nvec/nvec.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
> index 52054a528723..2a5e0dcf4162 100644
> --- a/drivers/staging/nvec/nvec.c
> +++ b/drivers/staging/nvec/nvec.c
> @@ -925,8 +925,7 @@ static int tegra_nvec_remove(struct platform_device
> *pdev) static int nvec_suspend(struct device *dev)
>  {
>  	int err;
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct nvec_chip *nvec = platform_get_drvdata(pdev);
> +	struct nvec_chip *nvec = dev_get_drvdata(dev);
>  	struct nvec_msg *msg;
>  	char ap_suspend[] = { NVEC_SLEEP, AP_SUSPEND };
> 
> @@ -946,8 +945,7 @@ static int nvec_suspend(struct device *dev)
> 
>  static int nvec_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct nvec_chip *nvec = platform_get_drvdata(pdev);
> +	struct nvec_chip *nvec = dev_get_drvdata(dev);
> 
>  	dev_dbg(nvec->dev, "resuming\n");
>  	tegra_init_i2c_slave(nvec);




_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
