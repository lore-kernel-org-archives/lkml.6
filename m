Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-218482-1522445012-5-9610480629721301057
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, HEXHASH_WORD 1.624,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522444999; b=HYsS8LNcc10ORwX5NWLVfNBZv90VjdHgnQRH4xgKweep0d5ZAm
    adcvZG/2u34svboxdyzUEjmZGGAgfvtVb8frdKkzRYqGY2MFCQmYFLpIJu1l5GWz
    xv7mKl1djRH1f7yFJ5AfhTHn3uH1ttKtRLAnjQSjWw3bB49b5guUBh/0bgGmLs8H
    +28BIL1nzLznIEJksjpK/4heDtKDw4vviiQD6D5Hx3AQMDFumu0Mfqhfkql9Sno+
    lZhQBoXLGGIKu6bSkRhaw+VGnonWxqqwmJQs4xvpwEx1dtvwEf8K3hnSbYtE8MqD
    cJ6La01EqI7SNpCih8Ol1yjD73bLFklj4S6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522444999; bh=dZsak
    UY97YCNeW0x2BpapJzjo7PIUL2tZViGiJJ2N9Y=; b=VojypS7FkGCpRRCMDv7k2
    rHaA472/2K3sl1Zj2sUhsc3rvZjuPiB3EtkjDEeiTdK3I2tMvvd4WHIgDnv1tKda
    lPnI3ipI4scenlmKHrjKdeCHufWM4AAM0TXTAXyYv2yywkI9bMNO/VXhLg4kZmwD
    8xf7WyFQc2Cv8JGhiXN6Z7Cqh8/h3Y8trxjfct8BtVV9lmgyY/whNlKpKCid092w
    pmwbP98Oer59hx1D+lpJTgruffuKnV/5hfIbR7bCMl9oJNVGsF4vR+Fp2ez4Zv6c
    xwyYBMrMzxKa2XzZIlqJg2pVwiNX5eerng6Lxkwo8GCxNuCvumpdywKRojaqV9bP
    w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDb/BPkbhPi/72Ld36xpXHXQN1qhnOJuwBHIi05SA/us2ZyxTGTtIyJ5J8i3C5an1AbZ7bq9NgI8CQf3lUMdVHbW9McSqIbaaIPyhgsxzzdkk80GDHKS
    R//3hwvwjnsxvkwOyweeUnmEp/IAPmP7IKfl+8+iZ9MPN/jPd69R6ME8gwfPv6Uko3yxjZNP7nbQ1ltXkJI9BM0bRC+FQxevAbhOuHcBFh5YgMKBT1//y3cH
    ebnnRK7gO21qa21/8auBzw==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8
    a=DDOyTI_5AAAA:8 a=PbKyzNdyVeYQkthHfLUA:9 a=5y72ZMmNcTrGiLiY:21
    a=qGt-RFI-wgqcme9H:21 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A7321777
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=helgaas@kernel.org
Date: Fri, 30 Mar 2018 16:23:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
Subject: Re: [PATCH v5] PCI: hv: Make sure the bus domain is really unique
Message-ID: <20180330212311.GB9322@bhelgaas-glaptop.roam.corp.google.com>
References: <4BF97B43-5339-4750-9704-23D6AAC4A01E@microsoft.com>
 <105A3FAC-23AF-40F9-8B83-F00DED14EC43@microsoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <105A3FAC-23AF-40F9-8B83-F00DED14EC43@microsoft.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 Jake Oshins <jakeo@microsoft.com>, Bjorn Helgaas <bhelgaas@google.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 07:35:04PM +0000, Sridhar Pitchai wrote:
>   >When Linux runs as a guest VM in Hyper-V and Hyper-V adds the virtual
>   >PCI bus to the guest, Hyper-V always provides unique PCI domain.
>   >
>   >commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
>   >overrode unique domain with the serial number of the first device added
>   >to the virtual PCI bus. The reason for that patch is to have a consistent
>   >and short name for the device. But commit 4a9b0933bdfc ("PCI: hv: Use
>   >device serial number as PCI domain") will not guarantee unique domain id.
>   >For example, if the serial number of the device is 0 and there exists a
>   >PCI bus with domain 0 already, this will cause the PCI bus registration
>   >with kernel fails.
>   >
>   >commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI
>   >domain") need to be reverted. Also, we no longer need it as commit
>   >4a1626dd233e ("netvsc: transparent VF management") remove the
>   >need for it.

Do you mean 0c195567a8f6 ("netvsc: transparent VF management")?

I don't see a 4a1626dd233e commit in Linus' tree.

The connection between 0c195567a8f6 ("netvsc: transparent VF
management") and this Hyper-V domain ID issue is not clear to me at
all.  But obviously I'm not a networking or a Hyper-V person.

A hint in the changelog about what that connection is would be nice.

>   >Revert commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI
>   >domain") so we can reliably support multiple devices being assigned to
>   >a guest.
>   >
>   >This revert should only be backported to kernels that contain commit
>   >4a1626dd233e ("netvsc: transparent VF management").
>   >
>   >Fixes: 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
>   >Signed-off-by: Sridhar Pitchai <sridhar.pitchai@microsoft.com>
>   >Cc: stable@vger.kernel.org

This backporting guidance is very confusing.

4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
appeared in v4.11.

0c195567a8f6 ("netvsc: transparent VF management") appeared in v4.14.

The changelog and the "Fixes" tag both suggest that 4a9b0933bdfc was
flat-out buggy and should be reverted unconditionally.  That would
mean this patch should be applied to v4.11 and later stable kernels.

But the changelog also says "only revert 4a9b0933bdfc if you have
0c195567a8f6".  That would mean this patch should only be applied to
v4.14 and later stable kernels.

Which is it?  You can answer in this thread if you want, but Lorenzo
will ultimately be looking for a v6 patch with a corrected changelog.

>   >---
>   >Changes in v5:
>   >* fix the commit comment. [Lorenzo Pieralisi, Bjorn Helgaas]
>   >* fixed the patch white space.
>   >---
>   > drivers/pci/host/pci-hyperv.c | 11 -----------
>   > 1 file changed, 11 deletions(-)
>   >
>   >diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
>   >index 2faf38eab785..ac67e56e451a 100644
>   >--- a/drivers/pci/host/pci-hyperv.c
>   >+++ b/drivers/pci/host/pci-hyperv.c
>   >@@ -1518,17 +1518,6 @@ static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *hbus,
>   > 	get_pcichild(hpdev, hv_pcidev_ref_childlist);
>   > 	spin_lock_irqsave(&hbus->device_list_lock, flags);
>   > 
>   >-	/*
>   >-	 * When a device is being added to the bus, we set the PCI domain
>   >-	 * number to be the device serial number, which is non-zero and
>   >-	 * unique on the same VM.  The serial numbers start with 1, and
>   >-	 * increase by 1 for each device.  So device names including this
>   >-	 * can have shorter names than based on the bus instance UUID.
>   >-	 * Only the first device serial number is used for domain, so the
>   >-	 * domain number will not change after the first device is added.
>   >-	 */
>   >-	if (list_empty(&hbus->children))
>   >-		hbus->sysdata.domain = desc->ser;
>   > 	list_add_tail(&hpdev->list_entry, &hbus->children);
>   > 	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>   > 	return hpdev;
>   >-- 
> >2.14.1
> 
> Hi Lorenzo,
> Did you get a chance to look at the patch v5. Please let me know if
> anything I need to address further.

I think Lorenzo is out this week, but I suspect he'll look at it next
week.

Bjorn
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
