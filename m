Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-477338-1527098641-2-2973375858597622292
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527098641; b=WB6zAl0buJ0L1zgY2ssjlaSo/bUDyz5Xty92IEk8Zf2nzg69Fr
    QFA4SUoMuylDKKLZqxual/zaeOGi3SNxk88VBVBpkDc4MoW2i0uL9tqQKPJ7bhPZ
    Nf3k0W3eNXTs2//bHwvhsx0WOXu5gWv1EeCIchEU2qYzw0l+Ghh2B543BRmACK18
    nkO+8LnfGt80tn91/hxM+5lgYTZLSEf3SNetcm5nGXNyAwShkPKciyVEYM5COyZE
    VPbIDgnSnKDx8bffNw65P34Q0lZbHqYisk2Cl088yRIGyhmXL+TAAxbMHy8GGJGm
    B05uOGvO3WX1tkdNqsgdCHjBo1jiOE6VvlFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527098641;
    bh=00fn+1ceFH2zjyJzg3hsj/koCDIXNpTKS4bBsK3A3rQ=; b=jjQCt8jAwLKN
    VeV7DnYbdckzL/4wdC4I0XfuoPy5uz8/hTPZCDpEw6eyDiT88aJnXoM5Nwjn69qF
    9cA9dpN+6cgx7p+FyTqXDZycv2tDXoWOD3bNE2yunsAv0gT4KrpobuzW/MhOIun9
    9GVocBNhE4zvNQFq+irlzPKpDL3YwxO/dPtAPt7FQk8DRx3cduWH1oUL4vgN/WOP
    Hce8kJQnl1J+8SnKvw46RjYRcdEKi8pWCsOHr68/LnplMm103vmlKSVGMxxbTQdz
    2DDOvmYpLqzQ48BHx4xAVPwPakpbpeQ41opIe1m8LNtQqrCZ2SvKB6r6BXA08CRV
    ucSXq/ienw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=p2LGRHXV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=p2LGRHXV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfExFb8ilm7sOVF9SKhAWmCe13B2oRuRKTVGOuxuy1Ff2qwZ6w2Jglya1QHGTRrX5fyMN3h66++g8m/0vyvOACIpS3fAJ3w6XO4sh4oewWlCc4x+uEbsU
    1cswkXO5AFSazNsCS8m5CCS9ByeGLtOO4BlxaU1TDl5vOcFAVx4+MGNKQPNabej2b0rG2R/4GFfGI+xC288b9kEoFMVaSrFFfztWeeNQglIdyLO0qX/oo20C
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=6OO8HELXZbti36y6H1wA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754759AbeEWSDr (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 14:03:47 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33136 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754691AbeEWSDq (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 23 May 2018 14:03:46 -0400
X-Google-Smtp-Source: AB8JxZp+SajOaiObaozFY5qkIE735uCaNrPKfAM12RgaX/dIeyPg44aSTHoujx8T0D6sHn3DckD97A==
Subject: Re: [PATCH v2 1/3] usb: roles: intel_xhci: Always allow user control
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20180523143758.66348-1-heikki.krogerus@linux.intel.com>
 <20180523143758.66348-2-heikki.krogerus@linux.intel.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <0e4dd22d-8553-1d51-22a2-d6252e5c5dc5@redhat.com>
Date: Wed, 23 May 2018 20:03:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180523143758.66348-2-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 23-05-18 16:37, Heikki Krogerus wrote:
> Trying to determine the USB port type with this mux is very
> difficult. To simplify the situation, always allowing user
> control, even if the port is USB Type-C port.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>   .../usb/roles/intel-xhci-usb-role-switch.c    | 21 +------------------
>   1 file changed, 1 insertion(+), 20 deletions(-)
> 
> diff --git a/drivers/usb/roles/intel-xhci-usb-role-switch.c b/drivers/usb/roles/intel-xhci-usb-role-switch.c
> index 30b07ea3a3c6..3f14153d753f 100644
> --- a/drivers/usb/roles/intel-xhci-usb-role-switch.c
> +++ b/drivers/usb/roles/intel-xhci-usb-role-switch.c
> @@ -39,20 +39,6 @@ struct intel_xhci_usb_data {
>   	void __iomem *base;
>   };
>   
> -struct intel_xhci_acpi_match {
> -	const char *hid;
> -	int hrv;
> -};
> -
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
> @@ -139,6 +125,7 @@ static enum usb_role intel_xhci_usb_get_role(struct device *dev)
>   static struct usb_role_switch_desc sw_desc = {
>   	.set = intel_xhci_usb_set_role,
>   	.get = intel_xhci_usb_get_role,
> +	.allow_userspace_control = true,
>   };
>   
>   static int intel_xhci_usb_probe(struct platform_device *pdev)


I hate to be pedantic here, but the sw_desc can and should be made
const now, with that fixed the entire series is:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> @@ -146,7 +133,6 @@ static int intel_xhci_usb_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	struct intel_xhci_usb_data *data;
>   	struct resource *res;
> -	int i;
>   
>   	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>   	if (!data)
> @@ -159,11 +145,6 @@ static int intel_xhci_usb_probe(struct platform_device *pdev)
>   	if (!data->base)
>   		return -ENOMEM;
>   
> -	for (i = 0; i < ARRAY_SIZE(allow_userspace_ctrl_ids); i++)
> -		if (acpi_dev_present(allow_userspace_ctrl_ids[i].hid, "1",
> -				     allow_userspace_ctrl_ids[i].hrv))
> -			sw_desc.allow_userspace_control = true;
> -
>   	platform_set_drvdata(pdev, data);
>   
>   	data->role_sw = usb_role_switch_register(dev, &sw_desc);
> 
