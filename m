Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F1916256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2F220857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MpGNNOn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2F220857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbeG3Tai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:30:38 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:32851 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbeG3Tah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:30:37 -0400
Received: by mail-io0-f196.google.com with SMTP id z20-v6so10622295iol.0;
        Mon, 30 Jul 2018 10:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eHKnmk7JQOcxN8oUy3aB7V62ckALKqY8ckJeGpQjeLY=;
        b=MpGNNOn56uFXy6eBjibgkDbbD1Jp5M/ip6YWccGD8YpfCnqq2KhvVvQuOZrUGqRym5
         EhSFYtXw1H2A/VTYd7uZ021MwVj7b56ssCPLU+moQWMnwvPwDaXeZ4AFs2O+iUBTRHTv
         ltDPNIsrULDY/pJxGuUnaRfUUou+5UAq7R+PY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eHKnmk7JQOcxN8oUy3aB7V62ckALKqY8ckJeGpQjeLY=;
        b=XcgT49FqUvR3HOiuPWhQR9TKrA/AlN51nw8vymPDl4jy7/bqh6vA9o09fr3ORpggT3
         1xtRFx+B/54MmcM1fUk653WyDAXP5MuItEy21rKyEjm5K8QgtNwaHONjM+cFP81w0Yvy
         RhpQWtP8tNUUhhaAjIXAo96wE4qQWh/5x7Zg6kEG4WvQlHZW6Oml4sZQ7acYQhTahHZW
         XGTc+Rfmtej4DX8hbZv75ZfYlY6Ls4I4wd/fWjrsc5NrHcudFeSzhTiIwkJMfbYuhuVk
         BiBkX+FYD6Vg63BJVuNLjWx32+Z5zSQ7gmldTX96+Ffu5RH2e8J5VITJ/k8PA8nmzoP+
         xLjg==
X-Gm-Message-State: AOUpUlHi8S7ZJkGfYq7yVo07dYErRrNa6SBdETOqY3VXyg4Q6bM/fmRu
        17v+4wVsjWt+iAlXqoTIP9UPC1UNHtmmUZzUVYQ=
X-Google-Smtp-Source: AAOMgpc3V/Jo8bIn7/IbW3JX3cOdLTXtmadp1MmIdSNlL73uCPQjIXdwRtU7ACi3xGRe6bMR7qrH3M92IEF8i+as5FM=
X-Received: by 2002:a6b:fc0c:: with SMTP id r12-v6mr14620695ioh.203.1532973270493;
 Mon, 30 Jul 2018 10:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180730143104.GB24051@amd> <20180729113749.GA7333@amd>
 <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
 <153271292330.9458.14583488053811372222.stgit@warthog.procyon.org.uk>
 <25489.1532953411@warthog.procyon.org.uk> <21165.1532964795@warthog.procyon.org.uk>
 <20180730173052.GA881@amd>
In-Reply-To: <20180730173052.GA881@amd>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Jul 2018 10:54:19 -0700
Message-ID: <CA+55aFyzya1jiqXoWYtxzD+pRtg-oXXSs8z4ZS5gCKWAmmLrMA@mail.gmail.com>
Subject: Re: [PATCH 36/38] vfs: Add a sample program for the new mount API
 [ver #10]
To:     Pavel Machek <pavel@ucw.cz>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 10:30 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Still userland needs a way to understand the errors.

Not really.

We don't internationalize kernel strings. We never have. Yes, some
people tried to do some database of kernel messages for translation
purposes, but I absolutely refused to make that part of the
development process. It's a pain.

For some GUI project, internationalization might be a big deal, and it
might be "TheRule(tm)". For the kernel, not so much. We care about the
technology, not the language.

So we'll continue to give error numbers for "an error happened". And
if/when people need more information about just what _triggered_ that
error, they are as English-language strings. You can quote them and
google them without having to understand them. That's just how things
work.

Let's face it, the mount options themselves are already (shortened)
English language words. We talk about "mtime" and "create".

There are places where localization is a good idea. The kernel is
*not* one of those places.

                 Linus
