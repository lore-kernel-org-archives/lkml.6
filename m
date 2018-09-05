Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFD3C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12110206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12110206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeIEU7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 16:59:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:38507 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbeIEU7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 16:59:15 -0400
Received: from homer.simpson.net ([185.191.218.38]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ldbqw-1fXutU0RHO-00imjs; Wed, 05
 Sep 2018 18:28:10 +0200
Message-ID: <1536164889.4611.8.camel@gmx.de>
Subject: Re: [regression/bisected] 4.19 cycle boot time IO stalls
From:   Mike Galbraith <efault@gmx.de>
To:     Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Date:   Wed, 05 Sep 2018 18:28:09 +0200
In-Reply-To: <178d6adc-2a79-99dc-daa8-fb0ed9f0afd1@kernel.dk>
References: <1536137722.4813.66.camel@gmx.de>
         <178d6adc-2a79-99dc-daa8-fb0ed9f0afd1@kernel.dk>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:f6HOeT+c2cfKwvRMFp+xeXbX9INJEXd4rtUsfkTT8+DHnaAK6Kn
 xwEDttCd3+uOCrmNppfzSzDUGPEKDcJyAtM2AbHDIdJwxkE5EdZ44SlDH3zjx2fXb7pucwt
 qmDYDQ9Ly912m2KxvTNSyeqFVUKXWjvddbb2ffz5SwJ/LCfvAPODu6b4F7FY4h7ufymsP6e
 E3Oic79m5fzTvKig3ce2g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cUEcnunO+p4=:8CYl41AW1FYAQmFdX9m9uK
 n/Jno6zVS49GOzrwPT0b8Bbnz2kxvq8+oY9TomoomWkJHQbezJFrpgEMDzTnFP2ei+ZuyeYRQ
 2Q5rGAfuXSrgEF7jS2G9AZbOrIszjwqiLljyUGyUzqVwWbFEfHJkhC6rj5DEbknCV+NWvGSrw
 F6sVwUWoAW4KowM1TsHLwXfJzPXpC6ohJ4KxYYzLjMDW1gt0zMIm6r0DJl0xSy5zGIMIPU6O+
 DcW5P9b6ML8fLeNiGycMVp+TkdX32yEWNX7rPvU9x/k1teRfpgseHl6NHojG1ZrnoAGftPh/O
 0fEwDtj2Pjo5bp3c9wagcWDA8IVHTBI80uUnHgml0Sgdv9Ul5H/NYC+/NxQox4xHCZfX6lCEP
 cdgGRPCTY+FAXJUWkKRW/DXGZYA/LuAHW7WVRLJ9owPHKV8ydPDtPIHOj7yrjJ7n4PiTx8w2K
 mY9/aIx9zdR1nJhWQBg+wvRPUOp61rc4btWTi3FyC8Tj/7p0xbfLXQ4vRdRusyKshpWpGMA4y
 4lgzdMrUNefFdnumz2eC8GTKO1Z4AkymGUSyAQrrXSGxf5paSerIRDtAGxbzz3+H5yKs2DLqh
 Bz16H+DVV/ImZOnWGr9q8/jV08C47OVm5Iqcgkwn/5ZjX9i7CnphJlo4ZNKj22DFaI4LZNRUf
 T7BniXNqjbEKWVaCbhDUVOdXf+J2P8UXq47qVJ5xCoTILtlCZidlNs9kGC1j8K7OSf3LprQxv
 84rG7olc5XCb4KnTSMWHB5g/MJEbYHwDZX/4v35RjqYdwIbl6ryx/A8x/0knG8ONnpwvUa9Ik
 eU/exA3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-09-05 at 07:39 -0600, Jens Axboe wrote:
> 
> I bet it's the host busy change from Ming, which I already
> reported as being the culprit for another test failure I had. For
> some reason it's not merged yet, nudge nudge Martin. You can test
> by reverting:
> 
> commit 328728630d9f2bf14b82ca30b5e47489beefe361
> Author: Ming Lei <ming.lei@redhat.com>
> Date:   Sun Jun 24 22:03:27 2018 +0800
> 
>     scsi: core: avoid host-wide host_busy counter for scsi_mq
> 
> which was slightly modified by 265d59aacbce, so you'll want to
> yank that one first.

Bingo (woohoo, no dog slow take 2 required).

> BTW, that suse email for me hasn't worked in 12 years :-)

Yeah, I must have double tapped mouse, and picked up one of the many
ancient artifacts in Evolution's DB.  Sorry about that.

	-Mike
