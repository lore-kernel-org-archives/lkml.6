Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17452C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 06:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E9C2086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 06:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E9C2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbeKGQYm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 11:24:42 -0500
Received: from mga07.intel.com ([134.134.136.100]:1142 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbeKGQYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 11:24:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 22:55:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,474,1534834800"; 
   d="scan'208";a="89193802"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga006.jf.intel.com with ESMTP; 06 Nov 2018 22:55:41 -0800
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 6 Nov 2018 22:55:41 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.117]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.102]) with mapi id 14.03.0415.000;
 Wed, 7 Nov 2018 14:55:39 +0800
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v4 05/12] iommu/vt-d: Reserve a domain id for FL and PT
 modes
Thread-Topic: [PATCH v4 05/12] iommu/vt-d: Reserve a domain id for FL and PT
 modes
Thread-Index: AQHUdMlFMMstJpzVJ0qoQmcCQ2mzjKVD4jMg
Date:   Wed, 7 Nov 2018 06:55:38 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439D5FAE7@SHSMSX104.ccr.corp.intel.com>
References: <20181105053151.7173-1-baolu.lu@linux.intel.com>
 <20181105053151.7173-6-baolu.lu@linux.intel.com>
In-Reply-To: <20181105053151.7173-6-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTIwMTFlY2MtNmQ0NS00ZTgwLWJiYzMtOGJlMDIwNzFjNDQ2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUnpMSThNalpxUzdUeDNvMElSZkNqbXNKYXRhS0FSK2h4S0tnRExpeGoyREhNZlZhUVwvSmUzMCsxM0RzNnZaS2YifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
> Sent: Monday, November 5, 2018 1:32 PM
> Subject: [PATCH v4 05/12] iommu/vt-d: Reserve a domain id for FL and PT modes
> 
> Vt-d spec rev3.0 (section 6.2.3.1) requires that each pasid
> entry for first-level or pass-through translation should be
> programmed with a domain id different from those used for
> second-level or nested translation. It is recommended that
> software could use a same domain id for all first-only and
> pass-through translations.
> 
> This reserves a domain id for first-level and pass-through
> translations.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Cc: Sanjay Kumar <sanjay.k.kumar@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 10 ++++++++++
>  drivers/iommu/intel-pasid.h |  6 ++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 9331240c70b8..2f7455ee4e7a 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -1618,6 +1618,16 @@ static int iommu_init_domains(struct intel_iommu
> *iommu)
>  	 */
>  	set_bit(0, iommu->domain_ids);
> 
> +	/*
> +	 * Vt-d spec rev3.0 (section 6.2.3.1) requires that each pasid
> +	 * entry for first-level or pass-through translation modes should
> +	 * be programmed with a domain id different from those used for
> +	 * second-level or nested translation. We reserve a domain id for
> +	 * this purpose.
> +	 */
> +	if (sm_supported(iommu))
> +		set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);

"FLPT_DEFAULT_DID" looks very likely for first level translation. How about
"PT_FL_DEFAULT_DID"?

>  	return 0;
>  }
> 
> diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
> index 12f480c2bb8b..03c1612d173c 100644
> --- a/drivers/iommu/intel-pasid.h
> +++ b/drivers/iommu/intel-pasid.h
> @@ -17,6 +17,12 @@
>  #define PDE_PFN_MASK			PAGE_MASK
>  #define PASID_PDE_SHIFT			6
> 
> +/*
> + * Domain ID reserved for pasid entries programmed for first-level
> + * only and pass-through transfer modes.
> + */
> +#define FLPT_DEFAULT_DID		1

Would be helpful to elaborate why DID 1 is selected in the patch
description.

Regards,
Yi Liu

