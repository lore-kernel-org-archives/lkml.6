Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934984AbeEWVHL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 17:07:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35238 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934930AbeEWVHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 17:07:04 -0400
To: Kees Cook <keescook@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Tejun Heo <tj@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
        Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
        linux-block <linux-block@vger.kernel.org>, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] block: Create scsi_sense.h for SCSI and ATAPI
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180522183613.GA3784@infradead.org> <yq1efi3bk3g.fsf@oracle.com>
        <CAGXu5jJ0Sice+fdpWgzBhQR=NGz-DT9qmYVdV1GeH73_q9pbmw@mail.gmail.com>
        <732f4249-5681-4a54-ec21-4ecc3d3a74e5@kernel.dk>
        <20180522191309.GA23615@infradead.org>
        <8d4af5c4-96fa-54ee-d5c1-b887b1de5a3c@kernel.dk>
        <CAGXu5j+mgGZkTDS6EDRspJKKbU=vMT4ehv9T-SekPba=ESoGDg@mail.gmail.com>
        <9A0BC289-4203-4C77-A012-AAB07F42061F@kernel.dk>
        <CAGXu5jJsGWDsZNDJvUUqncSaAcvond_B_J7=BbvVW0X3r6Sxww@mail.gmail.com>
        <aa150272-ffeb-fb8f-7303-0d9502cf9a71@kernel.dk>
        <20180523142545.GA16248@infradead.org>
        <24d36869-e037-042d-cb16-20a81b34eb76@kernel.dk>
        <CAGXu5jJn=1Rz=D8VUwv_VoaGoLtaD=+tcPZxQxntweZoZwFa5Q@mail.gmail.com>
Date: Wed, 23 May 2018 17:06:02 -0400
In-Reply-To: <CAGXu5jJn=1Rz=D8VUwv_VoaGoLtaD=+tcPZxQxntweZoZwFa5Q@mail.gmail.com>
        (Kees Cook's message of "Wed, 23 May 2018 13:52:02 -0700")
Message-ID: <yq1o9h684lh.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8902 signatures=668700
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=991
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805230206
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kees,

> obj-$(CONFIG_SCSI)              += scsi/
>
> So: this needs to live in block/ just like CONFIG_BLK_SCSI_REQUEST's
> scsi_ioctl.c. I will split it into CONFIG_BLK_SCSI_SENSE, but I'll
> still need to move the code from drivers/scsi/ to block/. Is this
> okay?

The reason this sucks is that scsi_normalize_sense() is an inherent core
feature in the SCSI layer. Dealing with sense data for ioctls is just a
fringe use case.

I don't want to get too hung up on what goes where. But architecturally
it really irks me to move a core piece of SCSI state machine
functionality out of the subsystem to accommodate ioctl handling.

I'm traveling today so I probably won't get a chance to look closely
until tomorrow morning.

-- 
Martin K. Petersen	Oracle Linux Engineering
