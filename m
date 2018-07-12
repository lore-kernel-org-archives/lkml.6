Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35153C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDCAF2147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/hmxWTM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDCAF2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732514AbeGLOxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:53:55 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37130 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732338AbeGLOxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:53:55 -0400
Received: by mail-oi0-f67.google.com with SMTP id k81-v6so56219148oib.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 07:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GVkS6C/v4FZ8oJ7TC45xk+UqKqaEvSf4sNhHJ2FbgKM=;
        b=I/hmxWTMw8PE5lhi5iZ+hvqeQCECSl8ia7Lr2BoSpmAkge0tkVPK9pji9uhV8Wf+M2
         /A6WPwpZ4oKDGQf5xTUq4Qbz8KzOhbU4Juf91oIC10LhTmE8HlVTemOa5HLJ0GuYvq3F
         FJdznDC2MouY7npazHwr+S2TebonQltYD/WSyT5Va+eM0XrvpJoIB20tclsJXl4H1J4N
         mGhmrU45NqpVSNFnzbR0IYEAi5CzDBFLyZEIuRQZQKZSQ90Hc88JUe8w3Wyb8tHHrGRq
         HjVKDDWGNEx9v50DbfzVxKptnapTBJTh9jtJTW+N2Ee5SWJKEePJtLv1TacCAGNyNvFa
         YWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GVkS6C/v4FZ8oJ7TC45xk+UqKqaEvSf4sNhHJ2FbgKM=;
        b=QluqPpuJZP46Yk3MetelOJbJOQyE/+oTkh6w1DrPiKeTpIZbYFfn2OEpBeYRPf7gUq
         isAMb50QLO/CUx5QtQIESPK94QFboEQVrpZCxTkg+jJSCJdEh5NdBjXPneE4gVpUyv/m
         NROsEzm7wXLcsGFwrx/1d2L/V/ifBLy4v1tWqSIEy4faMU41fbBj3x92RSW3rWiDF5Ul
         yj2qf9MaR30wlnuachaNVwepLQa0RsDMGYcZAxM+jeT8vd5+w3QUl79EkJzXgIqfZGwt
         AvZWUv0nOl95u9mHmH7YkVsYti9w0YvqCiZ6SzELTU9eNiMps7SHCmZOff1ns/2YgMsm
         VhjA==
X-Gm-Message-State: AOUpUlHGoSC6IRlKbb0vygDIvpNcop/xXCfyWHKkj3QKzCEggQSfaoqC
        EVc0Vzrp+/Q9XPX4nZqyoGmnKMZUFzthwquc6Pw=
X-Google-Smtp-Source: AAOMgpe+g9bHH8xe2dc9A+4nUAKVmX0BTtelZ53jSjMNZ/3QH8cyyDYCzwaaN4tVNptQOpdIhddBX4LEemLSlPWoQOA=
X-Received: by 2002:aca:6655:: with SMTP id a82-v6mr2814475oic.228.1531406642951;
 Thu, 12 Jul 2018 07:44:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:c984:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 07:44:01
 -0700 (PDT)
In-Reply-To: <f3e2ca08-e22d-f16c-1c2e-9fb1985771ef@intel.com>
References: <9548e10a-7403-425e-bf1f-b1eb9d055d99@intel.com>
 <CAMe9rOrHowBX06nihdRRmEqhV8v7cs+PwVY7JYQFpUFOnHC71A@mail.gmail.com>
 <f22ee1e2-9a35-697f-50ab-543ac1631c89@intel.com> <CAMe9rOpPwtPd-R+D9=iDYgbFtnP+=akWic-QBKwq9wKa7uadEQ@mail.gmail.com>
 <2022d212-62f2-a163-2493-abecfbafa07b@intel.com> <CAMe9rOqc0oVw+ZLXCM-nrtPb1OiPFBeHt+Lsx+6K6y=t3HSVhA@mail.gmail.com>
 <cbb38230-9c57-905b-3a11-e2717c5aa615@intel.com> <CAMe9rOqh9saaULM_+jNtzfYarbZScm+6KCEyibxxqn7GLvKwzA@mail.gmail.com>
 <CAMe9rOpV89jWhvAZtqOJnc0eXzRYiLF5pLWRcdb7-kKLigj4rQ@mail.gmail.com>
 <067e2d5d-1abf-efd4-cb50-992ba5ca6748@intel.com> <20180711183126.yo7eyqpd4ggb5kcr@codemonkey.org.uk>
 <9A6C6EEB-85D8-4F59-95ED-EB4DA5947BCA@amacapital.net> <f3e2ca08-e22d-f16c-1c2e-9fb1985771ef@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Thu, 12 Jul 2018 07:44:01 -0700
Message-ID: <CAMe9rOpBm71hnzG0wx=2qaWKHYNE30JJOT=Jt4i+Vqs3Xb4qBQ@mail.gmail.com>
Subject: Re: Kernel 4.17.4 lockup
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Dave Jones <davej@codemonkey.org.uk>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 4:14 PM, Dave Hansen <dave.hansen@intel.com> wrote:
> On 07/11/2018 04:07 PM, Andy Lutomirski wrote:
>> Could the cause be an overflow of the IRQ stack?  I=E2=80=99ve been mean=
ing
>> to put guard pages on all the special stacks for a while. Let me see
>> if I can do that in the next couple days.
>
> But what would that overflow into?  Wouldn't it most likely be another
> interrupt stack since they're all allocated together?
>
> This looks more like thread stack corruption.

I tried netconsole and got this:

[29369.552998] ------------[ cut here ]------------
[29369.560996] kernel BUG at mm/page_alloc.c:2019!
[29369.568980] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
[29369.576892] Modules linked in: netconsole xt_CHECKSUM
ipt_MASQUERADE nf_nat_masquerade_ipv4 tun nf_conntrack_netbios_ns
nf_conntrack_broadcast xt_CT ip6t_rpfilter ip6t_REJECT nf_reject_ipv6
xt_conntrack devlink ip_set nfnetlink ebtable_nat ebtable_broute
bridge stp llc ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6
nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_security iptable_nat
nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack
libcrc32c iptable_mangle iptable_raw iptable_security ebtable_filter
ebtables ip6table_filter ip6_tables sunrpc vfat fat intel_powerclamp
coretemp kvm_intel kvm irqbypass intel_cstate intel_uncore
snd_hda_codec_realtek snd_hda_codec_generic iTCO_wdt
iTCO_vendor_support gpio_ich snd_hda_intel joydev snd_hda_codec
snd_hda_core snd_hwdep mxm_wmi snd_seq snd_seq_device
[29369.627745]  snd_pcm pcspkr snd_timer snd i2c_i801 soundcore
lpc_ich i5500_temp i7core_edac shpchp wmi acpi_cpufreq ata_generic
pata_acpi radeon crc32c_intel i2c_algo_bit drm_kms_helper
firewire_ohci firewire_core ttm crc_itu_t drm e1000e pata_marvell
[29369.645472] CPU: 1 PID: 3896 Comm: expect Tainted: G          I
  4.17.5+ #7
[29369.654333] Hardware name:  /DX58SO, BIOS
SOX5810J.86A.5600.2013.0729.2250 07/29/2013
[29369.663320] RIP: 0010:move_freepages_block+0x246/0x4b0
[29369.672238] RSP: 0018:ffff8800b61f7178 EFLAGS: 00010002
[29369.681064] RAX: ffff8801af3d7000 RBX: ffffea00033c8000 RCX: 00000000000=
00000
[29369.690011] RDX: dffffc0000000000 RSI: ffffea00033cc000 RDI: ffffffff831=
d8ec0
[29369.698992] RBP: ffff8801af3d7680 R08: ffff8800b61f73c8 R09: ffffed0035e=
7af78
[29369.708025] R10: ffffed0035e7af78 R11: ffff8801af3d7bc3 R12: ffff8800b61=
f7228

before machine looked up.

--=20
H.J.
