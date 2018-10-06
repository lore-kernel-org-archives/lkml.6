Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3A2ECDE43
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 20:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC53C2087D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 20:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mG3/sUxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC53C2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbeJGDs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 23:48:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43156 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeJGDs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 23:48:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id p24-v6so6600412pff.10;
        Sat, 06 Oct 2018 13:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oPmYQ0BGaSYFMm+d0TzEj5zlGjVaZ1jhACbfb+p1gIQ=;
        b=mG3/sUxKoJQ3UprlUX4HMSktypw8wLzL+GDERq4pZ47hqxN2rMq+mhQu26s4n2nz1C
         oOkiaNTBZJ1a+u9mZ+Z4eTlShjx6ro4yOn8IXOxWWicQlZKwTvnCovqWS0OePYfEIK01
         oActC6Wd/7FzEzyFRGbhUJjX4/pKAOhDsXnvHXe1pL+IHDn+eLpDbXflRMZsaUWi3GnC
         qzzs+JkNtwlUUkBAnxmUnqMmbYDZV0Il83Hvk++M4VTT/q/RKvJnBo81cQLAewQlNX2u
         uyOiOeLbVTGee6DdQiOuBLpi5T0FpC2JECLDpogBXBFFQKkztmnyPsk67axoM1NFjYq3
         PUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oPmYQ0BGaSYFMm+d0TzEj5zlGjVaZ1jhACbfb+p1gIQ=;
        b=LL+A0VJIo94ubNlhsD3kw0HHUsVDSL3FtxHStVeIgIZKTJfQQGL92uEAxrQebbVz0o
         ToTnTtHtWH95IPJt1+jcvKnOs1mqEarh2pF/4wb9OIrTvAjL/PcZ4QXUk7bjCZ1SC1wy
         jyEp95kgwQigulQVpcGysk51QEaW/o8OQw2dBfAgkLMzckJoAZ1DJCUAbeGoT4gLRVZv
         c7XXjW4Tw6kU2BFNErCHj+avbpV0KU3BUbpd7vS+fvZ7XgJRAHLixNjfrO77Jd5lwlwU
         wTEpC0V7i4NGcDg9aus5tjJHrxWuJalQDcmourfzOU9TmNiFeGmtt6mEqEgW8/LZeezF
         KoEA==
X-Gm-Message-State: ABuFfoiGwQgaueTOvlGIWuvzOG1uzOvuEcnzuSd46TenyJt2+uINPY0q
        trbWsxZfjB05X0oMfUzFHLU=
X-Google-Smtp-Source: ACcGV62AS0FEXaKK+SDBmiFVSD7uzI3IwB/789iEV0jJ9Qj1gWZkx3y8H6E9LqB47L4Woo3aKD988g==
X-Received: by 2002:a62:210:: with SMTP id 16-v6mr18669991pfc.100.1538858624151;
        Sat, 06 Oct 2018 13:43:44 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id z11-v6sm26332750pfd.99.2018.10.06.13.43.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Oct 2018 13:43:43 -0700 (PDT)
Subject: Re: [PATCH] KVM: X86: Add missing KVM_AMD dependency
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>
References: <1538765165-19177-1-git-send-email-linux@roeck-us.net>
 <749a21f9-ad88-af0e-bed7-b505ac57568d@redhat.com>
 <20181005220325.GA24365@roeck-us.net>
 <713d35b9-5dd5-284f-b514-7d2295a2db34@redhat.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b489282b-912d-e79d-3b7a-77784b8c51c9@roeck-us.net>
Date:   Sat, 6 Oct 2018 13:43:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <713d35b9-5dd5-284f-b514-7d2295a2db34@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paolo,

On 10/05/2018 03:18 PM, Paolo Bonzini wrote:
> On 06/10/2018 00:03, Guenter Roeck wrote:
>>> This should be handled by
>>>
>>> config KVM_AMD_SEV
>>>          def_bool y
>>>          bool "AMD Secure Encrypted Virtualization (SEV) support"
>>>          depends on KVM_AMD && X86_64
>>>          depends on CRYPTO_DEV_SP_PSP && !(KVM_AMD=y && CRYPTO_DEV_CCP_DD=m)
>>>          ---help---
>>>          Provides support for launching Encrypted VMs on AMD processors.
>>>
>> Unfortunately it doesn't. It disables KVM_AMD_SEV, but that doesn't prevent
>> the calls.
> 
> Yes, exactly - that's why I mentioned the sev_guest patch that should
> cull all the SEV code from a !KVM_AMD_SEV build.
> 
>>> Maybe this works as well?  I haven't tested it yet:
>>>
>> I am sure there are many possible solutions. I would personally prefer one
>> that enforces KVM_AMD=m with CRYPTO_DEV_CCP_DD=m, but that is just me.
> 
> Well, KVM_AMD=y is a relatively unusual choice to begin with.  The

It is common enough that we are not the only ones affected. Also, even a
"relatively unusual choice" should, in my opinion, not result in a build
error. Never mind, I'll just apply the suggested workaround and configure
CRYPTO_DEV_CCP_DD=y. I need to do that anyway, after all, if I want to keep
KVM_AMD=y.

Thanks,
Guenter
