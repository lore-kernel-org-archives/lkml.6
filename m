Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAD8C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE422514B
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNfu8Fdc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE422514B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934041AbeFXPt3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:49:29 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:40639 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933776AbeFXPt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:49:27 -0400
Received: by mail-wm0-f52.google.com with SMTP id z13-v6so1174573wma.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 08:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EgUExKtWL+4VbBNTArlGIkTBm4c1vQoGzCgog1xJi2E=;
        b=TNfu8Fdc+rDVlDD8D3jfLmuo2p6lzPzMIYheoxDsC3YbIY7fJpGMssn6Xh4fkX8dOE
         PL8KMfDjVtC5hf+xB/yieG2d+IEmcZERZOMkThrLI9Uw+uKL/KaXM8KRMwRYNuq/2/a0
         vaKjhg/M856Gg6e4vQjE1jekbz8DgFBSIPQBvCtJlvE5XhnmqfZme5tRhaqfKDEWvSSb
         7rhqUt2HmfoxsInmDmqPviT4xXtfVs4SD8qkoGAc7+yOgKwvW6naJSQFUT95Vm4fTV/n
         EKixdtXfmpI34mTYFJRNKXQO9xG+jV4EkIU/aire7UabKRkxiNgKzA04khYGe/o2Rt1r
         h3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EgUExKtWL+4VbBNTArlGIkTBm4c1vQoGzCgog1xJi2E=;
        b=sx7c9jhz9efAmrfmB+yCgCfN1SjqGlRAwfCBHv5bk22Sspz/djaVRA9UwnOCf/4SeL
         nzOsknjPL4E8aO+PZjIt0Z5voxwiv724xxnD3sz8Q/Pd7MuV+BH9sNfQD+5QKGA5TTch
         5D3Oo+zdVt6zCBgNGC0IPA4XofpnL8uG+hDa970dcvUHVP3YLF00wicdGqV2O4qO15KS
         5xYbwp0aT++HnM+oPMKdV9bftBUjh5L3QHTklg5g57lP42udATLwlVRESv8KSo79jgEd
         cr3L9R185o164CEES8OslSLJcHQV0a3/OAs9ius90T6q97+VzYKs8oMA2fpKp/6wNf7+
         T6bw==
X-Gm-Message-State: APt69E2WGZPNAqpCbbImfTpuSYFYccOEKtjaN4yMFO8mcgq4exm4Tbbg
        nRWP4hORXtffajiYYc8QyFw=
X-Google-Smtp-Source: ADUXVKI4sBgT3aLfUoEEFB4W5xyoZ6wt7yFqhhjLVkKjxQnNzeeohfLdHnB1KaAeVLiYmtyzAyA7xA==
X-Received: by 2002:a1c:944f:: with SMTP id w76-v6mr276028wmd.105.1529855366736;
        Sun, 24 Jun 2018 08:49:26 -0700 (PDT)
Received: from xux707-tw (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id j10-v6sm24905427wrr.47.2018.06.24.08.49.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Jun 2018 08:49:25 -0700 (PDT)
Date:   Sun, 24 Jun 2018 16:49:26 +0100
From:   John Whitmore <arigead@gmail.com>
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 3/8] staging: rtl8192u: User memset to initialize
 memory, instead of loop.
Message-ID: <20180624154924.65gtd6aqfbzl5t63@xux707-tw>
References: <20180624154027.27654-1-johnfwhitmore@gmail.com>
 <20180624154027.27654-4-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180624154027.27654-4-johnfwhitmore@gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry having difficulty getting the full v3 patch set sent using git
send-email. Only one seems to be going out. Sorry about the noise.
