Return-Path: <baolu.lu@linux.intel.com>
X-Google-Smtp-Source: AB8JxZrmJ2qYSOYrwB8gNd/AJLjWbhcnbu5k2VuW3vP/iVqQjjDNI4LGEG2QV6x6JELigOAUcn/b
ARC-Seal: i=1; a=rsa-sha256; t=1526196809; cv=none;
        d=google.com; s=arc-20160816;
        b=Ru9TUq+2qN5x1FtFv/CAoVJ6s9PAzzpX2zPHT7/F/o0lVlh5I8ZFpWHy3vG9kMcBel
         LFsdP5mXb9pREcE4KiZG5HXKEYsLqiXqz/Y4VkVObux8y6XVgJGN/LVupgYjKVon/Biu
         5ggzO92y34PDzbcB66IJet3KMnQsVDlE6rjegaDxUBJLXjuStfP5cV/vnipHSFKDyMRR
         IH0PoU/12tVBZCtw6mOW2gkXBq9lZ2MGvYi25StdOLv8Ey2CCHCPK5633PczQPh1RkXs
         JoTSSExZMqnHP1cBriNIb3rRswSHQLsOFPo2jYFr4p9R/wajJyAd93J+qBADg7DqlnUu
         KVWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=nRS3PJ4jW57S1Fd5I2gEAvGdkJjyQibRfD52PAXcwZ0=;
        b=xd9XQA6wHX3cKj+icYuYe683AL/ROYrXGIKWU/LLqg2WZtNbMkuojoww0xH9ArW3Xt
         ZJaJAlh0ZxUtWDupiUyryZE0N3BqrueEp9NXW/lDNpJIiPsyzs0XL46hgbXlzeF7H3K/
         aWrKnZcS4erT8/XDySPrwx3j96WkTOEmzocX7RRQiQMGUkldQGeXqJDC1calXuJDmyQm
         97N7u8yHUTsPs9UirN8dGyNdGaaadKvVMwclgEHvdTA3WYELz54oEbHAomqtu1XcbN+s
         UwlgjKh271iCTztx+0R4F3QVPirVQxVTGq33VOE+1p7LT/PnI0g3WvrjomDeeX8vGN+U
         OtDA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of baolu.lu@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=baolu.lu@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of baolu.lu@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=baolu.lu@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,395,1520924400";
   d="scan'208";a="55435596"
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
Message-ID: <5AF7EA43.5060805@linux.intel.com>
Date: Sun, 13 May 2018 15:33:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1526072055-86990-4-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202361739379214?=
X-GMAIL-MSGID: =?utf-8?q?1600333346143502967?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 05/12/2018 04:53 AM, Jacob Pan wrote:
> Adding a flag in device domain into to track whether a guest or
typo:                                       ^^info

Best regards,
Lu Baolu

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
>  	u8 ats_qdep;
>  	u64 fault_mask;	/* selected IOMMU faults to be reported */
>  	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
