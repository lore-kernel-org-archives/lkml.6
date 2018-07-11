Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF949C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 00:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9F920878
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 00:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JUcMcsXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9F920878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732311AbeGKAmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 20:42:17 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36978 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732262AbeGKAmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 20:42:17 -0400
Received: by mail-io0-f193.google.com with SMTP id z19-v6so22080654ioh.4;
        Tue, 10 Jul 2018 17:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NEgtF0qoaOMYkYzqkSAVkMqdFB+vsXarEKaOYiZgf7I=;
        b=JUcMcsXU7f2zEE7eZpASIywpgizHJ9Je2Dq5dPl4QTpaak5OzXWIjPzxBHtg9LK0+3
         mCc33Bk3qF380zl49rML6zrTUoiaoSySPEnF4YTdHvmBwj9fKTraNtJhyJnQu+7DdMX1
         kXkaflYteqE17IvcDssvt+ZhA2SPRnBxrMwrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NEgtF0qoaOMYkYzqkSAVkMqdFB+vsXarEKaOYiZgf7I=;
        b=VkJmKZDd0j+p9MvanSsHb+/7d8ur6t89V4/WSXoFKDzgo6A0c/xdqOhGPiBUBQeyjz
         qRYDdIiNUJMlhJYfcDkfScOorKWHHNW82ntATYbo4q7Nf0LxOniF/lOm5biY2xtVYN3R
         Bvl1QEAJ+/6wVH+d2IhjMSAiJ27SgK++yliQST0b+guQggsHk7R1VR9eKqWCZH9wiyWi
         YBUY7OhKg+4ZTesFkYLSegp/PUmloxri1abV0nSl1Md9EVcKvHcCD2vnjV9x53BnWvkr
         eeBTcAq8J9J3QnM2oDOIHB8XwHMHgA4oRXBSICoDRq6BjeKJZDI7BzyvWE/LL7FP3B4Q
         FkbA==
X-Gm-Message-State: APt69E3Eemg6YdzZ0bVR8cGZqAV9fOOiKRmcsiGpuBcx4HpcpK3R7SOk
        698HR/r1bppWTt8MTyFROmJI+Qc2N5qnzEQDqpg=
X-Google-Smtp-Source: AAOMgpdwILN8V5jGdRddO1ERgg1Frr1pfc/mompwYOuKwKSMjQAvWll2d0LwGhv4npFVkVmBJWA+VRr3agxr1UH2Z0U=
X-Received: by 2002:a6b:7a05:: with SMTP id h5-v6mr7598063iom.238.1531269640623;
 Tue, 10 Jul 2018 17:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <1530913134.3135.2.camel@HansenPartnership.com>
 <CA+55aFy-o3fRtkQnJU=0zv7CPUtgfKiwhfQi_05K25Y_-mx+_w@mail.gmail.com>
 <CA+55aFxQ8QzGTWsVdVQVok9cLbgZDFjG2g3JZtWJd+G9jHkYoQ@mail.gmail.com>
 <CA+55aFxAy__3hE1OoUFPKZfptLT1cXuoujsnSGXBMzJPQ+Qjzg@mail.gmail.com>
 <1530940958.3135.4.camel@HansenPartnership.com> <CA+55aFwg-2GP4ASTdd1pusmZkF7c8AN9febVDCaioDxzYJSLfw@mail.gmail.com>
 <70d566f0-2dda-60c2-7c7a-e09e371f8607@cybernetics.com> <CA+55aFxdkGTQ-djy6Z4D52xzHhwWdqQyfVgKweTiUfRpvYoztw@mail.gmail.com>
In-Reply-To: <CA+55aFxdkGTQ-djy6Z4D52xzHhwWdqQyfVgKweTiUfRpvYoztw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Jul 2018 17:40:29 -0700
Message-ID: <CA+55aFxDgwKMFTBdxGAYN__zCC=tQjZN1nRHZh5m891Av8V=JA@mail.gmail.com>
Subject: Re: Re: [GIT PULL] SCSI fixes for 4.18-rc3
To:     tonyb@cybernetics.com
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000fc3d8f0570ae7e02"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000fc3d8f0570ae7e02
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 10, 2018 at 3:24 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So /dev/sg really has serious issues. Not just the read/write part,
> but even the SG_IO part is broken right now (sg_new_write() actually
> does do blk_verify_command(), but only for read-only opens for some
> reason).

Looking more at this, it's even more broken than that.

Look at SCSI_IOCTL_SEND_COMMAND. It will do a sg_scsi_ioctl(), but
before that it does the same crazy sg_allow_access() case - and only
for read-only opens.

But that's *doubly* wrong, because

 (a) it's racy, and does the command check on a local copy that might
not be the final one.

 (b) it's pointless, because sg_scsi_ioctl() actually does the proper
command check on the final command as it was copied from user space.

And yes, sg_scsi_ioctl() itself has a slight race in that first it
reads the first byte of the command ("opcode") in order to look up the
size of the command, and then it reads the whole command - including
the first byte - again. So it has the same "read twice, use possibly
inconsistent data" issue, but the actual command that is checked is
the final one that matches the command that is actually submitted. So
all you can do is confuse "cmdlen" and then get timeouts and retry
attempts based on the "fist command" value, but the actually sent
command is fine.

I'm not even going to bother with the sg_scsi_ioctl() race, because
it's harmless, but the drivers/scsi/sg.c code is just pointless and
confusing and should be removed.

Something like the attached?

Please, can we try to at least just de-crapify some of this code?

There's that other "sg_allow_access()" that I also think is wrong and
should just use blk_verify_command() directly and even when opened for
read, but that whole "read or TYPE_SCANNER" is presumably some special
crazy hack for some odd SCSI device.

                  Linus

--000000000000fc3d8f0570ae7e02
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-scsi-sg-remove-incorrect-scsi-command-checking-logic.patch"
Content-Disposition: attachment; 
	filename="0001-scsi-sg-remove-incorrect-scsi-command-checking-logic.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jjgedvj10>
X-Attachment-Id: f_jjgedvj10

RnJvbSBmMDc1ZGNlNjZjNjAzOWJiOTdiNzYyYjU5MmE2ZGI2ZDc5ZTQzNTBhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFR1ZSwgMTAgSnVsIDIwMTggMTc6MDI6MTcgLTA3MDAKU3ViamVjdDog
W1BBVENIXSBzY3NpIHNnOiByZW1vdmUgaW5jb3JyZWN0IHNjc2kgY29tbWFuZCBjaGVja2luZyBs
b2dpYwoKVGhlIFNDU0lfSU9DVExfU0VORF9DT01NQU5EIGlvY3RsIGhhcyBpbnRlcmVzdGluZyBz
Y3NpIGNvbW1hbmQKInNlY3VyaXR5IiBjaGVja2luZy4KCklmIHRoZSBmaWxlIHdhcyBvcGVuZWQg
cmVhZC1vbmx5IChidXQgb25seSBpbiB0aGF0IGNhc2UpLCBpdCB3aWxsCmZldGNoIHRoZSBmaXJz
dCBieXRlIG9mIHRoZSBjb21tYW5kIGZyb20gdXNlciBzcGFjZSwgYW5kIGRvCiJzZ19hbGxvd19h
Y2Nlc3MoKSIgb24gaXQuICBUaGF0LCBpbiB0dXJuLCB3aWxsIGNoZWNrIHRoYXQKImJsa192ZXJp
ZnlfY29tbWFuZCgpIiBpcyBvayB3aXRoIHRoYXQgY29tbWFuZCBieXRlLgoKSWYgdGhhdCBwYXNz
ZXMsIGl0IHdpbGwgdGhlbiBkbyBjYWxsICJzZ19zY3NpX2lvY3RsKCkiIHRvIGV4ZWN1dGUKdGhl
IGNvbW1hbmQuCgpUaGlzIGlzIGVudGlyZWx5IG5vbnNlbnNpY2FsIGZvciBzZXZlcmFsIHJlYXNv
bnMuCgpJdCdzIG5vbnNlbnNpY2FsIHNpbXBseSBiZWNhdXNlIGl0J3MgcmFjeTogYWZ0ZXIgaXQg
Y29waWVzIHRoZSBjb21tYW5kCmJ5dGUgZnJvbSB1c2VyIG1vZGUgdG8gY2hlY2sgaXQsIHVzZXIg
bW9kZSBjb3VsZCBqdXN0IGNoYW5nZSB0aGUgYnl0ZQpiZWZvcmUgaXQgaXMgYWN0dWFsbHkgc3Vi
bWl0dGVkIGxhdGVyIGJ5ICJzZ19zY3NpX2lvY3RsKCkiLgoKQnV0IGl0IGlzIG5vbnNlbnNpY2Fs
IGFsc28gYmVjYXVzZSAic2dfc2NzaV9pb2N0bCgpIiBpdHNlbGYgYWxyZWFkeSBkb2VzCmJsa192
ZXJpZnlfY29tbWFuZCgpIG9uIHRoZSBjb21tYW5kIHByb3Blcmx5IGFmdGVyIGl0IGhhcyBiZWVu
IGNvcGllZApmcm9tIHVzZXIgc3BhY2UuCgpTbyBpdCBpcyBhbiBpbmNvcnJlY3QgaW1wbGVtZW50
YXRpb24gb2YgYSBwb2ludGxlc3MgY2hlY2suIFJlbW92ZSBpdC4KClNpZ25lZC1vZmYtYnk6IExp
bnVzIFRvcnZhbGRzIDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4KLS0tCiBkcml2ZXJz
L3Njc2kvc2cuYyB8IDkgLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgOSBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvc2cuYyBiL2RyaXZlcnMvc2NzaS9zZy5jCmluZGV4
IGNkMmZkYWMwMDBjOS4uNGYzNDUwNzkzMjczIDEwMDY0NAotLS0gYS9kcml2ZXJzL3Njc2kvc2cu
YworKysgYi9kcml2ZXJzL3Njc2kvc2cuYwpAQCAtMTEwMywxNSArMTEwMyw2IEBAIHNnX2lvY3Rs
KHN0cnVjdCBmaWxlICpmaWxwLCB1bnNpZ25lZCBpbnQgY21kX2luLCB1bnNpZ25lZCBsb25nIGFy
ZykKIAljYXNlIFNDU0lfSU9DVExfU0VORF9DT01NQU5EOgogCQlpZiAoYXRvbWljX3JlYWQoJnNk
cC0+ZGV0YWNoaW5nKSkKIAkJCXJldHVybiAtRU5PREVWOwotCQlpZiAocmVhZF9vbmx5KSB7Ci0J
CQl1bnNpZ25lZCBjaGFyIG9wY29kZSA9IFdSSVRFXzY7Ci0JCQlTY3NpX0lvY3RsX0NvbW1hbmQg
X191c2VyICpzaW9jcCA9IHA7Ci0KLQkJCWlmIChjb3B5X2Zyb21fdXNlcigmb3Bjb2RlLCBzaW9j
cC0+ZGF0YSwgMSkpCi0JCQkJcmV0dXJuIC1FRkFVTFQ7Ci0JCQlpZiAoc2dfYWxsb3dfYWNjZXNz
KGZpbHAsICZvcGNvZGUpKQotCQkJCXJldHVybiAtRVBFUk07Ci0JCX0KIAkJcmV0dXJuIHNnX3Nj
c2lfaW9jdGwoc2RwLT5kZXZpY2UtPnJlcXVlc3RfcXVldWUsIE5VTEwsIGZpbHAtPmZfbW9kZSwg
cCk7CiAJY2FzZSBTR19TRVRfREVCVUc6CiAJCXJlc3VsdCA9IGdldF91c2VyKHZhbCwgaXApOwot
LSAKMi4xOC4wLjEzMi5nOTVlZGEzZDg2Cgo=
--000000000000fc3d8f0570ae7e02--
