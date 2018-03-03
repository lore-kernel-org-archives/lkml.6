Return-Path: <alex.shi@linaro.org>
X-Cyrus-Session-Id: sloti22d1t05-2934828-1520038463-2-4387438510545683400
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H2 -0.001,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.192.194', Host='mail-pf0-f194.google.com', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: alex.shi@linaro.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520038462; b=UQY3YuiXub5dRPkOmz5MCBWSJ45gg68j9MePSmN4ikEEPmb
    3fPlhDzUhrp6FnIr/2VXciB1EXCupPS3stYg2yRgnj1/uwaMeYjvt3HR6/qdUJo1
    GonVxRL76MBwEGbpfVqoAEo3iBouGXBVYL1bsaGix535MoOq42lTxbG+dpgtGKt/
    uaKXNcBpgr8OUaBRm10H2PFB1YDxNJsYwBNKoWZfZUUWdhExfgIckjUFHgVLz6W8
    CAzC190w+jfjiiZuZ8GVYhjeL6ABJSnL+RoJFPF+5i7X6F07AuuFWDi566i9nnKe
    Fw62CCeSbPIcDowMwY3GszET+xwSbirgGmHMotw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding; s=arctest; t=1520038462; bh=7oFJ1hLM
    XeLEH4Mumm8V3lGsMwYIl5SiaBNQjpqfxOA=; b=g8+EJydedGte/wZMN42w9Qsc
    d32iukzP9DmqidOQShfmngICkYLrGO2Zs8rwc+DPAMHQsh9mNAOUONfNCKaS7x0u
    62FIGVEDTx9JqLXXWfQhUim4z17QapXvZl3ooLBWyRH0FrbcOuPwpq9IXyHAIpsl
    AEEp9qX5s9hOtuKUDI9p21bpuF6tJHDxssvMujuVMdF8QZhUdqP72+jqNS+fXsL5
    qqieQ9rcinBjhuLKOM6yjJyODTT0HXNnPpaof2AATUe2N0yHN4ddG2H42ICmG6hg
    Cw4pDXrR3zNylKr+XevedhWm55doeeKPbm6UxzWtwBadrgZ+NT5UO/WuqME+VQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=IZUBn5f7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.85.192.194 (mail-pf0-f194.google.com);
    spf=pass smtp.mailfrom=alex.shi@linaro.org smtp.helo=mail-pf0-f194.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JvqpA9ms;
    x-ptr=pass x-ptr-helo=mail-pf0-f194.google.com x-ptr-lookup=mail-pf0-f194.google.com;
    x-return-mx=pass smtp.domain=linaro.org smtp.result=pass smtp_is_org_domain=yes header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=IZUBn5f7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.85.192.194 (mail-pf0-f194.google.com);
    spf=pass smtp.mailfrom=alex.shi@linaro.org smtp.helo=mail-pf0-f194.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JvqpA9ms;
    x-ptr=pass x-ptr-helo=mail-pf0-f194.google.com x-ptr-lookup=mail-pf0-f194.google.com;
    x-return-mx=pass smtp.domain=linaro.org smtp.result=pass smtp_is_org_domain=yes header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELsHVrSwfJaRJ1Uo0uIdGMsgh4YdXof+WnymJVDZdWd0LROFFoPsWlOMNcu6QuZlLzXEJobMkg==
Subject: Re: [PATCH 00/45] arm Spectre fix backport review for LTS 4.9
To: Will Deacon <will.deacon@arm.com>
Cc: Greg KH <greg@kroah.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, stable@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
 <20180301164630.GB23321@kroah.com>
 <c96bc4d8-25b8-684b-83f6-7d6c6c0fea4b@linaro.org>
 <20180302103046.GC19323@arm.com>
From: Alex Shi <alex.shi@linaro.org>
Message-ID: <f12aee2c-556b-f146-17eb-707bb901dbd8@linaro.org>
Date: Sat, 3 Mar 2018 08:54:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302103046.GC19323@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/02/2018 06:30 PM, Will Deacon wrote:
> On Fri, Mar 02, 2018 at 05:02:32PM +0800, Alex Shi wrote:
>> As testing the spectre bug fix, that's a good question. I also asked
>> this question to original patch authors, like Marc. They said they just
>> figure out these patches could block spectre or meltdown issue. From my
>> side, I just reproduced the process internal spectre. But all fix on arm
>> can not resolve the user space internal spectre. It can block from user
>> to kernel or kernel to user spectre according the code purose. So I
>> believe these patch could do their job. And arm cpu would drop the
>> spectre branches if it has 20+ 'nop' instructions...
> 
> Since this is archived on a public list and I don't want people to rely on
> this, no, you cannot rely on "20+ 'nop' instructions" to work around
> spectre on arm/arm64. It might prevent a particular PoC working on a
> particular SoC, but it's fragile at best.
> 


Thanks for comments, Will!

Yes, I full understand the difference between SoCs. Thanks for point it out!


Regards
Alex
