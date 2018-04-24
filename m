Return-Path: <zohar@linux.vnet.ibm.com>
X-Google-Smtp-Source: AIpwx4/9FS/3htOh9blX2uiQoHxoy9atkwcW/BtnZg8/xUNd7grsgrKXVJiaFlG1S+aKI/pN0jDc
ARC-Seal: i=1; a=rsa-sha256; t=1524586043; cv=none;
        d=google.com; s=arc-20160816;
        b=tIM3BdNGonBJJi+occaMgUKfiJi7vvOwGoZVWlzmDh3s0xP815Nhs2EK4zbDSpzRv9
         H2QeBFJBwWo7umN9v/fHOcV5ZiqqqMdQ4E1U5JkjdSGEwLGYj73oeEAEowWhzxeyAgmC
         niVQ4HIjnjtfpOeqA0zS1cEgi7Rn6tZyfxL4HsW0NO9w+KgpmDpQtrHgdKWS2YIA0YnE
         zwmFhl4CR9n5K69j34/KbLagZTCuzmVrzjY97+EFW4eljAQMs+xnivQZiwyzv1cLoDa3
         5J2lD6djoFpBHdevE05/IUMhBVrSLIscI+xK8ap+DduW7lrJFtNErJIuR2CT5UIJp2du
         nOyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:references
         :in-reply-to:date:cc:to:from:subject:arc-authentication-results;
        bh=iNqEB40QbE2HWEbUkBVQgCwP0S8hDHwcy5gURElcwDs=;
        b=l0T0njkaSDfXCSDWC6mToUuXNlxXIwSQwq8rpTbhuhydq9aeD0rw2pRhBp6/aernRf
         q0KZ5r0jjW0/C3BGtCd1Hc6ORJz+2jKvg7c4nCJT2j61Mo9BZZ7s+fugr2aWQbjKLDb2
         VnoJ6ZjsthnF1bPZx0tqvxeRzxE8SwLdD4ttQdtWX1LriqqHPEkP2SICCBlJJbQ73ucc
         RnY/yPlD3QcjTS77U4msyQnnVP2vJnTAEw094I0tfyHznIS0xo3YPaF/RoCPApOYys+b
         0IWZqZT5qMthG74ERYNAwqYUkQClypVm46BENqeBC6NCsiFzJsDrnkM9W9s1wg8FiTQK
         UBrw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v3 2/5] efi: Add embedded peripheral firmware support
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Hans de Goede <hdegoede@redhat.com>,
        "Luis R. Rodriguez"
 <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko
 <andy@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin"
 <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Jones <pjones@redhat.com>, Dave
 Olsthoorn <dave@bewaar.me>,
        Will Deacon <will.deacon@arm.com>, Andy
 Lutomirski <luto@kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        David Howells <dhowells@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, dmitry.torokhov@gmail.com,
        mfuzzey@parkeon.com, Kalle Valo
 <kvalo@codeaurora.org>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, nbroeking@me.com,
        bjorn.andersson@linaro.org, Torsten Duwe <duwe@suse.de>,
        x86@kernel.org, linux-efi@vger.kernel.org
Date: Tue, 24 Apr 2018 12:07:01 -0400
In-Reply-To: <71e6a45a-398d-b7a4-dab0-8b9936683226@redhat.com>
References: <20180408174014.21908-1-hdegoede@redhat.com>
	 <20180408174014.21908-3-hdegoede@redhat.com>
	 <20180423211143.GZ14440@wotan.suse.de>
	 <71e6a45a-398d-b7a4-dab0-8b9936683226@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18042416-0040-0000-0000-000004326A53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042416-0041-0000-0000-000026369A0B
Message-Id: <1524586021.3364.20.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-24_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804240153
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597199782052351527?=
X-GMAIL-MSGID: =?utf-8?q?1598644334855505112?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-04-24 at 17:09 +0200, Hans de Goede wrote:
> Hi,
> 
> On 23-04-18 23:11, Luis R. Rodriguez wrote:
> > Hans, please see use of READING_FIRMWARE_PREALLOC_BUFFER, we'll need a new ID
> > and security for this type of request so IMA can reject it if the policy is
> > configured for it.
> 
> Hmm, interesting, actually it seems like the whole existence
> of READING_FIRMWARE_PREALLOC_BUFFER is a mistake, the IMA
> framework really does not care if we are loading the firmware
> into memory allocated by the firmware-loader code, or into
> memory allocated by the device-driver requesting the firmware.
> 
> As such the current IMA code (from v4.17-rc2) actually does
> not handle READING_FIRMWARE_PREALLOC_BUFFER at all, 

Right, it doesn't yet address READING_FIRMWARE_PREALLOC_BUFFER, but
should.

Depending on whether the device requesting the firmware has access to
the DMA memory, before the signature verification, will determine how
IMA-appraisal addresses READING_FIRMWARE_PREALLOC_BUFFER.

Mimi

> here
> are bits of code from: security/integrity/ima/ima_main.c:
> 
> static int read_idmap[READING_MAX_ID] = {
>          [READING_FIRMWARE] = FIRMWARE_CHECK,
>          [READING_MODULE] = MODULE_CHECK,
>          [READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
>          [READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,
>          [READING_POLICY] = POLICY_CHECK
> };
> 
> int ima_post_read_file(struct file *file, void *buf, loff_t size,
> 	...
>          if (!file && read_id == READING_FIRMWARE) {
>                  if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
>                      (ima_appraise & IMA_APPRAISE_ENFORCE))
>                          return -EACCES; /* INTEGRITY_UNKNOWN */
>                  return 0;
>          }
> 
> Which show that the IMA code is not handling
> READING_FIRMWARE_PREALLOC_BUFFER as it should (I believe it
> should handle it the same as READING_FIRMWARE).
> 
> Now we could fix that, but the only user of
> READING_FIRMWARE_PREALLOC_BUFFER is the code which originally
> introduced it:
> 
> https://patchwork.kernel.org/patch/9162011/
> 
> So I believe it might be better to instead replace it
> with just READING_FIRMWARE and find another way to tell
> kernel_read_file() that there is a pre-allocated buffer,
> perhaps the easiest way there is that  *buf must be
> NULL when the caller wants kernel_read_file() to
> vmalloc the mem. This would of course require auditing
> all callers that the buf which the pass in is initialized
> to NULL.
> 
> Either way adding a third READING_FIRMWARE_FOO to the
> kernel_read_file_id enum seems like a bad idea, from
> the IMA pov firmware is firmware.
> 
> What this whole exercise has shown me though is that
> I need to call security_kernel_post_read_file() when
> loading EFI embedded firmware. I will add a call to
> security_kernel_post_read_file() for v4 of the patch-set.
> 
> > Please Cc Kees in future patches.
> 
> Will do.
> 
> Regards,
> 
> Hans
> 
