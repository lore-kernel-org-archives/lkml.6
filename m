Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE94C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6197D214C6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tYwtX7DM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbfAKAEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 19:04:32 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34010 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfAKAEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 19:04:31 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0ANxYf1119863;
        Fri, 11 Jan 2019 00:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=rtTNP9p660wD1/V/TubZtqh4R3npzHoGwQ9jTS3YdV4=;
 b=tYwtX7DMqr3FJaocZgOcz0czeDWSzp1GVSvpCwKl5jlfgx9/SZPrJ46bHd230nS/m/3A
 XjZw7GLR8rEdxG9p7l/px6A5mfSd+3uHWYW/Qf7HfMM9ohe9rrWyDUtFC85us5wWLGFr
 rC/0VeCfraixTGwZlQGi2JnaT4KhNyJGQPsXQbFXZ7KiDyK5eRqalRsmBBSb/LzlKg5N
 c1zX777zLQLoMoLIsxWUKZCv2I56fct8iIVF0vxgdvSB43I8yBXcP4Ep818dA6AH7V1S
 Rk+iwyE/UN3ewc4gZ8OSVtlrQNG8lzNEhdyqSkQFDkOkIzigyZYu2HWVbUUB72XJ8Vsg LQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2ptn7ra1j1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jan 2019 00:02:29 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0B02SSs008104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jan 2019 00:02:28 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0B02RYl019346;
        Fri, 11 Jan 2019 00:02:28 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Jan 2019 16:02:27 -0800
To:     james harvey <jamespharvey20@gmail.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        martin.petersen@oracle.com, jaxboe@fusionio.com
Subject: Re: Interpreting /sys/block/<disk>/{,<partition>}/discard_alignment
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <CA+X5Wn4s2_zEvAHzT+dXToht=TBCyqBxVVnOPCrSTa_=_sxV6g@mail.gmail.com>
Date:   Thu, 10 Jan 2019 19:02:25 -0500
In-Reply-To: <CA+X5Wn4s2_zEvAHzT+dXToht=TBCyqBxVVnOPCrSTa_=_sxV6g@mail.gmail.com>
        (james harvey's message of "Wed, 9 Jan 2019 20:25:22 -0500")
Message-ID: <yq14lag12pa.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9132 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901100181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


James,

> Q1 - I'm hoping you can clarify how this should be interpreted.
>
> I originally took this to mean the number of bytes into the first
> discard_granularity block that the partition resides at.  i.e.  If
> discard_granularity_block is 128MB, and partition 1 starts at sector
> 2048 with 512 byte sectors, that this should return 2048*512=1048576
> (1MB.)

The alignment offset is the offset for the given block device. It
doesn't matter whether the block device in question is a partition, DM
device or a full device. A block device is a block device.

The common alignment scenario is 3584 on a device with 4K physical
blocks. That's because of the 63-sector legacy FAT partition table
offset. Which essentially means that the first LBA is misaligned and the
first aligned HBA is 7.

Many of the first 512e drives shipped with that intentional misalignment
as default. And you could switch it to 0-aligned via a jumper. These
days all drives are 0-aligned.

> Q2 - At https://lkml.org/lkml/2018/12/5/1693 --- I saw you recently
> said "... there are not many devices that actually report a non-zero
> discard alignment..."  Does this mean that every filesystem needs to
> look at the partition table to determine its correct value on its own,
> rather than using discard_alignment?

No, it needs to look at the device topology for the block device it is
on. I don't believe we ever wired up an ioctl for the discard alignment
so you'll have to find your device in sysfs. There's an alignment ioctl
for the "regular" block alignment, though.

-- 
Martin K. Petersen	Oracle Linux Engineering
