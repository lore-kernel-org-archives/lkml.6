Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A758C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAD220834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z4PXVjUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBAD220834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbeJYXW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:22:59 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:33299 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbeJYXW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:22:58 -0400
Received: by mail-lj1-f172.google.com with SMTP id z21-v6so8512537ljz.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 07:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OlhRKkndX/X/6C4UC85I7PIlW17/q6si5dLiEMfdmKU=;
        b=Z4PXVjUkWHkCD3a3/oVWKfTsyZYfe0ghq0y+OuCHFNpNc7LXg1qOEh5zpoQab1Qton
         lJHd7UO9zIo6Bv/qO/m61dsUty0NTJNnW77c4wV9ol+t4R3yKFWeThvS0voUqPKOXce1
         Butmo69xs68qJG3/VappF4kWxSGIPAsgXUe7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OlhRKkndX/X/6C4UC85I7PIlW17/q6si5dLiEMfdmKU=;
        b=RLMDA1optPZ/al9AzvjPOLhUxeNYcd8ZWD1DVJgk4dzmPbzHpqi1ALgR/AE5Y52aTB
         5qSr3V5K6EdCU/Dtg3ECS0C65kn7rLeuTdZ8jLrH0643ly0h3Vj9jpAuJ0jX//XNokpt
         Rnq0rjMogO04c7dzjLgkKFdnINU9l7i9ir2t5SBfeNQdPuViHdUUD+KOl3XCdsh+oM2q
         s692A1NsKEdcsG5A5WIudN+71rVlBJbF564Q0tWwqhOLE2suqecyIDKa59fte8yleUzE
         19IM//OXT7ztHhDYfyWCzPo0nx0MAyqD+QKPIxlgHa2EEfK+QxwYlbb5+OtutV8wUwLH
         PYcQ==
X-Gm-Message-State: AGRZ1gJvNRO/sgyirOghxiw4byCoyzVWTKjUiA6CCmfZ26QHerpgZMSG
        3RB/3+9SAKRiJ3pmcL24zhJMDSKentAIx1eN
X-Google-Smtp-Source: AJdET5dxa0SkETcGWMgYVj9zWMczAyOB631uklbwH/hXzafASaWCYXD/b7E15/u7qjGhtAsfugCgnA==
X-Received: by 2002:a2e:1b47:: with SMTP id b68-v6mr1335029ljb.104.1540478989609;
        Thu, 25 Oct 2018 07:49:49 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id h21-v6sm1301501lfh.38.2018.10.25.07.49.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 07:49:48 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id y22-v6so1874681lji.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 07:49:48 -0700 (PDT)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr1487171ljh.59.1540478988114;
 Thu, 25 Oct 2018 07:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <1540378751.3008.59.camel@HansenPartnership.com>
In-Reply-To: <1540378751.3008.59.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Oct 2018 07:49:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2CFSmAFSacKfJx+O+9kb0C35F1UH5G_kY608baW-2GQ@mail.gmail.com>
Message-ID: <CAHk-=wj2CFSmAFSacKfJx+O+9kb0C35F1UH5G_kY608baW-2GQ@mail.gmail.com>
Subject: Re: [GIT PULL] first round of SCSI updates for the 4.19+ merge window
To:     James.Bottomley@hansenpartnership.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 3:59 AM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> This is mostly updates of the usual drivers:  [...]

Hmm. No diffstat?

The shortlog matches, but I really prefer seeing what the diffstat is
too and confirm that part.

Anyway, pulled,

                    Linus
