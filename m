Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FD6C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2619720837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qM3CkoXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2619720837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933563AbeFUMYr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:24:47 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37699 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933186AbeFUMYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:24:46 -0400
Received: by mail-pg0-f67.google.com with SMTP id r21-v6so1365360pgv.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 05:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oQbUkjCsw+O4Rjuxbdst4jHMEvMxiP4RWuC8y/i2vpw=;
        b=qM3CkoXIt8Kc9nVughH9y4LI71S0afGMHhnrSP5GHF/4l8PnNNLDlE6T03QVtTD3S+
         rltSq8u83TEy/stMjVahikLvgI33U8q1Ai0iaMDeivMvY19qZq6MIehCP1VFE/xf3Qmh
         XOB3U2cx/6C6FlTejYMUIvsN3e/AcEkxw/2gKE6dXWpYz5RFkXrvf1tOQa9/26Jq+Dv3
         K8eVw0c7/AhC/G6GM571Xa16rlaN+2PA+0K3agA/dFNe7nJlyS3nLQoAnWS3GB57fYDM
         P+16IDEC2GeFLHZmLH5UzclwVp15f/+1A++U4bsgZooaFgldnlCBPG0puRmnaDOz8V8k
         FZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=oQbUkjCsw+O4Rjuxbdst4jHMEvMxiP4RWuC8y/i2vpw=;
        b=fFXclBwsuDGx8f6oijZLKt82lDZY+cQDqokrpWGn5T2pdQrcElThbXLRTyFXEFkY2m
         +XplxrDYQ7nz3N9401j5plbIEX8qFjM8XcUobgFWwxLDNq3rwdZLUMjtyqkD5ngj9cDg
         Neun0BFtiqI4JK3MOxHOLPx/PLRhnsA8nCCsSt84JI+NleUMiteVObPOCAD1ceELgNAX
         8We1HcMzlmDLV/LytHH2BhZVOHdmJLZTGXT7vm1M/np9dznbLXrFJpTNjDfHQRlGBWmI
         TniSZIIqPBF6AW/Rw50t1qNfIAXHxsy8hvVJAOt7xAxcwZFCxPAirQDOvArbKomHxjlL
         wyjQ==
X-Gm-Message-State: APt69E1HgqFbhLM6Ixu1weAPlDaHknGtJ04XtXiqBt/SnVprxon+8Zov
        4pcj8usJW1o7hVE1f5IOeW8=
X-Google-Smtp-Source: ADUXVKL2zjNDq4s2+iTDcRXLXUHiyOHJowgcRvh4AO1sfRymd3g6ubcUmFDFGo2tI9rcLHsvg8P82w==
X-Received: by 2002:a62:4e07:: with SMTP id c7-v6mr27340433pfb.149.1529583885768;
        Thu, 21 Jun 2018 05:24:45 -0700 (PDT)
Received: from toy ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id w7-v6sm5885374pgr.82.2018.06.21.05.24.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 05:24:45 -0700 (PDT)
Date:   Thu, 21 Jun 2018 20:24:36 +0800
From:   Jun Yao <yaojun8558363@gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     james.morse@arm.com, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 1/1] arm64/mm: move
 {idmap_pg_dir,tramp_pg_dir,swapper_pg_dir} to .rodata section
Message-ID: <20180621122436.GA19014@toy>
Mail-Followup-To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        james.morse@arm.com, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
References: <20180620085755.20045-1-yaojun8558363@gmail.com>
 <20180620085755.20045-2-yaojun8558363@gmail.com>
 <CAKv+Gu8_=uTJFDXr0GpGMc=9WZ9tbz305CE6i=qbnqRB=suRVA@mail.gmail.com>
 <20180621025141.GB11276@toy>
 <CAKv+Gu_3Cfuq-qQuRHkYCB2uTPOK=KVeVh4OKmtu2MDYwfOtTA@mail.gmail.com>
 <70ebe6d7-0745-5606-ae89-8a7b2fb62008@arm.com>
 <CAKv+Gu-t5ErL89J=sxeVRYzDNrB1Ejdj+XOggAMWk-gY7ewsOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-t5ErL89J=sxeVRYzDNrB1Ejdj+XOggAMWk-gY7ewsOg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 11:29:52AM +0200, Ard Biesheuvel wrote:
> On 21 June 2018 at 10:59, James Morse <james.morse@arm.com> wrote:
> > On 21/06/18 07:39, Ard Biesheuvel wrote:
> >> On 21 June 2018 at 04:51, Jun Yao <yaojun8558363@gmail.com> wrote:
> >>> On Wed, Jun 20, 2018 at 12:09:49PM +0200, Ard Biesheuvel wrote:
> >>>> On 20 June 2018 at 10:57, Jun Yao <yaojun8558363@gmail.com> wrote:
> >>>> As for swapper_pg_dir, it would indeed be nice if we could keep those
> >>>> mappings read-only most of the time, but I'm not sure how useful this
> >>>> is if we apply it to the root level only.
> >>>
> >>> The purpose of it is to make 'KSMA' harder, where an single arbitrary
> >>> write is used to add a block mapping to the page-tables, giving the
> >>> attacker full access to kernel memory. That's why we just apply it to
> >>> the root level only. If the attacker can arbitrary write multiple times,
> >>> I think it's hard to defend.
> >>>
> >>
> >> So the assumption is that the root level is more easy to find?
> >> Otherwise, I'm not sure I understand why being able to write a level 0
> >> entry is so harmful, given that we don't have block mappings at that
> >> level.
> >
> > I think this thing assumes 3-level page tables with 39bit VA.
> >
> 
> The attack, you mean? Because this code is unlikely to build with that
> configuration, given that __pgd_populate() BUILD_BUG()s in that case.

I think this configuration may be ok. I find that the kernel on Google
pixel 2 XL is built with 3-level page tables with 39-bit VA.
