Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B818ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 15:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150612083A
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 15:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150612083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbeIWVPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 17:15:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53360 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726168AbeIWVPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 17:15:38 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8NFE9d9063328
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 11:17:49 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mp3dxq156-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 11:17:49 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Sun, 23 Sep 2018 16:17:46 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 23 Sep 2018 16:17:40 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8NFHdij55967832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 23 Sep 2018 15:17:39 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FE6242041;
        Sun, 23 Sep 2018 18:17:24 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9BA742042;
        Sun, 23 Sep 2018 18:17:14 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.207.67])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 23 Sep 2018 18:17:12 +0100 (BST)
Date:   Sun, 23 Sep 2018 18:17:24 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alex Rosenbaum <alexr@mellanox.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Don Dutile <ddutile@redhat.com>,
        Doug Ledford <dledford@redhat.com>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Noa Osherovich <noaos@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Joel Nider <joeln@il.ibm.com>
Subject: Re: Linux RDMA mini-conf at Plumbers 2018
References: <20180920181923.GA6542@mellanox.com>
 <20180920185428.GT3519@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180920185428.GT3519@mtr-leonro.mtl.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18092315-0028-0000-0000-000002FD71AB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092315-0029-0000-0000-000023B77D6F
Message-Id: <20180923151724.GA2469@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-23_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809230162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 09:54:28PM +0300, Leon Romanovsky wrote:
> On Thu, Sep 20, 2018 at 12:19:23PM -0600, Jason Gunthorpe wrote:
> > This is just a friendly reminder that registration deadlines are
> > approaching for this conference. Please see
> >
> > https://www.linuxplumbersconf.org/event/2/page/7-attend
> >
> > For details.
> >
> > This year we expect to have close to a day set aside for RDMA related
> > topics. Including up to half a day for the thorny general kernel issues
> > related to get_user_pages(), particularly as exasperated by RDMA.
> >
> > We have been working on the following concepts for sessions, I've
> > roughly marked names based on past participation in related email
> > threads. As we get closer to the conference date we will be organizing
> > leaders for each section based on these lists, please let us know of
> > any changes, or desire to be a leader!
> >
> > RDMA and get_user_pages
> > =======================
> >   Dan Williams <dan.j.williams@intel.com>
> >   Matthew Wilcox <willy@infradead.org>
> >   John Hubbard <jhubbard@nvidia.com>
> >   Nicholas Piggin <npiggin@gmail.com>
> >   Jan Kara <jack@suse.cz>
> >
> >  RDMA, DAX and persistant memory co-existence.
> >
> >  Explore the limits of what is possible without using On
> >  Demand Paging Memory Registration. Discuss 'shootdown'
> >  of userspace MRs
> >
> >  Dirtying pages obtained with get_user_pages() can oops ext4
> >  discuss open solutions.
> >
> > RDMA and PCI peer to peer
> > =========================
> >   Don Dutile <ddutile@redhat.com>
> >   Alex Williamson <alex.williamson@redhat.com>
> >   Christoph Hellwig <hch@lst.de>
> >   Stephen Bates <sbates@raithlin.com>
> >   Logan Gunthorpe <logang@deltatee.com>
> >   Jérôme Glisse <jglisse@redhat.com>
> >   Christian König <christian.koenig@amd.com>
> >   Bjorn Helgaas <bhelgaas@google.com>
> >
> >  RDMA and PCI peer to peer transactions. IOMMU issues. Integration
> >  with HMM. How to expose PCI BAR memory to userspace and other
> >  drivers as a DMA target.
> >
> > Improving testing of RDMA with syzkaller, RXE and Python
> > ========================================================
> >  Noa Osherovich <noaos@mellanox.com>
> >  Don Dutile <ddutile@redhat.com>
> >  Jason Gunthorpe <jgg@mellanox.com>
> >
> >  Problem solve RDMA's distinct lack of public tests.
> >  Provide a better framework for all drivers to test with,
> >  and a framework for basic testing in userspace.
> >
> >  Worst remaining unfixed syzkaller bugs and how to try to fix them
> >
> >  How to hook syzkaller more deeply into RDMA.
> >
> > IOCTL conversion and new kABI topics
> > ====================================
> >  Jason Gunthorpe <jgg@mellanox.com>
> >  Alex Rosenbaum <alexr@mellanox.com>
> >
> >  Attempt to close on the remaining tasks to complete the project
> >
> >  Restore fork() support to userspace
> >
> > Container and namespaces for RDMA topics
> > ========================================
> >  Parav Pandit <parav@mellanox.com>
> >  Doug Ledford <dledford@redhat.com>
> >
> >  Remaining sticky situations with containers
> >
> >  namespaces in sysfs and legacy all-namespace operation
> >
> >  Remaining CM issues
> >
> >  Security isolation problems
> >
> > Very large Contiguous regions in userspace
> > ==========================================
> >  Christopher Lameter <cl@linux.com>
> >  Parav Pandit <parav@mellanox.com>
> >
> >  Poor performance of get_user_pages on very large virtual ranges
> >
> >  No standardized API to allocate regions to user space
> >
> >  Carry over from last year
> >
> > As we get closer to the conference date the exact schedule will be
> > published on the conference web site. I belive we have the Thursday
> > set aside right now.
> >
> > If there are any last minute topics people would like to see please
> > let us know.
> 
> I want to remind you that Mike wanted to bring the topic of enhancing
> remote page faults during post-copy container migration in CRIU over
> RDMA.
 
It's more Joel's topic, but thanks for the reminder anyway :)

> Thanks
> 
> >
> > See you all in Vancouver!
> >
> > Thanks,
> > Jason & Leon
> >

-- 
Sincerely yours,
Mike.

