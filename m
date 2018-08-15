Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BC0C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836FE2156B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilGH22Xw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836FE2156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbeHPBRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 21:17:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727573AbeHPBRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 21:17:17 -0400
Received: from mail-yw1-f53.google.com (mail-yw1-f53.google.com [209.85.161.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D276A2156E;
        Wed, 15 Aug 2018 22:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534371791;
        bh=Y+6r9vg7WmUjMfNk4fJQ6JvxHpvWOZA+4UHlsJTLMG0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ilGH22XwEyFrpnOsKBcYpmexPKiq3XPiyPgC6TrzRhOgpaiLtZC7w+9FNJE8wgUDm
         T79CIdO1lFWNYWozLUwpeeXHiYnN0Jk9NAztkS6FxE8IwbS49HwCOgJjaXfeHY0VSx
         mJzy7brIN/M9u8PgQKppE6RCrfrCmZrVcWVHIMIw=
Received: by mail-yw1-f53.google.com with SMTP id r184-v6so2040037ywg.6;
        Wed, 15 Aug 2018 15:23:10 -0700 (PDT)
X-Gm-Message-State: AOUpUlFoHWGQRXFbyo4aVlbaKJW+O40RGoyIPp8LfM9RaGo1mtbB9icS
        GGtS9X5BvqkCxSTOvwkYn43O67HTVpr4H1Iwyy0=
X-Google-Smtp-Source: AA+uWPz8bkcxJKQDqOHfsLB2f63aWKbfvfH+EHxhb4040p2rnOO73Et3+XkAbbgkKrl8fDSyyb4F1l8nuslpahnmCzg=
X-Received: by 2002:a81:6257:: with SMTP id w84-v6mr14893784ywb.327.1534371789790;
 Wed, 15 Aug 2018 15:23:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:81cc:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 15:22:29
 -0700 (PDT)
In-Reply-To: <20180815220958.3606-1-atull@kernel.org>
References: <20180815220958.3606-1-atull@kernel.org>
From:   Alan Tull <atull@kernel.org>
Date:   Wed, 15 Aug 2018 17:22:29 -0500
X-Gmail-Original-Message-ID: <CANk1AXQDYoxvcnmiPAtKJVAoE7YooiRxcikwYuscKgEZe9m64w@mail.gmail.com>
Message-ID: <CANk1AXQDYoxvcnmiPAtKJVAoE7YooiRxcikwYuscKgEZe9m64w@mail.gmail.com>
Subject: Re: [PATCH 1/2] fpga: doc: documentation for FPGA debugfs
To:     Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dinh Nguyen <dinguyen@kernel.org>
Cc:     Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Alan Tull <atull@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 5:09 PM, Alan Tull <atull@kernel.org> wrote:
> From: Alan Tull <atull@opensource.altera.com>

Ugh.  This patchset is a squash-and-cleanup of some really old commits
that had my no-longer valid opensource.altera.com email address as the
commit author.  I'll need to fix that in v2.

Alan

>
> This patch depends on my recently submitted documentation changes
> ("docs: fpga: document programming fpgas using regions")
>
> Document the DebugFS interface for the core FPGA Manager
> framework.
>
> Signed-off-by: Alan Tull <atull@kernel.org>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
