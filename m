Return-Path: <will.deacon@arm.com>
X-Cyrus-Session-Id: sloti22d1t05-2611097-1519641907-2-7864215143419797680
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, SPF_PASS -0.001,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='217.140.101.70', Host='usa-sjc-mx-foss1.foss.arm.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: will.deacon@arm.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519641907; b=gN23Z4H0NTKiolnAoEwgFLipJVmFjVyQVctYgpGc20yc5BX
    Hny/Xao5zRXM9H5wAsmCWhCFEjJhj4MUPqkwHIQxtfyApQUZN9GxMg1lJ3uawVwg
    JqFv1TzqYOKbjpPtGJdo9l9XlOVMofYeTj5In1atYSMFgka2cZkWNav1DdklvBcQ
    4JApDSPy9o071szA6JsI9Mu46IItQe8OkXLcjSIxWXMb3yp/F9gIJOeQ+bdcEO4L
    OJfxSI7JcIWJHFWTdA0PpbKcrgiYdqA6QDa28mgHek2cSglOTloDp2Ek8Trk+L36
    nOG5Md/EsxY2FyrsYJLsKdBVSfCINK/QYG3c7Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1519641907; bh=739UkBFPaiGH9V8oP59d+0/+d59iYULREwyXQzmdxlo=; b=e
    GGgrGcCndwUZMRV+OxI5LfGYmsu4Lb4kYU1efZZdYSwNnekAwkXz8xNt3R00azw3
    DuAUBvZNwP0cEvhGRVuKUBve68qXtdPJ9Y9pZaHSMw5ZzOLCwFIuZmtzIViDNVOo
    XOkgXp6swzfrl2dsDmWj7DEKwvsC/1VqZtIllmODk2JRPDzpd+zBKmIiF+Y+oXoo
    OacMi47QAV4vLKB9eXR7FLONAmY6R0X8ydJxHyiG2e3jex5Sua+go2Jf08LxsMlN
    SUeDaFYa9TB/WUhpWseqRLy1ICmzExfIQZ7KlUgDb+nw6M1SvYyUAy/80XLyQaTK
    7U+upl4qsTNdF1x1/eJmw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=arm.com;
    iprev=pass policy.iprev=217.140.101.70 (foss.arm.com,usa-sjc-mx-foss1.foss.arm.com);
    spf=pass smtp.mailfrom=will.deacon@arm.com smtp.helo=foss.arm.com;
    x-aligned-from=pass;
    x-ptr=pass x-ptr-helo=foss.arm.com x-ptr-lookup=foss.arm.com,usa-sjc-mx-foss1.foss.arm.com;
    x-return-mx=pass smtp.domain=arm.com smtp.result=pass smtp_is_org_domain=yes header.domain=arm.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=arm.com;
    iprev=pass policy.iprev=217.140.101.70 (foss.arm.com,usa-sjc-mx-foss1.foss.arm.com);
    spf=pass smtp.mailfrom=will.deacon@arm.com smtp.helo=foss.arm.com;
    x-aligned-from=pass;
    x-ptr=pass x-ptr-helo=foss.arm.com x-ptr-lookup=foss.arm.com,usa-sjc-mx-foss1.foss.arm.com;
    x-return-mx=pass smtp.domain=arm.com smtp.result=pass smtp_is_org_domain=yes header.domain=arm.com header.result=pass header_is_org_domain=yes
Date: Mon, 26 Feb 2018 10:45:05 +0000
From: Will Deacon <will.deacon@arm.com>
To: Alex Shi <alex.shi@linaro.org>
Cc: Greg KH <greg@kroah.com>, Marc Zyngier <marc.zyngier@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>, stable@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	"moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 46/52] arm: Add BTB invalidation on switch_mm for
 Cortex-A9, A12 and A17
Message-ID: <20180226104505.GB8736@arm.com>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
 <1519633227-29832-47-git-send-email-alex.shi@linaro.org>
 <20180226100518.GA11378@kroah.com>
 <3fa9ebcb-fe94-bbd6-49a7-e90c91c3905e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fa9ebcb-fe94-bbd6-49a7-e90c91c3905e@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 06:40:42PM +0800, Alex Shi wrote:
> 
> 
> On 02/26/2018 06:05 PM, Greg KH wrote:
> > On Mon, Feb 26, 2018 at 04:20:20PM +0800, Alex Shi wrote:
> >> From: Marc Zyngier <marc.zyngier@arm.com>
> >>
> >> ** Not yet queued for inclusion in mainline **
> > 
> > As Marc said, this should have been a HUGE clue that we can't take this
> > patch.  Please go re-read
> > 	https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > 
> 
> Thanks for comments, Greg!
> 
> I read the rules for several times, and thought it maybe a exception for
> this bug fix. But since MarcZ said so. We can wait. :)

The reason I added the disclaimer to the commit message was precisely to
avoid these things accidentally going into stable. If stable diverges
significantly from mainline, it's just going to make backports of other
patches more difficult. So no, we shouldn't be considering an exception
for this.

Will
