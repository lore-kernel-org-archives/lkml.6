Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74454C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E9A20663
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E9A20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391127AbeKVLOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 06:14:04 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44942 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732226AbeKVLOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 06:14:03 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 87B8588D;
        Thu, 22 Nov 2018 00:37:13 +0000 (UTC)
Date:   Wed, 21 Nov 2018 16:37:11 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Enke Chen <enkechen@cisco.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "Victor Kamensky (kamensky)" <kamensky@cisco.com>,
        xe-linux-external@cisco.com, Stefan Strogin <sstrogin@cisco.com>
Subject: Re: [PATCH v5] kernel/signal: Signal-based pre-coredump
 notification
Message-Id: <20181121163711.2c00316784d221eb1750edb0@linux-foundation.org>
In-Reply-To: <20181030164628.GD7643@redhat.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
        <458c04d8-d189-4a26-729a-bb1d1d751534@cisco.com>
        <7741efa7-a3f8-62a1-ba52-613883164643@cisco.com>
        <84460a77-a111-404e-4bad-88104a6e246e@cisco.com>
        <20181026082812.GA10581@redhat.com>
        <21f678a8-4001-df36-c26e-e96cf203b1b1@cisco.com>
        <20181029111804.GA24820@redhat.com>
        <0c197608-3b7e-ffd1-8943-801a60beb917@cisco.com>
        <20181030164628.GD7643@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2018 17:46:29 +0100 Oleg Nesterov <oleg@redhat.com> wrote:

> On 10/29, Enke Chen wrote:
> >
> > Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> 
> Hmm. I didn't say this ;)
> 
> But OK, feel free to keep this tag.
> 
> I do not like this feauture.

Why is that?

> But I see no technical problems in this version
> and I never pretented I understand the user-space needs, so I won't argue.

The changelog appears to spell this all out quite well?  Unusually
well, in my experience ;)

A couple of things...

- We'll be looking for a manpage update please.  (Search MAINTAINERS
  for "manpage")

- As it's a linux-specific feature, a test under
  tools/testing/selftests would be appropriate.  I don't know how much
  that work will be.  Do we have other linux-specific signal extensions
  which could piggyback onto that?

