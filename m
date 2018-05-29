Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2785586-1527631299-2-12031096904312431919
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527631299; b=WhY/qocSy8vFwFLaE3+MV98Z/i2MTHq1X3uadN5SvuhMXBnHR9
    znndJpkdFudi1qaKjCNTawHx142Z/uDubr85EgqBNpJyqpJQd0UfA/uY+O72AUH6
    FN7TnxOv8ZxfwJPVXATJyIBcYZBKHnjMQ+FXnzqt6LSxcj5kBE+aH1m/Rgs7nI4P
    ynG/bH3t2jpbQOidVvqIFwJTR3wZbKHivyh1Vx9Y2r/YEAINHz1vsmAt6fz2nADD
    vRuJVRDV4vgr4ic3lsgoJk4V80/3RQJwGcvKVkcRriqOldR75qLqLVgcu293pfyx
    y588+0Z6NdxBqmCttZsVpAFF63E+4YA2rd8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527631299; bh=HGA08dhrgWIzhl7Pz3XBZ5/goaPNlc
    8Xl7/lkJsoZlw=; b=arZ0iR6iA+f72U2YvYq+5ZOHDAiGHc339ULJlhqSo8bvdu
    xmtXViSFvOFmyrceJlakmEWpjSywPAdeRdTREs9eKgjUgQaC5j2i2xa2oi5ZOdbS
    QrELe9EFPJUEH5qqUp/T13JqJCax5T4I30ZgwVFPBGTL8VPngF/QCf6EVKyYiBIx
    1FjFEl94zLqEhMOzmCZJzyOQd7kP6CeeHfJJQ/dQyoMcQocsnVltUCai389ylMl2
    lERyxjPs7f7036lzpFTtqqUigUh8ksUXlO5EReTJjwgzalZu359HMEQGdBN7BdiE
    bIeMc1GgNjpKmTPMHa/C6yjgt3v/4SI3L9k9FqDQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNjZkgCYxZBZAaP0NkusgGoEV0ONg29UjTWLnJRUvM69ZsUi0Dfkd2G+4A/MuVZxteHfnv7MYl5G95o2j9cVein4rsRqTSfsQn5m13gluZRCSWEILB0M
    afUTDqLMSeNGWs9TWXZ7ICcA6TK8t31dRhDxRxjJzKG3vb/wibr4ccjpw/WXBOdjECjGa/azXmcRvFTRJMx8PRyJdz20u49/SnmFQZNF/DgEtj+VjsbweEEy
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=WVGbnYGx-VxYQHjBUdIA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967491AbeE2WBR (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 18:01:17 -0400
Received: from mga12.intel.com ([192.55.52.136]:62286 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967368AbeE2WBP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 18:01:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,458,1520924400";
   d="scan'208";a="43149773"
Date: Tue, 29 May 2018 16:01:14 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Dave Jiang <dave.jiang@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 2/7] dax: change bdev_dax_supported() to support
 boolean returns
Message-ID: <20180529220114.GA13948@linux.intel.com>
Mail-Followup-To: Ross Zwisler <ross.zwisler@linux.intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Toshi Kani <toshi.kani@hpe.com>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Dave Jiang <dave.jiang@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-xfs@vger.kernel.org
References: <20180529195106.14268-1-ross.zwisler@linux.intel.com>
 <20180529195106.14268-3-ross.zwisler@linux.intel.com>
 <20180529212510.GJ30110@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529212510.GJ30110@magnolia>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 29, 2018 at 02:25:10PM -0700, Darrick J. Wong wrote:
> On Tue, May 29, 2018 at 01:51:01PM -0600, Ross Zwisler wrote:
> > From: Dave Jiang <dave.jiang@intel.com>
> > 
> > The function return values are confusing with the way the function is
> > named. We expect a true or false return value but it actually returns
> > 0/-errno.  This makes the code very confusing. Changing the return values
> > to return a bool where if DAX is supported then return true and no DAX
> > support returns false.
> > 
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> 
> Looks ok, do you want me to pull the first two patches through the xfs
> tree?
> 
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

Thanks for the review.

I'm not sure what's best.  If you do that then Mike will need to have a DM
branch for the rest of the series based on your stable commits, yea?

Mike what would you prefer?
