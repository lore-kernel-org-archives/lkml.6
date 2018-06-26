Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C6EC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89191265E2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H8C208mw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89191265E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752615AbeFZHWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:22:04 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:42399 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752575AbeFZHV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:21:59 -0400
Received: by mail-io0-f196.google.com with SMTP id r24-v6so14972014ioh.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 00:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FM+c7xzAJagkjNlHIuVzq6WL8yj383HOWUsn9j+wao4=;
        b=H8C208mwWz/8pzEIRF8CKW7B1CZgJPqQ+RdtHfu3+1nvMRPngeidyuSk02Zxcu8xrI
         hQuDLAZFg+sRq7Cqg57MlEW6tliZlspqhrGyzbLeLhwq3u7+NQR5isKLhCboNHhfxGMr
         TCR9Lmukyp7E+qBq+3I90A6iD/4AZ7Md1KrDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FM+c7xzAJagkjNlHIuVzq6WL8yj383HOWUsn9j+wao4=;
        b=hKeFml66qKXPAv8voZEUfcKqz6pqhBGctCq0AR+WEZW01YlepE1uWmvFSinj6AYU66
         fllSL6/2tkbyJWFCcQ/O2Y1nHOIHmVOMrrlkFxW1ArnT1BVrSFFhAKYl0CpGROwLiyoG
         oMUSr+er5o+0Ud28ZcZnPxwOtpp1ijD7IWEV1vqKsg3YlNP/cokvXG359EwRHYW8CNS5
         xgCmL2MjPfrKIK4pULTsvGwxfJpMZcqJ/+OXsFDrlc8wBScTA2QrpyQWSdondQep/B07
         6jnNGDVeeCkyRwYPa+IV6zExbU8gtQaRtpZ5h6AYcfiDob9Fa573TUETGDmYmTqBFGCQ
         kxMQ==
X-Gm-Message-State: APt69E1+jkbRiOLwh0uoXGfPDI17g1Yqsun8N8KPNYfH/GpJ+M3/WISI
        yD48bSDkUMTq00BxyezRJhsp4Ikp/0rL/FOCeCsBzA==
X-Google-Smtp-Source: AAOMgpef/EdYKemTx6Q9sU7SmVq8f3quw2XNmjTxfeW/oKOrZsYO7ImQCQBfafnm0kFrP6VXWoXGTXAvRwveaQlt2os=
X-Received: by 2002:a6b:4a15:: with SMTP id w21-v6mr243594iob.277.1529997718615;
 Tue, 26 Jun 2018 00:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <1529766899-1994-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1529766899-1994-1-git-send-email-hofrat@osadl.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Jun 2018 09:21:46 +0200
Message-ID: <CACRpkda9G+y2Q-UtMPsHaopoB42F9st=ZY92EEGVk9sOXLODJA@mail.gmail.com>
Subject: Re: [PATCH] PCI: faraday: add missing of_node_put()
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 5:16 PM Nicholas Mc Guire <hofrat@osadl.org> wrote:

>  The call to of_get_next_child() returns a node pointer with refcount
> incremented thus it must be explicitly decremented here in the error
> path and after the last usage.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: commit d3c68e0a7e34 ("PCI: faraday: Add Faraday Technology FTPCI100 PCI Host Bridge driver")

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
