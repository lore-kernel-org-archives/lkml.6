Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZoSvYD4EpnGGbmc90nwG1zmsJoZ46HP93KkzNgqTEJ/ic/BwT6mF3OZfnGGpfe01sbJqFT/
ARC-Seal: i=1; a=rsa-sha256; t=1525393305; cv=none;
        d=google.com; s=arc-20160816;
        b=0ztgDgbq5URfgtFq04FJJsEMk6nOQM/OJYHQrFwmrXKplpgyd2hF4OxCnvimXHSTXf
         yeO8x+cf9flX0M9cdXJjyloGvWS5R9SCCEnuuvCLk5GMdtnNCM7lLN5OE5TF6hgP75/8
         /7mHv1a0wjeWHqM0Wt79T/rZGEzEMcZQpJCjwiwOlsQ72EyupDBzla7D5LYmV5etNgXO
         koiQFgCWfch32BjBDm/x6zV9AEzja0pX+8AF8EQtNp8h8GGves8LINn11uFy3PSMFwT5
         fQ6kcc9J2GYqwpk6vsELfgLLiF9uNBv69pYDgNj9JEgWFOp+/W/LAuOardnaM6xDQk4r
         zgMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=LNg4SA4R4cK9NlEha7DSy8zTyzC24NfRnzqKR/goGZo=;
        b=Rulc5JM18J/kc/ZB0zZhW7bQLm4PbgnKt4me+rF1b7iZcfFWYOUF90gEOo1cx+IyrP
         bZp5UYJGLdZjAyzHAKh8SD7nYpWqOc+bwXpUew4ilV8KMkuxduGpPP6TjV+SKViDani2
         D7/KNb4CsQ72P48T5k9wtKCWsSwdtOuzS5RyelLQWb7AMSa+O5f7oZ2xjNfPm7Cz/Zy1
         CHrJbFLmyznSRWBXPMfwaO6GQpFd80aU9P2krGuXZfzUlPv7/A/IZ93raF5rk4w2HMgH
         /WGOwkeXpZRAKf3tLuA8Np9aEhdzMSZLinzv5rz6iFtgxb2U7FrYsEVrdubo5admJIla
         NhkA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Fri, 4 May 2018 00:21:42 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>, Stephen Boyd <sboyd@kernel.org>,
	Vikram Mulukutla <markivx@codeaurora.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Martijn Coenen <maco@android.com>, Todd Kjos <tkjos@android.com>,
	Andy Gross <andy.gross@linaro.org>,
	David Brown <david.brown@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-security-module@vger.kernel.org,
	Chris Wright <chrisw@sous-sol.org>,
	David Howells <dhowells@redhat.com>,
	Alan Cox <alan@linux.intel.com>, Kees Cook <keescook@chromium.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Andres Rodriguez <andresx7@gmail.com>,
	Darren Hart <dvhart@infradead.org>,
	Andy Shevchenko <andy@infradead.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Jones <pjones@redhat.com>, Dave Olsthoorn <dave@bewaar.me>,
	Will Deacon <will.deacon@arm.com>,
	Andy Lutomirski <luto@kernel.org>,
	Matt Fleming <matt@codeblueprint.co.uk>,
	Josh Triplett <josh@joshtriplett.org>, dmitry.torokhov@gmail.com,
	mfuzzey@parkeon.com, Kalle Valo <kvalo@codeaurora.org>,
	Arend Van Spriel <arend.vanspriel@broadcom.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, nbroeking@me.com,
	bjorn.andersson@linaro.org, Torsten Duwe <duwe@suse.de>,
	x86@kernel.org, linux-efi <linux-efi@vger.kernel.org>,
	devel@driverdev.osuosl.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 2/5] efi: Add embedded peripheral firmware support
Message-ID: <20180504002142.GT27853@wotan.suse.de>
References: <20180408174014.21908-1-hdegoede@redhat.com>
 <20180408174014.21908-3-hdegoede@redhat.com>
 <20180423211143.GZ14440@wotan.suse.de>
 <71e6a45a-398d-b7a4-dab0-8b9936683226@redhat.com>
 <1524586021.3364.20.camel@linux.vnet.ibm.com>
 <20180424234219.GX14440@wotan.suse.de>
 <1524632409.3371.48.camel@linux.vnet.ibm.com>
 <20180425175557.GY14440@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180425175557.GY14440@wotan.suse.de>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597199782052351527?=
X-GMAIL-MSGID: =?utf-8?q?1599490810483962098?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Android folks, poke below. otherwise we'll have no option but to seriously
consider Mimi's patch to prevent these calls when IMA appraisal is enforced:

http://lkml.kernel.org/r/1525182503-13849-7-git-send-email-zohar@linux.vnet.ibm.com

Please read below....

On Wed, Apr 25, 2018 at 05:55:57PM +0000, Luis R. Rodriguez wrote:
> On Wed, Apr 25, 2018 at 01:00:09AM -0400, Mimi Zohar wrote:
> > On Tue, 2018-04-24 at 23:42 +0000, Luis R. Rodriguez wrote:
> > > On Tue, Apr 24, 2018 at 12:07:01PM -0400, Mimi Zohar wrote:
> > > > On Tue, 2018-04-24 at 17:09 +0200, Hans de Goede wrote:
> > > If its of any help --
> > > 
> > > drivers/soc/qcom/mdt_loader.c is the only driver currently using
> > > request_firmware_into_buf() however I'll note qcom_mdt_load() is used in many
> > > other drivers so they are wrappers around request_firmware_into_buf():
> > > 
> > > drivers/gpu/drm/msm/adreno/a5xx_gpu.c:   * adreno_request_fw() handles this, but qcom_mdt_load() does
> > > drivers/gpu/drm/msm/adreno/a5xx_gpu.c:          ret = qcom_mdt_load(dev, fw, fwname, GPU_PAS_ID,
> > > drivers/gpu/drm/msm/adreno/a5xx_gpu.c:          ret = qcom_mdt_load(dev, fw, newname, GPU_PAS_ID,
> > > drivers/media/platform/qcom/venus/firmware.c:   ret = qcom_mdt_load(dev, mdt, fwname, VENUS_PAS_ID, mem_va, mem_phys,
> > > drivers/remoteproc/qcom_adsp_pil.c:     return qcom_mdt_load(adsp->dev, fw, rproc->firmware, adsp->pas_id,
> > > drivers/remoteproc/qcom_wcnss.c:        return qcom_mdt_load(wcnss->dev, fw, rproc->firmware, WCNSS_PAS_ID,
> > > 
> > > > > As such the current IMA code (from v4.17-rc2) actually does
> > > > > not handle READING_FIRMWARE_PREALLOC_BUFFER at all, 
> > > > 
> > > > Right, it doesn't yet address READING_FIRMWARE_PREALLOC_BUFFER, but
> > > > should.
> > > > 
> > > > Depending on whether the device requesting the firmware has access to
> > > > the DMA memory, before the signature verification, 
> > > 
> > > It would seem from the original patch review about READING_FIRMWARE_PREALLOC_BUFFER
> > > that this is not a DMA buffer.

To be very clear I believe Stephen implied this was not DMA buffer. Mimi
asked for READING_FIRMWARE_DMA if it was:

https://patchwork.kernel.org/patch/9074611/

> > The call sequence:
> > qcom_mdt_load() -> qcom_scm_pas_init_image() -> dma_alloc_coherent()
> > 
> > If dma_alloc_coherent() isn't allocating a DMA buffer, then the
> > function name is misleading/confusing.
> 
> Hah, by *definition* the device *and* processor has immediate access
> to data written *immediately* when dma_alloc_coherent() is used. From
> Documentation/DMA-API.txt:
> 
> -----------------------------------------------------------------------
> Part Ia - Using large DMA-coherent buffers                                      
> ------------------------------------------                                      
>                                                                                 
> ::                                                                              
>                                                                                 
>         void *                                                                  
>         dma_alloc_coherent(struct device *dev, size_t size,                     
>                            dma_addr_t *dma_handle, gfp_t flag)                  
>                                                                                 
> Consistent memory is memory for which a write by either the device or           
> the processor can immediately be read by the processor or device                
> without having to worry about caching effects.  (You may however need           
> to make sure to flush the processor's write buffers before telling              
> devices to read that memory.)  
> ------------------------------------------------------------------------
> 
> Is ptr below
> 
> 	ret = request_firmware_into_buf(&seg_fw, fw_name, dev,  
> 					ptr, phdr->p_filesz); 
> 
> Also part of the DMA buffer allocated earlier via:
> 
>         ret = qcom_scm_pas_init_image(pas_id, fw->data, fw->size);              
> 
> Android folks?

Android folks?

> > > The device driver should have access to the buffer pointer with write given
> > > that with request_firmware_into_buf() the driver is giving full write access to
> > > the memory pointer so that the firmware API can stuff the firmware it finds
> > > there.
> > > 
> > > Firmware signature verification would be up to the device hardware to do upon
> > > load *after* request_firmware_into_buf().
> > 
> > We're discussing the kernel's signature verification, not the device
> > hardware's signature verification.  Can the device driver access the
> > buffer, before IMA-appraisal has verified the firmware's signature?
> 
> It will depend on the above question.

  Luis
