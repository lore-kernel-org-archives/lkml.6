Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB046C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59BA21919
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZY9qesP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfBHFTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 00:19:54 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43915 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfBHFTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 00:19:53 -0500
Received: by mail-pl1-f194.google.com with SMTP id f90so894688plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 21:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BYbBSsXD8XXPJr8WmxtwPC6HBpOHhpTEB9wAZo2Q1Iw=;
        b=ZY9qesP9VVn0x9e71+u4lkQ//uBh7kJgGvlvQKRWeoCf4hvZtlJxqBWlgNIsBozfuw
         PdiI4WYxwxhuhA+2Sgprj5UL9o5hea0yoh9+Ctc3FowkhG51kFr8aedwRShg+QKcaDCW
         tIY0lbhw0VWFe5rVm0M2wXVtSouGOAhLUfZ50+m3NGMVTTrnEeKRxLxi0BdKLdR7nIiA
         XEYfw1JdCfICZ/gylNCtg2bIU+Rm1+9QUR+dnNgdoU5lcQEY8JXoxLEdbOeFNsjs58Ms
         yjBkj2TK4LWgLjeiJEPhzVoyPpQRQIMnqvxzPKyKJF6lFGUzbvvWjTcEHrDFrmsmTVdQ
         Iftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BYbBSsXD8XXPJr8WmxtwPC6HBpOHhpTEB9wAZo2Q1Iw=;
        b=skKM9Zm/Ns5hP0G3+OGyX0ibu7shvOfIbjbPM2WSsmKiO/SSiE7DVQuuF5q3di0sLR
         OjEpkfiAYvO9GeK/bj2OESJ+AVKD/KEIrMJvfz52Q5CP7j5zxTMh3X+IDU+dN91+KAfN
         RMZHQBqvQJRr6doEZ0BsRlj9SQviKD/CIGo0XPfaNEHrTrnPiIyMaEjlmGE67LqZWrZq
         fTSPRCQKHImLZi046fDRWRdsQyTd0WN8EkZxP2SOzvFeF1xwueILvhZUYU3tbrxkkJtJ
         Zjz9m2Pfkjj7WGtef9D5AlqjrwrfaAY2fNny7w42tLI0kzV2Yh6Lj/vYhoddoNcDh6BY
         4TQw==
X-Gm-Message-State: AHQUAuYm9NIQP3yUi2GPtS8RujCHfUUxYhd9eMgVjF6shhVBsCSdsN3p
        8dLlwDE17XxltjOK8Osk7nSEH/PswDo=
X-Google-Smtp-Source: AHgI3Ib+Q8mmAigiLi1jjcsVDeZ6rNsQaeyBAKdrDXlYrjxQElJhijsWAqyqebNTeTb+oDehCRzanA==
X-Received: by 2002:a17:902:298a:: with SMTP id h10mr20875446plb.312.1549603192845;
        Thu, 07 Feb 2019 21:19:52 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id d16sm901999pgj.21.2019.02.07.21.19.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 21:19:51 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gryZq-0002AV-R9; Thu, 07 Feb 2019 22:19:50 -0700
Date:   Thu, 7 Feb 2019 22:19:50 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Doug Ledford <dledford@redhat.com>,
        Christopher Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
Message-ID: <20190208051950.GA4283@ziepe.ca>
References: <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
 <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com>
 <20190206210356.GZ6173@dastard>
 <20190206220828.GJ12227@ziepe.ca>
 <0c868bc615a60c44d618fb0183fcbe0c418c7c83.camel@redhat.com>
 <20190207035258.GD6173@dastard>
 <20190207052310.GA22726@ziepe.ca>
 <CAPcyv4jd4gxvt3faYYRbv5gkc6NGOKjY_Z-P0Ph=ss=gWZw7sA@mail.gmail.com>
 <20190207171736.GD22726@ziepe.ca>
 <CAPcyv4hsHeCGjcJNEmMg_6FYEsQ_8Z=bvx+WmO1v_LmoXbJrxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hsHeCGjcJNEmMg_6FYEsQ_8Z=bvx+WmO1v_LmoXbJrxA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 03:54:58PM -0800, Dan Williams wrote:

> > The only production worthy way is to have the FS be a partner in
> > making this work without requiring revoke, so the critical RDMA
> > traffic can operate safely.
> 
> ...belies a path forward. Just swap out "FS be a partner" with "system
> administrator be a partner". In other words, If the RDMA stack can't
> tolerate an MR being disabled then the administrator needs to actively
> disable the paths that would trigger it. Turn off reflink, don't
> truncate, avoid any future FS feature that might generate unwanted
> lease breaks. 

This is what I suggested already, except with explicit kernel aid, not
left as some gordian riddle for the administrator to unravel.

You already said it is too hard for expert FS developers to maintain a
mode switch, it seems like a really big stretch to think application
and systems architects will have any hope to do better.

It makes much more sense for the admin to flip some kind of bit and
the FS guarentees the safety that you are asking the admin to create.

> We would need to make sure that lease notifications include the
> information to identify the lease breaker to debug escapes that
> might happen, but it is a solution that can be qualified to not
> lease break. 

I think building a complicated lease framework and then telling
everyone in user space to design around it so it never gets used would
be very hard to explain and justify.

Never mind the security implications if some seemingly harmless future
filesystem change causes unexpected lease revokes across something
like a tenant boundary.

> In any event, this lets end users pick their filesystem
> (modulo RDMA incompatible features), provides an enumeration of
> lease break sources in the kernel, and opens up FS-DAX to a wider
> array of RDMA adapters. In general this is what Linux has
> historically done, give end users technology freedom.

I think this is not the Linux model. The kernel should not allow
unpriv user space to do an operation that could be unsafe.

I continue to think this is is the best idea that has come up - but
only if the filesystem is involved and expressly tells the kernel
layers that this combination of DAX & filesystem is safe.

Jason
