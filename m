Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C63FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 05:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFA020870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 05:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFA020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbeG3GsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 02:48:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43310 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726094AbeG3GsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 02:48:24 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6U5DvJi079422
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 01:15:12 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2khqukfkrf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 01:15:12 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Mon, 30 Jul 2018 06:15:09 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 30 Jul 2018 06:15:03 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6U5F2Y135258544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Jul 2018 05:15:02 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34488AE045;
        Mon, 30 Jul 2018 08:15:05 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59860AE04D;
        Mon, 30 Jul 2018 08:15:04 +0100 (BST)
Received: from mschwideX1 (unknown [9.145.66.78])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 30 Jul 2018 08:15:04 +0100 (BST)
Date:   Mon, 30 Jul 2018 07:14:58 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Huaisheng HS1 Ye <yehs1@lenovo.com>
Cc:     "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
        "bart.vanassche@wdc.com" <bart.vanassche@wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jack@suse.cz" <jack@suse.cz>, "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "NingTing Cheng" <chengnt@lenovo.com>,
        "colyli@suse.de" <colyli@suse.de>,
        Huaisheng Ye <yehs2007@zoho.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: Re: [External]  [PATCH v2 2/6] s390, dcssblk: kaddr and pfn can be
 NULL to ->direct_access()
In-Reply-To: <TY2PR03MB334328133134A67C87E5CC5C92290@TY2PR03MB3343.apcprd03.prod.outlook.com>
References: <20180725162849.8320-1-yehs2007@zoho.com>
        <20180725162849.8320-3-yehs2007@zoho.com>
        <TY2PR03MB334328133134A67C87E5CC5C92290@TY2PR03MB3343.apcprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18073005-0028-0000-0000-000002E23595
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18073005-0029-0000-0000-0000239A34C8
Message-Id: <20180730071458.42e3c5a1@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-30_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807300059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Jul 2018 04:07:25 +0000
Huaisheng HS1 Ye <yehs1@lenovo.com> wrote:

> May I have your ack's for this patch? The whole series would be applied
> to libnvdimm if it could get your approval.
> And any suggestion is welcome.

Sure, it is just two additional ifs. I did not think that this needed an
ack, but here you go:

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

> 
> Cheers,
> Huaisheng Ye
> 
> > From: Huaisheng Ye <yehs2007@zoho.com>
> > Sent: Thursday, July 26, 2018 12:29 AM
> > 
> > From: Huaisheng Ye <yehs1@lenovo.com>
> > 
> > dcssblk_direct_access() needs to check the validity of pointers kaddr
> > and pfn for NULL assignment. If anyone equals to NULL, it doesn't need
> > to calculate the value.
> > 
> > If either of them is equal to NULL, that is to say callers may
> > have no need for kaddr or pfn, so this patch is prepared for allowing
> > them to pass in NULL instead of having to pass in a pointer or local
> > variable that they then just throw away.
> > 
> > Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
> > ---
> >  drivers/s390/block/dcssblk.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
> > index ed60728..23e526c 100644
> > --- a/drivers/s390/block/dcssblk.c
> > +++ b/drivers/s390/block/dcssblk.c
> > @@ -922,9 +922,11 @@ static DEVICE_ATTR(save, S_IWUSR | S_IRUSR, dcssblk_save_show,
> >  	unsigned long dev_sz;
> > 
> >  	dev_sz = dev_info->end - dev_info->start + 1;
> > -	*kaddr = (void *) dev_info->start + offset;
> > -	*pfn = __pfn_to_pfn_t(PFN_DOWN(dev_info->start + offset),
> > -			PFN_DEV|PFN_SPECIAL);
> > +	if (kaddr)
> > +		*kaddr = (void *) dev_info->start + offset;
> > +	if (pfn)
> > +		*pfn = __pfn_to_pfn_t(PFN_DOWN(dev_info->start + offset),
> > +				PFN_DEV|PFN_SPECIAL);
> > 
> >  	return (dev_sz - offset) / PAGE_SIZE;
> >  }
> > --
> > 1.8.3.1  
> 


-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

