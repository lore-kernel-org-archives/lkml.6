Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD66C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FAC42083C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FAC42083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbeJPRhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:37:08 -0400
Received: from ozlabs.org ([203.11.71.1]:55929 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbeJPRhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:37:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Z9TD448fz9s0t;
        Tue, 16 Oct 2018 20:47:28 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     frowand.list@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH v4 00/18] of: overlay: validation checks, subsequent fixes
In-Reply-To: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
Date:   Tue, 16 Oct 2018 20:47:27 +1100
Message-ID: <87murekyts.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

frowand.list@gmail.com writes:

> From: Frank Rowand <frank.rowand@sony.com>
>
> Add checks to (1) overlay apply process and (2) memory freeing
> triggered by overlay release.  The checks are intended to detect
> possible memory leaks and invalid overlays.
>
> The checks revealed bugs in existing code.  Fixed the bugs.
>
> While fixing bugs, noted other issues, which are fixed in
> separate patches.
>
> *****  Powerpc folks: I was not able to test the patches that
> *****  directly impact Powerpc systems that use dynamic
> *****  devicetree.  Please review that code carefully and
> *****  test.  The specific patches are: 03/16, 04/16, 07/16

Hi Frank,

Do you have this series in a git tree somewhere?

I tried applying it on top of linux-next but hit some conflicts which I
couldn't easily resolve.

cheers
