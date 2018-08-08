Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC25EC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51746216FD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="PBAC2y0I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sCB2sy/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51746216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbeHHEAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 00:00:05 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:58929 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725139AbeHHEAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 00:00:05 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 24E54325;
        Tue,  7 Aug 2018 21:42:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 07 Aug 2018 21:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=1kszUV1wGVGJOHuG6d2OY/WmOBLLhrCnMqGmWBDj4u0=; b=PBAC2y0I
        CTenkTi+lv+jC5bKdqBzHJ4LLuxMzKLTwt13lf934yZdRh5fUTICiIaQAjd5joMs
        J26G2JNrbTcldUgTt55ZE6iKLAwwvG9kIZn/rPJaH3B86BxGykbC7rBe5yjdigLO
        WTTvVbWn2rKr3tnE6bBbF61cdXZWZsgGbWJMkYJy0eLN2QIg+79YbOWK8n4qGP4n
        HWFr9Z/YgE3q4AIUi+ij0dJgjYKtWGkMMRiuqZQjez0vA3S23KZ4BKtif9J+nkKb
        p8PRq3ilDAUj/EEsq5RMtYIRfSRnvpWNmf7IWUcxKW880PibdKOnyQbPx7oAd2OU
        R1T7sXfzbvPNAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=1kszUV1wGVGJOHuG6d2OY/WmOBLLh
        rCnMqGmWBDj4u0=; b=sCB2sy/9a01+jzwqbI7sVu3WasxDS5m6ztf5m8Z4wwJfE
        D8abybv2bFtNb9TvcVyHZ8oMNlAa25TsyZCwhqrmXGRAZtHINDT20xiQQVfFtiBD
        WOyHS167Q2HCeUyJyhMLlY6sbpJVfVSLBmyQtFAQs9eI2BlfAaR0StwCLmwBS11M
        1RKqMlUeBswj8jk+0Cdi4BfOP6qBw6tPo9QyHdglYDZd4JvOnSQPmi7sHzzDnqrr
        tqyafuFvs6GjW6Bp67318ohaEzI7upcMc5MfN5Z3/5PGw6dRRgkXcpWyMEmh2f7x
        OHT80SAi+tQx9ndX8T8MQ2DIYlwc98PuW4o5LueFQ==
X-ME-Proxy: <xmx:m0pqWwpxSLIUJ6uydmj-UDdmDWPrUvDSEvFtym8DWvOh9DEm-a-o1Q>
    <xmx:m0pqW20T6BNOcokziz9iysOy8_ST3kMsz7pgxWH_eMP_GHo_AiMXeQ>
    <xmx:m0pqW3B8mpGhfsVQ0QsO7kwIaCKZOrw-GO8t1zkz00Aj2OGyAuA7mw>
    <xmx:m0pqW2cZmos3fXnr72eyGbxOU5rALGu05SaIr51U0xriAFHz4XSPwg>
    <xmx:m0pqW0hG-z0WtQ6Meq0J-lZTdETXdfYndeUWA68w9lqj1KjOaSQseg>
    <xmx:nEpqW0xul-VhxUKpzTB7QDgcogMu2og1lR59p5a54_DkMzwX6CdYfg>
X-ME-Sender: <xms:m0pqW9WC-lGYPDIgO_xD2g-vd5HkB2RAl8xSsghIB8vAxm9ROJ_taw>
Received: from localhost (ppp121-44-251-7.bras2.syd2.internode.on.net [121.44.251.7])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2920BE4563;
        Tue,  7 Aug 2018 21:42:50 -0400 (EDT)
Date:   Wed, 8 Aug 2018 11:42:48 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 12/13] docs: net: Fix various minor typos
Message-ID: <20180808014248.GF11191@eros>
References: <20180801050908.29970-1-me@tobin.cc>
 <20180801050908.29970-13-me@tobin.cc>
 <76cf11bc-61b3-8068-5546-79d3ff3a58e9@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76cf11bc-61b3-8068-5546-79d3ff3a58e9@iogearbox.net>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 10:41:12AM +0200, Daniel Borkmann wrote:
> On 08/01/2018 07:09 AM, Tobin C. Harding wrote:
> > There are a few minor typos and grammatical issues.  We should however
> > try to keep the current flavour of the document.
> > 
> > Fix typos and grammar if glaringly required.
> > 
> > Signed-off-by: Tobin C. Harding <me@tobin.cc>
> 
> Overall looks good, just some minor nits:
> 
> >  Documentation/networking/filter.rst | 65 +++++++++++++++--------------
> >  1 file changed, 33 insertions(+), 32 deletions(-)
> > 
> > diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
> > index 99dfa74fc4f7..b989a6c882b8 100644
> > --- a/Documentation/networking/filter.rst
> > +++ b/Documentation/networking/filter.rst
> > @@ -32,10 +32,10 @@ removing the old one and placing your new one in its place, assuming your
> >  filter has passed the checks, otherwise if it fails the old filter will
> >  remain on that socket.
> >  
> > -SO_LOCK_FILTER option allows to lock the filter attached to a socket. Once
> > -set, a filter cannot be removed or changed. This allows one process to
> > +SO_LOCK_FILTER option allows locking of the filter attached to a socket.
> > +Once set, a filter cannot be removed or changed. This allows one process to
> >  setup a socket, attach a filter, lock it then drop privileges and be
> > -assured that the filter will be kept until the socket is closed.
> > +assured  that the filter will be kept until the socket is closed.
> 
>           ^-- looks like extra whitespace slipped in?
> 
> >  The biggest user of this construct might be libpcap. Issuing a high-level
> >  filter command like ``tcpdump -i em1 port 22`` passes through the libpcap
> > @@ -470,7 +470,7 @@ JIT compiler
> >  ============
> >  
> >  The Linux kernel has a built-in BPF JIT compiler for x86_64, SPARC, PowerPC,
> > -ARM, ARM64, MIPS and s390 and can be enabled through CONFIG_BPF_JIT. The JIT
> > +ARM, ARM64, MIPS and s390 which can be enabled through CONFIG_BPF_JIT. The JIT
> >  compiler is transparently invoked for each attached filter from user space
> >  or for internal kernel users if it has been previously enabled by root::
> >  
> > @@ -580,7 +580,7 @@ Internally, for the kernel interpreter, a different instruction set
> >  format with similar underlying principles from BPF described in previous
> >  paragraphs is being used. However, the instruction set format is modelled
> >  closer to the underlying architecture to mimic native instruction sets, so
> > -that a better performance can be achieved (more details later). This new
> > +that better performance can be achieved (more details later). This new
> >  ISA is called 'eBPF' or 'internal BPF' interchangeably. (Note: eBPF which
> >  originates from [e]xtended BPF is not the same as BPF extensions! While
> >  eBPF is an ISA, BPF extensions date back to classic BPF's 'overloading'
> > @@ -655,12 +655,12 @@ Some core changes of the new internal format:
> >  
> >    32-bit architectures run 64-bit internal BPF programs via interpreter.
> >    Their JITs may convert BPF programs that only use 32-bit subregisters into
> > -  native instruction set and let the rest being interpreted.
> > +  native instruction set and let the rest be interpreted.
> >  
> > -  Operation is 64-bit, because on 64-bit architectures, pointers are also
> > -  64-bit wide, and we want to pass 64-bit values in/out of kernel functions,
> > -  so 32-bit eBPF registers would otherwise require to define register-pair
> > -  ABI, thus, there won't be able to use a direct eBPF register to HW register
> > +  Operation is 64-bit since on 64-bit architectures pointers are also
> > +  64-bit wide and we want to pass 64-bit values in/out of kernel functions.
> > +  32-bit eBPF registers would otherwise require us to define a register-pair
> > +  ABI, thus we would not be able to use a direct eBPF register to HW register
> >    mapping and JIT would need to do combine/split/move operations for every
> >    register in and out of the function, which is complex, bug prone and slow.
> >    Another reason is the use of atomic 64-bit counters.
> > @@ -694,7 +694,7 @@ Some core changes of the new internal format:
> >    situations without performance penalty.
> >  
> >    After an in-kernel function call, R1 - R5 are reset to unreadable and R0 has
> > -  a return value of the function. Since R6 - R9 are callee saved, their state
> > +  the return value of the function. Since R6 - R9 are callee saved, their state
> >    is preserved across the call.
> >  
> >    For example, consider three C functions::
> > @@ -732,7 +732,7 @@ Some core changes of the new internal format:
> >    are currently not supported, but these restrictions can be lifted if necessary
> >    in the future.
> >  
> > -  On 64-bit architectures all register map to HW registers one to one. For
> > +  On 64-bit architectures all registers map to HW registers one to one. For
> >    example, x86_64 JIT compiler can map them as ... ::
> >  
> >      R0 - rax
> > @@ -831,9 +831,10 @@ A program, that is translated internally consists of the following elements::
> >  
> >    op:16, jt:8, jf:8, k:32    ==>    op:8, dst_reg:4, src_reg:4, off:16, imm:32
> >  
> > -So far 87 internal BPF instructions were implemented. 8-bit ``op`` opcode field
> > -has room for new instructions. Some of them may use 16/24/32 byte encoding. New
> > -instructions must be multiple of 8 bytes to preserve backward compatibility.
> > +So far 87 internal BPF instructions have been implemented. 8-bit ``op``
> > +opcode field has room for new instructions. Some of them may use 16/24/32
> > +byte encoding. New instructions must be a multiple of 8 bytes to preserve
> > +backward compatibility.
> >  
> >  Internal BPF is a general purpose RISC instruction set. Not every register and
> >  every instruction are used during translation from original BPF to new format.
> > @@ -844,11 +845,11 @@ out of registers and would have to resort to spill/fill to stack.
> >  
> >  Internal BPF can used as generic assembler for last step performance
> >  optimizations, socket filters and seccomp are using it as assembler. Tracing
> > -filters may use it as assembler to generate code from kernel. In kernel usage
> > +filters may use it as assembler to generate code from kernel.  In-kernel usage
> 
>                                                                 ^-- ditto

Hi Daniel,

Thanks for doing such a careful review that you noticed this.  I'm
working on this more ATM and I've moved the document to use double
spaces between _all_ full stops.  Currently the document uses mostly
single spaces but there are some sections with double space.  The
internet tells me this is a 'style' issue not a rule.  And I've seen
single and double spacing in tree and do not know if one is favoured.

Do you care?  If you do not care I'll just use double spaces.  If you do
care and would prefer me to uniformly use a single space I can do that
also.  Oh, and FTR filter.txt looks like its going into userspace-api/
so you may care even less with that move.

If this is overly pedantic just tell me to go away :)

thanks,
Tobin.
