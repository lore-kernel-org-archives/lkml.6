Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19238C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3DC213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3DC213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbeJIAI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:08:29 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52414 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeJIAI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:08:29 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9Yor-0007zy-KI; Mon, 08 Oct 2018 16:55:45 +0000
Date:   Mon, 8 Oct 2018 17:55:45 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH RFC] proc: Don't retain negative dentries
Message-ID: <20181008165545.GE32577@ZenIV.linux.org.uk>
References: <20181008165009.21890-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008165009.21890-1-a.fatoum@pengutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 06:50:10PM +0200, Ahmad Fatoum wrote:
> The referenced commit 1da4d377f94 ("proc: revalidate misc dentries")
> caused following userspace code to access a stale /proc/net/dev
> after the network namespace was changed:

> Despite switching the network namespace, the read access from the
> newly opened file gave back what the very first read in the default
> network namespace returned.

What the hell does that have to do with negative dentries anywhere???

NAK.  Rationale makes no sense _and_ the patch has nothing to do
with claimed rationale.
