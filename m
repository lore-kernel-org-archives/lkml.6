Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AEBC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1902F2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1902F2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ics.forth.gr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbeKFFAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:00:51 -0500
Received: from mailgate-4.ics.forth.gr ([139.91.1.7]:45925 "EHLO
        mailgate-4.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725139AbeKFFAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:00:50 -0500
Received: from av1.ics.forth.gr (av3in.ics.forth.gr. [139.91.1.77])
        by mailgate-4.ics.forth.gr (8.14.5/ICS-FORTH/V10-1.9-GATE-OUT) with ESMTP id wA5JdURL037948;
        Mon, 5 Nov 2018 21:39:32 +0200 (EET)
X-AuditID: 8b5b9d4d-91bff70000000e62-1e-5be09c72c25e
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.1.35])
        by av1.ics.forth.gr (SMTP Outbound / FORTH / ICS) with SMTP id 15.28.03682.27C90EB5; Mon,  5 Nov 2018 21:39:30 +0200 (EET)
Received: from webmail.ics.forth.gr (localhost [127.0.0.1])
        by enigma.ics.forth.gr (8.15.1//ICS-FORTH/V10.5.0C-EXTNULL-SSL-SASL) with ESMTP id wA5JdTaD019100;
        Mon, 5 Nov 2018 21:39:30 +0200
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 05 Nov 2018 21:39:29 +0200
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Vincent Chen <vincentc@andestech.com>
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu, zong@andestech.com,
        arnd@arndb.de, alankao@andestech.com, greentime@andestech.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        deanbo422@gmail.com
Subject: Re: [RFC 0/2] RISC-V: A proposal to add vendor-specific code
Organization: FORTH
In-Reply-To: <1540982130-28248-1-git-send-email-vincentc@andestech.com>
References: <1540982130-28248-1-git-send-email-vincentc@andestech.com>
Message-ID: <cac10a0961274e3ac4674e945f9d9e90@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.1.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LpjmZU1i2a8yDaYPM+KYttS1azWmz9PYvd
        4u+kY+wWt368YbR4vL6H0eLyrjlsFts+t7BZbJ6wgNVi1+5dbBbPV/ayOXB57Dk9i9nj969J
        jB6HO76we+ycdZfdY/OSeo9LzdfZPT5vkgtgj+KySUnNySxLLdK3S+DKeHJ3FWPBdY2K9xN7
        mBoYnyt0MXJySAiYSLzoW8zcxcjFISRwmFFi++UpUM5BRoltC3oYIapMJWbv7QSzeQUEJU7O
        fMICYjMLWEhMvbKfEcKWl2jeOpsZxGYRUJU48+MpmM0moCkx/9JBsHoRIPvewjnsIAuYBd4x
        Suz+1skEkhAWcJXov7mXFcTmFxCW+HT3IpjNKeAucWFXB5gtJOAmsb/tLDvEES4SBybuZoI4
        TkXiw+8HYHFRAWWJFyems05gFJqF5NZZSG6dheTWBYzMqxgFEsuM9TKTi/XS8otKMvTSizYx
        guNnru8OxnML7A8xCnAwKvHwchQ8iBZiTSwrrsw9xCjBwawkwqvEBhTiTUmsrEotyo8vKs1J
        LT7EKM3BoiTOe/hFeJCQQHpiSWp2ampBahFMlomDU6qBMaSUc7Lv4qD7q+5fqtKaPpX7snx+
        0uVtTyY1MBZMt5Bx62hbsFZWQ3NyZ5iQ2XP57eFdcxeHbRKe2Lk/1XLPwv+ezssKzVdt8fi9
        RJ5hlcNB19MdHS05p2t3Z3a6vHzJq5MyIVmoSPNE14HOp8/fbXu5yXfJfKV9T+eq3TF6fFZ6
        5/xzp/9+clZiKc5INNRiLipOBACtXFszmwIAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vincent,

Στις 2018-10-31 12:35, Vincent Chen έγραψε:
> RISC-V permits each vendor to develop respective extension ISA based
> on RISC-V standard ISA. This means that these vendor-specific features
> may be compatible to their compiler and CPU. Therefore, each vendor may
> be considered a sub-architecture of RISC-V. Currently, vendors do not
> have the appropriate examples to add these specific features to the
> kernel. In this RFC set, we propose an infrastructure that vendor can
> easily hook their specific features into kernel. The first commit is
> the main body of this infrastructure. In the second commit, we provide
> a solution that allows dma_map_ops() to work without cache coherent
> agent support. Cache coherent agent is unsupported for low-end CPUs in
> the AndeStar RISC-V series. In order for Linux to run on these CPUs, we
> need this solution to overcome the limitation of cache coherent agent
> support. Hence, it also can be used as an example for the first commit.
> 
>   I am glad to discuss any ideas, so if you have any idea, please give
> me some feedback.

So if I got this right, in your case you've added some CSRs 
(ucctlbeginaddr
and ucctlcommand) for marking regions as non-cacheable, and you provide 
your
own get_arch_dma_ops by overriding the default header files with your
vendor-specific ones.

Some things that are IMHO wrong with the proposed approach:

a) By directly modifying your custom CSRs, it means that we will need
compiler support in order to compile a kernel with your code in it. This
will break CI systems and will introduce various issues on testing and
reviewing your code. In general if we need custom toolchains to compile
the kernel, that may be unavailable (vendors will not always open source
their compiler support), we won't be able to maintain a decent level of
code quality in the tree. How can the maintainer push your code on the
repository if he/she can't even perform a basic compilation test ?

In contrast with ARM and others that have a standard set of possible
extensions (e.g. NEON, crc32 etc), and provide compiler support for 
those,
a similar approach is not valid for RISC-V. We could demand that vendors
add compiler support e.g. on gcc before submitting a patch with custom
assembly but I don't think this approach is feasible (one vendor's CSRs
or custom instructions may overlap with another's). I believe we should
just use SBI calls instead and let the firmware (and/or custom userspace
libraries) handle the custom CSRs/assembly instructions.

This is a concern also for lib/ and crypto/ where vendors might want to 
use
their own extensions for providing optimized assembly for their cores. 
It's
not a big deal to use SBI and handle vendor-specific stuff on firmware 
and/or
userspace, it's actually more flexible for the vendors since they can 
have
their own process for maintaining their firmware and releasing it in 
their
own terms/license etc. If we see that the SBI has too much overhead or 
is not
enough we can design it in a better way or extend it. It will still be
standard and easier to maintain than a fragmented ecosystem of mostly
unusable code, inside the mainline kernel.

In case we need to save/store registers related to a custom extension, I
guess we can also have an SBI call for saving/restoring custom registers
to/from S-managed memory and we should be ok. It should also be possible
to do any extra state handling in firmware if needed. I believe we can 
and
should avoid custom assembly on the kernel at all costs !


b) By using CONFIG_VENDOR_FOLDER_NAME you add a compile time dependency 
that
allows this kernel image to be built for a specific vendor. This is 
problematic
in different ways. At first it's not possible to have a kernel image 
that's
generic and can be used for all RISC-V systems. That's what distros want
and that's how they 've been working so far.

Also in case a vendor has many different boards with different 
implementation
details how will this approach help ? It would make more sense to have 
something
like arch/riscv/<platform>. Also have in mind that some extensions might 
be
available as IP to vendors so multiple vendors might use the same 
extension
made/licensed from another vendor. I think arch/riscv/<extension> is 
more
appropriate. Since we can use mvendorid/marchid/mimpid to identify that
at runtime maybe we can have some wrapper code that initializes a struct 
of
function pointers early on setup_arch(), allowing vendors to populate it
according to the available extensions in their hw, based on the above 
ids.

We can also just use device-tree for that and mark the used extensions 
there.
We can even pass extension-specific parameters this way (e.g. to save 
CSRs)
in case of extensions that can be parametrized on hw design phase (I'm
thinking of IPs sold from companies with licenses for unlocking the X 
feature
or for supporting up to Y channels/slots/instances/whatever).


In any case it's an interesting subject that we definitely need to think 
about,
thanks for bringing this up !

Regards,
Nick
