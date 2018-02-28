Return-Path: <alex.shi@linaro.org>
X-Cyrus-Session-Id: sloti22d1t05-3220176-1519791049-2-8816448645405942527
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H3 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='74.125.83.67', Host='mail-pg0-f67.google.com', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: alex.shi@linaro.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519791048; b=KtZyZQEvqkjo09QLrd1tJMKVC/FdyoZGEokitU/afphWy9m
    vK0Pl55t0DW7Bje42RJUwsD6kxaob7VKL7ihajnwiWZWt9O/TyGTkBp3J7H0U3af
    ETlikI5a9fucKJzcV+YNon37WnIVblviBa0Cffa0XfEeKGx4Nba6+ryPVUVp+Zzf
    mknP7M3GQsrzfy3NkjhiTfnCVdRqrX6NBZjo6Rh/batijeZb68AL00XLIwcbbs4e
    rZmMEBRbWbn6pxIYwNl4FPYmNctu0LtFE1AFSx+AWfyOreLD77InBcWYuO6y5QIM
    kvQvFfw290eUO8TjVIKTaWOtA+6bxOxDdvYkUMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding; s=arctest; t=1519791048; bh=RZMUAaCI
    eHGpW7bJVe81xnfhceYtJIPBe6A7RWj0JMM=; b=dyde3dpyi61A+x0sRST+dHUC
    cdyJIjKm7SM91NqZjCZaDoXEQ5ZTfD18UiVcX4t+8kxbldJuT6bdbtmYixk1nrC3
    8ZRp8oRGYFOdUObaFdzodUoP3fjhxQfxmzTAQGRgFaJBkhhl9AZyUDbJOkt1L9XH
    yPjwip+PCCJ1ELk/NcOWYsydjIZDmjGtiGmOOPmwYYR60StjWdOIXQUdvjhFaE2V
    8SeVXZGTeo292moKHsjXX3MKiqSEZ5K5PyZk1u3ihcRCkxv141b9C6NLc6RZg0om
    zW4yWlHV9X04X1gmGYlsou3mpwGm91HCneNhGr3oq/i6qMU/sSxLmbCmGn22Yg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=UeMm45UZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=74.125.83.67 (mail-pg0-f67.google.com);
    spf=pass smtp.mailfrom=alex.shi@linaro.org smtp.helo=mail-pg0-f67.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QlORI9Wk;
    x-ptr=pass x-ptr-helo=mail-pg0-f67.google.com x-ptr-lookup=mail-pg0-f67.google.com;
    x-return-mx=pass smtp.domain=linaro.org smtp.result=pass smtp_is_org_domain=yes header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=UeMm45UZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=74.125.83.67 (mail-pg0-f67.google.com);
    spf=pass smtp.mailfrom=alex.shi@linaro.org smtp.helo=mail-pg0-f67.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QlORI9Wk;
    x-ptr=pass x-ptr-helo=mail-pg0-f67.google.com x-ptr-lookup=mail-pg0-f67.google.com;
    x-return-mx=pass smtp.domain=linaro.org smtp.result=pass smtp_is_org_domain=yes header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x224CqkdP52jxO3COWRbJyFlzRnc4OEUWBkQ723XQmZeUmyaayFkHSw5LOqxH3s8KOo/nQTU0YQ==
Subject: Re: [PATCH 46/52] arm: Add BTB invalidation on switch_mm for
 Cortex-A9, A12 and A17
To: Will Deacon <will.deacon@arm.com>
Cc: Greg KH <greg@kroah.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, stable@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>,
 "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
 <1519633227-29832-47-git-send-email-alex.shi@linaro.org>
 <20180226100518.GA11378@kroah.com>
 <3fa9ebcb-fe94-bbd6-49a7-e90c91c3905e@linaro.org>
 <20180226104505.GB8736@arm.com>
From: Alex Shi <alex.shi@linaro.org>
Message-ID: <a12f1c0c-1d79-768f-97e4-2ef62ebf150c@linaro.org>
Date: Wed, 28 Feb 2018 12:10:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226104505.GB8736@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 02/26/2018 06:45 PM, Will Deacon wrote:
> On Mon, Feb 26, 2018 at 06:40:42PM +0800, Alex Shi wrote:
>>
>>
>> On 02/26/2018 06:05 PM, Greg KH wrote:
>>> On Mon, Feb 26, 2018 at 04:20:20PM +0800, Alex Shi wrote:
>>>> From: Marc Zyngier <marc.zyngier@arm.com>
>>>>
>>>> ** Not yet queued for inclusion in mainline **
>>>
>>> As Marc said, this should have been a HUGE clue that we can't take this
>>> patch.  Please go re-read
>>> 	https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
>>>
>>
>> Thanks for comments, Greg!
>>
>> I read the rules for several times, and thought it maybe a exception for
>> this bug fix. But since MarcZ said so. We can wait. :)
> 
> The reason I added the disclaimer to the commit message was precisely to
> avoid these things accidentally going into stable. If stable diverges
> significantly from mainline, it's just going to make backports of other
> patches more difficult. So no, we shouldn't be considering an exception
> for this.
> 

Hi Will,

Got it. Thanks for explanations!
I remove all non upstream patches and put it on

git://git.linaro.org/kernel/linux-linaro-stable.git
v4.9-spectre-upstream-only

If other patches passed review. it could be got as whole branch from there.

Thanks
Alex
