Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED43BC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B614D2087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B614D2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbeJEWhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:37:18 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46678 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729084AbeJEWhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:37:17 -0400
Received: by mail-qk1-f196.google.com with SMTP id q12-v6so8165145qkl.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 08:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tYn3ZGjvTFVf1Syl0/B8m+IAJzA5qA+CtYoSUnqBSBk=;
        b=dPWL4Wa+EtOyB60HXOACDWV59uqSv3Vb8b+im+z1jYshqmc79Nie4eEZ1reniZUAeN
         HwXporUp5rOTy+kgi4UcQmSnuEdLSmYF3fiUZF7l9SuOE1+qpIjSgRpAtH1icUTfLoT8
         u8RcJpsqXIcCMSg0TS5m7E1A6htSKp0menAh3NEg7mxYa0qEXsHncNVUjB6nXG3hlZI+
         +RQHAwU/kzVIwd3taVjokKts9DONlLSN53m0clNL+bH4N6wxa+af3Ee9MbtBTXCykeXu
         CiagAZgYAqVM8LJy7BXRVeGEPXPwNGO6mUfBaAJN2irVXzOYN90pfzxViaRyn6bMyPQb
         LBaw==
X-Gm-Message-State: ABuFfoidsX5E9s/ItD+B5X0Ck2yiNVY3ccG5JqswBWzBFet8hdk3U6Se
        9SPWdnJhyMRBjPRhGWu8NYvNofK+rdD4BqQWM5w=
X-Google-Smtp-Source: ACcGV60GgrgdAHi75IGeMNoGjTh9AmeWNFkO06Gad/+li9uzUg4ddRORavA3MpKB0jHMu71urngUV0vfFOT+I2RonoE=
X-Received: by 2002:a37:38b:: with SMTP id 133-v6mr9588923qkd.173.1538753882337;
 Fri, 05 Oct 2018 08:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20181004164715.14646-1-leoyang.li@nxp.com>
In-Reply-To: <20181004164715.14646-1-leoyang.li@nxp.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 5 Oct 2018 17:37:45 +0200
Message-ID: <CAK8P3a3uM0_wO-wf7h+1UkUXUSTVtWSrmX_RLVzAC8e3LCuseg@mail.gmail.com>
Subject: Re: [GIT PULL] for-next updates for soc/fsl drivers for v4.20 take 2
To:     Leo Li <leoyang.li@nxp.com>
Cc:     arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 6:47 PM Li Yang <leoyang.li@nxp.com> wrote:
>
> Hi arm-soc maintainers,
>
> Please merge the following updates for next.
>
> PS.  One of the patches is depending on the last pull request for fixes to build
> https://patchwork.kernel.org/patch/10622883/
> I didn't include the fix patches directly in this pull request to prevent a
> complicated merge.  Please let me know if there is a more preferred approach
> to deal with dependencies between pull requests.

Sorry, I'd rather not pull it like this, because that would result in a
broken branch on my side that fails to build until it gets merged with
the other one.

I think the best way to handle this is for you to:

- start a branch on the afa86d264a7c commit that you already sent me
  for 4.20.
- merge the soc-fsl-fix-v4.19-2 branch that you sent me for 4.19 into
  that branch
- rebase all patches from tags/soc-fsl-next-v4.20-2 on top of the merge
- resend the pull request with the new branch

This will result in a bisectable (i.e. each commit builds and works) branch
that also merges cleanly with my fixes branch.

Generally speaking, every branch you send must work standalone,
and each commit in that branch can only depend on work that
comes earlier in that branch.

       Arnd
