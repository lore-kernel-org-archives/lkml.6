Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7648FECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2864C208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2864C208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbeGPJvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:51:00 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:44261 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbeGPJvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:51:00 -0400
Received: by mail-ed1-f44.google.com with SMTP id d17-v6so17339030eds.11;
        Mon, 16 Jul 2018 02:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tEX94UruHi5M7fhHcQzP0s3zap3KuYMSd7VQqa34D+A=;
        b=VqchS/rwYMasKQ+ybmnU3b9E6n0sAhq7OVIrZ+b/Lj8oepbEnliFHs2TpAYYBBycYH
         Fx1l62bKIZLx4pn8Gsf+NkEbJUmiv99sey/DkdPT4SS64tt6IEAzFhDFtIkvdByBIGon
         42uVTWSV2OxWyx8NHlwelKtcy8wnPxHKnZSJsoVdY8hRTgvpxLgDnN/a0blnQja3M0q1
         eIhVmDDRikscSf7L+GpP4hzSEf0h9xjOyyfduH2VTyulpPpWQmFFl70VFmMg2RkgDuzH
         cPoPJLX2BIilFmrrtwU0vA+eqJmkVpffetUAMe1KpkdWbev2Z9fTlfawTZXDuGcNa2FG
         4gvQ==
X-Gm-Message-State: AOUpUlGiNSoNkeFoGm11J5jeXrFJLzITWcmxRLB2DHcBNOk1Oaoq2z6H
        fbzCSRYEdT9YOskGNXBHsV3outP7
X-Google-Smtp-Source: AAOMgpfdsjLbVm70afrjSJktXWsgSvpPMSmEJebtQYt7NH0ZsJk446mb5ntQq0Is0EAtUKaRPlt8Jw==
X-Received: by 2002:a50:955e:: with SMTP id v30-v6mr17121095eda.268.1531733069205;
        Mon, 16 Jul 2018 02:24:29 -0700 (PDT)
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com. [74.125.82.52])
        by smtp.gmail.com with ESMTPSA id r11-v6sm7687846edh.32.2018.07.16.02.24.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 02:24:28 -0700 (PDT)
Received: by mail-wm0-f52.google.com with SMTP id f21-v6so2250239wmc.5;
        Mon, 16 Jul 2018 02:24:28 -0700 (PDT)
X-Received: by 2002:a1c:6fdd:: with SMTP id c90-v6mr9070719wmi.16.1531733068591;
 Mon, 16 Jul 2018 02:24:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 02:24:08
 -0700 (PDT)
In-Reply-To: <6a9fa6f3-7aef-a83b-72a6-dc9492964b5e@gmail.com>
References: <20180716075718.4e5ef491@canb.auug.org.au> <CAOesGMhVeo6Wc=nMcEnusa+FfwQBWJnxs0LY-zXm4HMau+SMhg@mail.gmail.com>
 <6a9fa6f3-7aef-a83b-72a6-dc9492964b5e@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 16 Jul 2018 17:24:08 +0800
X-Gmail-Original-Message-ID: <CAGb2v667K4Z6o-KEQROWuCbgJbKLNX_OCpCBOWaECb_qfRMBpw@mail.gmail.com>
Message-ID: <CAGb2v667K4Z6o-KEQROWuCbgJbKLNX_OCpCBOWaECb_qfRMBpw@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the arm-soc tree
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Olof Johansson <olof@lixom.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Eric Anholt <eric@anholt.net>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 5:13 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
> On 07/15/2018 03:50 PM, Olof Johansson wrote:
>> Thanks Stephen, I keep saying every time you catch these that I need
>> to run the same script. :(
>>
>> Florian, I wonder if this happened when you rebased to squash in the fix?
>
> Humm, could be, all I did (and it was not the first time) was to do an
> interactive rebase with --preserve-merges. AFAICT, all of these commits
> came from Eric's pull request, so what I typically do is just sign off
> on the merge commit, but do not apply my SoB to all commits coming from
> that pull request if that makes sense?

When you rebase, if the commit is re-applied, the committer changes to
you, so you need to add your SoB to all commits you rebased.

I suppose you could override it with GIT_COMMITTER_NAME and
GIT_COMMITTER_EMAIL environment variables, but that sort of distorts
the SoB if any changes were added due to rebasing, such as resolution
of merge conflicts.

ChenYu
