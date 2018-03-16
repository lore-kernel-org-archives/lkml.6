Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1717850-1521164785-2-11853112810243575987
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521164784; b=NF7gW2SjngU6YTq17fbTbruZ69wSFUIEfD99zDy+diMfDVM
    hEeGLbgs7qrBU3SsESF2AVs+tXEiB6r+YlDkyL8hIgo/vUdSXoa+XbCdf02jzQ50
    hYPLcQun3RNyfrI7nsqHY4krSKKpJaUgCtTn/fUDT6clLVjv5/vWtwKxRfsL06zG
    //dE+YQAQHh8y10AKi5/t003ZoBWG54h+RUKFD9NUMT8s+Qx6tWEvVCS5U/86BSp
    aqlIl/vQJZ6Q1UdtSxqmlUiMJN+3vWCftOGoFN8Lrd9JumBIrLp/9GHi0f5YP5DD
    x9vENN5xM3aQVe/VzlzsQNBNJPkfI3wzHvdpnzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521164784; bh=3jxGuAaB/9ukZJr4ISk3meUnq1yIKa+Ya03/xZnGlR8=; b=p
    0A4qvG6KBkaMVCXF0xGCi7Lw9L4LRheOZeSLKv5zaCZI/bPfg334DQUhPNQrTrvr
    BeDhOdZQ7MNSoL8puNNhBkvPKaMJMaaQGzlD1g6p/6rAWx6drASPGPfBX46eFhKz
    gE0HrdO3flXJUoXr3yALgxi8l/ArDUhKGrmcaCdC2ShwW4NtafK337ItSn2fKwZe
    PifimUGSNfRmE+50ZGh9BS25LNEv5n1W36jd7UbWGqSPPX7KxRDNLDuDUwE6py/d
    cu6we0oZRr6+C/66gRVP7Y0Ej7SS0EzL9cr6z/z1G3NC8O8xlN4CW8ZPbeB+TVPl
    M5tAm3yOkBliC1E32n34A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752816AbeCPBqK (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 21:46:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751877AbeCPBqJ (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 15 Mar 2018 21:46:09 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7E820855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Fri, 16 Mar 2018 10:46:04 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: dwc3: use local copy of resource to fix-up
 register offset
Message-Id: <20180316104604.1a88e9854cd9fb5809808eda@kernel.org>
In-Reply-To: <1521113998-25052-1-git-send-email-yamada.masahiro@socionext.com>
References: <1521113998-25052-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 15 Mar 2018 20:39:57 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> It is not a good idea to modify the resource from the platform device.
> Modify its local copy to pass it to devm_ioremap_resource() so that we
> do not need to restore it in the failure path and the remove hook.
> 

This looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks,

> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/usb/dwc3/core.c | 32 ++++++++------------------------
>  1 file changed, 8 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index f1d838a..e9083a3 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1164,7 +1164,7 @@ static void dwc3_check_params(struct dwc3 *dwc)
>  static int dwc3_probe(struct platform_device *pdev)
>  {
>  	struct device		*dev = &pdev->dev;
> -	struct resource		*res;
> +	struct resource		*res, dwc_res;
>  	struct dwc3		*dwc;
>  
>  	int			ret;
> @@ -1189,20 +1189,19 @@ static int dwc3_probe(struct platform_device *pdev)
>  	dwc->xhci_resources[0].flags = res->flags;
>  	dwc->xhci_resources[0].name = res->name;
>  
> -	res->start += DWC3_GLOBALS_REGS_START;
> -
>  	/*
>  	 * Request memory region but exclude xHCI regs,
>  	 * since it will be requested by the xhci-plat driver.
>  	 */
> -	regs = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(regs)) {
> -		ret = PTR_ERR(regs);
> -		goto err0;
> -	}
> +	dwc_res = *res;
> +	dwc_res.start += DWC3_GLOBALS_REGS_START;
> +
> +	regs = devm_ioremap_resource(dev, &dwc_res);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
>  
>  	dwc->regs	= regs;
> -	dwc->regs_size	= resource_size(res);
> +	dwc->regs_size	= resource_size(&dwc_res);
>  
>  	dwc3_get_properties(dwc);
>  
> @@ -1269,29 +1268,14 @@ static int dwc3_probe(struct platform_device *pdev)
>  	pm_runtime_put_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  
> -err0:
> -	/*
> -	 * restore res->start back to its original value so that, in case the
> -	 * probe is deferred, we don't end up getting error in request the
> -	 * memory region the next time probe is called.
> -	 */
> -	res->start -= DWC3_GLOBALS_REGS_START;
> -
>  	return ret;
>  }
>  
>  static int dwc3_remove(struct platform_device *pdev)
>  {
>  	struct dwc3	*dwc = platform_get_drvdata(pdev);
> -	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  
>  	pm_runtime_get_sync(&pdev->dev);
> -	/*
> -	 * restore res->start back to its original value so that, in case the
> -	 * probe is deferred, we don't end up getting error in request the
> -	 * memory region the next time probe is called.
> -	 */
> -	res->start -= DWC3_GLOBALS_REGS_START;
>  
>  	dwc3_debugfs_exit(dwc);
>  	dwc3_core_exit_mode(dwc);
> -- 
> 2.7.4
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
