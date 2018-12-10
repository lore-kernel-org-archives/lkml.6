Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D628C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D012020821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D012020821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbeLJVb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:31:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728088AbeLJVb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:31:27 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBALOREY110027
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 16:31:26 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p9w9yfkxc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 16:31:26 -0500
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jejb@linux.ibm.com>;
        Mon, 10 Dec 2018 21:31:25 -0000
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 10 Dec 2018 21:31:20 -0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBALVJ7s28049432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Dec 2018 21:31:19 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2C2078063;
        Mon, 10 Dec 2018 21:31:19 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AFB178069;
        Mon, 10 Dec 2018 21:31:17 +0000 (GMT)
Received: from [153.66.254.194] (unknown [9.80.236.69])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 10 Dec 2018 21:31:16 +0000 (GMT)
Subject: Re: [PATCH] scsi: qla2xxx: fix unused function warning
From:   James Bottomley <jejb@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>, bvanassche@acm.org
Cc:     qla2xxx-upstream@qlogic.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        loberman@redhat.com,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, hmadhani@marvell.com,
        quinn.tran@cavium.com, Hannes Reinecke <hare@suse.de>,
        Jens Axboe <axboe@kernel.dk>, darren.trapp@cavium.com,
        William.Kuzeja@stratus.com,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 10 Dec 2018 13:31:15 -0800
In-Reply-To: <CAK8P3a0MShhjPMUdNs=CTqOJ-ovDPczYiQFL9c2M2dOUQ4yK7w@mail.gmail.com>
References: <20181210205215.2703138-1-arnd@arndb.de>
         <1544475666.185366.378.camel@acm.org>
         <CAK8P3a0MShhjPMUdNs=CTqOJ-ovDPczYiQFL9c2M2dOUQ4yK7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18121021-0036-0000-0000-00000A6880A0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010210; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01129898; UDB=6.00587084; IPR=6.00910031;
 MB=3.00024646; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-10 21:31:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121021-0037-0000-0000-000049EDD87C
Message-Id: <1544477475.2753.26.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-10_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=978 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812100191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-10 at 22:28 +0100, Arnd Bergmann wrote:
> On Mon, Dec 10, 2018 at 10:01 PM Bart Van Assche <bvanassche@acm.org>
> wrote:
> > 
> > On Mon, 2018-12-10 at 21:51 +0100, Arnd Bergmann wrote:
> > > In what seems to be a mismatch between the scsi-fixes branch and
> > > the scsi-mkp/for-next branch, a newly introduced variable from
> > > one patch got obsoleted in another one:
> > > 
> > > drivers/scsi/qla2xxx/qla_os.c: In function
> > > '__qla2x00_abort_all_cmds':
> > > drivers/scsi/qla2xxx/qla_os.c:1791:11: error: unused variable
> > > 'status' [-Werror=unused-variable]
> > > 
> > > Remove the variable again.
> > > 
> > > Fixes: c4e521b654e1 ("scsi: qla2xxx: Split the
> > > __qla2x00_abort_all_cmds() function")
> > > Fixes: f2ffd4e5bc7b ("scsi: qla2xxx: Timeouts occur on surprise
> > > removal of QLogic adapter")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > > Maybe check carefully that the merge in linux-next is otherwise
> > > correct
> > > ---
> > >  drivers/scsi/qla2xxx/qla_os.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/scsi/qla2xxx/qla_os.c
> > > b/drivers/scsi/qla2xxx/qla_os.c
> > > index 63c47bc7ae59..db331cb5ba3c 100644
> > > --- a/drivers/scsi/qla2xxx/qla_os.c
> > > +++ b/drivers/scsi/qla2xxx/qla_os.c
> > > @@ -1788,7 +1788,7 @@ static void qla2x00_abort_srb(struct
> > > qla_qpair *qp, srb_t *sp, const int res,
> > >  static void
> > >  __qla2x00_abort_all_cmds(struct qla_qpair *qp, int res)
> > >  {
> > > -     int cnt, status;
> > > +     int cnt;
> > >       unsigned long flags;
> > >       srb_t *sp;
> > >       scsi_qla_host_t *vha = qp->vha;
> > 
> > When I prepared commit c4e521b654e1 I verified that my patch did
> > not produce any
> > warnings when building with W=1. So something must be wrong at your
> > side. Did you
> > perhaps start from linux-next to prepare this patch? If so, please
> > submit this
> > patch to Stephen Rothwell.
> 
> Yes, I tried to make clear that the two branches are fine by
> themselves, sorry if I was still ambiguous. The patch is currently
> only needed on linux-next as far as I can tell, but we should avoid
> getting the same error when the branches are merged in mainline.

It should be fixed in linux-next as of the next release.  It was just a
problem with the original merge which I fixed when I did my version of
it.

James

