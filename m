Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0585CC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFCF121476
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NOp+V4Pt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFCF121476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeJAXVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 19:21:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40728 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725740AbeJAXVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 19:21:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id s5-v6so9629962pfj.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 09:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=h3bEcrrSNY9f1REFsb0jumY0i0qy9sSG5USvLnAw73s=;
        b=NOp+V4PtclyvgDhPQW9NPO5Bq5ixy8wY+UjexDsznNmUWNdmuU+Xup+waWfeG8s2KU
         0zBXCBGXywCP1CkhqAdtzbPg5ljAJeXFgqw5+oEtpwDhqOLz1ZNE76gxQVJashBE+YrD
         la85iF5E+Xf8Ug7VpPIYBYddR+QO71B731X+/cXGiXxYTkkte6xQ4DWYSD891YWwzsXd
         NMUOpA4t9QPZLVqi1ePFmlZSRIT1iAc6eSTTphlFCCjtEtnc77O1e/sRRvOFbyUKGdNp
         9OaxRKVrK6+J2Xu4J1/qV8qAH130aHA+GNF34WY4jebKnmp187Bua0XAV34SAA37TYa7
         zBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=h3bEcrrSNY9f1REFsb0jumY0i0qy9sSG5USvLnAw73s=;
        b=mYFLOJ5nQ6T5OOaByrztDzsMIPvckOIL1CEmL6ilXyG2P4YjdPUvmhh9NrVxTVbIs7
         vsO69V+XSDnBkRo0V6TgnHzVs9FguQJ8lrZhD1L2CI1in71I/XM1WoL7gv0XMkpvvn6X
         a/byup9dFO5iGCmniCjpKILfSsUVg1y5qduAie6H9wArFSZncs84uVQCp/Kc+0HR0nQk
         MZ/tVpCflQd4oCE16p2lRfmRENTlkCVLiQiC8fRrUNJYhAr97ukN5vPIkAHXouSKj18y
         QKNPLaB4bcA+CWdL9koiLT1QVqQTgIArhtO/DXomfKCGJcS1njXUNCRjoVuc3Ij+pMoH
         6/Jw==
X-Gm-Message-State: ABuFfohQsDQYJsrAMGwDZiIcWPBFLQEV6nf3ArIUy5b64sZh0NghbvKJ
        tH/QJZXc6CQu+UKRRRLaIwVFQA==
X-Google-Smtp-Source: ACcGV60OtZS93tI03Kl5kXcs4fazktBpuZrpI2z6q+7nHqo87BRF7aJr6+7a5GiBB8+Kh2yjTRO2WQ==
X-Received: by 2002:a17:902:f01:: with SMTP id 1-v6mr12752281ply.8.1538412160897;
        Mon, 01 Oct 2018 09:42:40 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id a2-v6sm16322337pgc.68.2018.10.01.09.42.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 09:42:39 -0700 (PDT)
Date:   Mon, 01 Oct 2018 09:42:39 -0700 (PDT)
X-Google-Original-Date: Mon, 01 Oct 2018 09:40:12 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Show CPU ID and Hart ID separately in /proc/cpuinfo
In-Reply-To: <CAAhSdy2gC15j9zW+_rjBQzofGyhBjcNVWSYCbBtrAmQtDogBqA@mail.gmail.com>
CC:     aou@eecs.berkeley.edu, atish.patra@wdc.com,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     anup@brainfault.org
Message-ID: <mhng-d37b6a32-c6d3-4736-80f4-cb814dde9fed@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2018 23:12:47 PDT (-0700), anup@brainfault.org wrote:
> On Sat, Sep 29, 2018 at 7:16 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> On Wed, 12 Sep 2018 07:38:22 PDT (-0700), anup@brainfault.org wrote:
>> > Currently, /proc/cpuinfo show logical CPU ID as Hart ID which
>> > is in-correct. This patch shows CPU ID and Hart ID separately
>> > in /proc/cpuinfo using cpuid_to_hardid_map().
>> >
>> > With this patch, contents of /proc/cpuinfo looks as follows:
>> > cpu   : 0
>> > hart  : 1
>> > isa   : rv64imafdcsu
>> > mmu   : sv48
>> >
>> > cpu   : 1
>> > hart  : 0
>> > isa   : rv64imafdcsu
>> > mmu   : sv48
>> >
>> > cpu   : 2
>> > hart  : 3
>> > isa   : rv64imafdcsu
>> > mmu   : sv48
>> >
>> > cpu   : 3
>> > hart  : 2
>> > isa   : rv64imafdcsu
>> > mmu   : sv48
>> >
>> > Signed-off-by: Anup Patel <anup@brainfault.org>
>> > ---
>> >  arch/riscv/kernel/cpu.c | 3 ++-
>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
>> > index f0f0ec2737b7..7c1342e242e6 100644
>> > --- a/arch/riscv/kernel/cpu.c
>> > +++ b/arch/riscv/kernel/cpu.c
>> > @@ -87,7 +87,8 @@ static int c_show(struct seq_file *m, void *v)
>> >                                                  NULL);
>> >       const char *compat, *isa, *mmu;
>> >
>> > -     seq_printf(m, "hart\t: %lu\n", cpu_id);
>> > +     seq_printf(m, "cpu\t: %lu\n", cpu_id);
>> > +     seq_printf(m, "hart\t: %lu\n", cpuid_to_hardid_map(cpu_id));
>> >       if (!of_property_read_string(node, "riscv,isa", &isa)
>> >           && isa[0] == 'r'
>> >           && isa[1] == 'v')
>>
>> I like this, but it doesn't appear to apply.  Do you mind sending something
>> against Linus' master?  Then I should be able to sort it out.
>>
>
> This patch is requires cpuid_to_hardid_map() added by Atish's
> patchset so I have requested Atish to make this patch part of
> his v6 patchset.

Thanks!
