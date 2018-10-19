Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F083ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF37B21476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9QiWml4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF37B21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeJSPtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 11:49:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35575 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbeJSPtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 11:49:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id w5-v6so36307657wrt.2;
        Fri, 19 Oct 2018 00:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zEyCDVZpIEmgAea9YYP1epJ1TMWaKZP/TxnPbG8DVn0=;
        b=L9QiWml4iFOtS2TZGRcpegBVzimrjUvOFuh72tN/dkAdZ+3Cli+5QxRF+iWf/i+0HH
         5YK5fPoIjlJD/EevHhlzJR5NXkOkhiovY/dM8IxkzV8F8rYq8nwlWM06tmM4jHDOvvX2
         nobOEiSl2ehW+t+XckkgGcmsWZX+B1PtxD/vNLJ0hbZzCN9dVy7qYPcR3uZO8mUmesD2
         uyhl6Ws4Fztyi+bLW8MIN+5TouUTlleF4Wewe2QGhQpaZt4c2tWPrZA6zrT3WhZa7Z3C
         z2M5xVOg5ZVZ0vCmkaTdaGM+syVZrevmITEjYa3d1THNuse/KG2jWmPpwNsxbR2eyoac
         9rvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zEyCDVZpIEmgAea9YYP1epJ1TMWaKZP/TxnPbG8DVn0=;
        b=ETQoaciKP0bfacbFiIu0r/2tgjnV1DmKManGP+yF06hSSwnytCbvu0I6kEpTNMGHyA
         0xU3Qc3xTu07ZmG6fzGLmdILCUkiQpHPjV24w20/FMrAJJi9/xGK40WiQplEl8d6q7ft
         cvZp71CUnCS2zb3F1znI1IVrsElXwTg2Le5xoipqckOjzR0E77put4pHpMNEQtEmLdPA
         vXUEsR/osrG9hXS8u2wFInGeidrs0d7lTAxLiyLu+hhb+0gNhSOQx1bk2AH3ZIyvfJMV
         9ck49Q9pGdhGhyl0gHRPLCri2jss9ff1gRY4kCFXcxZu1z+E52m0CPDLQMcuQB5mbTQc
         LdzA==
X-Gm-Message-State: AGRZ1gINHO0D/1xVfhHi8L3j7RUMFQu12pCDARUcVx228mUUIqbkZLEl
        Eigsy35WhvtFxAXu3VoxedM=
X-Google-Smtp-Source: AJdET5euewxWTYRPLosWgeJmljk+2LOND5mu3jhYJBL4LX7B6stbM/g5ODF7XvChWnjAWIFZ95vrSA==
X-Received: by 2002:adf:9246:: with SMTP id 64-v6mr817413wrj.130.1539935061607;
        Fri, 19 Oct 2018 00:44:21 -0700 (PDT)
Received: from [192.168.10.150] (dynamic-adsl-78-12-231-174.clienti.tiscali.it. [78.12.231.174])
        by smtp.googlemail.com with ESMTPSA id r131-v6sm3741153wmb.32.2018.10.19.00.44.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 00:44:20 -0700 (PDT)
Subject: Re: [PATCH 05/11] x86/fpu: set PKRU state for kernel threads
To:     Andy Lutomirski <luto@amacapital.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>
References: <20181004140547.13014-1-bigeasy@linutronix.de>
 <20181004140547.13014-6-bigeasy@linutronix.de>
 <39e0a55f-4920-cfde-9bef-09c51109d211@linux.intel.com>
 <CALCETrUdxsFA5g0M9uRFktfdi=mxK_g3kBfs-VxwDZ0xWqjFAQ@mail.gmail.com>
 <20181018162644.qqjkzoqn2fleyi2b@linutronix.de>
 <CC7B46F7-7A6E-4CAF-A1EB-91271CC7B092@amacapital.net>
 <20181018182538.vgotfpsdy7qxl2tg@linutronix.de>
 <CALCETrVjEOkNhdyAF10PaYi_rnFUWKRqPhLRCq3ZV=gxQFETxg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Message-ID: <2fe82232-4e80-8317-757c-d2235c4633d8@redhat.com>
Date:   Fri, 19 Oct 2018 09:44:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CALCETrVjEOkNhdyAF10PaYi_rnFUWKRqPhLRCq3ZV=gxQFETxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2018 22:46, Andy Lutomirski wrote:
>> [0] drivers/usb/gadget/function/f_fs.c::ffs_user_copy_worker()
>>
>> Sebastian
> I think we need an entirely new API:
> 
> user_mm_ctx_t ctx = user_mm_ctx_get();
> 
> ...
> 
> use_user_mm_ctx(ctx);
> unuse_user_mm_ctx(ctx);
> 
> ...
> 
> user_mm_ctx_put(ctx);
> 
> and ctx will store a copy of mm and PKRU.
> 

That looks like a good API in general.  The ffs_user_copy_worker that
Sebastian mentioned seems to be used by AIO, in which case of course it
has to happen in a kernel thread.

But while the API is good, deciding on the desired semantics is
"interesting".  The submitting thread might be changing PKRU between the
time the I/O operation is submitted and the time it is completed, for
example.  You could look up the task's PKRU at use_mm time, except that
the task might have disappeared...  In the end just using PKRU=0 makes
some sense and it only should be documented that some kernel services
will ignore PKRU.

Paolo
