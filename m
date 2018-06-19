Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90025C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4783C20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7zJPbGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4783C20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030361AbeFSRlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:41:40 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41799 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030242AbeFSRli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:41:38 -0400
Received: by mail-lf0-f66.google.com with SMTP id d24-v6so751892lfa.8;
        Tue, 19 Jun 2018 10:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HgRhM9AaleTo4Djg+8R1yt02pVFmI3wEuCaOcqSW5XQ=;
        b=S7zJPbGbNX8B+qb4IhwzE7h920i3/v19+lRBaKXyWlsgLYdiVqKPUpSINo+v3LRbQF
         5Aa5MROr8tFcZbkuss/J0Gg1IAzxAG+5FEGquDLHtPVWSRIE+UtkKs1PGc3UBpLObd2k
         Q6hdthF0UkoH6VwKeeMP6AK/uCJQg1UkNcGF1LPhYliomcUqeL6IvuQtWVwauNngM1U5
         RHvpZNDIBzFBANuMmNhZE0K3mtrF879rmevLdCVUpej9LmshgQiwY+MwJi9dAR1RkSPw
         QKB8k/nFfsImi24lIu8oblSv2/GCoJGyZ2pu8T+T1fQ+WHQgb6r8CW1F0MYPTIfNrSHd
         eeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HgRhM9AaleTo4Djg+8R1yt02pVFmI3wEuCaOcqSW5XQ=;
        b=f1R0Pjruqxj3Z4zba+WD4QgZBVfsTiydv1GKX1PCwxVADrOBhDINpTbRARPsn30x2s
         QN9u+PxgesRWQM3TFHkE4jt30LFHgsLPVw4UzhCgwctJygoq4LW0sVpL7M9kaKwe8Tyc
         tC+mKo+mkKZ5O8dbzphoKHQRovWZhRebxqP7I5TvJ9a0F9XnZrwcXWcF6bK5VlUgWGah
         eNkO38xYAdVmpf22L74YOeviqA0bCwJnop+ZgAG1Jh5dl18gFWmifMU2l2ccUU4qM8rZ
         L5mL04gO21Zlg0vGG+ejE5VqZxQh45mRt1Yd5bavcBfySQYIaAL1M6DB62IUPckOjhFU
         la0A==
X-Gm-Message-State: APt69E0qZR8kUlQZ3Gl4UwS6bHT7mJyu9ic9oluF0AT01mOSXz+cPAGd
        7X/UFvilMmRJ16C1Hu98PpO+ab33Sj7R7oUl6Tg=
X-Google-Smtp-Source: ADUXVKIg27iFM9KvZZ7D1/BmIGOLx1eTpHpA/g3vkjNs9TFjFI7HDiUuUuCelg9Tj6OYOZaefwkzpyiPFqnmarsoSEw=
X-Received: by 2002:a2e:93c9:: with SMTP id p9-v6mr12171373ljh.117.1529430096547;
 Tue, 19 Jun 2018 10:41:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b43:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 10:41:35
 -0700 (PDT)
In-Reply-To: <1E0C8AFA-5168-4916-932E-8E1C3F0EADE6@linux.vnet.ibm.com>
References: <20180611194204.GA18687@jordon-HP-15-Notebook-PC>
 <20180613232347.GA3851@p8tul1-build.aus.stglabs.ibm.com> <CAFqt6zb-fDRdH1_k7QwW_YEErKYPYFNpJFrK7N82P0PLiKnRtA@mail.gmail.com>
 <1E0C8AFA-5168-4916-932E-8E1C3F0EADE6@linux.vnet.ibm.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 19 Jun 2018 23:11:35 +0530
Message-ID: <CAFqt6zbgaqVxAVcX+ryzP5-qDDZs+Z1rNrY4mHhwr=THO++5Vg@mail.gmail.com>
Subject: Re: [PATCH] scsi: cxlflash: Change return type for fault handler
To:     Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Cc:     "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        brajeswar.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 7:41 PM, Uma Krishnan
<ukrishn@linux.vnet.ibm.com> wrote:
>
>
>> On Jun 19, 2018, at 12:10 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>
>> On Thu, Jun 14, 2018 at 4:53 AM, Matthew R. Ochs
>> <mrochs@linux.vnet.ibm.com> wrote:
>>> On Tue, Jun 12, 2018 at 01:12:04AM +0530, Souptick Joarder wrote:
>>>> Use new return type vm_fault_t for fault handler. For
>>>> now, this is just documenting that the function returns
>>>> a VM_FAULT value rather than an errno. Once all instances
>>>> are converted, vm_fault_t will become a distinct type.
>>>>
>>>> Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>>>>
>>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>>
>>> This looks fine to me.
>>>
>>> FYI that there is another handler for this driver in a series
>>> destined for 4.18 and currently in next/master.
>>>
>>> Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
>>>
>>
>> Matthew, is this patch queued for 4.19 ?
>>
> Below is the commit that added fault handler in ocxl. It is in 4.18 rc1 (upstream/master tree)
>
> commit 93b8f8df552c5a30bfddb75a632f1b2a436c2cae
>     scsi: cxlflash: Support adapter context mmap and release


No, that's a different patch with commit
93b8f8df552c5a30bfddb75a632f1b2a436c2cae.
Not the patch under discussion in this mail thread :)

Anyway the other patch with commit 93b8f8df552c5a30b also has to be modified
to use new return type vm_fault_t for fault handler ocxlflash_mmap_fault().

Shall I modify and submit the same ?
