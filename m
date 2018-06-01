Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3754601-1527881036-2-5758037512504557734
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527881035; b=ZMVWDdJP/L+DlSDDNtuI7CneymrhiZNbpAqYx5E9nojqt/iVyu
    lyXdanIlTslmcIHWRxNSwqqskvhp5XMWD6pWyXcgOv0kT8b9pXag1cz8Wk+7BJby
    fideLvFG1Ltf3lcez5S7EfrTXWsP3KtADCuhENFPGQNLq21zi9YlhDL4N1RmKp5g
    w/T0v1kMAwxmxeADcANpKyF5PfA9H5/4TZxnAJxTt0JLzTGOcPcpKHTKNmblgETl
    PWJR1jfbZtu4UQCM0XPzAbWxNLDK8Q7mdrXrg64cAg6NZUb6zyZqPzspy327yx+3
    iUo56kf3fcb6IOYDkzbxjLeBbCpq+gZU0L1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527881035; bh=iTCNyNNhZtLtAY+TfimymI4eeQ2Nnc
    1lUioyiPRBtto=; b=gk9BNs3ozZvwUi1V4XQmpxf2Id46Hb6Rg7jKqzPo0vLm6t
    Beq1OlDHFmt3fs/TlAFprB7ketBijXKA26ndAxwuVN6VovNd0VpvsM4i/yrZMf0Z
    MLMbJB5F9ktWvzGjwOqJkoRjtZi2wVqxx0KRckDQ6CxU6YeK/+C4n84petOtzvKz
    pZ6qBqsBUjwrDP0cx6Pl0WtOa3Ex/VTtT15g+td99fEPhPJr7qMTtzNz/m4oUMK3
    cL14qwc3lEiE0q6hptTK3RVPv9XrDQcCFrfwnRKyoIY8+hqM4RcK3XrhgyNPMfws
    e7x54bLKjYe7ZOaAL1F01Nbe25QSTL1MmmW/4wJA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-85 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-85 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAVjasRjPwW/RcllfqOxXUAxAdAmgkoh2qAZQLQ/K6eIUwSRUZd10gMQuZWnJV454GPIF0o41cuXBaARYmuyEqPZ/xTMQLKm5CKLXR+qFPzlZOCg8DmA
    rVee0RZjFi3/xrAIB3XjNeuvOFf7mLQ2g/luCebKOD5t5ioc3+B9s+MXB+n5KlJ/yp1qwd/0t9Yv6J6TbUDmL/83GVophGaF2fJPUt7imXtWTBl4S8cTDBLG
    s0kBfBv3Rp7OZGU/KmKtjg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=4_jHGUOkoL8lhqfQ6O0A:9 a=o5Y1oyKLvLU4meEP:21
    a=I1Qy0Hd3Bm45KT-7:21 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753283AbeFATXx (ORCPT <rfc822;linux@kroah.com>);
        Fri, 1 Jun 2018 15:23:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:49179 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752019AbeFATXv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 Jun 2018 15:23:51 -0400
Date: Fri, 1 Jun 2018 21:23:46 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Martijn Coenen <maco@android.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Vikram Mulukutla <markivx@codeaurora.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-security-module@vger.kernel.org,
        Chris Wright <chrisw@sous-sol.org>,
        David Howells <dhowells@redhat.com>,
        Alan Cox <alan@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Josh Triplett <josh@joshtriplett.org>,
        dmitry.torokhov@gmail.com, mfuzzey@parkeon.com,
        Kalle Valo <kvalo@codeaurora.org>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        nbroeking@me.com, Torsten Duwe <duwe@suse.de>, x86@kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 2/5] efi: Add embedded peripheral firmware support
Message-ID: <20180601192346.GQ4511@wotan.suse.de>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508153805.GC27853@wotan.suse.de>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 03:38:05PM +0000, Luis R. Rodriguez wrote:
> On Fri, May 04, 2018 at 12:44:37PM -0700, Martijn Coenen wrote:
> > On Wed, Apr 25, 2018 at 10:55 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > > Is ptr below
> > >
> > >         ret = request_firmware_into_buf(&seg_fw, fw_name, dev,
> > >                                         ptr, phdr->p_filesz);
> > >
> > > Also part of the DMA buffer allocated earlier via:
> > >
> > >         ret = qcom_scm_pas_init_image(pas_id, fw->data, fw->size);
> > >
> > > Android folks?
> > 
> > I think the Qualcomm folks owning this (Andy, David, Bjorn, already
> > cc'd here) are better suited to answer that question.
> 
> Andy, David, Bjorn?

Andy, David, Bjorn?

Note: as-is we have no option but to assume this is DMA memory for now.
We cannot keep IMA's guarantees with the current prealloc firmware API
buffer, so I've suggested:

a) The prealloc buffer API be expanded to enable the caller to descrbe it
b) Have the qcom driver say this is DMA
c) IMA would reject it to ensure it stays true to what it needs to gaurantee

d) Future platforms which want to use IMA but want to trust DMA buffers
   would need to devise a way to describe IMA can trust some of these
   calls.

I'll leave it up to you guys (Andy, David, Bjorn) to come up with the code for
d) once and if you guys want to use IMA later.  But since what is pressing here
is to stay to true to IMA, with a-c IMA would reject such calls for now.

  Luis
