Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC8BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F24A222C2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gSU7pGpW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbfBLXGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 18:06:05 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:53728 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729264AbfBLXGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 18:06:05 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 7D76F10C1C46;
        Tue, 12 Feb 2019 15:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1550012764; bh=DavfpsT2aJaiB6R8iH2e9RmITZKKNwKhYJRQcHDdNb0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=gSU7pGpW211S43Jk/g0eocgItL+arNIxmJf04m//B4SU6qbAb6Vw2Tyk2bneb+dJD
         vUgW8ssiEG2h571WbRyWKHf2IH35aEZDDuYScTrz5p6lzohmMr9JRtdi8EqNvPmJjt
         XoKIwSLWn0l7l88sszJCNG9/6oG8LmtiloRrcpqOJIKqIEp+EitYCc6UImxJSpLeUK
         DqnIgTx6o8ot/P1NnNzyr2a9laX3TmaExNPsuScQ5is6UFPjROFBt8Y2WGhwLuYkhJ
         3oUto9lo5qi9btAA5/svijVTEgNvsf2O+TFDLzNR6cvEQ2O7YfBs+rbTNc4Fhh1JU3
         +8znuNjc+SC0Q==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 219AFA0071;
        Tue, 12 Feb 2019 23:06:03 +0000 (UTC)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 12 Feb 2019 15:06:02 -0800
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 13 Feb 2019 04:36:05 +0530
Received: from [10.10.161.59] (10.10.161.59) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 13 Feb 2019 04:36:04 +0530
Subject: Re: Semantics of symbol address in perf report -v
To:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        "Eugeniy Paltsev" <eugeniy.paltsev@synopsys.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Newsgroups: gmane.linux.kernel.arc,gmane.linux.kernel.perf.user,gmane.linux.kernel.cross-arch,gmane.linux.kernel
References: <da403654-f21d-9959-067f-b76581600741@synopsys.com>
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
Openpgp: preference=signencrypt
Autocrypt: addr=vgupta@synopsys.com; keydata=
 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
 hhqBJlyU6MVUa6vZNv8E
Message-ID: <c7f4f000-6934-912e-f8eb-c163a04323d1@synopsys.com>
Date:   Tue, 12 Feb 2019 15:05:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <da403654-f21d-9959-067f-b76581600741@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.161.59]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/19 11:55 AM, Vineet Gupta wrote:
> Hi,
> 
> I noticed a small anomaly in perf report -v output on ARC and x86 as well.
> 
> A simple program which sits in tight loop, compiled for x86_64
> 
> void main() { while(1) {} }
> 
> $ gcc -g tight.c
> $ ./a.out &
> $ perf record -e cycles -p 26703
> $ perf report -n -v  --stdio  | egrep "(main|Symbol)"
> 
> |# Overhead Samples Command  Shared Object         Symbol
> 
> |  99.93%    55753   a.out   /home/arc/test/a.out  0x4da     B [.] main
> 
> |                                                  ^^^^^
> 
> The printer address for Symbols is *not* the actual address in elf, but rather VMA
> start offset.
> 
> 0x4da = 0x4004da - 0x0000000000400000
> 
> $ objdump -d ./a.out
> 
> | 00000000004004d6 <main>:
> |  4004d6:	55                   	push   %rbp
> |  4004d7:	48 89 e5             	mov    %rsp,%rbp
> |  4004da:	eb fe                	jmp    4004da <main+0x4>
> |  4004dc:	0f 1f 40 00          	nopl   0x0(%rax)
> 
> $ readelf -a ./a.out
> 
> | Program Headers:
> |  Type           Offset             VirtAddr           PhysAddr
> |                 FileSiz            MemSiz              Flags  Align
> | Program Headers:
> |  LOAD           0x0000000000000000 0x0000000000400000 0x0000000000400000
>                  0x000000000000068c 0x000000000000068c  R E    200000
> 
> 
> This is problematic in narrowing down the hotspot instruction, when the binary
> itself is. One needs to do the offset addition manually to find the actual hotspot
> location.
> 
> |   99.79%  100064  a.out  /home/arc/test/a.out  0x4da  B [.] 0x00000000000004da
> 
>                                                                ^^^^^^^^^^^^^^^^
> 
> Is this considered an issue ? Would the fix to print the actual symbol address
> (and recorded in raw perf event data) break some existing tooling etc.
> 

@Arnaldo any ideas ?

this is being done in tools/perf/util/symbol-elf.c

    symsrc__init
	if (dso->kernel == DSO_TYPE_USER)
		ss->adjust_symbols = true;

     dso__load_sym
	dso->adjust_symbols = runtime_ss->adjust_symbols || ref_reloc(kmap);

		} else if ((used_opd && runtime_ss->adjust_symbols) ||
			   (!used_opd && syms_ss->adjust_symbols)) {

			*sym.st_value -= shdr.sh_addr - shdr.sh_offset;*
               }

I investigated a bit more and this goes back to 2009:

Initially the adj was done for prelink binaries: commit f5812a7a336fb
("perf_counter tools: Adjust only prelinked symbol's addresses")

+       self->prelinked = elf_section_by_name(elf, &ehdr, &shdr,
+                                             ".gnu.prelink_undo",
+                                             NULL) != NULL;
+      if (self->prelinked) {
          if (verbose >= 2)
            printf("adjusting symbol: ...
           sym.st_value -= shdr.sh_addr - shdr.sh_offset;
+      }

commit 30d7a77dd5a97 ("perf_counter tools: Adjust symbols in ET_EXEC files too")
started doing this for any executable

-       self->prelinked = elf_section_by_name(elf, &ehdr, &shdr,
-                                             ".gnu.prelink_undo",
-                                             NULL) != NULL;
+       self->adjust_symbols = (ehdr.e_type == ET_EXEC ||
+                               elf_section_by_name(elf, &ehdr, &shdr,
+                                                    ".gnu.prelink_undo",
+
