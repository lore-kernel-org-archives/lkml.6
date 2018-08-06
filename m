Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF52C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 00:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9932198F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 00:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="Z28EnD+P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="njzc4GM4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9932198F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbeHFC24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 22:28:56 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:44251 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726870AbeHFC24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 22:28:56 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 3E66A1D0;
        Sun,  5 Aug 2018 20:22:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 05 Aug 2018 20:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=w3BPqUpyYCxLfiWci77kaDfKc6lvfuB5b8Zjvpj9Fu0=; b=Z28EnD+P
        u07/tVlggSkRxvDTIqWLBZd8BQa6zNu8/CKLO80GmHGZ45ve2ovGNOpMsF/f7SMF
        h75xoYXZGLrgqtAO3kv2d7uz6mJqlwv3QI+0wsmaZePVaf0u5iAF1EyHReLvSx6y
        zb5G+KNSP3kIOt6Nr0YIFvfl/vgY2qlNF9ox0O/NY0hH46POa9ZO2za4PdXGbwv5
        YsMFjO92LxmZcqZAloDqrsfLK9v/ij1YGu+ULVy9EMPxrWtBJYU/T4LYcTebr2Vz
        Ee67t9e5LeiAkX+ZTezWWNt9+go7jxKogrXi+r1ADWg6XceoiHH7a6yYEKqJrEw4
        w4Mry4Nghx4XHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=w3BPqUpyYCxLfiWci77kaDfKc6lvf
        uB5b8Zjvpj9Fu0=; b=njzc4GM4FRmz7+3tokhNuje0/wwkNX/ydTijH41orxtHH
        W6ehFBNrSm+X+I2F1vo8sKulFsR+2GZ5Bb/j2kW0pUorMvih4W+OjaMj/MtxiQ5T
        rmwXqzL0H1dWcGIIMJSLw7BY5WglZetvuzR1LBcHJdMd0o77FkZHEeawSgQB8Wx3
        c5i+yeuotT9OagMfRZ7vnOyv8SXCuwZMbnZQjoQVk/edYCQl1+6mSobUkcR1JZxB
        9M2EXQ9TVSvWqupCYT7BgNkqII+8U+F8r/gwcwyXCBbIkl4sSV0f4XGt/2OHvinb
        W9vaEVuKGaRTqfE8lyWq56ciMVp2lwuS2+0AnP9+g==
X-ME-Proxy: <xmx:wJRnW48rMbr2wVJN8oMoV6iuhCGRix-5enHCScMgfmypMFr-A7v-fw>
    <xmx:wJRnW35LwWCZtofa3YL5HY2NRSHZ0zLLZ54zi5BHalmGnu42sw48Cg>
    <xmx:wJRnWyZPp2AQykSIxkZYJTU01qViaHHpSqsG6kwKWOaJ_VO522DRjQ>
    <xmx:wJRnWxJB433clD6Yh0Ux_xv2k5pt3UEvIG1C4sbOcKFeo5cwSpr1pA>
    <xmx:wJRnW1hg_14t4nPtGCmfM2eGpsEDnl1tjJ3z0xX2ApIvZ2I_y-DoqA>
    <xmx:wJRnWyD1GHdEfKf1sm6ixy2tfAl7j2XQvqDAKCs6D37wNbYxfGRNBA>
X-ME-Sender: <xms:wJRnW6ZRD-JZBiu4uwt_InBZWCe5hwNERuFWxSopm6yxLfIUkDdeyg>
Received: from localhost (ppp121-44-251-7.bras2.syd2.internode.on.net [121.44.251.7])
        by mail.messagingengine.com (Postfix) with ESMTPA id CCAEDE4636;
        Sun,  5 Aug 2018 20:22:23 -0400 (EDT)
Date:   Mon, 6 Aug 2018 10:22:20 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 05/13] docs: net: Fix indentation issues for
 code snippets
Message-ID: <20180806002220.GJ3088@eros>
References: <20180801050908.29970-1-me@tobin.cc>
 <20180801050908.29970-6-me@tobin.cc>
 <8d166300-78f3-db60-c097-4f7c587856f4@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d166300-78f3-db60-c097-4f7c587856f4@iogearbox.net>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 10:44:23AM +0200, Daniel Borkmann wrote:
> On 08/01/2018 07:09 AM, Tobin C. Harding wrote:
> [...]
> > -Starting bpf_dbg is trivial and just requires issuing:
> > +Starting bpf_dbg is trivial and just requires issuing::
> >  
> > -# ./bpf_dbg
> > +  # ./bpf_dbg
> >  
> >  In case input and output do not equal stdin/stdout, bpf_dbg takes an
> >  alternative stdin source as a first argument, and an alternative stdout
> > @@ -381,86 +384,87 @@ file "~/.bpf_dbg_init" and the command history is stored in the file
> >  Interaction in bpf_dbg happens through a shell that also has auto-completion
> >  support (follow-up example commands starting with '>' denote bpf_dbg shell).
> >  The usual workflow would be to ...
> > -
> > -> load bpf 6,40 0 0 12,21 0 3 2048,48 0 0 23,21 0 1 1,6 0 0 65535,6 0 0 0
> > -  Loads a BPF filter from standard output of bpf_asm, or transformed via
> > -  e.g. `tcpdump -iem1 -ddd port 22 | tr '\n' ','`. Note that for JIT
> > -  debugging (next section), this command creates a temporary socket and
> > -  loads the BPF code into the kernel. Thus, this will also be useful for
> > -  JIT developers.
> > -
> > -> load pcap foo.pcap
> > -  Loads standard tcpdump pcap file.
> > -
> > -> run [<n>]
> > -bpf passes:1 fails:9
> > -  Runs through all packets from a pcap to account how many passes and fails
> > -  the filter will generate. A limit of packets to traverse can be given.
> > -
> > -> disassemble
> > -l0:	ldh [12]
> > -l1:	jeq #0x800, l2, l5
> > -l2:	ldb [23]
> > -l3:	jeq #0x1, l4, l5
> > -l4:	ret #0xffff
> > -l5:	ret #0
> > -  Prints out BPF code disassembly.
> > -
> > -> dump
> > -/* { op, jt, jf, k }, */
> > -{ 0x28,  0,  0, 0x0000000c },
> > -{ 0x15,  0,  3, 0x00000800 },
> > -{ 0x30,  0,  0, 0x00000017 },
> > -{ 0x15,  0,  1, 0x00000001 },
> > -{ 0x06,  0,  0, 0x0000ffff },
> > -{ 0x06,  0,  0, 0000000000 },
> > -  Prints out C-style BPF code dump.
> > -
> > -> breakpoint 0
> > -breakpoint at: l0:	ldh [12]
> > -> breakpoint 1
> > -breakpoint at: l1:	jeq #0x800, l2, l5
> > -  ...
> > -  Sets breakpoints at particular BPF instructions. Issuing a `run` command
> > -  will walk through the pcap file continuing from the current packet and
> > -  break when a breakpoint is being hit (another `run` will continue from
> > -  the currently active breakpoint executing next instructions):
> > -
> > -  > run
> > -  -- register dump --
> > -  pc:       [0]                       <-- program counter
> > -  code:     [40] jt[0] jf[0] k[12]    <-- plain BPF code of current instruction
> > -  curr:     l0:	ldh [12]              <-- disassembly of current instruction
> > -  A:        [00000000][0]             <-- content of A (hex, decimal)
> > -  X:        [00000000][0]             <-- content of X (hex, decimal)
> > -  M[0,15]:  [00000000][0]             <-- folded content of M (hex, decimal)
> > -  -- packet dump --                   <-- Current packet from pcap (hex)
> > -  len: 42
> > -    0: 00 19 cb 55 55 a4 00 14 a4 43 78 69 08 06 00 01
> > -   16: 08 00 06 04 00 01 00 14 a4 43 78 69 0a 3b 01 26
> > -   32: 00 00 00 00 00 00 0a 3b 01 01
> > -  (breakpoint)
> > -  >
> > -
> > -> breakpoint
> > -breakpoints: 0 1
> > -  Prints currently set breakpoints.
> > -
> > -> step [-<n>, +<n>]
> > -  Performs single stepping through the BPF program from the current pc
> > -  offset. Thus, on each step invocation, above register dump is issued.
> > -  This can go forwards and backwards in time, a plain `step` will break
> > -  on the next BPF instruction, thus +1. (No `run` needs to be issued here.)
> > -
> > -> select <n>
> > -  Selects a given packet from the pcap file to continue from. Thus, on
> > -  the next `run` or `step`, the BPF program is being evaluated against
> > -  the user pre-selected packet. Numbering starts just as in Wireshark
> > -  with index 1.
> > -
> > -> quit
> > -#
> > -  Exits bpf_dbg.
> > +::
> > +
> > +  > load bpf 6,40 0 0 12,21 0 3 2048,48 0 0 23,21 0 1 1,6 0 0 65535,6 0 0 0
> > +    Loads a BPF filter from standard output of bpf_asm, or transformed via
> > +    e.g. `tcpdump -iem1 -ddd port 22 | tr '\n' ','`. Note that for JIT
> > +    debugging (next section), this command creates a temporary socket and
> > +    loads the BPF code into the kernel. Thus, this will also be useful for
> > +    JIT developers.
> 
> Here for the bpf_dbg howto, it would be good to separate explanation from
> the cmdline code snippets. This would more easily clarify the commands
> themselves if we already go the rst route, so I'd prefer splitting this up.

Sure thing.  Will do as suggested. Thanks for the review.


	Tobin
