Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C99C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553BF2494F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AXA+LJyj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 553BF2494F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933901AbeFVW16 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 18:27:58 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:32779 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932918AbeFVW14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 18:27:56 -0400
Received: by mail-ot0-f196.google.com with SMTP id h6-v6so9176542otj.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 15:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5GcbRm6HzPO4iWWcYRomDO/imqkOEksleLhNqIxIHSk=;
        b=AXA+LJyjvFGpjfGPUA82Gu72EmhUaOkc9FulD7gs3hISPXtbuunYY4XcvhkxTpWrWA
         V7t+dH0sk1cP740jBLIx168GTabE3qUOHtljM9tGTz40y/JwcJpSF40K9kXMh1GJWafP
         kkh+AJrkHobQg+8meY7x/vmLpEY8ZWqWea90VxxmBLm4rTomS1mWj2fde8GCShZXCndn
         XR6lwaL2fTbI/WdVeLdCRfXTqzQgd3jiuG/lMU0exCruswv7/zINW3iD8+elV7IGvaR8
         tiDjfNf5612laDVJFZqjgbjsmSfI0i5B60ZPKfd4lHKnFvLuVuSCd/P7vJiEqiIL+THw
         KljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5GcbRm6HzPO4iWWcYRomDO/imqkOEksleLhNqIxIHSk=;
        b=N+Qlsn1NBjLifA3SI7QJUTXCO3tiqhGSy5RpMf88LMDsnaja8LpX5FxElwK5KVyppa
         mplWdY0hVJz2H2lPR1jwHI2zLPJPv8gdfrm+OtJjwd6aYTb5IbjY04V0YWV/QwIYhWmH
         fXYBIEyyiFGXqKoLOD9uw/GOj6u7Mb+FSlKVZK7qk6nVTC5xAeWiffbINju7BQOxqeUG
         ecWvftXNBKhvhapUkdbWcGpA4uwqBgSg8R8A0Fekw0mb25UfPfGqiHbYYgYyTaCAJjbv
         wHADGca/0bCjTWv1mq32OpRqrrwNWhVU3kUkE4rRknTIH6A8d7e+lyEdMgE/8rhXJFGk
         oJMQ==
X-Gm-Message-State: APt69E2XpCYT5aaWFvBZgRMuzo7WhZcj3jg0LdjWwhb666LATDBbv7kw
        LrCRWFr5XB44Kv4FC9VvirLh1Ia0Oxodf4VBebnRkg==
X-Google-Smtp-Source: ADUXVKKwAoIpmEHkMKLTmtbPA1noHsP5I21FDqYVYEaRUPS3c8GjKwhoxKN0zbhFdA5G3pl0hq8hET5L+k+soY+E6sM=
X-Received: by 2002:a9d:8ac:: with SMTP id 41-v6mr2186587otf.115.1529706475596;
 Fri, 22 Jun 2018 15:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180621220416.5412-1-tycho@tycho.ws> <20180621220416.5412-2-tycho@tycho.ws>
 <CAG48ez3Ek_KG54ejR=Q=XtW_HDs8hQ+cgFODzn4rQ0nVDVpODg@mail.gmail.com>
 <20180622151514.GM3992@cisco> <E8029AD7-7009-4CBF-911E-186328237176@amacapital.net>
 <CAGXu5jKWQCDzXPdTz=+bxT9+4enaBvgYfMseUiGti+t1KwZT8g@mail.gmail.com>
In-Reply-To: <CAGXu5jKWQCDzXPdTz=+bxT9+4enaBvgYfMseUiGti+t1KwZT8g@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 23 Jun 2018 00:27:43 +0200
Message-ID: <CAG48ez3gobTL5mUnZKjhLedotZx49nGrxYKKud5_7+512PaOFw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] seccomp: add a return code to trap to userspace
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Tycho Andersen <tycho@tycho.ws>,
        kernel list <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Linux API <linux-api@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        suda.akihiro@lab.ntt.co.jp, "Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 11:51 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Jun 22, 2018 at 11:09 AM, Andy Lutomirski <luto@amacapital.net> w=
rote:
> > One possible extra issue: IIRC /proc/.../mem uses FOLL_FORCE, which is =
not what we want here.

Uuugh, I forgot about that.

> > How about just adding an explicit =E2=80=9Cread/write the seccomp-trapp=
ed task=E2=80=99s memory=E2=80=9D primitive?  That should be easier than a =
=E2=80=9Copen mem fd=E2=80=9D primitive.
>
> Uuugh. Can we avoid adding another "read/write remote process memory"
> interface? The point of this series was to provide a lightweight
> approach to what should normally be possible via the existing
> seccomp+ptrace interface. I do like Jann's context idea, but I agree
> with Andy: it can't be a handle to /proc/$pid/mem, since it's
> FOLL_FORCE. Is there any other kind of process context id we can use
> for this instead of pid? There was once an idea of pid-fd but it never
> landed... This would let us get rid of the "id" in the structure too.
> And if that existed, we could make process_vm_*v() safer too (taking a
> pid-fd instead of a pid).

Or make a duplicate of /proc/$pid/mem that only differs in whether it
sets FOLL_FORCE? The code is basically already there... something like
this:

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 80aa42506b8b..e8a6a63046da 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -762,6 +762,8 @@ static int mem_open(struct inode *inode, struct file *f=
ile)
        return ret;
 }

+static const struct file_operations proc_mem_operations;
+
 static ssize_t mem_rw(struct file *file, char __user *buf,
                        size_t count, loff_t *ppos, int write)
 {
@@ -782,7 +784,10 @@ static ssize_t mem_rw(struct file *file, char __user *=
buf,
        if (!mmget_not_zero(mm))
                goto free;

-       flags =3D FOLL_FORCE | (write ? FOLL_WRITE : 0);
+       flags =3D (write ? FOLL_WRITE : 0);
+       if (file->f_op =3D=3D &proc_mem_operations) {
+               flags |=3D FOLL_FORCE;
+       }

        while (count > 0) {
                int this_len =3D min_t(int, count, PAGE_SIZE);
@@ -861,6 +866,14 @@ static const struct file_operations proc_mem_operation=
s =3D {
        .release        =3D mem_release,
 };

+static const struct file_operations proc_mem_noforce_operations =3D {
+       .llseek         =3D mem_lseek,
+       .read           =3D mem_read,
+       .write          =3D mem_write,
+       .open           =3D mem_open,
+       .release        =3D mem_release,
+};
+
 static int environ_open(struct inode *inode, struct file *file)
 {
        return __mem_open(inode, file, PTRACE_MODE_READ);
@@ -2916,6 +2929,7 @@ static const struct pid_entry tgid_base_stuff[] =3D {
        REG("numa_maps",  S_IRUGO, proc_pid_numa_maps_operations),
 #endif
        REG("mem",        S_IRUSR|S_IWUSR, proc_mem_operations),
+       REG("mem_noforce", S_IRUSR|S_IWUSR, proc_mem_noforce_operations),
        LNK("cwd",        proc_cwd_link),
        LNK("root",       proc_root_link),
        LNK("exe",        proc_exe_link),
@@ -3302,6 +3316,7 @@ static const struct pid_entry tid_base_stuff[] =3D {
        REG("numa_maps", S_IRUGO, proc_tid_numa_maps_operations),
 #endif
        REG("mem",       S_IRUSR|S_IWUSR, proc_mem_operations),
+       REG("mem_noforce",S_IRUSR|S_IWUSR, proc_mem_noforce_operations),
        LNK("cwd",       proc_cwd_link),
        LNK("root",      proc_root_link),
        LNK("exe",       proc_exe_link),
