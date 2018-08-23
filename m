Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9CCC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C90521566
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C90521566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeHWWOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 18:14:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39678 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726985AbeHWWOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 18:14:37 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7NITGXS119942
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 14:43:36 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m1y1dhkc3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 14:43:36 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 23 Aug 2018 14:43:36 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Aug 2018 14:43:34 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7NIhXPf28704842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Aug 2018 18:43:33 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2325B2067;
        Thu, 23 Aug 2018 14:42:37 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84A6FB205F;
        Thu, 23 Aug 2018 14:42:37 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 23 Aug 2018 14:42:37 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A3C1B16C86E3; Thu, 23 Aug 2018 11:43:33 -0700 (PDT)
Date:   Thu, 23 Aug 2018 11:43:33 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Nicolas Pitre <nicolas.pitre@linaro.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel-only deployments?
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180823174359.GA13033@linux.vnet.ibm.com>
 <CAMuHMdW4utnKZrEjAtWCUyfUj7qp1EXTj5B+fCryE23GHMLtnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdW4utnKZrEjAtWCUyfUj7qp1EXTj5B+fCryE23GHMLtnA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18082318-0040-0000-0000-0000046437DA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009599; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01077799; UDB=6.00555724; IPR=6.00857773;
 MB=3.00022891; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-23 18:43:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082318-0041-0000-0000-0000086B4C1F
Message-Id: <20180823184333.GR4225@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-23_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808230191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 08:16:55PM +0200, Geert Uytterhoeven wrote:
> Hi Paul,
> 
> On Thu, Aug 23, 2018 at 7:44 PM Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > Does anyone do kernel-only deployments, for example, setting up an
> > embedded device having a Linux kernel and absolutely no userspace
> > whatsoever?
> 
> Isn't that basically the original porting guide from VxWorks to Linux?

I haven't seen that document, but if you say so.  The TimeSys appnote
suggests using Linux userspace, but I can easily imagine cases where
porting the VxWorks "application" into the Linux kernel.

But do you really believe that supporting Linux-kernel-only deployments
in mainline would be something worth doing?  Who aside from rcutorture
would really use such a thing?

							Thanx, Paul

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 

