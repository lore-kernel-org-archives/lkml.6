Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47227C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A9620833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p157OlrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A9620833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeIJMNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:13:09 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53739 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbeIJMNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:13:09 -0400
Received: by mail-wm0-f67.google.com with SMTP id b19-v6so20380311wme.3;
        Mon, 10 Sep 2018 00:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5Z+nKMPUIK/KD9vHXHbUqJpRwAQq8ArTb+pdGdFdls0=;
        b=p157OlrEOFZy4G1l9pL3GiUAS3pxmhPATWoD8qwLur7SIQ8YzrH+RxWCl78fnQqE3B
         qZfDFsHiEUyVRhgp69z7l5lJ3OXqFnF4SysKv1bcV/uGQxDJp6n8IlmuvJjl0qzx5GGc
         W6OKsxPKzQPq0cP7mKQ67j5WMmsBA+F2pTLLVtYJS5Z03oABr52dbWSEWF4fFjruCTd6
         0WxrwdPolK/YtGF7cdGKLRnfFuSp9sYmpiNh+m2OPb9854mCWllz7JLqotYYPvAjtB9d
         qU9j9cgZuIuuyDEb+nSH53hC0WoygB/NbGjDRF8ilG3yctmGpMorT1HUkwuFJu7lIbhI
         nhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Z+nKMPUIK/KD9vHXHbUqJpRwAQq8ArTb+pdGdFdls0=;
        b=TKwIp5Q0t60WN4kWOg7NvKLKZPY5XK6cpmnnVTOB69fQ5MvcimuS9pnqJqaUMJjKUf
         yyQGQ/uSYs/8FJub7/g8WjcYhHXFbQEY+Ob6g+p8T9MWNtvPeWGjXoMyfYbvoqVf3LlH
         u6xIu/BiQN4Z9XmNZFI2sYAFgtSsZs0Cr9LNR29jmT+mBo7MmpiuPOBkMJCbKlla/rnX
         d+mGYjS2zMdxot0WYA5Wc3py7gtNTNEAoBAc5EtaVWbeYkRduXOyRoc9k6ewueZnJTs1
         zxMfB3QabQaXGtw9MX5hy95vkLBjaQ9hHRr41Pe7S2/TqsugzT+OhM1cTnmc1lquMxcG
         XPJw==
X-Gm-Message-State: APzg51C3PixOzkif+LmEceLKUXJHGSE1ONL0zgsrwQqWXi7KIK+p+qVW
        RVzvx+Ns6432p13f7yPowrg=
X-Google-Smtp-Source: ANB0VdYgTTIEmXL7H1Uu7R+emVbLtLrDnqfUINPEEGmSYk3aWMOS4yEPH/fmtaXQ9S10Cko1+LMwZg==
X-Received: by 2002:a1c:1bca:: with SMTP id b193-v6mr12089740wmb.6.1536564031082;
        Mon, 10 Sep 2018 00:20:31 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z10-v6sm15740378wrv.22.2018.09.10.00.20.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 00:20:30 -0700 (PDT)
Date:   Mon, 10 Sep 2018 09:20:28 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Aaron Ma <aaron.ma@canonical.com>
Cc:     ard.biesheuvel@linaro.org, tglx@linutronix.de, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/efi: earlyprintk - Add 64bit efi fb address support
Message-ID: <20180910072028.GA47768@gmail.com>
References: <1536423828-5693-1-git-send-email-aaron.ma@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536423828-5693-1-git-send-email-aaron.ma@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Aaron Ma <aaron.ma@canonical.com> wrote:

>  	if (efi_fb)
>  		return (efi_fb + start);

Just noticed this detail unrelated to your patch: return is not a function.

Thanks,

	Ingo
