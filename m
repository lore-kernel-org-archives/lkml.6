Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAB8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B70D20836
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731669AbfAKPkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:40:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43686 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729463AbfAKPkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:40:46 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0BFTKM5016706
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 10:40:45 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pxupd045a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 10:40:44 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 11 Jan 2019 15:40:43 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 11 Jan 2019 15:40:39 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0BFedL443778098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 15:40:39 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F28DA5204E;
        Fri, 11 Jan 2019 15:40:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.91.13])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3F07152050;
        Fri, 11 Jan 2019 15:40:38 +0000 (GMT)
Subject: Re: [BUG] Nuvoton NCPT650 TPM 2.0 mode not working
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
Cc:     jarkko.sakkinen@linux.intel.com, linux-integrity@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 11 Jan 2019 10:40:27 -0500
In-Reply-To: <e8eb56fdab618770917fbe5b174328dc1240f934.camel@mniewoehner.de>
References: <776f384a81466642472beb4a34b10f26f1de88e9.camel@mniewoehner.de>
         <1541960689.3190.4.camel@HansenPartnership.com>
         <e8eb56fdab618770917fbe5b174328dc1240f934.camel@mniewoehner.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19011115-0008-0000-0000-000002AF9074
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011115-0009-0000-0000-0000221B9B19
Message-Id: <1547221227.19931.453.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-11_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901110128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Sun, 2018-11-11 at 19:50 +0100, Michael Niewöhner wrote:

> Well, there are at least two implementations I know of:
> For my Lenovo X260 I can choose between Infineon TPM 1.2 or Intel PTT TPM 2.0
> This here is my ThinkStation P320 which can choose between PTT 1.2, PTT 2.0,
> Nuvoton 1.2 and 2.0. When switchting between 1.2 and 2.0 the Nuvoton gets
> reflashed with the appropriate firmware.

With IBM's LTC help, we finally found a Lenovo with the Nuvoton
NCPT650.  It's a System x3550 M5[1], not a ThinkStation P320, running
Fedora (vmlinuz-4.16.14-300.fc28.x86_64). I replaced the 4.16 kernel
with the latest stable 4.19.y kernel.  Both the TPM and IMA seem to be
working properly.  Not sure if this helps...

From dmesg:
# dmesg | grep -i tpm 
[    0.000000] Linux version 4.19.14 (mimi@x86tpm2Server.rtp.stglabs.i
bm.com) (gcc version 8.1.1 20180502 (Red Hat 8.1.1-1) (GCC)) #6 SMP
Thu Jan 10 22:32:54 EST 2019
[    0.000000] efi:  ACPI=0x7b786000  ACPI 2.0=0x7b786014 
SMBIOS=0x793fe000  TPMEventLog=0x426fa018 
[    0.014413] ACPI: SSDT 0x000000007B784000 0003A7 (v02 INTEL 
Tpm2Tabl 00001000 INTL 20130328)
[    0.014416] ACPI: TPM2 0x000000007B783000 000034 (v03 INTEL  EDK2  
  00000002 INTL 01000013)
[    2.667052] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2

# cat /sys/kernel/security/ima/ascii_runtime_measurements | head -2
10 5425744ce804c8cae89a08d53b41ab20ff1b3ea6 ima-sig
sha1:7996f7339c3ce64e63f1232ef1aa6033247af784 boot_aggregate

I installed the ibmtpm2tss[2], built (eg. autoreconf -i; configure --
enable-hwtpm) and installed it.

# export LD_LIBRARY_PATH=/usr/local/lib/
# cd /usr/local/bin
# ./tsspcrread -ha 10 -halg sha256 -ns
f73ff9109b06d4f7a7cbe7eac32b20d2ca662e55cb4c81e152beea261989ad4b

Mimi

[1] https://lenovopress.com/lp0599.pdf
[2] https://git.code.sf.net/p/ibmtpm20tss/tss

