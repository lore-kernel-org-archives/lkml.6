Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3071BC282D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121DF217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbfBESwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:52:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35678 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727524AbfBESwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:52:40 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x15ImmWs011630
        for <linux-kernel@vger.kernel.org>; Tue, 5 Feb 2019 13:52:38 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qfe9ep42m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 13:52:38 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 5 Feb 2019 18:52:36 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 5 Feb 2019 18:52:34 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x15IqWo860883126
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Feb 2019 18:52:33 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E12E8A4053;
        Tue,  5 Feb 2019 18:52:32 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC710A4055;
        Tue,  5 Feb 2019 18:52:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.107.43])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 Feb 2019 18:52:31 +0000 (GMT)
Subject: Re: [PATCH] x86/ima: require signed kernel modules
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Justin Forbes <jforbes@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Date:   Tue, 05 Feb 2019 13:52:21 -0500
In-Reply-To: <20190205183201.GA3218@ubuntu-xps13>
References: <1548962339-10681-1-git-send-email-zohar@linux.ibm.com>
         <1548962339-10681-2-git-send-email-zohar@linux.ibm.com>
         <20190205151859.GD16362@ubuntu-xps13>
         <1549385244.4146.148.camel@linux.ibm.com>
         <20190205183201.GA3218@ubuntu-xps13>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19020518-0008-0000-0000-000002BC7927
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020518-0009-0000-0000-000022287CC0
Message-Id: <1549392741.4146.161.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902050143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-02-05 at 12:32 -0600, Seth Forshee wrote:
> On Tue, Feb 05, 2019 at 11:47:24AM -0500, Mimi Zohar wrote:
> > Hi Seth,
> > 
> > On Tue, 2019-02-05 at 09:18 -0600, Seth Forshee wrote:
> > > On Thu, Jan 31, 2019 at 02:18:59PM -0500, Mimi Zohar wrote:
> > > > Require signed kernel modules on systems with secure boot mode enabled.
> > > > 
> > > > To coordinate between appended kernel module signatures and IMA
> > > > signatures, only define an IMA MODULE_CHECK policy rule if
> > > > CONFIG_MODULE_SIG is not enabled.
> > > > 
> > > > This patch defines a function named set_module_sig_required() and renames
> > > > is_module_sig_enforced() to is_module_sig_enforced_or_required().  The
> > > > call to set_module_sig_required() is dependent on CONFIG_IMA_ARCH_POLICY
> > > > being enabled.
> > > > 
> > > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > > 
> > > With respect to interactions with the kernel lockdown patches, this
> > > looks better than the patches I saw previously. I don't feel like I know
> > > enough about what's going on with IMA to ack the patch, but I feel
> > > confident that it's at least not going to break signature enforcement
> > > for us.
> > 
> > Thank you for testing!  Could this be translated into a "tested-by"
> > "(for w/lockdown patches)"?
> 
> Yeah, that's fine. To be clear about what I tested, I've confirmed that
> it doesn't interfere with requiring signed modules under lockdown with
> CONFIG_IMA_ARCH_POLICY=n and IMA appraisal enabled.
> 
> Tested-by: Seth Forshee <seth.forshee@canonical.com>

Oh!  You've disabled the coordination of the two signature
verification methods.  Any chance you could test with
"CONFIG_IMA_ARCH_POLICY" enabled?

Mimi

