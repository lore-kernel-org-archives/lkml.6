Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F05C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6249E213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6249E213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbeK3DBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:01:50 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:54631 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbeK3DBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:01:49 -0500
Received: from office.codethink.co.uk ([148.252.241.226] helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1gSOfU-0006EJ-59; Thu, 29 Nov 2018 15:55:56 +0000
Message-ID: <1543506955.2867.10.camel@codethink.co.uk>
Subject: Re: [PATCH 1/3] bpf/verifier: Log instruction patching when verbose
 logging is enabled
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 29 Nov 2018 15:55:55 +0000
In-Reply-To: <b1d395a1-076a-054d-09ae-9d9242b1c29a@iogearbox.net>
References: <20181123183356.5q4bu47zpj5wdufb@xylophone.i.decadent.org.uk>
         <20181123183455.qjokyt6zpa2yck6s@xylophone.i.decadent.org.uk>
         <b1d395a1-076a-054d-09ae-9d9242b1c29a@iogearbox.net>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-23 at 21:10 +0100, Daniel Borkmann wrote:
> On 11/23/2018 07:34 PM, Ben Hutchings wrote:
> > User-space does not have access to the patched eBPF code, but we
> > need to be able to test that patches are being applied.  Therefore
> > log distinct messages for each case that requires patching.
> 
> Thanks for the patches, Ben! Above is actually not the case, e.g. privileged
> admin can use something like 'bpftool prog dump xlated id <id>' and then the
> BPF insns are dumped to user space for the program /after/ the verification,
> so the rewrites can then be seen.

Oh that's good.

> test_verifier temporarily drops caps to
> load and run the unprivileged cases, but we can extend the test suite to
> retrieve and check the final insns after that happened. I think this would be
> a nice extension to the test suite for cases like these and would also provide
> better insight than verbose() statement saying that something has been
> patched (but not the actual result of it).

Agreed; I'll look into doing this instead.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
