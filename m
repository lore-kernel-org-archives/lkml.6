Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C217AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 21:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D64D20664
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 21:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/Fxx3s9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D64D20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbeKXHtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 02:49:22 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43400 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeKXHtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 02:49:21 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so3791019pfk.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 13:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vJ2oW2MQrRXjgGlRSVw43ogX7g4kjePMWJEOb9+ZsSU=;
        b=q/Fxx3s9KyfctdEuEvrRI0NW5AFVu7pRtxiVG80P2OUISDCS+pmUrNIlU0HeGHYGyq
         Qy7Xz6FnTWlwlb19ofVpG/BVzHmyqMPR6GO5L+/iV/9B1dbHHB/w7RlqKQwcc3lnIViz
         QnFqRPEy5wRq+kWpuWSXSTXqNyUOKmja756IpLem3Jiq2NxcYm3FfzqOmKdXFu9mHdWq
         m36W7cxPdmUk9TP72AWkHkNvKvhGzUtfUZUj18VnEDYw7AFksEarFQ0VXIdbce7W7mgO
         ss/rAmaKVSBxAQaOTRQxkY8xBl3FwxUwLEnVbinlbGJxOtuBzDtr98/xOCKPK0uBLKAM
         LomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vJ2oW2MQrRXjgGlRSVw43ogX7g4kjePMWJEOb9+ZsSU=;
        b=lBh1+w5TjbDJkdYOHwtdJnv7tRobQX5q4JSCepwuoDuUAu+HA1/ws4x7jYPDfVrkKM
         qzAbT/T/itL9dPHC1ykRDl1ZoLgzpfFJ8xVbn2fBbKjflZXC9Q3kxI3hCMrZq5VWsA0z
         V7yYazV4PnxEBHTHw8aRsjFXka1gkS4UH1oB27bVU6qhJyDZWOoMrzy0nnQYPaCQxwG7
         FstJirBL0J9G2A7SUc4HBggMuqo2GxFVJ66xzMCzTyzLBjR4W5gx59drAWMpOphk7X9u
         Q1JSvzL8qE9Gch3v1z40672UlwwDNhykvak9Kge4uhtg3guL163e2n6xAr4VFvtGEKxf
         jU2Q==
X-Gm-Message-State: AA+aEWb57LRGZFO52HdjHRXyGpHC+9CnPgJcOzsWXXTZEuX09jcO9izo
        7SS/S2+SeoL8W9wa9/8EaUboNpXF
X-Google-Smtp-Source: AFSGD/VvAWUmrrYhmoEBuswi0g2mWBqkBXxfHmOHPLY+Ue5OihM2EhRVsJ/23d/rwUXaNAJMUqTXZQ==
X-Received: by 2002:a63:6984:: with SMTP id e126mr15764558pgc.143.1543007008369;
        Fri, 23 Nov 2018 13:03:28 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p2sm54303786pgc.94.2018.11.23.13.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 13:03:27 -0800 (PST)
Subject: Re: [PATCH] x86/TSC: Use RDTSCP
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>
References: <20181119184556.11479-1-bp@alien8.de>
 <20181123200307.GA6223@roeck-us.net> <20181123204425.GN30697@zn.tnic>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <901af2a0-e0d7-586d-5f04-2066cf1ac871@roeck-us.net>
Date:   Fri, 23 Nov 2018 13:03:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181123204425.GN30697@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/18 12:44 PM, Borislav Petkov wrote:
> On Fri, Nov 23, 2018 at 12:03:07PM -0800, Guenter Roeck wrote:
>> [    0.762832] EIP: read_tsc+0x4/0x10
>> [    0.762832] Code: 00 01 00 eb 89 90 55 89 e5 5d c3 90 90 90 90 90 90 90 90 90 90 90 55 a1 44 5a 8b c5 89 e5 5d c3 8d b6 00 00 00 00 55 89 e5 57 <0f> ae f0b
> 
> Where does that 'b' in f0b come from?
> 

Good catch.

It is a cut off screen log. x86 boots change xterm configuration from
wrap to non-wrap, and I did a cut-and-paste instead of copying the log
to a file. Sorry for that.

Guenter

> But ok, I was able to reproduce and decode myself. So if the Code:
> section is correct, qemu chokes on MFENCE.
> 
> [ 0.854209] Code: 90 90 90 90 90 90 90 a1 84 37 11 cd c3 8d b4 26 00 00 00 00 8d 76 00 c3 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00 90 55 89 e5 <0f> ae f0 0f 31 5d c3 8d b6 00 00 00 00 55 89 e5 57 31 ff 56 53 89
> All code
> ========
>     0:   90                      nop
>     1:   90                      nop
>     2:   90                      nop
>     3:   90                      nop
>     4:   90                      nop
>     5:   90                      nop
>     6:   90                      nop
>     7:   a1 84 37 11 cd          mov    0xcd113784,%eax
>     c:   c3                      ret
>     d:   8d b4 26 00 00 00 00    lea    0x0(%esi,%eiz,1),%esi
>    14:   8d 76 00                lea    0x0(%esi),%esi
>    17:   c3                      ret
>    18:   8d b4 26 00 00 00 00    lea    0x0(%esi,%eiz,1),%esi
>    1f:   8d b4 26 00 00 00 00    lea    0x0(%esi,%eiz,1),%esi
>    26:   90                      nop
>    27:   55                      push   %ebp
>    28:   89 e5                   mov    %esp,%ebp
>    2a:*  0f ae f0                mfence          <-- trapping instruction
>    2d:   0f 31                   rdtsc
>    2f:   5d                      pop    %ebp
>    30:   c3                      ret
>    31:   8d b6 00 00 00 00       lea    0x0(%esi),%esi
>    37:   55                      push   %ebp
>    38:   89 e5                   mov    %esp,%ebp
>    3a:   57                      push   %edi
>    3b:   31 ff                   xor    %edi,%edi
>    3d:   56                      push   %esi
>    3e:   53                      push   %ebx
>    3f:   89                      .byte 0x89
> 
> Doing this:
> 
>          asm volatile(ALTERNATIVE_2("mfence", ...
> 
> fails too which confirms that P3 can't do MFENCE.
> 
> I need to think about how to handle that old cruft.
> 
> Thx for the report.
> 

