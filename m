Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0B8C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B476020C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="PVBlHtMp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B476020C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731122AbeIMTCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:02:50 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:38403 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730002AbeIMTCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:02:50 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id b720f8d6;
        Thu, 13 Sep 2018 13:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=nKAnQ8xSc7buMx5+dgRRMAxskA4=; b=PVBlHt
        Mp1inSPeaNTY/4TbGKeOgZUFty+4tEaFtXqbNziG7CvxTIxCXU4/muNXE5J2qd0B
        kzB1i3nFvWmZoQ4i5ZyZqlKGdkdj1auZc1U/EZPda1sHBJsKYGfCBTqpvo0y55bo
        k2fXaaLwbzFrQcilwyoaLOmtMlFx091gxtWWATonFFCYWEB9eaFrWF2uiArRSves
        nOsbKUQTTtgtaE3F3nJyxBink5O3C4IOtGqPRU6oG3trDQQwq6qgkGGiYSZBuP2b
        6YWOenL4JPlx9vOOs+v08K+d2ugc8PpLbCzPZuadn2FF2Ob+doy9Xp3Lce5foUEk
        UYKdTzkSuf32Kx6g==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c170e193 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Thu, 13 Sep 2018 13:36:18 +0000 (UTC)
Received: by mail-oi0-f44.google.com with SMTP id c190-v6so9477310oig.6;
        Thu, 13 Sep 2018 06:53:13 -0700 (PDT)
X-Gm-Message-State: APzg51Blsl9y9khh4spOqt6ZQlfBIFJRtgvjgI/Dp4TdR3ueueaXBEjg
        AqIbnyY1xj7QgElsmYnGa/+8A1xbNGyT0bJDQg8=
X-Google-Smtp-Source: ANB0VdYhPp4zGiZXzdSnv2dL1Ih9HxcmBFPGKZnRmrcRPw+bKiJ7XMCPsguSg11hID6mBpUxxKjHDBHw9HnWUxhwJO4=
X-Received: by 2002:aca:b641:: with SMTP id g62-v6mr6225370oif.71.1536846792598;
 Thu, 13 Sep 2018 06:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-2-Jason@zx2c4.com>
 <20180912061433.GA8484@ip-172-31-15-78> <CAHmME9pmgu_xWJ0rvdS4RhzwjKPiNdkQ9nc6mqTNeb6A8xT8Eg@mail.gmail.com>
 <20180913050301.GA26367@ip-172-31-15-78> <CAHmME9rMg_2eHBnfP6j9Y3O7-At90HF=ToTWeFL_Qc4nGURORg@mail.gmail.com>
In-Reply-To: <CAHmME9rMg_2eHBnfP6j9Y3O7-At90HF=ToTWeFL_Qc4nGURORg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 13 Sep 2018 15:53:01 +0200
X-Gmail-Original-Message-ID: <CAHmME9oURsx=8HY1TRkFPEV1-qPUc03FF8stM20b8WzpnXVnOg@mail.gmail.com>
Message-ID: <CAHmME9oURsx=8HY1TRkFPEV1-qPUc03FF8stM20b8WzpnXVnOg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 01/17] asm: simd context helper API
To:     kevin@guarana.org, Andrew Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 3:52 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> simd_put();
Rather, simd_put(simd_context);
