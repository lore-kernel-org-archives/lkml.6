Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38853C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 09:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37BA2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 09:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37BA2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbeKBSwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 14:52:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41401 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeKBSwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 14:52:45 -0400
Received: from mail-lf1-f69.google.com ([209.85.167.69])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <christian.brauner@canonical.com>)
        id 1gIW1p-0005zi-Gr
        for linux-kernel@vger.kernel.org; Fri, 02 Nov 2018 09:46:09 +0000
Received: by mail-lf1-f69.google.com with SMTP id m18so137465lfb.15
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 02:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qv5DpT9Vz5guju32HZQzGcH5DmXIbAOAY57SDtNyGp4=;
        b=LnMOEzU9VO1mT9YgaJiCczRCXIzZ6SXDP0DzKg0/rx9jk4/epjkPuvcICx42YW9gba
         LoU+OF6bwgIUiWnQAF6KpwX+J9zhut9LHmu7gtZgvcbpr0ZXI3cLKNyQ1PS/Wjxy7E5W
         MRm0DsZZ1NeuYnOJmDil6njjKmkw4RB95uv9vCYSPS6o/nQd0wfjLOj5T26ZP3x5pHzW
         3oX3P5nV3by/nXRMJP/MpYA5kPPw6BUNG+JBOkJY9I7Fwg6yM7iQJUx/nGh5Fp28sZ9V
         kHkvTVFipGJsY7kOQOGqNk/VACrg7UbQo7dvO/keSdFYpb+Ed5rysNopF4Rg2/zdP+aM
         CP7g==
X-Gm-Message-State: AGRZ1gJ3bBLrb2NIScgJ/lmQ4uRqy/FXCqPNHyVnJ2FjUyEbK9aUtPZM
        VF6WNJWsG1Z+5MecDdAS9vWtgT/nHAVwyhufCwBQ0uWuIdfZ7146QgatSk3wePigWVdF73nGidA
        XAvaY6bM/2QI8MOzBxVxb4O9uFdYMGrgFzmuZ8op8eQ==
X-Received: by 2002:a2e:86ca:: with SMTP id n10-v6mr3117996ljj.90.1541151968206;
        Fri, 02 Nov 2018 02:46:08 -0700 (PDT)
X-Google-Smtp-Source: AJdET5cjmBISAac7CIIIruvKu1b6WBYKjo+cfgSN0AoHkkA0c+rWHHGZ1QRZNYarD8vs/TwcHCmXyQ==
X-Received: by 2002:a2e:86ca:: with SMTP id n10-v6mr3117967ljj.90.1541151967601;
        Fri, 02 Nov 2018 02:46:07 -0700 (PDT)
Received: from gmail.com ([94.72.11.11])
        by smtp.gmail.com with ESMTPSA id l63sm2230342lfl.76.2018.11.02.02.46.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 02:46:06 -0700 (PDT)
From:   Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian@brauner.io>
Date:   Fri, 2 Nov 2018 10:46:03 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Daniel Colascione <dancol@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>, ebiederm@xmission.com,
        luto@amacapital.net, serge@hallyn.com
Subject: Re: [RFC PATCH] Implement /proc/pid/kill
Message-ID: <20181102094602.z5otkwrqtchpuhfm@gmail.com>
References: <CAKOZuesKVic-5epRj8XcFNR_63SgvaPcbjDQuSLxNrEfS=O=Jg@mail.gmail.com>
 <20181030204501.jnbe7dyqui47hd2x@yavin>
 <20181030214243.GB32621@google.com>
 <20181030222339.ud4wfp75tidowuo4@yavin>
 <20181030223343.GB105735@joelaf.mtv.corp.google.com>
 <CAKOZueuBdY_b=CVk29pzn0NAt9sJtzr6yqx9Y00WCppCm1JFWQ@mail.gmail.com>
 <CAPP7u0VQqDvFr=-52+Tmv_K=vT730wG7w9VQqJggsXTPFvaUBQ@mail.gmail.com>
 <20181031025655.yz7lfhswk7igb3ty@yavin>
 <CAEXW_YQxWcQGZHrwhwsyu7GCk+WSap=tb0-asTsG8sTFmjE--g@mail.gmail.com>
 <20181101204059.GA102756@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181101204059.GA102756@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 01:40:59PM -0700, Joel Fernandes wrote:
> On Tue, Oct 30, 2018 at 09:24:00PM -0700, Joel Fernandes wrote:
> > On Tue, Oct 30, 2018 at 7:56 PM, Aleksa Sarai <cyphar@cyphar.com> wrote:
> > > On 2018-10-31, Christian Brauner <christian.brauner@canonical.com> wrote:
> > >> > I think Aleksa's larger point is that it's useful to treat processes
> > >> > as other file-descriptor-named, poll-able, wait-able resources.
> > >> > Consistency is important. A process is just another system resource,
> > >> > and like any other system resource, you should be open to hold a file
> > >> > descriptor to it and do things to that process via that file
> > >> > descriptor. The precise form of this process-handle FD is up for
> > >> > debate. The existing /proc/$PID directory FD is a good candidate for a
> > >> > process handle FD, since it does almost all of what's needed. But
> > >> > regardless of what form a process handle FD takes, we need it. I don't
> > >> > see a case for continuing to treat processes in a non-unixy,
> > >> > non-file-descriptor-based manner.
> > >>
> > >> That's what I'm proposing in the API for which I'm gathering feedback.
> > >> I have presented parts of this in various discussions at LSS Europe last week
> > >> and will be at LPC.
> > >> We don't want to rush an API like this though. It was tried before in
> > >> other forms
> > >> and these proposals didn't make it.
> > >
> > > :+1: on a well thought-out and generic proposal. As we've discussed
> > > elsewhere, this is an issue that really would be great to (finally)
> > > solve.
> > 
> > Excited to see this and please count me in for discussions around this. thanks.
> > 
> 
> Just a quick question, is there a track planned at LPC for discussing this
> new proposal or topics around/related to the proposal?
> 
> If not, should that be planned?

There isn't currently one planned but I'm happy to have a hallway track
session around this.

But note, I think not all relevant people are going to be there (e.g.
Andy). File descriptors for processes seems interesting to a lot of
people so I'm going to send out a pitch of the idea I have and see how
much I'm going to get yelled at latest on Tuesday. Even if it just
triggers a design discussion.
I have been urged by people I pitched this to to send it to lkml
already. Sorry for the delay and the initial non-transparency. The only
reason I didn't do it right away was to ensure that this idea is not
completely crazy. :) (Eric probably still thinks I am though. :))
It's just that I'm at a conference and I want to have a nicer writeup of
this. Given the speed with which this is all coming I have given up on
preparing a first set of patches. :)

Christian
