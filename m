Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAE0C04EBA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24462147D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24462147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbeKUWjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 17:39:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729157AbeKUWjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 17:39:24 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wALBxRei082130
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 07:05:16 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nw4wtxnh0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 07:05:16 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Wed, 21 Nov 2018 12:05:14 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 21 Nov 2018 12:05:11 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wALC5AUp58523874
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Nov 2018 12:05:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC531AE061;
        Wed, 21 Nov 2018 12:05:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 900BAAE053;
        Wed, 21 Nov 2018 12:05:10 +0000 (GMT)
Received: from localhost (unknown [9.152.212.229])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 21 Nov 2018 12:05:10 +0000 (GMT)
Date:   Wed, 21 Nov 2018 13:05:09 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH next-lockdown 0/1] debugfs EPERM fix for 'Kernel lockdown for
 secure boot' patch series
References: <4136.1522452584@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4136.1522452584@warthog.procyon.org.uk>
X-TM-AS-GCONF: 00
x-cbid: 18112112-4275-0000-0000-000002E46EEE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112112-4276-0000-0000-000037F19A45
Message-Id: <cover.thread-bfac1b.your-ad-here.call-01542799656-ext-6093@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-21_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=599 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811210107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure whom to offer the fix, since 'Kernel lockdown for secure boot'
in not upstream, but it has been picked by fedora and ubuntu. And I see
it in next-lockdown branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git

So, in addition to (prior to) opening bug reports to distributions I'm
sending this patch hoping to reach its origin from where distributions
had picked it.

Vasily Gorbik (1):
  debugfs: avoid EPERM when no open file operation defined

 fs/debugfs/file.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.18.0.13.gd42ae10

