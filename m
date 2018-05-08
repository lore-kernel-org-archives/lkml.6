Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2981746-1525793902-2-16727381027112135805
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525793900; b=nsOgX9zRhOTMRSUqH22XyzZCUHwreXGWpmCVTfULyPelGgk6CV
    kc+5b3U9lBLCmq0jrKgutAPW2X907HmYjiaIeFJsgYZctZaxRuRTZGctKHD++rO7
    ec6A8EjvYCLCFz7oxueTqTRvp7NqzXKywaSgPGgJOUEsrEvOjhTLUPFUVT9b/oT6
    x/d54gVRHL2FQbGcvKv8LF1km2s1ALy/HUXU+u3gs877yBkHDOSaW1IRWkpovP/0
    4XnoolePBmn39M9pWq/eumaBp5VtRpj705LDCtXbQIrY6B9Gx7mlTS21ZEsEuJD0
    euepoO4Olsv573l5uhZ6Hmug9/p/sMqlvqzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525793900; bh=VDs9l
    8tyuv8YdcXIuhzEGSdDQCm/lRTnhkMo3JzQvpo=; b=ljlPQFHSY6UukD/107GhT
    C9Fl69Ys4SCeEpwd7+yivCyM/uyC7P1mzqMzVh0rc9Y2uoKVEXteUPHqKPaQcmQP
    QgujSr6xvivIqQmPBhlWIRK8A030ZgYFDeCu+QEdcwrFEawEJDDeOB7+OrKztzNJ
    neCm7PSqaJqIgtyuFqzQZnQCZQ4ri8DyS28BhF5J8Z/5KRCLls1s2NQbEsoZYc6b
    Zjs/Fr4hU8J7KppgAq8h5p0/1tVrMx/L4pagTln5O3bo9QijFJ5kxB5ccBPBkOCa
    CZojaovxwH0Qh0FOFZgovsd2M9PxVbwXuDewtw21x9ACx5TR7WcY+kzkH8RLkCX2
    A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNw0wHgoIHyiQ9cYBxJLkGgv6gfsH1MHef8cdxYsFYGU+cVSM9JMPIs76cP1ANzEtFtfHglBeBAuhmZw7uFeez5BlOaKhyQrfif/koDqeRwquF9GdFbH
    jNF0crQ9FLCkaMX3K3dym+tyUAdV71kSH6ZambkDC0lEguavszXzTsvOf8a4UU9FcTCUaTYMmb0ZVGmoJ5jvChzQbVyc/xTPH9F5adaowhDqDyECcz3rUcik
    7HzlFPWri00eHjjI0NbM6g==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8 a=DDOyTI_5AAAA:8
    a=laZnSQGQ1tk_wvC2IXcA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 8 May 2018 15:38:05 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Martijn Coenen <maco@android.com>, Andy Gross <andy.gross@linaro.org>,
 David Brown <david.brown@linaro.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v3 2/5] efi: Add embedded peripheral firmware support
Message-ID: <20180508153805.GC27853@wotan.suse.de>
References: <20180408174014.21908-1-hdegoede@redhat.com>
 <20180408174014.21908-3-hdegoede@redhat.com>
 <20180423211143.GZ14440@wotan.suse.de>
 <71e6a45a-398d-b7a4-dab0-8b9936683226@redhat.com>
 <1524586021.3364.20.camel@linux.vnet.ibm.com>
 <20180424234219.GX14440@wotan.suse.de>
 <1524632409.3371.48.camel@linux.vnet.ibm.com>
 <20180425175557.GY14440@wotan.suse.de>
 <CAB0TPYGnCu+anWHBGvkaigxD--8uHQaQJ2c62kegJ7mTqvkmnA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAB0TPYGnCu+anWHBGvkaigxD--8uHQaQJ2c62kegJ7mTqvkmnA@mail.gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
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
 David Howells <dhowells@redhat.com>, Peter Jones <pjones@redhat.com>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>, nbroeking@me.com,
 x86@kernel.org, Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
 Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Arend Van Spriel <arend.vanspriel@broadcom.com>, Todd Kjos <tkjos@android.com>,
 Kees Cook <keescook@chromium.org>, linux-efi <linux-efi@vger.kernel.org>,
 linux-arm-msm@vger.kernel.org, Torsten Duwe <duwe@suse.de>,
 Josh Triplett <josh@joshtriplett.org>, Chris Wright <chrisw@sous-sol.org>,
 Hans de Goede <hdegoede@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Kalle Valo <kvalo@codeaurora.org>,
 Alan Cox <alan@linux.intel.com>, mfuzzey@parkeon.com,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
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

On Fri, May 04, 2018 at 12:44:37PM -0700, Martijn Coenen wrote:
> On Wed, Apr 25, 2018 at 10:55 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > Android became the primary user of CONFIG_FW_LOADER_USER_HELPER_FALLBACK.
> >
> > It would be good for us to hear from Android folks if their current use of
> > request_firmware_into_buf() is designed in practice to *never* use the direct
> > filesystem firmware loading interface, and always rely instead on the
> > fallback mechanism.
> 
> It's hard to answer this question for Android in general. As far as I
> can tell the reasons we use CONFIG_FW_LOADER_USER_HELPER(_FALLBACK)
> are:
> 1) We have multiple different paths on our devices where firmware can
> be located, and the direct loader only supports one custom path
> 2) Most of those paths are not mounted by the time the corresponding
> drivers are loaded, because pretty much all Android kernels today are
> built without module support, and therefore drivers are loaded well
> before the firmware partition is mounted
> 3) I think we use _FALLBACK because doing this with uevents is just
> the easiest thing to do; our init code has a firmware helper that
> deals with this and searches the paths that we care about
> 
> 2) will change at some point, because Android is moving towards a
> model where device-specific peripheral drivers will be loaded as
> modules, and since those modules would likely come from the same
> partition as the firmware, it's possible that the direct load would
> succeed (depending on whether the custom path is configured there or
> not). But I don't think we can rely on the direct loader even in those
> cases, unless we could configure it with multiple custom paths.
> 
> I have no reason to believe request_firmware_into_buf() is special in
> this regard; drivers that depend on it may have their corresponding
> firmware in different locations, so just depending on the direct
> loader would not be good enough.

Thanks! This is very useful! This provides yet-another justification and use
case to document for the fallback mechanism. I'll go and extend it.

> >
> > Is ptr below
> >
> >         ret = request_firmware_into_buf(&seg_fw, fw_name, dev,
> >                                         ptr, phdr->p_filesz);
> >
> > Also part of the DMA buffer allocated earlier via:
> >
> >         ret = qcom_scm_pas_init_image(pas_id, fw->data, fw->size);
> >
> > Android folks?
> 
> I think the Qualcomm folks owning this (Andy, David, Bjorn, already
> cc'd here) are better suited to answer that question.

Andy, David, Bjorn?

  Luis
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
