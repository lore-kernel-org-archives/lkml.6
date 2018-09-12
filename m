Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EA8ECDFC1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35EE20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E35EE20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbeILPhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:37:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35138 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727002AbeILPhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:37:11 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8CAOXGO118375
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 06:33:15 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mey8m59ax-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 06:33:15 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 12 Sep 2018 11:33:13 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Sep 2018 11:33:09 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8CAX8YK51380464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Sep 2018 10:33:08 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B98104C05E;
        Wed, 12 Sep 2018 13:32:59 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 162C04C046;
        Wed, 12 Sep 2018 13:32:59 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.207])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 12 Sep 2018 13:32:58 +0100 (BST)
Date:   Wed, 12 Sep 2018 13:33:06 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Michal Hocko <mhocko@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] docs: core-api: add memory allocation guide
References: <1534517236-16762-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1534517236-16762-4-git-send-email-rppt@linux.vnet.ibm.com>
 <20180911115555.5fce5631@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911115555.5fce5631@lwn.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18091210-0008-0000-0000-000002702C14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091210-0009-0000-0000-000021D86827
Message-Id: <20180912103305.GC6719@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-12_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=798 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809120110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 11:55:55AM -0600, Jonathan Corbet wrote:
> Sorry for being so slow to get to this...it fell into a dark crack in my
> rickety email folder hierarchy.  I do have one question...
> 
> On Fri, 17 Aug 2018 17:47:16 +0300
> Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> 
> > +    ``GFP_HIGHUSER_MOVABLE`` does not require that allocated memory
> > +    will be directly accessible by the kernel or the hardware and
> > +    implies that the data is movable.
> > +
> > +    ``GFP_HIGHUSER`` means that the allocated memory is not movable,
> > +    but it is not required to be directly accessible by the kernel or
> > +    the hardware. An example may be a hardware allocation that maps
> > +    data directly into userspace but has no addressing limitations.
> > +
> > +    ``GFP_USER`` means that the allocated memory is not movable and it
> > +    must be directly accessible by the kernel or the hardware. It is
> > +    typically used by hardware for buffers that are mapped to
> > +    userspace (e.g. graphics) that hardware still must DMA to.
> 
> I realize that this is copied from elsewhere, but still...as I understand
> it, the "HIGH" part means that the allocation can be satisfied from high
> memory, nothing more.  So...it's irrelevant on 64-bit machines to start
> with, right?  And it has nothing to do with DMA, I would think.  That would
> be handled by the DMA infrastructure and, perhaps, the DMA* zones.  Right?
> 
> I ask because high memory is an artifact of how things are laid out on
> 32-bit systems; hardware can often DMA quite easily into memory that the
> kernel sees as "high".  So, to me, this description seems kind of
> confusing; I wouldn't mention hardware at all.  But maybe I'm missing
> something?

Well, I've amended the original text from gfp.h in attempt to make it more
"user friendly". The GFP_HIGHUSER became really confusing :)
I think that we can drop mentions of hardware from GFP_HIGHUSER_MOVABLE and
GFP_USER, but it makes sense to leave the example in the GFP_HIGHUSER
description.

How about:

    ``GFP_HIGHUSER_MOVABLE`` does not require that allocated memory
    will be directly accessible by the kernel and implies that the
    data is movable.

    ``GFP_HIGHUSER`` means that the allocated memory is not movable,
    but it is not required to be directly accessible by the kernel. An
    example may be a hardware allocation that maps data directly into
    userspace but has no addressing limitations.

    ``GFP_USER`` means that the allocated memory is not movable and it
    must be directly accessible by the kernel

 
> Thanks,
> 
> jon
> 

-- 
Sincerely yours,
Mike.

