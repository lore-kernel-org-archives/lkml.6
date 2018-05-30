Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-298618-1527714012-2-868919430305443796
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527714011; b=dCFTio2jzyaTwnKVRBozdF4M+1P6psuVdcceNsoWU2dqmGuzDV
    YYNbzhKW2H08uTVxSSvgs/V5ceiz1PI0YkxC8QMCdJ4k2e1hMZNPVuHMDUtsI5aT
    OSJcp59ydgXq3YNK0dngD8iYFt4MyX0AADKmArsWPri6hyWG8RM9ps3gtvcfCt5j
    2/6TQjx+ds3V0N5EX/4TAfDp+Yl8ebHWuzCGUV1KZ8g3hVbabbg1TO4KHHLfgwz1
    Ipi0OhZ1S/bqO4hHNx4v7nieBXtjQPSHNE+A8ZNLKAJ7MXPe5TWBjR3KisdjGzJ1
    Yt50PQHm9usDGe8HqZAOQGddQno5T3f2Mw8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527714011; bh=UrmzhnTDB8Am2qmlgkw9Gtiw5Ohe8/mBJQhS7nQ9tU
    c=; b=Nhb+cu3I4UGKtiFOCGT6lC6RylGqX2ZOborN+6UtPiXYXs/am8G0YsNEd+
    OJ/odYEOzaQrwENLxippjpsVsTg2Vd+voRQSriC68tNnVU9nyJd7uN9sAt5uuStz
    fDcXZDP/5Cw7TrUeuaCiCEG95gojrwJU8tPrXxJH+g/ZZGbgCMNhv3zc91nUFtMU
    H+5Px6xt210lUytJzTuZMegeFqMUqtoDF0JHrxbNZxyIJydDPCpT1Y2ibZ5WKlZd
    /oUdhOpHSLEYsQYVhnXv6ls7GklIkQUUNxFWBLn2HHhTjECE6KWri8kYpaAvtyb9
    R9F3BYi2Lhv0P43NfYbAH8+FE+cA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=paul-moore-com.20150623.gappssmtp.com
    header.i=@paul-moore-com.20150623.gappssmtp.com header.b=vfytkEzU
    header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=IGcOia7R;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=paul-moore.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=paul-moore-com.20150623.gappssmtp.com
      header.i=@paul-moore-com.20150623.gappssmtp.com header.b=vfytkEzU
      header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=IGcOia7R;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=paul-moore.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEHMfPZUfE4tejdil6NFU108VVGVx6J9swjvMjpzU8EMtbIshkBgwQTsUepRLw12dUeJbg8dlcwCA+ojSBovpsZQz7HXRQxUn4/8VHYdVYxkRSABH3mp
    WJ2KKIouqLcDxr39TVoKtR9wdBtKDKjKn35H6bZ0Mk+q/kwfbCca9kkX6p+g8LvEILIm9SQ8X8zDlTSGkaHhouNqyxlOZwQDNTmcbkR1yaixFkaaFC0haqQz
    fhAZOxkKMX0iH1LZK9ntUg==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=EmDd13E5pkEA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=VnNF1IyMAAAA:8 a=xVhDTqbCAAAA:8 a=VwQbUJbxAAAA:8
    a=jeWM6FH8Fq5rde5H3XAA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=GrmWmAYt4dzCMttCBZOh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932337AbeE3VAI (ORCPT <rfc822;linux@kroah.com>);
        Wed, 30 May 2018 17:00:08 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42705 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932283AbeE3VAH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 May 2018 17:00:07 -0400
X-Google-Smtp-Source: ADUXVKJN56tLnUsPHLp52sFQq9BsxIrKgfs3pEjXm5VhfzQnVQlSc4t3IWWwfyzuVj7pBP9l1h2N8+t2D5wTZLU7v/U=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <1527635645.3534.39.camel@linux.vnet.ibm.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1527616920-5415-9-git-send-email-zohar@linux.vnet.ibm.com>
 <CAHC9VhQL+CsqKL83fSZhjEZVSjKKfmLULvehXZ8SZhtK5xzLMQ@mail.gmail.com> <1527635645.3534.39.camel@linux.vnet.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 30 May 2018 17:00:04 -0400
Message-ID: <CAHC9VhQQX-JAnV-6jEOsug-6siyO9mrNa=rYK9Whg-MYcfHxgA@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] module: replace the existing LSM hook in init_module
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 29, 2018 at 7:14 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Tue, 2018-05-29 at 18:39 -0400, Paul Moore wrote:
> [...]
>> > @@ -4043,6 +4037,25 @@ static int selinux_kernel_module_from_file(struct file *file)
>> >                                 SYSTEM__MODULE_LOAD, &ad);
>> >  }
>> >
>> > +static int selinux_kernel_load_data(enum kernel_load_data_id id)
>> > +{
>> > +       u32 sid;
>> > +       int rc = 0;
>> > +
>> > +       switch (id) {
>> > +       case LOADING_MODULE:
>> > +               sid = current_sid();
>> > +
>> > +               /* init_module */
>> > +               return avc_has_perm(&selinux_state, sid, sid, SECCLASS_SYSTEM,
>> > +                                   SYSTEM__MODULE_LOAD, NULL);
>> > +       default:
>> > +               break;
>> > +       }
>> > +
>> > +       return rc;
>> > +}
>>
>> I'm not a fan of the duplication here.  If we must have a new LSM hook
>> for this, can we at least have it call
>> selinux_kernel_module_from_file() so we have all the kernel module
>> loading logic/controls in one function?  Yes, I understand there are
>> differences between init_module() and finit_module() but I like
>> handling them both in one function as we do today.
>
> There's some disagreement as to whether we really need two LSM hooks.
>  This sounds like you would prefer a single LSM hook, not the two that
> this patch set introduces.
>
> We need to come to some consensus.  (Comments appreciated in 0/8.)

My comments were intentionally made on the SELinux specific code and
not the LSM generic code/hooks.  As the LSM hook code must not make
any assumptions about the underlying LSM implementations, it may make
sense to have two different hooks.  However as far as the SELinux code
is concerned I would rather keep the access controls in one function
as mentioned above.  From a purely selfish SELinux perspective I would
prefer a single hook, but if others feel two hooks are better, that's
fine with me too.

>> >  static int selinux_kernel_read_file(struct file *file,
>> >                                     enum kernel_read_file_id id)
>> >  {
>> > @@ -6950,6 +6963,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>> >         LSM_HOOK_INIT(kernel_act_as, selinux_kernel_act_as),
>> >         LSM_HOOK_INIT(kernel_create_files_as, selinux_kernel_create_files_as),
>> >         LSM_HOOK_INIT(kernel_module_request, selinux_kernel_module_request),
>> > +       LSM_HOOK_INIT(kernel_load_data, selinux_kernel_load_data),
>> >         LSM_HOOK_INIT(kernel_read_file, selinux_kernel_read_file),
>> >         LSM_HOOK_INIT(task_setpgid, selinux_task_setpgid),
>> >         LSM_HOOK_INIT(task_getpgid, selinux_task_getpgid),
>> > --
>> > 2.7.5

-- 
paul moore
www.paul-moore.com
