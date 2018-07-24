Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D77C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC6A20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC6A20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388274AbeGXHXp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 03:23:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43082 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388161AbeGXHXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 03:23:44 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6O6E6QP145453
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 02:18:54 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kdwqytdk2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 02:18:53 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Tue, 24 Jul 2018 07:18:51 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 24 Jul 2018 07:18:49 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6O6ImCM38404288
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Jul 2018 06:18:48 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04279A4051;
        Tue, 24 Jul 2018 09:19:03 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5335A4040;
        Tue, 24 Jul 2018 09:19:02 +0100 (BST)
Received: from mschwideX1 (unknown [9.145.77.38])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 24 Jul 2018 09:19:02 +0100 (BST)
Date:   Tue, 24 Jul 2018 08:18:45 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 4.18-rc6
In-Reply-To: <CA+55aFw3tRe70mUgV70oi6xBwSLx0h_supRGoNUHgrcSGxUgeg@mail.gmail.com>
References: <CA+55aFzMheDA-2z=MdGgJrz-REcrknb+4OEvRKaJipm+x6xEhw@mail.gmail.com>
        <20180723204617.GA14487@roeck-us.net>
        <CA+55aFyuaEGGksOxv3aAp0THYkAapap-JY65A0A81S0qUE0S+g@mail.gmail.com>
        <20180723212330.GA7441@roeck-us.net>
        <CA+55aFw3tRe70mUgV70oi6xBwSLx0h_supRGoNUHgrcSGxUgeg@mail.gmail.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
X-TM-AS-GCONF: 00
x-cbid: 18072406-0008-0000-0000-00000256D749
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072406-0009-0000-0000-000021BD48BA
Message-Id: <20180724081845.1cc4c9d8@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-24_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=896 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807240066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jul 2018 16:17:22 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Jul 23, 2018 at 2:23 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >  
> > >
> > > Martin - can we just remove the
> > >
> > >          select HAVE_GCC_PLUGINS
> > >
> > > from the s390 Kconfig file (or perhaps add "if BROKEN" or something to
> > > disable it).
> > >
> > > Because if it's not getting fixed, it shouldn't be exposed.
> > >  
> > The problem only affects 4.18 - the code has been rearranged in -next.
> > Only, in my builders, I can't disable a flag for individual releases,
> > so I just disabled it completely for s390.  
> 
> Well, I'm not going to release a 4.18 with a known problem, so in 4.18
> this *will* be disabled if it's not fixed.
> 
> The fact that it might be fixed in linux-next is entirely immaterial
> to the release of 4.18.

Ok, if gcc with the plugins and an allmodconfig is considered to be
important enough to warrant a fix, it can be pulled from here:

git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

Martin Schwidefsky (1):
      s390: disable gcc plugins

Once that is in I will create another patch to undo this one and place
it after the early boot rework.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

