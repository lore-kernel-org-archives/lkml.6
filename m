Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D020C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF7720852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8tawwFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF7720852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbeGYSgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 14:36:14 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:44074 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbeGYSgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 14:36:14 -0400
Received: by mail-pf1-f172.google.com with SMTP id k21-v6so1942484pff.11;
        Wed, 25 Jul 2018 10:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=VmU7+L904IvlaG7fqi5iWeqPyvadF/3l/1qlDzvJTYk=;
        b=m8tawwFPNtOBThLRSjh/WurPTzyTrYuOATdMBlPPTXEZyV6wvhvo1zcUFWHq3bGazY
         8QCtqvyH9Es+xGHXQbTAgO9EECqy23dIu5Mx4IcFyprFDFpiV6dKgg9pbg29TFUWlCHk
         Y6chOOuhrKUqBSNNPGUoasXPsEdVjQQut4zqERodBZdhl9EHpgDHQsjul/hzcGGgKUiF
         cQEvCizpS8t/tVgkrp/YCp73ZXW9OwOOzDq49Rm7GoyRdHL4ugTlWIxvS7HkLyHiK13g
         9SndqWzlhqhAeW4Y0flJeg02boGAg+md1I1CfsCFi0oECY0ILjEZPQsqCuPynTcu+22r
         tyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=VmU7+L904IvlaG7fqi5iWeqPyvadF/3l/1qlDzvJTYk=;
        b=T7Wd6Z4QUmSElbX0i1QJj40kjrF7CYvZXp1gwAtrwNjjy/cmwokSgqr1UW1RHGD6rj
         JZ17jJxI8Es8eX5Rh1SW2TJw7W81U1+Q0oh2zy1VPLtFFo/GTWJSfhUCkSeFwy6s+HFd
         cL28q8hOQ6+KGkg2vMjQPOF3/Qtq64ezdph60ZuC+uQwOdHtM5q6Liayj4oKvGQL/iCY
         NCR/x3pXSgejwYzUttg1wBBgNtDIZrGUdEcBQrKEsO92/pc2xaUxOg1NAM2+BSutsFmu
         HlLhUXhIwQOLohKNQsE96BbGGnRjoptZJBPsrD0L/li6iA05BkiL5NAFa5niDdYbPHrJ
         1ehw==
X-Gm-Message-State: AOUpUlEAGKD2QIZ/++NDEP3drqg87hB4YzbX5r8rptKz3cZTGix+VhI1
        z6fJnISkHQsekJK/n4cZInrlKlcs
X-Google-Smtp-Source: AAOMgpeFfujakYwek/X+UFdXmMI3ZiWorkne9IGWPT6Auyd1DgSOKUloMmdxPvCf4IGsvV6mpfd3/Q==
X-Received: by 2002:a63:41c6:: with SMTP id o189-v6mr21787885pga.323.1532539416737;
        Wed, 25 Jul 2018 10:23:36 -0700 (PDT)
Received: from [192.168.0.77] ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id q28-v6sm27447092pfg.144.2018.07.25.10.23.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 10:23:35 -0700 (PDT)
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Taeung Song <treeze.taeung@gmail.com>
Subject: [Question] bpf: about a new 'tools/bpf/bpf_dwarf2btf'
Message-ID: <47cfb90e-a9f4-8127-2b89-0e20d9fda2f0@gmail.com>
Date:   Thu, 26 Jul 2018 02:23:32 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Building bpf programs with .BTF section,
I thought it'd be better to convert dwarf info to .BTF by
a new tool such as 'tools/bpf/bpf_dwarf2btf' instead of pahole
in the future.

Currently for bpf binary that have .BTF section,
we need to use pahole from https://github.com/iamkafai/pahole/tree/btf
with the command line such as "pahole -J bpf_prog.o".

I think it is great but if implementing new 'bpf_dwarf2btf'
(dwarf parsing + btf encoder code written by Martin KaFai Lau on
the pahole project i.e. btf.h, btf_encoder.c, btf_encoder.h, libbtf.c, 
libbtf.h),
BPF developers would more easily use functionalities based on BTF.

What do you think about this ? Do you think this is needed ?
Or, already implementing something like this ?

If it is needed, I want to try to make 'tools/bpf/bpf_dwarf2btf'
based on the pahole code. I'd appreciate it, if you reply to this

Thanks,
Taeung
