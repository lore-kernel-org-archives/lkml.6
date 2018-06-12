Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2735BC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D244C20891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N0U38E/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D244C20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934720AbeFLWJG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:09:06 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:41387 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934163AbeFLWJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:09:05 -0400
Received: by mail-io0-f195.google.com with SMTP id t5-v6so1221551ioa.8;
        Tue, 12 Jun 2018 15:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NSqhCpXtr0oZDLp8AciUtfnj8yU0m9vBezJpFc32H9U=;
        b=N0U38E/RfOk8vK6h+rAoTZnxfaSTs/jqYU0R2zD3G53OmzpPVClqNKSx6T1yK5TRO5
         kUMGEF9UCdAKMG05ub0Ib5jnNuGViXgHtVhbNS58iEfRv8nGhAcbYuR2oVlLbKChI7AI
         p6xdZsCMYh0TlIaZa31L9C6cKh6RG6OC9CzPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NSqhCpXtr0oZDLp8AciUtfnj8yU0m9vBezJpFc32H9U=;
        b=Q+9HXpQv4sJcDp0sTSeNFHCB0l19jyfuE9dt6iirJyML2W49MCITGULG3HF7l4j8mG
         bt/YadwhPk1RUP/bVgnMe2mqS0QmGsQojfKBuoUEAlAZDTgVRqMNhv56OsEnhM3VzkTq
         dbFLZb6fjtHMpt9H7X3Us8uqnVQSj/bxhEFkgn/P+KjUjP4hBLUPLb9peLyq7/z5FvcN
         ks1ogyUCsbBcWwnU9SD6b3E03KqgYiZBXojhh+O8RaKzYiSOcftTCO09n4GWfktOdUJ9
         313ttKT+3zQ/xUDIQwWaWFS8RamGK9LMTeqqMMPiUSTLIOrrL8gOARyd7w5/s1YzemmI
         +TEQ==
X-Gm-Message-State: APt69E2AcxKBXekxpwIuRdaJ/Q6nQSfCL55bcHdMYJtpL39n7Lmonds2
        JmN+C9yRDbhZZztmnUIIMGem18E2SMCxBbEbInY=
X-Google-Smtp-Source: ADUXVKLNgXFcapGE9FvmbR7sYMj3OyD4iMcwK5KeGedKPVz4QhZ8ZcderKEYRjGk+jsHV0LNqTm33+xivWJf910IWI8=
X-Received: by 2002:a6b:f90b:: with SMTP id j11-v6mr2422948iog.238.1528841344210;
 Tue, 12 Jun 2018 15:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180612210820.GA70310@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180612210820.GA70310@bhelgaas-glaptop.roam.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Jun 2018 15:08:53 -0700
Message-ID: <CA+55aFyo-NmP_zkyjnMXxJEq-93ha4akLDpF8biiFQ-hhWnZmg@mail.gmail.com>
Subject: Re: [GIT PULL] PCI changes for v4.18, part 2
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        shawn.lin@rock-chips.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 2:08 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
>   - squash AER directory into drivers/pci/pcie/aer.c (Bjorn Helgaas)

Could we please see *reasons* for this series of commits?

Those commit messages have trivial "what", but no explanations "why".

                  Linus
