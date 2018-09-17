Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6856AECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A96F20883
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A96F20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbeIQU12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:27:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52808 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726885AbeIQU12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:27:28 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8HExLgt125168
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 10:59:45 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mjbu5frwg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 10:59:44 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Mon, 17 Sep 2018 15:59:42 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Sep 2018 15:59:40 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8HExdd3524672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Sep 2018 14:59:39 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF51E4203F;
        Mon, 17 Sep 2018 17:59:27 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A97D42042;
        Mon, 17 Sep 2018 17:59:27 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.207.180])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 17 Sep 2018 17:59:27 +0100 (BST)
Date:   Mon, 17 Sep 2018 17:59:36 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Pintu Kumar <pintu.ping@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Subject: Re: KSM not working in 4.9 Kernel
References: <CAOuPNLj1wx4sznrtLdKjcvuTf0dECPWzPaR946FoYRXB6YAGCw@mail.gmail.com>
 <20180916153237.GC15699@rapoport-lnx>
 <CAOuPNLj0HyC+yzwTpN-EWpzHTJ58u7pBfOja1MyweF4pbct1eQ@mail.gmail.com>
 <20180917043724.GA12866@rapoport-lnx>
 <CAOuPNLidXFHgkBmwOPj_xFkU_OpLaXbpJg04Le7MPxu8cYg_RQ@mail.gmail.com>
 <CAOuPNLj+4pMnEy5EyZmzDWszqMb_PQb3q7t_hvG_50BTz1He2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOuPNLj+4pMnEy5EyZmzDWszqMb_PQb3q7t_hvG_50BTz1He2Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18091714-0008-0000-0000-0000027262C8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091714-0009-0000-0000-000021DAB34F
Message-Id: <20180917145936.GA20945@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-17_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809170151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 05:25:27PM +0530, Pintu Kumar wrote:
> On Mon, Sep 17, 2018 at 11:46 AM Pintu Kumar <pintu.ping@gmail.com> wrote:
> > > > But still no effect.
> > > > And I checked LTP test cases. It almost doing the same thing.
> > > >
> > > > I observed that [ksmd] thread is not waking up at all.
> > > > I gave some print inside it, but I could never saw that prints coming.
> > > > I could not find it running either in top command during the operation.
> > > > Is there anything needs to be done, to wakw up ksmd?
> > > > I already set: echo 1 > /sys/kernel/mm/ksm.
> > >
> > > It should be echo 1 > /sys/kernel/mm/ksm/run
> > >
> >
> > Oh yes, sorry for the typo.
> > I tried the same, but still ksm is not getting invoked.
> > Could someone confirm if KSM was working in 4.9 kernel?
> >
> 
> Ok, it's working now. I have to explicitly stop the ksm thread to see
> the statistics.
> Also there was some internal patch that was setting vm_flags to
> VM_MERGABLE thus causing ksm_advise call to return.
> 
> # echo 1 > /sys/kernel/mm/ksm/run
> # ./malloc-test.out &
> # echo 0 > /sys/kernel/mm/ksm/run
> 
> ~ # grep -H '' /sys/kernel/mm/ksm/*
> /sys/kernel/mm/ksm/full_scans:105
> /sys/kernel/mm/ksm/pages_shared:1
> /sys/kernel/mm/ksm/pages_sharing:999
> /sys/kernel/mm/ksm/pages_to_scan:100
> /sys/kernel/mm/ksm/pages_unshared:0
> /sys/kernel/mm/ksm/pages_volatile:0
> /sys/kernel/mm/ksm/run:0
> /sys/kernel/mm/ksm/sleep_millisecs:20
> 
> 
> However, I have one doubt.
> Is the above data correct, for the below program?

You have 1 shared page and 999 additional references to that page
 
> int main(int argc, char *argv[])
> {
>         int i, n, size, ret;
>         char *buffer;
>         void *addr;
> 
>         n = 10;
>         size = 100 * getpagesize();
>         for (i = 0; i < n; i++) {
>                 buffer = (char *)malloc(size);
>                 memset(buffer, 0xff, size);
>                 madvise(buffer, size, MADV_MERGEABLE);o

This madvise() call should fail because buffer won't be page aligned

>                 addr =  mmap(NULL, size,
>                            PROT_READ | PROT_EXEC | PROT_WRITE,
> MAP_PRIVATE | MAP_ANONYMOUS,
>                            -1, 0);
>                 memset(addr, 0xff, size);
>                 ret = madvise(addr, size, MADV_MERGEABLE);
>                 if (ret < 0) {
>                         fprintf(stderr, "madvise failed: ret: %d,
> reason: %s\n", ret, strerror(errno));
>                 }
>                 usleep(500);
>         }
>         printf("Done....press ^C\n");
> 
>         pause();
> 
>         return 0;
> }
> 
> 
> Thanks,
> Pintu
> 

-- 
Sincerely yours,
Mike.

