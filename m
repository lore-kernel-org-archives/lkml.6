Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D00FC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D9925FD4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D9925FD4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964830AbeFYRvB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:51:01 -0400
Received: from smtprelay0010.hostedemail.com ([216.40.44.10]:52982 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755488AbeFYRu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:50:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id E8878837F24A;
        Mon, 25 Jun 2018 17:50:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: soap49_85906d6d5222
X-Filterd-Recvd-Size: 2265
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Jun 2018 17:50:57 +0000 (UTC)
Message-ID: <3b61527dd119e0ab1025e9e36f666e74a336b180.camel@perches.com>
Subject: Re: [PATCH v2] kvm: x86: mmu: Add cast to negated bitmasks in
 update_permission_bitmask()
From:   Joe Perches <joe@perches.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 25 Jun 2018 10:50:55 -0700
In-Reply-To: <20180625173502.GD129942@google.com>
References: <20180619192504.180479-1-mka@chromium.org>
         <4dd99306-4fea-24b2-4bea-5b7927ea5e79@redhat.com>
         <20180625173502.GD129942@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-25 at 10:35 -0700, Matthias Kaehlcke wrote:
> Some other instances of the warning that have been addressed are:
> commit 644d87dccdc69cf79834a72ed0c889580d6af32a
> commit e2a5dca753d1cdc3212519023ed8a13e13f5495b
> commit dae1a432ab1fe79ae53129ededeaece35a2dc14d
> commit d1600401faad4bc186bfdb291d8af644465e20bd
> commit a45463cbf3f9dcdae683033c256f50bded513d6a
 
I think all these implicit conversion warnings are senseless
and should really be silenced by setting them only to be
output at W=3 with all the other non-static and generally
unnecessary signed/unsigned conversions

---
 scripts/Makefile.extrawarn | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 8d5357053f86..9b1d0d59e8d0 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -46,6 +46,7 @@ warning-2 += $(call cc-option, -Wunused-macros)
 warning-3 := -Wbad-function-cast
 warning-3 += -Wcast-qual
 warning-3 += -Wconversion
+warning-3 += $(call cc-option -Wconstant-conversion)
 warning-3 += -Wpacked
 warning-3 += -Wpadded
 warning-3 += -Wpointer-arith
