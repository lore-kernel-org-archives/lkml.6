Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECB3C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB995208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoJJH6hU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB995208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933600AbeFUMKK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:10:10 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:43869 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933291AbeFUMKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:10:07 -0400
Received: by mail-oi0-f65.google.com with SMTP id t133-v6so2664418oif.10;
        Thu, 21 Jun 2018 05:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=EYw7Uv3wP48JR6VhattOVzgshSy+nYuSdeos80BDzK4=;
        b=DoJJH6hUYhZ+lAAlG6tTuMKwCJiWYEux6Lwy8Of2sCJ4mn/EYfC3WLjBJMCMBNAZVL
         HTEEMG9b8ApT4MRswjiS2Es5YucAzwYUdLGTIxHIE+nerjzUWMsd17xmzCS0sDboonbE
         /1w3ljwcGe3vnZaCnxg+L2ZJJIQJ1yfYfLfJWPxNpE5eWpcE69nHKtweWP4haVVN7M7v
         5doEOGW+2wkV2m59asCFK/XkNq1e61p+2ynAWuWeU5eWlnnyhiaOHlMnyCXWgTHW+MHC
         6x+Gzg5Iez57ez9ZEoBfWJU+qP7rovGdHPafiao6VL5jlq7Pd6BokbxoP/JqFOjvhKUR
         k5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=EYw7Uv3wP48JR6VhattOVzgshSy+nYuSdeos80BDzK4=;
        b=OUd1P5k4bD09szvgQTcl4kDAHzbHeXjU00flozdnlQeCoyluRcciADOpA89X91yB1z
         8xva+n+gCD+jxwM3pdww7njgxXlkn5ffl9dtHEcx+HtHzViWPq9gS9EtgJnYXqtohm9d
         5YfdLk2XfGGwF1EincjdUE4jwv+Cte4+w5MYhN3SOWCfOH7tA48HLaZ+qSuQfpn/TQgH
         LzSmkt7AIdzc1jILo/HtoUSi22Ka3wAzF3c91j9pbVMMmAn1tJ2CZKNSqcqW9JqQVsY0
         WF8uQM/Qq8xfUKtAjbWIy8N1lAlguKETFYe1zKbE2O6kovK5KdhTpxb9d8QHTghMMz6M
         Gpfg==
X-Gm-Message-State: APt69E2xHJTUoJGakNveX+KCIFyFXzEoOYiKY6mtckTQCfuWUxnFn3T5
        TBpoo0oxAhKDFWBmFLmOjqs6RHUhiqfwS5TRYQM=
X-Google-Smtp-Source: ADUXVKIfRwJoDZnatf+ilUE55FBOSKLBLzr5X+HhKH8Xn49vDk0WGLdfVI70ve+G6txVRWBgtSkae5Lzjlb3L6sgdh4=
X-Received: by 2002:aca:5bc6:: with SMTP id p189-v6mr14886969oib.116.1529583007115;
 Thu, 21 Jun 2018 05:10:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 05:10:06
 -0700 (PDT)
In-Reply-To: <20180621090142.GB21807@amd>
References: <cover.1529486870.git.yu.c.chen@intel.com> <78af30838d0bac69bdd6e138b659bcbb8464fd13.1529486870.git.yu.c.chen@intel.com>
 <20180621090142.GB21807@amd>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Jun 2018 14:10:06 +0200
X-Google-Sender-Auth: 41LUitx7QrYH8TLy5qZQiVxBzr8
Message-ID: <CAJZ5v0hDhsxwU4X6_dCqc7P5GaTtpBeMUeJTHo9YJ8QtWinYfg@mail.gmail.com>
Subject: Re: [PATCH 3/3][RFC] tools: create power/crypto utility
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Chen Yu <yu.c.chen@intel.com>, "Ted Ts'o" <tytso@mit.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Stephan Mueller <smueller@chronox.de>,
        Eric Biggers <ebiggers3@gmail.com>,
        Denis Kenzior <denkenz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 11:01 AM, Pavel Machek <pavel@ucw.cz> wrote:
>
>
> On Wed 2018-06-20 17:40:51, Chen Yu wrote:
>> crypto_hibernate is a user-space utility to generate
>> 512bits AES key and pass it to the kernel via ioctl
>> for hibernation encryption.(We can also add the key
>> into kernel via keyctl if necessary, but currently
>> using ioctl seems to be more straightforward as we
>> need both the key and salt transit).
>
> Ah, here you go:
>
> https://en.wikipedia.org/wiki/Uswsusp

No, not really.

> It can already do encryption. If you see problems there, patches will
> be gladly accepted to fix them.

By whom?

> If you want to maintain uswsusp in kernel tree, I guess that would be
> an option, too.

No, it isn't an option due to the dependencies on crypto libraries.

> If you want to just help swsusp, I have some patches that reduce
> duplicities between x86-32 and x86-64. It would be cool to clean them
> up and get them merged.

Sure, please submit them then.

Thanks,
Rafael
