Return-Path: <alex.shi@linaro.org>
X-Cyrus-Session-Id: sloti22d1t05-1148518-1519982104-5-17647467515777452891
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H3 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='74.125.83.65', Host='mail-pg0-f65.google.com', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: alex.shi@linaro.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519982103; b=i0h19tS5j+m9clYIlVTt7R1sWpNyG9u1RwpBMYGilJJ+ZzG
    dOtNzDdrGrfyxQeFrRllPr3IdTulTKadpjEOTTouHdRYaYRYjCsNAR5c8fG2Cc5O
    7cxcmZ4Eh8qr4BiOf8adxhE/zzC5zfM6m2OUpDcPRJs6dNWd8X6rNbQqzsG86wyw
    Z5OG2PR6xLS3ieCIw13gHTvYYUsFf2ZUORrNEEJq70RIZe/hjicpGhGtqnvlrsmz
    oQyabOKfnsbyY7SwNSx9LVzwlC3L7jep0ERy0q9+z6gUWVpBc+L9QKHKkbQ96Yy6
    4KQHiCKvQ4zyhNpXEFdMSxc2Q2ZANSIiTXNEwCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding; s=arctest; t=1519982103; bh=jhSB0wy1
    L7Qt2K7LrBZ6b4VOIhijG0kw9lM1E3Zs5z8=; b=Es+VM4dOynZB7hG9q4MTFji4
    rX74qbwE9CehAGJKk5Ai4LxnyrEEUWtzWHIQSNIlBdZEwjgg6Dhea5rMEO5cOYSm
    XJ9pDgaNvd1nGZM5Su7iVTW8TuFbPc6k/yzezti6B8GaJk+208KPqQjHIAajMzcB
    n8A6yZizOuzfpM2DANYcVuhOq7IWGlfv23wCE4SUy+eljNlhG/rCkF+47aSDMEao
    2oKCaVc+3d4ILd3S5J4gRYcU5f8sxCXwKlAR9OG1cRkSHj5qqvQYo9WxJbyszw80
    E3k8fmcTfiD1W5mpT94umN8gUNb3ewfwmP0kFMGAM1U1DGAPGFZOmA+9zHxrYQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=EsUM304v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=74.125.83.65 (mail-pg0-f65.google.com);
    spf=pass smtp.mailfrom=alex.shi@linaro.org smtp.helo=mail-pg0-f65.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=p8Yy/Zv/;
    x-ptr=pass x-ptr-helo=mail-pg0-f65.google.com x-ptr-lookup=mail-pg0-f65.google.com;
    x-return-mx=pass smtp.domain=linaro.org smtp.result=pass smtp_is_org_domain=yes header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=EsUM304v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=74.125.83.65 (mail-pg0-f65.google.com);
    spf=pass smtp.mailfrom=alex.shi@linaro.org smtp.helo=mail-pg0-f65.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=p8Yy/Zv/;
    x-ptr=pass x-ptr-helo=mail-pg0-f65.google.com x-ptr-lookup=mail-pg0-f65.google.com;
    x-return-mx=pass smtp.domain=linaro.org smtp.result=pass smtp_is_org_domain=yes header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELvaSLOOL9tdzVBGOSRIAXlsosqW/v6GCYIESgzVq2wDuUjqR5+EnriFkiQu0fH+iKqG0qJikQ==
Subject: Re: [PATCH 0/29] arm meltdown fix backporting review for lts 4.9
To: Greg KH <greg@kroah.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, stable@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
 <20180301152450.GA4061@kroah.com>
From: Alex Shi <alex.shi@linaro.org>
Message-ID: <5cf40379-9098-da02-a471-8abd7d8f0be8@linaro.org>
Date: Fri, 2 Mar 2018 17:14:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180301152450.GA4061@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/01/2018 11:24 PM, Greg KH wrote:
> On Wed, Feb 28, 2018 at 11:56:22AM +0800, Alex Shi wrote:
>> Hi All,
>>
>> This backport patchset fixed the meltdown issue, it's original branch:
>> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kpti
>> A few dependency or fixingpatches are also picked up, if they are necessary
>>  and no functional changes.
>>
>> The patchset also on repository:
>> 	git://git.linaro.org/kernel/linux-linaro-stable.git lts-4.9-spectrevv2 
>>
>> No bug found yet from kernelci.org and lkft testing.
> 
> No bugs is good, but does it actually fix the meltdown problem?  What
> did you test it on?

Oh, I have no A73/A75 cpu, so I can not reproduce meltdown bug.

> 
> And why are you making this patchset up?  What is wrong with the patches
> in the android-common tree for this?

We believe the LTS is the base kernel for android/lsk, so the fixing
patches should get it first and then merge to other tree.

> 
>> Any comments are appreciated!
> 
> You need to start versioning this changeset, as I have no idea if this
> is the "latest" one or not, right?>
> Or have you not sent out this patchset before?  How does this interact
> with the "spectre" patches?  Or am I totally confused here?

It is the first patchset for meltdown. Yes, I will resent this patchset
with versioning after the renesas board booting fixed.

The meltdown and spectre is 2 different bugs, the fixing patchset are
isolated each other. So I did the backport as 2 different patchset. And
merging them together is relative simple. I will comming with a merge
patch next time, after the meltdown patchset ready.(the kernelci didn't
works well in recent days)

Thanks
Alex
