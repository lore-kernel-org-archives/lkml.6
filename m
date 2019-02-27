Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33216C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D51A2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbfB0OPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:15:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729848AbfB0OPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:15:12 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1REE6x7142330
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 09:15:11 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qwuva11w2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 09:15:10 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 27 Feb 2019 14:15:09 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Feb 2019 14:15:05 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1REF4oN27197516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Feb 2019 14:15:04 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6C3942042;
        Wed, 27 Feb 2019 14:15:04 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A558042041;
        Wed, 27 Feb 2019 14:15:03 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.106.105])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 27 Feb 2019 14:15:03 +0000 (GMT)
Subject: Re: [PATCH v2 5/5] selftests/ima: loading kernel modules
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     shuah <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Vorel <pvorel@suse.cz>
Date:   Wed, 27 Feb 2019 09:14:53 -0500
In-Reply-To: <19d494c6-ecb1-b884-2d23-5f556b3ec05b@kernel.org>
References: <1551223620-11586-1-git-send-email-zohar@linux.ibm.com>
         <1551223620-11586-6-git-send-email-zohar@linux.ibm.com>
         <19d494c6-ecb1-b884-2d23-5f556b3ec05b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022714-0012-0000-0000-000002FADB80
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022714-0013-0000-0000-00002132839F
Message-Id: <1551276893.10911.23.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902270096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

> > diff --git a/tools/testing/selftests/ima/test_kernel_module.sh b/tools/testing/selftests/ima/test_kernel_module.sh
> > new file mode 100755
> > index 000000000000..4009e1b60b03
> > --- /dev/null
> > +++ b/tools/testing/selftests/ima/test_kernel_module.sh
> > @@ -0,0 +1,96 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> 
> Same here
> 
> # SPDX-License-Identifier: GPL-2.0

Sure, I'll make the change here and in the other places.


> > +get_secureboot_mode
> > +if [ $? -eq 0 ]; then
> > +	log_skip "secure boot not enabled"
> > +fi
> > +
> > +# get the kernel config
> > +get_kconfig
> > +
> 
> get_kconfig() will be good candidate as a kselftest common
> function. Is that possible?

Sure, where would it go?  get_kconfig calls log_skip.  I didn't see
any common logging functions.  Petr suggested defining a set of common
logging functions.  Did you want to only make "log_skip" a common
function or the other logging functions log_pass, log_fail, log_info
as well?

Thanks,

Mimi

