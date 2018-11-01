Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39813C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072422082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Z41bLBSy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 072422082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbeKBCyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 22:54:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44170 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727465AbeKBCyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 22:54:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id w3-v6so9349451pgs.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 10:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=GFlRgMZkJ4YMHOMTHBQoUQxMJc7k1tC+EcFFH8tZutg=;
        b=Z41bLBSysABsyy3IHVEJQzoULwqyc7jqXN9vEKH2igPsZdi+icv34TVdjtHQvBO+H6
         Q+bovyQIsXPKifThtKOnL7+5S82ju/4mEOunOz33ariVVn9WAg5n7hEEwqsLObjwrRqi
         FGfHxCI8l81g8Jec6j82EThH6FYowKHNi/7j607WNt9ydRTKHvJwp881H67qIGkfDMg7
         r7Rh7bI1GMlEJVmmxnIxW5lpHrm6zSqOwwmbg5YH2IydUa6RgOJXHNbabwBR6fhk8iOL
         ObOKPyG1UIR9YXYL6zA9VO7mIz4KtPq6zbsT4cirJHaKqar4FqS8EsmTb429KQNXAJci
         BJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=GFlRgMZkJ4YMHOMTHBQoUQxMJc7k1tC+EcFFH8tZutg=;
        b=OaMnzlf3TEj5ScDnPBCUOBqBmTTQG3CGwfViVZlW5aDnCpFjy7gvITad5AwgL4sN61
         E6S22Edbp5pfu9wXcxMc3VrsLR+B43GhgXm/5f7EZMD+9OJXy1q9BU7fJwj7Y54KCHI9
         JysXThEA1pQ5paUfzUIkRXFoxbsLA3n2q5voOpQbymiGV/ewP1ApC2hNSwHghk4Pl6io
         Q81kzq8XMk5cfJVPHqNoGSPIi3Jzb4uvOYpOFRTpGBsq+1zMmg/u6dHI1bYcw/PpPaMZ
         P0EyxPT0vE6DL7wCvt1pcm12BJoZ4KGnYXqZHcx+313bxEoteRjGPeN2m5bHKp1cYxLa
         ZvSQ==
X-Gm-Message-State: AGRZ1gLx4n/z6PfpsmFOq+64IUMcU4feyJaBB4yxVLnmUPAST1EDg3Mn
        areui7xQ0JRdt98Ymdmqm+WvFg==
X-Google-Smtp-Source: AJdET5cwpGuphfqFHjwbJ1QEYaAwcz2T8I+FVV0Fyo/MlNFeaCjpgqRMaxBaL6OvADbL8iTngeip1w==
X-Received: by 2002:a63:6ac5:: with SMTP id f188mr8071804pgc.165.1541094605708;
        Thu, 01 Nov 2018 10:50:05 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id m20-v6sm38421157pfj.171.2018.11.01.10.50.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 10:50:04 -0700 (PDT)
Date:   Thu, 01 Nov 2018 10:50:04 -0700 (PDT)
X-Google-Original-Date: Thu, 01 Nov 2018 10:49:38 PDT (-0700)
Subject:     Re: [RFC 0/2] RISC-V: A proposal to add vendor-specific code
In-Reply-To: <20181101005541.GA25604@andestech.com>
CC:     Christoph Hellwig <hch@infradead.org>, anup@brainfault.org,
        zong@andestech.com, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, greentime@andestech.com,
        linux-kernel@vger.kernel.org, vincentc@andestech.com,
        linux-riscv@lists.infradead.org, deanbo422@gmail.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     alankao@andestech.com
Message-ID: <mhng-22ded2c8-7f87-4acc-b017-627e369cf874@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2018 17:55:42 PDT (-0700), alankao@andestech.com wrote:
> On Wed, Oct 31, 2018 at 07:17:45AM -0700, Christoph Hellwig wrote:
>> On Wed, Oct 31, 2018 at 04:46:10PM +0530, Anup Patel wrote:
>> > I agree that we need a place for vendor-specific ISA extensions and
>> > having vendor-specific directories is also good.
>>
>> The only sensible answer is that we should not allow vendor specific
>> extensions in the kernel at all.  ...
>
> How can this even be possible if a extension includes an extra register
> set as some domain-specific context?  In such a case, kernel should
> at least process the context during any context switch, just like how it
> deals with the FP context.

Ya, I think there are cases where vendor-specific extensions are going to be 
necessary to handle within the kernel.  Right now the only one I can think of 
is the performance counter stuff, where we explicitly allow vendor-specific 
counters as part of the ISA spec.

For stateful extensions, we currently have a standard mechanism where the XS 
bits get set in sstatus and the actual save/restore code is hidden behind an 
SBI call.  That call doesn't currently exist, but if we just go ahead and add 
one it should be easy to support this from within Linux.  We'll need to figure 
out how to enable these custom extensions from userspace, but that seems 
tractable as well.  We'll probably also want some fast-path for the V extension 
(and any other stateful standard extensions), but I think as long as the V 
extension adds a quick check for dirtiness then it's not a big deal.

Do you guys have stateful extensions?  We're trying really hard to avoid them 
at SiFive because they're a huge headache, so unless there's a compelling base 
of software using one I don't want to go add support if we can avoid it.
