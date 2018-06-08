Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id OAJYIauoGlsjQgAAmS7hNA
	; Fri, 08 Jun 2018 16:03:18 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E9652607DC; Fri,  8 Jun 2018 16:03:17 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXLyAEAs"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5906B601B4;
	Fri,  8 Jun 2018 16:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5906B601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752931AbeFHQDP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 12:03:15 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52623 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752846AbeFHQDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 12:03:13 -0400
Received: by mail-it0-f67.google.com with SMTP id m194-v6so2975147itg.2;
        Fri, 08 Jun 2018 09:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HbxImwP63/em8teen6Tqa/C8pMEx1y1l/pOX9RiA6BY=;
        b=pXLyAEAsIhxftZ2wrmdHZZXhyoRgqPU84iiqq9rVGW72cVIhLS/DZbupH675zFxxUd
         I3FY6s+yokODyghExo3hadNv8aNp/q+lKO5hUDSI2FtyKIPCdJZReYRYTr3ymym2LWEE
         DZ8pbBS6X0B889c/UgVNafqJkDR8ih1lgoPiXePD4yilOa6sS7zwkktJ76rspHknnqie
         JmfnPY2jKp+Anl7SD+PaCF0Bbsi0D5AE0eHr/OorccO5Sm5K7gJiLXqbeIRqKZ5Pbvdm
         6WWVlQxLNfPgNOfdPOWQwoMKjvCpFZTy+PIEInLbLHnPxaJ+Bqeaxu1r/Gcz4TyNSnpb
         AX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HbxImwP63/em8teen6Tqa/C8pMEx1y1l/pOX9RiA6BY=;
        b=rHoYgya29ArEnuFTdxytAElBid/cAhL8ou7fMKVOQQRs/7hw0o+j5ohKttLdN6SobJ
         NfNaFXNWeNDdxRB8X9lVPHoUj6Sf0KCjXQyuKm0SyvYEllMli8jbqohLeLFjCTwoqwPL
         8g2gL19nmmZRFFP9BHbkKMXOOYPZBGcgEybBIJ74VTpKmfcXLEap9Df23b8RFx3Bj5TC
         Fnu3LjGimY8TQQ9XNeySKZTsEWsz21r3Uot4a/2j+jwCps8g7WySSTPn0BEepd2otl7B
         a7wWs5A+FcIGdqKWkBfI1wjGuh2kVcfer/ZbOMFsH4oc9j0rIfyb8sgJEJvQYNsBJ7Wl
         5XAw==
X-Gm-Message-State: APt69E32lfm6Rvc5fw8P/aYZxFsEvEDeX5B8od1ygXmDRczgE9o864Lm
        c2XyPxNbevc9tmh8dC0F2Yw=
X-Google-Smtp-Source: ADUXVKKQ+4aYCxMY6Ds5gB5/0tKAzwsIRMYTEHFg+9fa1ou3H5bEWz/RdVLbmZfk6pH9wtvatZwMjQ==
X-Received: by 2002:a24:1d4:: with SMTP id 203-v6mr2148469itk.97.1528473793042;
        Fri, 08 Jun 2018 09:03:13 -0700 (PDT)
Received: from [192.168.86.235] ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id l24-v6sm9006683iog.59.2018.06.08.09.03.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 09:03:12 -0700 (PDT)
Subject: Re: KASAN: use-after-free Write in bpf_tcp_close
To: Dmitry Vyukov <dvyukov@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: syzbot <syzbot+31025a5f3f7650081204@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <000000000000cb4149056d3587f5@google.com>
 <ca3eff64-adb0-6110-38ca-2e07b6ecc3d6@iogearbox.net>
 <CACT4Y+YqCF3mcjkJSZaJSpBHazQsucdZWdgksg=Cdi7AFQuEqQ@mail.gmail.com>
From: John Fastabend <john.fastabend@gmail.com>
Message-ID: <e9585eb9-5374-12bf-ec5f-58cbb384d6e8@gmail.com>
Date: Fri, 8 Jun 2018 09:03:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YqCF3mcjkJSZaJSpBHazQsucdZWdgksg=Cdi7AFQuEqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 09:58 AM, Dmitry Vyukov wrote:
> On Mon, May 28, 2018 at 12:15 AM, Daniel Borkmann <daniel@iogearbox.net> wrote:
>> [ +John ]
>>
>> On 05/27/2018 10:06 PM, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following crash on:
>>>
>>> HEAD commit:    ff4fb475cea8 Merge branch 'btf-uapi-cleanups'
>>> git tree:       bpf-next
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=12b3d577800000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=b632d8e2c2ab2c1
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=31025a5f3f7650081204
>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=109a2f37800000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171a727b800000
>>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+31025a5f3f7650081204@syzkaller.appspotmail.com
>>
>> Should be fixed by: https://patchwork.ozlabs.org/patch/920695/
> 
> #syz fix: bpf: sockhash fix race with bpf_tcp_close and map delete
> 

Same here 'bpf: sockhash fix race with bpf_tcp_close and map delete"
was dropped and a new fix will be posted shortly.

Thanks!
John
