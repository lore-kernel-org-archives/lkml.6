Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59A3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C269217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732591AbfBRPcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 10:32:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43924 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729975AbfBRPcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 10:32:15 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1IFTx4S066201
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 10:32:14 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qqx03dk74-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 10:32:14 -0500
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jejb@linux.ibm.com>;
        Mon, 18 Feb 2019 15:32:13 -0000
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Feb 2019 15:32:09 -0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1IFW8iS29818998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Feb 2019 15:32:08 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A95578060;
        Mon, 18 Feb 2019 15:32:08 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B775B7805C;
        Mon, 18 Feb 2019 15:32:06 +0000 (GMT)
Received: from jarvis.ext.hansenpartnership.com (unknown [9.80.228.140])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 18 Feb 2019 15:32:06 +0000 (GMT)
Subject: Re: [PATCH] scsi: mvumi: fix 32 bit shift of a 32 bit unsigned int
From:   James Bottomley <jejb@linux.ibm.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Walter Harms <wharms@bfs.de>
Cc:     Colin King <colin.king@canonical.com>,
        Jianyun Li <jyli@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 18 Feb 2019 07:32:05 -0800
In-Reply-To: <20190218093710.GB17104@kadam>
References: <1596625925.142066.1550334436646@ox-groupware.bfs.de>
         <20190218093710.GB17104@kadam>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19021815-0012-0000-0000-0000170CAE71
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010620; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01162882; UDB=6.00607140; IPR=6.00943458;
 MB=3.00025638; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-18 15:32:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021815-0013-0000-0000-0000563F77E0
Message-Id: <1550503925.2834.3.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-18_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902180115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-02-18 at 12:37 +0300, Dan Carpenter wrote:
> On Sat, Feb 16, 2019 at 05:27:16PM +0100, Walter Harms wrote:
> > Am 16.02.2019 15:44, schrieb Colin King:
> > > From: Colin Ian King <colin.king@canonical.com>
> > > 
> > > Currently m_sg->baseaddr_h (a 32 bit unsigned int) is being
> > > shifted by a
> > > total of 32 bits; this always produces a 0 result.  Fix this by
> > > casting
> > > it to a dma_addr_t (a 64 bit unsigned int) before performing the
> > > shift.
> > > 
> > > Detected by CoverityScan, CID#147270 ("Operands don't affect
> > > result")
> > > 
> > > Fixes: f0c568a478f0 ("[SCSI] mvumi: Add Marvell UMI driver")
> > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > ---
> > >  drivers/scsi/mvumi.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
> > > index 36f64205ecfa..d3582accfd09 100644
> > > --- a/drivers/scsi/mvumi.c
> > > +++ b/drivers/scsi/mvumi.c
> > > @@ -313,7 +313,7 @@ static void mvumi_delete_internal_cmd(struct
> > > mvumi_hba
> > > *mhba,
> > >  			sgd_getsz(mhba, m_sg, size);
> > >  
> > >  			phy_addr = (dma_addr_t) m_sg->baseaddr_l 
> > > |
> > > -				(dma_addr_t) ((m_sg->baseaddr_h
> > > << 16) << 16);
> > > +				(((dma_addr_t) m_sg->baseaddr_h
> > > << 16) << 16);
> > >  
> > >  			dma_free_coherent(&mhba->pdev->dev,
> > > size, cmd->data_buf,
> > >  								
> > > phy_addr);
> > 
> > i would suggest to try a version with less casts to make it more
> > readable
> > like this untested suggestion:
> > 
> > phy_addr =(m_sg->baseaddr_h << 16)| m_sg->baseaddr_l;
> > phy_addr <<= 16;
> > 
> 
> That would be a behavior change but it also might be a bugfix?  Why
> doesn't the code just do:
> 
> 	phy_addr = ((dma_addr_t)m_sg->baseaddr_h << 32) | m_sg-
> >baseaddr_l;
> 
> (Probably they broke it up into two shifts to silence a GCC warning
> that the shift was wrong because of the missing cast?)

No because dma_addr_t can be 32 bits and the warning would then always
appear on some builds.  The << 16 << 16 makes sure it doesn't.

James



