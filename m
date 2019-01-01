Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50724C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 16:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28439218B0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 16:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbfAAQin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 11:38:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51802 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728911AbfAAQim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 11:38:42 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x01GXsg8104884
        for <linux-kernel@vger.kernel.org>; Tue, 1 Jan 2019 11:38:41 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pr6vdth4y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 11:38:40 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 1 Jan 2019 16:38:39 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 1 Jan 2019 16:38:35 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x01GcYY952101352
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Jan 2019 16:38:34 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E270542045;
        Tue,  1 Jan 2019 16:38:33 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85F2F42042;
        Tue,  1 Jan 2019 16:38:32 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.106.33])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Jan 2019 16:38:32 +0000 (GMT)
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
Date:   Tue, 01 Jan 2019 11:38:21 -0500
In-Reply-To: <0902784697eea3fc522e21a89cdecb745f12c83c.camel@mniewoehner.de>
References: <ef7e773b01a5e6153b84628f74fc67092a2f9b0e.camel@gmail.com>
         <1f281756bb1f041e55be8dd090670a1a7b1d1c94.camel@mniewoehner.de>
         <1545519232.3940.115.camel@linux.ibm.com>
         <e7ec38d7cade9aa76384aa2781eab307d2cd5a7b.camel@mniewoehner.de>
         <b75fd04643daf5aab5a1fc115e8fbfca9a381f8d.camel@mniewoehner.de>
         <1546140837.4069.81.camel@linux.ibm.com>
         <912668ea1d74f526f78f03f562fdaf17fc06f62c.camel@mniewoehner.de>
         <1546291059.4069.158.camel@linux.ibm.com>
         <0902784697eea3fc522e21a89cdecb745f12c83c.camel@mniewoehner.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19010116-0016-0000-0000-0000023E36DB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010116-0017-0000-0000-0000329737F8
Message-Id: <1546360701.4069.168.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-01_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=902 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901010152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-01 at 17:15 +0100, Michael Niewöhner wrote:
> On Mon, 2018-12-31 at 16:17 -0500, Mimi Zohar wrote:
> > On Sun, 2018-12-30 at 14:22 +0100, Michael Niewöhner wrote:
> > 
> > > > difference is that on a cold boot, the TPM takes longer to initialize.
> > > 
> > > Well, as I said. Waiting for 10, 20 or even 60 seconds in the boot manager
> > > does
> > > not solve the problem. So the problem is NOT that the TPM takes longer to
> > > initialize. Even adding a delay of 20 seconds before TPM init does not solve
> > > that while that should be more than enough time.
> > 
> > The purpose of commenting out the TPM2 selftest was to minimize the
> > TPM initialization delay, so that the TPM is ready before IMA.  After
> > James' patch that wasn't needed anymore.
> > 
> > Looking back at this thread, I see you're using systemd-boot, not
> > grub2.  When you commented out the systemd-boot timeout, IMA found the
> > TPM.  The question is why isn't the TPM ready with the timeout before
> > IMA (like above)?  Has systemd-boot done the selftest?
> 
> I am not sure wether systemd-boot touches TPM at all but I get the same
> behaviour with syslinux-efi.

From looking at the source code, it depends on whether systemd was
compiled with ENABLE_TPM enabled(eg. src/boot/efi/boot.c,
src/boot/efi/measure.c, src/boot/efi/stub.c).

Mimi

