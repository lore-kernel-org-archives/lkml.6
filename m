Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CB3ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD16620C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD16620C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbeIXOs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 10:48:26 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39403 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbeIXOs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 10:48:26 -0400
Received: by mail-qt1-f193.google.com with SMTP id c25-v6so2854309qtp.6;
        Mon, 24 Sep 2018 01:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IB6AX+1gqLdngY133C8SE3T3DnBDlv7sNnHHYf7gcJY=;
        b=uAsWnazgFCObe9U6bRZF+6IupENhfGYT9JtmBCRrMnik/1YUsfwjS/4OV7YY9DAm2d
         oUb87dtezVNXIPCfvE817KZH50Txrt0+3dztp5xqjBY7JTsdMWjqk0EwEyxLtis8vbb0
         CzjQvqqCaHB2RaAHXONTST6AQcjy/lh+3coU2Vd6Aqo1V5t2488SxME1S9FJ31sgS0Kx
         JIDdBBOUuv0A0s50todSoPMgd6klyLM1mBQKElQkV217FK2+dZ889H2HWYu8NKMi9keY
         jcyFnnK88OasTMh6+S4n0xkQ65YjanS4Uy7NEj+GU9aMi1s3Zq1gobzbiTbwzhLtvWdy
         Aeug==
X-Gm-Message-State: APzg51BAy6vrZT1ARK+5dCzEuqdBOXNo7bgcDDNgjzxjYLvwYAZGTCSY
        64fBIWRCshIFi0vrbpG/Ph6ug749BfEPCeDTfY4=
X-Google-Smtp-Source: ANB0VdZk8tflkRwyKyFZ1F5qBxOoO6YVv2YvzteBBQhtJT2lF5DIXeFvYNdMO0jHyMPbCmx9jV2hkWakvy/kA0zeRJs=
X-Received: by 2002:aed:3f22:: with SMTP id p31-v6mr7104444qtf.185.1537778846547;
 Mon, 24 Sep 2018 01:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180914143719.GA27689@guoren-Inspiron-7460> <mhng-9d591179-01d4-4a84-a490-8a09d4f3a3d1@palmer-si-x1c4>
 <CAK8P3a3v0K6G47dAVFtn+XjM3iM7vx6L_RB0mmONBDB9gBNgag@mail.gmail.com> <CAMuHMdVV0QWXCkkL8dq4UMLaANGMHu7ePhQ83FiFDtynpJzbLA@mail.gmail.com>
In-Reply-To: <CAMuHMdVV0QWXCkkL8dq4UMLaANGMHu7ePhQ83FiFDtynpJzbLA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 24 Sep 2018 10:47:09 +0200
Message-ID: <CAK8P3a0AVPL3nYF4HTM_jD8-vFn_ScSTnLMUku9vRdbwZQeD4g@mail.gmail.com>
Subject: Re: [PATCH V4 00/27] C-SKY(csky) Linux Kernel Port
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>, Guo Ren <ren_guo@c-sky.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        DTML <devicetree@vger.kernel.org>,
        andrea.parri@amarulasolutions.com,
        Peter Zijlstra <peterz@infradead.org>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 9:21 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Arnd,
>
> On Fri, Sep 21, 2018 at 7:19 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thu, Sep 20, 2018 at 10:52 AM Palmer Dabbelt <palmer@sifive.com> wrote:
> > > On Fri, 14 Sep 2018 07:37:20 PDT (-0700), ren_guo@c-sky.com wrote:
> > > > On Wed, Sep 12, 2018 at 04:30:36PM +0200, Arnd Bergmann wrote:
> > > >> On Wed, Sep 12, 2018 at 3:25 PM Guo Ren <ren_guo@c-sky.com> wrote:
> > My plan was to get that all into 4.20, and then have a conversation about the
> > actual syscall table changes in 4.21. If we need it for both csky and rv32,
> > we might just change the generic syscall table that way in 4.21 without
> > changing all the other ones along with them. I don't want to drag things out
> > over too many merge windows though, and my plan was to do all architectures
> > together to simplify the version checks in the libc code to only have to check
> > for a single version.
>
> What happens with the version checks if it is backported to stable?

They end up as dead code.

The way these version checks are done in glibc, we always try the new
interface first before falling back to the old version, but don't check the
kernel version at runtime.

The compile-time check optimizes out the fallback if glibc is built for
a recent-enough minimum kernel version that is guaranteed to have
the new version.

      Arnd
