Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2753674-1521197682-2-17115124731712661273
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521197681; b=WDmzX4mrNDQE71MK01jEWvK0NZJQ0XC4sGgv6uYX6zYcMJS
    BI/pUMZcg35PdPTMQAoAW+0/ARK49NHUU9rRXFue1CdOWLDBHTDNiDwa9PqYrxhz
    1jTgC8Q0Hyz0+LlYCXSGkkx1MSnnVcmUmfKvcboZ+RxDRYRYcuuCUANNh39KTUSl
    h/4gvsGo6JyA+MptHyNd+Nfzc6cNAra0UCsLYeIEAs58nE1EDZamLSkdhSHohNq1
    TgAo1zWMcCpA3N4jmEe8vXlrvezNUqtfO5kr1aKWVSFaYdJDOgeiy/rHovJkdvNl
    1Yw0UH3s4NN/0fKSUWH2AxlMISUH4UhWBLwS2vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521197681; bh=U
    0atCvc6eG9V/8CyqvGcSt/dD+iiD9XVOWJgwedGO+Q=; b=IBqkbtE3U97uziQxd
    E3hsTGlhJc5xXiTNyw69ZWHJfkFmF4aIfJxgaiyr9tyxmqw2d898KE/RwdaNtSiw
    7vGuXQuzoIIV2SjfEVmsUkY0gf1bfdJMiAupBgDmMlDNRp2Bw61wMrHwndRCY9m0
    dyNHBTwbdWzt8eEkcgcpmmHWIVaSLAYzMOMiL3Ev6GaQn2GiyziNtJjmIq4OhHth
    z6oauFiaDI05Q38Sm2vvQJeNu8pSZyznts8rMTyqWII2wgsmnNuB2mshlEUYtwZg
    YRqQFHX2/L8XHGX+1OF2dh5RB7s1CBBrQ9UKiv913vv40+qkseAjA94DyujnPXJu
    q+ghg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 16 Mar 2018 10:54:24 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v4 3/4] PCI: hv: Remove hbus->enum_sem
Message-ID: <20180316105424.GA24198@e107981-ln.cambridge.arm.com>
References: <KL1P15301MB0006E2FA71F87B312D9DECA4BFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <KL1P15301MB0006E2FA71F87B312D9DECA4BFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
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

On Thu, Mar 15, 2018 at 02:21:51PM +0000, Dexuan Cui wrote:
> Since we serialize the present/eject work items now, we don't need the
> semaphore any more.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Acked-by: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Jack Morgenstein <jackm@mellanox.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> ---
>  drivers/pci/host/pci-hyperv.c | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)

Dexuan,

while applying/updating these patches I notice this one may be squashed
into:

https://patchwork.ozlabs.org/patch/886266/

since they logically belong in the same patch. Are you OK with me doing
that ? Is my reading correct ?

Thanks,
Lorenzo

> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
> index 1d2e1cb617f4..0dc2ecdbbe45 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -447,7 +447,6 @@ struct hv_pcibus_device {
>  	spinlock_t device_list_lock;	/* Protect lists below */
>  	void __iomem *cfg_addr;
>  
> -	struct semaphore enum_sem;
>  	struct list_head resources_for_children;
>  
>  	struct list_head children;
> @@ -1648,12 +1647,8 @@ static struct hv_pci_dev *get_pcichild_wslot(struct hv_pcibus_device *hbus,
>   * It must also treat the omission of a previously observed device as
>   * notification that the device no longer exists.
>   *
> - * Note that this function is a work item, and it may not be
> - * invoked in the order that it was queued.  Back to back
> - * updates of the list of present devices may involve queuing
> - * multiple work items, and this one may run before ones that
> - * were sent later. As such, this function only does something
> - * if is the last one in the queue.
> + * Note that this function is serialized with hv_eject_device_work(),
> + * because both are pushed to the ordered workqueue hbus->wq.
>   */
>  static void pci_devices_present_work(struct work_struct *work)
>  {
> @@ -1674,11 +1669,6 @@ static void pci_devices_present_work(struct work_struct *work)
>  
>  	INIT_LIST_HEAD(&removed);
>  
> -	if (down_interruptible(&hbus->enum_sem)) {
> -		put_hvpcibus(hbus);
> -		return;
> -	}
> -
>  	/* Pull this off the queue and process it if it was the last one. */
>  	spin_lock_irqsave(&hbus->device_list_lock, flags);
>  	while (!list_empty(&hbus->dr_list)) {
> @@ -1695,7 +1685,6 @@ static void pci_devices_present_work(struct work_struct *work)
>  	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>  
>  	if (!dr) {
> -		up(&hbus->enum_sem);
>  		put_hvpcibus(hbus);
>  		return;
>  	}
> @@ -1782,7 +1771,6 @@ static void pci_devices_present_work(struct work_struct *work)
>  		break;
>  	}
>  
> -	up(&hbus->enum_sem);
>  	put_hvpcibus(hbus);
>  	kfree(dr);
>  }
> @@ -2516,7 +2504,6 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	spin_lock_init(&hbus->config_lock);
>  	spin_lock_init(&hbus->device_list_lock);
>  	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
> -	sema_init(&hbus->enum_sem, 1);
>  	init_completion(&hbus->remove_event);
>  	hbus->wq = alloc_ordered_workqueue("hv_pci_%x", 0,
>  					   hbus->sysdata.domain);
> -- 
> 2.7.4
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
