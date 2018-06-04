Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751322AbeFDUZK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 16:25:10 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:37678 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751203AbeFDUZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 16:25:08 -0400
X-Google-Smtp-Source: ADUXVKKmzuw6mQp5rRdRjRWXECrM5TsQJT6wSAZduAy5kxuUcgeMke4lOSSwCcFByZQHdp5/n/LmY+0oVXGR2WEDxCE=
MIME-Version: 1.0
In-Reply-To: <CAB+yDaYOtfZ-nfEdvkSh5Cvsw79ovTRzP8KfzcWc1E_tHn6YCA@mail.gmail.com>
References: <CAB+yDaZAwFny2NdOZfymdpdR3Sf7pdkxahgQ6v2zBzUvSwBWTA@mail.gmail.com>
 <CAB+yDaZFZhku34wp-t_i32Vy6cYB9fnS0iboPnQZ26sQeAZ+Uw@mail.gmail.com>
 <2f2047ca-a96f-91da-c746-530c7b8d1bbf@oracle.com> <CAB+yDaZFVpRGW8X_eN=0pEeujn6VX13kxRZSf-Sse_GrjcCQKA@mail.gmail.com>
 <d77a3fd9-ecda-1bf6-b4c9-60abdacd445a@oracle.com> <CAB+yDaYOtfZ-nfEdvkSh5Cvsw79ovTRzP8KfzcWc1E_tHn6YCA@mail.gmail.com>
From: shankarapailoor <shankarapailoor@gmail.com>
Date: Mon, 4 Jun 2018 13:25:06 -0700
Message-ID: <CAB+yDaar=-KTfO2i_aKY9R2xMXUpw=DNwr4sxGCC5nvP7w9YZQ@mail.gmail.com>
Subject: Re: Slab out of bounds in setxattr
To: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000c27431056dd6ba80"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000c27431056dd6ba80
Content-Type: text/plain; charset="UTF-8"

Sorry,

Sent the same thing twice. Here is the updated one.

On Mon, Jun 4, 2018 at 1:22 PM, shankarapailoor
<shankarapailoor@gmail.com> wrote:
> Hi Dave,
>
> I've updated the patch accordingly.
>
> Regards,
> Shankara
>
> On Mon, Jun 4, 2018 at 11:39 AM, Dave Kleikamp <dave.kleikamp@oracle.com> wrote:
>> On 06/04/2018 01:30 PM, shankarapailoor wrote:
>>> Hi Dave,
>>>
>>> Attached is my proposed patch. It solves the problem as you suggest
>>> and I don't see the KASAN complaint.
>>
>> That looks good to me. Add a description and a Signed-off-by: and I'll
>> get it pushed upstream.
>>
>> Thanks for finding this.
>>
>> Shaggy
>>
>>>
>>> Regards,
>>> Shankara
>>>
>>> On Mon, Jun 4, 2018 at 11:24 AM, Dave Kleikamp <dave.kleikamp@oracle.com> wrote:
>>>> On 06/01/2018 11:06 PM, shankarapailoor wrote:
>>>>> Hi,
>>>>>
>>>>> Looking at the crash some more, it seems that if value_len > PAGE_SIZE
>>>>> then e_buf->max_size is rounded up nearest page size [1]. If a new
>>>>> attribute is added with value_len < e_buf->max_size - EA_SIZE(ea) then
>>>>> no new space is allocated for the attiribute list [2] and this
>>>>> triggers the KASAN slab out of bounds error. This is the case in the C
>>>>> repro I provided.
>>>>
>>>> I see the problem. It looks like we should be calculating max_size
>>>> earlier and using that to call kmalloc(). (xattr.c#496)
>>>>
>>>> Shaggy
>>>>>
>>>>>
>>>>> 1. https://elixir.bootlin.com/linux/v4.17-rc7/source/fs/jfs/xattr.c#L501
>>>>> 2. https://elixir.bootlin.com/linux/v4.17-rc7/source/fs/jfs/xattr.c#L723
>>>>>
>>>>> On Fri, Jun 1, 2018 at 1:52 PM, shankarapailoor
>>>>> <shankarapailoor@gmail.com> wrote:
>>>>>> Hi Dave et al,
>>>>>>
>>>>>> I have been fuzzing linux 4.17-rc4 with JFS using Syzkaller  KASAN:
>>>>>> slab-out-of-bounds in jfs_xattr.
>>>>>>
>>>>>> Attached are my kernel configs and a C reproducer. In the first
>>>>>> setxattr call it appears that length is much larger than the name. In
>>>>>> __jfs_setxattr, I don't see where the length is checked against the
>>>>>> actual value length.
>>>>>>
>>>>>> Regards,
>>>>>> Shankara Pailoor
>
>
>
> --
> Regards,
> Shankara Pailoor



-- 
Regards,
Shankara Pailoor

--000000000000c27431056dd6ba80
Content-Type: application/octet-stream; name=jfspatch
Content-Disposition: attachment; filename=jfspatch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ji0pf7181

RnJvbSAzOGQyZmM3Y2I4ZjRiMzNmYmE0OTJjYTk1NmMxYjJiZThhNzk2YTg1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaGFua2FyYSBQYWlsb29yIDxzaGFua2FyYXBhaWxvb3JAZ21h
aWwuY29tPgpEYXRlOiBNb24sIDQgSnVuIDIwMTggMTk6NTc6MTUgKzAwMDAKU3ViamVjdDogW1BB
VENIXSBfX2pmc19zZXR4YXR0cjogY2hhbmdlIGVhX2dldCB0byBhbGxvY2F0ZSBlYV9idWYtPnhh
dHRyIHdpdGggdGhlIHNhbWUgc2l6ZSBhcyBlYV9idWYtPm1heF9zaXplClNpZ25lZC1vZmYtYnk6
IFNoYW5rYXJhIFBhaWxvb3IgPHNoYW5rYXJhcGFpbG9vckBnbWFpbC5jb20+Ci0tLQogZnMvamZz
L3hhdHRyLmMgfCA4ICsrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQpkaWZmIC0tZ2l0IGEvZnMvamZzL3hhdHRyLmMgYi9mcy9qZnMveGF0dHIu
YwppbmRleCBjNjBmM2QzLi45NmI5MzU1IDEwMDY0NAotLS0gYS9mcy9qZnMveGF0dHIuYworKysg
Yi9mcy9qZnMveGF0dHIuYwpAQCAtNDkzLDE0ICs0OTMsMTQgQEAgc3RhdGljIGludCBlYV9nZXQo
c3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGVhX2J1ZmZlciAqZWFfYnVmLCBpbnQgbWluX3Np
emUpCiAgICAgICAgICAgICAgICAgKiBUbyBrZWVwIHRoZSByZXN0IG9mIHRoZSBjb2RlIHNpbXBs
ZS4gIEFsbG9jYXRlIGEKICAgICAgICAgICAgICAgICAqIGNvbnRpZ3VvdXMgYnVmZmVyIHRvIHdv
cmsgd2l0aAogICAgICAgICAgICAgICAgICovCi0gICAgICAgICAgICAgICBlYV9idWYtPnhhdHRy
ID0ga21hbGxvYyhzaXplLCBHRlBfS0VSTkVMKTsKLSAgICAgICAgICAgICAgIGlmIChlYV9idWYt
PnhhdHRyID09IE5VTEwpCi0gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOwot
CiAgICAgICAgICAgICAgICBlYV9idWYtPmZsYWcgPSBFQV9NQUxMT0M7CiAgICAgICAgICAgICAg
ICBlYV9idWYtPm1heF9zaXplID0gKHNpemUgKyBzYi0+c19ibG9ja3NpemUgLSAxKSAmCiAgICAg
ICAgICAgICAgICAgICAgfihzYi0+c19ibG9ja3NpemUgLSAxKTsKKyAgICAgICAgICAgICAgIGVh
X2J1Zi0+eGF0dHIgPSBrbWFsbG9jKGVhX2J1Zi0+bWF4X3NpemUsIEdGUF9LRVJORUwpOworICAg
ICAgICAgICAgICAgaWYgKGVhX2J1Zi0+eGF0dHIgPT0gTlVMTCkKKyAgICAgICAgICAgICAgICAg
ICAgICAgcmV0dXJuIC1FTk9NRU07CisKICAgICAgICAgICAgICAgIGlmIChlYV9zaXplID09IDAp
CiAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAwOwo=
--000000000000c27431056dd6ba80--
