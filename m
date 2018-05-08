Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3018566-1525795852-2-12477696151196052013
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
    1525795851; b=WphZ1jAZMOkbUsN9r3KfkUoOcwCqenfJ4YisNNtjBQpQ6uX0z3
    K4MElcySrPjg+JIc+mmqEiub54CTzC2QA2Gvq0KmEtRtKm53jQQ+L7K+WB9LT/x4
    E4RvfTOeF1Enn6N3wy/rBR8CyqgVBa5HEVlsqfZwRt8hsH1b4GptbNiennKlzFz2
    Vv8Kifn32zS4k20CMj2uk3dpliIeSEUIpkhdGfCIWOWgJ5aakSsJfgAb9v8uht1G
    bzIUw7mJyUQ4cPkl2+lOnMq+NG9OMAfk/hqLAaQyBiaRwek1m5YjMbkWfdfFUQ+6
    +CLO+Vk2dBi4y5BSfpaP+ptUvZgKK59SblIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525795851; bh=Yd11Y
    sAn+xyFgLHuV57BfNT5+qvTZ7I2RecaLcYs7fk=; b=WJX6nfj+p+O2BPugbLqJC
    RDO4Qu71TV/KL1zRkzqN7vnI5cz2IraWtFOBUVsYnoQr+qxCCQDvtRd8y3D7aR6K
    ZKqz6rlu3ThGk7cCPJ4X3I9pOD0OUCyVqIdJrjvbMBmi4pr9nSgHmz6VFBMNmXbs
    BuBtWuE3D4hShzQa4ZdJbUeGjxit/OJ92FzMyzT0PSoladl4c8SK5uoFAwIIEUXB
    na2gSj6sfDT1Qwp+AYB8V44AqKsU48yQFpJwqbG491NEZUYpGXCXBee++8Ek86Qy
    +8H7UFrQN4sIWDfX5ZxN53OjhUxdN2P4P5nYKK4dCHyXIQcjxl/+3uNNnCclNB4A
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
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
    x-vs=clean score=-85 state=0
Authentication-Results: mx5.messagingengine.com;
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
    x-vs=clean score=-85 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC4YMNOrokb0BGnKjoosxH5IG9zRecI78/fzEazCUzFASb4Fa2EjRDTiVMJPikPmYy5PvL51okkKd1sw0mVtP+uxf1Q5H8WyLdLLsoKJYsFbjTOStGzG
    wAvDMFFdiKlD+tzZ+jpYyM0ZhVwL9bzhbyTti4mZr151HxiMmfuSHIZwtTdZAfZ3cy9A9eQUdKL63kXr216hfq3+URHFGTFfU8/7efqrMe5TSPPMfZ5NAAJh
    NJK8RJg6ER2uE0jZLJqPpw==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8 a=DDOyTI_5AAAA:8
    a=kpvyO64mCYQ25S6vECcA:9 a=ehwtOV2CpkiSd9Cj:21 a=aSRPJVVujFewrgcl:21
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 8 May 2018 16:10:37 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v3 2/5] efi: Add embedded peripheral firmware support
Message-ID: <20180508161037.GE27853@wotan.suse.de>
References: <20180408174014.21908-1-hdegoede@redhat.com>
 <20180408174014.21908-3-hdegoede@redhat.com>
 <20180423211143.GZ14440@wotan.suse.de>
 <71e6a45a-398d-b7a4-dab0-8b9936683226@redhat.com>
 <1524586021.3364.20.camel@linux.vnet.ibm.com>
 <20180424234219.GX14440@wotan.suse.de>
 <1524632409.3371.48.camel@linux.vnet.ibm.com>
 <20180425175557.GY14440@wotan.suse.de>
 <CAB0TPYGnCu+anWHBGvkaigxD--8uHQaQJ2c62kegJ7mTqvkmnA@mail.gmail.com>
 <20180508153805.GC27853@wotan.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180508153805.GC27853@wotan.suse.de>
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
 Will Deacon <will.deacon@arm.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 David Howells <dhowells@redhat.com>, David Brown <david.brown@linaro.org>,
 Peter Jones <pjones@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>, nbroeking@me.com,
 x86@kernel.org, Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
 Ingo Molnar <mingo@redhat.com>, Andy Gross <andy.gross@linaro.org>,
 Darren Hart <dvhart@infradead.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Arend Van Spriel <arend.vanspriel@broadcom.com>, Todd Kjos <tkjos@android.com>,
 Kees Cook <keescook@chromium.org>, linux-efi <linux-efi@vger.kernel.org>,
 linux-arm-msm@vger.kernel.org, Torsten Duwe <duwe@suse.de>,
 Josh Triplett <josh@joshtriplett.org>, Chris Wright <chrisw@sous-sol.org>,
 Hans de Goede <hdegoede@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, platform-driver-x86@vger.kernel.org,
 Martijn Coenen <maco@android.com>, Kalle Valo <kvalo@codeaurora.org>,
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

On Tue, May 08, 2018 at 03:38:05PM +0000, Luis R. Rodriguez wrote:
> On Fri, May 04, 2018 at 12:44:37PM -0700, Martijn Coenen wrote:
> > On Wed, Apr 25, 2018 at 10:55 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > > Android became the primary user of CONFIG_FW_LOADER_USER_HELPER_FALLBACK.
> > >
> > > It would be good for us to hear from Android folks if their current use of
> > > request_firmware_into_buf() is designed in practice to *never* use the direct
> > > filesystem firmware loading interface, and always rely instead on the
> > > fallback mechanism.
> > 
> > It's hard to answer this question for Android in general. As far as I
> > can tell the reasons we use CONFIG_FW_LOADER_USER_HELPER(_FALLBACK)
> > are:
> > 1) We have multiple different paths on our devices where firmware can
> > be located, and the direct loader only supports one custom path

FWIW I'd love to consider patches to address this, if this is something
you may find a need for in the future to *avoid* the fallback, however
would like a clean solution.

> > 2) Most of those paths are not mounted by the time the corresponding
> > drivers are loaded, because pretty much all Android kernels today are
> > built without module support, and therefore drivers are loaded well
> > before the firmware partition is mounted

I've given this some more thought and you can address this with initramfs,
this is how other Linux distributions are addressing this. One way to
address this automatically is to scrape the drivers built-in or needed early on
boot in initamfs and if the driver has a MODULE_FIRMWARE() its respective
firmware is added to initramfs as well.

If you *don't* use initramfs, then yes you can obviously run into issues
where your firmware may not be accessible if the driver is somehow loaded
early.

> > 3) I think we use _FALLBACK because doing this with uevents is just
> > the easiest thing to do; our init code has a firmware helper that
> > deals with this and searches the paths that we care about
> > 
> > 2) will change at some point, because Android is moving towards a
> > model where device-specific peripheral drivers will be loaded as
> > modules, and since those modules would likely come from the same
> > partition as the firmware, it's possible that the direct load would
> > succeed (depending on whether the custom path is configured there or
> > not). But I don't think we can rely on the direct loader even in those
> > cases, unless we could configure it with multiple custom paths.

Using initramfs will help, but because of the custom path needs -- you're
right, we don't have anything for that yet, its also a bit unclear if
something nice and clean can be drawn up for it. So perhaps dealing with
the fallback mechanism is the way to go for this for sure, since we already
have support for it.

Just keep in mind that the fallback mechanism costs you about ~13436 bytes.

So, if someone comes up with a clean interface for custom paths I'd love
to consider it to avoid those 13436 bytes.

  Luis
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
