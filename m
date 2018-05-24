Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1900785-1527165678-2-7509315710451913621
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527165677; b=WkXoTbz3+wgEueUANwrei80qXncjWFsik3B7P7IgfFORlf309V
    axrTxF09oHjuYspyLYwixX8gyZlcuguVimoDXF077tyijRTBjTKW5Krw0xKErHqR
    O1Xo/FSynDDBwq3YTh3/nftl5j/Mo4Ip8OTDJ/plwJj4QrhrfWNI93PSQBy9qxch
    WXW3T+eSmiVNtvrDxGO27V98WzLkOSWuKp8aymTTQHw3Z6O/gsW3O5PD+ZCziMYZ
    pxy+EzJV0el+IQfyU7glc1PCNKA7Tk4w+FQK4CQuPIkFiuQlpypiDt/lfuVklfmR
    Vum4dXHLFur84bNmERFytcR47sY8FmmdUtSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1527165677; bh=XTtJr
    XvfYfDWETgChUpqFnG8BoEldfC0HMgN8RqzMLs=; b=Ilggz+W6NSVzLYZLfaYsY
    hWs28O8jU4FUmR08ZiBn6sKePgAL8tjJU0LhD9BjOsXb/J5A/Voi9/6cry91B6TE
    rHW/ipQ2BrPW3kBvg+nNqvHoBQYurUNw/iYogpnGJDMi7Vj51lCMdNmb7yZvhRR7
    5GYDChQdnkDzh9xmuxSTBRCdG3kEeRDBqcaVfy75jODFGL/A2us2XNvEDVa9aMwG
    7XH8S9P4YUsRK9w1iOM/NRFgcjCcl9znvusqfaeEMrgFzNvcRCNPyRF1BIEmmU9I
    pmCpZAEZ5avPm2t9AFb9ZWGR000mrwmMG3hs9vrDOj+46VcTyLUTF1Hz/efwTegA
    w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=arm.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=arm.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDyggbRbWaXX0TCqH6PdCeaeXr/FWo5dxF6fKtc7afCjjl69v2P0DXQ0gl/j8dNR4zJqTHzCmzjVvKa5GSU25XsJqRgKQzmFBlalzRtwo5udg9j4oTGK
    1WBq4os5KsyfUfrK7j6J1EdA3L7c0C3Cz+s6y/EJguPzm5p04eWbeZVEuyDt3ruXwKTO91R8MNaQLZSOzLak50sqHnvZCndDs0zeqqMfBSSnTXGRvXRrTsG7
    8aY2uRmbmYlr8z+boL6ozA==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=DDOyTI_5AAAA:8
    a=6ZHmymdd3umwkvHkPMUA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 24 May 2018 13:41:01 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH] PCI: hv: Do not wait forever on a device that has
 disappeared
Message-ID: <20180524124101.GB20732@e107981-ln.cambridge.arm.com>
References: <KL1P15301MB0006DF4209AEE3809ABD303FBF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <KL1P15301MB0006DF4209AEE3809ABD303FBF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
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
Cc: "'olaf@aepfle.de'" <olaf@aepfle.de>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
 "'jasowang@redhat.com'" <jasowang@redhat.com>,
 "'driverdev-devel@linuxdriverproject.org'"
 <driverdev-devel@linuxdriverproject.org>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "'apw@canonical.com'" <apw@canonical.com>,
 "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>,
 'Bjorn Helgaas' <bhelgaas@google.com>,
 "'vkuznets@redhat.com'" <vkuznets@redhat.com>,
 Haiyang Zhang <haiyangz@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 09:12:01PM +0000, Dexuan Cui wrote:
> 
> Before the guest finishes the device initialization, the device can be
> removed anytime by the host, and after that the host won't respond to
> the guest's request, so the guest should be prepared to handle this
> case.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> ---
>  drivers/pci/host/pci-hyperv.c | 46 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 34 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
> index ad6a64d..248765f 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -556,6 +556,26 @@ static void put_pcichild(struct hv_pci_dev *hv_pcidev,
>  static void get_hvpcibus(struct hv_pcibus_device *hv_pcibus);
>  static void put_hvpcibus(struct hv_pcibus_device *hv_pcibus);
>  
> +/*
> + * There is no good way to get notified from vmbus_onoffer_rescind(),
> + * so let's use polling here, since this is not a hot path.
> + */
> +static int wait_for_response(struct hv_device *hdev,
> +			     struct completion *comp)
> +{
> +	while (true) {
> +		if (hdev->channel->rescind) {
> +			dev_warn_once(&hdev->device, "The device is gone.\n");
> +			return -ENODEV;
> +		}
> +
> +		if (wait_for_completion_timeout(comp, HZ / 10))
> +			break;
> +	}
> +
> +	return 0;

This is pretty racy, isn't it ? Also, I reckon you should consider the
timeout return value as an error condition unless I am completely
missing the point of what you are doing.

Lorenzo

> +}
> +
>  /**
>   * devfn_to_wslot() - Convert from Linux PCI slot to Windows
>   * @devfn:	The Linux representation of PCI slot
> @@ -1569,7 +1589,8 @@ static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *hbus,
>  	if (ret)
>  		goto error;
>  
> -	wait_for_completion(&comp_pkt.host_event);
> +	if (wait_for_response(hbus->hdev, &comp_pkt.host_event))
> +		goto error;
>  
>  	hpdev->desc = *desc;
>  	refcount_set(&hpdev->refs, 1);
> @@ -2070,15 +2091,16 @@ static int hv_pci_protocol_negotiation(struct hv_device *hdev)
>  				sizeof(struct pci_version_request),
>  				(unsigned long)pkt, VM_PKT_DATA_INBAND,
>  				VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> +		if (!ret)
> +			ret = wait_for_response(hdev, &comp_pkt.host_event);
> +
>  		if (ret) {
>  			dev_err(&hdev->device,
> -				"PCI Pass-through VSP failed sending version reqquest: %#x",
> +				"PCI Pass-through VSP failed to request version: %d",
>  				ret);
>  			goto exit;
>  		}
>  
> -		wait_for_completion(&comp_pkt.host_event);
> -
>  		if (comp_pkt.completion_status >= 0) {
>  			pci_protocol_version = pci_protocol_versions[i];
>  			dev_info(&hdev->device,
> @@ -2287,11 +2309,12 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
>  	ret = vmbus_sendpacket(hdev->channel, d0_entry, sizeof(*d0_entry),
>  			       (unsigned long)pkt, VM_PKT_DATA_INBAND,
>  			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> +	if (!ret)
> +		ret = wait_for_response(hdev, &comp_pkt.host_event);
> +
>  	if (ret)
>  		goto exit;
>  
> -	wait_for_completion(&comp_pkt.host_event);
> -
>  	if (comp_pkt.completion_status < 0) {
>  		dev_err(&hdev->device,
>  			"PCI Pass-through VSP failed D0 Entry with status %x\n",
> @@ -2331,11 +2354,10 @@ static int hv_pci_query_relations(struct hv_device *hdev)
>  
>  	ret = vmbus_sendpacket(hdev->channel, &message, sizeof(message),
>  			       0, VM_PKT_DATA_INBAND, 0);
> -	if (ret)
> -		return ret;
> +	if (!ret)
> +		ret = wait_for_response(hdev, &comp);
>  
> -	wait_for_completion(&comp);
> -	return 0;
> +	return ret;
>  }
>  
>  /**
> @@ -2405,11 +2427,11 @@ static int hv_send_resources_allocated(struct hv_device *hdev)
>  				size_res, (unsigned long)pkt,
>  				VM_PKT_DATA_INBAND,
>  				VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> +		if (!ret)
> +			ret = wait_for_response(hdev, &comp_pkt.host_event);
>  		if (ret)
>  			break;
>  
> -		wait_for_completion(&comp_pkt.host_event);
> -
>  		if (comp_pkt.completion_status < 0) {
>  			ret = -EPROTO;
>  			dev_err(&hdev->device,
> -- 
> 2.7.4
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
