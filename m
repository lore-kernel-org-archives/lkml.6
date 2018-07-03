Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD435C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FDE120C07
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V8+wbj6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FDE120C07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752788AbeGCKvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:51:53 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33878 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752576AbeGCKvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:51:51 -0400
Received: by mail-yw0-f193.google.com with SMTP id j68-v6so516677ywg.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 03:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1wtzN+0tJwzobJaW2XUAgWJ2+1M4tAWFKex3GPA0EBQ=;
        b=V8+wbj6jwQXigi6INHfQNW1nbvUZwhfbRqApDRQCTZDvl9uCrjUO+l9fMuUOuw/+SY
         i3xX1RjKW6XXvgsNUtnBNyRspjiEbL30ybNyeGoBEarnsU6Zksge9MQvB82VdvqxNO/O
         Yle51AOwBaGPwg7aXmhDWuED8i1abC+MjTGDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1wtzN+0tJwzobJaW2XUAgWJ2+1M4tAWFKex3GPA0EBQ=;
        b=WPDdHV0NGFUoSXIIBns/qwU7X0mjApEQdHWUkvyz2tjYLfFWOVuYNvUwojgZbNg0Qm
         En7dXPZuSNHBbIrQUm+ubHDM8GeTuTvhKaxB/+KgS8bLsJX78pqGhSUhSq7FXwMxAM5d
         zicQw/E2KzAKP78d9JYz4vpcqJfnFETT+IktWqDTEya696LYvape0jA2d1QicIxNB/b7
         VgYHWchPoFDWDeyeFPjcoMrViy58ybOdKWIW5zrqR7WtDCkjK/kz4QA9ongVkQLGRzHg
         bIH8mPz5SXoSR3UNj4cnLom8lsZdYGJDEZXJ9rfQh8rAZ9bMCsuFi8G2INte5ZpN/3fF
         J5FQ==
X-Gm-Message-State: APt69E1XdKiVQLYwemn9QeQd/jpRKEhijeloWGZvcgto2hT960K4OQAW
        psNPc64uo9/Wt1IgApM6P/K/mLBNsShyIfLyq/7Wzw==
X-Google-Smtp-Source: AAOMgpdMWSFXuiczw4NhyTL2Vlc6lCCrMrzDIRLv8yIPK2Zrlm6lM9WBfVDezMAdfPsoiMsEB+s2cE3fOw3+qTEbEJM=
X-Received: by 2002:a81:77c3:: with SMTP id s186-v6mr8952576ywc.31.1530615109791;
 Tue, 03 Jul 2018 03:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180612110510.11731-1-anders.roxell@linaro.org>
 <d6851756-ae3b-09ec-f487-1eeece6bd4c6@iogearbox.net> <CALDO+SY3qNYAOSiYC3645C7YY9LSx7ggg0GjY76m4TbBfF_t3A@mail.gmail.com>
 <CADYN=9+3V4fpqbjh-X4VUVWd_X38XSYhEbZoRBffcx=-nMtF8g@mail.gmail.com>
 <CALDO+SZXvnUU7VKd_UwnBCU0NiTHjqei4xEUCdcktkKCD3MnEg@mail.gmail.com>
 <CADYN=9KegM2wNCX7=BDct16bzzmr-02aG1c3MLDEEon1yGXnzQ@mail.gmail.com>
 <CALDO+SY2eE6DHtVmfnUpMjTjHe3shfzae48nk_OehfUyuKNYsg@mail.gmail.com>
 <CADYN=9JAOim7CvoZzWnbHNEF+4yG3Lzvry1rZLqGp+7hQxPdkw@mail.gmail.com> <CALDO+Sap3GTW3Ud4u-950ZicXpqfCh3kV5x8FVFpPmH+snOsGg@mail.gmail.com>
In-Reply-To: <CALDO+Sap3GTW3Ud4u-950ZicXpqfCh3kV5x8FVFpPmH+snOsGg@mail.gmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 3 Jul 2018 12:51:38 +0200
Message-ID: <CADYN=9LxoRfa6z2PQqs7fdLkDtSPvebrbO8T5gr3ZAjhEG5L_Q@mail.gmail.com>
Subject: Re: [PATCH] selftests: bpf: config: add config fragments
To:     William Tu <u9012063@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2018 at 23:27, William Tu <u9012063@gmail.com> wrote:
>
> >> >
> >> > --- ::11 ping statistics ---
> >> > 5 packets transmitted, 3 packets received, 40% packet loss
> >> > round-trip min/avg/max = 0.139/1.857/5.293 ms
> >> > + ip netns exec at_ns0 ping -c 3 -w 10 -q 10.1.1.200
> >> > PING 10.1.1.200 (10.1.1.200): 56 data bytes
> >> >
> >> > --- 10.1.1.200 ping statistics ---
> >> > 3 packets transmitted, 3 packets received, 0% packet loss
> >> > round-trip min/avg/max = 0.214/0.256/0.305 ms
> >> > + ping -c 3 -w 10 -q 10.1.1.100
> >> > PING 10.1.1.100 (10.1.1.100): 56 data bytes
> >> >
> >> > --- 10.1.1.100 ping statistics ---
> >> > 3 packets transmitted, 3 packets received, 0% packet loss
> >> > round-trip min/avg/max = 0.210/0.211/0.213 ms
> >> > + check_err 0
> >> > + '[' 0 -eq 0 ']'
> >> > + ret=0
>
> So looks like the ipv4 over ipv6 gre passes.
>
> >> > + ip netns exec at_ns0 ping6 -c 3 -w 10 -q fc80::200
> >> > PING fc80::200 (fc80::200): 56 data bytes
> >> >
> >> > --- fc80::200 ping statistics ---
> >> > 10 packets transmitted, 0 packets received, 100% packet loss
> `
> but the ipv6 over ipv6 gre fails.
> Do you have any firewall rules that block this traffic?
> or if possible, the packet might get dropped at function ip6gre_xmit_ipv6
> can you print the return value of this function?
>
>
> >> > + check_err 1
> >> > + '[' 0 -eq 0 ']'
> >> > + ret=1
> >> > + ip -s link show ip6gretap11
> >> > 19: ip6gretap11@NONE: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1434 qdisc
> >> > pfifo_fast state UNKNOWN mode DEFAULT group default qlen 1000
> >> >     link/ether de:d2:0c:53:80:8c brd ff:ff:ff:ff:ff:ff
> >> >     RX: bytes  packets  errors  dropped overrun mcast
> >> >     2096       25       0       0       0       0
> >> >     TX: bytes  packets  errors  dropped carrier collsns
> >> >     5324       36       5       5       0       0
> >>
> >> So there are 5 errors at TX.
> >
> > and today when I tried it on next-20180620 I saw 8 errors at TX.
> >
> >> I couldn't reproduce in my local machine using 4.17-rc6.
> >> How do I checkin the "next-20180613" source code?
> >
> > You can find the source code here [1], and I would look in the latest tag that I
> > said that I was able to reproduce it on above.
> >
> > Cheers,
> > Anders
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
>
> Hi Anders,

Hi William,

>
> I'm still not able to reproduce the issue on next-20180620.

I'm not able to reproduce it either, and I tried on todays tag as well
next-20180703.

The only test that is failing in bpf/test_tunnel.sh:

FAIL: xfrm tunnel

Cheers,
Anders

> Below is my test.
>
> Testing IP6GRETAP tunnel...
> PING ::11(::11) 56 data bytes
>
> --- ::11 ping statistics ---
> 5 packets transmitted, 3 received, 40% packet loss, time 4048ms
> rtt min/avg/max/mdev = 0.040/32.118/96.235/45.337 ms
> PING 10.1.1.200 (10.1.1.200) 56(84) bytes of data.
>
> --- 10.1.1.200 ping statistics ---
> 3 packets transmitted, 3 received, 0% packet loss, time 2026ms
> rtt min/avg/max/mdev = 0.074/0.099/0.117/0.018 ms
> PING 10.1.1.100 (10.1.1.100) 56(84) bytes of data.
>
> --- 10.1.1.100 ping statistics ---
> 3 packets transmitted, 3 received, 0% packet loss, time 2054ms
> rtt min/avg/max/mdev = 0.069/0.113/0.187/0.052 ms
> PING fc80::200(fc80::200) 56 data bytes
>
> --- fc80::200 ping statistics ---
> 3 packets transmitted, 3 received, 0% packet loss, time 2054ms
> rtt min/avg/max/mdev = 0.069/0.104/0.142/0.031 ms
> PASS: ip6gretap
> root@osboxes:~/linux-next/tools/testing/selftests/bpf#
> root@osboxes:~/linux-next/tools/testing/selftests/bpf# uname -a
> Linux osboxes 4.18.0-rc1-next-20180620 #1 SMP Tue Jun 26 12:26:00 PDT
> 2018 x86_64 x86_64 x86_64 GNU/Linux
