Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A4AC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBE620830
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZVsYIaBT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DBE620830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbeKGJNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 04:13:38 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42048 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbeKGJNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 04:13:37 -0500
Received: by mail-pf1-f194.google.com with SMTP id u10-v6so1103388pfn.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 15:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=3mZx8qDroV6FAU5EZ6pqnwSrOu6KAm56fCYs5Ed1eNo=;
        b=ZVsYIaBTty5C4Sa9GGFzh1uVTd+nkurOgr8rifxK5Oin+N0y2s4MUGZTORikfExSMf
         /zPh0ODraQS0ksvXesdg+Fru56wUZ6hLVMt4/ZH16z8YseNx/CJ0atKYKUqCbBZWfdOf
         E9jHO0SX4PK9H7SZG31PO5VJj9IdrXgDT0Fnv4L2u4zhXjOpKK/bUW2jbT5tpRvfAJ5d
         eOE2uOrrcpYsAzl04Fuo3Oh0qOA8blnANQRZVGX8Rtu4/ugMlSem+oFMkEUi3kSgYWjj
         uBW3Z7vq4OvRDR3b9qTB1jqYR2yAjxx7/ztNJik1gC5F1QoHiaIJFzvDs5wT+6hdqldj
         5nVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=3mZx8qDroV6FAU5EZ6pqnwSrOu6KAm56fCYs5Ed1eNo=;
        b=SgFk4jy+M8xYT5g8rntXQW/SFPMAu9XWMCrUSxIA01i7ZPU2lv4PMYSSW7lcQ1dePX
         MbBTLR7KfpqiIVU7ks4647fktgn7jv0QcziwCURlFyNTL+TdFeUxhPkiSjUOB8kDiPoq
         Z4BdZvY1wgrrGkAgoCywv0m9GETTpT8MSlbXqQ6AOeEzxWKbvCxrpaJPjuoS7jhuCsJQ
         IAA2K6geM7NvUDVZgmQRz2aOlV5WXqrcCoAc8IrnK/sut7JvDqgpDE41cfree/fI6qe6
         l21yz5SSw2gM3lEJQScG2/bLTBw9KT/Kch9A0w40qq1pyU1uiTQvINzf/4ngHYKjPRYm
         7wrg==
X-Gm-Message-State: AGRZ1gK7O6b+ZVYcC1fv4RrDMRNHyZ7XN/Lpbv4qHD//njZu78FrtYse
        mxvSqS/wCordgi5aG74QeM1D6Q==
X-Google-Smtp-Source: AJdET5dQHmidbtAakfSLdXJQdD+u6AiivLS0XcExdf0bj9QD3WuNGSZZr4vdV5w7XMULevxHPtso3w==
X-Received: by 2002:a65:63d3:: with SMTP id n19mr3377444pgv.179.1541547952958;
        Tue, 06 Nov 2018 15:45:52 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id z2sm15440462pgu.4.2018.11.06.15.45.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 15:45:52 -0800 (PST)
Date:   Tue, 06 Nov 2018 15:45:52 -0800 (PST)
X-Google-Original-Date: Tue, 06 Nov 2018 15:41:54 PST (-0800)
Subject:     Re: [RFC 0/2] RISC-V: A proposal to add vendor-specific code
In-Reply-To: <20181105065807.GA1286@andestech.com>
CC:     aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        greentime@andestech.com, alankao@andestech.com,
        vincentc@andestech.com, zong@andestech.com, deanbo422@gmail.com,
        kito@andestech.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     vincentc@andestech.com
Message-ID: <mhng-611cf294-d378-466f-83eb-6c114c70c585@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 04 Nov 2018 22:58:07 PST (-0800), vincentc@andestech.com wrote:
> On Fri, Nov 02, 2018 at 01:48:57AM +0800, Karsten Merker wrote:
>> On Wed, Oct 31, 2018 at 10:27:05AM -0700, Palmer Dabbelt wrote:
>> > On Wed, 31 Oct 2018 04:16:10 PDT (-0700), anup@brainfault.org wrote:
>> > > On Wed, Oct 31, 2018 at 4:06 PM Vincent Chen <vincentc@andestech.com> wrote:
>> > > >
>> > > >   RISC-V permits each vendor to develop respective extension ISA based
>> > > > on RISC-V standard ISA. This means that these vendor-specific features
>> > > > may be compatible to their compiler and CPU. Therefore, each vendor may
>> > > > be considered a sub-architecture of RISC-V. Currently, vendors do not
>> > > > have the appropriate examples to add these specific features to the
>> > > > kernel. In this RFC set, we propose an infrastructure that vendor can
>> > > > easily hook their specific features into kernel. The first commit is
>> > > > the main body of this infrastructure. In the second commit, we provide
>> > > > a solution that allows dma_map_ops() to work without cache coherent
>> > > > agent support. Cache coherent agent is unsupported for low-end CPUs in
>> > > > the AndeStar RISC-V series. In order for Linux to run on these CPUs, we
>> > > > need this solution to overcome the limitation of cache coherent agent
>> > > > support. Hence, it also can be used as an example for the first commit.
>> > > >
>> > > >   I am glad to discuss any ideas, so if you have any idea, please give
>> > > > me some feedback.
>> > > >
>> > > I agree that we need a place for vendor-specific ISA extensions and
>> > > having vendor-specific directories is also good.
>> > >
>> > > What I don't support is the approach of having compile time selection
>> > > of vendor-specific ISA extension.
>> > >
>> > > We should have runtime probing for compatible vendor-specific ISA
>> > > extension. Also, it should be possible to link multiple vendor-specific
>> > > SA extensions to same kernel image. This way we can have a single
>> > > kernel image (along with various vendor-specific ISA extensions) which
>> > > works on variety of targets/hosts.
>> > >
>> > > As an example or runtime probing you can look at how IRQCHIP or
>> > > CLOCKSOURCE drivers are probed. The vendor-specific ISA extension
>> > > hooks should called in similar fashion.
>> >
>> > Yes, I agree.  My biggest concern here is that we ensure that
>> > one kernel can boot on implementations from all vendors.  I
>> > haven't had a chance to look at the patches yet, but it should
>> > be possible to:
>> >
>> > * Build a kernel that has vendor-specific code from multiple vendors.
>> > * Detect the implementation an run time and select the correct extra
>> >   code.
>>
>> From a distro point of view we definitely want to have one kernel
>> image that is bootable everywhere.  Debian won't support any
>> platform that requires a per-platform or per-vendor kernel, and I
>> assume that the same will be true for Fedora and Suse.
>>
>> One thing that I have stumbled upon while looking at the patches
>> is that they seem to assume that X-type ISA extensions are
>> strictly per vendor.  Although that is probably true in the
>> majority of cases, it doesn't necessarily have to be - I could
>> e.g. imagine that the DSP extensions from the PULP cores might
>> be used by multiple vendors.  If such an extension would have
>> state that needs to be saved on context switch, it would need
>> corresponding kernel support.  Using "PULP" (or any other
>> open-source project) as the vendor in such a case leads to
>> another potential issue: the patches base everything on a JEDEC
>> vendor ID that is compared to the contents of the mvendorid CSR,
>> but such a JEDEC vendor ID usually doesn't exist for open-source
>> implementations; the majority of those have mvendorid set to
>> zero.
>>
> Many thanks for kinds of comments. I quickly synthesize the comments and
> list them as below.
> 1. The kernel image shall include all vendor-specific code.
> 2. This kernel image can only enable particular vendor-specific features
>    based on the CPU vendor in the running platform.
>    - The runtime probing mechanism can refer to arm32/arm64, powerpc,
>      IRQCHIP driver or CLOCKSOURCE driver
>    - For some cases, such as open-source projects, using CSR $mvendorid
>      to identify the compatibility is not appropriate.
> I think the above requirements are reasonable, but I have questions about
> the first requirement in practice. As far as I know, vendors are allowed
> to add specific instructions and CSRs which are incompatible with other
> vendors to their own ISA extensions. If I understand the first requirement
> correctly, it implies that we need a "super" RISC-V toolchain. This "super"
> RISC-V toolchain should recognize all kinds of vendor-specific instructions
> and CSRs, so that it can compile vendor sources into objects successfully;
> then it should recognize all kinds of vendor-specific relocations, so that
> it can link the objects successfully. Each of them is not trivial at the
> time of this proposal and in foreseeable future.
>
> If it will take a long time to complete this "super" toolchain, I suppose
> the infrastructure in this RFC might be a temporary solution before it is
> ready. This scheme does not suffer the compilation problems caused by the
> lack of the super toolchain because the selection of vendor-specific ISA
> extension is determined at compile time. In addition, the mechanism for
> checking compatibility at runtime ensures that the kernel with
> vendor-specific feature runs on CPUs of other vendors just like pure
> RISC-V kernel. In other words, this scheme, to some extent, satisfies the
> requirements that one kernel image is bootable everywhere.

I don't want anything in the kernel that can't be compiled by upstream GCC, as 
that will be a huge mess.  As far as I'm concerned, the best way to move 
forward is to figure out how each style of extension can be integrated.  Right 
now, what I see is:

* Performance counters.  Here we should be safe, as there's an ISA-mandated 
  space in which to put non-standard performance counters.  The support here is 
  just figuring out how to interpret the bits.  This naturally fits into our 
  current device-tree based mechanisms for probing hardware, and will be easy 
  to maintain in the kernel.
* Cache management.  It appears these are currently being described as 
  instructions, which means they won't compile by default.  Here I think the 
  best bet is to rely on the SBI, and if that's too slow to build a "SBI VDSO" 
  mechanism to accelerate the relevant bits.  It is a bit of a headache, but 
  we're not going to have anything standardized here quickly.

If those are the only two concerns then I think we're OK.  Are there any other 
extension you're worried about?
