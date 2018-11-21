Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEBCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FED6214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="iXmVwQ1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FED6214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbeKUXk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:40:59 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54852 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728243AbeKUXk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 18:40:59 -0500
Received: from [10.38.211.137] (x59cc8b89.dyn.telefonica.de [89.204.139.137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6CBE11EC0319;
        Wed, 21 Nov 2018 14:06:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1542805599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Zhwxe3g2Sf3MfXxQLYjVzm6l1DmcrZp6x2Y1QfMO/U=;
        b=iXmVwQ1ZCMS1keMtwWeVlBAzeeEu/uqHfun/d30Tw1xW7znMMIPuBIp/2zuktB73Btj+K5
        uUgeQf7McpJ3mrbeNy1ME7oBuTtj9bk8uOzRlZFz0wmNtV7eFDao5i/N3LttwBnklUDya8
        vLkhpWfbHfX6wmfygm2Jz/G9/nhB1pU=
Date:   Wed, 21 Nov 2018 14:06:22 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <ddeff176-2517-4b58-73b6-3787e84b2a5e@redhat.com>
References: <20181114072926.13312-1-lijiang@redhat.com> <20181114072926.13312-2-lijiang@redhat.com> <20181114112600.GD13926@zn.tnic> <9eb61523-7a08-24c4-ac15-050537bd9203@redhat.com> <20181115103959.GB26448@zn.tnic> <c3347d48-aa32-e8e4-c99b-baf2e6a21dc2@redhat.com> <20181118115251.GB19380@zn.tnic> <ddeff176-2517-4b58-73b6-3787e84b2a5e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2 v6] x86/kexec_file: add e820 entry in case e820 type string matches to io resource name
To:     lijiang <lijiang@redhat.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, akpm@linux-foundation.org, dyoung@redhat.com,
        bhe@redhat.com
From:   Boris Petkov <bp@alien8.de>
Message-ID: <49B3EB59-ABD2-4A5C-BE8A-B078283B8418@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On November 21, 2018 11:54:09 AM GMT+01:00, lijiang <lijiang@redhat=2Ecom> =
wrote:
>If you understood this issue, you might ignore it, please=2E

Yes,I got it=2E Simply figuring out which reserved regions to export and w=
hich not, is not worth the effort - we can do the simple thing of directly =
exporting them all=2E

Thx=2E

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
