Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-679016-1521133317-2-1345155599130027973
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
    t=1521133316; b=MAS9E5BMLDnqZzYujN0aiBM+YnDfHMt9+dfyUobMsfX0Q7i
    xay+pl4uYC7khMYNtnOYejpouELBCcum8u0DHi6wqeRQTKPQsKrPU1DO9VS7T4DZ
    nahyzACh0Z6aUUDUI/eGi6+Kr1AuJIHkobwdo3I0YSdAL6hwK5T0R0v3nYYTqXYr
    nj/03YyW/Hw/ELsEMKRKmi57GyDu7rrR1VdFR3VOjnmpqI+h9m3KZLU1ZmsY7ht1
    9BMev9D12LgYMfdkPSccZfWq9fBImc0MJQC/CmoXI5nqEWHTDNrWPDE9W1MTi5b8
    rNhpQzbvXWHxqmqLPcNVDl8lHmOUocYU0o/IU6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521133316; bh=H
    1wmFEt8sNBqIJ1Cbr/G/EHVTHb63FxSwbl39Aqv26U=; b=MIsR0F8TfVGPcbIbp
    shdjmGPALIsIzv1v4fdcls5a6Xu6aU4RJM+iAlVFKOzpPUE9dbpD3Xs7n1eOTVG1
    QQeMAXRA65ihEK7fUr0pYBQgjjPl5lc+NYEcrnrBpRoDSDeEYDo+cWdwh6ZiR2pn
    W4bjgUFLnpUoTIeSvLT8cecKjEpHHS2Ij04z7BTUEPusB/gKcIp8BdCk0S4tttJn
    OBTkpmJm+8ZeKlqBY/UuxiPTw3vg5WlYkc2ISOVjPOdeM5k19+ei4djGG23XpNWi
    8qjy3xyvuC0zt7Zgs5anMEm9JZg4oYetnExQJo+lX7UDUhi/bcmqQV6HirPRAtC7
    VOZGw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 15 Mar 2018 17:01:31 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v4 1/2] PCI: hv: Serialize the present and eject work items
Message-ID: <20180315170131.GA22134@e107981-ln.cambridge.arm.com>
References: <KL1P15301MB0006C96F94181FFB93A222D8BFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <KL1P15301MB0006C96F94181FFB93A222D8BFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
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
Cc: "olaf@aepfle.de" <olaf@aepfle.de>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "driverdev-devel@linuxdriverproject.org"
 <driverdev-devel@linuxdriverproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 "apw@canonical.com" <apw@canonical.com>,
 "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 02:20:53PM +0000, Dexuan Cui wrote:
> When we hot-remove the device, we first receive a PCI_EJECT message and
> then receive a PCI_BUS_RELATIONS message with bus_rel->device_count == 0.
> 
> The first message is offloaded to hv_eject_device_work(), and the second
> is offloaded to pci_devices_present_work(). Both the paths can be running
> list_del(&hpdev->list_entry), causing general protection fault, because
> system_wq can run them concurrently.
> 
> The patch eliminates the race condition.
> 
> Tested-by: Adrian Suhov <v-adsuho@microsoft.com>
> Tested-by: Chris Valean <v-chvale@microsoft.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Acked-by: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: stable@vger.kernel.org

I need to know either what commit you are fixing (ie Fixes: tag - which
is preferrable) or you tell me which kernel versions we are targeting
for the stable backport.

Thanks,
Lorenzo

> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Jack Morgenstein <jackm@mellanox.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> ---
>  drivers/pci/host/pci-hyperv.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
> index 2faf38eab785..5e67dff779a7 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -461,6 +461,8 @@ struct hv_pcibus_device {
>  	struct retarget_msi_interrupt retarget_msi_interrupt_params;
>  
>  	spinlock_t retarget_msi_interrupt_lock;
> +
> +	struct workqueue_struct *wq;
>  };
>  
>  /*
> @@ -1770,7 +1772,7 @@ static void hv_pci_devices_present(struct hv_pcibus_device *hbus,
>  	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>  
>  	get_hvpcibus(hbus);
> -	schedule_work(&dr_wrk->wrk);
> +	queue_work(hbus->wq, &dr_wrk->wrk);
>  }
>  
>  /**
> @@ -1848,7 +1850,7 @@ static void hv_pci_eject_device(struct hv_pci_dev *hpdev)
>  	get_pcichild(hpdev, hv_pcidev_ref_pnp);
>  	INIT_WORK(&hpdev->wrk, hv_eject_device_work);
>  	get_hvpcibus(hpdev->hbus);
> -	schedule_work(&hpdev->wrk);
> +	queue_work(hpdev->hbus->wq, &hpdev->wrk);
>  }
>  
>  /**
> @@ -2463,11 +2465,17 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
>  	sema_init(&hbus->enum_sem, 1);
>  	init_completion(&hbus->remove_event);
> +	hbus->wq = alloc_ordered_workqueue("hv_pci_%x", 0,
> +					   hbus->sysdata.domain);
> +	if (!hbus->wq) {
> +		ret = -ENOMEM;
> +		goto free_bus;
> +	}
>  
>  	ret = vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL, 0,
>  			 hv_pci_onchannelcallback, hbus);
>  	if (ret)
> -		goto free_bus;
> +		goto destroy_wq;
>  
>  	hv_set_drvdata(hdev, hbus);
>  
> @@ -2536,6 +2544,8 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	hv_free_config_window(hbus);
>  close:
>  	vmbus_close(hdev->channel);
> +destroy_wq:
> +	destroy_workqueue(hbus->wq);
>  free_bus:
>  	free_page((unsigned long)hbus);
>  	return ret;
> @@ -2615,6 +2625,7 @@ static int hv_pci_remove(struct hv_device *hdev)
>  	irq_domain_free_fwnode(hbus->sysdata.fwnode);
>  	put_hvpcibus(hbus);
>  	wait_for_completion(&hbus->remove_event);
> +	destroy_workqueue(hbus->wq);
>  	free_page((unsigned long)hbus);
>  	return 0;
>  }
> -- 
> 2.7.4
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
