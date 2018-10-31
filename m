Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D91FECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D3F20840
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqjXSFEW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D3F20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbeJaSYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:24:23 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36666 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbeJaSYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:24:22 -0400
Received: by mail-lf1-f66.google.com with SMTP id h192so11095901lfg.3;
        Wed, 31 Oct 2018 02:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wjWGJMBjAYOtg/ptm8tzogysjtI/euxcYBSvlp1KYNk=;
        b=hqjXSFEW6gVaIPRrCElTSgcsV+NMOLvQ7BOV2b89x13+rTMYt94wz3dmaG6pdpzv/V
         seYn+r2ZfJ53E850vFkdbFn6Ynv3KyyTd5fkeII+yNeDJQCLZr8qaig6bWZVo/GmBcY3
         EBDsecuwrH9PYN7hpm1/JbZCUHoHtviD8Br5cwuXM22NnHDFMwgpp6dM8MlpYMaxFPAt
         oewIFJVktKJbOCFw8sgJiUsAV2oRIA1NmuFLt1PRNEkVy5RyWa9Wa7GwxnVTrStKfyNK
         S8XWyv5F//0nrN4ldCehGNVBMIGOa5o2RH+oanPJ8wLPRpKUDdN4WYhpkt94Uqrl0bww
         9+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wjWGJMBjAYOtg/ptm8tzogysjtI/euxcYBSvlp1KYNk=;
        b=cNGfwdYT/IROmIzSsRJhp4Iu5969I2pT1ViMXS1qGsf4XcbsdNE1O07+Shhxa70HJS
         TQr+3chvKsbL5HE49HAwsuSe37qen6fVl4RBaA2mRYTys6ys+Uva0igh6IzPGW7TRtbA
         YgeIIIt5peDqrEZCnm3kJkfAc5OJ+DpQtet9+0PBg2SWwDWaEpTfTc0GmRcXH6xlEyUs
         PUV6xljGbQEEgFxAo50SEneIdHFf+TmFXYi4FRnUn9DbwC+ut4Vpp1Kv5wCJnu0FQ7Fs
         FguQ2ZRgV2jnW4EYzXcr+tv6eBuk5XgKEbAUjuVNit4bVM0k3/3hUOu7MluFNeHyCHZR
         5Bpg==
X-Gm-Message-State: AGRZ1gLYuBRO2SYTXV4A0cnfb00d4pn2sM+aNbZITcgpbDqPMbEW0G5W
        IbknP26gSGAyJgJJPT4bWAE=
X-Google-Smtp-Source: AJdET5de9wbbH/+B8NPVDLnMQYOyVLLiZ1keyqYy8njWrzulBwaMiDt+axJCah+Pf/T9SoXYRceZxg==
X-Received: by 2002:a19:4287:: with SMTP id p129mr1387081lfa.135.1540978021862;
        Wed, 31 Oct 2018 02:27:01 -0700 (PDT)
Received: from [192.168.10.160] (91-159-62-242.elisa-laajakaista.fi. [91.159.62.242])
        by smtp.gmail.com with ESMTPSA id c5-v6sm810518lja.62.2018.10.31.02.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 02:27:01 -0700 (PDT)
Subject: Re: [PATCH 10/17] prmem: documentation
To:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-11-igor.stoppa@huawei.com>
 <20181026092609.GB3159@worktop.c.hoisthospitality.com>
 <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
 <20181028183126.GB744@hirez.programming.kicks-ass.net>
 <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com>
 <20181030152641.GE8177@hirez.programming.kicks-ass.net>
 <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <58295796-9bb5-080a-4c4d-47761d0876a9@gmail.com>
Date:   Wed, 31 Oct 2018 11:27:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/10/2018 18:37, Kees Cook wrote:
> On Tue, Oct 30, 2018 at 8:26 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>> I suppose the 'normal' attack goes like:
>>
>>   1) find buffer-overrun / bound check failure
>>   2) use that to write to 'interesting' location
>>   3) that write results arbitrary code execution
>>   4) win
>>
>> Of course, if the store of 2 is to the current cred structure, and
>> simply sets the effective uid to 0, we can skip 3.
> 
> In most cases, yes, gaining root is game over. However, I don't want
> to discount other threat models: some systems have been designed not
> to trust root, so a cred attack doesn't always get an attacker full
> control (e.g. lockdown series, signed modules, encrypted VMs, etc).

Reading these points I see where I was not clear.

Maybe I can fix that. SELinux is a good example of safeguard against a 
takeover of root, so it is a primary target. Unfortunately it contains 
some state variables that can be used to disable it.

Other attack that comes to my mind, for executing code within the 
kernel, without sweating too much with ROP is the following:

1) find the rabbit hole to write kernel data, whatever it might be
2) spray the keyring with own key
3) use the module loading infrastructure to load own module, signed with 
the key at point 2)

Just to say that direct arbitrary code execution is becoming harder to 
perform, but there are ways around it which rely more on overwriting 
unprotected data.

They are a lower hanging fruit for an attacker.

--
igor
