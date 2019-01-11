Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5162C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F1220878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388695AbfAKRXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:23:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389379AbfAKRXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:23:34 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0BHEe38142273
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 12:23:33 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pxx9wcjtb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 12:23:32 -0500
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jejb@linux.ibm.com>;
        Fri, 11 Jan 2019 17:23:32 -0000
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 11 Jan 2019 17:23:30 -0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0BHNSjo19267710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 17:23:29 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB8F27805C;
        Fri, 11 Jan 2019 17:23:28 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A99078060;
        Fri, 11 Jan 2019 17:23:27 +0000 (GMT)
Received: from [153.66.254.194] (unknown [9.85.186.19])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 11 Jan 2019 17:23:27 +0000 (GMT)
Subject: Re: [PATCH] scsi: advansys: use struct_size() in kzalloc()
From:   James Bottomley <jejb@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hannes Reinecke <hare@suse.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 11 Jan 2019 09:23:26 -0800
In-Reply-To: <20190111165449.GG6310@bombadil.infradead.org>
References: <20190104212209.GA15250@embeddedor>
         <05420a5c-c268-b87d-9d75-f5d18a4b7f7a@suse.de>
         <1547224903.2793.10.camel@linux.ibm.com>
         <20190111165449.GG6310@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19011117-0036-0000-0000-00000A7946CF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010385; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01145010; UDB=6.00596232; IPR=6.00925279;
 MB=3.00025086; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-11 17:23:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011117-0037-0000-0000-00004A4E5FC9
Message-Id: <1547227406.2793.24.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-11_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=672 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901110140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-11 at 08:54 -0800, Matthew Wilcox wrote:
> On Fri, Jan 11, 2019 at 08:41:43AM -0800, James Bottomley wrote:
> > On Fri, 2019-01-11 at 16:46 +0100, Hannes Reinecke wrote:
> > > > -		asc_sg_head = kzalloc(sizeof(asc_scsi_q-
> > > > >sg_head)
> > > > +
> > > > -			use_sg * sizeof(struct asc_sg_list),
> > > > GFP_ATOMIC);
> > > > +		asc_sg_head = kzalloc(struct_size(asc_sg_head,
> > > > sg_list, use_sg),
> > > > +				      GFP_ATOMIC);
> > > 
> > > If you want ...
> > 
> > Are we sure there's a benefit to this?  It's obvious that the
> > current
> > code is correct but no-one's likely to test the new code for quite
> > some
> > time, so changing the code introduces risk. What's the benefit of
> > making the change in legacy drivers?  Just because we have a new,
> > shiny
> > macro doesn't mean we have to force its use everywhere.
> > 
> > I would recommend we have a rational needs test: so run the
> > coccinelle
> > script over all the drivers to find out where this construct is
> > used,
> > but only update those that are actually buggy with the new macro.
> 
> It's hard to tell whether they're buggy.  The problem being defended
> against here is integer overflow.  So can 'use_sg' ever get large
> enough that sizeof(asc_scsi_q->sg_head) + use_sg * sizeof(struct
> asc_sg_list) is larger than 4 billion?  Probably not; I imagine
> there's some rational sane limit elsewhere that says "No more than
> 256 SG elements" or something.

OK so firstly describing why we're doing this would have been
enormously useful.

Secondly, as you say, even with the enhanced rationale I'm not sure it
provides any benefit:  he advansys is two drivers squashed together:
the asc_ and adv_ prefixes.  It looks like the adv_ variant does check
the number of sg elements against the max, but asc_ doesn't; it relies
on the host limit sg_tablesize.  In both cases the actual limit is
somewhere around 255, so if the user can control the value they can
definitely cause corruption long before we get to mathematical
overflow.

The limit should be enforced by blk_queue_max_segments() and I think
this is done in all cases (including SG_IO).

> But I don't know without checking.  Is there some device-specific
> ioctl where the user can specify 2^31 scatterlist entries and
> somebody forgot to check?  This macro is a defense-in-depth strategy,
> so using it as widely as possible makes more sense than arguing about
> whether there are already adequate safeguards in place.

OK, so this is a question worth asking (I believe the answer to be "no"
but I could be wrong) because if there is some way of getting the value
over the driver internal table max (which is fixed for quite a few
drivers) we can induce corruption which this macro won't defend against
and if we need to, we should probably defend in sg_map_dma().

James


