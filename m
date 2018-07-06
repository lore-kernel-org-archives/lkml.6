Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561E4C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176DC223B1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 176DC223B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934886AbeGFTeQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 15:34:16 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:37111 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934561AbeGFTeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 15:34:13 -0400
Received: by mail-qt0-f173.google.com with SMTP id a18-v6so10860177qtj.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 12:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CsQZiSgyXXUQVMADjLlymBSnkkoZaWw4LxKdkpj3rzw=;
        b=i0M0piMBYN1mxiJhvrK/myQTCX+viLnP3W2oXGoBszrNry90YkAUgqhz6xDMmMJMho
         nlvyFgSw/Xoiw7WRjt20EgsnEdLLQPW3Az7lyD5/5U+5g0ir8eFvjqcVv4HwN+5EuNNM
         W9obTk56VC8hl9bPutqEhcYkfchpwEOvdDJki0pRnNv4KvRYOr2iTEemrCZgXqk9HeIt
         E2XNbje9Fl2ybK0RJ7ix4nfh/2tZxOpHQwRR9SVHumc8Iboz+usau66fyHzvFRz3PI6a
         wAAV5nEz6WewataJg2GZDXb5pPJPp8XlFHIQDPf5GoMxRhJa3K95d8FQMXI+WQfIlKN1
         u1Yw==
X-Gm-Message-State: APt69E3EDBHznRL150ZMpt6/Fhcn+lF0aclFIsunJmwsKtdtNlHbxFcl
        QZJS1QTXZI4Ty+WW4BS3OSpLvg==
X-Google-Smtp-Source: AAOMgpeNsQZ8Zcjc2IgnvZXgjP5ZbYSVfTHORza7DWziocCUziKU8zvT2+wb829h6q+gGlQUNgCUOw==
X-Received: by 2002:a0c:b65a:: with SMTP id q26-v6mr10077861qvf.43.1530905652537;
        Fri, 06 Jul 2018 12:34:12 -0700 (PDT)
Received: from trogon.sfo.coreos.systems ([2604:2000:80c5:4400:140c:73de:b623:c90])
        by smtp.gmail.com with ESMTPSA id c20-v6sm2892234qtq.30.2018.07.06.12.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 12:34:10 -0700 (PDT)
Date:   Fri, 6 Jul 2018 15:34:08 -0400
From:   Benjamin Gilbert <bgilbert@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gabriel C <nix.or.die@gmail.com>, linux-x86_64@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        bero@lindev.ch, Michal Marek <michal.lkml@markovi.net>
Subject: Re: 4.17.x won't boot due to "x86/boot/compressed/64: Handle 5-level
 paging boot if kernel is above 4G"
Message-ID: <20180706193408.GA1705@trogon.sfo.coreos.systems>
References: <20180701213243.GA20180@trogon.sfo.coreos.systems>
 <CAEJqkghSELJRq7r_OrKvixxnT-rUncV==Ej1+jfYZvkMHz=o_w@mail.gmail.com>
 <20180703124403.veiak4vnbxtmwhv2@kshutemo-mobl1>
 <20180703142150.tqckl7miou3wf33q@kshutemo-mobl1>
 <20180704150857.szamkvy6jx3fqxlf@kshutemo-mobl1>
 <CAK7LNARMbt0h4WVdzPzKhMQD-M4ABjffjo4TdtK40RV-NGzTLw@mail.gmail.com>
 <20180706104144.6p2s43o3sqc6d5y3@kshutemo-mobl1>
 <CAK7LNAS9VuoUakpYEfdo5Bki4eic1QuruvNOfra8oUWUn0embA@mail.gmail.com>
 <20180706162928.73jfqtdwdcwtagui@kshutemo-mobl1>
 <20180706181110.GC25550@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706181110.GC25550@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 11:11:10AM -0700, Andi Kleen wrote:
> There are valid use cases to override the flags. I use it sometimes too,
> and know some other people do to.
> 
> But you need to know what you're doing. 
> 
> Perhaps a warning during build would be reasonable. So if you ask
> for a build log you would see it.

In our case, the package is presumably passing LDFLAGS="" to override the
LDFLAGS environment variable already set by the packaging system.  This has
worked for years without a problem.

--Benjamin Gilbert
