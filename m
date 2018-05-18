Return-Path: <zohar@linux.vnet.ibm.com>
X-Google-Smtp-Source: AB8JxZobT9OgaGOuS70mVg+9iDdzn2gmz5YnJJsUkPC1WJWFG4Eptpnt9pldr+RDHiQaxJK+LrZI
ARC-Seal: i=1; a=rsa-sha256; t=1526643072; cv=none;
        d=google.com; s=arc-20160816;
        b=qR3NPT9WttS8cBzam5+owiTgfotMEpfr6f1u12wlAYnI20OdHkq3ZcNGfxGqfpdoqr
         zBdx9gffLvVjiGum/wxFlUWwfRyEXlAeP/Bm8/wclTyW67kk7nm7fKBWEaXbTTJDqOmA
         NHypL8sTdTfNlm5mmUkZhpuk8rYiXAcVMMm5bSFFC5neraUVgXXikBRqJ75mfNzErbJ/
         F6VkfM5vaO7ObM8eiWSAB/mMhOaFHGiaHT0NTazzRVHcQP8A+uH/S5bELx3L0j6C9Swh
         gFJ9+oX09TbdKwbntAZdr6VODlqvvHBCmID6ZB7TuDe6SDMTK8g0/cM7WOxOsog1y1A7
         m4+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:references
         :in-reply-to:date:cc:to:from:subject:arc-authentication-results;
        bh=PnvUUV9+iPyBbarM/Si0aVEAMHhT+s34E6du0CM0G5c=;
        b=j+r7hRfTaE6A4UL1wWw7bkJPmx1Ph1/ctf4RYHvT+A7HmnoemaRLcOfqalKbRzRE3S
         uF7Lc/JDNfTtkpTdE6t6ywI+Hnz0Ils5rNwp73c75CNntadxBufXVW09vK+jTpifJ3jC
         FhOtxG7X/wwEGqaw5cbOXvKEBGRPvDpvzyurRsVOhI9nEa7G6nrN5OjdWC9Tqn7if9se
         n+uBTtPMx+I10emcf1idNizs0OjZmsxdKlz6VOw7frtr85AL1oEW8IOOYY43tIjLPwo/
         u2h2J79IvmW1B4qQ7uIfh2vWPB+Nv5gC1uP5vmK2PBmbcJ754ykM0DwFiX45DwpXPF5Y
         gMZg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v2 3/9] security: define security_kernel_read_blob()
 wrapper
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        Casey Schaufler
	 <casey@schaufler-ca.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R
 . Rodriguez" <mcgrof@kernel.org>, kexec@lists.infradead.org,
        Andres
 Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>, Stephen Smalley <sds@tycho.nsa.gov>
Date: Fri, 18 May 2018 07:30:50 -0400
In-Reply-To: <87y3ghhbws.fsf@xmission.com>
References: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
	 <1526568530-9144-4-git-send-email-zohar@linux.vnet.ibm.com>
	 <74c096ca-1ad1-799e-df3d-7b1b099333a7@schaufler-ca.com>
	 <87y3ghhbws.fsf@xmission.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18051811-0040-0000-0000-0000045AD902
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051811-0041-0000-0000-000020FF17AC
Message-Id: <1526643050.3632.127.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-18_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805180128
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600723179870285580?=
X-GMAIL-MSGID: =?utf-8?q?1600801286649365632?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-05-17 at 22:37 -0500, Eric W. Biederman wrote:
> Casey Schaufler <casey@schaufler-ca.com> writes:
> 
> > On 5/17/2018 7:48 AM, Mimi Zohar wrote:
> >> In order for LSMs and IMA-appraisal to differentiate between the original
> >> and new syscalls (eg. kexec, kernel modules, firmware), both the original
> >> and new syscalls must call an LSM hook.
> >>
> >> Commit 2e72d51b4ac3 ("security: introduce kernel_module_from_file hook")
> >> introduced calling security_kernel_module_from_file() in both the original
> >> and new syscalls.  Commit a1db74209483 ("module: replace
> >> copy_module_from_fd with kernel version") replaced these LSM calls with
> >> security_kernel_read_file().
> >>
> >> Commit e40ba6d56b41 ("firmware: replace call to fw_read_file_contents()
> >> with kernel version") and commit b804defe4297  ("kexec: replace call to
> >> copy_file_from_fd() with kernel version") replaced their own version of
> >> reading a file from the kernel with the generic
> >> kernel_read_file_from_path/fd() versions, which call the pre and post
> >> security_kernel_read_file LSM hooks.
> >>
> >> Missing are LSM calls in the original kexec syscall and firmware sysfs
> >> fallback method.  From a technical perspective there is no justification
> >> for defining a new LSM hook, as the existing security_kernel_read_file()
> >> works just fine.  The original syscalls, however, do not read a file, so
> >> the security hook name is inappropriate.  Instead of defining a new LSM
> >> hook, this patch defines security_kernel_read_blob() as a wrapper for
> >> the existing LSM security_kernel_file_read() hook.
> >
> > What a marvelous opportunity to bikeshed!
> >
> > I really dislike adding another security_ interface just because
> > the name isn't quite right. Especially a wrapper, which is just
> > code and execution overhead. Why not change security_kernel_read_file()
> > to security_kernel_read_blob() everywhere and be done?
> 
> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> Nack on this sharing nonsense.  These two interfaces do not share any
> code in their implementations other than the if statement to distinguish
> between the two cases.
> 
> Casey you are wrong.  We need something different here.
> 
> Mimi a wrapper does not cut it.   The code is not shared.  Despite using
> a single function call today.
> 
> If we want comprehensible and maintainable code in the security modules
> we need to split these two pieces of functionality apart.

kernel_read_file() is a common, generic method of reading a file from
the kernel, which is being called from a number of places.  The
kernel_read_file_id enumeration is needed to differentiate between the
callers.  The purpose of the new security_kernel_read_file() calls is
not for the kernel to read a file, but as a method of identifying the
original buffer based methods containing a file.

Having to define a separate LSM hook for each of the original, non
kernel_read_file(), buffer based method callers, kind of makes sense,
as the callers themselves are specific, but is it really necessary?
Could we define a new, generic LSM hook named
security_kernel_buffer_data() for this purpose?

Mimi
