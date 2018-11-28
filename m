Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E162C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 01:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1630B20851
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 01:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YklVy7/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1630B20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeK1MU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 07:20:59 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:44119 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbeK1MU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 07:20:59 -0500
Received: by mail-yb1-f196.google.com with SMTP id p144-v6so9928728yba.11;
        Tue, 27 Nov 2018 17:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/p3lR1qb5AtNLs2gdxyYDh5jPsCXjKv4iEznoBPU0zE=;
        b=YklVy7/wF0flvKGW++A4sQ/j0Mb2T7y+msrOsN+4rXS+mqbkoZR/caheWr0rTWgFfr
         RdgZgkLYKtb46aOTdfWHIOj3byMTrG35wV2qKz/PONJhpbQ76RO8n3xDzSAtI5XZ4WRI
         l87xxN3RzUgGi1PcfDtB5zYrIQ0LNNiJRSv0CnGK5kgEsocKefuZs4B/EO+XAJSphf9J
         nRxJxeMX+2rDwb2XvLJ1hCbuJTwJW1X38tkIDHnFC06Dpo2WCUgjZAyHM5phqv9HCQam
         oEAdn7Zo2eeRf/+/89o0i3uKsRV6sPGOAUJz5tRdcNQ0kbD8iF122OjuWP+wYtKtitZ4
         F89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/p3lR1qb5AtNLs2gdxyYDh5jPsCXjKv4iEznoBPU0zE=;
        b=Wdw/u2DWMzhDPutoDaSxGf1RRSdzs8+58eUZooBZssETYJyhb5Um3Ubzj4ZbYaGHTs
         5bXs/gMhxYA2n1r7SzpScXw6btXwj4WK4SNQUA0/WFmahp5xF81v3jxpr+USR8x2/t48
         IIXSrh3Z2qgkj4iBQqmaPiJpVOfPvZZZNjx4Qp4YSTtx6vJsT4Pd+18EvhFzkJp4BjBP
         mChUg3i4pIq7ohqdAt/9WAshnECo0GCGDTLBWTyD80hflXHhe23bdNSE11KVl6un2xJJ
         rZikAYL5NkE0oUpxTI0BzXeSovQRawT0qS2jUiYmHV1Wk0Vq2MbPN/+3nDaAAMKvN7m8
         c00g==
X-Gm-Message-State: AA+aEWZYzrM/1L3ZMRffoFn8P6r46iIR3GcaPiMzarEXElSErZ7PDFSe
        vmNUMwmgDv8gCmI7GxwwSYc=
X-Google-Smtp-Source: AJdET5erxLVejscsHgoj8PKsm9L7CfW8FijU3DkMpSYo5J9ZWPRzS5Vmlo8xoKacRebEBapIVSusQA==
X-Received: by 2002:a25:cc8f:: with SMTP id l137-v6mr36123844ybf.393.1543368072250;
        Tue, 27 Nov 2018 17:21:12 -0800 (PST)
Received: from [10.33.114.204] ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id l35sm2523945ywh.48.2018.11.27.17.21.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 17:21:11 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: =?utf-8?Q?Re=3A_=5BPATCH_0/2=5D_Don=E2=80=99t_leave_executable_TL?=
 =?utf-8?Q?B_entries_to_freed_pages?=
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CDB8B7C1-FD55-44AD-9B71-B3A750BF5489@gmail.com>
Date:   Tue, 27 Nov 2018 17:21:08 -0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        naveen.n.rao@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com,
        David Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>, rostedt@goodmis.org,
        mingo@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        jeyu@kernel.org, netdev@vger.kernel.org, ard.biesheuvel@linaro.org,
        jannh@google.com, kristen@linux.intel.com, dave.hansen@intel.com,
        deneen.t.dock@intel.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <449E6648-5599-476D-8136-EE570101F930@gmail.com>
References: <20181128000754.18056-1-rick.p.edgecombe@intel.com>
 <CDB8B7C1-FD55-44AD-9B71-B3A750BF5489@gmail.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Nov 27, 2018, at 5:06 PM, Nadav Amit <nadav.amit@gmail.com> wrote:
>=20
>> On Nov 27, 2018, at 4:07 PM, Rick Edgecombe =
<rick.p.edgecombe@intel.com> wrote:
>>=20
>> Sometimes when memory is freed via the module subsystem, an =
executable
>> permissioned TLB entry can remain to a freed page. If the page is =
re-used to
>> back an address that will receive data from userspace, it can result =
in user
>> data being mapped as executable in the kernel. The root of this =
behavior is
>> vfree lazily flushing the TLB, but not lazily freeing the underlying =
pages.=20
>>=20
>> There are sort of three categories of this which show up across =
modules, bpf,
>> kprobes and ftrace:
>>=20
>> 1. When executable memory is touched and then immediatly freed
>>=20
>>  This shows up in a couple error conditions in the module loader and =
BPF JIT
>>  compiler.
>=20
> Interesting!
>=20
> Note that this may cause conflict with "x86: avoid W^X being broken =
during
> modules loading=E2=80=9D, which I recently submitted.

I actually have not looked on the vmalloc() code too much recent, but it
seems =E2=80=A6 strange:

  void vm_unmap_aliases(void)
  {      =20

  ...
  	mutex_lock(&vmap_purge_lock);
  	purge_fragmented_blocks_allcpus();
  	if (!__purge_vmap_area_lazy(start, end) && flush)
  		flush_tlb_kernel_range(start, end);
  	mutex_unlock(&vmap_purge_lock);
  }

Since __purge_vmap_area_lazy() releases the memory, it seems there is a =
time
window between the release of the region and the TLB flush, in which the
area can be allocated for another purpose. This can result in a
(theoretical) correctness issue. No?

