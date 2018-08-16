Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FF2C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9864A20C0D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otReBDuT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9864A20C0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbeHPVhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:37:32 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36220 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbeHPVhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:37:32 -0400
Received: by mail-lj1-f196.google.com with SMTP id u7-v6so4450195lji.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 11:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7fpyD5QkjGMTzyqAYnXR/sR7gSNdiSbya+0evF8OqQ4=;
        b=otReBDuTAWlWsYXB4485SHQtN4lc/XkitAm6Jmxqhf/bI5ycM0/ctEe+vfXAw69pes
         w1RTpdvoDPmOWVwZHcJddHQASG3bdqW7ZIbvF3xJoGcPRI+HjaffjYzvFnwwuM9arCs1
         4HPtbEzC4t+/GfuAT8OffgMrCvclkhPJ9I0PWf/LOjV7hgQSQbSycHQhbWue7a3WGfFL
         HNSub4awDa5XkMoQP96JsaJWUsrHuXbO6qDVmL58H6gAJQntzdj+JgvTR+6Om73a3eJA
         vCCsR9dXNj8osoCsTS7EKFJ6uUAZ3P+VIoz09rLPGX09rbQbA+xidOkdXVOY8c8CvLHZ
         jv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7fpyD5QkjGMTzyqAYnXR/sR7gSNdiSbya+0evF8OqQ4=;
        b=mnxAfe0cJrvpTEYlUctQxh3HgfvP/RhSD0+lwNtCEgUr4MOs6IhaVbADfnEYNHr6ZP
         UVfmaQ8iv4ef5/U2qKKjvPhi+2Lankfqur3oLTSz4ANMCJ69weRQQjoHQSelZJ3TUJMK
         Hi80TpYcnwNclZYRyu5wZ+hl/aAJiIDbPLdoGAAyL0U22BOwt+85t4rsWQBuyt5zIrcQ
         a81eCnegulfDwJzKlVr9GCMe1P10lOKMcOiKMgVEqHnku36VJ+DwlbW6zVC5vgQUhShi
         k409LPhQPBJX+P0Bs1wehueRdSCJ2vX7AWFaLKFzq5ZAsTMPF5aWXM+1FPS8MOT3AAe1
         79ew==
X-Gm-Message-State: AOUpUlEOkTBC6s4jqk9WseI/VpDifFE7FIfSwPzKlMr5He89ZCl/Qw9r
        BuG4eXU4YmG+OZBYuVMK0hFyjethZGc=
X-Google-Smtp-Source: AA+uWPxHOg1tmhmqFdfiX2kcrlEfudDYPG1DGdMNSXlSdYaP9h815O2R8n9b++I1+5SBJvC0E1S4zQ==
X-Received: by 2002:a2e:5d88:: with SMTP id v8-v6mr21057967lje.137.1534444644650;
        Thu, 16 Aug 2018 11:37:24 -0700 (PDT)
Received: from [10.112.23.205] (nat-eduroam-hy-138-172.fe.helsinki.fi. [128.214.138.172])
        by smtp.gmail.com with ESMTPSA id j10-v6sm4690ljb.33.2018.08.16.11.37.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 11:37:23 -0700 (PDT)
Subject: Re: AArch64 boot failure on Hikey960 on latest master after "arm64:
 insn: Don't fallback on nosync path for general insn patching"
To:     John Stultz <john.stultz@linaro.org>,
        Will Deacon <will.deacon@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <462f8ae6-9948-a8e5-7504-623d40344336@iki.fi>
 <20180816102219.GF31093@arm.com>
 <CALAqxLWJzpV2Mqkz_ed_5zYX3SFyMZTBgTzyRAden7ab3VNm-Q@mail.gmail.com>
From:   Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Message-ID: <95c5c8b6-35f9-b1b4-0153-591b000c0a79@iki.fi>
Date:   Thu, 16 Aug 2018 21:37:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLWJzpV2Mqkz_ed_5zYX3SFyMZTBgTzyRAden7ab3VNm-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/16/2018 08:57 PM, John Stultz wrote:
> On Thu, Aug 16, 2018 at 3:22 AM, Will Deacon <will.deacon@arm.com> wrote:
>> Hi Tuomas, [+John]
...
>>
>> Out of interest -- do you know if Hikey960 is used by any boot-testing
>> farms? The patch above has been in linux-next for ages, but we didn't see
>> any complaints until it hit mainline :(
> 
> Unfortunately not yet. HiKey960 upstreaming is ongoing, and the UFS
> support patches should land in the 4.19 merge window.
> After which, it will enable more mainline testing as folks won't have
> to carry patches just to get the system to boot.
> 

A microSD rootfs gets me a working system on e.g. v4.17... except that
even there the system hangs if I don't have 'clk_ignore_unused' on
the kernel command line. I wonder if this is a known problem?

- Tuomas
