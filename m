Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752176AbeEVTJr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 15:09:47 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:41363 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752075AbeEVTJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 15:09:44 -0400
X-Google-Smtp-Source: AB8JxZp3QZBTeo6vIjISTtRAu1JPdXy1hGbmswV7YDSBGhOPCo7C8Vd6rnP1xxbXDMwjGw2TscCoZA==
Subject: Re: [PATCH 3/6] block: Create scsi_sense.h for SCSI and ATAPI
To: Kees Cook <keescook@chromium.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Tejun Heo <tj@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
        Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
        linux-block <linux-block@vger.kernel.org>, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20180522181512.39316-1-keescook@chromium.org>
 <20180522181512.39316-4-keescook@chromium.org>
 <20180522183613.GA3784@infradead.org> <yq1efi3bk3g.fsf@oracle.com>
 <CAGXu5jJ0Sice+fdpWgzBhQR=NGz-DT9qmYVdV1GeH73_q9pbmw@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <732f4249-5681-4a54-ec21-4ecc3d3a74e5@kernel.dk>
Date: Tue, 22 May 2018 13:09:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJ0Sice+fdpWgzBhQR=NGz-DT9qmYVdV1GeH73_q9pbmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/18 12:59 PM, Kees Cook wrote:
> On Tue, May 22, 2018 at 11:50 AM, Martin K. Petersen
> <martin.petersen@oracle.com> wrote:
>>
>> Christoph,
>>
>>> On Tue, May 22, 2018 at 11:15:09AM -0700, Kees Cook wrote:
>>>> Both SCSI and ATAPI share the sense header. In preparation for using the
>>>> struct scsi_sense_hdr more widely, move this into a separate header and
>>>> move the helper function to scsi_ioctl.c which is linked with CONFIG_IDE
>>>> by way of CONFIG_BLK_SCSI_REQUEST.
>>>
>>> Please keep the code where it is and just depend on SCSI on the legacy
>>> ide driver.  No need to do gymnastics just for a legacy case.
>>
>> Yup, I agree.
> 
> Oh, er, this was mainly done at Jens's request. Jens, can you advise?

I think Martin and Christoph are objecting to moving the code to
block/scsi_ioctl.h. I don't care too much about where the code is, but
think it would be nice to have the definitions in a separate header. But
if they prefer just pulling in all of SCSI for it, well then I guess
it's pointless to move the header bits. Seems very heavy handed to me,
though.

-- 
Jens Axboe
