Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8392CC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A8C20874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fj5874Ex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A8C20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938003AbeFSM45 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:56:57 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34608 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937770AbeFSM4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:56:52 -0400
Received: by mail-qk0-f194.google.com with SMTP id q70-v6so11267534qke.1;
        Tue, 19 Jun 2018 05:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XoxrUacn2pppdp5q/J+79P5xzJo9E1IGirns39fjvhk=;
        b=Fj5874ExHyOqWCqUUjAlXUJ+qlP+IJhoI5JQ6gc9EOm8hsZXyanrNdfC0RRcNjDyYT
         UJ8zNZlJia6H2d8zv8nQUzpu8jZ9AsYDL/5GWYV+mO69hJdvcMQ7gfFcuqVZO5K5ZPDg
         +j93E94xAs7sMbq0mPXEfVYv7A5i/OCYqaDUFCA/+efWJnFGWFlISosP+onboA71BQLA
         rUqNY75LURj1M2XInAUtiqcM6bDNKW+D0a92YvD0GN3Kx+o9NE4ZLwHf9/8jgrcre08J
         au9npyXE3uI+xogVYZvleXPjOjSMuFXw4ydJRLx9IV5/LE/ExTJmYXDQDekYrdWihN8n
         kw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XoxrUacn2pppdp5q/J+79P5xzJo9E1IGirns39fjvhk=;
        b=Qx1bv7u/NnlaJ1C69qmZugKN9t5xcW8yYXSjyufGi0DbGEabaSVjPxDFOVW7bVSYur
         4LVxvV5M/rcVZMaGhEexWzHMmBTItZpoA+R6E3+USZUUcnmWsBZvEDA/UbiT6uczWMnM
         TpBbtEwgzRwrBJtAiHH/mNCC3d5xuOjtrL3xyDCzcr4jxA2bZ3hLJTbcGblLYjW/9gBR
         8Fzh2CRxSND2x78i2T3RtHJGNXydfYPhMuqwBPzzJIrPzbacTP2qE0xarNGAGNDkBBEk
         QSxgsXzfv8t87yetVm0XmnXy5Nv/dGTMkMn4y7MIgbS+7/kkRXShPVh5j0vLKj+1VYOs
         wBhA==
X-Gm-Message-State: APt69E1GA85phs3tgfDPss+vTrOGe0mX9CejVKGEgiVG/q7VfKo5mcq8
        Z4CwtlSn29QUETBSPD8CXD2RfQc7P4jNHux5WD5nHdFt
X-Google-Smtp-Source: ADUXVKLts1syGUOZ1b2l8RDwHiqBMxituiKLuS37LJk3qHKWDFb3M1D2sbgUUB4CqKqvgxuxrtQIumRz/AhxvFCo8EQ=
X-Received: by 2002:a37:db0a:: with SMTP id e10-v6mr13500415qki.136.1529413011004;
 Tue, 19 Jun 2018 05:56:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:22b2:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 05:56:10
 -0700 (PDT)
In-Reply-To: <CADYN=9KegM2wNCX7=BDct16bzzmr-02aG1c3MLDEEon1yGXnzQ@mail.gmail.com>
References: <20180612110510.11731-1-anders.roxell@linaro.org>
 <d6851756-ae3b-09ec-f487-1eeece6bd4c6@iogearbox.net> <CALDO+SY3qNYAOSiYC3645C7YY9LSx7ggg0GjY76m4TbBfF_t3A@mail.gmail.com>
 <CADYN=9+3V4fpqbjh-X4VUVWd_X38XSYhEbZoRBffcx=-nMtF8g@mail.gmail.com>
 <CALDO+SZXvnUU7VKd_UwnBCU0NiTHjqei4xEUCdcktkKCD3MnEg@mail.gmail.com> <CADYN=9KegM2wNCX7=BDct16bzzmr-02aG1c3MLDEEon1yGXnzQ@mail.gmail.com>
From:   William Tu <u9012063@gmail.com>
Date:   Tue, 19 Jun 2018 05:56:10 -0700
Message-ID: <CALDO+SY2eE6DHtVmfnUpMjTjHe3shfzae48nk_OehfUyuKNYsg@mail.gmail.com>
Subject: Re: [PATCH] selftests: bpf: config: add config fragments
To:     Anders Roxell <anders.roxell@linaro.org>
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

On Thu, Jun 14, 2018 at 11:41 PM, Anders Roxell
<anders.roxell@linaro.org> wrote:
> On Thu, 14 Jun 2018 at 14:09, William Tu <u9012063@gmail.com> wrote:
>>
>> On Thu, Jun 14, 2018 at 4:42 AM, Anders Roxell <anders.roxell@linaro.org> wrote:
>> > On 14 June 2018 at 13:06, William Tu <u9012063@gmail.com> wrote:
>> >> On Tue, Jun 12, 2018 at 5:08 PM, Daniel Borkmann <daniel@iogearbox.net> wrote:
>> >>> On 06/12/2018 01:05 PM, Anders Roxell wrote:
>> >>>> Tests test_tunnel.sh fails due to config fragments ins't enabled.
>> >>>>
>> >>>> Fixes: 933a741e3b82 ("selftests/bpf: bpf tunnel test.")
>> >>>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>> >>>> ---
>> >>>>
>> >>>> All tests passes except ip6gretap that still fails. I'm unsure why.
>> >>>> Ideas?
>> >>
>> >> Hi Anders,
>> >>
>> >> ip6erspan is based on ip6gretap, does ip6erspan pass?
>> >
>> > it did pass  when I was sending the email.
>> > However, I retested this on next-20180613 and now it fails.
>> >
>> Does 'ip -s link show' show any errors/dropped on ip6gretap device?
>
> I rerun the test_ip6gretap test only and added "set -x" to
> test_tunnel.sh here's the output.
> I added "ip -s link show ip6gretap11" before the cleanup function in the script.
>
> # ./test_tunnel.sh
> + PING_ARG='-c 3 -w 10 -q'
> + ret=0
> + GREEN='\033[0;92m'
> + RED='\033[0;31m'
> + NC='\033[0m'
> + trap cleanup 0 3 6
> + trap cleanup_exit 2 9
> + cleanup
> + ip netns delete at_ns0
> + ip link del veth1
> + ip link del ipip11
> + ip link del ipip6tnl11
> + ip link del gretap11
> + ip link del ip6gre11
> + ip link del ip6gretap11
> + ip link del vxlan11
> + ip link del ip6vxlan11
> + ip link del geneve11
> + ip link del ip6geneve11
> + ip link del erspan11
> + ip link del ip6erspan11
> + bpf_tunnel_test
> + echo 'Testing IP6GRETAP tunnel...'
> Testing IP6GRETAP tunnel...
> + test_ip6gretap
> + TYPE=ip6gretap
> + DEV_NS=ip6gretap00
> + DEV=ip6gretap11
> + ret=0
> + check ip6gretap
> + ip link help ip6gretap
> + grep -q '^Usage:'
> + '[' 0 -ne 0 ']'
> + config_device
> + ip netns add at_ns0
> + ip link add veth0 type veth peer name veth1
> + ip link set veth0 netns at_ns0
> + ip netns exec at_ns0 ip addr add 172.16.1.100/24 dev veth0
> + ip netns exec at_ns0 ip link set dev veth0 up
> + ip link set dev veth1 up mtu 1500
> + ip addr add dev veth1 172.16.1.200/24
> + add_ip6gretap_tunnel
> + ip netns exec at_ns0 ip addr add ::11/96 dev veth0
> + ip netns exec at_ns0 ip link set dev veth0 up
> + ip addr add dev veth1 ::22/96
> + ip link set dev veth1 up
> + ip netns exec at_ns0 ip link add dev ip6gretap00 type ip6gretap seq
> flowlabel 0xbcdef key 2 local ::11 remote ::22
> + ip netns exec at_ns0 ip addr add dev ip6gretap00 10.1.1.100/24
> + ip netns exec at_ns0 ip addr add dev ip6gretap00 fc80::100/96
> + ip netns exec at_ns0 ip link set dev ip6gretap00 up
> + ip link add dev ip6gretap11 type ip6gretap external
> + ip addr add dev ip6gretap11 10.1.1.200/24
> + ip addr add dev ip6gretap11 fc80::200/24
> + ip link set dev ip6gretap11 up
> + attach_bpf ip6gretap11 ip6gretap_set_tunnel ip6gretap_get_tunnel
> + DEV=ip6gretap11
> + SET=ip6gretap_set_tunnel
> + GET=ip6gretap_get_tunnel
> + tc qdisc add dev ip6gretap11 clsact
> + tc filter add dev ip6gretap11 egress bpf da obj test_tunnel_kern.o
> sec ip6gretap_set_tunnel
> + tc filter add dev ip6gretap11 ingress bpf da obj test_tunnel_kern.o
> sec ip6gretap_get_tunnel
> + ping6 -c 3 -w 10 -q ::11
> PING ::11 (::11): 56 data bytes
>
> --- ::11 ping statistics ---
> 5 packets transmitted, 3 packets received, 40% packet loss
> round-trip min/avg/max = 0.139/1.857/5.293 ms
> + ip netns exec at_ns0 ping -c 3 -w 10 -q 10.1.1.200
> PING 10.1.1.200 (10.1.1.200): 56 data bytes
>
> --- 10.1.1.200 ping statistics ---
> 3 packets transmitted, 3 packets received, 0% packet loss
> round-trip min/avg/max = 0.214/0.256/0.305 ms
> + ping -c 3 -w 10 -q 10.1.1.100
> PING 10.1.1.100 (10.1.1.100): 56 data bytes
>
> --- 10.1.1.100 ping statistics ---
> 3 packets transmitted, 3 packets received, 0% packet loss
> round-trip min/avg/max = 0.210/0.211/0.213 ms
> + check_err 0
> + '[' 0 -eq 0 ']'
> + ret=0
> + ip netns exec at_ns0 ping6 -c 3 -w 10 -q fc80::200
> PING fc80::200 (fc80::200): 56 data bytes
>
> --- fc80::200 ping statistics ---
> 10 packets transmitted, 0 packets received, 100% packet loss
> + check_err 1
> + '[' 0 -eq 0 ']'
> + ret=1
> + ip -s link show ip6gretap11
> 19: ip6gretap11@NONE: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1434 qdisc
> pfifo_fast state UNKNOWN mode DEFAULT group default qlen 1000
>     link/ether de:d2:0c:53:80:8c brd ff:ff:ff:ff:ff:ff
>     RX: bytes  packets  errors  dropped overrun mcast
>     2096       25       0       0       0       0
>     TX: bytes  packets  errors  dropped carrier collsns
>     5324       36       5       5       0       0

So there are 5 errors at TX.
I couldn't reproduce in my local machine using 4.17-rc6.
How do I checkin the "next-20180613" source code?

Thanks
William
