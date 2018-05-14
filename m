Return-Path: <baolu.lu@linux.intel.com>
X-Google-Smtp-Source: AB8JxZqUH1d/xIyT0TRqzexeDOuaMj8LLaK0mXOO4DBLiWhgYW5IbluQ/37IJNwk+Ld3Qo3gQia+
ARC-Seal: i=1; a=rsa-sha256; t=1526261772; cv=none;
        d=google.com; s=arc-20160816;
        b=iXXbY1Og6WIiCcnIahcKdC8D8ofvlNYs9vYXfhNt+PTMwjKJB37LnMVJy6IT8vEWD6
         wn4mP1UBWak1QZHgzqHPpkz5T6eUj2upMsfWcSPMasU2TusuVKEYa0RgVxpz7ka7qa5O
         OdERFSPaufBYR0CXA591wxZVp/lN8KsKKy5I5RIJ6GYufP9eajH2jUDoPfhnD0mtPBED
         WvFxxpJ/FfVTY779sLduoi6xnCyg2Pa0v4qWwCv3bEjOKrNPSZ1lM5838z0/JJm9odX/
         7lUvpw+/2wbh3l0g1pYASrXGtR2oqB5qYf6xrHCPdYYjSC2K4k8jtQLSSKkTSlmmtU0B
         0dEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=Xxwfr7ZJ2v8LER2snXN7YjO6UwZoSYrEjxwKRVaAqvo=;
        b=0PEOeBLDk6/z8dS7a0ar2LQj85S+/rXXjMyIKAE9SgwiI56Kexv8jWYXm74XN3hHtc
         eP02UfMOrim0KZ+Mc3WBX5SS3nobUP3rUklvxXUTWDYdq0xmDmgN5ml5wrnP5reMt9oA
         qEpTD8sTjr/Qv2/gjmQytdjFyR/HHFGR17dcCnpTaWeJU4iLfgeztvhx2lTlgHqnIvy4
         wJ8gxs8z2IyQZunBbrD4p/2RCY0akgiMUrZQCKUAPA2AdhQ1vDN9M5tunskUxaktQDZX
         UO42JMZAInoEdaLpDPx54/sKn1nH2ba8sv4dHJ6b7+HqCP/6pk3rA74nnrPhMpbrebtS
         QJKQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of baolu.lu@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=baolu.lu@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of baolu.lu@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=baolu.lu@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,398,1520924400";
   d="scan'208";a="228159237"
Subject: Re: [PATCH v5 06/23] iommu/vt-d: add definitions for PFSID
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1526072055-86990-7-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>,
 Christoph Hellwig <hch@infradead.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5AF8E808.5030402@linux.intel.com>
Date: Mon, 14 May 2018 09:36:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1526072055-86990-7-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202362182382878?=
X-GMAIL-MSGID: =?utf-8?q?1600401463826130792?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 05/12/2018 04:53 AM, Jacob Pan wrote:
> When SRIOV VF device IOTLB is invalidated, we need to provide
> the PF source ID such that IOMMU hardware can gauge the depth
> of invalidation queue which is shared among VFs. This is needed
> when device invalidation throttle (DIT) capability is supported.
>
> This patch adds bit definitions for checking and tracking PFSID.

Patch 6 and 7 could be posted in a separated patch series.

>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  include/linux/intel-iommu.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index ddc7d79..dfacd49 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -114,6 +114,7 @@
>   * Extended Capability Register
>   */
>  
> +#define ecap_dit(e)		((e >> 41) & 0x1)
>  #define ecap_pasid(e)		((e >> 40) & 0x1)
>  #define ecap_pss(e)		((e >> 35) & 0x1f)
>  #define ecap_eafs(e)		((e >> 34) & 0x1)
> @@ -284,6 +285,7 @@ enum {
>  #define QI_DEV_IOTLB_SID(sid)	((u64)((sid) & 0xffff) << 32)
>  #define QI_DEV_IOTLB_QDEP(qdep)	(((qdep) & 0x1f) << 16)
>  #define QI_DEV_IOTLB_ADDR(addr)	((u64)(addr) & VTD_PAGE_MASK)
> +#define QI_DEV_IOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) | ((u64)(pfsid & 0xff0) << 48))
>  #define QI_DEV_IOTLB_SIZE	1
>  #define QI_DEV_IOTLB_MAX_INVS	32
>  
> @@ -308,6 +310,7 @@ enum {
>  #define QI_DEV_EIOTLB_PASID(p)	(((u64)p) << 32)
>  #define QI_DEV_EIOTLB_SID(sid)	((u64)((sid) & 0xffff) << 16)
>  #define QI_DEV_EIOTLB_QDEP(qd)	((u64)((qd) & 0x1f) << 4)
> +#define QI_DEV_EIOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) | ((u64)(pfsid & 0xff0) << 48))

PFSID[15:4] are stored in Descriptor [63:52], hence it should look like:

+#define QI_DEV_EIOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) | ((u64)(pfsid & 0xfff0) << 48))



>  #define QI_DEV_EIOTLB_MAX_INVS	32
>  
>  #define QI_PGRP_IDX(idx)	(((u64)(idx)) << 55)
> @@ -467,6 +470,7 @@ struct device_domain_info {
>  	struct list_head global; /* link to global list */
>  	u8 bus;			/* PCI bus number */
>  	u8 devfn;		/* PCI devfn number */
> +	u16 pfsid;		/* SRIOV physical function source ID */
>  	u8 pasid_supported:3;
>  	u8 pasid_enabled:1;
>  	u8 pri_supported:1;

Best regards,
Lu Baolu
