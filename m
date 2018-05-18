Return-Path: <casey@schaufler-ca.com>
X-Google-Smtp-Source: AB8JxZr9RG+kzBcH3CgGeijyDoToX3ujiPzOMwiHdC2DbDnJRJgjzC9Jc1JSjc1rI2YI2ZsFu+jA
ARC-Seal: i=1; a=rsa-sha256; t=1526603082; cv=none;
        d=google.com; s=arc-20160816;
        b=HYJ7q/ZKRduwh6Yo/RhBUZ1IDytOFWc3zMtePgLWzJQQnJiKlw9IR1U1GwvjxbRhKt
         Sz+w8pnL4A31OH43yAAc55hvXV1Pv9c9Z5co7n2RIU6xzAPizxMyRfNGuGA3QTYhjzub
         mMJQWH+oNon+TyrW0EEx4TxefZGktex2o7i6CWSTJmF+DpFnLGiFI9QOTbpNqrD2Fi0e
         o4MPtF8am5WAOu7zW6OMhPNbpuzZbHBK4wqo7b4CLEAu+ArcdwkWnOuEha5KQ1X19zlS
         WaoT4Knx8TDSCfPy51DB84qxDHDKycssefUFE6fdho2nDiuTdcwfygfJZi5payu8nQZH
         j22g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=Hn2UaiWgiClEk1OIfSkB21wepK0Bazi0hGIkS0gxcCA=;
        b=lWFvGLC4Om0JVszznGIHOybtsHumajO26OPUjNSou4OM1LbpuIfDhBKucKGF1d37DW
         HL2yPOsrl1qA/FGb0fJzk47rIss+eJyMqnPA6erH2s4tCJBp4jRZ1gyctrnQnoB9imzB
         yU7A1GRtgASurxq8hnPVvxflr0Oc/GGh/hurrBTjwJD3LSGd+Qm3oZSMoyvU2TeF5a8t
         gTOhci9s96KKrJrR1jMGcISUJoPERZkDWm19J1H6heNCNJMOFI4Swtgd2OYMEHo5+sxH
         dymf6T37ekPhhfBHd+Z+U0p5v0FTAVrKbOi52zM3hOu4Ns4wipX+eefsckpbJEQKLPFb
         KC3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@yahoo.com header.s=s2048 header.b=t4c5z3VC;
       spf=neutral (google.com: 66.163.189.90 is neither permitted nor denied by best guess record for domain of casey@schaufler-ca.com) smtp.mailfrom=casey@schaufler-ca.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@yahoo.com header.s=s2048 header.b=t4c5z3VC;
       spf=neutral (google.com: 66.163.189.90 is neither permitted nor denied by best guess record for domain of casey@schaufler-ca.com) smtp.mailfrom=casey@schaufler-ca.com
X-YMail-OSG: RdrzShUVM1nVF5Z.LMKCv3_qU2cluqY4seE00vDkPs_UPjctaVqsFfP5sIPwhcL
 Y87gXebPrqh2_0ius86D0ssSMukZWnNxoQm0jXiLla14dEEG92rXCTf1K72OpKWSOg0jI1fISTBi
 OD4374ON63AvwbO6T2jaXQr.LCLw7qztLHQ3YVH24BAvPsDO5p8T0gxjvoWpLk36PaFgW2asKokz
 wDQ2DatSqU.cSccKsHzrexcY24rvZG1khPwxAAtv2AHTDtEuh6wJRNKNaRhgDEPx2fYgXLQTGyT2
 prX4K.h8tCQhWyoC3K.aWmdIxFxOxa91ZjxZPecYHgm8t6lg6Oq8U4gf5sqEkGzkflVEWDeSCDhb
 ISYBdbvNlaNRGw5WX57Y353ORnPiaw0GUnWhc40pJH6GcY8CBXShE0a_XF6OqBV1rcLgicGlSf1o
 iDJDarNu6VJaqCQL7Y0DQUC.9ncxe28I3RXdh.pq9i1O5Pit_vzimWKw1rohfMBwqE8OlbCXNjZ.
 iHT8FgzL0PcM8_ns.oKRg7T9y3JkpoRNHAhDCeLS9P5E_8keGWbc9yrvgf6LpI9osKkJDjZt5FaN
 x3tkW23R__vqAezIlS2nH0pBfsi.XfA7TBBV1lJHOgC1L1tpzsr.d14M7sk42nOi51hFvK6BjPK7
 2_.0CzHF.jw--
Subject: Re: [PATCH v2 3/9] security: define security_kernel_read_blob()
 wrapper
To: Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Howells <dhowells@redhat.com>, "Luis R . Rodriguez"
 <mcgrof@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
 kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Kees Cook <keescook@chromium.org>
References: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1526568530-9144-4-git-send-email-zohar@linux.vnet.ibm.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <74c096ca-1ad1-799e-df3d-7b1b099333a7@schaufler-ca.com>
Date: Thu, 17 May 2018 17:24:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526568530-9144-4-git-send-email-zohar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600723179870285580?=
X-GMAIL-MSGID: =?utf-8?q?1600759354071269998?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 5/17/2018 7:48 AM, Mimi Zohar wrote:
> In order for LSMs and IMA-appraisal to differentiate between the original
> and new syscalls (eg. kexec, kernel modules, firmware), both the original
> and new syscalls must call an LSM hook.
>
> Commit 2e72d51b4ac3 ("security: introduce kernel_module_from_file hook")
> introduced calling security_kernel_module_from_file() in both the original
> and new syscalls.  Commit a1db74209483 ("module: replace
> copy_module_from_fd with kernel version") replaced these LSM calls with
> security_kernel_read_file().
>
> Commit e40ba6d56b41 ("firmware: replace call to fw_read_file_contents()
> with kernel version") and commit b804defe4297  ("kexec: replace call to
> copy_file_from_fd() with kernel version") replaced their own version of
> reading a file from the kernel with the generic
> kernel_read_file_from_path/fd() versions, which call the pre and post
> security_kernel_read_file LSM hooks.
>
> Missing are LSM calls in the original kexec syscall and firmware sysfs
> fallback method.  From a technical perspective there is no justification
> for defining a new LSM hook, as the existing security_kernel_read_file()
> works just fine.  The original syscalls, however, do not read a file, so
> the security hook name is inappropriate.  Instead of defining a new LSM
> hook, this patch defines security_kernel_read_blob() as a wrapper for
> the existing LSM security_kernel_file_read() hook.

What a marvelous opportunity to bikeshed!

I really dislike adding another security_ interface just because
the name isn't quite right. Especially a wrapper, which is just
code and execution overhead. Why not change security_kernel_read_file()
to security_kernel_read_blob() everywhere and be done?

>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
>
> Changelog v2:
> - Define a generic wrapper named security_kernel_read_blob() for
> security_kernel_read_file().
>
> Changelog v1:
> - Define and call security_kexec_load(), a wrapper for
> security_kernel_read_file().
> ---
>  include/linux/security.h | 6 ++++++
>  security/security.c      | 6 ++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 63030c85ee19..4db1967a688b 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -323,6 +323,7 @@ int security_kernel_module_request(char *kmod_name);
>  int security_kernel_read_file(struct file *file, enum kernel_read_file_id id);
>  int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
>  				   enum kernel_read_file_id id);
> +int security_kernel_read_blob(enum kernel_read_file_id id);
>  int security_task_fix_setuid(struct cred *new, const struct cred *old,
>  			     int flags);
>  int security_task_setpgid(struct task_struct *p, pid_t pgid);
> @@ -922,6 +923,11 @@ static inline int security_kernel_post_read_file(struct file *file,
>  	return 0;
>  }
>  
> +static inline int security_kernel_read_blob(enum kernel_read_file_id id)
> +{
> +	return 0;
> +}
> +
>  static inline int security_task_fix_setuid(struct cred *new,
>  					   const struct cred *old,
>  					   int flags)
> diff --git a/security/security.c b/security/security.c
> index 68f46d849abe..8f199b2bf4a2 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1044,6 +1044,12 @@ int security_kernel_read_file(struct file *file, enum kernel_read_file_id id)
>  }
>  EXPORT_SYMBOL_GPL(security_kernel_read_file);
>  
> +int security_kernel_read_blob(enum kernel_read_file_id id)
> +{
> +	return security_kernel_read_file(NULL, id);
> +}
> +EXPORT_SYMBOL_GPL(security_kernel_read_blob);
> +
>  int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
>  				   enum kernel_read_file_id id)
>  {
