Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1126EC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E44024067
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="de56vitR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E44024067
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753395AbeGEIgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 04:36:43 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35154 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753216AbeGEIgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 04:36:41 -0400
Received: by mail-pf0-f195.google.com with SMTP id q7-v6so3651402pff.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 01:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jUQncZh8AgsO/eTfnzrih4Pm2mwi0Gy/CofjtE072kY=;
        b=de56vitR5tk8KPRhvCmhn64vO2ftQZugXEFwK+6vmBlKFbsGKoVXicy9S+kbGc7ebL
         7iaSj8/xSHKAAC2uM0T68oxFzEFCn0RODsPDMCsgJOZeJDTHpBTjdRfeNQL3vjTwFgYF
         J5UzAqaTAwy7aCO0P/z0iQEq3CgkpM5SLg/gDm1niPlyMpSQkt+YvXfMytJFKMgoVhmr
         s5ueoVMV2dGYY0h09pOov5BB+WQEIEznQh1GqQA60Oy+g/ZhECGRH0KhIyzwFBstiIRj
         Xj974dlnD8vbsBFcw1vVLKPYeQOe+5YxqUOO/5rE+eGGNqsB/gsBXOZiwucYygsJBHF8
         pBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jUQncZh8AgsO/eTfnzrih4Pm2mwi0Gy/CofjtE072kY=;
        b=Ys/q6G2BmbtnUEJT7IJg2hGWd+43IubVDc2pB7rbbvin2g/9TBx5IQUXg3dVU/GCIz
         z74TC2pf5kYKYlMQgsHoQewaLx5OBmOLuYa7zDUkIoZ9PFXQ/KRE4iTcNucRtRD9no7z
         k/C9wDcG9Tr/DXtsnKYVEDrwr/fajk2HVtbnbWMR27Bvjrz9EoWH0AEgXRBSGSXxGZnf
         2VUllLIAPi8RyJSzHDFEMoOrxXH+cCyfOjUVEVgstfcNvVJxsyKaAByrzPDApY4Cvskl
         YMMfXtzZuSygQ4METYcyMrzsMTV1NMAXJPvFxqr2qdCxSjmSZCENR9MPTOa+MIDCCrf+
         EZgA==
X-Gm-Message-State: APt69E3dYOzSxodeTlSnsV3d8bpXXu2dERmPLUGxUERRCECWUiQtREfw
        02O5VNC4eksvGF1oN/vCulv6yjSAEAb5sbluDC3uFqE0sT0=
X-Google-Smtp-Source: AAOMgpfGOV5qgeFnmz5xzhb2nBUC12LLDNupL1MqTi2oDQkFeRn1UqedOpv617EkYnprd/4vk+akpsN2T9RyxT0FCA8=
X-Received: by 2002:a62:4a41:: with SMTP id x62-v6mr3602123pfa.45.1530779800938;
 Thu, 05 Jul 2018 01:36:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Thu, 5 Jul 2018 01:36:20
 -0700 (PDT)
In-Reply-To: <20180705055920.19611-3-manfred@colorfullife.com>
References: <20180705055920.19611-1-manfred@colorfullife.com> <20180705055920.19611-3-manfred@colorfullife.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 5 Jul 2018 10:36:20 +0200
Message-ID: <CACT4Y+YyZT+JRyUcYRD83V13M-k91XUp1qkpBCUCkGfamLgDTg@mail.gmail.com>
Subject: Re: [PATCH 2/6] ipc: reorganize initialization of kern_ipc_perm.seq
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>, 1vier1@web.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000444a9205703c7242"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000444a9205703c7242
Content-Type: text/plain; charset="UTF-8"

On Thu, Jul 5, 2018 at 7:59 AM, Manfred Spraul <manfred@colorfullife.com> wrote:
> ipc_addid() initializes kern_ipc_perm.seq after having called
> ipc_idr_alloc().
>
> Thus a parallel semop() or msgrcv() that uses ipc_obtain_object_check()
> may see an uninitialized value.
>
> The patch moves the initialization of kern_ipc_perm.seq before the
> calls of ipc_idr_alloc().
>
> Notes:
> 1) This patch has a user space visible side effect:
> If /proc/sys/kernel/*_next_id is used (i.e.: checkpoint/restore) and
> if semget()/msgget()/shmget() fails in the final step of adding the id
> to the rhash tree, then .._next_id is cleared. Before the patch, is
> remained unmodified.
>
> There is no change of the behavior after a successful ..get() call:
> It always clears .._next_id, there is no impact to non checkpoint/restore
> code as that code does not use .._next_id.
>
> 2) The patch correctly documents that after a call to ipc_idr_alloc(),
> the full tear-down sequence must be used. The callers of ipc_addid()
> do not fullfill that, i.e. more bugfixes are required.
>
> Reported-by: syzbot+2827ef6b3385deb07eaf@syzkaller.appspotmail.com
> Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
> ---
>  Documentation/sysctl/kernel.txt |  3 ++-
>  ipc/util.c                      | 45 +++++++++++++++++++++++----------
>  2 files changed, 34 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/sysctl/kernel.txt b/Documentation/sysctl/kernel.txt
> index eded671d55eb..b2d4a8f8fe97 100644
> --- a/Documentation/sysctl/kernel.txt
> +++ b/Documentation/sysctl/kernel.txt
> @@ -440,7 +440,8 @@ Notes:
>  1) kernel doesn't guarantee, that new object will have desired id. So,
>  it's up to userspace, how to handle an object with "wrong" id.
>  2) Toggle with non-default value will be set back to -1 by kernel after
> -successful IPC object allocation.
> +successful IPC object allocation. If an IPC object allocation syscall
> +fails, it is undefined if the value remains unmodified or is reset to -1.
>
>  ==============================================================
>
> diff --git a/ipc/util.c b/ipc/util.c
> index 4e81182fa0ac..662c28c6c9fa 100644
> --- a/ipc/util.c
> +++ b/ipc/util.c
> @@ -197,13 +197,24 @@ static struct kern_ipc_perm *ipc_findkey(struct ipc_ids *ids, key_t key)
>  /*
>   * Specify desired id for next allocated IPC object.
>   */
> -#define ipc_idr_alloc(ids, new)                                                \
> -       idr_alloc(&(ids)->ipcs_idr, (new),                              \
> -                 (ids)->next_id < 0 ? 0 : ipcid_to_idx((ids)->next_id),\
> -                 0, GFP_NOWAIT)
> +static inline int ipc_idr_alloc(struct ipc_ids *ids,
> +                               struct kern_ipc_perm *new)
> +{
> +       int key;
>
> -static inline int ipc_buildid(int id, struct ipc_ids *ids,
> -                             struct kern_ipc_perm *new)
> +       if (ids->next_id < 0) {
> +               key = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
> +       } else {
> +               key = idr_alloc(&ids->ipcs_idr, new,
> +                               ipcid_to_idx(ids->next_id),
> +                               0, GFP_NOWAIT);
> +               ids->next_id = -1;
> +       }
> +       return key;
> +}
> +
> +static inline void ipc_set_seq(struct ipc_ids *ids,
> +                               struct kern_ipc_perm *new)
>  {
>         if (ids->next_id < 0) { /* default, behave as !CHECKPOINT_RESTORE */
>                 new->seq = ids->seq++;
> @@ -211,24 +222,19 @@ static inline int ipc_buildid(int id, struct ipc_ids *ids,
>                         ids->seq = 0;
>         } else {
>                 new->seq = ipcid_to_seqx(ids->next_id);
> -               ids->next_id = -1;
>         }
> -
> -       return SEQ_MULTIPLIER * new->seq + id;
>  }
>
>  #else
>  #define ipc_idr_alloc(ids, new)                                        \
>         idr_alloc(&(ids)->ipcs_idr, (new), 0, 0, GFP_NOWAIT)
>
> -static inline int ipc_buildid(int id, struct ipc_ids *ids,
> +static inline void ipc_set_seq(struct ipc_ids *ids,
>                               struct kern_ipc_perm *new)
>  {
>         new->seq = ids->seq++;
>         if (ids->seq > IPCID_SEQ_MAX)
>                 ids->seq = 0;
> -
> -       return SEQ_MULTIPLIER * new->seq + id;
>  }
>
>  #endif /* CONFIG_CHECKPOINT_RESTORE */
> @@ -270,6 +276,19 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
>         new->cuid = new->uid = euid;
>         new->gid = new->cgid = egid;
>
> +       ipc_set_seq(ids, new);
> +
> +       /*
> +        * As soon as a new object is inserted into the idr,
> +        * ipc_obtain_object_idr() or ipc_obtain_object_check() can find it,
> +        * and the lockless preparations for ipc operations can start.
> +        * This means especially: permission checks, audit calls, allocation
> +        * of undo structures, ...
> +        *
> +        * Thus the object must be fully initialized, and if something fails,
> +        * then the full tear-down sequence must be followed.
> +        * (i.e.: set new->deleted, reduce refcount, call_rcu())
> +        */
>         id = ipc_idr_alloc(ids, new);
>         idr_preload_end();
>
> @@ -291,7 +310,7 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
>         if (id > ids->max_id)
>                 ids->max_id = id;
>
> -       new->id = ipc_buildid(id, ids, new);
> +       new->id = SEQ_MULTIPLIER * new->seq + id;
>
>         return id;
>  }


Hi Manfred,

The series looks like a significant improvement to me. Thanks!

I feel that this code can be further simplified (unless I am missing
something here). Please take a look at this version:

https://github.com/dvyukov/linux/commit/f77aeaf80f3c4ab524db92184d874b03063fea3a?diff=split

This is on top of your patches. It basically does the same as your
code, but consolidates all id/seq assignment and dealing with next_id,
and deduplicates code re CONFIG_CHECKPOINT_RESTORE. Currently it's a
bit tricky to follow e.g. where exactly next_id is consumed and where
it needs to be left intact.
The only difference is that my code assigns new->id earlier. Not sure
if it can lead to anything bad. But if yes, then it seems that
currently uninitialized new->id is exposed. If necessary (?) we could
reset new->id in the same place where we set new->deleted.

Other patches in the series look good to me.

p.s. I've uploaded full context diffs of all patches here:
https://github.com/dvyukov/linux/commits/ipc1

--000000000000444a9205703c7242
Content-Type: text/plain; charset="US-ASCII"; name="ipc.txt"
Content-Disposition: attachment; filename="ipc.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jj8apfvr0

Y29tbWl0IGY3N2FlYWY4MGYzYzRhYjUyNGRiOTIxODRkODc0YjAzMDYzZmVhM2EKQXV0aG9yOiBE
bWl0cnkgVnl1a292IDxkdnl1a292QGdvb2dsZS5jb20+CkRhdGU6ICAgVGh1IEp1bCA1IDEwOjE1
OjI2IDIwMTggKzAyMDAKCiAgICBpcGNfaWRyX2FsbG9jIHJlZmFjdG9yaW5nCgpkaWZmIC0tZ2l0
IGEvaXBjL3V0aWwuYyBiL2lwYy91dGlsLmMKaW5kZXggNzc2YTljZTI5MDVmLi5jOTg2NzVkODYx
MmUgMTAwNjQ0Ci0tLSBhL2lwYy91dGlsLmMKKysrIGIvaXBjL3V0aWwuYwpAQCAtMTkzLDUyICsx
OTMsMzIgQEAgc3RhdGljIHN0cnVjdCBrZXJuX2lwY19wZXJtICppcGNfZmluZGtleShzdHJ1Y3Qg
aXBjX2lkcyAqaWRzLCBrZXlfdCBrZXkpCiAJcmV0dXJuIE5VTEw7CiB9CiAKLSNpZmRlZiBDT05G
SUdfQ0hFQ0tQT0lOVF9SRVNUT1JFCiAvKgogICogU3BlY2lmeSBkZXNpcmVkIGlkIGZvciBuZXh0
IGFsbG9jYXRlZCBJUEMgb2JqZWN0LgogICovCi1zdGF0aWMgaW5saW5lIGludCBpcGNfaWRyX2Fs
bG9jKHN0cnVjdCBpcGNfaWRzICppZHMsCi0JCQkJc3RydWN0IGtlcm5faXBjX3Blcm0gKm5ldykK
K3N0YXRpYyBpbmxpbmUgaW50IGlwY19pZHJfYWxsb2Moc3RydWN0IGlwY19pZHMgKmlkcywgc3Ry
dWN0IGtlcm5faXBjX3Blcm0gKm5ldykKIHsKLQlpbnQga2V5OworCWludCBrZXksIG5leHRfaWQg
PSAtMTsKIAotCWlmIChpZHMtPm5leHRfaWQgPCAwKSB7Ci0JCWtleSA9IGlkcl9hbGxvYygmaWRz
LT5pcGNzX2lkciwgbmV3LCAwLCAwLCBHRlBfTk9XQUlUKTsKLQl9IGVsc2UgewotCQlrZXkgPSBp
ZHJfYWxsb2MoJmlkcy0+aXBjc19pZHIsIG5ldywKLQkJCQlpcGNpZF90b19pZHgoaWRzLT5uZXh0
X2lkKSwKLQkJCQkwLCBHRlBfTk9XQUlUKTsKLQkJaWRzLT5uZXh0X2lkID0gLTE7Ci0JfQotCXJl
dHVybiBrZXk7Ci19CisjaWZkZWYgQ09ORklHX0NIRUNLUE9JTlRfUkVTVE9SRQorCW5leHRfaWQg
PSBpZHMtPm5leHRfaWQ7CisJaWRzLT5uZXh0X2lkID0gLTE7CisjZW5kaWYKIAotc3RhdGljIGlu
bGluZSB2b2lkIGlwY19zZXRfc2VxKHN0cnVjdCBpcGNfaWRzICppZHMsCi0JCQkJc3RydWN0IGtl
cm5faXBjX3Blcm0gKm5ldykKLXsKLQlpZiAoaWRzLT5uZXh0X2lkIDwgMCkgeyAvKiBkZWZhdWx0
LCBiZWhhdmUgYXMgIUNIRUNLUE9JTlRfUkVTVE9SRSAqLworCWlmIChuZXh0X2lkIDwgMCkgeyAv
KiAhQ0hFQ0tQT0lOVF9SRVNUT1JFIG9yIG5leHRfaWQgaXMgdW5zZXQgKi8KIAkJbmV3LT5zZXEg
PSBpZHMtPnNlcSsrOwogCQlpZiAoaWRzLT5zZXEgPiBJUENJRF9TRVFfTUFYKQogCQkJaWRzLT5z
ZXEgPSAwOworCQlrZXkgPSBpZHJfYWxsb2MoJmlkcy0+aXBjc19pZHIsIG5ldywgMCwgMCwgR0ZQ
X05PV0FJVCk7CiAJfSBlbHNlIHsKLQkJbmV3LT5zZXEgPSBpcGNpZF90b19zZXF4KGlkcy0+bmV4
dF9pZCk7CisJCW5ldy0+c2VxID0gaXBjaWRfdG9fc2VxeChuZXh0X2lkKTsKKwkJa2V5ID0gaWRy
X2FsbG9jKCZpZHMtPmlwY3NfaWRyLCBuZXcsIGlwY2lkX3RvX2lkeChuZXh0X2lkKSwKKwkJCQkw
LCBHRlBfTk9XQUlUKTsKIAl9CisJbmV3LT5pZCA9IFNFUV9NVUxUSVBMSUVSICogbmV3LT5zZXEg
KyBrZXk7CisJcmV0dXJuIGtleTsKIH0KIAotI2Vsc2UKLSNkZWZpbmUgaXBjX2lkcl9hbGxvYyhp
ZHMsIG5ldykJCQkJCVwKLQlpZHJfYWxsb2MoJihpZHMpLT5pcGNzX2lkciwgKG5ldyksIDAsIDAs
IEdGUF9OT1dBSVQpCi0KLXN0YXRpYyBpbmxpbmUgdm9pZCBpcGNfc2V0X3NlcShzdHJ1Y3QgaXBj
X2lkcyAqaWRzLAotCQkJICAgICAgc3RydWN0IGtlcm5faXBjX3Blcm0gKm5ldykKLXsKLQluZXct
PnNlcSA9IGlkcy0+c2VxKys7Ci0JaWYgKGlkcy0+c2VxID4gSVBDSURfU0VRX01BWCkKLQkJaWRz
LT5zZXEgPSAwOwotfQotCi0jZW5kaWYgLyogQ09ORklHX0NIRUNLUE9JTlRfUkVTVE9SRSAqLwot
CiAvKioKICAqIGlwY19hZGRpZCAtIGFkZCBhbiBpcGMgaWRlbnRpZmllcgogICogQGlkczogaXBj
IGlkZW50aWZpZXIgc2V0CkBAIC0yNzgsOCArMjU4LDYgQEAgaW50IGlwY19hZGRpZChzdHJ1Y3Qg
aXBjX2lkcyAqaWRzLCBzdHJ1Y3Qga2Vybl9pcGNfcGVybSAqbmV3LCBpbnQgbGltaXQpCiAJY3Vy
cmVudF9ldWlkX2VnaWQoJmV1aWQsICZlZ2lkKTsKIAluZXctPmN1aWQgPSBuZXctPnVpZCA9IGV1
aWQ7CiAJbmV3LT5naWQgPSBuZXctPmNnaWQgPSBlZ2lkOwotCi0JaXBjX3NldF9zZXEoaWRzLCBu
ZXcpOwogCW5ldy0+ZGVsZXRlZCA9IGZhbHNlOwogCiAJLyoKQEAgLTMxNyw5ICsyOTUsNiBAQCBp
bnQgaXBjX2FkZGlkKHN0cnVjdCBpcGNfaWRzICppZHMsIHN0cnVjdCBrZXJuX2lwY19wZXJtICpu
ZXcsIGludCBsaW1pdCkKIAlpZHMtPmluX3VzZSsrOwogCWlmIChpZCA+IGlkcy0+bWF4X2lkKQog
CQlpZHMtPm1heF9pZCA9IGlkOwotCi0JbmV3LT5pZCA9IFNFUV9NVUxUSVBMSUVSICogbmV3LT5z
ZXEgKyBpZDsKLQogCXJldHVybiBpZDsKIH0KIAo=
--000000000000444a9205703c7242--
