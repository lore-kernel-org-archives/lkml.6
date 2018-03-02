Return-Path: <will.deacon@arm.com>
X-Cyrus-Session-Id: sloti22d1t05-1243504-1519986646-2-15615725079463812923
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, SPF_PASS -0.001,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='217.140.101.70', Host='foss.arm.com', Country='US', FromHeader='com',
  MailFrom='com'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: will.deacon@arm.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519986646; b=A8LXAUp+ggRz0FmavvDL4CB4xBtPJz3naVvxqgkNnWsJVoJ
    bU4DoYCQ6z+ToRweAav/7XYBh4axZ5Boje9R5lbUMlHmJFzU/QkL/4TXpy1ei1zE
    2s75LIp0agUCTxP3kqhLCFgWQdYCfqi/cEmSA5UCO6MEZzGYOtLBoP70CSaoNL8n
    URLtvLPHDs7DxL32XRp048WKM75DwvMzOb6AOmCCPfX/FpMbJp+ANDRw2wJvX37I
    jX1tDP01essOcwMnWo0VyZD2UmtpmPWIrCuEDhvcTcUJOojpll7ywesw4tVNVXSr
    AZ5NcMmuZuz5uS7UO2rgNo9BZbXP+wEAQGNAO1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1519986646; bh=vOOVzcwPhmBSwCLGwYpbX4mCIGrwz7TAKHf72KqJ0Bc=; b=L
    9Z34nHlLnJ6lQzktPHtA5HBw7umI+pHS3kSj2ZCU2ebM4tac2GJHyIR8cFBqYZP5
    176PO3DTSrBkSIJiwPu4ROnd9JR7n7aDOtg/bqNCGsSW0HhqoHV1dmQvNAhN3EsR
    COhL5XfrsF8W1GbOlqKnPn9JottsEXWLzyeWNcKZk5WRippQ0PKjFWI0/IymKB52
    LYvqwzMmbQyOtKQb1UTe/mqCebduWo5sPuDtWuKU7wXkqLRRIAO54wjA2YxbxHWc
    RIfKmaNJLjAJByfHFW+ykn/6+ztccFVCvojQJB8jFxIKyZbQsNPpeq9GUO1s2+bO
    fTNe18VBBElr4Xqsccsyw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=arm.com;
    iprev=pass policy.iprev=217.140.101.70 (foss.arm.com,usa-sjc-mx-foss1.foss.arm.com);
    spf=pass smtp.mailfrom=will.deacon@arm.com smtp.helo=foss.arm.com;
    x-aligned-from=pass;
    x-ptr=pass x-ptr-helo=foss.arm.com x-ptr-lookup=foss.arm.com,usa-sjc-mx-foss1.foss.arm.com;
    x-return-mx=pass smtp.domain=arm.com smtp.result=pass smtp_is_org_domain=yes header.domain=arm.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=arm.com;
    iprev=pass policy.iprev=217.140.101.70 (foss.arm.com,usa-sjc-mx-foss1.foss.arm.com);
    spf=pass smtp.mailfrom=will.deacon@arm.com smtp.helo=foss.arm.com;
    x-aligned-from=pass;
    x-ptr=pass x-ptr-helo=foss.arm.com x-ptr-lookup=foss.arm.com,usa-sjc-mx-foss1.foss.arm.com;
    x-return-mx=pass smtp.domain=arm.com smtp.result=pass smtp_is_org_domain=yes header.domain=arm.com header.result=pass header_is_org_domain=yes
Date: Fri, 2 Mar 2018 10:30:46 +0000
From: Will Deacon <will.deacon@arm.com>
To: Alex Shi <alex.shi@linaro.org>
Cc: Greg KH <greg@kroah.com>, Marc Zyngier <marc.zyngier@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>, stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/45] arm Spectre fix backport review for LTS 4.9
Message-ID: <20180302103046.GC19323@arm.com>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
 <20180301164630.GB23321@kroah.com>
 <c96bc4d8-25b8-684b-83f6-7d6c6c0fea4b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c96bc4d8-25b8-684b-83f6-7d6c6c0fea4b@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 05:02:32PM +0800, Alex Shi wrote:
> As testing the spectre bug fix, that's a good question. I also asked
> this question to original patch authors, like Marc. They said they just
> figure out these patches could block spectre or meltdown issue. From my
> side, I just reproduced the process internal spectre. But all fix on arm
> can not resolve the user space internal spectre. It can block from user
> to kernel or kernel to user spectre according the code purose. So I
> believe these patch could do their job. And arm cpu would drop the
> spectre branches if it has 20+ 'nop' instructions...

Since this is archived on a public list and I don't want people to rely on
this, no, you cannot rely on "20+ 'nop' instructions" to work around
spectre on arm/arm64. It might prevent a particular PoC working on a
particular SoC, but it's fragile at best.

Will
