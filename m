Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A66C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C373920836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C373920836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754139AbeFTASL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:18:11 -0400
Received: from smtprelay0174.hostedemail.com ([216.40.44.174]:50185 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753644AbeFTASG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:18:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 4B149100E806B;
        Wed, 20 Jun 2018 00:18:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: car11_80970b6b9353a
X-Filterd-Recvd-Size: 2099
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Wed, 20 Jun 2018 00:18:03 +0000 (UTC)
Message-ID: <366638527170f814bbe98f7189900ebf6c04d007.camel@perches.com>
Subject: Re: [PATCH] kvm: x86: mmu: Add cast to negated bitmasks in
 update_permission_bitmask()
From:   Joe Perches <joe@perches.com>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>, rkrcmar@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com,
        x86@kernel.org, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 19 Jun 2018 17:18:02 -0700
In-Reply-To: <20180619234543.GG169030@google.com>
References: <CAKwvOdkv7D8b+apFXUdv_hwJDoWZtUJUTSF2BEzxbMzLVreG6g@mail.gmail.com>
         <ffe4b263-8a8d-c8ed-7ba1-ca55600ab273@redhat.com>
         <CAKwvOdnhPCDRFMhYiAr2kSCDWrL_gaY8c6XHJ96PupcN-wcDpQ@mail.gmail.com>
         <ad7a9addf043ee7fda8907eff9f83c9709b575dc.camel@perches.com>
         <d6a99e26-b100-715b-2615-b77259ec8397@redhat.com>
         <66b5e5c3ed82a5e1559419deb841c57bf0751fd3.camel@perches.com>
         <20180619183622.GB169030@google.com>
         <7547dfd4045a5acf23505887065bc228e65f2ff9.camel@perches.com>
         <20180619211019.GE169030@google.com>
         <951ccf2a257fb8f8827f88e1c17ce64d23173e94.camel@perches.com>
         <20180619234543.GG169030@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-19 at 16:45 -0700, Matthias Kaehlcke wrote:
> On Tue, Jun 19, 2018 at 02:55:05PM -0700, Joe Perches wrote:
> > Well, you advocate to disable a possibly useful warning globally ...
> > You're advocating for making the code more complex/ugly for a
> > condition where the result is identical.
> My goal is no to make the code (slightly) more complex/ugly but have
> the rest of the kernel benefit from a possibly useful warning.

For what case in the kernel is this warning useful?

