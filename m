Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA45CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEDC920883
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEDC920883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730984AbeKGVjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 16:39:23 -0500
Received: from ozlabs.org ([203.11.71.1]:39011 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbeKGVjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 16:39:22 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42qlZf5s6Mz9sCm;
        Wed,  7 Nov 2018 23:09:14 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH v6 00/18] of: overlay: validation checks, subsequent fixes
In-Reply-To: <bf1be459-22d7-6b23-7b1f-847dad5e028f@gmail.com>
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com> <CAL_JsqJ6fJcqH4+YHrEZRb+8-KFEmL8WSTSE_XSyrtO=2+JQBA@mail.gmail.com> <bf1be459-22d7-6b23-7b1f-847dad5e028f@gmail.com>
Date:   Wed, 07 Nov 2018 23:09:14 +1100
Message-ID: <87sh0dqec5.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Rowand <frowand.list@gmail.com> writes:

> Hi Michael, Ben, Paul,
>
> Do you know if anyone has tried this series on PowerPC?

I have. No obvious breakage.

My test does a loop of adding and removing multiple CPUs multiple times,
and in the past that has uncovered refcounting bugs. So I don't think
we're leaking any with this series applied.

I used the tracepoint patch to keep an eye on the refcounts :)

  https://patchwork.ozlabs.org/patch/751602/


I'm happy for this series to go into linux-next where it should get some
more testing.

cheers
