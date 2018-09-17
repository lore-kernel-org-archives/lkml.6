Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21899ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 04:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C442086B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 04:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C442086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbeIQKDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 06:03:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46848 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727124AbeIQKDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 06:03:09 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8H4Z3NP049850
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 00:37:32 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mj37a3kjy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 00:37:32 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Mon, 17 Sep 2018 05:37:30 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Sep 2018 05:37:27 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8H4bQ9J66453724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Sep 2018 04:37:26 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9997F4C04E;
        Mon, 17 Sep 2018 07:37:15 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24A4E4C04A;
        Mon, 17 Sep 2018 07:37:15 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.140])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 17 Sep 2018 07:37:15 +0100 (BST)
Date:   Mon, 17 Sep 2018 07:37:24 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Pintu Kumar <pintu.ping@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Subject: Re: KSM not working in 4.9 Kernel
References: <CAOuPNLj1wx4sznrtLdKjcvuTf0dECPWzPaR946FoYRXB6YAGCw@mail.gmail.com>
 <20180916153237.GC15699@rapoport-lnx>
 <CAOuPNLj0HyC+yzwTpN-EWpzHTJ58u7pBfOja1MyweF4pbct1eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOuPNLj0HyC+yzwTpN-EWpzHTJ58u7pBfOja1MyweF4pbct1eQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18091704-0012-0000-0000-000002A99A08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091704-0013-0000-0000-000020DDEC31
Message-Id: <20180917043724.GA12866@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-17_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809170048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2018 at 10:35:17PM +0530, Pintu Kumar wrote:
> On Sun, Sep 16, 2018 at 9:02 PM Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> >
> > On Fri, Sep 14, 2018 at 07:58:01PM +0530, Pintu Kumar wrote:
> > > Hi All,
> > >
> > > Board: Hikey620 ARM64
> > > Kernel: 4.9.20
> > >
> > > I am trying to verify KSM (Kernel Same Page Merging) functionality on
> > > 4.9 Kernel using "mmap" and madvise user space test utility.
> > > But to my observation, it seems KSM is not working for me.
> > > CONFIG_KSM=y is enabled in kernel.
> > > ksm_init is also called during boot up.
> > >   443 ?        SN     0:00 [ksmd]
> > >
> > > ksmd thread is also running.
> > >
> > > However, when I see the sysfs, no values are written.
> > > ~ # grep -H '' /sys/kernel/mm/ksm/*
> > > /sys/kernel/mm/ksm/pages_hashed:0
> > > /sys/kernel/mm/ksm/pages_scanned:0
> > > /sys/kernel/mm/ksm/pages_shared:0
> > > /sys/kernel/mm/ksm/pages_sharing:0
> > > /sys/kernel/mm/ksm/pages_to_scan:200
> > > /sys/kernel/mm/ksm/pages_unshared:0
> > > /sys/kernel/mm/ksm/pages_volatile:0
> > > /sys/kernel/mm/ksm/run:1
> > > /sys/kernel/mm/ksm/sleep_millisecs:1000
> > >
> > > So, please let me know if I am doing any thing wrong.
> > >
> > > This is the test utility:
> > > int main(int argc, char *argv[])
> > > {
> > >         int i, n, size;
> > >         char *buffer;
> > >         void *addr;
> > >
> > >         n = 100;
> > >         size = 100 * getpagesize();
> > >         for (i = 0; i < n; i++) {
> > >                 buffer = (char *)malloc(size);
> > >                 memset(buffer, 0xff, size);
> > >                 addr =  mmap(NULL, size,
> > >                            PROT_READ | PROT_EXEC | PROT_WRITE,
> > > MAP_PRIVATE | MAP_ANONYMOUS,
> > >                            -1, 0);
> > >                 madvise(addr, size, MADV_MERGEABLE);
> >
> > Just mmap'ing an area does not allocate any physical pages, so KSM has
> > nothing to merge.
> >
> > You need to memset(addr,...) after mmap().
> >
> 
> Yes, I am doing memset also.
> memset(addr, 0xff, size);
> 
> But still no effect.
> And I checked LTP test cases. It almost doing the same thing.
> 
> I observed that [ksmd] thread is not waking up at all.
> I gave some print inside it, but I could never saw that prints coming.
> I could not find it running either in top command during the operation.
> Is there anything needs to be done, to wakw up ksmd?
> I already set: echo 1 > /sys/kernel/mm/ksm.

It should be echo 1 > /sys/kernel/mm/ksm/run
 
> 
> 
> > >                 sleep(1);
> > >         }
> > >         printf("Done....press ^C\n");
> > >
> > >         pause();
> > >
> > >         return 0;
> > > }
> > >
> > >
> > >
> > > Thanks,
> > > Pintu
> > >
> >
> > --
> > Sincerely yours,
> > Mike.
> >
> 

-- 
Sincerely yours,
Mike.

