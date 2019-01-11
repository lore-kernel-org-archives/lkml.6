Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF029C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FB020872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388187AbfAKQly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 11:41:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40522 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731998AbfAKQlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 11:41:53 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0BGY4Gc041266
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 11:41:51 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pxw27xkyk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 11:41:51 -0500
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jejb@linux.ibm.com>;
        Fri, 11 Jan 2019 16:41:50 -0000
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 11 Jan 2019 16:41:47 -0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0BGfk4419726434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 16:41:46 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 403C57805C;
        Fri, 11 Jan 2019 16:41:46 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A424478063;
        Fri, 11 Jan 2019 16:41:44 +0000 (GMT)
Received: from [153.66.254.194] (unknown [9.85.186.19])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 11 Jan 2019 16:41:44 +0000 (GMT)
Subject: Re: [PATCH] scsi: advansys: use struct_size() in kzalloc()
From:   James Bottomley <jejb@linux.ibm.com>
To:     Hannes Reinecke <hare@suse.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 11 Jan 2019 08:41:43 -0800
In-Reply-To: <05420a5c-c268-b87d-9d75-f5d18a4b7f7a@suse.de>
References: <20190104212209.GA15250@embeddedor>
         <05420a5c-c268-b87d-9d75-f5d18a4b7f7a@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19011116-0004-0000-0000-000014D15FB0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010385; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144996; UDB=6.00596224; IPR=6.00925266;
 MB=3.00025086; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-11 16:41:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011116-0005-0000-0000-00008A2F4732
Message-Id: <1547224903.2793.10.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-11_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901110136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-11 at 16:46 +0100, Hannes Reinecke wrote:
> On 1/4/19 10:22 PM, Gustavo A. R. Silva wrote:
> > One of the more common cases of allocation size calculations is
> > finding the
> > size of a structure that has a zero-sized array at the end, along
> > with memory
> > for some number of elements for that array. For example:
> > 
> > struct foo {
> >      int stuff;
> >      void *entry[];
> > };
> > 
> > instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count,
> > GFP_KERNEL);
> > 
> > Instead of leaving these open-coded and prone to type mistakes, we
> > can now
> > use the new struct_size() helper:
> > 
> > instance = kzalloc(struct_size(instance, entry, count),
> > GFP_KERNEL);
> > 
> > This code was detected with the help of Coccinelle.
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > ---
> >   drivers/scsi/advansys.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
> > index d37584403c33..6c274e6e1c33 100644
> > --- a/drivers/scsi/advansys.c
> > +++ b/drivers/scsi/advansys.c
> > @@ -7576,8 +7576,8 @@ static int asc_build_req(struct asc_board
> > *boardp, struct scsi_cmnd *scp,
> >   			return ASC_ERROR;
> >   		}
> >   
> > -		asc_sg_head = kzalloc(sizeof(asc_scsi_q->sg_head)
> > +
> > -			use_sg * sizeof(struct asc_sg_list),
> > GFP_ATOMIC);
> > +		asc_sg_head = kzalloc(struct_size(asc_sg_head,
> > sg_list, use_sg),
> > +				      GFP_ATOMIC);
> >   		if (!asc_sg_head) {
> >   			scsi_dma_unmap(scp);
> >   			scp->result = HOST_BYTE(DID_SOFT_ERROR);
> > 
> 
> If you want ...

Are we sure there's a benefit to this?  It's obvious that the current
code is correct but no-one's likely to test the new code for quite some
time, so changing the code introduces risk. What's the benefit of
making the change in legacy drivers?  Just because we have a new, shiny
macro doesn't mean we have to force its use everywhere.

I would recommend we have a rational needs test: so run the coccinelle
script over all the drivers to find out where this construct is used,
but only update those that are actually buggy with the new macro.

James

