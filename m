Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-333886-1519830664-2-4994764640821900819
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enroda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519830663; b=pXucpUL1k3v4mIWje0/kaJY2iDOaLdEoMluplh4ufNoiJRp
    DcQKuBNhz2ICDwFrfHaK97YjSiNjc+9g1VU1k78OoZDB1D6PlnDYUX8k/AJ7bKG2
    9Ob8BWGXrHYEamOtj1blCGSKE2CE3L3sswxUUmhwnD3C+lWCCe1fNlOMRsjUmGoJ
    PUHHQ947vwFAZW/yhG7y4FFrYyq0DxJ8iOYzcip4znbT2w1DD2cMD61o6F3jO1xo
    oVYTwGy1tL9LF2DSAL1WTQL69Y+VK85g9MP6m4FCjnzadNw5570elEjEcHx2E82F
    m/6E0qj/WjRD37R5CyLzRxp2gI1kqUFjlqROlVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519830663; bh=qub0Fay9rtAczDxqM67XQJIHqx70pjH8si2uij+TSqk=; b=W
    STYwtQbvFiFo8jZRf1NGRTfzD586hIwfic9k3HCJD3AIbH37xYf/YAT48RV54iaj
    CDEZUlXnjAQdxfj4ArBajy/NJcAuuCApz/SI6bX3danC1i6Cb+NJlWkRRYLHm3o5
    ht66OrtOcUwWFwBKU0hMPh61SnmGf8UsX848kMJR0xULS3HMbEI1x2ZgQZw4QpeX
    PbWd6YpFZV4p1C+42veHFjxlG1Fhqo69M8c7bq7DOpw/I9O6TBDzDXX79KJlA4PV
    bCS/5zZgNyMqr367etOtp1JURPBzzchO7BjMpkDAydr256OpfE7wW8BIZgoWyIBY
    +9a1GSTbH1YQzP3JZOeKA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932151AbeB1PKp (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:10:45 -0500
Received: from mga01.intel.com ([192.55.52.88]:28983 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932435AbeB1PIL (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 28 Feb 2018 10:08:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,406,1515484800";
   d="scan'208";a="207743779"
Date: Wed, 28 Feb 2018 07:10:13 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
        "# v4 . 4+" <stable@vger.kernel.org>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix a potential memory leak
Message-ID: <20180228071013.53e91c90@jacob-builder>
In-Reply-To: <1519450947-9760-1-git-send-email-baolu.lu@linux.intel.com>
References: <1519450947-9760-1-git-send-email-baolu.lu@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 24 Feb 2018 13:42:27 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> A memory block was allocated in intel_svm_bind_mm() but never freed
> in a failure path. This patch fixes this by free it to avoid memory
> leakage.
> 
looks good to me.

Thanks,
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v4.4+
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-svm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 35a408d..3d4b924 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -396,6 +396,7 @@ int intel_svm_bind_mm(struct device *dev, int
> *pasid, int flags, struct svm_dev_ pasid_max - 1, GFP_KERNEL);
>  		if (ret < 0) {
>  			kfree(svm);
> +			kfree(sdev);
>  			goto out;
>  		}
>  		svm->pasid = ret;

[Jacob Pan]
