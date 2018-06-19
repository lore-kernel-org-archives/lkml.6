Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4497C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE4B205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="SmleVhf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE4B205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966768AbeFSPqh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:46:37 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:41729 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966406AbeFSPqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:46:35 -0400
Received: by mail-lf0-f65.google.com with SMTP id d24-v6so205961lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 08:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NcNvGnJWxZGTUW2LZ1kSMUr+sYWSKDJ8qJqbrIooLbs=;
        b=SmleVhf+f7iWkJ4+eAjPgniPjiFLpUaPz/ZOZXikUI95ol9H2HoA2StCFGENh4MZL8
         hezY22w/XFVAPyZV/LrwWPOTF23NR/DpMLTHO+srWo8DsH0mQZc1AN9Qw90xQlhwp10S
         dO1DZmWOR1INOki4n7Dab0dzhftMkP55LNFeK0tMEfRxPt4jMG1pNAxKiOsFg/glLe2H
         f0c98teLiYlrU9OpaU1Ukfyn8GrugruJohzKPjLBoerwjBoy4y8DqD78R3e/K+C6UJuE
         cqTnr/QAHHerV9IDOoD4xviLi8xoyu6mQLMDq0tyEhPfeFxrhtTdstIOdUbp1cZpjaDS
         BozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NcNvGnJWxZGTUW2LZ1kSMUr+sYWSKDJ8qJqbrIooLbs=;
        b=djIT2mopEY6rK8cErsGwpCymFd8Q07jq2/QBdsCgNH2H1YfSY4Y2VaX3xmmQn+EtQc
         nn0a2SwbSNaawkrtmxLmKs+HrGnB/EhV0qGmtloRcrXRY0VJoq1P2UooGtL99cY17lXx
         eHsipQVqv3mxNXQEF59cNnlu2AwkkBN3irThIDWn/w4LY8bNGGzNixQyMPswT8jUlwNk
         Ur5MWIeWQCGw9VKUxzvTU0XdPFj5jSDnhu+6mxLlrq10zHVNR8MEljOsnwM+m3Alf0PG
         D+XCz/Flb11Xg2fEXSZYDvQmaamOOSB/jfcRPGx5DpERF7hvGzi1wbFuGdLtZEmtpJt2
         3Cuw==
X-Gm-Message-State: APt69E01O/NJMrTIQEkRUh3zp/b/YGQGc2u29siiTUI6R4tOjrxr5y0x
        2T7qOcBRkp4boFXLp+jeyHNXN5XfILE3S7ZcFQEj
X-Google-Smtp-Source: ADUXVKLhev5lbbZVd3HyGQcvyO1FOR2d/NoTprzWkKyo1qK9YguQwe2Nc5xs+zmwDrNt9Vl6iToreT8TW//B2+EEwzg=
X-Received: by 2002:a19:a892:: with SMTP id r140-v6mr10323156lfe.39.1529423194391;
 Tue, 19 Jun 2018 08:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180612080912.7827-1-peter.enderborg@sony.com>
 <20180612080912.7827-2-peter.enderborg@sony.com> <a85d28e8cbd32acda21424ab6a46089f26969671.camel@perches.com>
 <ef97b4b2-35da-7642-aa9d-de3e968cfb81@sony.com>
In-Reply-To: <ef97b4b2-35da-7642-aa9d-de3e968cfb81@sony.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 Jun 2018 11:46:23 -0400
Message-ID: <CAHC9VhR=1Z6sPJ=oetCg0fGFGb7yKq3OxRATeo15jhqMY5JoQQ@mail.gmail.com>
Subject: Re: [PATCH 01/13] selinux: Cleanup printk logging in conditional
To:     peter.enderborg@sony.com
Cc:     joe@perches.com, Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>, danielj@mellanox.com,
        dledford@redhat.com, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 2:23 AM peter enderborg
<peter.enderborg@sony.com> wrote:
> On 06/12/2018 04:38 PM, Joe Perches wrote:
> > On Tue, 2018-06-12 at 10:09 +0200, Peter Enderborg wrote:
> >> Replace printk with pr_* to avoid checkpatch warnings.
> > I believe it would be nicer to remove the
> > "SELinux: " prefix embbeded in each format
> > and use a specific
> >
> > #define pr_fmt(fmt) "SELinux: " fmt
> >
> > to automatically prefix these formats.
>
> I cant argument about that, however some of the warnings and debug prints in this set does not have this
> so it will then change the actual output. (And I also think that they should have a the prefix, but I don't
> know why they don't) So I am not sure if it appropriate for a cleanup patch, it supposed to have no functional change.

As others have mentioned, I think this patch is still a step forward
so I'm going to go ahead and merge it; thanks Peter.

As far as the prefix, or lack of, is concerned, that's probably an
oversight that we should fix at some point, but we would need to look
at each instance to verify.

-- 
paul moore
www.paul-moore.com
