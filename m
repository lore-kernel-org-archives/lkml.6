Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A201EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD002184A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1pNxpUqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbfBRJhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:37:40 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43686 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729706AbfBRJhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:37:39 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1I9YJDQ013053;
        Mon, 18 Feb 2019 09:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=S7BpYWvWJfJZDRrSk/Ev/sZMj8iLn7HBry9NGkvBct8=;
 b=1pNxpUqH7lsvoKOh9P0ngvXRT2f/jBttQRlnKQ5II3be+v8bf7TxPtu5rpyQkOPkytUb
 3yaLus7zvQpCAH+vuqky/UKNVUnQFDNLCraDg9tusvw/SsXAL59M8haikJXflDI6vVcE
 l6CA0PBSB0vDMeiHCJZ42m53DUhiy4MEuGwim3ACHHrA0rVdcCt818IEvTTi2cU0d/Et
 MzDpCKWuSn5ZUaRUPmXKhxtNqhyYQ1jaLJUJQgkIG2q3YcdvjPIhSi4Oj92aTocco9co
 buTi6R/yqIAS6x2jYZXsj6G1nQEg0KzOMKbOzbC8DK1+zqrAHeIqeM1FXRqKeMi7Dqxw hw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2qpb5r530s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Feb 2019 09:37:31 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1I9bP2r015692
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Feb 2019 09:37:25 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1I9bLpZ015348;
        Mon, 18 Feb 2019 09:37:21 GMT
Received: from kadam (/197.157.0.22)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Feb 2019 01:37:21 -0800
Date:   Mon, 18 Feb 2019 12:37:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Walter Harms <wharms@bfs.de>
Cc:     Colin King <colin.king@canonical.com>,
        Jianyun Li <jyli@marvell.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: mvumi: fix 32 bit shift of a 32 bit unsigned int
Message-ID: <20190218093710.GB17104@kadam>
References: <1596625925.142066.1550334436646@ox-groupware.bfs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596625925.142066.1550334436646@ox-groupware.bfs.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9170 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902180074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 05:27:16PM +0100, Walter Harms wrote:
> Am 16.02.2019 15:44, schrieb Colin King:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Currently m_sg->baseaddr_h (a 32 bit unsigned int) is being shifted by a
> > total of 32 bits; this always produces a 0 result.  Fix this by casting
> > it to a dma_addr_t (a 64 bit unsigned int) before performing the shift.
> > 
> > Detected by CoverityScan, CID#147270 ("Operands don't affect result")
> > 
> > Fixes: f0c568a478f0 ("[SCSI] mvumi: Add Marvell UMI driver")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/scsi/mvumi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
> > index 36f64205ecfa..d3582accfd09 100644
> > --- a/drivers/scsi/mvumi.c
> > +++ b/drivers/scsi/mvumi.c
> > @@ -313,7 +313,7 @@ static void mvumi_delete_internal_cmd(struct mvumi_hba
> > *mhba,
> >  			sgd_getsz(mhba, m_sg, size);
> >  
> >  			phy_addr = (dma_addr_t) m_sg->baseaddr_l |
> > -				(dma_addr_t) ((m_sg->baseaddr_h << 16) << 16);
> > +				(((dma_addr_t) m_sg->baseaddr_h << 16) << 16);
> >  
> >  			dma_free_coherent(&mhba->pdev->dev, size, cmd->data_buf,
> >  								phy_addr);
> 
> i would suggest to try a version with less casts to make it more readable
> like this untested suggestion:
> 
> phy_addr =(m_sg->baseaddr_h << 16)| m_sg->baseaddr_l;
> phy_addr <<= 16;
> 

That would be a behavior change but it also might be a bugfix?  Why
doesn't the code just do:

	phy_addr = ((dma_addr_t)m_sg->baseaddr_h << 32) | m_sg->baseaddr_l;

(Probably they broke it up into two shifts to silence a GCC warning that
the shift was wrong because of the missing cast?)

regards,
dan carpenter


