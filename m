Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0632CC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA502403A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m4snExFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA502403A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754221AbeGEQJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:09:02 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44455 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754003AbeGEQI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:08:59 -0400
Received: by mail-pf0-f196.google.com with SMTP id j3-v6so5826460pfh.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 09:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=S9EKC66hdJylp6b1c52W6FbTirreq16K6z8CLKmgfmU=;
        b=m4snExFPAFvw+nUQsNls3QTMkKPEvBDe4u2xz2FPZkVJ21cSOzqdHWRwcN5hack9XH
         jD5lfgMTclvHNAhvdeK/z3uRB+E3vzMJgXqlaHjt9TIw4kbMmde5rHGIKz5VQChUIC1e
         NryZJ0gOMB6S6PFXd+j1FnvOdN86R5F/OxFtcNktiQyS2SPVub0OucnxIA2dG98SxlRV
         i9LjLDD3OPSOYzHS1nSOG8YBoc5F7T0gkz/MtmhqAEjSfyvi2MuSBGg1crt+3xH1T+q2
         H5oXo14gNIYstb8VaMSuR+o7GuKlmkm3zlQ2kIIxlG+b/iF2ZVBmSNgcdOC6MakWvmmm
         HdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=S9EKC66hdJylp6b1c52W6FbTirreq16K6z8CLKmgfmU=;
        b=GjHbtE2K4s8WkqAEi3ioshEBaqd3Lj+weFwjl1NU5goDiZ4QMHVFElBoSclWA7JZe5
         YVHCEGWpPLC2WzefUdqy9Ur26OjFVzmtDFmGFnpoGuCZE6Deg//Qf1ncdme5sw5I+tkT
         8s1AsBl1QHLuhFD+BLalF5/1M0mTnU2KdB6c+EqEdE4oKSAwILWSOnnH1NYyZFyPLjSn
         5Tu0GZf9KS69mCQltGP0bNqUMbVcgsX3rRfPxmn88Ix5j6+9ytrG8G/7Pt0voNfgipAp
         UgbAQzVNLj/zTumkcRHCmHMlOFkuC7abal4uUExBLbBHDr/nWkO6KmTRAnmaP3N4GAgt
         33RA==
X-Gm-Message-State: APt69E1lZo2hLu+DebZsAIOg13GOJ66tJmFEAAE9IFF2HXnM6qEzDJcS
        T6Jev1/e7DHTBvE/ydEaRM8zNNryq4hw4/q0qTubbm2O
X-Google-Smtp-Source: AAOMgpdO93PkgCbnBwU3FJxz4ZHWYNAVku/zTG5vWiY1ezmfC4OTp/UiKboliShO5qmLfZlUctHyDJA3fDIjGiPY1HA=
X-Received: by 2002:a65:58c8:: with SMTP id e8-v6mr6121450pgu.96.1530806938046;
 Thu, 05 Jul 2018 09:08:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Thu, 5 Jul 2018 09:08:37
 -0700 (PDT)
In-Reply-To: <7143da44-448b-8beb-7583-1a5516623649@colorfullife.com>
References: <20180705055920.19611-1-manfred@colorfullife.com>
 <20180705055920.19611-3-manfred@colorfullife.com> <CACT4Y+YyZT+JRyUcYRD83V13M-k91XUp1qkpBCUCkGfamLgDTg@mail.gmail.com>
 <7143da44-448b-8beb-7583-1a5516623649@colorfullife.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 5 Jul 2018 18:08:37 +0200
Message-ID: <CACT4Y+ZO+Y3TzXsiV99_-S=5Uh0t_U2hadp7LBL0B2swZJyZwg@mail.gmail.com>
Subject: Re: [PATCH 2/6] ipc: reorganize initialization of kern_ipc_perm.seq
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000c3b8ad057042c3b2"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000c3b8ad057042c3b2
Content-Type: text/plain; charset="UTF-8"

On Thu, Jul 5, 2018 at 5:12 PM, Manfred Spraul <manfred@colorfullife.com> wrote:
> Hi Dmitry,
>
> On 07/05/2018 10:36 AM, Dmitry Vyukov wrote:
>>
>> [...]
>> Hi Manfred,
>>
>> The series looks like a significant improvement to me. Thanks!
>>
>> I feel that this code can be further simplified (unless I am missing
>> something here). Please take a look at this version:
>>
>>
>> https://github.com/dvyukov/linux/commit/f77aeaf80f3c4ab524db92184d874b03063fea3a?diff=split
>>
>> This is on top of your patches. It basically does the same as your
>> code, but consolidates all id/seq assignment and dealing with next_id,
>> and deduplicates code re CONFIG_CHECKPOINT_RESTORE. Currently it's a
>> bit tricky to follow e.g. where exactly next_id is consumed and where
>> it needs to be left intact.
>> The only difference is that my code assigns new->id earlier. Not sure
>> if it can lead to anything bad. But if yes, then it seems that
>> currently uninitialized new->id is exposed. If necessary (?) we could
>> reset new->id in the same place where we set new->deleted.
>
> Everything looks correct for me, it is better than the current code.
> Except that you didn't sign off your last patch.

It was meant more like a review comment expressed in code. But I signed it now.

> As next step: Who can merge the patches towards linux-next?
> The only open point that I see are stress tests of the error codepaths.
>
> And:
> I don't think that the patches are relevant for linux-stable, correct?

I don't have a pressing need for stable (simply because KMSAN/KTSAN
are not backported to any stable releases, so we won't discover it
there).

--000000000000c3b8ad057042c3b2
Content-Type: text/plain; charset="US-ASCII"; name="ipc.txt"
Content-Disposition: attachment; filename="ipc.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jj8qun4q0

Y29tbWl0IDIzOTVmNjQ2MjU5NmIyOThkM2E0ZWViMTYxNGIxYTY3Njg2YjZmYzUKQXV0aG9yOiBE
bWl0cnkgVnl1a292IDxkdnl1a292QGdvb2dsZS5jb20+CkRhdGU6ICAgVGh1IEp1bCA1IDEwOjE1
OjI2IDIwMTggKzAyMDAKCiAgICBpcGNfaWRyX2FsbG9jIHJlZmFjdG9yaW5nCiAgICAKICAgIFNp
Z25lZC1vZmYtYnk6IERtaXRyeSBWeXVrb3YgPGR2eXVrb3ZAZ29vZ2xlLmNvbT4KCmRpZmYgLS1n
aXQgYS9pcGMvdXRpbC5jIGIvaXBjL3V0aWwuYwppbmRleCA3NzZhOWNlMjkwNWZmLi5jOTg2NzVk
ODYxMmUyIDEwMDY0NAotLS0gYS9pcGMvdXRpbC5jCisrKyBiL2lwYy91dGlsLmMKQEAgLTE5Myw1
MiArMTkzLDMyIEBAIHN0YXRpYyBzdHJ1Y3Qga2Vybl9pcGNfcGVybSAqaXBjX2ZpbmRrZXkoc3Ry
dWN0IGlwY19pZHMgKmlkcywga2V5X3Qga2V5KQogCXJldHVybiBOVUxMOwogfQogCi0jaWZkZWYg
Q09ORklHX0NIRUNLUE9JTlRfUkVTVE9SRQogLyoKICAqIFNwZWNpZnkgZGVzaXJlZCBpZCBmb3Ig
bmV4dCBhbGxvY2F0ZWQgSVBDIG9iamVjdC4KICAqLwotc3RhdGljIGlubGluZSBpbnQgaXBjX2lk
cl9hbGxvYyhzdHJ1Y3QgaXBjX2lkcyAqaWRzLAotCQkJCXN0cnVjdCBrZXJuX2lwY19wZXJtICpu
ZXcpCitzdGF0aWMgaW5saW5lIGludCBpcGNfaWRyX2FsbG9jKHN0cnVjdCBpcGNfaWRzICppZHMs
IHN0cnVjdCBrZXJuX2lwY19wZXJtICpuZXcpCiB7Ci0JaW50IGtleTsKKwlpbnQga2V5LCBuZXh0
X2lkID0gLTE7CiAKLQlpZiAoaWRzLT5uZXh0X2lkIDwgMCkgewotCQlrZXkgPSBpZHJfYWxsb2Mo
Jmlkcy0+aXBjc19pZHIsIG5ldywgMCwgMCwgR0ZQX05PV0FJVCk7Ci0JfSBlbHNlIHsKLQkJa2V5
ID0gaWRyX2FsbG9jKCZpZHMtPmlwY3NfaWRyLCBuZXcsCi0JCQkJaXBjaWRfdG9faWR4KGlkcy0+
bmV4dF9pZCksCi0JCQkJMCwgR0ZQX05PV0FJVCk7Ci0JCWlkcy0+bmV4dF9pZCA9IC0xOwotCX0K
LQlyZXR1cm4ga2V5OwotfQorI2lmZGVmIENPTkZJR19DSEVDS1BPSU5UX1JFU1RPUkUKKwluZXh0
X2lkID0gaWRzLT5uZXh0X2lkOworCWlkcy0+bmV4dF9pZCA9IC0xOworI2VuZGlmCiAKLXN0YXRp
YyBpbmxpbmUgdm9pZCBpcGNfc2V0X3NlcShzdHJ1Y3QgaXBjX2lkcyAqaWRzLAotCQkJCXN0cnVj
dCBrZXJuX2lwY19wZXJtICpuZXcpCi17Ci0JaWYgKGlkcy0+bmV4dF9pZCA8IDApIHsgLyogZGVm
YXVsdCwgYmVoYXZlIGFzICFDSEVDS1BPSU5UX1JFU1RPUkUgKi8KKwlpZiAobmV4dF9pZCA8IDAp
IHsgLyogIUNIRUNLUE9JTlRfUkVTVE9SRSBvciBuZXh0X2lkIGlzIHVuc2V0ICovCiAJCW5ldy0+
c2VxID0gaWRzLT5zZXErKzsKIAkJaWYgKGlkcy0+c2VxID4gSVBDSURfU0VRX01BWCkKIAkJCWlk
cy0+c2VxID0gMDsKKwkJa2V5ID0gaWRyX2FsbG9jKCZpZHMtPmlwY3NfaWRyLCBuZXcsIDAsIDAs
IEdGUF9OT1dBSVQpOwogCX0gZWxzZSB7Ci0JCW5ldy0+c2VxID0gaXBjaWRfdG9fc2VxeChpZHMt
Pm5leHRfaWQpOworCQluZXctPnNlcSA9IGlwY2lkX3RvX3NlcXgobmV4dF9pZCk7CisJCWtleSA9
IGlkcl9hbGxvYygmaWRzLT5pcGNzX2lkciwgbmV3LCBpcGNpZF90b19pZHgobmV4dF9pZCksCisJ
CQkJMCwgR0ZQX05PV0FJVCk7CiAJfQorCW5ldy0+aWQgPSBTRVFfTVVMVElQTElFUiAqIG5ldy0+
c2VxICsga2V5OworCXJldHVybiBrZXk7CiB9CiAKLSNlbHNlCi0jZGVmaW5lIGlwY19pZHJfYWxs
b2MoaWRzLCBuZXcpCQkJCQlcCi0JaWRyX2FsbG9jKCYoaWRzKS0+aXBjc19pZHIsIChuZXcpLCAw
LCAwLCBHRlBfTk9XQUlUKQotCi1zdGF0aWMgaW5saW5lIHZvaWQgaXBjX3NldF9zZXEoc3RydWN0
IGlwY19pZHMgKmlkcywKLQkJCSAgICAgIHN0cnVjdCBrZXJuX2lwY19wZXJtICpuZXcpCi17Ci0J
bmV3LT5zZXEgPSBpZHMtPnNlcSsrOwotCWlmIChpZHMtPnNlcSA+IElQQ0lEX1NFUV9NQVgpCi0J
CWlkcy0+c2VxID0gMDsKLX0KLQotI2VuZGlmIC8qIENPTkZJR19DSEVDS1BPSU5UX1JFU1RPUkUg
Ki8KLQogLyoqCiAgKiBpcGNfYWRkaWQgLSBhZGQgYW4gaXBjIGlkZW50aWZpZXIKICAqIEBpZHM6
IGlwYyBpZGVudGlmaWVyIHNldApAQCAtMjc4LDggKzI1OCw2IEBAIGludCBpcGNfYWRkaWQoc3Ry
dWN0IGlwY19pZHMgKmlkcywgc3RydWN0IGtlcm5faXBjX3Blcm0gKm5ldywgaW50IGxpbWl0KQog
CWN1cnJlbnRfZXVpZF9lZ2lkKCZldWlkLCAmZWdpZCk7CiAJbmV3LT5jdWlkID0gbmV3LT51aWQg
PSBldWlkOwogCW5ldy0+Z2lkID0gbmV3LT5jZ2lkID0gZWdpZDsKLQotCWlwY19zZXRfc2VxKGlk
cywgbmV3KTsKIAluZXctPmRlbGV0ZWQgPSBmYWxzZTsKIAogCS8qCkBAIC0zMTcsOSArMjk1LDYg
QEAgaW50IGlwY19hZGRpZChzdHJ1Y3QgaXBjX2lkcyAqaWRzLCBzdHJ1Y3Qga2Vybl9pcGNfcGVy
bSAqbmV3LCBpbnQgbGltaXQpCiAJaWRzLT5pbl91c2UrKzsKIAlpZiAoaWQgPiBpZHMtPm1heF9p
ZCkKIAkJaWRzLT5tYXhfaWQgPSBpZDsKLQotCW5ldy0+aWQgPSBTRVFfTVVMVElQTElFUiAqIG5l
dy0+c2VxICsgaWQ7Ci0KIAlyZXR1cm4gaWQ7CiB9CiAK
--000000000000c3b8ad057042c3b2--
