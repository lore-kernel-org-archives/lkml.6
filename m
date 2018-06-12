Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B24D3C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B94208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLfoVfov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B94208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933555AbeFLK44 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 06:56:56 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:47051 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932556AbeFLK4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 06:56:53 -0400
Received: by mail-pl0-f68.google.com with SMTP id 30-v6so14135378pld.13;
        Tue, 12 Jun 2018 03:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=bAQmhiG0d/rA242iDtDBG3ksrc7d9+O2dlTHEQiuaJs=;
        b=jLfoVfovpk0mKFMtvaEYc2nNPgyC/i9xM9U7ZZlDJ7OwOSqv4YSc6ot8hsz5+ZOHjO
         iJw3j3BMDt1djoBmhM2HQYLW2Ef1DpXR1svrSlVhQM/eY1cfbuwFQR1FrvS4e6CXT+WH
         +xDr1Pj+PywQzX2HhXENoUnf4cMWV1oPcHWwEpFOk4+5sVmze3bAanL4SgSdvLcRvicB
         uCLk8CouCDycIql4jS4nMGjNR2BXbIE6KABbzyPYiYlO2V0G5pGHmvbNEUHyiBAaWM2r
         21tFUs8ca9T1hOoRmyw+fItgSRnVgXrvJ1+9h4lpFTRZMa+1x6X2dOie8p4qxzxmNxm0
         AuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bAQmhiG0d/rA242iDtDBG3ksrc7d9+O2dlTHEQiuaJs=;
        b=H//ESv8xoe/8SZgFGyF2zFDU9cUkCLPP1G0+NlnCM9++TwRqg1H4mkTB8Dlkn564yg
         VaMWIY1aBTToueQY3Tvn1jjR1uxiHRdoPrk07nkOB+XuwM7O4z2gVM4Hlce3hGMoFPja
         Jp7ByfzHMhIYkAigXsHdeKQ5kcvOkXpOUGa4uWTcWmqvw12hHd8UW3axfaCJD1pEd8ED
         DbnBajmQby2F95OxpkA4NnEnIAfi0fSPl9NzVjN6C4bu39Pl7yb65WBmktzABjxcx3W6
         o9oAY+Pa+wp/r5vFuItQt2MdMMY4/TLHfgQDaFSn54/goQ5HmOnVKmaGH0eByUCjFt1P
         Zgew==
X-Gm-Message-State: APt69E2pPN/Qgf5VXEkbIOPzrvEoQ3OXIGx5GR068sLW7AIPcTtWzLC9
        vt3nDZ+zD1F9RnmJ9c1jjZU=
X-Google-Smtp-Source: ADUXVKIsoP7pe/v/LuLKBO/LWOx9/x3R+oH4JuPu1SoR+AS+xe2Wuh1yjXZdNbBKjFKJHLMDht22PQ==
X-Received: by 2002:a17:902:3081:: with SMTP id v1-v6mr3626488plb.266.1528801012619;
        Tue, 12 Jun 2018 03:56:52 -0700 (PDT)
Received: from [192.168.1.11] (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id e68-v6sm3170674pfl.65.2018.06.12.03.56.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 03:56:51 -0700 (PDT)
Subject: Re: [PATCH 00/10] Control Flow Enforcement - Part (3)
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
From:   Balbir Singh <bsingharora@gmail.com>
Message-ID: <bbfde1b3-5e1b-80e3-30e8-fd1e46a2ceb1@gmail.com>
Date:   Tue, 12 Jun 2018 20:56:30 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607143807.3611-1-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/06/18 00:37, Yu-cheng Yu wrote:
> This series introduces CET - Shadow stack
> 
> At the high level, shadow stack is:
> 
> 	Allocated from a task's address space with vm_flags VM_SHSTK;
> 	Its PTEs must be read-only and dirty;
> 	Fixed sized, but the default size can be changed by sys admin.
> 
> For a forked child, the shadow stack is duplicated when the next
> shadow stack access takes place.
> 
> For a pthread child, a new shadow stack is allocated.
> 
> The signal handler uses the same shadow stack as the main program.
> 

Even with sigaltstack()?


Balbir Singh.
