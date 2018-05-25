Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4001181-1527262956-2-14527120136109072887
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527262956; b=DVm+Zoo40lxc3fzdf4D2f8Yrgcs5uitCzzhSqTBcapqeCty2Af
    dV9EQDOO/j1+yFn7ehSivDqkpzl2qx8WgZkHoKW0VPmaepJ2LxlGFJHd+LXaevJU
    dOKfiEfZFFGQ2HsjOpN0WES0LrdkPvDSjNfbwj4KnMijqtq2xz5uxXlYUmjejc3X
    uitd8bfvjWjRFSL5HR/DDhrcXlur5uWtD1a5gSPjfx4NF9/oM2vYERw9IsDClVTB
    IbHe6ocACnWU6D7MdV6sS6Pd5dDGjNhFvIzTa9O3MEvIrPyk05BrEYmbue90de+s
    kR3FZHyCow132nKednDr/UAPy7su3CLyyWrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527262956; bh=CStK0UH1RnpX9uTTcEevlfRVOWr0v9
    jJZpd3xgJJxos=; b=nOCId1nURZz0NQnApKkdu1p/R1B0rSfSJ9uLT4XXjN8PeS
    xF8+Jn0L8lyS9WU1BAl1GRfLJqbrZ8HivGNtOARlsvMJqGkj6a0zx9GoYpq8T3Ab
    +spc9GetXICpvFWZiMV+VS/wpcjTTOn2A977vkEYp8DUthxsPer6iNqLdqXG1M4y
    ETgc1/ZYZDuf2HZ1o1Iz0aZ57DLWjaNW2tfGPMEtfsEjjHK1iR6KHvFzOVPEEBin
    D+lWF5tOGOFLkl+iqyL/nhq+wovWNjJO96DJb+vnjN6fGgJYXnBa+MyDtd+Mb8lm
    +8JBuahEKtx3lPoU5wPOMN4X+IRFWbICjfO7FgyQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfGXkohTdcBMVtmToiUBOeE8+pPN0XASpALZZccwZqaRCzlD0h2D+r71aSeW5R6Q7oeqZl9f1lHDMQ4fdLROu3GMJNqqMWDxtc7EsCNCTPEZjuE1f7Yg/
    vXiutQYF0M9FPnyfhwUhcvlRpwOBub4GVi22ynBGik4BfC+UaRPg9PdWF8ertIPS4O7NvnRi3qchSAdQ7O23MV0megKvVOe1Y6weWSIaueBQkIBqHc4kt+Gq
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=wUZLH9Bnd-WLXg72xvsA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966130AbeEYPmb (ORCPT <rfc822;linux@kroah.com>);
        Fri, 25 May 2018 11:42:31 -0400
Received: from mga18.intel.com ([134.134.136.126]:65454 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965570AbeEYPma (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 May 2018 11:42:30 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,440,1520924400";
   d="scan'208";a="50197259"
Date: Fri, 25 May 2018 09:42:29 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH 1/7] fs: allow per-device dax status checking for
 filesystems
Message-ID: <20180525154229.GA11044@linux.intel.com>
Mail-Followup-To: Ross Zwisler <ross.zwisler@linux.intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Toshi Kani <toshi.kani@hpe.com>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        xfs <linux-xfs@vger.kernel.org>
References: <20180525025518.11405-1-ross.zwisler@linux.intel.com>
 <20180525025518.11405-2-ross.zwisler@linux.intel.com>
 <20180525050218.GF4507@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525050218.GF4507@magnolia>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 24, 2018 at 10:02:18PM -0700, Darrick J. Wong wrote:
> On Thu, May 24, 2018 at 08:55:12PM -0600, Ross Zwisler wrote:
> > From: "Darrick J. Wong" <darrick.wong@oracle.com>
> > 
> > Remove __bdev_dax_supported and change to bdev_dax_supported that takes a
> > bdev parameter.  This enables multi-device filesystems like xfs to check
> > that a dax device can work for the particular filesystem.  Once that's
> > in place, actually fix all the parts of XFS where we need to be able to
> > distinguish between datadev and rtdev.
> > 
> > This patch fixes the problem where we screw up the dax support checking
> > in xfs if the datadev and rtdev have different dax capabilities.
> > 
> > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> 
> Reviewed-by: Darr...oh, I'm not allowed to do that, am I?
> 
> Would you mind (re)sending this to the xfs list so that someone else can
> review it?
> 
> --D

Thanks for the review, Darrick.

I think at one point Dave said that if you touch more than 1 filesystem with a
series you should just CC linux-fsdevel and omit the individual filesystems?
I realize that this series only touches ext2 and ext4 a little, but that's
what I opted for.

Is that sufficient to get to the rest of the XFS developers, or would you like
a resend adding linux-xfs?
