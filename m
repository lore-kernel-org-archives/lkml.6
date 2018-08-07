Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3F8C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B084821707
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B084821707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390088AbeHGUZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 16:25:12 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55838 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389301AbeHGUZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 16:25:12 -0400
Received: by mail-it0-f68.google.com with SMTP id d10-v6so33820itj.5;
        Tue, 07 Aug 2018 11:09:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6Xj8RMrQxgY2GlvUArJ6vKQ3EHDssxmewTKQDRhAVX8=;
        b=o+tdbukl99ZcLdwZhg0h39OMkO2SrbHufBdDORbQ6CP8CxqpAfu64V0FYLIqqV6xeE
         UUu+9flKl5teTa4uzIwIYAPUKeSP9h+D94JpfrtAkiG2ehy0SVJx8EiKsI8KVNID2HiG
         5IpAcSyrXBmwMJga6DPpz7qdRNgmaMsqu7SdfP8Pl1BQ75OcL3sejI0lQiq/Wc721iXT
         fOYdflpVfacUXAKWgebepDAxaKtDZLjSJsmMys009v1UlRrA4YIgdFePzPOddSIWQ2hd
         BsCdiy8vrYQlmHJOoWatF2g0tVvXQDWdOfvWWhV5PY7yewydU1O2SO7LVq2y8MvpTJHP
         qVQQ==
X-Gm-Message-State: AOUpUlHWcPFo3OkLIUar1Gmi70eBtMjtmD+yy/HlzmVG0tsSLrqU0JXD
        8dmeBlhgPkiAHEqrKDm53A==
X-Google-Smtp-Source: AA+uWPymrE7QLWcBnEqgSD4ssWEW2ACe8p+1c4iwf8GVbB7rQQdzbK4Uam/Oz8RKIdSk1t2JFJf9HQ==
X-Received: by 2002:a24:184c:: with SMTP id 73-v6mr2820342itr.42.1533665379609;
        Tue, 07 Aug 2018 11:09:39 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id 203-v6sm1070637itw.31.2018.08.07.11.09.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 11:09:38 -0700 (PDT)
Date:   Tue, 7 Aug 2018 12:09:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bharat Bhushan <Bharat.Bhushan@nxp.com>
Cc:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        oss@buserror.net, galak@kernel.crashing.org, mark.rutland@arm.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        tyreld@linux.vnet.ibm.com, joe@perches.com
Subject: Re: [RFC 3/5] powerpc/mpic: Add support for non-contiguous irq ranges
Message-ID: <20180807180938.GA13623@rob-hp-laptop>
References: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
 <1532684881-19310-4-git-send-email-Bharat.Bhushan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532684881-19310-4-git-send-email-Bharat.Bhushan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 03:17:59PM +0530, Bharat Bhushan wrote:
> Freescale MPIC h/w may not support all interrupt sources reported
> by hardware, "last-interrupt-source" or platform. On these platforms
> a misconfigured device tree that assigns one of the reserved
> interrupts leaves a non-functioning system without warning.

There are lots of ways to misconfigure DTs. I don't think this is 
special and needs a property. We've had some interrupt mask or valid 
properties in the past, but generally don't accept those.

> 
> This patch adds "supported-irq-ranges" property in device tree to
> provide the range of supported source of interrupts. If a reserved
> interrupt used then it will not be programming h/w, which it does
> currently, and through warning.
> 
> Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> ---
>  .../devicetree/bindings/powerpc/fsl/mpic.txt       |   8 ++
>  arch/powerpc/include/asm/mpic.h                    |   9 ++
>  arch/powerpc/sysdev/mpic.c                         | 113 +++++++++++++++++++--
>  3 files changed, 121 insertions(+), 9 deletions(-)
