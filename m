Return-Path: <baolu.lu@linux.intel.com>
X-Google-Smtp-Source: AB8JxZr5rcjOpcSAgyYzTHWN5J2wQVhwyj++D6SCpIu2/bCrBeO/bXrac0F5QeVoD6aTcrks0OzA
ARC-Seal: i=1; a=rsa-sha256; t=1526198516; cv=none;
        d=google.com; s=arc-20160816;
        b=ofzT34topstG3yuoE+pVzB0TWHA3ZINppcepvcIeVj1817CstQIecOexHhtxBiN3i5
         1TOjoeL9N7Z9UocWzPfj+pj8mLSQipkfmk97KMy7KyeDwuWiGW94s11MQQZyjmGPpHom
         pEXiS0EUR9pers/xZuaWwHoM8SBOfFkYiuVAqYlY7vFR3RREblf8NOtHQ8vX5lLbHYKK
         bqPIeypj52YTwlLkVJfgvRhHEUKR4UpoGjhz64YIVeGyDlTRHPwFyr+MiAEsB3ohk0yu
         g8RVCyHFsI9o9PwwxKuM2TzjuI8DPw8AMXOFydxtEjRAk3VrD7HDZz65sTCacQeC4V8s
         Pllw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=4i2iwfwRARuJIjFwJj4+Z2gOtqOQYYQtbc+9gc43EJU=;
        b=l0Lmqz15+zM01eDnacY0gVp6UfNFbNsN/JHkzgltTogO8pRBrEk1i4debIojog5Bx5
         ryhpgXIKse8LtUbETg9WbBn/mZUqi4nXpku7Xu9R4rAtb4Cva72i5tFtIY2k59dwYzt9
         3Nt8YFS+I3w+ska45vcfxF/upZzJiECiq1DwsdiBqTctS5a9qSXnsFY40zR1cZgoxP1p
         wSyG2WH+PpWryI1wBrx9SiDJ2wwts5wRLEZvGQ9p/TVTRnK/29TckhunX8V4cHio56zI
         VJQJBF+javq74DD9WP+VGR7MEEEOdieGf11zScoQ9EYcoLL8oheG2K5LtuOUgk62HzVr
         I7Bw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of baolu.lu@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=baolu.lu@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of baolu.lu@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=baolu.lu@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,395,1520924400";
   d="scan'208";a="50410118"
Subject: Re: [PATCH v5 03/23] iommu/vt-d: add a flag for pasid table bound
 status
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1526072055-86990-4-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>,
 Christoph Hellwig <hch@infradead.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5AF7F0EE.902@linux.intel.com>
Date: Sun, 13 May 2018 16:01:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1526072055-86990-4-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202361739379214?=
X-GMAIL-MSGID: =?utf-8?q?1600335135357923526?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi again,

On 05/12/2018 04:53 AM, Jacob Pan wrote:
> Adding a flag in device domain into to track whether a guest or
> user PASID table is bound to a device.
>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  include/linux/intel-iommu.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 304afae..ddc7d79 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -473,6 +473,7 @@ struct device_domain_info {
>  	u8 pri_enabled:1;
>  	u8 ats_supported:1;
>  	u8 ats_enabled:1;
> +	u8 pasid_table_bound:1;

Can you please add some comments here? So that, people can
understand the purpose for this bit exactly.

Best regards,
Lu Baolu

>  	u8 ats_qdep;
>  	u64 fault_mask;	/* selected IOMMU faults to be reported */
>  	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
