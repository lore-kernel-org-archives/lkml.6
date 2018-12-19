Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23D5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8D120879
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="f7W55KN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbeLSUzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 15:55:25 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33937 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729023AbeLSUzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 15:55:25 -0500
Received: by mail-ot1-f68.google.com with SMTP id t5so20475651otk.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 12:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UCMt4lViQ74YLZhCrmqn2ws6QgOfmf5JzdEMbyICZMw=;
        b=f7W55KN6VS5LKddSdMQl+i2i3l4M24Yl7gPPsoyjnmQbk6k2MgOfsD9QvUXN9LxQpH
         pPDazlAPqktEDIxzPLS80CB9MRmSi2o1Nb57OjjfVg/YGCEcMSgdDVpDlujhSxX3ZKoz
         gPFBun3Yq02zWrrmyCKojCtk26IM5C88Apf/Cq/kHhj/9/61e/qOX9+HjE9sw/pbasdA
         ewHQOOm17kWgUonbSzAOkfeBcDagI7oGNlIKwpdSTmZLeJfPBNvS9jBp1Dx+AxG8Sdfy
         vLbXro4pJXvI3e7zC3xPDR38bj/NhGOiW8ifkeEhobwNfmvMqQ68n3noSwX5pyyaXKL8
         6Yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UCMt4lViQ74YLZhCrmqn2ws6QgOfmf5JzdEMbyICZMw=;
        b=D1hGlxyX4NZUF60LR2QbKo9Q7VnMtAelFoqH5H3b6TGSPmJXXYGEU3QsX8Na0gghvG
         hc2emH5MsWiGj4y1leYoYnR2T9hB3VIPtD1reIjKRflnmaPz4Uu3BqlcD0pGSAAmpg/X
         CYi3HpouT4vrmHuNyUVy4BOFhKgREKKJ253m6JjFU/1l0LR2TrqRGpuFok5e4S2gTuuY
         zTrkHy9hQaZuASrb7BUjNE2LQaK4vFpyJ6gJqJrV7yTpx3/gNSdHT3QA7xiB5Y843zKh
         KN2Nkdv5Dc4oD2gT3RSnoEo0XSYGmWI0l7TrL8juRGuJGrBmJRpI7dFkFlM3TaRQRC3+
         E6+Q==
X-Gm-Message-State: AA+aEWY2J+6CHIm0yitkPG4DqoSaRfXwFANcEqRPNZXvMEJgcqLv/hpo
        gvuDtwgohsZd9QCFqRYKITsDtdS7oMuDzyGP85o/ww==
X-Google-Smtp-Source: AFSGD/WquP0ie601L8jomOYKZFmVQqTfO89cDr4kEVpKmvgvDSU7B/s+gj2+E0Gb7RvZZkBWX21yyp7vKbJYE64tdgc=
X-Received: by 2002:a9d:6a50:: with SMTP id h16mr14933915otn.95.1545252924320;
 Wed, 19 Dec 2018 12:55:24 -0800 (PST)
MIME-Version: 1.0
References: <154510700291.1941238.817190985966612531.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20181219203236.GA5689@dhcp22.suse.cz>
In-Reply-To: <20181219203236.GA5689@dhcp22.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 19 Dec 2018 12:55:13 -0800
Message-ID: <CAPcyv4iiH_TfAra9F+v-NruuGAHPhp_oRH3Ut3gFZAjM=Mesyg@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] mm: Randomize free memory
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Lutomirski <luto@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 12:32 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 17-12-18 20:23:23, Dan Williams wrote:
> > Andrew, this needs at least an ack from Michal, or Mel before it moves
> > forward. It would be a nice surprise / present to see it move forward
> > before the holidays, but I suspect it may need to simmer until the new
> > year. This series is against v4.20-rc6.
>
> I am sorry but I am unlikely to look into this before the end of the
> year and I do not want to promise early days in new year either because
> who knows how much stuff piles up by then. But this is definitely on my
> radar.

Ok, I'll hold off on posting v7 until the 4.21/5.0 -rc2 timeframe.
