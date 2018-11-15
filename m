Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1381DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CA921780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7CA921780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solarflare.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388990AbeKPF7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:59:49 -0500
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:50606 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725869AbeKPF7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:59:49 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us3.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id 0372EB400BD;
        Thu, 15 Nov 2018 19:50:35 +0000 (UTC)
Received: from ec-desktop.uk.solarflarecom.com (10.17.20.45) by
 ocex03.SolarFlarecom.com (10.20.40.36) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 15 Nov 2018 11:50:19 -0800
Subject: Re: WARNING in bpf_check (2)
To:     syzbot <syzbot+4fc427c7af994b0948be@syzkaller.appspotmail.com>,
        <ast@kernel.org>, <daniel@iogearbox.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>
References: <000000000000c9fe68057aaf48ff@google.com>
From:   Edward Cree <ecree@solarflare.com>
Message-ID: <5e3a3f0c-7981-c3a3-b4ab-c7d65470d392@solarflare.com>
Date:   Thu, 15 Nov 2018 19:50:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <000000000000c9fe68057aaf48ff@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Originating-IP: [10.17.20.45]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24222.005
X-TM-AS-Result: No-4.948700-4.000000-10
X-TMASE-MatchedRID: VPleTT1nwdQOwH4pD14DsPHkpkyUphL9suIso71Vk6IwGgZhIlY8SzpI
        hhonTuyPmnaWd90iolxoOl48rYPFefrqG4cFc/YAvHKClHGjjr2wR/wKmchi2T9zwv61WVRWAMJ
        cHOzzDuO3ZkwTC0mWoVHDeXhxzobf5MSi+jETHH0XrP0cYcrA28SgMQYKGHsJpcn28zKwP8KDtx
        8lDD0Wx0IsQzqZ2Xa9EubYZQfPWlu/WXZS/HqJ2gtuKBGekqUpnH7sbImOEBRKzGtfmKVHdY5Og
        hbiaJhOH/tJDrEgLMx4hvNc8gM+BLxEDoSYA/8zSzeHtqoubvzO+1+9CEMXMwKfCCECTygN+NtD
        ge0nTbKPgCDbAY3P7tVH8LonOSWy/S2A05ietQe2WKPzVcog4R/BXqwE9HSW
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.948700-4.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24222.005
X-MDID: 1542311437-lOgl0QXgWezD
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/18 07:49, syzbot wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    ccda4af0f4b9 Linux 4.20-rc2
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=129edfbd400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4a0a89f12ca9b0f5
> dashboard link: https://syzkaller.appspot.com/bug?extid=4fc427c7af994b0948be
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172b626d400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148dcb0b400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+4fc427c7af994b0948be@syzkaller.appspotmail.com
I'm investigating this.  So far I have disassembled the prog and reproduced
 the failure by adding the following to test_verifier.c:
    {
        "syz found: explosion",
        .insns = {
            BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
            BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 5),
            BPF_JMP_REG(BPF_JSGT, BPF_REG_0, BPF_REG_0, 0),
            BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
            BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
            BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
            BPF_EXIT_INSN(),
            BPF_LDX_MEM(BPF_B, BPF_REG_9, BPF_REG_1, 0),
            BPF_MOV64_IMM(BPF_REG_0, 0),
            BPF_EXIT_INSN(),
        },
        .prog_type = BPF_PROG_TYPE_SOCKET_FILTER,
        .result = ACCEPT,
    },
A subprog _does_ start at insn 7, and the verifier was happy with it until
 jit_subprogs, suggesting that something has mangled env->subprog_info[].start
 or else insns have been inserted but the call insns not adjusted.
The obvious suspect would be adjust_subprog_starts() and/or
 bpf_patch_insn_data().

-Ed
