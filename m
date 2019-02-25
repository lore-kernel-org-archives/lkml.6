Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8FAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508B220842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfBYI2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 03:28:12 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:32970 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725942AbfBYI2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 03:28:11 -0500
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1P8Q4m1018821;
        Mon, 25 Feb 2019 08:28:07 GMT
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0a-002e3701.pphosted.com with ESMTP id 2qvcq6r288-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Feb 2019 08:28:07 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id 22E8E92;
        Mon, 25 Feb 2019 08:28:06 +0000 (UTC)
Received: from anatevka (anatevka.americas.hpqcorp.net [10.34.81.61])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id ACD3E48;
        Mon, 25 Feb 2019 08:28:05 +0000 (UTC)
Date:   Mon, 25 Feb 2019 01:28:05 -0700
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Matt Hsiao <matt.hsiao@hpe.com>, linux-kernel@vger.kernel.org,
        arnd@arndb.de, david.altobelli@hpe.com, mark.rusk@hpe.com
Subject: Re: [PATCH 4/4] misc: hpilo: Update driver version
Message-ID: <20190225082805.GA10062@anatevka>
Reply-To: Jerry.Hoemann@hpe.com
References: <1550736282-25416-1-git-send-email-matt.hsiao@hpe.com>
 <1550736282-25416-5-git-send-email-matt.hsiao@hpe.com>
 <20190221083256.GA6397@kroah.com>
 <20190222041111.GB31132@anatevka>
 <20190222064928.GA15860@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222064928.GA15860@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-25_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902250063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 07:49:28AM +0100, Greg KH wrote:
> On Thu, Feb 21, 2019 at 09:11:11PM -0700, Jerry Hoemann wrote:
> 
> > Our primary means of supporting Linux to our customers is via our
> > distro partners.  While we prefer to use in distro drivers, HPE does
> > from time to time deliver driver updates via the "Service Pack for
> > Proliants" -- The SPP. 
> 
> That's fine, but again, does not matter to the in-kernel driver at all.

Your point?  No one claimed that changing the version number
of the module changes its functionality.  We're changing the driver
version number to reflect that the driver's functionality changed.

We do this to help determine the version running on a system
in the event we have problems.  It's a support issue.

> I understand that in your viewpoint, your driver's version means
> something.  But in reality, it's only the kernel's version that means
> something because your driver is just part of the overall kernel, it
> does not stand alone.

I never claimed a driver stood alone.  jeezz.

When you say kernel "version", are you trying to say that the version
string printed by the kernel determines the source of the drivers?
(I ask, because I have heard other maintainers make this claim.)

The kernel version string only reliably determines the base kernel build.
Modules can be unloaded and replaced by totally new versions drastically
different from the version that existed at the time of the base kernel build.

The delivery of drivers updates independent of base kernel was old
practice when I started Unix development 30 years ago.  It was not unique
to HPE then or now.  I don't see it stopping.

So while Linux delivers drivers built to a baseline kernel build, we
cannot rely that the bits being used on a system still reflect that initial
install.  We can't just assume a driver version.  And without knowing
the driver version, it makes support more difficult.

If you're trying to be profound, the "version" of the OS running is
more than just the base kernel.  That is only the beginning.
We then have to consider the modules loaded and the order that they're
loaded.  This sequence is unbounded as modules can be repeatedly loaded
and unloaded.  When you know that, then you know the "version" of the kernel
running.

But that isn't what the kernel version string gives you.  So why have it/print it?
By your reasoning it's meaningless. It should be tossed.  We have it because
it gives us info, but it is only a start.


-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
