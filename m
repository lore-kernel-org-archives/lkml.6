Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA915C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 12:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5ED4217F9
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 12:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="uIlJBqHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbeLWMZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 07:25:53 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:40326 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeLWMZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 07:25:53 -0500
Received: by mail-wm1-f47.google.com with SMTP id f188so9755793wmf.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 04:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=07d2jrndARIrOVwmGE2dKzT5S6G+DO8LvvlFZ4WozsU=;
        b=uIlJBqHpUYe05FvPLF2UGUqqTf2W4YNw1Nz6QqxO5lWevlSVczEtT759eIei8/WlVd
         xaYMLT/dTJOq91yff/DEgHvEdOfNByALBP6MqsN+4zxLQliQtCzqRl2hzqINVf7f4uEJ
         YzFddY7LdZdjHCkaMLSOOItBr/RUTSoo+0APbokrn/oKRnRAvWFx2tN8cB8XZjVZkzed
         SUdKuoL8PVmac4lfajCNfJTt1DJcZ5ogmrlznSuoH5ufs9tAA9YiWCJLPn1nIfC/JZgS
         e2xen4/F4CEQOcCeKw9S/NYEK/Hk4Ep0/mvkQk9wO+OVeDk7TYCrLZK1qWdtFT8ZbNEI
         dsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=07d2jrndARIrOVwmGE2dKzT5S6G+DO8LvvlFZ4WozsU=;
        b=P2i2zcASRi+Dwtw/I/fkwFjhEBeQIbzBMEUYyKnFMd9zz7lCVT6+Li7GZVrAw8zQcl
         1YjSeV+UYBsrXS4xbUWIrAKAHYr3vuvUdv+MBF7mZFtAckOMQXJNdTZbnbsV42R9uNT2
         xSa0Ksom8+AMk5iAB8zIr3dheN9AKMCsYrXkUUVAWbHIvBPDNUIj13Y3/6AiQL+fl38I
         tZMJRjICGS35sCzAs71XozqT/01waZjBBIi4WJco/CBrTpwc0nFLmucHJ28IxscHIm+A
         Wc3EOW/4x+x2qx9psTmZ1qNVW0pNUamk0Sbkx8G4ZzaxvwIaH4q1fcaSXJKmbC7323D2
         KAXQ==
X-Gm-Message-State: AJcUuke5540A2iVs9rcrhp8JcSXo2QsWvxLZ5o44I676p1821esDBUk/
        x9maMrDpyBTIEmMIybyOVEbjKw==
X-Google-Smtp-Source: AFSGD/WUiWtPhPog5N75tlzKVy1gTwH3qpPzobZpmRePEukjSA+BUN5vzkqya2ZezyU1OAixVKPNFg==
X-Received: by 2002:a1c:9183:: with SMTP id t125mr8878474wmd.79.1545567951148;
        Sun, 23 Dec 2018 04:25:51 -0800 (PST)
Received: from linux.fritz.box (p200300D993E1B70073C019066AB385FE.dip0.t-ipconnect.de. [2003:d9:93e1:b700:73c0:1906:6ab3:85fe])
        by smtp.googlemail.com with ESMTPSA id s1sm24977939wro.9.2018.12.23.04.25.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Dec 2018 04:25:50 -0800 (PST)
Subject: Re: general protection fault in put_pid
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot+1145ec2e23165570c3ac@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        ktsanaktsidis@zendesk.com, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Matthew Wilcox <willy@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>
References: <00000000000051ee78057cc4d98f@google.com>
 <CACT4Y+YX3=OLqfmWwhHVCQz+HwE=53VH9c1E2M+rgbF=UVTV5A@mail.gmail.com>
 <ab2fb696-8d3b-9720-a8a0-99c66a080605@colorfullife.com>
 <CACT4Y+Y-c7FgSTKyHqpRZu3eKLo5QfXy10axTSwWkU4MUgjFgw@mail.gmail.com>
 <87614226-e895-c3a3-3626-b0fbe7e191be@colorfullife.com>
 <CACT4Y+bU4mLF1tEhw6mKf1m1W63OGvaFhAsTrpTW0M5MFXekRQ@mail.gmail.com>
 <CACT4Y+Zynq-URqgJNyCZyTPM80GU8DndtKv=BFDU9_U=f0KceA@mail.gmail.com>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <cc088b05-7bc9-778e-30b9-4b8720314001@colorfullife.com>
Date:   Sun, 23 Dec 2018 13:25:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Zynq-URqgJNyCZyTPM80GU8DndtKv=BFDU9_U=f0KceA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dmitry,

On 12/23/18 10:57 AM, Dmitry Vyukov wrote:
>
> I can reproduce this infinite memory consumption with the C program:
> https://gist.githubusercontent.com/dvyukov/03ec54b3429ade16fa07bf8b2379aff3/raw/ae4f654e279810de2505e8fa41b73dc1d77778e6/gistfile1.txt
>
> But this is working as intended, right? It just creates infinite
> number of large semaphore sets, which reasonably consumes infinite
> amount of memory.
> Except that it also violates the memcg bound and a process can have
> effectively unlimited amount of such "drum memory" in semaphores.

Yes, this is as intended:

If you call semget(), then you can use memory, up to the limits in 
/proc/sys/kernel/sem.

Memcg is not taken into account, an admin must set /proc/sys/kernel/sem.

The default are "infinite amount of memory allowed", as this is the most 
sane default: We had a logic that tried to autotune (i.e.: a new 
namespace "inherits" a fraction of the parent namespaces memory limits), 
but this we more or less always wrong.


--

     Manfred

