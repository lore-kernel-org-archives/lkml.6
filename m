Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166C0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E622083E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyxrDmZJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E622083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbeKOML6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 07:11:58 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:43199 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeKOML6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 07:11:58 -0500
Received: by mail-io1-f67.google.com with SMTP id t81-v6so13296407iod.10;
        Wed, 14 Nov 2018 18:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XUz/XSl6RoQ53EWVZFImh1lTtVq5//CnDHoDtignLls=;
        b=IyxrDmZJ5+DzQdqvWM/ucI02P3PU2iJNW2gHZKXV5S95ZLdIINj0vIYhFVOlW4ntTT
         cV6sCrKyOJPN/GNM4mmIc1C+7b5+EqUgyc6017e6iKVDXaF7mxvtWtAoSpaHmQog5FZ4
         tsVM/X+6B18exMADAESxspiqVx+BgSdw9erQeibtHKmyq8bB9bm8uDa+fllNE8KBMWRG
         ARojpwe5U7vyGXQnCMcAryt1uagQps2KLay1mDpP2M7vIxSVMffJBHrQsAafpSAOipcN
         d8JLAWEUYTLMB0zzRVlloEZQULgIEaFw3DqSmktrhCRnfCrDcZlioTKP8SOkW/X8f+eQ
         9iaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XUz/XSl6RoQ53EWVZFImh1lTtVq5//CnDHoDtignLls=;
        b=tNs6Bt4L37QjEpsjoKpkjfOLfS/HFIBM0pUX8bGYIeVechjXa4v/ALlkUX6fWEQZeI
         b1arCv61tjO7gvOfTA5Yfq219F6DWz8/nkqsnqbqlUXq+x48fmf7SlREBuK0bAT+/PbO
         Gh2u1NWHWLMs0fHLXLtOE9CE/cVMjU++tu2fUrqvNlicWwAsMA1a8DN7KzJ19/uh9A2A
         sSRTbejlt8zV1xOROdqMV5BFKrSsgwXqdWU7ZNXJzNp9fbdyOxLN+rCbhNeQmaIPWeaN
         ZZJV/hRlIm9362XiAjlSKMbkfWGOlkz7AB0xjgrkDZtIgcBAXXMQqPcj7QNGt4dr7Z3d
         OgoA==
X-Gm-Message-State: AGRZ1gKDGsCXf+Hnm9PghaGQjMviHSIxjdOmWC5KfTlE4RobllMvP5rs
        NyqLOFTHnUNDwjnCInDZWsdDyYdkc9RGs/87Tw8=
X-Google-Smtp-Source: AJdET5fGm7wRVo26aUsFBFy7FCSbGFmJ2028p8VSMU/YxexAavTkr53LdQSv0pPDFMzngzBS3VZ/mP0Bqafi4C2NsM8=
X-Received: by 2002:a6b:5b02:: with SMTP id v2-v6mr3686730ioh.157.1542247568790;
 Wed, 14 Nov 2018 18:06:08 -0800 (PST)
MIME-Version: 1.0
References: <2335309.gnWok9HYb4@agathebauer> <CAOBGo4zirLiKX8VcROAE=kAD0+qkF0E-cBv9DtBiQr=_obDv5w@mail.gmail.com>
 <20181112032637.GG6218@tassilo.jf.intel.com> <31474933.dcNFsqGoRn@agathebauer>
In-Reply-To: <31474933.dcNFsqGoRn@agathebauer>
From:   Travis Downs <travis.downs@gmail.com>
Date:   Wed, 14 Nov 2018 21:05:32 -0500
Message-ID: <CAOBGo4wPeobp90eqZF1apZxHUn-dnh6L3Rpt_=beR49o3XHY7g@mail.gmail.com>
Subject: Re: PEBS level 2/3 breaks dwarf unwinding! [WAS: Re: Broken dwarf
 unwinding - wrong stack pointer register value?]
To:     Milian Wolff <milian.wolff@kdab.com>
Cc:     ak@linux.intel.com, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 8:20 AM Milian Wolff <milian.wolff@kdab.com> wrote:

> 3) I suggest we always keep the first frame and sample IP from the user regs,
> i.e. the accurate PEBS/IBS IP. Then we add the following frames from unwinding
> the ustack with the iregs.

Does this mean that the displayed unwind will sometimes be
"impossible" to have actually be generated from a consistent execution
of the user program?

For example, the top frame (from PEBS) and second frame (from iregs)
may be inconsistent in that the latter function never calls the first.
At this point it would be good to have an indication at the top frame
is from a different source than the rest of the frames, lest the user
pull is hair out trying to determine how function X seems to call
function Y despite that not being the case in the source.
