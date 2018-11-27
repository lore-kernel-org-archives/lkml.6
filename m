Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6BAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7366020873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7366020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbeK0Sgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:36:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36512 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729042AbeK0Sgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 13:36:50 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAR7dF9u076665
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 02:39:50 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p10bfuf7r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 02:39:50 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Tue, 27 Nov 2018 07:39:48 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 27 Nov 2018 07:39:45 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAR7diAk3801596
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Nov 2018 07:39:44 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AF3AA4053;
        Tue, 27 Nov 2018 07:39:44 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C65B8A4055;
        Tue, 27 Nov 2018 07:39:43 +0000 (GMT)
Received: from mschwideX1 (unknown [9.145.179.93])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Nov 2018 07:39:43 +0000 (GMT)
Date:   Tue, 27 Nov 2018 08:39:41 +0100
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: Remove obsolete bust_spinlock() implementation
In-Reply-To: <20181123070212.GA3300@osiris>
References: <20181122141529.14933-1-pmladek@suse.com>
        <20181123021748.GB1582@jagdpanzerIV>
        <20181123070212.GA3300@osiris>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18112707-0008-0000-0000-000002990E55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112707-0009-0000-0000-000022035137
Message-Id: <20181127083941.3bebcf13@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-27_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811270070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2018 08:02:12 +0100
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> On Fri, Nov 23, 2018 at 11:17:48AM +0900, Sergey Senozhatsky wrote:
> > On (11/22/18 15:15), Petr Mladek wrote:  
> > > The commit cefc8be82403cf ("Consolidate bust_spinlocks()") kept
> > > the s390-specific implementation because of the absence of CONFIG_VT.
> > > In fact, the only difference was calling console_unblank() instead of
> > > unblank_screen().
> > > 
> > > The common implementation in lib/bust_spinlocks.c started to call
> > > unblank_screen() explicitly since the commit b61312d353da187
> > > ("oops handling: ensure that any oops is flushed to the mtdoops
> > > console").
> > > 
> > > As a result, the custom implementation is not longer necessary.
> > > And we could get all the other improvements of the common
> > > implementation for free.  
> > 
> > I believe I sent a similar patch several weeks ago and it's
> > in s390 patch queue as of now, waiting for the next merge
> > window.
> > 
> > lkml.kernel.org/r/20181025081108.GB26561@osiris  
> 
> Yes, it will be added soon to the features branch of the
> s390/linux.git repository on kernel.org and then hit linux-next.

The patch is now queued for the next merge window.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

