Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166499AbeBOS3E (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 13:29:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:54508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163160AbeBOPZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:25:21 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF4C9217A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jeyu@kernel.org
Date: Thu, 15 Feb 2018 16:25:16 +0100
From: Jessica Yu <jeyu@kernel.org>
To: Matthew Garrett <mjg59@google.com>
Cc: Ben Hutchings <ben@decadent.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Make kernel taint on invalid module signatures
 configurable
Message-ID: <20180215152514.rxmh7webdg2i2fct@redbean>
References: <20170807195027.13192-1-mjg59@google.com>
 <CACdnJus-X533K0Bgqjc-MoZ2NbLz0ac9x+rryHUtnjrnmJ+Kmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACdnJus-X533K0Bgqjc-MoZ2NbLz0ac9x+rryHUtnjrnmJ+Kmg@mail.gmail.com>
X-OS: Linux redbean 4.14.16-200.fc26.x86_64 x86_64
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Matthew Garrett [14/02/18 18:21 +0000]:
>Hi Jessica,
>
>Any objections to this patch?
>
>Thanks!

Hi Matthew!

My questions and comments from last year still apply here -

  http://lkml.kernel.org/r/20170829175647.ej5fqszss2mbpc5i@redbean

I'm still unclear on why a distro would enable CONFIG_MODULE_SIG and
then _not_ want to know about unsigned modules.

>From what I understand from Ben's post from last year
(http://lkml.kernel.org/r/1504044122.4448.24.camel@decadent.org.uk),
it sounds like the main issue is that Debian doesn't support their own
centralised module signing yet, causing all of their modules to be
automatically tainted if they enable CONFIG_MODULE_SIG, and that a new
option like this would likely be used as a temporary "fix". Am I
understanding correctly?

I understand this predicament, but it seems like adding a new set of
options/parameters like this is just hiding the symptoms of the
problem (modules distributed by Debian getting tainted by default)
instead of fixing what seems to be the heart of the issue (Debian
doesn't support their own module signing yet), if that makes sense.
I am hesitant about merging something that would only serve as a
temporary solution until Debian supports their own module signing. In
that case, I would prefer the Debian folks to maintain their own patch
removing the taint until they support module signing for their own
modules, especially if - and please correct me if I'm wrong - the
new option is not going to see long-term usage.

Thanks,

Jessica
