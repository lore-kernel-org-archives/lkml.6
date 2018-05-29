Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2840403-1527636317-2-14773007901524046966
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527636317; b=KQDp3IsCx30iNUb6uefrIormU9sT18rSOAviWGJM9KrRiy6QSB
    VdvyJfmsNNHI16rij2lZFFaNY7X25j4ktmIsU5VSPSD9FcIWoo0g2P66Cr1Bi4SE
    H7/BoRynYKT93PiJXeRvFOLIBt4W/jAPmRhDsXnxD6v15/LXoiJmr0ea27ADbJJF
    z9Fnn5+zg09np0ImDtX+crLnPj3pm3bznbR9a984HKMRS6WxjB//T+0FSE8XTzEZ
    rj70kfDtZWxlUxmPk5uukY1HaOp/cJ8RMcAIbBPpR+FPOVls84vxkZsoUvYee7zR
    KSM5mA0dSgqIG3Sj8NHWQn2WQlSk3hVbWh2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:in-reply-to
    :references:content-type:mime-version:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1527636317; bh=kplM125CFdou
    fW44t1TBod4DbTzeV5AUzlyUilXmd5E=; b=Bw2IDckNSaYwzhi2EEDnFRjzWCWt
    QSg0LyBikUnIDZBlApFmt6UTB9gNW+rARHgsU7eQgk6/qThTidY9G0DTI9inYR8e
    fCQjXnx1k7ZLxv2o1c+/4M+fEPz18sBSN/MXtkG65FAsHvfd/p2wwpoJa5W6EHfO
    zhRDsYSyCysCjg3Cvk3IG+qF1KEkNVrhIkhwwXF4h78l6tZxORJKD9Q9vghaAKXa
    b8vJdM/ez5WIr2w3rJkXnmDAQggnj8noiL/AdHtiJp3zYsLJMW4HGFqWJV9WnkAn
    +JC/minjxMC/w4jmZrjJgDCeWev2ylWOOrTuL4rpQFQgpHgLw4OyY/Sc7w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
    header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.vnet.ibm.com header.result=pass
    header_org.domain=ibm.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
      header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.vnet.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfETaEQAaVW1Cv1f2HPnapVIYiLWyeR6u/PfFMuMuoXczOcrAckj1+Th5QRQQz7JbQ+ebtvbAKwIoAp3qcyczQbwZ4E90ITfUugXuudDRzCKDBkNyjn9a
    T4yp9ZfU7TMXZCra0RhWI/iOikt2vwt2xGRhbQw+rOQFigc4mQBxOJ5/citpPge41SwWjUMKREtHVj+YrAxxMrBV0sJnM+X70r7Y83KakOyCVyRDMUPNpcyd
    p+wxEWBn+vDoK1jqlR0c9w==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8 a=xVhDTqbCAAAA:8 a=vpqfxihKAAAA:8
    a=VwQbUJbxAAAA:8 a=W3_5baIey23v17qd1qgA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=GrmWmAYt4dzCMttCBZOh:22 a=AULIiLoY-XQsE5F6gcqX:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967768AbeE2XZP (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 19:25:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56384 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S967758AbeE2XZO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 May 2018 19:25:14 -0400
Subject: Re: [PATCH v4 8/8] module: replace the existing LSM hook in
 init_module
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Paul Moore <paul@paul-moore.com>, Kees Cook <keescook@chromium.org>
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
Date: Tue, 29 May 2018 19:25:02 -0400
In-Reply-To: <CAHC9VhQL+CsqKL83fSZhjEZVSjKKfmLULvehXZ8SZhtK5xzLMQ@mail.gmail.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1527616920-5415-9-git-send-email-zohar@linux.vnet.ibm.com>
         <CAHC9VhQL+CsqKL83fSZhjEZVSjKKfmLULvehXZ8SZhtK5xzLMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18052923-0012-0000-0000-000005DBD40D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052923-0013-0000-0000-0000195939B9
Message-Id: <1527636302.3534.46.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-29_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805290249
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Kees,

Missing from this patch are the loadpin changes.  Before including
them in the next version of this patch, do you prefer separating the
init_module from the finit_module support in loadpin_read_file() or
keeping it as one function, like Paul for SELinux?

Mimi

On Tue, 2018-05-29 at 18:39 -0400, Paul Moore wrote:
> On Tue, May 29, 2018 at 2:02 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > Both the init_module and finit_module syscalls call either directly
> > or indirectly the security_kernel_read_file LSM hook.  This patch
> > replaces the direct call in init_module with a call to the new
> > security_kernel_load_data hook and makes the corresponding changes in
> > SELinux and IMA.
> >
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > Cc: Jeff Vander Stoep <jeffv@google.com>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: Casey Schaufler <casey@schaufler-ca.com>
> > ---
> >  kernel/module.c                   |  2 +-
> >  security/integrity/ima/ima_main.c | 24 ++++++++++--------------
> >  security/selinux/hooks.c          | 26 ++++++++++++++++++++------
> >  3 files changed, 31 insertions(+), 21 deletions(-)
> >
> > diff --git a/kernel/module.c b/kernel/module.c
> > index ce8066b88178..b97c642b5b4d 100644
> > --- a/kernel/module.c
> > +++ b/kernel/module.c
> > @@ -2879,7 +2879,7 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
> >         if (info->len < sizeof(*(info->hdr)))
> >                 return -ENOEXEC;
> >
> > -       err = security_kernel_read_file(NULL, READING_MODULE);
> > +       err = security_kernel_load_data(LOADING_MODULE);
> >         if (err)
> >                 return err;
> >
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index 3dae605a1604..0ff1d8152f6e 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -441,17 +441,6 @@ static int read_idmap[READING_MAX_ID] = {
> >   */
> >  int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
> >  {
> > -       bool sig_enforce = is_module_sig_enforced();
> > -
> > -       if (!file && read_id == READING_MODULE) {
> > -               if (!sig_enforce && (ima_appraise & IMA_APPRAISE_MODULES) &&
> > -                   (ima_appraise & IMA_APPRAISE_ENFORCE)) {
> > -                       pr_err("impossible to appraise a module without a file descriptor. sig_enforce kernel parameter might help\n");
> > -                       return -EACCES; /* INTEGRITY_UNKNOWN */
> > -               }
> > -               return 0;       /* We rely on module signature checking */
> > -       }
> > -
> >         if (read_id == READING_FIRMWARE_PREALLOC_BUFFER) {
> >                 if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
> >                     (ima_appraise & IMA_APPRAISE_ENFORCE)) {
> > @@ -490,9 +479,6 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
> >                 return 0;
> >         }
> >
> > -       if (!file && read_id == READING_MODULE) /* MODULE_SIG_FORCE enabled */
> > -               return 0;
> > -
> >         /* permit signed certs */
> >         if (!file && read_id == READING_X509_CERTIFICATE)
> >                 return 0;
> > @@ -521,6 +507,8 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
> >   */
> >  int ima_load_data(enum kernel_load_data_id id)
> >  {
> > +       bool sig_enforce;
> > +
> >         if ((ima_appraise & IMA_APPRAISE_ENFORCE) != IMA_APPRAISE_ENFORCE)
> >                 return 0;
> >
> > @@ -536,6 +524,14 @@ int ima_load_data(enum kernel_load_data_id id)
> >                         pr_err("Prevent firmware sysfs fallback loading.\n");
> >                         return -EACCES; /* INTEGRITY_UNKNOWN */
> >                 }
> > +               break;
> > +       case LOADING_MODULE:
> > +               sig_enforce = is_module_sig_enforced();
> > +
> > +               if (!sig_enforce && (ima_appraise & IMA_APPRAISE_MODULES)) {
> > +                       pr_err("impossible to appraise a module without a file descriptor. sig_enforce kernel parameter might help\n");
> > +                       return -EACCES; /* INTEGRITY_UNKNOWN */
> > +               }
> >         default:
> >                 break;
> >         }
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 02ebd1585eaf..e02186470fc5 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -4018,12 +4018,6 @@ static int selinux_kernel_module_from_file(struct file *file)
> >         u32 sid = current_sid();
> >         int rc;
> >
> > -       /* init_module */
> > -       if (file == NULL)
> > -               return avc_has_perm(&selinux_state,
> > -                                   sid, sid, SECCLASS_SYSTEM,
> > -                                       SYSTEM__MODULE_LOAD, NULL);
> > -
> >         /* finit_module */
> >
> >         ad.type = LSM_AUDIT_DATA_FILE;
> > @@ -4043,6 +4037,25 @@ static int selinux_kernel_module_from_file(struct file *file)
> >                                 SYSTEM__MODULE_LOAD, &ad);
> >  }
> >
> > +static int selinux_kernel_load_data(enum kernel_load_data_id id)
> > +{
> > +       u32 sid;
> > +       int rc = 0;
> > +
> > +       switch (id) {
> > +       case LOADING_MODULE:
> > +               sid = current_sid();
> > +
> > +               /* init_module */
> > +               return avc_has_perm(&selinux_state, sid, sid, SECCLASS_SYSTEM,
> > +                                   SYSTEM__MODULE_LOAD, NULL);
> > +       default:
> > +               break;
> > +       }
> > +
> > +       return rc;
> > +}
> 
> I'm not a fan of the duplication here.  If we must have a new LSM hook
> for this, can we at least have it call
> selinux_kernel_module_from_file() so we have all the kernel module
> loading logic/controls in one function?  Yes, I understand there are
> differences between init_module() and finit_module() but I like
> handling them both in one function as we do today.
> 
> >  static int selinux_kernel_read_file(struct file *file,
> >                                     enum kernel_read_file_id id)
> >  {
> > @@ -6950,6 +6963,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
> >         LSM_HOOK_INIT(kernel_act_as, selinux_kernel_act_as),
> >         LSM_HOOK_INIT(kernel_create_files_as, selinux_kernel_create_files_as),
> >         LSM_HOOK_INIT(kernel_module_request, selinux_kernel_module_request),
> > +       LSM_HOOK_INIT(kernel_load_data, selinux_kernel_load_data),
> >         LSM_HOOK_INIT(kernel_read_file, selinux_kernel_read_file),
> >         LSM_HOOK_INIT(task_setpgid, selinux_task_setpgid),
> >         LSM_HOOK_INIT(task_getpgid, selinux_task_getpgid),
> > --
> > 2.7.5
> >
> 

