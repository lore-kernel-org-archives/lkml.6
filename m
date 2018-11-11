Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B3FC0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3CDE20871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3CDE20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbeKLEXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 23:23:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729390AbeKLEXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 23:23:11 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABISvnh137749
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 13:33:55 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2npde80083-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 13:33:55 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 11 Nov 2018 18:33:52 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 18:33:48 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABIXl2E6357490
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 18:33:48 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFA744C044;
        Sun, 11 Nov 2018 18:33:47 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E09D34C040;
        Sun, 11 Nov 2018 18:33:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.88.36])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 18:33:46 +0000 (GMT)
Subject: Re: [BUG] Nuvoton NCPT650 TPM 2.0 mode not working
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>,
        peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        arnd@arndb.de, linux-integrity@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sun, 11 Nov 2018 13:33:36 -0500
In-Reply-To: <776f384a81466642472beb4a34b10f26f1de88e9.camel@mniewoehner.de>
References: <776f384a81466642472beb4a34b10f26f1de88e9.camel@mniewoehner.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18111118-0020-0000-0000-000002E65700
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111118-0021-0000-0000-000021355932
Message-Id: <1541961216.3734.60.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-11-11 at 18:55 +0100, Michael Niewöhner wrote:
> Hi all,
> 
> Nuvoton NCPT650 does not work in TPM 2.0 mode with tpm_tis / tpm_i2c_nuvoton
> while it works in TPM 1.2 mode (I can reflash it via UEFI setup).
> Kernel version is 4.19.1
> 
> Kernel config:
> 
> $ cat .config | egrep 'TCG|TPM|CRB|_TIS'
> CONFIG_TCG_TPM=y
> CONFIG_HW_RANDOM_TPM=y
> CONFIG_TCG_TIS_CORE=y
> CONFIG_TCG_TIS=y
> CONFIG_TCG_TIS_SPI=y
> # CONFIG_TCG_TIS_I2C_ATMEL is not set
> # CONFIG_TCG_TIS_I2C_INFINEON is not set
> CONFIG_TCG_TIS_I2C_NUVOTON=y
> # CONFIG_TCG_NSC is not set
> # CONFIG_TCG_ATMEL is not set
> # CONFIG_TCG_INFINEON is not set
> CONFIG_TCG_CRB=y
> # CONFIG_TCG_VTPM_PROXY is not set
> # CONFIG_TCG_TIS_ST33ZP24_I2C is not set
> # CONFIG_TCG_TIS_ST33ZP24_SPI is not set
> 
> 
> TPM 1.2 mode dmesg:
> 
> $ dmesg | egrep -i tis\|tpm\|crb
> [    3.210040] tpm_tis 00:0a: 1.2 TPM (device-id 0xFE, rev-id 2)
> 
> 
> TPM 2.0 mode dmesg:
> 
> $ dmesg | egrep -i tis\|tpm\|crb
> [    0.000000] efi:  ACPI
> 2.0=0x9e457000  ACPI=0x9e457000  SMBIOS=0x9ec44000  SMBIOS
> 3.0=0x9ec43000  TPMEventLog=0x9711f018 
> [    0.003517] ACPI: TPM2 0x000000009E490ED8 000034 (v03 LENOVO TC-
> S06   00001300 AMI  00000000)
> [    4.071550] ima: No TPM chip found, activating TPM-bypass!

It's possible that eventually the TPM is initialized, but not in time
for IMA.  Could you you check to see if the TPM is responding to
userspace commands after boot?

Mimi

