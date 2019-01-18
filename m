Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BD4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B7F2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfARBxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 20:53:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57706 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726329AbfARBxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 20:53:13 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0I1iU4v142410
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 20:53:12 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q35cg8fbq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 20:53:12 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 18 Jan 2019 01:53:10 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 18 Jan 2019 01:53:06 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0I1r4H53277276
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Jan 2019 01:53:04 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7E2DA405B;
        Fri, 18 Jan 2019 01:53:04 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03B41A4054;
        Fri, 18 Jan 2019 01:53:03 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.91.65])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Jan 2019 01:53:02 +0000 (GMT)
Subject: Re: [PATCH v3 0/2] let kexec_file_load use platform keyring to
 verify the kernel image
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Dave Young <dyoung@redhat.com>
Cc:     Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, dwmw2@infradead.org,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com,
        ebiggers@google.com, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Date:   Thu, 17 Jan 2019 20:52:52 -0500
In-Reply-To: <20190118013530.GA2814@dhcp-128-65.nay.redhat.com>
References: <20190116101654.7288-1-kasong@redhat.com>
         <1547773684.4026.10.camel@linux.ibm.com>
         <20190118013530.GA2814@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19011801-4275-0000-0000-00000300B820
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011801-4276-0000-0000-0000380EDEBD
Message-Id: <1547776372.3982.1.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-18_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=882 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901180012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-18 at 09:35 +0800, Dave Young wrote:
> On 01/17/19 at 08:08pm, Mimi Zohar wrote:

> > It's taken so long for me to review/test this patch set due to a
> > regression in sanity_check_segment_list(), introduced somewhere
> > between 4.20 and 5.0.0-rc1.  The sgement overlap test - "if ((mend >
> > pstart) && (mstart < pend))" - fails, returning a -EINVAL.
> > 
> > Is anyone else seeing this?
> 
> Mimi, should be this issue?  I have sent a fix for that.
> https://lore.kernel.org/lkml/20181228011247.GA9999@dhcp-128-65.nay.redhat.com/

Thanks, that resolved the regression.

Mimi

