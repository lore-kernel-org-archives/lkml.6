Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3E88FC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8716208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8716208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935181AbeFMKFs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 06:05:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56974 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934226AbeFMKFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 06:05:47 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5DA5dGV054545
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 06:05:47 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jk0b6aayr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 06:05:45 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 13 Jun 2018 06:04:15 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Jun 2018 06:04:12 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5DA4BoB59899976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Jun 2018 10:04:11 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 872D0B2067;
        Wed, 13 Jun 2018 06:04:09 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72050B2064;
        Wed, 13 Jun 2018 06:04:09 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.171.172])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 13 Jun 2018 06:04:09 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A64B416C2C58; Wed, 13 Jun 2018 03:06:07 -0700 (PDT)
Date:   Wed, 13 Jun 2018 03:06:07 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     NeilBrown <neilb@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        trondmy@hammerspace.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [GIT PULL] Please pull NFS client changes for 4.18
Reply-To: paulmck@linux.vnet.ibm.com
References: <e5c90488937d14e9df81752a024be9d1e73ed398.camel@hammerspace.com>
 <CA+55aFxYMg+F9Jdi_25X-Qtt=7imqjQhLnjEyQXOQ6+eJvy83A@mail.gmail.com>
 <CA+55aFw+2+xCRAaMo8qgvZ7qNgRMo6D=WkwP7APQndG-y5b3dw@mail.gmail.com>
 <CA+55aFz3jmGST_cOB+qH6qZTFa5HJcw2JoeWxJEZdWgeO4=vNQ@mail.gmail.com>
 <20180613010427.GD3593@linux.vnet.ibm.com>
 <CA+55aFyWS-MC44k=LnGWr-Kq4_DRkJmub00Fj-tVrGxCL-PxGA@mail.gmail.com>
 <20180613013914.GE3593@linux.vnet.ibm.com>
 <87muvzihr8.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87muvzihr8.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18061310-2213-0000-0000-000002B9051E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009182; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01046303; UDB=6.00535848; IPR=6.00825278;
 MB=3.00021621; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-13 10:04:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061310-2214-0000-0000-00005A778C48
Message-Id: <20180613100607.GH3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-13_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806130113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 11:42:51AM +1000, NeilBrown wrote:
> On Tue, Jun 12 2018, Paul E. McKenney wrote:
> 
> > On Tue, Jun 12, 2018 at 06:11:50PM -0700, Linus Torvalds wrote:
> >> On Tue, Jun 12, 2018 at 6:02 PM Paul E. McKenney
> >> <paulmck@linux.vnet.ibm.com> wrote:
> >> >
> >> > We did review this one, and Neil did make requested changes to the comment
> >> > header and documentation.
> >> 
> >> Oh, I checked the commit for "acked-by" from you and didn't see any,
> >> so I was assuming this was just Neil and Trond on their own..
> >
> > Hmmm...  I gave them a Reviewed-by, but perhaps it got lost.
> >
> > http://lkml.kernel.org/r/20180501141404.GD26088@linux.vnet.ibm.com
> 
> Sorry about that.  I think I planned to add it after I heard back from
> Trond what he thought of the patch, but I didn't hear anything until it
> landed.  I'll try to be more proactive next time.

Not a problem from my viewpoint.  There may come a time when I need to
care about contribution metrics, but I don't need to at the moment.  ;-)

							Thanx, Paul

