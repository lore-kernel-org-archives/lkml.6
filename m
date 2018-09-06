Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063E2C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C2C20857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="k6pkK116"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C2C20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbeIFOUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 10:20:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39769 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbeIFOUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 10:20:06 -0400
Received: by mail-wm0-f67.google.com with SMTP id q8-v6so10560152wmq.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 02:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=u0lfzEM6OKUDa2ZxzUSTFZCtfnqL+76LEzTwJAF+FFk=;
        b=k6pkK116ukq13kcMlzeyfmDiLn60xbMWCv/3PAJYa4R+sXoi8CVeCa5kFHeGKKDJJR
         uTQB87XjAYI6yvUc0tA1UfTwTI2tRC+DoMvkmOOs6IPhoPOczaMgI6wtRo0EG9zCLVcc
         aJO5LRrhHxaFRPTJ83zkBevpzJcB4h3QU4axWQsX5D1jwhTM1iy55+DyKEjLYsWXpC9t
         AEqfzDwPjntKSWYzKRrSw8jQR2QgCu6615OiPj9qj7vTSMCFtdsCCjrxOleqyJPjcsHP
         vP/9hp8J4SwbCJOoeLIPdjkHgrZ2ABlssYeIM0xWXQUsAkw7HaeBTGB+kjcP0omJ3rjw
         L3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=u0lfzEM6OKUDa2ZxzUSTFZCtfnqL+76LEzTwJAF+FFk=;
        b=pOq3ic0NDtyP8U7SPFu/miAFpereU6Uq6kr4dNlEyXE2gz36RQMAjXiEJT03YPUJsj
         FzuP0yrLeh85EeYLjphgToHXzY07YcTGNXsyww4ZTVU18c2t0A+IUbjcH1J0iTYou0SO
         TssBA/um/L1K9QUl3qL5O0omIOYkZDHbGPKLR/RrNLpS+c/AR4DieYzIyq/Gw37dokQX
         MSpT2aA3BN7scv4rov1AHmcKKKUIa0Qnjw/9+0iF9EHP7INrrRbFTe8iUkMZxTNfEWhU
         0/ETKXiXXPNU54QWEltgCZ9XDYcGWGczLO5fVr9Xd008KAewsLdR4W9ymCahTTlKxkCx
         EYyQ==
X-Gm-Message-State: APzg51C1+i21RBsprAyr7+SXOboNQ1KUoTCf5Lw63CidUScBV7WNOgUa
        Mo0kzDSV0DpxSX1FxnqywoB/Sg==
X-Google-Smtp-Source: ANB0VdY4HpFgC42YSfsXcojvdj5KfvIJYhAYBAyOtf7Kl81e1/gdFQR2wA/kMjGm3Qhtatetc02e4g==
X-Received: by 2002:a1c:14c3:: with SMTP id 186-v6mr1496022wmu.21.1536227126959;
        Thu, 06 Sep 2018 02:45:26 -0700 (PDT)
Received: from localhost (smb-adpcdg1-01.hotspot.hub-one.net. [213.174.99.129])
        by smtp.gmail.com with ESMTPSA id k13-v6sm3426199wrq.7.2018.09.06.02.45.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 02:45:26 -0700 (PDT)
Date:   Thu, 06 Sep 2018 02:45:26 -0700 (PDT)
X-Google-Original-Date: Thu, 06 Sep 2018 01:03:33 PDT (-0700)
Subject:     Re: [RFC PATCH 1/5] RISC-V: Make IPI triggering flexible
In-Reply-To: <20180904185001.GA25119@infradead.org>
CC:     aou@eecs.berkeley.edu, daniel.lezcano@linaro.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        atish.patra@wdc.com, Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@infradead.org>, anup@brainfault.org
Message-ID: <mhng-ba039ed5-dcff-41d3-b237-0708b5e117b2@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Sep 2018 11:50:02 PDT (-0700), Christoph Hellwig wrote:
> On Tue, Sep 04, 2018 at 06:15:10PM +0530, Anup Patel wrote:
>> The mechanism to trigger IPI is generally part of interrupt-controller
>> driver for various architectures. On RISC-V, we have an option to trigger
>> IPI using SBI or SOC vendor can implement RISC-V CPU where IPI will be
>> triggered using SOC interrupt-controller (e.g. custom PLIC).
>
> Which is exactly what we want to avoid, and should not make it easy.
>
> The last thing we need is non-standard whacky IPI mechanisms, and
> that is why we habe SBI calls for it.  I think we should simply
> stat that if an RISC-V cpu design bypasse the SBI for no good reason
> we'll simply not support it.

I agree.  Hiding this sort of stuff is the whole point of the SBI.

Anup: do you have some concrete reason for trying to avoid the SBI?  If it's 
just to add non-standard interrupt controllers then I don't think that's a 
sufficient reason, as you can just add support for whatever the non-standard 
interrupt mechanism is in the SBI implementation -- that's what we're doing 
with BBL's CLINT driver, though there's not a whole lot of wackiness there so 
at least the SBI implementation is pretty small.

> So NAK for this patch.

Certainly without a compelling reason, and even then I'd only want to take some 
standard interrupt controller -- for example, the CLIC (or whatever the result 
of the fast interrupts task group is called) could be a viable option.  Even 
with a standard interrupt controller, we'd need a really compelling reason to 
do so.
