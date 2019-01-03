Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0CAC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9679F208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDqk9emA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfACUBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 15:01:34 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35682 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfACUBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 15:01:34 -0500
Received: by mail-ed1-f68.google.com with SMTP id x30so30053137edx.2;
        Thu, 03 Jan 2019 12:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZWCjQ4ddTYt+IuMuxquO5ufyiSZxLslzvwNL99DjM2c=;
        b=CDqk9emAoJer0ri7wRCVFdcQ7JE6/dN73LQ2xKU+he/tkR1MRfSbgsjSfsdWLk+8+K
         ZmZstnEu4w5VnRuSVeKzQOQNOjK3T7wwnuIK3dV7KCp9KMea8j+7cNwbpOQe9qOXOf/x
         4/+UcuS3pJA63z/psx1F+pHgBR6lCafMAqFKQmbA5dUrjH2mwfRpR0AvjYW1mMEZmNIq
         icP4WguP3+B4+oAQ8u4XBak0N2C5kPdxCz4gvOnMsF8/NDDelvW24wQeYWWxGBEgMnCE
         Q3r1AgNbVHBGJTCOuway6b7HXLO9fFPSjRNGv79sloa4BfYz7663N7S/gNBPC9/7+0f6
         Tl/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZWCjQ4ddTYt+IuMuxquO5ufyiSZxLslzvwNL99DjM2c=;
        b=ZJEgXwCeUAlQix94tjboPVCtC7u+X+urFDKWd5l2AO/S3/H65t/pwEhT01BknPPDb5
         rhcRlhYijwW6cdjjJjFN6po2ybbYGUU1+TdopqQqR8H3ySI9dYX2kNeKiLY7OtsQDfCn
         7dOn+ElVaOoTIJJgjpM+g98CD4rbAwqBllSMhOc/NuSE29p06IdcNpgT8l64Ci9L/D8V
         vWo7CqPjs4oKvb2hIXYjXE+L3AOO7e+suCut2zBK/h+u8eGYgP5ie4wP0m9vudlhRH5e
         gFixr+wx52n5buqZmBdp4B2cHaX20d46b+vivdodfkrnHF6dkxp9lNad0rFtxuFPU0eN
         m91g==
X-Gm-Message-State: AJcUukfSnnVt1u3Jw7c3ysHLrfydrfJNnIcETA8HTf8YrsF7yz1ZMI84
        rIB4zutsgEDPm60T/PfuDV0=
X-Google-Smtp-Source: ALg8bN6gcVwirCqvFRqXXivZ81p01EqhzYYCWRFx6LSXo0dZX/W65Wvr1Dh4weGPv6UVwA6jt4Xd/w==
X-Received: by 2002:a50:c299:: with SMTP id o25mr17337050edf.281.1546545692307;
        Thu, 03 Jan 2019 12:01:32 -0800 (PST)
Received: from [192.168.8.147] (205.17.136.77.rev.sfr.net. [77.136.17.205])
        by smtp.gmail.com with ESMTPSA id p16-v6sm14344365eju.73.2019.01.03.12.01.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 12:01:31 -0800 (PST)
Subject: Re: kernel panic: stack is corrupted in udp4_lib_lookup2
To:     syzbot <syzbot+4ad25edc7a33e4ab91e0@syzkaller.appspotmail.com>,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org,
        Stefano Brivio <sbrivio@redhat.com>
References: <000000000000513fb7057e8d7013@google.com>
Cc:     Willem de Bruijn <willemb@google.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <f2e566ac-5c4c-11ae-d436-ebb3522a2195@gmail.com>
Date:   Thu, 3 Jan 2019 12:01:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <000000000000513fb7057e8d7013@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/03/2019 05:07 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    195303136f19 Merge tag 'kconfig-v4.21-2' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12245d8f400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5e7dc790609552d7
> dashboard link: https://syzkaller.appspot.com/bug?extid=4ad25edc7a33e4ab91e0
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+4ad25edc7a33e4ab91e0@syzkaller.appspotmail.com
> 
> protocol 88fb is buggy, dev hsr_slave_1
> protocol 88fb is buggy, dev hsr_slave_0
> protocol 88fb is buggy, dev hsr_slave_1
> FAT-fs (loop0): invalid media value (0x00)
> FAT-fs (loop0): Can't find a valid FAT filesystem
> Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: udp4_lib_lookup2+0x7ea/0x7f0 net/ipv4/udp.c:455
> CPU: 1 PID: 17960 Comm: syz-executor2 Not tainted 4.20.0+ #176
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.

Maybe commit 11789039da536fea96c98a40c2b441decf2e7323
Author: Stefano Brivio <sbrivio@redhat.com>
Date:   Tue Dec 18 00:13:17 2018 +0100

    fou: Prevent unbounded recursion in GUE error handler

Forgot to deal with IPv6 ?

