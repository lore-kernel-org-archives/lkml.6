Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57E1C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD20521479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbfACLqV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 06:46:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56348 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730181AbfACLqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 06:46:21 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x03BinGX122523
        for <linux-kernel@vger.kernel.org>; Thu, 3 Jan 2019 06:46:20 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2psguw2hkw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 06:46:19 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 3 Jan 2019 11:46:18 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 3 Jan 2019 11:46:15 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x03BkEYw10879144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Jan 2019 11:46:15 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D451BA4068;
        Thu,  3 Jan 2019 11:46:14 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A49F7A4064;
        Thu,  3 Jan 2019 11:46:14 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  3 Jan 2019 11:46:14 +0000 (GMT)
Date:   Thu, 3 Jan 2019 12:46:13 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Martin KaFai Lau <kafai@fb.com>,
        Eugene Syromyatnikov <evgsyr@gmail.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: "bpf: Improve the info.func_info and info.func_info_rec_size
 behavior" breaks strace self tests
X-TM-AS-GCONF: 00
x-cbid: 19010311-0020-0000-0000-000002FFF5B6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010311-0021-0000-0000-0000214FFF0C
Message-Id: <20190103114613.GB3957@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-03_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=487 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901030105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the kernel commit 7337224fc150 ("bpf: Improve the info.func_info and
info.func_info_rec_size behavior") breaks one of strace's self tests:

FAIL: bpf-obj_get_info_by_fd-prog-v.gen

Looking into the kernel commit, it seems that the user space visible
uapi change is intentional; even though it might break existing user
space.

To reproduce:

git clone https://gitlab.com/strace/strace.git
cd strace
./bootstrap
./configure
make -j $(nproc)
cd tests
make -j $(nproc) check

