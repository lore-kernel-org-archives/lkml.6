Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D410DC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7226E20652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7226E20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=opteya.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbeIFQ1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:27:48 -0400
Received: from ou.quest-ce.net ([195.154.187.82]:42483 "EHLO ou.quest-ce.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbeIFQ1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:27:48 -0400
Received: from [37.170.173.92] (helo=test.quest-ce.net)
        by ou.quest-ce.net with esmtpsa (TLS1.1:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <ydroneaud@opteya.com>)
        id 1fxspv-0000q8-Ed; Thu, 06 Sep 2018 13:52:35 +0200
Message-ID: <2e337313415a1ede1fb7a777902a0de7cb7c2602.camel@opteya.com>
From:   Yann Droneaud <ydroneaud@opteya.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-api@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        codalist@coda.cs.cmu.edu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 06 Sep 2018 13:52:29 +0200
In-Reply-To: <9916.1536218032@warthog.procyon.org.uk>
References: <1c57005277ac723ebb670a1dc847a205f0529d53.camel@opteya.com>
         <153616286704.23468.584491117180383924.stgit@warthog.procyon.org.uk>
         <153616291029.23468.16421004714304578585.stgit@warthog.procyon.org.uk>
         <9916.1536218032@warthog.procyon.org.uk>
Organization: OPTEYA
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 37.170.173.92
X-SA-Exim-Mail-From: ydroneaud@opteya.com
Subject: Re: [PATCH 05/11] UAPI: coda: Don't use internal kernel structs in
 UAPI
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on ou.quest-ce.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le jeudi 06 septembre 2018 à 08:13 +0100, David Howells a écrit :
> Yann Droneaud <ydroneaud@opteya.com> wrote:
> 
> > This structure should not have been exposed to userspace in the
> > first
> > place: it's unusable by userspace as it is. It was incorrect to
> > have it
> > outside of #ifdef __KERNEL__ before commit 607ca46e97a1b ... 
> > ...
> > All CODA_REQ_* defines internals to kernel side and not exchanged
> > with
> > userspace.
> > 
> > Please move them back to <linux/coda_psdev.h>
> 
> Is there any reason coda_psdev.h needs to be in include/linux/ rather
> than fs/coda/?
> 

It's a valid concern.

At first I thought the first lines (see below) could have been useful
for userspace:

  #define CODA_PSDEV_MAJOR 67
  #define MAX_CODADEVS  5    /* how many do we allow */


But the file was unsuable for a long long time so we can assume it's
usage by userspace is deprecated, then we could remove it from UAPI,
and moves its content back to include/linux.

As one could see include/linux/coda_psdev.h is not used outside of
fs/coda, moving the header here as you suggests seems to be the correct
solution.

Regards.

-- 
Yann Droneaud
OPTEYA


