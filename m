Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B5DC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE11721852
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbfA3IeQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:34:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56796 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730190AbfA3IeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:34:15 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0U8XlDn124848
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 03:34:14 -0500
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.91])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qb6jh4raa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 03:34:14 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-kernel@vger.kernel.org> from <JOELN@il.ibm.com>;
        Wed, 30 Jan 2019 08:34:13 -0000
Received: from us1a3-smtp03.a3.dal06.isc4sb.com (10.106.154.98)
        by smtp.notes.na.collabserv.com (10.106.227.143) with smtp.notes.na.collabserv.com ESMTP;
        Wed, 30 Jan 2019 08:34:05 -0000
Received: from us1a3-mail108.a3.dal06.isc4sb.com ([10.146.45.126])
          by us1a3-smtp03.a3.dal06.isc4sb.com
          with ESMTP id 2019013008340388-215235 ;
          Wed, 30 Jan 2019 08:34:03 +0000 
In-Reply-To: <20190129170406.GD10094@ziepe.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-rdma@vger.kernel.org, linux-rdma-owner@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 5/5] RDMA/uverbs: add UVERBS_METHOD_REG_REMOTE_MR
From:   "Joel Nider" <JOELN@il.ibm.com>
Date:   Wed, 30 Jan 2019 10:34:02 +0200
References: <1548768386-28289-1-git-send-email-joeln@il.ibm.com>
 <1548768386-28289-6-git-send-email-joeln@il.ibm.com>
 <20190129170406.GD10094@ziepe.ca>
MIME-Version: 1.0
X-KeepSent: 8090F111:AEB0B591-C2258392:002E4215;
 type=4; name=$KeepSent
X-Mailer: IBM Notes Release 9.0.1FP7 August 18, 2016
X-LLNOutbound: False
X-Disclaimed: 46851
X-TNEFEvaluated: 1
x-cbid: 19013008-9951-0000-0000-00000B265F7C
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.425523; ST=0; TS=0; UL=0; ISC=; MB=0.000759
X-IBM-SpamModules-Versions: BY=3.00010503; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01153831; UDB=6.00601589; IPR=6.00934206;
 BA=6.00006216; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00025352; XFM=3.00000015;
 UTC=2019-01-30 08:34:10
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-01-30 05:59:00 - 6.00009527
x-cbparentid: 19013008-9952-0000-0000-00001B34A862
Message-Id: <OF8090F111.AEB0B591-ONC2258392.002E4215-C2258392.002F0FDE@notes.na.collabserv.com>
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux-rdma-owner@vger.kernel.org wrote on 01/29/2019 07:04:06 PM:

> On Tue, Jan 29, 2019 at 03:26:26PM +0200, Joel Nider wrote:
> > Add a new handler for new uverb reg_remote_mr. The purpose is to 
register
> > a memory region in a different address space (i.e. process) than the
> > caller.
> > 
> > The main use case which motivated this change is post-copy container
> > migration. When a migration manager (i.e. CRIU) starts a migration, it
> > must have an open connection for handling any page faults that occur
> > in the container after restoration on the target machine. Even though
> > CRIU establishes and maintains the connection, ultimately the memory
> > is copied from the container being migrated (i.e. a remote address
> > space). This container must remain passive -- meaning it cannot have
> > any knowledge of the RDMA connection; therefore the migration manager
> > must have the ability to register a remote memory region. This remote
> > memory region will serve as the source for any memory pages that must
> > be copied (on-demand or otherwise) during the migration.
> > 
> > Signed-off-by: Joel Nider <joeln@il.ibm.com>
> >  drivers/infiniband/core/uverbs_std_types_mr.c | 129 
+++++++++++++++++++++++++-
> >  include/rdma/ib_verbs.h                       |   8 ++
> >  include/uapi/rdma/ib_user_ioctl_cmds.h        |  13 +++
> >  3 files changed, 149 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/core/uverbs_std_types_mr.c b/drivers/
> infiniband/core/uverbs_std_types_mr.c
> > index 4d4be0c..bf7b4b2 100644
> > +++ b/drivers/infiniband/core/uverbs_std_types_mr.c
> > @@ -150,6 +150,99 @@ static int 
UVERBS_HANDLER(UVERBS_METHOD_DM_MR_REG)(
> >     return ret;
> >  }
> > 
> > +static int UVERBS_HANDLER(UVERBS_METHOD_REG_REMOTE_MR)(
> > +   struct uverbs_attr_bundle *attrs)
> > +{
> 
> I think this should just be REG_MR with an optional remote PID
> argument

Maybe I missed something.  Isn't REG_MR only implemented as a write() 
command? In our earlier conversation you told me all new commands must be 
implemented as ioctl() commands.


> >  DECLARE_UVERBS_NAMED_OBJECT(
> >     UVERBS_OBJECT_MR,
> >     UVERBS_TYPE_ALLOC_IDR(uverbs_free_mr),
> >     &UVERBS_METHOD(UVERBS_METHOD_DM_MR_REG),
> >     &UVERBS_METHOD(UVERBS_METHOD_MR_DESTROY),
> > -   &UVERBS_METHOD(UVERBS_METHOD_ADVISE_MR));
> > +   &UVERBS_METHOD(UVERBS_METHOD_ADVISE_MR),
> > +   &UVERBS_METHOD(UVERBS_METHOD_REG_REMOTE_MR),
> > +);
> 
> I'm kind of surprised this compiles with the trailing comma?
Personally, I think it is nicer with the trailing comma. Of course 
syntactically it makes no sense, but when adding a new entry, you don't 
have to touch the previous line, which makes the diff cleaner. If this is 
against standard practices I will remove the comma.



