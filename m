Return-Path: <alex.shi@linaro.org>
X-Cyrus-Session-Id: sloti22d1t05-2556621-1519641659-2-12396518193978967237
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H2 -0.001,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.223.173', Host='mail-io0-f173.google.com', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: alex.shi@linaro.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519641658; b=iV93zJa90KaNDb6Nuwxnkwls2S7AgWrFta+NTq9KEclTAOY
    npuy2QTlrSWYIM36OZBCxfSCuCWBzE1F+oiHi6O82yytAkNFGbm09ikKcpKeTCnf
    XZVrPc9AGYuaYPMST8YZCmq8VwWRGsJMyeDB+p4biST046fhBZJC5WUubO2HYHmC
    gmLfumo1HiIScmXamZ5/lYnO6JTO96uyiqXNfPUUG0WjuqIz2wF99niqpLOS69hB
    /RFjblglD+qtd8OGJT2I+02nTqWudpw0I8iiM3FYxRi1NZOsTj9QFYvNSdKBrWOs
    McLuUPCZFs25OUHudD6pfY+TM5V9G+GE7OpGCtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding; s=arctest; t=1519641658; bh=adFCYfjF
    vWLuCeRnysF8HFynHezy9a3vY0TnmzVoDR4=; b=LSzJb/vyB3yyMuj4hBEq1NIl
    CuyZZIDEmB8vk+sWsdi/tsZPT7Lx+r6w4IPL3nBV+IPZpYXuHWngVR2PcQjVfi/7
    doVDsnsn5SJjGmQicZCH3Dl1DayXg4pwkr/fqSV4lUqm5S0dfqm5l9/GpKA1vUiU
    kvOnOcMHiW/NSSrynOrIxkY/Ua1Uoqnhbfk0kQBpUGsPwo5b3raG/9n9G90HmY8+
    s6wY6y+9vePVlWxVni6K9vm4wLIgB8cCOkuzEjan0TafEgKXl2eee+H6Tzdh3AdZ
    uWxk4pNf+8Wfr52bVTUntQtoa9rj3vmE5m1dNb9w46Ucv2Rvnmyv1+5yoyBqHw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=WA1oWEAA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.85.223.173 (mail-io0-f173.google.com);
    spf=pass smtp.mailfrom=alex.shi@linaro.org smtp.helo=mail-io0-f173.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AZqZKz12;
    x-ptr=pass x-ptr-helo=mail-io0-f173.google.com x-ptr-lookup=mail-io0-f173.google.com;
    x-return-mx=pass smtp.domain=linaro.org smtp.result=pass smtp_is_org_domain=yes header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=WA1oWEAA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.85.223.173 (mail-io0-f173.google.com);
    spf=pass smtp.mailfrom=alex.shi@linaro.org smtp.helo=mail-io0-f173.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AZqZKz12;
    x-ptr=pass x-ptr-helo=mail-io0-f173.google.com x-ptr-lookup=mail-io0-f173.google.com;
    x-return-mx=pass smtp.domain=linaro.org smtp.result=pass smtp_is_org_domain=yes header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELvh63icg+pAxzWeTAYlLeRwKPFIrHjil8M9gnCQzadvqv0jGXTrbgwH33kIOmxxsmCK/1yQOg==
Subject: Re: [PATCH 46/52] arm: Add BTB invalidation on switch_mm for
 Cortex-A9, A12 and A17
To: Greg KH <greg@kroah.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, stable@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>,
 "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
 <1519633227-29832-47-git-send-email-alex.shi@linaro.org>
 <20180226100518.GA11378@kroah.com>
From: Alex Shi <alex.shi@linaro.org>
Message-ID: <3fa9ebcb-fe94-bbd6-49a7-e90c91c3905e@linaro.org>
Date: Mon, 26 Feb 2018 18:40:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226100518.GA11378@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 02/26/2018 06:05 PM, Greg KH wrote:
> On Mon, Feb 26, 2018 at 04:20:20PM +0800, Alex Shi wrote:
>> From: Marc Zyngier <marc.zyngier@arm.com>
>>
>> ** Not yet queued for inclusion in mainline **
> 
> As Marc said, this should have been a HUGE clue that we can't take this
> patch.  Please go re-read
> 	https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> 

Thanks for comments, Greg!

I read the rules for several times, and thought it maybe a exception for
this bug fix. But since MarcZ said so. We can wait. :)

Regards
Alex
