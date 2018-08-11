Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D7EC46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 11:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3647921B32
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 11:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="iqyIXfXI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q1iPsPuM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3647921B32
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbeHKOZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 10:25:01 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35167 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727268AbeHKOZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 10:25:01 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0C83B21C1C;
        Sat, 11 Aug 2018 07:51:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 11 Aug 2018 07:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=XEV+7wC3qJf+gLzl6yzAmemuAs4SGw4ZCN1ouq8y5Sc=; b=iqyIXfXI
        m61W/aD/va5eQeBSo5Cr7NrHE7VOqZsDOrCgty93jp4M7dkDz13kksBSFT9PF0t4
        A+3EiWKZJmBmLIG3nvasc0GGw2Fvl+9uH1FQk09uDE66hPsr2dAN9a//EuLVBrT/
        G4NoSUpcAM4GJMfylZm7RYkjbwSRCNBYk+0fR+VEA4XTVJbsZJXJsg/Y0hQ7lqob
        XYu4n8Q7F/U+XKwsnmh4IRJUq/e208gp4rdIVlebUWixDmYIexbD2CC8s1hacAiD
        PmEudjl8Y91n1wUPbe5MUlmhreDsKWKc1Yj2cIxW46D28GxZj/HRGXJoZRNkk7Q2
        eGWClVuWr6QAPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=XEV+7wC3qJf+gLzl6yzAmemuAs4SG
        w4ZCN1ouq8y5Sc=; b=Q1iPsPuMvJyO3NwagZQfc33tf8QUAQb1tdrs+RCU+9VBK
        239odyRWtJ6xZKMH6LGO5Ijf4EwfAjzBKb0FCHRHBoikXRFsy0g00OdPsyZU7cfo
        zpz9ZiLjDEeqZ3ZyOgxYa1lGMFuRT9BDP5M/OkEKCGn0dIAZYP29qtYbOV7RK40Y
        IjpGLz1i/HCIUpqgxTODShqKRxWokvKph7DfFOSBqUyKosw4pDi1sF8g7YkPkUcO
        BXrAEbXP2oZBVImRt4WpAjYRTvJda/wDWIF/SUCnb9UBW0/34J/NcfipQkKfrryA
        5PBivAqfnWkrztOFyrNwr4MgPQuTNc2YF3emeNNNw==
X-ME-Proxy: <xmx:ps1uWykCJm0MHZStoyEyI-cHlHaXqTiKZ-8PK-vNnbCpGEjPZqcqOg>
    <xmx:ps1uW1VMs20dsKtp328nly1Bi_ux04joR6m10gWDl7VlinMEsB8wHQ>
    <xmx:ps1uW1stakNdjUP7PEZvkyOTQP_aZCaX3n2XAOeOmNENG3hg7upw3A>
    <xmx:ps1uW1jealSNHML3x5K0uQo9Uhdd-EKuKUMZp43HYMcYp4SRP-7TCw>
    <xmx:ps1uWwwEmY0c5-6dC-IL4si3yZaD0WkzXM0_SXC0pQga8EOkE_psoA>
    <xmx:ps1uW6-RfMRG8ip_pfgaITRZR07BfZHsQSDAKIqy9ZqRKcgmmsf3AQ>
X-ME-Sender: <xms:ps1uWymyUj3qPufSXzHZShcw8AoD8ijc-pEyGBAVzI41gL87fDIrVQ>
Received: from localhost (124-169-145-41.dyn.iinet.net.au [124.169.145.41])
        by mail.messagingengine.com (Postfix) with ESMTPA id 867C410268;
        Sat, 11 Aug 2018 07:51:01 -0400 (EDT)
Date:   Sat, 11 Aug 2018 21:50:58 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-doc@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 0/4] Convert filter.txt to RST
Message-ID: <20180811115058.GN32374@eros>
References: <20180809052328.27942-1-me@tobin.cc>
 <20180809060734.rtqqu4sexbwzuqmm@ast-mbp>
 <20180809072753.GF32374@eros>
 <80bdc251-9f57-602f-6536-b34651684bb7@iogearbox.net>
 <20180810014636.GJ32374@eros>
 <20180810065752.2ab5473d@lwn.net>
 <CAADnVQL-ekJXQoP+Peuh1uBJ1RGxMJ0G0DVp-UoGcWOY9BATeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQL-ekJXQoP+Peuh1uBJ1RGxMJ0G0DVp-UoGcWOY9BATeQ@mail.gmail.com>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 10:51:28AM -0700, Alexei Starovoitov wrote:
> On Fri, Aug 10, 2018 at 5:57 AM Jonathan Corbet <corbet@lwn.net> wrote:
> >
> > The objective actually is to have SPDX tags in all files in the kernel.
> > That includes documentation, even though people, as always, care less
> > about the docs than they do the code.
> 
> right, but let's do that as a separate patch set.
> In the current set I'd focus on reviewing the actual doc changes.
> In particular completely removing
> Documentation/networking/filter.txt
> feels wrong, since lots of websites point directly there.
> Can we have at least few words there pointing to new location?

Something like ...


------------ filter.txt

BPF documentation can now be found in the following places:

- Introduction to BPF (Linux Socket Filter) - Documentation/userspace-api/socket-filter.rst
- Classic BPF (cBPF) - Documentation/userspace-api/cBPF.rst
- Internal BPF (eBPF) - Documentation/userspace-api/eBPF.rst

- SECCOMP BPF - Documentation/userspace-api/seccomp_filter.rst

- BPF Design Q&A - Documentation/bpf/bpf_design_QA.rst
- BPF Development Q&A - Documentation/bpf/bpf_devel_QA.rst

-------------


Also this highlights that bpf/index.rst is not quite correct yet in this
set.  The Q&A files are indexed but not explicitly mentioned.  My
feeling is that bpf/index.rst should mirror the information above.

thanks,
Tobin.
