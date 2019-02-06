Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C31BC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE96218A1
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtA+9IsU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfBFDmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 22:42:11 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33403 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfBFDmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 22:42:10 -0500
Received: by mail-yw1-f66.google.com with SMTP id p17so2657667ywg.0;
        Tue, 05 Feb 2019 19:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uuk/Rx3fe36tfTHzRztmfd0lDXHNL10LU3kOZdp1hLE=;
        b=LtA+9IsUZ0PY7OKLz28eIcTe4UFsH4e0/x7f+27OPl86WkK2jL2Hu6qOpe9dK+v5nt
         /f+UZZ0cXYFy2JIrwlIs9+bagKzdSEqlYmhRgWfItSQsU2FExcTTVA9YWYkf1Kyuskzg
         acnPdlIHnx/FUIuJwJ14VxFLqyyVGLA8Y4OBp1PcuX6GqLVeBx8Qgqh12aJZqRYCg7b6
         GCogJBrbAjXarCPbEmdhF++mWJWdI224CincQXcceLBRw12X7356hwJHGFSmaCzIyjIY
         K6VFyL9GsW7AGvMlVINxVRuz4GCYP4q3R3x0tLczmYnbpvMOzsrs6/zCuJtNHC911YMu
         dSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uuk/Rx3fe36tfTHzRztmfd0lDXHNL10LU3kOZdp1hLE=;
        b=gcP4s0kzq0Zidr3+fuxtHquhmbd6+bBQExV5/oB21VHMvKLH6LP+b+O/hWeC2SgqF1
         oOJaLC5K/e9kc35ne7UvBWwcCw32hKyrjjDK6gwKAOr6LQV2a/1bDzn9cW78Xr1l8si+
         3CSf08JphEBps3XLRx1+oxfzLv/DyOTLmAPbMb/UADvDFhZ6qTa3cN3St8xw/aXtAFu3
         T7FSGh6BSBTbiw8XGabvRO0KkxtEsUTI+YZjuQrFUqsRt3J45JLN4obIXAHZx7OpKcpv
         +ZwT06Z8Pt0ztpg7GPH8SWceeNaPDGEAr0Goz9uwZh6mDaDM1sIqvlFlnrLp6KVUNGsu
         6OHg==
X-Gm-Message-State: AHQUAuYhwp58+BKE5CuY/dGeprIcpekEcN+bf3sFycASKT/QngEo3YWI
        25e9xrQF6gsIhE+/6RNBrT6GYBA7
X-Google-Smtp-Source: AHgI3IaMPeW4EjK/tL+dSKvp6jgPGkFf/2HkABb8VCUawam8I9to5SczxgV/zsRoUn78RWAQEEUAKg==
X-Received: by 2002:a81:b341:: with SMTP id r62mr6922350ywh.65.1549424529277;
        Tue, 05 Feb 2019 19:42:09 -0800 (PST)
Received: from [192.168.86.235] (c-73-241-150-70.hsd1.ca.comcast.net. [73.241.150.70])
        by smtp.gmail.com with ESMTPSA id w2sm1825993ywc.63.2019.02.05.19.42.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 19:42:08 -0800 (PST)
Subject: Re: KASAN: use-after-free Read in __wake_up_common_lock
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+fb065bc06d3d4054be6f@syzkaller.appspotmail.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     Karsten Keil <isdn@linux-pingi.de>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <000000000000c2e17f0580b3387c@google.com>
 <CACT4Y+YOTSY=ZVw882tfDDPZ6Y5ZSX6HHn2M=Q2uTxjUtjb9=w@mail.gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <6f9de558-6447-b64d-33c2-77bfc9f7aec6@gmail.com>
Date:   Tue, 5 Feb 2019 19:42:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YOTSY=ZVw882tfDDPZ6Y5ZSX6HHn2M=Q2uTxjUtjb9=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/05/2019 07:28 PM, Dmitry Vyukov wrote:
> On Wed, Jan 30, 2019 at 10:02 PM syzbot
> <syzbot+fb065bc06d3d4054be6f@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    62967898789d Merge git://git.kernel.org/pub/scm/linux/kern..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=10f0bf08c00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=4fceea9e2d99ac20
>> dashboard link: https://syzkaller.appspot.com/bug?extid=fb065bc06d3d4054be6f
>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+fb065bc06d3d4054be6f@syzkaller.appspotmail.com
> 
> I assume this is also fixed by:
> 
> #syz fix: mISDN: fix a race in dev_expire_timer()

Yes this looks very probable, thanks.

