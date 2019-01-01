Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1D3C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 17:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399B620656
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 17:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbfAAR5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 12:57:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53602 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbfAAR5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 12:57:11 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x01HsDrC138608
        for <linux-kernel@vger.kernel.org>; Tue, 1 Jan 2019 12:57:10 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pr95hfu0c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 12:57:10 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 1 Jan 2019 17:57:09 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 1 Jan 2019 17:57:07 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x01Hv6co22151246
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Jan 2019 17:57:06 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 531AEB2068;
        Tue,  1 Jan 2019 17:57:06 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31B66B2064;
        Tue,  1 Jan 2019 17:57:06 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.153.1])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  1 Jan 2019 17:57:06 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9DE6D16C3373; Tue,  1 Jan 2019 09:57:23 -0800 (PST)
Date:   Tue, 1 Jan 2019 09:57:23 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joey Pabalinas <joeypabalinas@gmail.com>, Willy Tarreau <w@1wt.eu>,
        mingo@kernel.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] rcutorture/nolibc: add a bit of documentation to
 explain how to use nolibc
Reply-To: paulmck@linux.ibm.com
References: <20181229180218.15798-1-w@1wt.eu>
 <20181229180218.15798-4-w@1wt.eu>
 <20181229223324.slqx3qjrmzg5g2w2@gmail.com>
 <20181230070846.GA17139@1wt.eu>
 <20181230074020.nirv2jzf6lh7s5lf@gmail.com>
 <20181231200854.GS4170@linux.ibm.com>
 <20190101002136.fvn3hy7ybkhmgd3r@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190101002136.fvn3hy7ybkhmgd3r@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19010117-0060-0000-0000-000002F14A3E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010329; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000272; SDB=6.01140283; UDB=6.00593364; IPR=6.00920499;
 MB=3.00024931; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-01 17:57:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010117-0061-0000-0000-000047C28C5C
Message-Id: <20190101175723.GX4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=656 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901010164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 02:21:36PM -1000, Joey Pabalinas wrote:
> On Mon, Dec 31, 2018 at 12:08:54PM -0800, Paul E. McKenney wrote:
> > On Sat, Dec 29, 2018 at 09:40:20PM -1000, Joey Pabalinas wrote:
> > > On Sun, Dec 30, 2018 at 08:08:46AM +0100, Willy Tarreau wrote:
> > > > Definitely! Same, I won't emit a patch just for this, Paul already queued it.
> > > 
> > > Yeah, not that big a deal :)
> > > 
> > > Reviewed-by: Joey Pabalinas <joeypabalinas@gmail.com>
> > 
> > But as long as I am rebasing to add the Reviewed-by, might as well
> > update the others.
> > 
> > The English rules for capitalization and lists are baroque and completely
> > unsuited to word processors ("If any list item is longer than one line,
> > capitalize all the items."), but in this case each item has multiple
> > sentences, so it makes sense to capitalize.
> > 
> > Please see below for the updated commit, and thank you all!
> 
> Interesting, I had no idea it was actually that odd, hah.

The horrible thing is the guy that informed me of this had English as
his third or fourth of something like seven languages.  Yet he knew
English better than I ever will.  Worst of all, when I would complain
about some inconsistency, his response was simply "Mr. McKenney, it is
your language, not mine!"  ;-)

							Thanx, Paul

