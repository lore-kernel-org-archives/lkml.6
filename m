Return-Path: <zohar@linux.vnet.ibm.com>
X-Google-Smtp-Source: AIpwx48hKORWL56FR06GkHKoOp9QyykTzR4eJyOqfrS5WkMKp+HidmUCQRsTAb2U3IviDk4IwhTo
ARC-Seal: i=1; a=rsa-sha256; t=1524632431; cv=none;
        d=google.com; s=arc-20160816;
        b=gjf+IPZZ6s+i5d03hlljhxCwKV4QFrnbcA3CHs8y3L5WM7gjD7WfMhlnrMysdD3bZH
         OvlXi+mdqLRhHfnptha0zBxDGYH5doHDk6zYTfvoPvuGflXws/DpY3+lRFnuR2qblGkw
         A4pHAsZq0MD2IY5DUvBTnYAQKMcN2sX+/tSJUQa6BolynNTWEvgo2yc8wVxxgF5R5oT7
         Oo0Bp8VIQ1uUqPR5CzmpPx3Pxjpm/GlcveYBvNad/6d50J4p/Q4WTzhJkdBzbfeR+ODW
         FEztcdLtbBFFq6FPlwBeLkXFDp0aTRU5OXwXMop+3CrV0ZSOgQ519soBFet78vCnze4F
         m0Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:references
         :in-reply-to:date:cc:to:from:subject:arc-authentication-results;
        bh=/d4MvYTztGpFdAwHR22Au8pYS/pPN5MLOBWzAOCWE+4=;
        b=XW7alIJ1c6sSurEA8lLGsw93VLYPxkK0AHDXh124zjGPZz7pxvdBJvnnHwl9RJnnJP
         h/3Sl62D/mA6UdOf42tAEehXfUK4ny5HN+9B+W2fyanhlRSwKV/HphjVrituVnhkvakM
         tj3wjI8AkI8nyhFMv5/+XuuxphyEitNqaQhDqIOY1Ljyi9KohsdUlFjLlmnXs+N06udw
         MBWsTs0uk2lundo6eec3k3D4AEKSAj2oPD1OFFla/OcUPX1X1d+LTuc9XEKlDDfWjiwG
         xUnv0cIAZN/8QQo71HVz/Vgra9BIy7x6ZO4ljf9YrJLKHFF1kDAW81o9qCRGeX4vfq2H
         AE9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v3 2/5] efi: Add embedded peripheral firmware support
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Andrew Morton
 <akpm@linux-foundation.org>,
        linux-security-module@vger.kernel.org,
        Chris
 Wright <chrisw@sous-sol.org>,
        David Howells <dhowells@redhat.com>, Alan Cox
 <alan@linux.intel.com>,
        Kees Cook <keescook@chromium.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Ard Biesheuvel
 <ard.biesheuvel@linaro.org>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter
 Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>, Will Deacon
 <will.deacon@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Matt Fleming
 <matt@codeblueprint.co.uk>,
        Josh Triplett <josh@joshtriplett.org>, dmitry.torokhov@gmail.com,
        mfuzzey@parkeon.com, Kalle Valo
 <kvalo@codeaurora.org>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, nbroeking@me.com,
        bjorn.andersson@linaro.org, Torsten Duwe <duwe@suse.de>,
        x86@kernel.org, linux-efi <linux-efi@vger.kernel.org>
Date: Wed, 25 Apr 2018 01:00:09 -0400
In-Reply-To: <20180424234219.GX14440@wotan.suse.de>
References: <20180408174014.21908-1-hdegoede@redhat.com>
	 <20180408174014.21908-3-hdegoede@redhat.com>
	 <20180423211143.GZ14440@wotan.suse.de>
	 <71e6a45a-398d-b7a4-dab0-8b9936683226@redhat.com>
	 <1524586021.3364.20.camel@linux.vnet.ibm.com>
	 <20180424234219.GX14440@wotan.suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18042505-0044-0000-0000-0000054BC975
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042505-0045-0000-0000-0000288C03A8
Message-Id: <1524632409.3371.48.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-25_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804250043
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597199782052351527?=
X-GMAIL-MSGID: =?utf-8?q?1598692976808003590?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-04-24 at 23:42 +0000, Luis R. Rodriguez wrote:
> On Tue, Apr 24, 2018 at 12:07:01PM -0400, Mimi Zohar wrote:
> > On Tue, 2018-04-24 at 17:09 +0200, Hans de Goede wrote:
> > > Hi,
> > > 
> > > On 23-04-18 23:11, Luis R. Rodriguez wrote:
> > > > Hans, please see use of READING_FIRMWARE_PREALLOC_BUFFER, we'll need a new ID
> > > > and security for this type of request so IMA can reject it if the policy is
> > > > configured for it.
> > > 
> > > Hmm, interesting, actually it seems like the whole existence
> > > of READING_FIRMWARE_PREALLOC_BUFFER is a mistake, 
> 
> request_firmware_into_buf() was merged without my own review, however,
> the ID thing did get review from Mimi:
> 
> https://patchwork.kernel.org/patch/9074611/
> 
> The ID is not for IMA alone, its for any LSM to decide what to do.
> Note Mimi asked for READING_FIRMWARE_DMA if such buffer was in DMA,
> otherise READING_FIRMWARE_PREALLOC_BUFFER was suggested.
> 
> > > the IMA
> > > framework really does not care if we are loading the firmware
> > > into memory allocated by the firmware-loader code, or into
> > > memory allocated by the device-driver requesting the firmware.
> 
> That's up to LSM folks to decide. We have these so far:
> 
> #define __kernel_read_file_id(id) \                                             
>         id(UNKNOWN, unknown)            \                                       
>         id(FIRMWARE, firmware)          \                                       
>         id(FIRMWARE_PREALLOC_BUFFER, firmware)  \                               
>         id(MODULE, kernel-module)               \                               
>         id(KEXEC_IMAGE, kexec-image)            \                               
>         id(KEXEC_INITRAMFS, kexec-initramfs)    \                               
>         id(POLICY, security-policy)             \                               
>         id(X509_CERTIFICATE, x509-certificate)  \                               
>         id(MAX_ID, )  
> 
> The first type of IDs added was about type of files the kernel
> LSMs may want to do different things for.
> 
> Mimi why did you want a separate ID for it back before?

The point of commit a098ecd2fa7d ("firmware: support loading into a
pre-allocated buffer") is to avoid reading the firmware into kernel
memory and then copying it "to it's final resting place".  My concern
is that if the device driver has access to the buffer, it could access
the buffer prior to the firmware's signature having been verified by
the kernel.

In tightly controlled environments interested in limiting which signed
firmware version is loaded, require's the device driver not having
access to the buffer until after the signature has been verified by
the kernel (eg. IMA-appraisal).

> 
> I should note now that request_firmware_into_buf() and its
> READING_FIRMWARE_PREALLOC_BUFFER was to enable a driver on memory constrained
> devices. The files are large (commit says 16 MiB).
> 
> I've heard of larger possible files with remoteproc and with Android using
> the custom fallback mechanism -- which could mean a proprietary tool
> fetching firmware from a random special place on a device.
> 
> I could perhaps imagine an LSM which may be aware of such type of
> arrangement may want to do its own vetting of some sort, but this
> would not be specific to READING_FIRMWARE_PREALLOC_BUFFER, but rather
> the custom fallback mechaism.
> 
> Whether or not the buffer was preallocated by the driver seems a little
> odd for security folks to do something different with it. Security LSM
> folks please chime in.
> 
> I could see a bit more of a use case for an ID for firmware scraped
> from EFI, which Hans' patch will provide. But that *also* should get
> good review from other LSM folks.
> 
> One of the issues with accepting more IDs loosely is where do we
> stop though? If no one really is using READING_FIRMWARE_PREALLOC_BUFFER
> I'd say lets remove it. Likewise, for this EFI thing I'd like an idea
> if we really are going to have users for it.
> 
> If its of any help --
> 
> drivers/soc/qcom/mdt_loader.c is the only driver currently using
> request_firmware_into_buf() however I'll note qcom_mdt_load() is used in many
> other drivers so they are wrappers around request_firmware_into_buf():
> 
> drivers/gpu/drm/msm/adreno/a5xx_gpu.c:   * adreno_request_fw() handles this, but qcom_mdt_load() does
> drivers/gpu/drm/msm/adreno/a5xx_gpu.c:          ret = qcom_mdt_load(dev, fw, fwname, GPU_PAS_ID,
> drivers/gpu/drm/msm/adreno/a5xx_gpu.c:          ret = qcom_mdt_load(dev, fw, newname, GPU_PAS_ID,
> drivers/media/platform/qcom/venus/firmware.c:   ret = qcom_mdt_load(dev, mdt, fwname, VENUS_PAS_ID, mem_va, mem_phys,
> drivers/remoteproc/qcom_adsp_pil.c:     return qcom_mdt_load(adsp->dev, fw, rproc->firmware, adsp->pas_id,
> drivers/remoteproc/qcom_wcnss.c:        return qcom_mdt_load(wcnss->dev, fw, rproc->firmware, WCNSS_PAS_ID,
> 
> Are we going to add more IDs for more types of firmware?
> What type of *different* decisions could LSMs take if the firmware
> was being written to a buffer? Or in this new case that is coming
> up, if the file came scraping EFI, would having that information
> be useful?
> 
> > > As such the current IMA code (from v4.17-rc2) actually does
> > > not handle READING_FIRMWARE_PREALLOC_BUFFER at all, 
> > 
> > Right, it doesn't yet address READING_FIRMWARE_PREALLOC_BUFFER, but
> > should.
> > 
> > Depending on whether the device requesting the firmware has access to
> > the DMA memory, before the signature verification, 
> 
> It would seem from the original patch review about READING_FIRMWARE_PREALLOC_BUFFER
> that this is not a DMA buffer.

The call sequence:
qcom_mdt_load() -> qcom_scm_pas_init_image() -> dma_alloc_coherent()

If dma_alloc_coherent() isn't allocating a DMA buffer, then the
function name is misleading/confusing.

> 
> The device driver should have access to the buffer pointer with write given
> that with request_firmware_into_buf() the driver is giving full write access to
> the memory pointer so that the firmware API can stuff the firmware it finds
> there.
> 
> Firmware signature verification would be up to the device hardware to do upon
> load *after* request_firmware_into_buf().

We're discussing the kernel's signature verification, not the device
hardware's signature verification.  Can the device driver access the
buffer, before IMA-appraisal has verified the firmware's signature?

Mimi

> 
>   Luis
> 
> > will determine how
> > IMA-appraisal addresses READING_FIRMWARE_PREALLOC_BUFFER.
> > 
> > Mimi
> > 
> > > here
> > > are bits of code from: security/integrity/ima/ima_main.c:
> > > 
> > > static int read_idmap[READING_MAX_ID] = {
> > >          [READING_FIRMWARE] = FIRMWARE_CHECK,
> > >          [READING_MODULE] = MODULE_CHECK,
> > >          [READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
> > >          [READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,
> > >          [READING_POLICY] = POLICY_CHECK
> > > };
> > > 
> > > int ima_post_read_file(struct file *file, void *buf, loff_t size,
> > > 	...
> > >          if (!file && read_id == READING_FIRMWARE) {
> > >                  if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
> > >                      (ima_appraise & IMA_APPRAISE_ENFORCE))
> > >                          return -EACCES; /* INTEGRITY_UNKNOWN */
> > >                  return 0;
> > >          }
> > > 
> > > Which show that the IMA code is not handling
> > > READING_FIRMWARE_PREALLOC_BUFFER as it should (I believe it
> > > should handle it the same as READING_FIRMWARE).
> > > 
> > > Now we could fix that, but the only user of
> > > READING_FIRMWARE_PREALLOC_BUFFER is the code which originally
> > > introduced it:
> > > 
> > > https://patchwork.kernel.org/patch/9162011/
> > > 
> > > So I believe it might be better to instead replace it
> > > with just READING_FIRMWARE and find another way to tell
> > > kernel_read_file() that there is a pre-allocated buffer,
> > > perhaps the easiest way there is that  *buf must be
> > > NULL when the caller wants kernel_read_file() to
> > > vmalloc the mem. This would of course require auditing
> > > all callers that the buf which the pass in is initialized
> > > to NULL.
> > > 
> > > Either way adding a third READING_FIRMWARE_FOO to the
> > > kernel_read_file_id enum seems like a bad idea, from
> > > the IMA pov firmware is firmware.
> > > 
> > > What this whole exercise has shown me though is that
> > > I need to call security_kernel_post_read_file() when
> > > loading EFI embedded firmware. I will add a call to
> > > security_kernel_post_read_file() for v4 of the patch-set.
> > > 
> > > > Please Cc Kees in future patches.
> > > 
> > > Will do.
> > > 
> > > Regards,
> > > 
> > > Hans
> > > 
> > 
> > 
> 
