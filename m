Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 65824C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A2E208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L12WDKaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A2E208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755891AbeFOGlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 02:41:36 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46391 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755791AbeFOGle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 02:41:34 -0400
Received: by mail-pl0-f67.google.com with SMTP id 30-v6so4845558pld.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 23:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kINFvtbYhvRo7ZG+TInj4RcBpRlYq36aTGUItnSHczw=;
        b=L12WDKaA6Fl+lEQvGwektouLbIIOdH9xIePtSNbWTsJNuMMnnY4Q9Wa/UGMWTxdZIf
         2J52TdQ6pCOzRKUlagAIXf4VaaAOCDRzWR4aSqDxMWqgy38zQMLf+spCR8ALQpSj1rAI
         08gsibgmFc1wWyedCYpUcSngoyIXuM2j7schI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kINFvtbYhvRo7ZG+TInj4RcBpRlYq36aTGUItnSHczw=;
        b=o1MrUEJDpURJau1iZKL3w+XZwxK8407NJNkL1JD5xVRcRBuI9HizvqHzLJx5YcKmDX
         u35X8Om3kAIVFChZ7vlhBEr966MVTGfio1crIHtsyJ7XqqX8YDFKX7kEkPq19HQFA2a/
         xUucjfPIzjiD1C7YgyhoCY58hFeY3QTkmLS0lLCmmTL1OQKLt34nHjXNJhz0pAbjFBOX
         RLl5DTGIpvC9jdVR3jQNE7NwTuBHPOlc8CIqMpB4JlDi8u/qW0c/kOLt4vn+4338qXHU
         yLAL78YE/9CZ1n8C9Dvh1cyXevMb5XaYyaCxhFquMqkIJpIs7De6TespSeQbKLSZU7wf
         AY+A==
X-Gm-Message-State: APt69E2E9SEImVdvSB3Of/ht9kUXscD/bR0mOE1s8vE3gpJuxZ/SFFPK
        RjGdcmOXIV3/Ry8NF5j6gxgyN6WD+IVScsJ4NdxidQ==
X-Google-Smtp-Source: ADUXVKJ/tzGYBDozMpjsqXMJssVROmQwMXkphs0V4pr4xGmS1LhY+hF6SuAQICxpVUc4LLauFsIUEfBH4HLYabzsnDg=
X-Received: by 2002:a17:902:ba87:: with SMTP id k7-v6mr498171pls.271.1529044893452;
 Thu, 14 Jun 2018 23:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180612110510.11731-1-anders.roxell@linaro.org>
 <d6851756-ae3b-09ec-f487-1eeece6bd4c6@iogearbox.net> <CALDO+SY3qNYAOSiYC3645C7YY9LSx7ggg0GjY76m4TbBfF_t3A@mail.gmail.com>
 <CADYN=9+3V4fpqbjh-X4VUVWd_X38XSYhEbZoRBffcx=-nMtF8g@mail.gmail.com> <CALDO+SZXvnUU7VKd_UwnBCU0NiTHjqei4xEUCdcktkKCD3MnEg@mail.gmail.com>
In-Reply-To: <CALDO+SZXvnUU7VKd_UwnBCU0NiTHjqei4xEUCdcktkKCD3MnEg@mail.gmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Fri, 15 Jun 2018 08:41:22 +0200
Message-ID: <CADYN=9KegM2wNCX7=BDct16bzzmr-02aG1c3MLDEEon1yGXnzQ@mail.gmail.com>
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

On Thu, 14 Jun 2018 at 14:09, William Tu <u9012063@gmail.com> wrote:
>
> On Thu, Jun 14, 2018 at 4:42 AM, Anders Roxell <anders.roxell@linaro.org> wrote:
> > On 14 June 2018 at 13:06, William Tu <u9012063@gmail.com> wrote:
> >> On Tue, Jun 12, 2018 at 5:08 PM, Daniel Borkmann <daniel@iogearbox.net> wrote:
> >>> On 06/12/2018 01:05 PM, Anders Roxell wrote:
> >>>> Tests test_tunnel.sh fails due to config fragments ins't enabled.
> >>>>
> >>>> Fixes: 933a741e3b82 ("selftests/bpf: bpf tunnel test.")
> >>>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> >>>> ---
> >>>>
> >>>> All tests passes except ip6gretap that still fails. I'm unsure why.
> >>>> Ideas?
> >>
> >> Hi Anders,
> >>
> >> ip6erspan is based on ip6gretap, does ip6erspan pass?
> >
> > it did pass  when I was sending the email.
> > However, I retested this on next-20180613 and now it fails.
> >
> Does 'ip -s link show' show any errors/dropped on ip6gretap device?

I rerun the test_ip6gretap test only and added "set -x" to
test_tunnel.sh here's the output.
I added "ip -s link show ip6gretap11" before the cleanup function in the script.

# ./test_tunnel.sh
+ PING_ARG='-c 3 -w 10 -q'
+ ret=0
+ GREEN='\033[0;92m'
+ RED='\033[0;31m'
+ NC='\033[0m'
+ trap cleanup 0 3 6
+ trap cleanup_exit 2 9
+ cleanup
+ ip netns delete at_ns0
+ ip link del veth1
+ ip link del ipip11
+ ip link del ipip6tnl11
+ ip link del gretap11
+ ip link del ip6gre11
+ ip link del ip6gretap11
+ ip link del vxlan11
+ ip link del ip6vxlan11
+ ip link del geneve11
+ ip link del ip6geneve11
+ ip link del erspan11
+ ip link del ip6erspan11
+ bpf_tunnel_test
+ echo 'Testing IP6GRETAP tunnel...'
Testing IP6GRETAP tunnel...
+ test_ip6gretap
+ TYPE=ip6gretap
+ DEV_NS=ip6gretap00
+ DEV=ip6gretap11
+ ret=0
+ check ip6gretap
+ ip link help ip6gretap
+ grep -q '^Usage:'
+ '[' 0 -ne 0 ']'
+ config_device
+ ip netns add at_ns0
+ ip link add veth0 type veth peer name veth1
+ ip link set veth0 netns at_ns0
+ ip netns exec at_ns0 ip addr add 172.16.1.100/24 dev veth0
+ ip netns exec at_ns0 ip link set dev veth0 up
+ ip link set dev veth1 up mtu 1500
+ ip addr add dev veth1 172.16.1.200/24
+ add_ip6gretap_tunnel
+ ip netns exec at_ns0 ip addr add ::11/96 dev veth0
+ ip netns exec at_ns0 ip link set dev veth0 up
+ ip addr add dev veth1 ::22/96
+ ip link set dev veth1 up
+ ip netns exec at_ns0 ip link add dev ip6gretap00 type ip6gretap seq
flowlabel 0xbcdef key 2 local ::11 remote ::22
+ ip netns exec at_ns0 ip addr add dev ip6gretap00 10.1.1.100/24
+ ip netns exec at_ns0 ip addr add dev ip6gretap00 fc80::100/96
+ ip netns exec at_ns0 ip link set dev ip6gretap00 up
+ ip link add dev ip6gretap11 type ip6gretap external
+ ip addr add dev ip6gretap11 10.1.1.200/24
+ ip addr add dev ip6gretap11 fc80::200/24
+ ip link set dev ip6gretap11 up
+ attach_bpf ip6gretap11 ip6gretap_set_tunnel ip6gretap_get_tunnel
+ DEV=ip6gretap11
+ SET=ip6gretap_set_tunnel
+ GET=ip6gretap_get_tunnel
+ tc qdisc add dev ip6gretap11 clsact
+ tc filter add dev ip6gretap11 egress bpf da obj test_tunnel_kern.o
sec ip6gretap_set_tunnel
+ tc filter add dev ip6gretap11 ingress bpf da obj test_tunnel_kern.o
sec ip6gretap_get_tunnel
+ ping6 -c 3 -w 10 -q ::11
PING ::11 (::11): 56 data bytes

--- ::11 ping statistics ---
5 packets transmitted, 3 packets received, 40% packet loss
round-trip min/avg/max = 0.139/1.857/5.293 ms
+ ip netns exec at_ns0 ping -c 3 -w 10 -q 10.1.1.200
PING 10.1.1.200 (10.1.1.200): 56 data bytes

--- 10.1.1.200 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 0.214/0.256/0.305 ms
+ ping -c 3 -w 10 -q 10.1.1.100
PING 10.1.1.100 (10.1.1.100): 56 data bytes

--- 10.1.1.100 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 0.210/0.211/0.213 ms
+ check_err 0
+ '[' 0 -eq 0 ']'
+ ret=0
+ ip netns exec at_ns0 ping6 -c 3 -w 10 -q fc80::200
PING fc80::200 (fc80::200): 56 data bytes

--- fc80::200 ping statistics ---
10 packets transmitted, 0 packets received, 100% packet loss
+ check_err 1
+ '[' 0 -eq 0 ']'
+ ret=1
+ ip -s link show ip6gretap11
19: ip6gretap11@NONE: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1434 qdisc
pfifo_fast state UNKNOWN mode DEFAULT group default qlen 1000
    link/ether de:d2:0c:53:80:8c brd ff:ff:ff:ff:ff:ff
    RX: bytes  packets  errors  dropped overrun mcast
    2096       25       0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    5324       36       5       5       0       0
+ cleanup
+ ip netns delete at_ns0
+ ip link del veth1
+ ip link del ipip11
+ ip link del ipip6tnl11
+ ip link del gretap11
+ ip link del ip6gre11
+ ip link del ip6gretap11
+ ip link del vxlan11
+ ip link del ip6vxlan11
+ ip link del geneve11
+ ip link del ip6geneve11
+ ip link del erspan11
+ ip link del ip6erspan11
+ '[' 1 -ne 0 ']'
+ echo -e '\033[0;31mFAIL: ip6gretap\033[0m'
FAIL: ip6gretap
+ return 1
+ exit 0
+ cleanup
+ ip netns delete at_ns0
+ ip link del veth1
+ ip link del ipip11
+ ip link del ipip6tnl11
+ ip link del gretap11
+ ip link del ip6gre11
+ ip link del ip6gretap11
+ ip link del vxlan11
+ ip link del ip6vxlan11
+ ip link del geneve11
+ ip link del ip6geneve11
+ ip link del erspan11
+ ip link del ip6erspan11
