Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-841545-1520609967-2-12873145164799554756
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520609967; b=pjMs+5GJafh+gHVtispf2WYrkcDSNW4nuNh82Qi9kOiZHKZ
    SRSpUBdA0VS7TLhcAqKZXUd2uEh0rW4X5uYY/azkrw+Wa+7FeSkYBMs2wzJYET3C
    1aVJ0a/j+Odam8j7eLN/W9xpZCORKBgjO3Kk5bV3QEZrDogpsI/A5yRTtsmXLpF1
    +4RRDNgRdAkjc7Rg6mqDHviHCRhsYp8uIfbqmX+aCMYowh9RnNZBUPGk8N+bg7LK
    I7qUJBvzaQcHZDfEHhc4oLCab9KUawNOLjhV/d6dZuWCJN7qnHfJBLQDj7ANEbAj
    s62Ru24CUMNhxAE17rXCY6x9DiJZm8J+0UUIASg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520609967; bh=U
    KecN6AWKqOBip6T5ybbg/kXQsEIHSLecE1uRttr6IY=; b=izUbDlq3AskGsmxyB
    3TF5BxAUNytHoCGNS/d5BmByiPPb/M6FBjFa6XlI95qRNhU9BkkhkYO8hO99/wld
    g4H30nMMzbf2bSvt9IRd0rXt2BChNN5Zgy1EGg8gpoZs8r0U/t39p59HwcBET7VH
    80Ufx31oSlpvtMpDZHVpzqMBDE25VKhOki3tCU0niCr0qCalHkW4XYgzFN7JLYQ1
    +oA26ciN4Pm21byYoyTchbytDUYpaVyWokW3D9lHuosZS/ourjlmbaZ4UyMkUPOP
    lhqnl6Lo6lowc7a0PbAcHQ5l/zaDoM8k5eLSeIicjyIyiHjENVqq9CQjqq+Mq4en
    9FZ1g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 9 Mar 2018 15:39:11 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
Subject: Re: [PATCH] PCI: hv: fix bus domain ID corruption
Message-ID: <20180309153911.GA20693@e107981-ln.cambridge.arm.com>
References: <A9BC9573-36AA-4493-A086-F99F9204BEC9@microsoft.com>
 <19EE9647-AE9B-443E-ADBD-51CCEFC3EDEA@microsoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <19EE9647-AE9B-443E-ADBD-51CCEFC3EDEA@microsoft.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: Stephen Hemminger <sthemmin@microsoft.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jake Oshins <jakeo@microsoft.com>, Bjorn Helgaas <bhelgaas@google.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 09, 2018 at 05:02:34AM +0000, Sridhar Pitchai wrote:
> When PCI BUS is added, PCI_BUS domain ID is set. When PCI_BUS and a device
> added to the bus is racing against each other, the first device tends to
> overwrite the domain ID. In order to avoid the race, this patch make sure
> when a device is added to a bus, it never updated the bus domain ID. Since
> we have the transparent SRIOV mode now, the short VF device name is no
> longer needed.

This commit log may be clear to you, it is not clear to me at all so
you will have to improve it and explain why it is safe to apply this
patch.

> Fixes: 4a9b0933bdfc("PCI:hv:Use device serial number as PCI domain")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sridhar Pitchai <srpitcha@microsoft.com>
> ---
>  drivers/pci/host/pci-hyperv.c | 11 -----------
>  1 file changed, 11 deletions(-)

Are you 100% sure this patch won't trigger a regression on current
systems ? I need ACKs/reviews from hyperv maintainers to apply it.

Lorenzo

> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
> index 2faf38e..ac67e56 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -1518,17 +1518,6 @@ static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *hbus,
>  	get_pcichild(hpdev, hv_pcidev_ref_childlist);
>  	spin_lock_irqsave(&hbus->device_list_lock, flags);
>  
> -	/*
> -	 * When a device is being added to the bus, we set the PCI domain
> -	 * number to be the device serial number, which is non-zero and
> -	 * unique on the same VM.  The serial numbers start with 1, and
> -	 * increase by 1 for each device.  So device names including this
> -	 * can have shorter names than based on the bus instance UUID.
> -	 * Only the first device serial number is used for domain, so the
> -	 * domain number will not change after the first device is added.
> -	 */
> -	if (list_empty(&hbus->children))
> -		hbus->sysdata.domain = desc->ser;
>  	list_add_tail(&hpdev->list_entry, &hbus->children);
>  	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>  	return hpdev;
> -- 
> 2.7.4
>  
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
