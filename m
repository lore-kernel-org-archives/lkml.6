Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43858C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16381217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfBEXNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 18:13:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48732 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726484AbfBEXNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 18:13:46 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x15N94k9017149
        for <linux-kernel@vger.kernel.org>; Tue, 5 Feb 2019 18:13:45 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qfgwerkq3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 18:13:44 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 5 Feb 2019 23:13:42 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 5 Feb 2019 23:13:39 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x15NDcFx2359776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Feb 2019 23:13:38 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3E664C070;
        Tue,  5 Feb 2019 23:13:37 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB9D34C064;
        Tue,  5 Feb 2019 23:13:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.107.43])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 Feb 2019 23:13:36 +0000 (GMT)
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
Date:   Tue, 05 Feb 2019 18:13:26 -0500
In-Reply-To: <20190205211337.GX11489@garbanzo.do-not-panic.com>
References: <1548962339-10681-1-git-send-email-zohar@linux.ibm.com>
         <1548962339-10681-2-git-send-email-zohar@linux.ibm.com>
         <20190204203850.GP11489@garbanzo.do-not-panic.com>
         <1549317910.4146.124.camel@linux.ibm.com>
         <20190204223026.GR11489@garbanzo.do-not-panic.com>
         <1549369479.4146.142.camel@linux.ibm.com>
         <20190205211337.GX11489@garbanzo.do-not-panic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19020523-0028-0000-0000-00000344C60B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020523-0029-0000-0000-00002402D098
Message-Id: <1549408406.4146.195.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-05_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=759 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902050169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-02-05 at 13:13 -0800, Luis Chamberlain wrote:
> Also, do we have selftests implemented to ensure we don't regress with
> your changes?

We're working on a regression test.  "modprobe" currently first
attempts to use finit_module, and then falls back to using
init_module.  Before writing a small program to load kernel modules,
are you aware of any that allows you to specify the syscall?

Mimi

