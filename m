Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753580AbeEVXmM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 19:42:12 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37617 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753563AbeEVXmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 19:42:10 -0400
X-Google-Smtp-Source: AB8JxZqmbRW7KxwJc/RD9QPR4qgenvUuldKVqIzsDopbo2OzvzVV3Rr9BHxOh2890e0GUJYKI8VidA==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 3/6] block: Create scsi_sense.h for SCSI and ATAPI
From: Jens Axboe <axboe@kernel.dk>
X-Mailer: iPhone Mail (15F5079a)
In-Reply-To: <CAGXu5j+mgGZkTDS6EDRspJKKbU=vMT4ehv9T-SekPba=ESoGDg@mail.gmail.com>
Date: Tue, 22 May 2018 17:42:06 -0600
Cc: Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Tejun Heo <tj@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
        Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
        linux-block <linux-block@vger.kernel.org>, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Message-Id: <9A0BC289-4203-4C77-A012-AAB07F42061F@kernel.dk>
References: <20180522181512.39316-1-keescook@chromium.org> <20180522181512.39316-4-keescook@chromium.org> <20180522183613.GA3784@infradead.org> <yq1efi3bk3g.fsf@oracle.com> <CAGXu5jJ0Sice+fdpWgzBhQR=NGz-DT9qmYVdV1GeH73_q9pbmw@mail.gmail.com> <732f4249-5681-4a54-ec21-4ecc3d3a74e5@kernel.dk> <20180522191309.GA23615@infradead.org> <8d4af5c4-96fa-54ee-d5c1-b887b1de5a3c@kernel.dk> <CAGXu5j+mgGZkTDS6EDRspJKKbU=vMT4ehv9T-SekPba=ESoGDg@mail.gmail.com>
To: Kees Cook <keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4MNgHCt010327

On May 22, 2018, at 5:31 PM, Kees Cook <keescook@chromium.org> wrote:
> 
>> On Tue, May 22, 2018 at 12:16 PM, Jens Axboe <axboe@kernel.dk> wrote:
>>> On 5/22/18 1:13 PM, Christoph Hellwig wrote:
>>>> On Tue, May 22, 2018 at 01:09:41PM -0600, Jens Axboe wrote:
>>>> I think Martin and Christoph are objecting to moving the code to
>>>> block/scsi_ioctl.h. I don't care too much about where the code is, but
>>>> think it would be nice to have the definitions in a separate header. But
>>>> if they prefer just pulling in all of SCSI for it, well then I guess
>>>> it's pointless to move the header bits. Seems very heavy handed to me,
>>>> though.
>>> 
>>> It might be heavy handed for the 3 remaining users of drivers/ide,
>> 
>> Brutal :-)
> 
> Heh. I noticed a similar sense buffer use in drivers/cdrom/cdrom.c
> too. Is this okay under the same considerations?

This is going from somewhat crazy to pretty nuts, imho. I guess in practical terms it doesn’t matter that much, since most folks would be using sr. I still think a split would be vastly superior. Just keep the scsi code in drivers/scsi/ and make it independently selectable.

Jens
