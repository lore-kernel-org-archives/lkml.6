Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59418C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 03:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09CE427B5E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 03:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09CE427B5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936677AbeF3DwD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 23:52:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33460 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S936630AbeF3DwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 23:52:00 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5U3iJ8F086836
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 23:52:00 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jwx60f75d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 23:51:59 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <benh@au1.ibm.com>;
        Sat, 30 Jun 2018 04:51:57 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 30 Jun 2018 04:51:53 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5U3pqYH36176100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 30 Jun 2018 03:51:53 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2CD5A404D;
        Sat, 30 Jun 2018 04:51:39 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 825E0A4040;
        Sat, 30 Jun 2018 04:51:39 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 30 Jun 2018 04:51:39 +0100 (BST)
Received: from pasglop (unknown [9.192.179.161])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 225FBA00E5;
        Sat, 30 Jun 2018 13:51:49 +1000 (AEST)
Subject: Re: [PATCH 2/2] drivers: core: Remove glue dirs from sysfs earlier
From:   Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Stanley <joel@jms.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sat, 30 Jun 2018 13:51:48 +1000
In-Reply-To: <61424071cc0feb487e4b8ce2c9c396df2fc56bd9.camel@kernel.crashing.org>
References: <c40fe912fe008b1b531a3867e8784ed79d68023e.camel@kernel.crashing.org>
         <CA+55aFxR0qg0yY-NWnH0DDruVWw8qRqp8=CRLq13p=TyxosJKw@mail.gmail.com>
         <ac64e45950c8e3df26fd50e7b251d5895c1d2201.camel@kernel.crashing.org>
         <CA+55aFwZG+wWwRX-FOgQHwt3eA76qgKb0W0sRGSd8Ug=szr20A@mail.gmail.com>
         <61424071cc0feb487e4b8ce2c9c396df2fc56bd9.camel@kernel.crashing.org>
Organization: IBM Australia
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18063003-4275-0000-0000-000002938D1A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18063003-4276-0000-0000-0000379AFFF3
Message-Id: <b74e1b91b54053d85ee052b034f812769f13ee5e.camel@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-30_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=784 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806300040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-06-30 at 11:04 +1000, Benjamin Herrenschmidt wrote:
> I had a look (see my other email). It's non-trivial. We can still look
> into it, but from what I gathered of how sysfs works, it's based on
> kernfs which doesn't have the kobjects nor access to the reference
> count, and is the holder of the names rbtree.
> 
> So we'd need to find a way to convey that "in-use" information down to
> kernfs (I thought maybe adding an optional pointer to a kref ? but
> then, it's still somewhat racy ...)
> 
> Additionally, we would need a few more pairs of eyes to make sure that
> sticking duplicates in that rbtree isn't going to break some corner
> case in there.

Just to clarify, I will look into it, but it will take more time so I'm
keen on having the low hanging fixes in now.

Also in general, I dislike the idea of leaving things in sysfs with a
refcount of 0. That "late" cleanup in kobject_release() looks to me
more like a band-aid than a feature.

I'd be almost tempted to stick a WARN_ON in there and see who gets hit
but I worry it's going send me down one of those rabbit holes and my
time is limited these days ;-)

Cheers,
Ben.

