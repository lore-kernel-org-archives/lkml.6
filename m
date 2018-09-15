Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916F8ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 20:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4979320881
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 20:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NpyyLvDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4979320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeIPBV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 21:21:27 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:55255 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727549AbeIPBV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 21:21:27 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 0fa60e04;
        Sat, 15 Sep 2018 19:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type:content-transfer-encoding; s=mail; bh=ATAmQmLySA/+
        fJwznGGRFL0BNoE=; b=NpyyLvDzTRQ4qFRuHIE3eHoy1c2/TvhxeAqxj+aPFu9N
        2r2jDnaUufbe0g8esDDAZWqf6cVHWxMf9vjNGEfZNIGCtl2JcaCyY+iqZDRzOngN
        Hb/3jdNoM5qZDxBzQBZcLVJfi3+c+LKlNFffTymp8ttaznA2MX5fbz6Sp4aeTV1w
        lC7kJSJ2i6iCkVwaFHuRAM37p51gqY0Wyj2sNH2cMGsdxKVoEJjkVgtqQMcZVZxc
        Va0k7p9REcZ/cSViTs9oR2tLGStpVwzJ8seJHSHKCJu91fETQANZjCVXJ4YG+f6Z
        Pyz9VDIurHRyX9we1yQxMkqBMT8TWcjSGasYIiFlrw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8c940cc2 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Sat, 15 Sep 2018 19:44:04 +0000 (UTC)
Received: by mail-oi0-f50.google.com with SMTP id x197-v6so15734307oix.5;
        Sat, 15 Sep 2018 13:01:16 -0700 (PDT)
X-Gm-Message-State: APzg51CS5KxEMHnn23wRYWBliWKaGnL2NQHm8p5qVR/Voiymqhg3+xQW
        /5S2AmiArDtqLoMzA5iGtGiibnIPeqME6bJ7UJo=
X-Google-Smtp-Source: ANB0VdYyLAfypqOADhKq/uh/Dcz2Bw5Oeua3XK4RFqDzY62c58vCRR4ySlr49yF0NQ/5o6NALbGVnVMXpwSMLFjmFHk=
X-Received: by 2002:a54:4f88:: with SMTP id g8-v6mr13305191oiy.191.1537041675806;
 Sat, 15 Sep 2018 13:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-2-Jason@zx2c4.com>
 <20180912061433.GA8484@ip-172-31-15-78> <CAHmME9pmgu_xWJ0rvdS4RhzwjKPiNdkQ9nc6mqTNeb6A8xT8Eg@mail.gmail.com>
 <20180913050301.GA26367@ip-172-31-15-78> <CAHmME9rMg_2eHBnfP6j9Y3O7-At90HF=ToTWeFL_Qc4nGURORg@mail.gmail.com>
 <61B4DFD6-9BB5-4B81-BD0E-ACF112EA8AF7@amacapital.net>
In-Reply-To: <61B4DFD6-9BB5-4B81-BD0E-ACF112EA8AF7@amacapital.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 15 Sep 2018 22:01:04 +0200
X-Gmail-Original-Message-ID: <CAHmME9o5zaJOHGrYtS8kof-PDKbUYNfU8t=b-oEZg02evML0qw@mail.gmail.com>
Message-ID: <CAHmME9o5zaJOHGrYtS8kof-PDKbUYNfU8t=b-oEZg02evML0qw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 01/17] asm: simd context helper API
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     kevin@guarana.org, Andrew Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 15, 2018 at 9:58 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
> I have no strong opinion, except that, if you paint the bikeshed =E2=80=
=9Cpass by value=E2=80=9D, then simd_get and simd_relax should probably hav=
e warn_unused_result set.

Good idea.
