Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D30DC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 01:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3463620843
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 01:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qp1Q/YNx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3463620843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeJ2KZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 06:25:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37158 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbeJ2KZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 06:25:26 -0400
Received: by mail-pl1-f195.google.com with SMTP id bh10-v6so3002385plb.4;
        Sun, 28 Oct 2018 18:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W8zbc508Lri55XPTGoSvM+RnFVoZz30xuenMctXg9Zc=;
        b=qp1Q/YNx3kuXIK4Yu4cAjSpL0mU4G0rYJlzwLbhKMLG4S8+ciniffFY3iqNCB5Hgxn
         IdpyYF6Ft84LOThmx0B0yfu4ris4YUpY9aQ5lkJRhboK+q0ZncZGmgEjNxMvZnhTFSZ4
         Vm60hkBswsn7YuV++W94qiyYR5Gdjz6ljuUzVL1Rqe/atoht6nIR1c/rQeozFyDOgJ9c
         yk/RYS/efZsSMUsyDwtTZ5G342NeI621acTOWFkJ9p7j9MQrSRNU/ok8r6E1Cp5sp/+u
         LqxOAV1AJIOnKpVvcRTExRKNpqW7UpX91CHsOADXY+0hYrpnXeH761A9G7VoyxwF7XZP
         eeQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W8zbc508Lri55XPTGoSvM+RnFVoZz30xuenMctXg9Zc=;
        b=bGjWT8G4i1WO3Vn9VQp9gM6GSzo5KKEfllgAPN1LHGjoJKBWA3bzAEySj9n5pQGkt0
         2M6L1B8T8yywpULB1GDhbbYODhnts3J0jFoutQEEiCEptWpJ7L40YA3tkxpjuEqhztH1
         BgnLupMk3foKeFl3VocD+OMgCRnPNTYnezRj05x7J4DJjtHzpgeOKMrQ+wd+4PSPUa+g
         hJM04HBqcOKDplnvRnAolgzttY28iLnhuijcgmh8cF18njINwCYJk5SB+pPtxE6Sd6Ty
         Dmtm0GdZsQijydAqXEIAoEAJrKl0d7ItMv50963h2KobPDHid+rpTR5QjJ5ndAZReTVg
         pa1w==
X-Gm-Message-State: AGRZ1gJPFs7K5sRbem/KRQD5qaEh1hXAAw1iz7iaUewySs8vILH+vXfd
        1qRBQlCR8i0QbDxvzM/S94o=
X-Google-Smtp-Source: AJdET5f0Nmck6RlJjeVQTiKO6hmxVbuoX473xW9ymRe83AJTKdOdi5yl443w2uw6C1Q+wTpq6jbSrw==
X-Received: by 2002:a17:902:163:: with SMTP id 90-v6mr9170745plb.87.1540777141061;
        Sun, 28 Oct 2018 18:39:01 -0700 (PDT)
Received: from leo.usersys.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id o4-v6sm2343625pfi.172.2018.10.28.18.38.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 18:39:00 -0700 (PDT)
Date:   Mon, 29 Oct 2018 09:38:50 +0800
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Subject: Re: linux-next: build failure in Linus' tree
Message-ID: <20181029013850.GL24677@leo.usersys.redhat.com>
References: <20181029093532.38a3888e@canb.auug.org.au>
 <CAHk-=wi475eRvUDctiWdBWsEB7UYgr8OrpPzrd=xkevUpTSCuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi475eRvUDctiWdBWsEB7UYgr8OrpPzrd=xkevUpTSCuA@mail.gmail.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 03:45:16PM -0700, Linus Torvalds wrote:
> On Sun, Oct 28, 2018 at 3:35 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > After merging the origin tree, today's linux-next build (powerpc
> > ppc64_defconfig) failed like this:
> 
> linux-next is back! Wheee..
> 
> >   5a2de63fd1a5 ("bridge: do not add port to router list when receives query with source 0.0.0.0")
> 
> David?
> 
>                  Linus

Sorry, I forgot to check if IPv6 is configured. Nikolay has helped post
a fix for this issue.

Regards
Hangbin
