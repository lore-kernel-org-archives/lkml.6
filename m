Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-375240-1527092007-2-5422939334238605534
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527092007; b=AG1WrC5RCjdPEPwIqV/VAK4s67EMyJKUh3N1XSyaUjlnXOuFQz
    HIO/zCgxaBBs5FXrHHq4T9eSJjVMpkQa0Q6dyfFAnGmFT7z1daAK8ndoRfdGIpQQ
    mwdzTyTir9nsubhyr0JzAWBLVmCBTnSb3WRhvoFG6jjTyfOVABqjC/uq6povE0Ba
    M387uZwXE3YjuKVq6dIkyJSYE+b5EX0FLAWebv07tjJyx2ty9s/wZ1yth1w3+BEA
    fhn3FIXKdmKCCdXVX223Ye7wvsPPGrwhbfzMKsggQxN5ZyIX0Znxig5ej6io2mJs
    JmnJg8bki9EF00ovpU7lpHBCadZHxqGpFrdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527092007; bh=yA6yUOBwnt3TCvQiFhLddP/vlj5/Q6
    v37b6dBuNu1FM=; b=ezvqFE4cP4SmgHwOq1KJxMZPk6RAeDj+PKV78diIFt6tq7
    qZe56TOi0jDyd7w99UiTAx8sr56I0ozUCT2HnzXo01/y6ib/4vj87Rz5UMlKU/nq
    8Aq8y5vOGtdRTCgtxdZlIZ/A0yIryCFT2SJB3l5xiHwJh7FxgYbizGL+emJ0jGrU
    szzZcNYeHQeJqIFluvHmJmzRk3o1e90e5rYSRFSKocxfCPxCVEUHtk6eDU1ccznB
    WrZUhqNdMzNZqCu9GT9EOpqcPCyoNj4mxXZF8shDVWWQdAkyW1A9JnuOPGJ2xAAA
    l08jBVfowZAMRm+I5lCrIW8rOu49poAfTUrPdfvw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNPInN1spKTkywZO+pCeCHy5omsNZzG462oVpr9NF/fn8e7RFcS5Oh9VYGTaDAVex/kvAUYfJtRcVRRJaZhVu1FtyP2K56bZWNHuE10Be/txAwUgoWe+
    s4TdS7e6vb8XDiiAZ8WeAUvXphOceRHyCa7TAW6Ja+RBsYKYFxl8prfigCR3nOqiM8/WkYc34abdvx8zAM4yRkCXxA5dfQqcVnOVdI7PIKZCNTaktiKhm/e+
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=20KFwNOVAAAA:8 a=tLcInzcBvtUTPvREeMwA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754630AbeEWQNV (ORCPT <rfc822;linux@kroah.com>);
        Wed, 23 May 2018 12:13:21 -0400
Received: from mga14.intel.com ([192.55.52.115]:43108 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751646AbeEWQNU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 May 2018 12:13:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,433,1520924400";
   d="scan'208";a="51590838"
Date: Wed, 23 May 2018 10:13:19 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 6/9] dax: introduce a ->copy_to_iter dax operation
Message-ID: <20180523161319.GA29519@linux.intel.com>
Mail-Followup-To: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org,
        Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com,
        linux-fsdevel@vger.kernel.org
References: <152539236455.31796.7516599166555186700.stgit@dwillia2-desk3.amr.corp.intel.com>
 <152539239729.31796.4765429575408958580.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152539239729.31796.4765429575408958580.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 05:06:37PM -0700, Dan Williams wrote:
> Similar to the ->copy_from_iter() operation, a platform may want to
> deploy an architecture or device specific routine for handling reads
> from a dax_device like /dev/pmemX. On x86 this routine will point to a
> machine check safe version of copy_to_iter(). For now, add the plumbing
> to device-mapper and the dax core.
> 
> Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Looks good to me.

Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>
