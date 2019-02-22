Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5E0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 03:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0EA207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 03:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbfBVD7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 22:59:31 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:52068 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726213AbfBVD7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 22:59:30 -0500
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1M3kWgl025254;
        Fri, 22 Feb 2019 03:59:26 GMT
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com with ESMTP id 2qt7x50r3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Feb 2019 03:59:26 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 8DF8D83;
        Fri, 22 Feb 2019 03:59:25 +0000 (UTC)
Received: from anatevka (anatevka.americas.hpqcorp.net [10.34.81.61])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 2247E36;
        Fri, 22 Feb 2019 03:59:25 +0000 (UTC)
Date:   Thu, 21 Feb 2019 20:59:24 -0700
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Matt Hsiao <matt.hsiao@hpe.com>, linux-kernel@vger.kernel.org,
        arnd@arndb.de, david.altobelli@hpe.com, mark.rusk@hpe.com
Subject: Re: [PATCH 3/4] misc: hpilo: Do not claim unsupported hardware
Message-ID: <20190222035924.GA31132@anatevka>
Reply-To: Jerry.Hoemann@hpe.com
References: <1550736282-25416-1-git-send-email-matt.hsiao@hpe.com>
 <1550736282-25416-4-git-send-email-matt.hsiao@hpe.com>
 <20190221083515.GC6397@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221083515.GC6397@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-22_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=700 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902220024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 09:35:15AM +0100, Greg KH wrote:
> On Thu, Feb 21, 2019 at 04:04:41PM +0800, Matt Hsiao wrote:
> > Do not claim when SSID 0x0289 as the iLO features
> > are not enabled/validated by the firmware.
> 
> Can you put more information here, like _what_ hardware is not being
> supported anymore?  As it is, this has nothing to do with "validation by
> the firmware", you are just deciding to not support a device that
> previously was supported by this driver.  As such you should provide
> more information why you are taking away functionality.

Hi Greg,

The SSID 0x0289 correspond to the recent CL2600/CL2800 servers.  These servers
leveraged Proliant hardware but are targeted to a different market segment
with different requirements.  They also come with a different firmware base.

Based upon the targeted market needs, these server de-featured certain
aspects of Proliants with this being one.

As a result, the linux hpilo driver still claims the hardware but
is not functional.

We decided to blacklist the driver to reduce confusion to customers.

Matt will update the documentation in the second version of the patch set.

Hope this helps.

Take care,

Jerry

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
