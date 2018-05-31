Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2115951-1527805649-2-18365565768057717541
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527805649; b=FPx3YrklRrspeg+c5BhAC8oA9JQbC4s0d1rozYLR63YQUC1U9/
    T5C2d1eOrioOkiceC8Zv3Zh7VIsBpX3N8yFTdqdihGzVSWfYa45DoHweufFrWPj/
    qVnYbnsdVm+kRBSUtyVZRmKQ3lXUhHYInVVygVGRMJ77+/wAo0DxMS4dWDaIOQPS
    WVRjGglBv4TIQ+Q8VgtDJvNFIDtZ5eyc/Q3Nnon6AwhATQRxi5quozi/Md1xkLUM
    QArp+G3+F5YVrTpbYcDrYTojaCx39WWp2nkJAT/33BsSbPM+2yDoNYWhZoNku04a
    4iiAeNx+MLY2pjNVOJt8FNUmgcTBFiPtO2Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527805649; bh=Smv8FzJ3gQEVR7k61MhHDqTK25gdQQ
    FaASkpzyEoAr0=; b=fBiK/fLj9RmbtRiCcPrId1yWj1YXNPnq3txN5/pmu96Tey
    Rx+clfGZWvIfW6NIRWxnRIHOmOJ0ENLhbb2RjeWzK9tIX9tdmsQSgH6alGt6Jjxb
    pj5LATV0g7POM44DWK78rUufwUSVe0Serbkx/94IAe0UOlAV6Pd7zooUuaSVyA8g
    eIWJwWca0Iw2CcStQEfOgpoDkAahvALahtKWLv7laG1x3v0s6ni11B6RVXdNxYgQ
    o3I9VtOHlbQVXcC/KMR6XU6g0d/uBM1eKG9z1DjI/RM1YmPqkG9tytsYmkQVEtI9
    9y3lY7/9Z+zvUysRnKmbz67LWf/cCCw4hV4kH7Iw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com
    header.i=@oracle.com header.b=WBKB3DnW header.a=rsa-sha256
    header.s=corp-2017-10-26 x-bits=2048;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com
      header.i=@oracle.com header.b=WBKB3DnW header.a=rsa-sha256
      header.s=corp-2017-10-26 x-bits=2048;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGJNHesRz1UUU4XA+oej8E816GIgfdr1NTECY8fxiUj1NgHu7+isz4y6Pfo9zpQSyEvRFPjPcLNc+VYvRHQNYmxv6Dz+GGAXoUINNN0iG0XsDI15e3NO
    WxgiPkEp480cLFyYzSIwm8M8RhluntFa5m/saUTLkg1U5rGFLcqo4B5yxPbkp1B2Oh9gpNa0c1hO8cn6rvE6Te2v5WxOyDAE3jpe2AjHgulOaobNT/dwl7oB
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=20KFwNOVAAAA:8 a=Q56s5UtnnQTbt5XO3u0A:9
    a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750771AbeEaW1K (ORCPT <rfc822;linux@kroah.com>);
        Thu, 31 May 2018 18:27:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55082 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbeEaW1J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 May 2018 18:27:09 -0400
Date: Thu, 31 May 2018 15:26:45 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Mike Snitzer <snitzer@redhat.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Toshi Kani <toshi.kani@hpe.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org,
        Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [dm-devel] [PATCH v2 2/7] dax: change bdev_dax_supported() to
 support boolean returns
Message-ID: <20180531222645.GA6086@magnolia>
References: <20180529195106.14268-1-ross.zwisler@linux.intel.com>
 <20180529195106.14268-3-ross.zwisler@linux.intel.com>
 <20180529212510.GJ30110@magnolia>
 <20180529220114.GA13948@linux.intel.com>
 <20180531191332.GB7825@magnolia>
 <20180531205206.GA12681@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531205206.GA12681@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8910 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1805310248
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 31, 2018 at 04:52:06PM -0400, Mike Snitzer wrote:
> On Thu, May 31 2018 at  3:13pm -0400,
> Darrick J. Wong <darrick.wong@oracle.com> wrote:
> 
> > On Tue, May 29, 2018 at 04:01:14PM -0600, Ross Zwisler wrote:
> > > On Tue, May 29, 2018 at 02:25:10PM -0700, Darrick J. Wong wrote:
> > > > On Tue, May 29, 2018 at 01:51:01PM -0600, Ross Zwisler wrote:
> > > > > From: Dave Jiang <dave.jiang@intel.com>
> > > > > 
> > > > > The function return values are confusing with the way the function is
> > > > > named. We expect a true or false return value but it actually returns
> > > > > 0/-errno.  This makes the code very confusing. Changing the return values
> > > > > to return a bool where if DAX is supported then return true and no DAX
> > > > > support returns false.
> > > > > 
> > > > > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > > > > Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> > > > 
> > > > Looks ok, do you want me to pull the first two patches through the xfs
> > > > tree?
> > > > 
> > > > Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> > > 
> > > Thanks for the review.
> > > 
> > > I'm not sure what's best.  If you do that then Mike will need to have a DM
> > > branch for the rest of the series based on your stable commits, yea?
> > > 
> > > Mike what would you prefer?
> > 
> > I /was/ about to say that I would pull in the first two patches, but now
> > I can't get xfs to mount with pmem at all, and have no way of testing
> > this...?
> 
> Once you get this sorted out, please feel free to pull in the first 2.

Sorted.  It'll be in Friday's for-next.  Ross helped me bang on the pmem
devices w/ ndctl to enable fsdax mode and twist qemu until everything
worked properly. ;)

--D

> I'm unlikely to get to reviewing the DM patches in this series until
> tomorrow at the earliest.
> 
> Mike
> 
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://www.redhat.com/mailman/listinfo/dm-devel
