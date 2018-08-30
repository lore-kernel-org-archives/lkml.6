Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A93C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 23:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E9A20837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 23:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQXzZ7mJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E9A20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeHaDKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 23:10:44 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34789 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeHaDKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 23:10:44 -0400
Received: by mail-io0-f194.google.com with SMTP id c22-v6so9000884iob.1;
        Thu, 30 Aug 2018 16:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yTQBRLerdEn1OoTjk02jmvGU6noLiIRegCTIkMAT8rI=;
        b=JQXzZ7mJN4sSDIg0IYU5aGqq1o8+7z44X8ny6InnqHYmTF3nRy2vhIUX7l8BTb/BX9
         Yvl4GhXFB+ajS1uWyFEZtE+IrIgU9al9l2xv8Wv0RVQx88H77PiIWeNr+UfXnVeU6wqB
         W+gUMD9+4Zn6BxD/n6CvsZma2xkQBgckxJWp3OuePeLR72ikuCAe0Fw0ZuLWlcnhEU5R
         vXbwXyZ6r5YhkitvqW909NVBjl4Qdd3m49Sr3gxD6hp2JHY8WHk/6/vwQcBkLNPJ4Srl
         tb+f0XgWZ2fH41idMFGY0opF3j/THSBmUMz3g8m+BcXKyAVLy39HIIw4uAbiyqE1cBL0
         EGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yTQBRLerdEn1OoTjk02jmvGU6noLiIRegCTIkMAT8rI=;
        b=n/3UgOpnpcjt/W9ciNLjobpRpryUpnfaj61jbMdeub1pawqK8bl8qzU5A8Jb1sK2M7
         p701y/sw2hTx8kvguXD17Fsj3p0EZbInRckiRreD3K8AbY9bj1MW+MXpbGBdY3onok9N
         R0cXHZBF52Dv0DALJrMSVEddmSbm00i2wqytiEyK542IROcP4wa9ONfew2ZJzeVZKkIh
         z3dpoltp8r2o94i6mG62+buhfICfPo1WI7iFnNCjC+nodWsz1/PCJibeuy+34AJFS6s9
         vIrrI8icg21DkgMEMcLjOV11FaKUGxfa2qIvf7K6egMSHYoljMO4Di0b/kEj2V7fDtme
         1shg==
X-Gm-Message-State: APzg51Abj3fdr0Ue3B81g5zvq1IXgAMdqq23+qGgt/7oLB7ETE2ad+MA
        k+6F9wIBePoFk3tV/vFDqM8=
X-Google-Smtp-Source: ANB0VdYWSIgRwYHP/qcSwxsK4XsQ8tY5S+BfycFTxhtaLRp5rq3/QCPzyBwEDTiKu1btse2S2JpltA==
X-Received: by 2002:a5e:c80b:: with SMTP id y11-v6mr10545584iol.198.1535670373259;
        Thu, 30 Aug 2018 16:06:13 -0700 (PDT)
Received: from [192.168.86.250] ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id m29-v6sm1529564iti.5.2018.08.30.16.06.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 16:06:12 -0700 (PDT)
Subject: Re: WARNING in handle_irq (3)
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+a58b558e3e62d0604e5c@syzkaller.appspotmail.com>,
        netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, nstange@suse.de,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>
References: <0000000000003b1c360574a8c31e@google.com>
 <CACT4Y+Yuwcm9N-_QwyPzj==xFUuziW24eQzw318Y=VKXQ=8_nw@mail.gmail.com>
From:   John Fastabend <john.fastabend@gmail.com>
Message-ID: <7e866a56-23a1-a528-63cb-8f6da536df74@gmail.com>
Date:   Thu, 30 Aug 2018 16:05:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Yuwcm9N-_QwyPzj==xFUuziW24eQzw318Y=VKXQ=8_nw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/2018 08:39 AM, Dmitry Vyukov wrote:
> On Thu, Aug 30, 2018 at 8:31 AM, syzbot
> <syzbot+a58b558e3e62d0604e5c@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    58c3f14f86c9 Merge tag 'riscv-for-linus-4.19-rc2' of git:/..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=10be176a400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
>> dashboard link: https://syzkaller.appspot.com/bug?extid=a58b558e3e62d0604e5c
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
> 
> +bpf maintainers
> 
> Looks suspiciously similar to:
> https://groups.google.com/d/msg/syzkaller-bugs/4v7MtbIT1hY/A87hInzyAwAJ
> 
> Note this commit seems to already have "bpf, sockmap: fix
> sock_hash_alloc and reject zero-sized keys ".
> 
> Tentative reproducer from the log is:
> 
> 14:08:59 executing program 5:
> socketpair(0x20000, 0x0, 0x0, &(0x7f0000000140))
> r0 = socket$inet6_tcp(0xa, 0x1, 0x0)
> r1 = socket$inet6_tcp(0xa, 0x1, 0x0)
> bind$inet6(r1, &(0x7f00000000c0)={0xa, 0x4e22}, 0x1c)
> listen(r1, 0x0)
> sendto$inet6(r0, &(0x7f0000000140), 0x2d6, 0x20000004,
> &(0x7f0000000080)={0xa, 0x100000004e22, 0x0, @loopback}, 0x1c)
> setsockopt$inet6_tcp_TCP_ULP(r0, 0x6, 0x1f, &(0x7f0000000080)='tls\x00', 0x152)
> r2 = bpf$MAP_CREATE(0x0, &(0x7f0000000280)={0xf, 0x4, 0x4, 0x70}, 0x2c)
> bpf$MAP_UPDATE_ELEM(0x2, &(0x7f0000000180)={r2, &(0x7f0000000000),
> &(0x7f0000000140)}, 0x20)
> 
> Which does not create a 0-key map.
> 
> 

Hi Dmitry,

Testing a fix for this now, we have an error path that can
call module_put and/or null the ulp ops erroneously. Should
have something out later tonight or worst case early tomorrow.
Thanks for the snippet.

Thanks,
John
