Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753369AbeFATBc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 15:01:32 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44271 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752704AbeFATB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 15:01:28 -0400
X-Google-Smtp-Source: ADUXVKLi9rzLuJvg9xKC19/3gWIBOdG3TTxhPt0k9C+5cUcAceLiluME6taXl4dLXre9VYRhVtv/aIJcnxzf7SZ+BK8=
MIME-Version: 1.0
In-Reply-To: <04ea0685-0141-b12c-06f6-f246a318bfe4@amd.com>
References: <20180523185538.GA975@jordon-HP-15-Notebook-PC>
 <CAFqt6zZq_GN2gjv-noP4RsOV74xCBGQjgHYadCOgaETv0wu9_g@mail.gmail.com> <04ea0685-0141-b12c-06f6-f246a318bfe4@amd.com>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Sat, 2 Jun 2018 00:31:26 +0530
Message-ID: <CAFqt6zafU0JxPU+cSB=mHZWuPDQnLgLk4cgAo2Gnbs1XUbTqgQ@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: ttm: Adding new return type vm_fault_t
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Hongbo.He@amd.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w51J2eee027032

On Fri, Jun 1, 2018 at 5:18 PM, Christian König
<christian.koenig@amd.com> wrote:
> Am 31.05.2018 um 07:07 schrieb Souptick Joarder:
>>
>> On Thu, May 24, 2018 at 12:25 AM, Souptick Joarder <jrdr.linux@gmail.com>
>> wrote:
>>>
>>> Use new return type vm_fault_t for fault handler. For
>>> now, this is just documenting that the function returns
>>> a VM_FAULT value rather than an errno. Once all instances
>>> are converted, vm_fault_t will become a distinct type.
>>>
>>> Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>>>
>>> Previously vm_insert_{mixed,pfn} returns err which driver
>>> mapped into VM_FAULT_* type. The new function
>>> vmf_insert_{mixed,pfn} will replace this inefficiency by
>>> returning VM_FAULT_* type.
>>>
>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>> ---
>>>   drivers/gpu/drm/ttm/ttm_bo_vm.c | 45
>>> ++++++++++++++++++++---------------------
>>>   1 file changed, 22 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c
>>> b/drivers/gpu/drm/ttm/ttm_bo_vm.c
>>> index 8eba95b..2d13f03 100644
>>> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
>>> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
>>> @@ -43,10 +43,11 @@
>>>
>>>   #define TTM_BO_VM_NUM_PREFAULT 16
>>>
>>> -static int ttm_bo_vm_fault_idle(struct ttm_buffer_object *bo,
>>> +static vm_fault_t ttm_bo_vm_fault_idle(struct ttm_buffer_object *bo,
>>>                                  struct vm_fault *vmf)
>>>   {
>>> -       int ret = 0;
>>> +       int err = 0;
>>> +       vm_fault_t ret = 0;
>
>
> Please keep reverse xmas tree order for variable declarations.
>
> Except for that it looks good to me,
> Christian.
>

Sure, I will send v2. We would like to get this patch in
queue for 4.18.
