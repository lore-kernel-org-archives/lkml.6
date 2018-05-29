Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2785586-1527633629-2-13269022160381280205
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527633628; b=QpqlWLV/jx9aa3t3SX+vuwhkIagPm/uI0phGQMCTNeim1coRsp
    uvlLpIN2AwJIBSNo//BMvSjBZE4ledVq3eBCHD5IKvjsAPUN7lcfoSDIHFnrptgq
    WsHWDhf/hqCcikrC+xHhQOgIysuCTemV4MM2lqc+WlF34kGNoM8qc3qwPTEXGCkX
    Q8WSivtYtjPX1daJlO8B3ezF/vwd1wlHDGTGs/E7n9Sbv2ThJSr7MuJkLUwFRnyK
    ds0mV4MNe9QhoabxAkaaZASNofsyUz4wGpfjgpH4iqFOFDQZN+4QgqNWLdx/GpD+
    X5TTvhCF4/SU+R/G62cid4FLReWDmUlNk+yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527633628; bh=cAJf/2JtGWptl1LHxuyEIXiKMUnvn2Z71zuwq659ba
    c=; b=I23/Z4+fu4wqTshLDRbTAVuJK/9X3NvME38F0adSC4Q9y8CCC/pusilj0+
    AkwmW73FgGLZyjFKOXGXGPRPyZ/ZrbJ94mPXOlHwdH1ATviqTsvI4ruVGxO4+M3I
    9ITfSmvB/78lYvy0qHURlXgdKlLe3KZrHtz+uDDM2UgA0/9cIKX/+gYOO8uVAQhv
    /EZz50i8RdNUs9il6UNbpI08EV/UnVYHDlhd4P6dkWLGu+U3LgsEH0eJtrwXsQ3U
    y7XGAtnjXRSsiDvxAAj85NPUpDIVGYhQopkku911sdZmtA/kBwIAjUA3hJzO83cB
    UDbsmr4REkeCrZH9ECvUsBAZCiyg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=paul-moore-com.20150623.gappssmtp.com
    header.i=@paul-moore-com.20150623.gappssmtp.com header.b=y4fOl0Zm
    header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=gbpzsnPo;
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
      header.i=@paul-moore-com.20150623.gappssmtp.com header.b=y4fOl0Zm
      header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=gbpzsnPo;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=paul-moore.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJJXbHF7TZhf5lcdiU2J1PsUgUOg+cT8OxR2bAVbdidhNtbHzFyJdqQwMkmnT+S+AI0BUvT/gdBqlOT0k7AAE79wqe7O0GdkM3RPEysijNvoD2qPuSij
    PzuetxYf43PQ99aRAQuwOaz2yNvBcR0xJOUdXPyG4/HRB5TiuS38tb2AQDKz9neamvdaKdzVYkfceU6+QchxA134Oj8Ns0DQcfLC7DhufPY7SvujPWzBN9uJ
    fNYQIfaeIEnw/a21CTybJg==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=EmDd13E5pkEA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8 a=xVhDTqbCAAAA:8
    a=vpqfxihKAAAA:8 a=VwQbUJbxAAAA:8 a=MSbAdP4cgrVjlDUEU-oA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=GrmWmAYt4dzCMttCBZOh:22 a=AULIiLoY-XQsE5F6gcqX:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967625AbeE2Wj6 (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 18:39:58 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40636 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967705AbeE2Wj4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 May 2018 18:39:56 -0400
X-Google-Smtp-Source: ADUXVKIvtO1TxhJJL9ANndp8gxMvuBiPK0ohF4ZSqrPRmnp6Tc2rRpz1bh69o18VUbDAJ+fW/nCLTkpPaINcNeKVpMs=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <1527616920-5415-9-git-send-email-zohar@linux.vnet.ibm.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com> <1527616920-5415-9-git-send-email-zohar@linux.vnet.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 29 May 2018 18:39:54 -0400
Message-ID: <CAHC9VhQL+CsqKL83fSZhjEZVSjKKfmLULvehXZ8SZhtK5xzLMQ@mail.gmail.com>
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

On Tue, May 29, 2018 at 2:02 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> Both the init_module and finit_module syscalls call either directly
> or indirectly the security_kernel_read_file LSM hook.  This patch
> replaces the direct call in init_module with a call to the new
> security_kernel_load_data hook and makes the corresponding changes in
> SELinux and IMA.
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Jeff Vander Stoep <jeffv@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  kernel/module.c                   |  2 +-
>  security/integrity/ima/ima_main.c | 24 ++++++++++--------------
>  security/selinux/hooks.c          | 26 ++++++++++++++++++++------
>  3 files changed, 31 insertions(+), 21 deletions(-)
>
> diff --git a/kernel/module.c b/kernel/module.c
> index ce8066b88178..b97c642b5b4d 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -2879,7 +2879,7 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
>         if (info->len < sizeof(*(info->hdr)))
>                 return -ENOEXEC;
>
> -       err = security_kernel_read_file(NULL, READING_MODULE);
> +       err = security_kernel_load_data(LOADING_MODULE);
>         if (err)
>                 return err;
>
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 3dae605a1604..0ff1d8152f6e 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -441,17 +441,6 @@ static int read_idmap[READING_MAX_ID] = {
>   */
>  int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
>  {
> -       bool sig_enforce = is_module_sig_enforced();
> -
> -       if (!file && read_id == READING_MODULE) {
> -               if (!sig_enforce && (ima_appraise & IMA_APPRAISE_MODULES) &&
> -                   (ima_appraise & IMA_APPRAISE_ENFORCE)) {
> -                       pr_err("impossible to appraise a module without a file descriptor. sig_enforce kernel parameter might help\n");
> -                       return -EACCES; /* INTEGRITY_UNKNOWN */
> -               }
> -               return 0;       /* We rely on module signature checking */
> -       }
> -
>         if (read_id == READING_FIRMWARE_PREALLOC_BUFFER) {
>                 if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
>                     (ima_appraise & IMA_APPRAISE_ENFORCE)) {
> @@ -490,9 +479,6 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
>                 return 0;
>         }
>
> -       if (!file && read_id == READING_MODULE) /* MODULE_SIG_FORCE enabled */
> -               return 0;
> -
>         /* permit signed certs */
>         if (!file && read_id == READING_X509_CERTIFICATE)
>                 return 0;
> @@ -521,6 +507,8 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
>   */
>  int ima_load_data(enum kernel_load_data_id id)
>  {
> +       bool sig_enforce;
> +
>         if ((ima_appraise & IMA_APPRAISE_ENFORCE) != IMA_APPRAISE_ENFORCE)
>                 return 0;
>
> @@ -536,6 +524,14 @@ int ima_load_data(enum kernel_load_data_id id)
>                         pr_err("Prevent firmware sysfs fallback loading.\n");
>                         return -EACCES; /* INTEGRITY_UNKNOWN */
>                 }
> +               break;
> +       case LOADING_MODULE:
> +               sig_enforce = is_module_sig_enforced();
> +
> +               if (!sig_enforce && (ima_appraise & IMA_APPRAISE_MODULES)) {
> +                       pr_err("impossible to appraise a module without a file descriptor. sig_enforce kernel parameter might help\n");
> +                       return -EACCES; /* INTEGRITY_UNKNOWN */
> +               }
>         default:
>                 break;
>         }
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 02ebd1585eaf..e02186470fc5 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4018,12 +4018,6 @@ static int selinux_kernel_module_from_file(struct file *file)
>         u32 sid = current_sid();
>         int rc;
>
> -       /* init_module */
> -       if (file == NULL)
> -               return avc_has_perm(&selinux_state,
> -                                   sid, sid, SECCLASS_SYSTEM,
> -                                       SYSTEM__MODULE_LOAD, NULL);
> -
>         /* finit_module */
>
>         ad.type = LSM_AUDIT_DATA_FILE;
> @@ -4043,6 +4037,25 @@ static int selinux_kernel_module_from_file(struct file *file)
>                                 SYSTEM__MODULE_LOAD, &ad);
>  }
>
> +static int selinux_kernel_load_data(enum kernel_load_data_id id)
> +{
> +       u32 sid;
> +       int rc = 0;
> +
> +       switch (id) {
> +       case LOADING_MODULE:
> +               sid = current_sid();
> +
> +               /* init_module */
> +               return avc_has_perm(&selinux_state, sid, sid, SECCLASS_SYSTEM,
> +                                   SYSTEM__MODULE_LOAD, NULL);
> +       default:
> +               break;
> +       }
> +
> +       return rc;
> +}

I'm not a fan of the duplication here.  If we must have a new LSM hook
for this, can we at least have it call
selinux_kernel_module_from_file() so we have all the kernel module
loading logic/controls in one function?  Yes, I understand there are
differences between init_module() and finit_module() but I like
handling them both in one function as we do today.

>  static int selinux_kernel_read_file(struct file *file,
>                                     enum kernel_read_file_id id)
>  {
> @@ -6950,6 +6963,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>         LSM_HOOK_INIT(kernel_act_as, selinux_kernel_act_as),
>         LSM_HOOK_INIT(kernel_create_files_as, selinux_kernel_create_files_as),
>         LSM_HOOK_INIT(kernel_module_request, selinux_kernel_module_request),
> +       LSM_HOOK_INIT(kernel_load_data, selinux_kernel_load_data),
>         LSM_HOOK_INIT(kernel_read_file, selinux_kernel_read_file),
>         LSM_HOOK_INIT(task_setpgid, selinux_task_setpgid),
>         LSM_HOOK_INIT(task_getpgid, selinux_task_getpgid),
> --
> 2.7.5
>

-- 
paul moore
www.paul-moore.com
