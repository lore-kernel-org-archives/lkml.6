Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C0EC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 23:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2DC25799
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 23:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XTqiKGam"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2DC25799
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752641AbeGAXa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 19:30:59 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:40089 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752563AbeGAXa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 19:30:56 -0400
Received: by mail-it0-f65.google.com with SMTP id 188-v6so9746220ita.5;
        Sun, 01 Jul 2018 16:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MoXRAwTvg+pC9goT2e/z2lc/cKKyekaUmZwhXz5u/vI=;
        b=XTqiKGamfjTi0ynZq7l1MMu3VmzB9KAP+Rwm04s+r+HEaFDJejmUPZvkzllR03aswn
         IjXRGFJDIeA6nYLwq8ieXDftNdoz2bFYd3xtpza87f0JEW8QTldem+tktNS8UAHcGDbt
         0OT1ihV+PYvrUtASlFk0aZj4v7WI3nVtfYTzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MoXRAwTvg+pC9goT2e/z2lc/cKKyekaUmZwhXz5u/vI=;
        b=filPmxSljl7l2l61ePfiBLJUmJWojIaC/rtobUGi5LMK9UJdY2ImyrK74axC0bwrHD
         Dz0O4RAL4ZZIiBTk86jb7pNLANRXcA5p8kg90b7jq/vAHA+NraSn3NmXfb6Yov6Vb8n/
         Af6DTEBRtW/DQj2R3EX5yOXxw8goa6DY/cjKZCauC00Q3SAW1aHtt78GX/TDfLjRArSv
         5a8MPUF+HKU8+PaS03B8U8XTzgX9VTOUoSltY3nKiJJTKx6cAmcqGVrRzewsF+3zqSXm
         xQx4XDvz27/dOpmBmeKGOC7RLZ20fZlLU8mWyoPVDoR1SRtptNTMxuQQvT2MEQwFfWi7
         Bggg==
X-Gm-Message-State: APt69E0Ug5upBqStiDlKp9iwKiltoPKl9VX27Zpxm7hs2+afBW9lYxt3
        YOvPd3DiIc90i1HXpUtJ6DUFRPjmz3HSLEuZO8M=
X-Google-Smtp-Source: AAOMgpd/rgxwupjJzeOCG7CgeEOe3hUKp+bUvvR/OTz0EQMuPst0VNzmDk4BjJPMywRXXVFbddeT/2S8Z+ydrJNWECk=
X-Received: by 2002:a24:8046:: with SMTP id g67-v6mr4284481itd.16.1530487855569;
 Sun, 01 Jul 2018 16:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <1527507182-3858-1-git-send-email-kt.liao@emc.com.tw>
 <20180529180506.GB167092@dtor-ws> <000301d3f7e4$5c9e51c0$15daf540$@emc.com.tw>
 <20180622001632.GI79890@dtor-ws>
In-Reply-To: <20180622001632.GI79890@dtor-ws>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 1 Jul 2018 16:30:44 -0700
Message-ID: <CA+55aFzLMkyAGdfaeDLUXeRE0MJUckRDsrbVy2yonT6R=wf-Og@mail.gmail.com>
Subject: Re: [PATCH] Input: elantech - Fix V4 report decoding for module with
 middle key
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     kt.liao@emc.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        ulrik.debie-os@e2big.org, phoenix@emc.com.tw,
        aaron.ma@canonical.com, josh.chen@emc.com.tw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 5:16 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> OK, thank you for the info. Applied.

Ugh. Dmitry, please be more careful with author names.

Apparently you aren't in a proper utf-8 locale, and you messed up the
name in the git repository. So yoiu apparently tried to take KT Liao's
Chinese name: =E5=BB=96=E5=B4=87=E6=A6=AE, but did so in some wrong locale,=
 and it ended up
being just '???' in the git repo.

And I only noticed when I did my shortlog for doing my 4.18-rc3 release not=
es.

I don't know what locale or tools you have, but please try to make
sure everything is utf-8 aware so that these kinds of name corruptions
don't happen..

                 Linus
