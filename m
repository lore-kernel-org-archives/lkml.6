Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DECC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 03:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2237B21019
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 03:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbeL3DeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 22:34:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725889AbeL3DeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 22:34:20 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBU3XKuM113645
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 22:34:19 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ppkxr3gew-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 22:34:19 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 30 Dec 2018 03:34:16 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 30 Dec 2018 03:34:13 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBU3YBkY6947146
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 30 Dec 2018 03:34:11 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8825011C04C;
        Sun, 30 Dec 2018 03:34:11 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1777011C05B;
        Sun, 30 Dec 2018 03:34:09 +0000 (GMT)
Received: from unknown4C3488A63DDA (unknown [9.80.105.198])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 30 Dec 2018 03:34:08 +0000 (GMT)
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
Date:   Sat, 29 Dec 2018 22:33:57 -0500
In-Reply-To: <b75fd04643daf5aab5a1fc115e8fbfca9a381f8d.camel@mniewoehner.de>
References: <ef7e773b01a5e6153b84628f74fc67092a2f9b0e.camel@gmail.com>
         <1f281756bb1f041e55be8dd090670a1a7b1d1c94.camel@mniewoehner.de>
         <1545519232.3940.115.camel@linux.ibm.com>
         <e7ec38d7cade9aa76384aa2781eab307d2cd5a7b.camel@mniewoehner.de>
         <b75fd04643daf5aab5a1fc115e8fbfca9a381f8d.camel@mniewoehner.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18123003-0020-0000-0000-000002FDDDEE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18123003-0021-0000-0000-0000214E1569
Message-Id: <1546140837.4069.81.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-29_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812300032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-25 at 14:55 +0100, Michael Niewöhner wrote:
> On Sun, 2018-12-23 at 12:55 +0100, Michael Niewöhner wrote:
> > Hi Mimi,
> > 
> > On Sat, 2018-12-22 at 17:53 -0500, Mimi Zohar wrote:
> > > On Sat, 2018-12-22 at 14:47 +0100, Michael Niewöhner wrote:
> > > 
> > > > When I remove the timeout and boot directly to the linux kernel, I get
> > > > that
> > > > "2314 TPM-self test error" since it has not finished, yet. The TPM is
> > > > detected
> > > > by IMA and works fine then.
> > > > 
> > > > Some more tests showed that any delay before booting the kernel causes the
> > > > TPM
> > > > to not get detected. I tested, 10, 15, 20, 30, 60... seconds. Only in some
> > > > very
> > > > rare cases the TPM got detected.
> > > > 
> > > > I wanted to know if the TPM is in an well initialized state at the time of
> > > > that
> > > > error. Since I was not able to get some test/debug kernel patches working
> > > > I
> > > > decided to try kexec. It turned out that the TPM is indeed correctly
> > > > working
> > > > and
> > > > will be detected just fine by linux after kexec!
> > > 
> > > No surprise here.  kexec would be the equivalent of a soft reboot.
> > 
> > Well, I am not that deep in kexec internals but isn't a soft reboot much more
> > than a kexec? I thought kexec would "just" load the new kernel to memory and
> > executes it while a soft reboot goes at least through some UEFI
> > initialization.
> > For example, my pwm fans - in fact the EC - get resetted on a soft reboot,
> > while
> > a kexec does not touch them.
> > 

Similarly, the PCRs are not reset on kexec.

> > That is why I wanted to test if there is a different behaviour on kexec
> > compared
> > to a "real" soft reboot. If there was such difference I would have assumed a
> > UEFI bug that does not initialize the TPM correctly.
> > Kexec AFAIK does not invoke any UEFI initialization, so the TPM should be in
> > the
> > same state as before kexec and since there is no difference between sr and
> > kexec
> > I have the feeling there is something wrong in the kernel.
> > 
> > Correct me if I am wrong here, please.

But the problem you've described is on a cold boot, not a soft reboot.
 Both the soft reboot and kexec are working properly.  It seems the
difference is that on a cold boot, the TPM takes longer to initialize.

> > My current workaround is to do a machine_emergency_reboot() when TPM isn't
> > detected correctly. That is a pretty hard workaround but it seems to work for
> > now...

This is a again soft reboot.

>  
> > > 
> > > > 
> > > > Is there anyone having an idea what could be wrong here? I am willing to
> > > > debug
> > > > this but I have really no idea where to start :-(
> > > 
> > > A while ago, I was "playing" with a pi.  Commenting out
> > > tpm2_do_selftest() seemed to resolve a similar problem, but that was
> > > before James' patches.  I don't know if that would make a difference
> > > now.
> > 
> > Hm, I will try that..
> > 
> 
> Unfortunately this did not change anything

Not much I can do now.  After vacation, I'll set up the pi to see if
it is working properly with a recent kernel.

Mimi

