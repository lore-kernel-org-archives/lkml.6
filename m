Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F3DECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08CFA2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="c7be5jsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08CFA2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbeIQU1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:27:11 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:44037 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbeIQU1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:27:11 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 7b2c01c1;
        Mon, 17 Sep 2018 14:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=VgULI4ABLTWlhWCYmFeM3uz9LB4=; b=c7be5j
        sqaOuTZPB6WELnPWn8QPO5XWJrH2oGZ7ZaVf2pJZpQvodMbiXTw+7IMEpORQKWt7
        /xaP2jgi1cuSVPvaSI7WX8/jW110+aASYsEfBT4F0zh7iSB8p8/rmjhlVrylhHSK
        1TAgvldymhXdJZVZZi3o+52ge8bHTYEIuS1ULmfZ4P4RrN/F5FztHZYKoMazQfhS
        7IAYPA8tOaDI6er2Zv4xypMX+V3yncPBI7QEbjqz8hSeDHsJEb1LTnYeLogOcqMv
        xEtaOeNQFcK6Wu7FuVMJTa07NaxXVCG50GtBpDw9tMfQ4HoKlDAjCGLp36/5ALPT
        oNKLnUoXP1lrhhcQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e164a898 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Mon, 17 Sep 2018 14:41:57 +0000 (UTC)
Received: by mail-ot1-f51.google.com with SMTP id v44-v6so11593219ote.13;
        Mon, 17 Sep 2018 07:59:23 -0700 (PDT)
X-Gm-Message-State: APzg51B3k18eSiD86coBlH89fL32cPe7f7g5SWWuAq1/poKoePqqs4rp
        QNALw6bR10VU9WScHpIeJ4p/SviFi+RIM8lUr98=
X-Google-Smtp-Source: ANB0Vdax+p1BsGkvV+AdLShsUZOJgAgHQX2CuOy8FiBSrDy8udBmI5Q2Pfv96/WHkOP4Y1NYs/g65k8sn9CBd7+N+Hg=
X-Received: by 2002:a9d:6554:: with SMTP id q20-v6mr13071230otl.209.1537196362779;
 Mon, 17 Sep 2018 07:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180911214737.GA81235@gmail.com> <CAHmME9rFUruF-VN1pmU-k5nFsb9ppAPhPpW-5Ho9dKL2HCg4kA@mail.gmail.com>
 <20180911233015.GD11474@lunn.ch> <20180911.165739.2032677219588723041.davem@davemloft.net>
 <CALCETrXrJPcs3h9CtF50N4k2AGx3qzspJd_UW3t+KGYOj7+p=Q@mail.gmail.com>
 <CAHmME9ohGPTX-fkhP6zaWdx3SbkiqO5kWkWE-bDk=pm-nUqYvw@mail.gmail.com> <8937D6B1-D21C-4C47-8A89-A466CDB6FB04@amacapital.net>
In-Reply-To: <8937D6B1-D21C-4C47-8A89-A466CDB6FB04@amacapital.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 17 Sep 2018 16:59:11 +0200
X-Gmail-Original-Message-ID: <CAHmME9phB0iruUT0CDDzxkaVuW_Uvs0GL-+zOiTTXiDz+ARe4g@mail.gmail.com>
Message-ID: <CAHmME9phB0iruUT0CDDzxkaVuW_Uvs0GL-+zOiTTXiDz+ARe4g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Biggers <ebiggers@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 4:54 PM Andy Lutomirski <luto@amacapital.net> wrote:
> Ard, what do you think?  I think it would
> be nice, but if the authors of that assembly are convinced it should be replaced, then this step is optional IMO.

I just spent several hours reworking everything for ChaCha. That was
the easy one. Poly1305 will be much harder. Work in progress, I guess,
but erf it's rough.
