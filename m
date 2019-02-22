Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024D4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 04:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF77207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 04:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfBVELR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 23:11:17 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:40234 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726178AbfBVELQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 23:11:16 -0500
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1M46iMs016047;
        Fri, 22 Feb 2019 04:11:12 GMT
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 2qt7x50thw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Feb 2019 04:11:12 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id DFF7055;
        Fri, 22 Feb 2019 04:11:11 +0000 (UTC)
Received: from anatevka (anatevka.americas.hpqcorp.net [10.34.81.61])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 7438A45;
        Fri, 22 Feb 2019 04:11:11 +0000 (UTC)
Date:   Thu, 21 Feb 2019 21:11:11 -0700
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Matt Hsiao <matt.hsiao@hpe.com>, linux-kernel@vger.kernel.org,
        arnd@arndb.de, david.altobelli@hpe.com, mark.rusk@hpe.com
Subject: Re: [PATCH 4/4] misc: hpilo: Update driver version
Message-ID: <20190222041111.GB31132@anatevka>
Reply-To: Jerry.Hoemann@hpe.com
References: <1550736282-25416-1-git-send-email-matt.hsiao@hpe.com>
 <1550736282-25416-5-git-send-email-matt.hsiao@hpe.com>
 <20190221083256.GA6397@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221083256.GA6397@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-22_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=816 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902220026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 09:32:56AM +0100, Greg KH wrote:
...
> >  
> > -MODULE_VERSION("1.5.0");
> > +MODULE_VERSION("1.5.1");
> 
> This line means nothing, it should just be removed entirely.  The
> "version" of the driver is the kernel version itself.

Hi Greg,

This doesn't hold when we do driver updates.

Our primary means of supporting Linux to our customers is via our
distro partners.  While we prefer to use in distro drivers, HPE does
from time to time deliver driver updates via the "Service Pack for
Proliants" -- The SPP. 

An SPP driver update can supply an updated module without modifying
the underlying base kernel version.  Because of this, the underlying
kernel version number doesn't always imply the version of a module
being used.

Even when we use only in kernel drivers, we also have the case where
our distro partners will back port newer driver versions to an older
distro release.  This gives the situation where an older kernel
version can have a newer module than a newer kernel version for
that distro.

We have found that having module version bumped when modifying the
driver helps us identify the version module actually being used.

Take care,

Jerry

> 
> Want me to drop it?

No. please keep it.  :)

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
