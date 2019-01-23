Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F2DC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1F421726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfAWJfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 04:35:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36086 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726207AbfAWJfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 04:35:17 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0N9VQKk137432
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 04:35:15 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q6mfj31t0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 04:35:15 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Wed, 23 Jan 2019 09:35:14 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 23 Jan 2019 09:35:11 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0N9ZA1O56557616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Jan 2019 09:35:10 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52327AE057;
        Wed, 23 Jan 2019 09:35:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16EA7AE051;
        Wed, 23 Jan 2019 09:35:10 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 23 Jan 2019 09:35:10 +0000 (GMT)
Date:   Wed, 23 Jan 2019 10:35:08 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390: kernel: no need to check return value of
 debugfs_create functions
References: <20190122152151.16139-3-gregkh@linuxfoundation.org>
 <20190122162454.GA31034@osiris>
 <20190122163337.GB23510@kroah.com>
MIME-Version: 1.0
In-Reply-To: <20190122163337.GB23510@kroah.com>
X-TM-AS-GCONF: 00
x-cbid: 19012309-4275-0000-0000-00000302F71D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012309-4276-0000-0000-000038112AD8
Message-Id: <20190123093508.GB3424@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901230072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 05:33:37PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 22, 2019 at 05:24:54PM +0100, Heiko Carstens wrote:
> > On Tue, Jan 22, 2019 at 04:21:02PM +0100, Greg Kroah-Hartman wrote:
> > > When calling debugfs functions, there is no need to ever check the
> > > return value.  The function can work or not, but the code logic should
> > > never do something different based on this.
> > > 
> > > Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > > Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> > > Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> > > Cc: linux-s390@vger.kernel.org
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  arch/s390/kernel/debug.c    | 6 ------
> > >  arch/s390/kernel/kdebugfs.c | 2 --
> > >  arch/s390/kernel/sysinfo.c  | 2 --
> > >  3 files changed, 10 deletions(-)
> > > diff --git a/arch/s390/kernel/sysinfo.c b/arch/s390/kernel/sysinfo.c
> > > index 12f80d1f0415..2ac3c9b56a13 100644
> > > --- a/arch/s390/kernel/sysinfo.c
> > > +++ b/arch/s390/kernel/sysinfo.c
> > > @@ -545,8 +545,6 @@ static __init int stsi_init_debugfs(void)
> > >  	int lvl, i;
> > > 
> > >  	stsi_root = debugfs_create_dir("stsi", arch_debugfs_dir);
> > > -	if (IS_ERR_OR_NULL(stsi_root))
> > > -		return 0;
> > 
> > No objections, however will you also change the odd behaviour that
> > e.g. debugfs_create_file() returns -ENODEV instead of (the expected)
> > NULL pointer if CONFIG_DEBUGFS is disabled?
> 
> Nope.  That is intentional.
> 
> > I do remember this since it caused at least one crash ;)
> 
> Which is why you shouldn't care about the return value of these
> functions :)
> 
> > 19cdd08ba155 ("[S390] qdio: fix broken pointer in case of CONFIG_DEBUG_FS is disabled").
> 
> Odd, what crashes when passed an error pointer?  What was someone trying
> to do with those pointers?  The only thing you can do with a return
> value from a debugfs function is to pass it back into another debugfs
> call.  Sounds like someone wasn't doing that :(

I think it used to be this code that crashed:

static void remove_debugfs_entry(struct qdio_q *q)
{
	int i;

	for (i = 0; i < MAX_DEBUGFS_QUEUES; i++) {
		if (!debugfs_queues[i])
			continue;
----->		if (debugfs_queues[i]->d_inode->i_private == q) {
			debugfs_remove(debugfs_queues[i]);
			debugfs_queues[i] = NULL;
		}
	}
}

Which looks like a layering violation anyway. However this code is
gone, so everything should be fine.

