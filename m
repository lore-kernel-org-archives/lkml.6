Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAFAC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 22:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B5F82173B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 22:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Oym7T3hR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfADWqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 17:46:55 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37946 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfADWqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 17:46:55 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so18913018pfi.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 14:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=LRY8C7wucfF/B/r5Qck4+abP1qaq8PZ2hb27AmRVcRY=;
        b=Oym7T3hRS8UnLGxENZoHx9nleXmgJlHuk1zs+xwJEMXim9Mcy3/9KdDuOiiKXdGofS
         zu+SVZjS+3tB+bxH7Qg8fn9URCwXfv7UmI8YCcD0EEVwU7YMqlHiYJGqBuuYsMe3gpkO
         vbcSXR6TjSmOKk31I9bZ3dw/MBqoO1EA9iv8FzkMR56rGHYMVtX63Mw8xcBQfi8mYuxb
         VAH8/RBFAqDbDiYgkD0s9+cbl0RIeVmqzRhlaBICRTynfvdKN+qVls6ZoB8taT1HCyl4
         QRfIKPTB7ot/5Fwkwgp32HKKOpLhp06kNrY5lWz/UaYGPmryRhJni0pz5QilxVUQpyw6
         GHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=LRY8C7wucfF/B/r5Qck4+abP1qaq8PZ2hb27AmRVcRY=;
        b=EroHB1uvjbyhD0lQn5YvzRln1z0HYF/Ia/9PWlis/EkClf26PiHchAJUrr9vZJ2fyc
         z1y/dvcU7Dw48hF6KIpeNAKuxRlUV6md6q32WHal7AkEvC/IhNEd2rer+1uuaoTEvaWU
         yh+ifIHmzg2RX0Wj682zQ7fRj1slDpVqnT36x/hs7/edywh0iBaAF1kpFMjs8FkzxSG3
         W2sIgHd7FQnXzK2cpzgXcF/RFbfI2aGGkd0PDv0WlIdfa1QLzrOl2uynrK0np6xC7Xfc
         6W+ufGffo7L8/pngtkv1ZfJPptzDJ81cAqtjxk7Hl1tKhi5bJx5AXdo7ARG3vaxM3FES
         mCBw==
X-Gm-Message-State: AJcUukd/JgRcFEcXhxElFUakwFhv3v7QPJ+YcUXHWNSXKAsAZaxh3/tc
        FHwy5+TxC4acIMm3Qha4Tjd9qw==
X-Google-Smtp-Source: ALg8bN46pet05eyEz7IC11sFR9391SdiwJOxH/CsYO6MAAskxf6IV6l6F3gVqEk6GbUn3kc1y/nqog==
X-Received: by 2002:a63:6f0d:: with SMTP id k13mr3100518pgc.42.1546642013905;
        Fri, 04 Jan 2019 14:46:53 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id z186sm91085267pfz.119.2019.01.04.14.46.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 14:46:52 -0800 (PST)
Date:   Fri, 04 Jan 2019 14:46:52 -0800 (PST)
X-Google-Original-Date: Fri, 04 Jan 2019 14:35:01 PST (-0800)
Subject:     Re: [PATCH 3/7] dt-bindings: riscv: cpus: add E51 cores to the list of documented CPUs
In-Reply-To: <20181220210141.GA17198@bogus>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        mark.rutland@arm.com, aou@eecs.berkeley.edu,
        devicetree@vger.kernel.org, paul@pwsan.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     robh@kernel.org
Message-ID: <mhng-199961ff-1c6e-41f4-b7e4-66c1bbba15e3@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2018 13:01:41 PST (-0800), robh@kernel.org wrote:
> On Fri, Dec 14, 2018 at 09:21:50PM -0800, Paul Walmsley wrote:
>> Add compatible strings for the SiFive E51 family of CPU cores to the
>> RISC-V CPU compatible string documentation.  The E51 CPU core is
>> described in:
>>
>> https://static.dev.sifive.com/FU540-C000-v1.0.pdf
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Palmer Dabbelt <palmer@sifive.com>
>> Cc: Albert Ou <aou@eecs.berkeley.edu>
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-riscv@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
>> Signed-off-by: Paul Walmsley <paul@pwsan.com>
>> ---
>>  Documentation/devicetree/bindings/riscv/cpus.txt | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/riscv/cpus.txt b/Documentation/devicetree/bindings/riscv/cpus.txt
>> index adf7b7af5dc3..fb9d4f86f41f 100644
>> --- a/Documentation/devicetree/bindings/riscv/cpus.txt
>> +++ b/Documentation/devicetree/bindings/riscv/cpus.txt
>> @@ -68,8 +68,9 @@ described below.
>>          - compatible:
>>                  Usage: required
>>                  Value type: <stringlist>
>> -                Definition: must contain "riscv", may contain one of
>> -                            "sifive,rocket0"
>> +                Definition: must contain "riscv", may contain one or
>> +			    more of "sifive,rocket0", "sifive,e51",
>> +			    "sifive,e5"
>
> I can't really tell what are valid combinations from this. It reads that
> I could list every string here and that would be valid. It is basically
> 'riscv' plus any other combinations of strings.

I think that's actually the correct interpretation: if it's a RISC-V CPU then 
it must have "riscv" listed in compatible, but it can also be anything else.  
There's some concrete examples here (a "sifive,e51" is a type of "riscv"), but 
I don't think it's realistic to count on us being able to enumerate all RISC-V 
implementations here.
