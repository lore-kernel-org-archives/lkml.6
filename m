Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2903157-1525168692-2-164498801193030398
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525168691; b=cdsoag2tmo+x6MZGM+8e2pRMaCHA77aIjWhtCuJ41hDC5nLWqs
    neO36ADh8ei8IuKF6XKiPfWxq/zTeORP4BYaHtVYquvO48qlS8R+t3VejbHr3Cvk
    /H3iMzTlpBtGuyqZW8eGITOBMHaUL1hiRST1pSJln+IWlVSDc3P3DHcyiOuATL9y
    PDnNCB7GuBIktpSYGk14CMhta8fu3plDUh4NElkRdshcuKuI67gJwk4Zqa7Wsxbi
    35cf75AyXkBg+Dpd1+zmHKqUAw68TFpXSuOTrUOxAC2Vb0dkvtKEmfq25XUp7lNK
    GfmCwRcJLvG6b4D6YwzpAkNl3Y9TDTfUAodA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525168691;
    bh=BWD1ZTJ2wWfAbxvUucTt3WsDnBudBUD7Eo+rwYnSSVI=; b=APWIs2Cb4OXV
    HBHKa39FkRXcLAt4JJxKijD1TSa1MbUqpHEFo57EVC0I+YBhY5p6eEj1nCkADLwy
    FqMkmDKPP3KChDK87+1+pye8X9lxhjxgt/S1RKmywyrsUs3PWBtMUgQf+MOwqPJ9
    GfzBQ2hPOGIlM7qb/8wSYBQXjYSwaKUOqe/Rp2Ex9sjrYpSCN4FOSnkE444onLYb
    D6sYiYAsh1ti34qShXU3sfgEfvtpyKUEOzbwQu9rlnX2VBQlpr3bB+rR+BqBTJ8g
    tkH0fjSt1cJcz/QvlKbZ5q7jf3nL7RgR1U3tycCf37JpwDaRO+TCIX/oMhXu4HCi
    9h26reqcxQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=KCxyzdZW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=KCxyzdZW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAybQAzMUHo9QOHzFwm4Ob+rQCnBe/gylRjey0KLcFZa4+BsZcr46VNZYYSAXpeyACr/Lx0HjkxQ/mVY4gioNw1V1w+U18ha6z5aYpZc0PtXwtRGway7
    AyHlGR4J9pG68gSOd6eIw/CjEzDEt/q/yqNbK64Aabx6urG3b7i8tNVjJHJXRR+7kixhmC38gnv4PIVKK0kXsqAU2HFlTr3aDVW27Q/2gDvwqCc4bWiRZkiP
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=5WL4R2Ehb5lPF2gFDoEA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeEAJ56 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 05:57:58 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50493 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbeEAJ55 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 1 May 2018 05:57:57 -0400
X-Google-Smtp-Source: AB8JxZrdz8sEu9ceCphSa4U+QUH3/0XebOjotWs8F1niCNs/pA67hxxt3IUw1AUFyoODoqsAzy/9Vw==
Subject: Re: [PATCH 4/4] usb: roles: intel_xhci: Always allow user control
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20180430124158.45269-1-heikki.krogerus@linux.intel.com>
 <20180430124158.45269-5-heikki.krogerus@linux.intel.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <9a0b6af4-8d49-8193-2fcd-a956c3f852ed@redhat.com>
Date: Tue, 1 May 2018 11:57:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430124158.45269-5-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 30-04-18 14:41, Heikki Krogerus wrote:
> Trying to determine the USB port type with this mux is very
> difficult. To simplify the situation, always allowing user
> control, even if the port is USB Type-C port.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com> > ---
>   drivers/usb/roles/intel-xhci-usb-role-switch.c | 15 +--------------
>   1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/drivers/usb/roles/intel-xhci-usb-role-switch.c b/drivers/usb/roles/intel-xhci-usb-role-switch.c
> index 28102127b9d5..6482eee6fd45 100644
> --- a/drivers/usb/roles/intel-xhci-usb-role-switch.c
> +++ b/drivers/usb/roles/intel-xhci-usb-role-switch.c
> @@ -43,15 +43,6 @@ struct intel_xhci_acpi_match {
>   	int hrv;
>   };
>   
> -/*
> - * ACPI IDs for PMICs which do not support separate data and power role
> - * detection (USB ACA detection for micro USB OTG), we allow userspace to
> - * change the role manually on these.
> - */
> -static const struct intel_xhci_acpi_match allow_userspace_ctrl_ids[] = {
> -	{ "INT33F4",  3 }, /* X-Powers AXP288 PMIC */
> -};
> -
>   static int intel_xhci_usb_set_role(struct device *dev, enum usb_role role)
>   {
>   	struct intel_xhci_usb_data *data = dev_get_drvdata(dev);
> @@ -137,7 +128,6 @@ static int intel_xhci_usb_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	struct intel_xhci_usb_data *data;
>   	struct resource *res;
> -	int i;
>   
>   	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>   	if (!data)
> @@ -150,10 +140,7 @@ static int intel_xhci_usb_probe(struct platform_device *pdev)
>   	if (!data->base)
>   		return -ENOMEM;
>   
> -	for (i = 0; i < ARRAY_SIZE(allow_userspace_ctrl_ids); i++)
> -		if (acpi_dev_present(allow_userspace_ctrl_ids[i].hid, "1",
> -				     allow_userspace_ctrl_ids[i].hrv))
> -			sw_desc.allow_userspace_control = true;
> +	sw_desc.allow_userspace_control = true;

It would be better to add:

	.allow_userspace_control = true,

To the initialization of the struct and also make the struct const since
we are now no longer changing it and usb_role_switch_register() accepts
it being const.

With that changed:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans
