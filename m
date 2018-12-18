Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62F2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3AE20874
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbeLRH5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:57:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34902 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726505AbeLRH5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 02:57:02 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBI7sFO0095818
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 02:57:01 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pev5nj38w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 02:57:01 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Tue, 18 Dec 2018 07:56:58 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Dec 2018 07:56:55 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBI7usWQ53018820
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Dec 2018 07:56:55 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5FE552050;
        Tue, 18 Dec 2018 07:56:54 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id A48235204E;
        Tue, 18 Dec 2018 07:56:54 +0000 (GMT)
Date:   Tue, 18 Dec 2018 08:56:53 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [-next] strace tests fail because of "y2038: socket: Add
 compat_sys_recvmmsg_time64"
References: <20181217130646.GB3560@osiris>
 <CAK8P3a0kLHcfAtVVuVBqwcQJE+qk6LAO9TBJO2Sb2_m6z5cn8g@mail.gmail.com>
 <CAK8P3a3buLM8aKdN8PATzx_mQqFrrLcJmPjbeiJ8uCzx2GwS2Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3buLM8aKdN8PATzx_mQqFrrLcJmPjbeiJ8uCzx2GwS2Q@mail.gmail.com>
X-TM-AS-GCONF: 00
x-cbid: 18121807-4275-0000-0000-000002F2281F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121807-4276-0000-0000-0000380028DD
Message-Id: <20181218075653.GB3590@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-18_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=821 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812180071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 11:05:06PM +0100, Arnd Bergmann wrote:
> On Mon, Dec 17, 2018 at 10:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Mon, Dec 17, 2018 at 2:06 PM Heiko Carstens
> > <heiko.carstens@de.ibm.com> wrote:
> > >
> > > Hi Arnd,
> > >
> > > in linux-next as of today 16 strace self tests fail on s390. I could
> > > bisect this to b136972b063b ("y2038: socket: Add compat_sys_recvmmsg_time64").
> > >
> > > The following tests fail:
> >
> > Hi Heiko,
> >
> > Thanks for the report and sorry I broke things. I'll have a closer look
> > tomorrow if I don't find it right away. I suppose the regression was in
> > native system calls, not the compat syscalls with 31-bit user space,
> > right?

Yes, I was talking about 64 bit native system calls.

> I found a bug in my patch by inspection. Can you try if the patch
> below makes it all work (apologies for the garbled whitespace),
> I'm considering a rewrite of that function now (to split it into two
> again), but want to make sure there isn't another problem in my
> original patch.

With your patch below applied, the tests pass again.

Thanks!

> ----
> diff --git a/net/socket.c b/net/socket.c
> index 3bb2ee083f97..7f9f225d0b6c 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -2486,12 +2486,12 @@ int __sys_recvmmsg(int fd, struct mmsghdr __user *mmsg,
>          return -EFAULT;
> 
>      if (!timeout && !timeout32)
> -        do_recvmmsg(fd, mmsg, vlen, flags, NULL);
> +        return do_recvmmsg(fd, mmsg, vlen, flags, NULL);
> 
>      datagrams = do_recvmmsg(fd, mmsg, vlen, flags, &timeout_sys);
> 
> -    if (!datagrams)
> -        return 0;
> +    if (datagrams <= 0)
> +        return datagrams;
> 
>      if (timeout && put_timespec64(&timeout_sys, timeout))
>          datagrams = -EFAULT;
> 

