Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-306461-1525447608-2-1772865853955395666
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525447607; b=Mpgx2Hu+naRksCzXl2w0uGez6wbHctl/0lws1uMKvTXwLxsJt+
    izZpprBcOXZXQQuUG+FUBNk4KmXMuL2tt7PjNDHJd/heGyYSZlM0QuPt4oiKj0YF
    1EcEi99IrRt61hQDhVhQrmoHYyToKzOX3yTStyCVOFGvFhqoZ4BMvQUCQY5gnp5T
    kZzw5Am6s35KgiS3DSwebiz5zfyF5Nw+NuAHgs76DmHODdSntG3SKWQ4XOvrZDf3
    CBU4DmR6SN76zGF9UigJzfsooV02QKNJsVIthua6TgaB1IrksJj/ovRRAPnSrhFI
    AeraLbB8+onXoQE+eGXrQ+SXHzDtj5/hfKkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525447607; bh=Rbr5+
    lM2cC7cg2yOzbU8xqiFLSEiV3X0c8TlV2RsksM=; b=LkP6RTHpBL6/YeKsVBXQK
    74Y+elEMGp5O8Ppsrce/ZifYRYol96ztWc6liAHytGjV+Q48PZPf3rkFIkH1D3ne
    6emqEhKi35ZhGG8AR25ZTD/1FtJldxkk15Mj9TUI9qkw0qd74rlJ+8d/XXLbgkaB
    qtPBAtMyGAzXnvSSqLQLET/kLzSCbPgvD/gJ/+QPQW8RHA6CBVCfKzKBiFHGx7M8
    mWnsEUNFHZk3mgSxOGaO+0QgyRsUCfFSg6k4YGWjD1jvQMi5ZyIN7VMgv8Nb8BR3
    5suMn42vigTm9y8J/fu3fr4oMCw+uHUQbySKgM2UQfK9hQgP4BAGLNkqs/83N6NT
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=android.com header.i=@android.com header.b=m7GPMUls
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=NKeQltKL;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=android.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=android.com header.i=@android.com header.b=m7GPMUls
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=NKeQltKL;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=android.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOI9woJZT2SZ56dS2rYnRFQiuQ+hz29CippmhMCsh1C2Eu48WaQ215O9S4b3jRpRzxriiXmO4Muugdo4i0k+wkH3vg/hwDvA1cf9G7S1AkHfMAfgO/EX
    xE0z4il5G7FO3rExwIxK6XlDo5luckBSnQTiU0rC3Seq1Lm/K//c86TiKFOkuIW4ydA+b4/ZYxDGsTvVp2Ji1PbB4n5zRsUyu3ZWp5+gcz8M2cf/WmnMoiNM
    iugP5Y3gfYA1+R7zqhInOQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
    a=DDOyTI_5AAAA:8 a=lBUK0qYsD22MGMrTQREA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZqma3D2PwtIBWJ6XxdArndbm9K3Gmzp/5GAUF+2z7b9GF490bBPyW5t7qj3STL4Ug18WYv0OZmMWeSl+v3ktBk=
MIME-Version: 1.0
In-Reply-To: <20180504002142.GT27853@wotan.suse.de>
References: <20180408174014.21908-1-hdegoede@redhat.com>
 <20180408174014.21908-3-hdegoede@redhat.com>
 <20180423211143.GZ14440@wotan.suse.de>
 <71e6a45a-398d-b7a4-dab0-8b9936683226@redhat.com>
 <1524586021.3364.20.camel@linux.vnet.ibm.com>
 <20180424234219.GX14440@wotan.suse.de>
 <1524632409.3371.48.camel@linux.vnet.ibm.com>
 <20180425175557.GY14440@wotan.suse.de>
 <20180504002142.GT27853@wotan.suse.de>
From: Martijn Coenen <maco@android.com>
Date: Fri, 4 May 2018 08:26:39 -0700
Message-ID: <CAB0TPYEEPq+jPfOjQmHYoXauicR=-C+APdy--1NDPUnW01i-TA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] efi: Add embedded peripheral firmware support
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: dmitry.torokhov@gmail.com, Matt Fleming <matt@codeblueprint.co.uk>,
 Will Deacon <will.deacon@arm.com>, platform-driver-x86@vger.kernel.org,
 David Howells <dhowells@redhat.com>, David Brown <david.brown@linaro.org>,
 Peter Jones <pjones@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>, nbroeking@me.com,
 x86@kernel.org, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
 Ingo Molnar <mingo@redhat.com>, Andres Rodriguez <andresx7@gmail.com>,
 Andy Gross <andy.gross@linaro.org>, Darren Hart <dvhart@infradead.org>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Arend Van Spriel <arend.vanspriel@broadcom.com>, Todd Kjos <tkjos@android.com>,
 Kees Cook <keescook@chromium.org>, linux-efi <linux-efi@vger.kernel.org>,
 linux-arm-msm@vger.kernel.org, Torsten Duwe <duwe@suse.de>,
 Josh Triplett <josh@joshtriplett.org>, Chris Wright <chrisw@sous-sol.org>,
 Hans de Goede <hdegoede@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, bjorn.andersson@linaro.org,
 Kalle Valo <kvalo@codeaurora.org>, Alan Cox <alan@linux.intel.com>,
 mfuzzey@parkeon.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vikram Mulukutla <markivx@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-security-module@vger.kernel.org, Dave Olsthoorn <dave@bewaar.me>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 3, 2018 at 5:21 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> Android folks, poke below. otherwise we'll have no option but to seriously
> consider Mimi's patch to prevent these calls when IMA appraisal is enforced:

Sorry, figuring out who's the right person to answer this, will get
back to you ASAP.

Martijn

>
> http://lkml.kernel.org/r/1525182503-13849-7-git-send-email-zohar@linux.vnet.ibm.com
>
> Please read below....
>
> On Wed, Apr 25, 2018 at 05:55:57PM +0000, Luis R. Rodriguez wrote:
>> On Wed, Apr 25, 2018 at 01:00:09AM -0400, Mimi Zohar wrote:
>> > On Tue, 2018-04-24 at 23:42 +0000, Luis R. Rodriguez wrote:
>> > > On Tue, Apr 24, 2018 at 12:07:01PM -0400, Mimi Zohar wrote:
>> > > > On Tue, 2018-04-24 at 17:09 +0200, Hans de Goede wrote:
>> > > If its of any help --
>> > >
>> > > drivers/soc/qcom/mdt_loader.c is the only driver currently using
>> > > request_firmware_into_buf() however I'll note qcom_mdt_load() is used in many
>> > > other drivers so they are wrappers around request_firmware_into_buf():
>> > >
>> > > drivers/gpu/drm/msm/adreno/a5xx_gpu.c:   * adreno_request_fw() handles this, but qcom_mdt_load() does
>> > > drivers/gpu/drm/msm/adreno/a5xx_gpu.c:          ret = qcom_mdt_load(dev, fw, fwname, GPU_PAS_ID,
>> > > drivers/gpu/drm/msm/adreno/a5xx_gpu.c:          ret = qcom_mdt_load(dev, fw, newname, GPU_PAS_ID,
>> > > drivers/media/platform/qcom/venus/firmware.c:   ret = qcom_mdt_load(dev, mdt, fwname, VENUS_PAS_ID, mem_va, mem_phys,
>> > > drivers/remoteproc/qcom_adsp_pil.c:     return qcom_mdt_load(adsp->dev, fw, rproc->firmware, adsp->pas_id,
>> > > drivers/remoteproc/qcom_wcnss.c:        return qcom_mdt_load(wcnss->dev, fw, rproc->firmware, WCNSS_PAS_ID,
>> > >
>> > > > > As such the current IMA code (from v4.17-rc2) actually does
>> > > > > not handle READING_FIRMWARE_PREALLOC_BUFFER at all,
>> > > >
>> > > > Right, it doesn't yet address READING_FIRMWARE_PREALLOC_BUFFER, but
>> > > > should.
>> > > >
>> > > > Depending on whether the device requesting the firmware has access to
>> > > > the DMA memory, before the signature verification,
>> > >
>> > > It would seem from the original patch review about READING_FIRMWARE_PREALLOC_BUFFER
>> > > that this is not a DMA buffer.
>
> To be very clear I believe Stephen implied this was not DMA buffer. Mimi
> asked for READING_FIRMWARE_DMA if it was:
>
> https://patchwork.kernel.org/patch/9074611/
>
>> > The call sequence:
>> > qcom_mdt_load() -> qcom_scm_pas_init_image() -> dma_alloc_coherent()
>> >
>> > If dma_alloc_coherent() isn't allocating a DMA buffer, then the
>> > function name is misleading/confusing.
>>
>> Hah, by *definition* the device *and* processor has immediate access
>> to data written *immediately* when dma_alloc_coherent() is used. From
>> Documentation/DMA-API.txt:
>>
>> -----------------------------------------------------------------------
>> Part Ia - Using large DMA-coherent buffers
>> ------------------------------------------
>>
>> ::
>>
>>         void *
>>         dma_alloc_coherent(struct device *dev, size_t size,
>>                            dma_addr_t *dma_handle, gfp_t flag)
>>
>> Consistent memory is memory for which a write by either the device or
>> the processor can immediately be read by the processor or device
>> without having to worry about caching effects.  (You may however need
>> to make sure to flush the processor's write buffers before telling
>> devices to read that memory.)
>> ------------------------------------------------------------------------
>>
>> Is ptr below
>>
>>       ret = request_firmware_into_buf(&seg_fw, fw_name, dev,
>>                                       ptr, phdr->p_filesz);
>>
>> Also part of the DMA buffer allocated earlier via:
>>
>>         ret = qcom_scm_pas_init_image(pas_id, fw->data, fw->size);
>>
>> Android folks?
>
> Android folks?
>
>> > > The device driver should have access to the buffer pointer with write given
>> > > that with request_firmware_into_buf() the driver is giving full write access to
>> > > the memory pointer so that the firmware API can stuff the firmware it finds
>> > > there.
>> > >
>> > > Firmware signature verification would be up to the device hardware to do upon
>> > > load *after* request_firmware_into_buf().
>> >
>> > We're discussing the kernel's signature verification, not the device
>> > hardware's signature verification.  Can the device driver access the
>> > buffer, before IMA-appraisal has verified the firmware's signature?
>>
>> It will depend on the above question.
>
>   Luis
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
