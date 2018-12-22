Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67434C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 22:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401E921934
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 22:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392890AbeLVWyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 17:54:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33280 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731424AbeLVWyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 17:54:12 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBMMmWs2024358
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 17:54:11 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2phgfswn8w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 17:54:11 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sat, 22 Dec 2018 22:54:09 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 22 Dec 2018 22:54:06 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBMMs5Bw60948554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 22 Dec 2018 22:54:05 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5D1A4C046;
        Sat, 22 Dec 2018 22:54:04 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 830CD4C040;
        Sat, 22 Dec 2018 22:54:03 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.106.35])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 22 Dec 2018 22:54:03 +0000 (GMT)
Subject: Re: tpm_tis TPM2.0 not detected on cold boot
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        peterhuewe@gmx.de, jgg@ziepe.ca, arnd@arndb.de,
        linux-integrity@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Ken Goldman <kgold@linux.ibm.com>
Date:   Sat, 22 Dec 2018 17:53:52 -0500
In-Reply-To: <1f281756bb1f041e55be8dd090670a1a7b1d1c94.camel@mniewoehner.de>
References: <ef7e773b01a5e6153b84628f74fc67092a2f9b0e.camel@gmail.com>
         <1f281756bb1f041e55be8dd090670a1a7b1d1c94.camel@mniewoehner.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18122222-4275-0000-0000-000002F46558
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18122222-4276-0000-0000-0000380275FC
Message-Id: <1545519232.3940.115.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-22_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=927 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812220207
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-12-22 at 14:47 +0100, Michael Niewöhner wrote:

> When I remove the timeout and boot directly to the linux kernel, I get that
> "2314 TPM-self test error" since it has not finished, yet. The TPM is detected
> by IMA and works fine then.
> 
> Some more tests showed that any delay before booting the kernel causes the TPM
> to not get detected. I tested, 10, 15, 20, 30, 60... seconds. Only in some very
> rare cases the TPM got detected.
> 
> I wanted to know if the TPM is in an well initialized state at the time of that
> error. Since I was not able to get some test/debug kernel patches working I
> decided to try kexec. It turned out that the TPM is indeed correctly working and
> will be detected just fine by linux after kexec!

No surprise here.  kexec would be the equivalent of a soft reboot.

> 
> Is there anyone having an idea what could be wrong here? I am willing to debug
> this but I have really no idea where to start :-(

A while ago, I was "playing" with a pi.  Commenting out
tpm2_do_selftest() seemed to resolve a similar problem, but that was
before James' patches.  I don't know if that would make a difference
now.

Mimi

