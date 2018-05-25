Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-94349-1527276231-2-4643365267288841208
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527276230; b=j2luKhFO6EfM5PNELAKo7uXmWeOYIwrXmczWZuL4t06rNLd/Tk
    L5OHyoQdYoPgslWuS15N8h0KQuSb8iyLdRXGy948SzC3wvRkK1UJGhSP63oirHhs
    ZRyybAWDOiw12fPj2AQJJvzDWWDT3aneed5K6ck+gJyXjinRT8GwRuVJAl7HR4t6
    yUoFy2xiD0xHwN5NCpUSwDDVR40v6TmEuiDvHp4NjWr5rnuHKrKMtX92Aet6V5Jn
    4D7qeKLGkY0TYg9Ea/WHFMZhUigYioUkKpOAZH5LLjo7e9nEklEAlBzLy6PJqo13
    hdrFg2S2dZHPVrh7qDaoWm9QtrbClQerF1oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527276230; bh=D5YwpzNe/8bLYFRa7bREBzvbgtGTo6
    cMKEgkEET/54k=; b=evON8Cbr4TxSNJT4gKfxLjGBu5vTy8AZl8ZtnaHh9pTmjI
    RqlxK3ClCghrxOtY4xr3gR+z+P7oeWUKoGLM+1GLZUGNCUB/auM0e8fJMGuUkkJm
    hRjq7RKVyv5pL8zjdQsBZOMU7S/Nv5OYYq022JSVxWe887du1Of6b7TSGr61wumF
    TsRtW04XELtXDOh4sfW5cNw7iRLUwbAUwuE12XgUwQrh3gDlmKo1qFb21CU4iVlD
    rg91svG34tHNkaX+Zb2GNUK6MLROu8kalZyv/r85dYrsMFjHyrDkH5XqUeltHq5u
    iBxGoZQs0sjlaSJUpWC7PPYmIgMao6fHElFdKeIg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com
    header.i=@oracle.com header.b=DKjSdiXm x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com
      header.i=@oracle.com header.b=DKjSdiXm x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF76ALnaIvg7a2PqZpxg0oBw1sYxQYs7EKx+yUx8Qk4jSWigk7GWATwTisTrWMp2DEFX5kazu5UaExrwuOLde284rtco8mTXkJ4wh/tT4+nZLuLNr9gP
    Veh9SA0OJG92l6ScSgp+at2f03B1oIVn1TSkTYZS6R4fpBLtiIEl88xqZELpgSsVhO1V5KoqJi7Zaslbbd+QQ2eH2FMo9ThDjCPlAi9qL/QaX7K6jEML1s5v
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=qjbXGoRJo5KrqO1P648A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967879AbeEYTXt (ORCPT <rfc822;linux@kroah.com>);
        Fri, 25 May 2018 15:23:49 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34594 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967587AbeEYTXs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 May 2018 15:23:48 -0400
Date: Fri, 25 May 2018 12:23:27 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH 1/7] fs: allow per-device dax status checking for
 filesystems
Message-ID: <20180525192327.GR12940@magnolia>
References: <20180525025518.11405-1-ross.zwisler@linux.intel.com>
 <20180525025518.11405-2-ross.zwisler@linux.intel.com>
 <20180525050218.GF4507@magnolia>
 <20180525154229.GA11044@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525154229.GA11044@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8904 signatures=668700
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805250201
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 25, 2018 at 09:42:29AM -0600, Ross Zwisler wrote:
> On Thu, May 24, 2018 at 10:02:18PM -0700, Darrick J. Wong wrote:
> > On Thu, May 24, 2018 at 08:55:12PM -0600, Ross Zwisler wrote:
> > > From: "Darrick J. Wong" <darrick.wong@oracle.com>
> > > 
> > > Remove __bdev_dax_supported and change to bdev_dax_supported that takes a
> > > bdev parameter.  This enables multi-device filesystems like xfs to check
> > > that a dax device can work for the particular filesystem.  Once that's
> > > in place, actually fix all the parts of XFS where we need to be able to
> > > distinguish between datadev and rtdev.
> > > 
> > > This patch fixes the problem where we screw up the dax support checking
> > > in xfs if the datadev and rtdev have different dax capabilities.
> > > 
> > > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > > Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> > 
> > Reviewed-by: Darr...oh, I'm not allowed to do that, am I?
> > 
> > Would you mind (re)sending this to the xfs list so that someone else can
> > review it?
> > 
> > --D
> 
> Thanks for the review, Darrick.
> 
> I think at one point Dave said that if you touch more than 1 filesystem with a
> series you should just CC linux-fsdevel and omit the individual filesystems?
> I realize that this series only touches ext2 and ext4 a little, but that's
> what I opted for.
> 
> Is that sufficient to get to the rest of the XFS developers, or would you like
> a resend adding linux-xfs?

For a patch by any other author I'd be fine with -fsdevel, but for this
specific one (because it's written by me and I'm not yet so bofh that I
review my own patches ;)) someone else from the xfs community has to
review it, so yes I'd like it to be sent to linux-xfs, please.

(And it's ok to note in the resend that this is the same as the -fsdevel
series, but posted here to attract the attention of the other xfs
developers.)

--D
