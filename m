Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56C2C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7A020821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbfBEMY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 07:24:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728809AbfBEMY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 07:24:58 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x15CNcl8141153
        for <linux-kernel@vger.kernel.org>; Tue, 5 Feb 2019 07:24:57 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qf8q3dep9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 07:24:57 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 5 Feb 2019 12:24:54 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 5 Feb 2019 12:24:51 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x15COpx651970254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Feb 2019 12:24:51 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCD89A4055;
        Tue,  5 Feb 2019 12:24:50 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE1E0A405D;
        Tue,  5 Feb 2019 12:24:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.107.43])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 Feb 2019 12:24:49 +0000 (GMT)
Subject: Re: [PATCH] x86/ima: require signed kernel modules
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Justin Forbes <jforbes@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Date:   Tue, 05 Feb 2019 07:24:39 -0500
In-Reply-To: <20190204223026.GR11489@garbanzo.do-not-panic.com>
References: <1548962339-10681-1-git-send-email-zohar@linux.ibm.com>
         <1548962339-10681-2-git-send-email-zohar@linux.ibm.com>
         <20190204203850.GP11489@garbanzo.do-not-panic.com>
         <1549317910.4146.124.camel@linux.ibm.com>
         <20190204223026.GR11489@garbanzo.do-not-panic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19020512-0028-0000-0000-000003446B75
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020512-0029-0000-0000-000024027421
Message-Id: <1549369479.4146.142.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-05_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902050098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-02-04 at 14:30 -0800, Luis Chamberlain wrote:
> On Mon, Feb 04, 2019 at 05:05:10PM -0500, Mimi Zohar wrote:
> > On Mon, 2019-02-04 at 12:38 -0800, Luis Chamberlain wrote:

> > I don't see a need for an additional LSM just for verifying kernel
> > module signatures.
> 
> But it is one, module signing was just spawned pre the boom of LSMs.
> 
> I do believe that treating the code as such would help with its reading
> and long term maintenance.
> 
> Anyway, I had to try to convince you.

Perhaps, after IMA supports appended signatures (for kernel modules),
I could see making the existing kernel module appended signature
verification an LSM.

For now, other than updating the comment, would you be willing to add
your Review/Ack to this patch?

Mimi

