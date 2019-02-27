Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7610FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBEB2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbfB0SiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 13:38:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60308 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726894AbfB0SiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 13:38:10 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1RITPun016232
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 13:38:09 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qwwcufykh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 13:38:08 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 27 Feb 2019 18:38:07 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Feb 2019 18:38:05 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1RIc4Qh32047282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Feb 2019 18:38:04 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 085A2A4064;
        Wed, 27 Feb 2019 18:38:04 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4125DA405B;
        Wed, 27 Feb 2019 18:38:03 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.106.105])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 27 Feb 2019 18:38:03 +0000 (GMT)
Subject: Re: [PATCH v2 5/5] selftests/ima: loading kernel modules
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     shuah <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Vorel <pvorel@suse.cz>
Date:   Wed, 27 Feb 2019 13:37:52 -0500
In-Reply-To: <ab45b574-4791-d42a-f566-ab9886525549@kernel.org>
References: <1551223620-11586-1-git-send-email-zohar@linux.ibm.com>
         <1551223620-11586-6-git-send-email-zohar@linux.ibm.com>
         <19d494c6-ecb1-b884-2d23-5f556b3ec05b@kernel.org>
         <1551276893.10911.23.camel@linux.ibm.com>
         <ab45b574-4791-d42a-f566-ab9886525549@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022718-0020-0000-0000-0000031C0659
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022718-0021-0000-0000-0000216D7446
Message-Id: <1551292672.10911.68.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=741 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902270125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> >>> +get_secureboot_mode
> >>> +if [ $? -eq 0 ]; then
> >>> +	log_skip "secure boot not enabled"
> >>> +fi
> >>> +
> >>> +# get the kernel config
> >>> +get_kconfig
> >>> +
> >>
> >> get_kconfig() will be good candidate as a kselftest common
> >> function. Is that possible?
> > 
> > Sure, where would it go?  get_kconfig calls log_skip.  I didn't see
> > any common logging functions.  Petr suggested defining a set of common
> > logging functions.  Did you want to only make "log_skip" a common
> > function or the other logging functions log_pass, log_fail, log_info
> > as well?
> > 
> 
> We can do this as a separate effort in the interest of getting these
> in the interest of getting these in.
> 
> We have common functions in ksefltest.h for c and we don't have them
> for tests scripts. We might be able to collect common routines such
> as get_kconfig into a common .sh and include in tests. If you have time
> to do this, that will be great. It can be done as a separate effort.

Ok.  For now, I'm waiting for some review/ack's.

Mimi

