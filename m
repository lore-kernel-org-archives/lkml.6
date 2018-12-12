Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72750C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 04:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F5920811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 04:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F5920811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbeLLELT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 23:11:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41638 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726220AbeLLELS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 23:11:18 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBC49bJX147408
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 23:11:17 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2par3qp0uy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 23:11:17 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <chandan@linux.vnet.ibm.com>;
        Wed, 12 Dec 2018 04:11:15 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Dec 2018 04:11:11 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBC4BAOt49741926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Dec 2018 04:11:10 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6461EAE051;
        Wed, 12 Dec 2018 04:11:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54BC1AE053;
        Wed, 12 Dec 2018 04:11:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.35.96])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 12 Dec 2018 04:11:08 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.vnet.ibm.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org
Subject: Re: [BUG BISECT next] Files cannot be opened after "fsverity: Move verity status check to fsverity_file_open"
Date:   Wed, 12 Dec 2018 09:41:18 +0530
Organization: IBM
In-Reply-To: <20181211174116.GB221175@gmail.com>
References: <CAJKOXPdNS+Qs6t1GwrgYhWT5EbtORJwYMzSrDPf8oAxv7ndNBg@mail.gmail.com> <20181211174116.GB221175@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 18121204-4275-0000-0000-000002EF46FD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121204-4276-0000-0000-000037FC672B
Message-Id: <3791832.MWVI2j2YUV@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-12_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812120033
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, December 11, 2018 11:11:17 PM IST Eric Biggers wrote:
> On Tue, Dec 11, 2018 at 03:15:53PM +0100, Krzysztof Kozlowski wrote:
> > Hi,
> > 
> > Bisect from today's next pointed me to:
> > commit 4de97efb578a094e8fbf279522d41eb9ece1e3e0
> > Author: Chandan Rajendra <chandan@linux.vnet.ibm.com>
> > Date:   Sat Dec 8 12:21:43 2018 +0530
> >     fsverity: Move verity status check to fsverity_file_open
> > 
> > as a reason of "Operation not supported" when reading any file from
> > mounted ext4fs (from SD card). Rootfs from nfsroot works but reading
> > from /home with ext4fs fails.
> > 
> > Mounts:
> > 192.168.1.10:/srv/nfs/odroidhc1 on / type nfs4
> > (rw,relatime,vers=4.0,rsize=131072,wsize=131072,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=192.168.1.12,local_lock=none,addr=192.168.1.10)
> > /dev/mmcblk0p2 on /home type ext4 (rw,relatime)
> > 
> > Configuration:
> > 1. Arch ARM Linux
> > 2. exynos_defconfig
> >   - All my Odroid boards (ARMv7, Exynos)
> >     Systemd: v239, v238
> > 3. All boards boot from TFTP with NFS root (NFSv4)
> > No specific errors in boot log:
> > https://krzk.eu/#/builders/21/builds/1034/steps/12/logs/serial0
> > 
> > Let me know if you need any more data.
> > 
> > Best regards,
> > Krzysztof
> 
> Thanks Krzysztof.  Ted, this is the same bug I pointed out in my review of this
> patch yesterday (https://patchwork.kernel.org/patch/10719197/#22371523).  Can
> you fix or revert the two broken patches?  Thanks,
> 

Hi,

I have sent version V4 of the patchset now. My plan was to include the fix for
"Kconfig recursive dependency" issue reported for IA64 architecture. But I
would need some more time to understand the problem and provide a correct
fix. Hence the V4 patchset was sent with a fix to only address the problem
reported in this mail.

-- 
chandan



