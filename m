Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FC2C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119822173F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 119822173F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732270AbeHCKjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 06:39:49 -0400
Received: from www62.your-server.de ([213.133.104.62]:52053 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbeHCKjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 06:39:49 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1flVhA-00072t-CT; Fri, 03 Aug 2018 10:44:24 +0200
Received: from [2a02:120b:c3f4:b8b0:b5ea:3969:d380:aafd] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1flVhA-000Y0r-7c; Fri, 03 Aug 2018 10:44:24 +0200
Subject: Re: [PATCH bpf-next 05/13] docs: net: Fix indentation issues for code
 snippets
To:     "Tobin C. Harding" <me@tobin.cc>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180801050908.29970-1-me@tobin.cc>
 <20180801050908.29970-6-me@tobin.cc>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8d166300-78f3-db60-c097-4f7c587856f4@iogearbox.net>
Date:   Fri, 3 Aug 2018 10:44:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180801050908.29970-6-me@tobin.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24807/Fri Aug  3 02:50:20 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2018 07:09 AM, Tobin C. Harding wrote:
[...]
> -Starting bpf_dbg is trivial and just requires issuing:
> +Starting bpf_dbg is trivial and just requires issuing::
>  
> -# ./bpf_dbg
> +  # ./bpf_dbg
>  
>  In case input and output do not equal stdin/stdout, bpf_dbg takes an
>  alternative stdin source as a first argument, and an alternative stdout
> @@ -381,86 +384,87 @@ file "~/.bpf_dbg_init" and the command history is stored in the file
>  Interaction in bpf_dbg happens through a shell that also has auto-completion
>  support (follow-up example commands starting with '>' denote bpf_dbg shell).
>  The usual workflow would be to ...
> -
> -> load bpf 6,40 0 0 12,21 0 3 2048,48 0 0 23,21 0 1 1,6 0 0 65535,6 0 0 0
> -  Loads a BPF filter from standard output of bpf_asm, or transformed via
> -  e.g. `tcpdump -iem1 -ddd port 22 | tr '\n' ','`. Note that for JIT
> -  debugging (next section), this command creates a temporary socket and
> -  loads the BPF code into the kernel. Thus, this will also be useful for
> -  JIT developers.
> -
> -> load pcap foo.pcap
> -  Loads standard tcpdump pcap file.
> -
> -> run [<n>]
> -bpf passes:1 fails:9
> -  Runs through all packets from a pcap to account how many passes and fails
> -  the filter will generate. A limit of packets to traverse can be given.
> -
> -> disassemble
> -l0:	ldh [12]
> -l1:	jeq #0x800, l2, l5
> -l2:	ldb [23]
> -l3:	jeq #0x1, l4, l5
> -l4:	ret #0xffff
> -l5:	ret #0
> -  Prints out BPF code disassembly.
> -
> -> dump
> -/* { op, jt, jf, k }, */
> -{ 0x28,  0,  0, 0x0000000c },
> -{ 0x15,  0,  3, 0x00000800 },
> -{ 0x30,  0,  0, 0x00000017 },
> -{ 0x15,  0,  1, 0x00000001 },
> -{ 0x06,  0,  0, 0x0000ffff },
> -{ 0x06,  0,  0, 0000000000 },
> -  Prints out C-style BPF code dump.
> -
> -> breakpoint 0
> -breakpoint at: l0:	ldh [12]
> -> breakpoint 1
> -breakpoint at: l1:	jeq #0x800, l2, l5
> -  ...
> -  Sets breakpoints at particular BPF instructions. Issuing a `run` command
> -  will walk through the pcap file continuing from the current packet and
> -  break when a breakpoint is being hit (another `run` will continue from
> -  the currently active breakpoint executing next instructions):
> -
> -  > run
> -  -- register dump --
> -  pc:       [0]                       <-- program counter
> -  code:     [40] jt[0] jf[0] k[12]    <-- plain BPF code of current instruction
> -  curr:     l0:	ldh [12]              <-- disassembly of current instruction
> -  A:        [00000000][0]             <-- content of A (hex, decimal)
> -  X:        [00000000][0]             <-- content of X (hex, decimal)
> -  M[0,15]:  [00000000][0]             <-- folded content of M (hex, decimal)
> -  -- packet dump --                   <-- Current packet from pcap (hex)
> -  len: 42
> -    0: 00 19 cb 55 55 a4 00 14 a4 43 78 69 08 06 00 01
> -   16: 08 00 06 04 00 01 00 14 a4 43 78 69 0a 3b 01 26
> -   32: 00 00 00 00 00 00 0a 3b 01 01
> -  (breakpoint)
> -  >
> -
> -> breakpoint
> -breakpoints: 0 1
> -  Prints currently set breakpoints.
> -
> -> step [-<n>, +<n>]
> -  Performs single stepping through the BPF program from the current pc
> -  offset. Thus, on each step invocation, above register dump is issued.
> -  This can go forwards and backwards in time, a plain `step` will break
> -  on the next BPF instruction, thus +1. (No `run` needs to be issued here.)
> -
> -> select <n>
> -  Selects a given packet from the pcap file to continue from. Thus, on
> -  the next `run` or `step`, the BPF program is being evaluated against
> -  the user pre-selected packet. Numbering starts just as in Wireshark
> -  with index 1.
> -
> -> quit
> -#
> -  Exits bpf_dbg.
> +::
> +
> +  > load bpf 6,40 0 0 12,21 0 3 2048,48 0 0 23,21 0 1 1,6 0 0 65535,6 0 0 0
> +    Loads a BPF filter from standard output of bpf_asm, or transformed via
> +    e.g. `tcpdump -iem1 -ddd port 22 | tr '\n' ','`. Note that for JIT
> +    debugging (next section), this command creates a temporary socket and
> +    loads the BPF code into the kernel. Thus, this will also be useful for
> +    JIT developers.

Here for the bpf_dbg howto, it would be good to separate explanation from
the cmdline code snippets. This would more easily clarify the commands
themselves if we already go the rst route, so I'd prefer splitting this up.

> +  > load pcap foo.pcap
> +    Loads standard tcpdump pcap file.
> +
> +  > run [<n>]
> +  bpf passes:1 fails:9
> +    Runs through all packets from a pcap to account how many passes and fails
> +    the filter will generate. A limit of packets to traverse can be given.
> +
> +  > disassemble
> +  l0:	ldh [12]
> +  l1:	jeq #0x800, l2, l5
> +  l2:	ldb [23]
> +  l3:	jeq #0x1, l4, l5
> +  l4:	ret #0xffff
> +  l5:	ret #0
> +    Prints out BPF code disassembly.
> +
> +  > dump
> +  /* { op, jt, jf, k }, */
> +  { 0x28,  0,  0, 0x0000000c },
> +  { 0x15,  0,  3, 0x00000800 },
> +  { 0x30,  0,  0, 0x00000017 },
> +  { 0x15,  0,  1, 0x00000001 },
> +  { 0x06,  0,  0, 0x0000ffff },
> +  { 0x06,  0,  0, 0000000000 },
> +    Prints out C-style BPF code dump.
> +
> +  > breakpoint 0
> +  breakpoint at: l0:	ldh [12]
> +  > breakpoint 1
> +  breakpoint at: l1:	jeq #0x800, l2, l5
> +    ...
> +    Sets breakpoints at particular BPF instructions. Issuing a `run` command
> +    will walk through the pcap file continuing from the current packet and
> +    break when a breakpoint is being hit (another `run` will continue from
> +    the currently active breakpoint executing next instructions):
> +
> +    > run
> +    -- register dump --
> +    pc:       [0]                       <-- program counter
> +    code:     [40] jt[0] jf[0] k[12]    <-- plain BPF code of current instruction
> +    curr:     l0:ldh [12]               <-- disassembly of current instruction
> +    A:        [00000000][0]             <-- content of A (hex, decimal)
> +    X:        [00000000][0]             <-- content of X (hex, decimal)
> +    M[0,15]:  [00000000][0]             <-- folded content of M (hex, decimal)
> +    -- packet dump --                   <-- Current packet from pcap (hex)
> +    len: 42
> +      0: 00 19 cb 55 55 a4 00 14 a4 43 78 69 08 06 00 01
> +     16: 08 00 06 04 00 01 00 14 a4 43 78 69 0a 3b 01 26
> +     32: 00 00 00 00 00 00 0a 3b 01 01
> +    (breakpoint)
> +    >
> +
> +  > breakpoint
> +  breakpoints: 0 1
> +    Prints currently set breakpoints.
> +
> +  > step [-<n>, +<n>]
> +    Performs single stepping through the BPF program from the current pc
> +    offset. Thus, on each step invocation, above register dump is issued.
> +    This can go forwards and backwards in time, a plain `step` will break
> +    on the next BPF instruction, thus +1. (No `run` needs to be issued here.)
> +
> +  > select <n>
> +    Selects a given packet from the pcap file to continue from. Thus, on
> +    the next `run` or `step`, the BPF program is being evaluated against
> +    the user pre-selected packet. Numbering starts just as in Wireshark
> +    with index 1.
> +
> +  > quit
> +  #
> +    Exits bpf_dbg.
>  
