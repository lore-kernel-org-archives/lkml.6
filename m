Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F9BECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D7621524
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="CD4lJNfn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D7621524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeJJAy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:54:29 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34782 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbeJJAy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:54:29 -0400
Received: by mail-ot1-f66.google.com with SMTP id i12-v6so2528248otl.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 10:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DoYB0X1jhJA2q0lW8xYYWyGXalA56LyXrGU7hBlyrdk=;
        b=CD4lJNfn/y93hJIJZ6lzV7kqH8n7DxVxku0i1bgJ9eg3Gqx/7X5YlMZM02UBCglYdJ
         5J/TK8NiGeNdkmVxbsqktqxR+UIkfrwgWWExiekIY/Tcn8sxrhlc0+vrLLIQPrHDGFxm
         Yl8ZN92VuH0L0cxlOZBUN+pDY0CtxXH0eIu0ChqbH2LiK58J9LIDj3hpC5N2OXGgkNIy
         +Q+ME80lolKor7LvfVOA/frKxj9gSFO0uwamzIuUGqLK97It/Jg8+2WlkWyJU92BlddQ
         QWJzJDs1zG6ir0uXJ3jQmom1mXHy7wEfpOkmomjkXAZ3dIEFuUm8udKVlFW/Upp1XhJO
         bu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DoYB0X1jhJA2q0lW8xYYWyGXalA56LyXrGU7hBlyrdk=;
        b=ZKg8mH+t+FMSb8R/jRB0hLvzyT+Kg3WKuPzBLpjT+V0rf1Zsat18vdwD4yGsblB/jS
         YTQiSatV1iFxT4Sh4346UN0UCdIqq1OOiPwf60m8nGkuykfpsJb8vUQ2mvBNwJeiFHtg
         spZ8dN6yc/plGpZYQe4tzrPpiMuOBAS9EIzDmr06o2Ga/Hz85jTw7lQlQ7SwSlXVX0HS
         HtexBpEvOjOgmwGBoPOqWdsuNyST16ZTlgL6kQgxxc8eAQ8+hBYiRMgUneHJnQrJnl2j
         8Zv+dtEi5s4Wj6q1NFK3ZOOHVKJipFl4rOKAagvNuvFByIcqhvQEbGi1hmU1sAkfWks8
         Hs/A==
X-Gm-Message-State: ABuFfog0V8kNSmClUUmpXnEQUV+DPjXV/EBv2pnw6kjgg1q6PtPZR64R
        w47uvC4nbEhxwJjrK1Wt6UurDA32TCKvZ6233nl5Lw==
X-Google-Smtp-Source: ACcGV63q5g54+Wc2X/0ct1BlZzNRH8Wu/QH40RN4VbasXnddRlmeVYZ6Nc7KddN5jvTuDzUfNkMNkKqCYQkWf+apx8w=
X-Received: by 2002:a9d:56ef:: with SMTP id b44mr18172849otj.214.1539106585745;
 Tue, 09 Oct 2018 10:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <153861931865.2863953.11185006931458762795.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153861932401.2863953.11364943845583542894.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20181004074838.GE22173@dhcp22.suse.cz> <CAPcyv4jO_K8g3XRzuYOQPeGT--aPtucwZsqkywxOFO4Zny5Xrg@mail.gmail.com>
 <20181009111209.GL8528@dhcp22.suse.cz>
In-Reply-To: <20181009111209.GL8528@dhcp22.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 9 Oct 2018 10:36:14 -0700
Message-ID: <CAPcyv4hcVG7V07d0gT4mQjOLrZnesWvVg7cOuUhxCg=+F5qYMA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm: Shuffle initial free memory
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 4:16 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 04-10-18 09:51:37, Dan Williams wrote:
> > On Thu, Oct 4, 2018 at 12:48 AM Michal Hocko <mhocko@kernel.org> wrote:
[..]
> > So the reason front-back randomization is not enough is due to the
> > in-order initial freeing of pages. At the start of that process
> > putting page1 in front or behind page0 still keeps them close
> > together, page2 is still near page1 and has a high chance of being
> > adjacent. As more pages are added ordering diversity improves, but
> > there is still high page locality for the low address pages and this
> > leads to no significant impact to the cache conflict rate. Patch3 is
> > enough to keep the entropy sustained over time, but it's not enough
> > initially.
>
> That should be in the changelog IMHO.

Fair enough, I'll fold that in when I rebase on top of -next.
