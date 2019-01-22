Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B986FC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A5020854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ixnChyjj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfAVHu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 02:50:57 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40636 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbfAVHu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 02:50:57 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0M7d7bE182911;
        Tue, 22 Jan 2019 07:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=DUICae31W7z5x97xX54CFol4IPkQrRIiS38gD816A8w=;
 b=ixnChyjjWKA1hhYO4ebIJ9fO6f7E47VGWCwOs4p1JdOCL5RbAGh6Om9mElHDdjzAkHV3
 gB8owMiQULQMZMfFAU8XvUKCnmC6f+ZSkt8iqsWtopTZx0RU++r4bZwws6sgD1CDA2TZ
 J32DPhLIOk1oYT60WzYNC88LeUdT9f0ecOwHaftCLe+ikfRX0y925GOEJP2BzzqfQ6u1
 tJsF5015QuEyf4VkiRdA+Eh+srOMb+s/m171JnerkxK4Io9c6kG12d+k5pYAD7lQePE3
 cJepHlyT8sovNLw8aQqW/zth6w8coHiPR1+UF4NyYGwHxg1M3eF7lo84C/mFJ2XzZVUJ Gw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2q3vhrhtqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jan 2019 07:48:42 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0M7mgk4032150
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jan 2019 07:48:42 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0M7me1K004012;
        Tue, 22 Jan 2019 07:48:41 GMT
Received: from kadam (/197.157.34.164)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Jan 2019 23:48:40 -0800
Date:   Tue, 22 Jan 2019 10:48:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ching Huang <ching2048@areca.com.tw>
Cc:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, colin.king@canonical.com
Subject: Re: [PATCH 2/3] scsi: arcmsr: Fix suspend/resume of
 ACB_ADAPTER_TYPE_B part 2
Message-ID: <20190122074816.GC11828@kadam>
References: <1547696703.4339.21.camel@Centos6.3-64>
 <20190117070227.GM4504@kadam>
 <1547714827.5079.19.camel@Centos6.3-64>
 <20190117091646.GA11828@kadam>
 <1547718748.5079.34.camel@Centos6.3-64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547718748.5079.34.camel@Centos6.3-64>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9143 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=799
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901220064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 05:52:28PM +0800, Ching Huang wrote:
> On Thu, 2019-01-17 at 12:16 +0300, Dan Carpenter wrote:
> > On Thu, Jan 17, 2019 at 04:47:07PM +0800, Ching Huang wrote:
> > > On Thu, 2019-01-17 at 10:59 +0300, Dan Carpenter wrote:
> > > > On Thu, Jan 17, 2019 at 11:45:03AM +0800, Ching Huang wrote:
> > > > > >From Ching Huang <ching2048@areca.com.tw>
> > > > > 
> > > > > Fix suspend/resume of ACB_ADAPTER_TYPE_B part 2.
> > > > > 
> > > > 
> > > > What does this look like from a user perspective?  Does it fail every
> > > > time or does it only fail sometimes?
> > > > 
> > > > What's the bug exactly?
> > > > 
> > > > There is no Fixes tag...
> > > >From user's perspective, hibernate/resume are OK.
> > > But following IO may cause 'isr get an illegal ccb command' in
> > > log/messages sometime.
> > > > 
> > 
> > 
> > You will need to resend with that information included in the commit
> > message.
> OK. I will resend this patch later.
> > 
> > > > > Signed-off-by: Ching Huang <ching2048@areca.com.tw>
> > > > > ---
> > > > > 
> > > > > diff --git a/drivers/scsi/arcmsr/arcmsr.h b/drivers/scsi/arcmsr/arcmsr.h
> > > > > index a94c513..b98c632 100755
> > > > > --- a/drivers/scsi/arcmsr/arcmsr.h
> > > > > +++ b/drivers/scsi/arcmsr/arcmsr.h
> > > > > @@ -508,9 +508,9 @@ struct MessageUnit_A
> > > > >  struct MessageUnit_B
> > > > >  {
> > > > >  	uint32_t	post_qbuffer[ARCMSR_MAX_HBB_POSTQUEUE];
> > > > > -	uint32_t	done_qbuffer[ARCMSR_MAX_HBB_POSTQUEUE];
> > > > > +	volatile uint32_t	done_qbuffer[ARCMSR_MAX_HBB_POSTQUEUE];
> > > > 
> > > > There is a well known rule of thumb that when someone uses "volatile"
> > > > in the kernel it means there is a locking problem...  Is this __iomem or
> > > > something?
> > > The done_qbuffer was a command completion queue, it was an area written
> > > by IO processor and read by device driver. So, ...
> > 
> > I'm not totally positive I understand this sentence.  I can find a bunch
> > of places which read from this buffer, but I haven't immediately found
> > which place writes to it.  Can you give me a function name that I should
> > read?
> Well, we allocate memory for struct MessageUnit_B in
> arcmsr_alloc_ccb_pool(), by assign to acb->dma_coherent_handle2.
> Then we tell IO controller its DMA address in arcmsr_iop_confirm().
> When a command was completed, controller's firmware program will write a
> completion ccb in done_qbuffer through DMA. So, you can't see any driver
> funtion write to it.

DMA memory doesn't need to be marked as volatile.

regards,
dan carpenter

