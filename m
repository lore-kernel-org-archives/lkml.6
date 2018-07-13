Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE4EECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC07C2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC07C2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbeGMWDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 18:03:20 -0400
Received: from smtprelay0074.hostedemail.com ([216.40.44.74]:39666 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726126AbeGMWDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 18:03:20 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 9C91B180171B8;
        Fri, 13 Jul 2018 21:46:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wrist30_3bddf3d52d03a
X-Filterd-Recvd-Size: 2020
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Fri, 13 Jul 2018 21:46:51 +0000 (UTC)
Message-ID: <6799952fbd3639c764c112bde961b5e00270a52d.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Require commit text and warn on long commit
 text lines
From:   Joe Perches <joe@perches.com>
To:     Prakruthi Deepak Heragu <pheragu@codeaurora.org>, apw@canonical.com
Cc:     linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        bryanh@codeaurora.org, ckadabi@codeaurora.org,
        David Keitel <dkeitel@codeaurora.org>
Date:   Fri, 13 Jul 2018 14:46:50 -0700
In-Reply-To: <1531518027-13318-1-git-send-email-pheragu@codeaurora.org>
References: <1531518027-13318-1-git-send-email-pheragu@codeaurora.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-13 at 14:40 -0700, Prakruthi Deepak Heragu wrote:
> Commit text is almost always necessary to explain why a change is needed.

This bit seems sensible, but perhaps it should just count the
number of lines after the end of email headers and before any
Signed-off-by:/Signature line

> Also, warn on commit text lines longer than 75 characters. The commit text
> are indented and may wrap on a terminal if they are longer than 75
> characters.

This is already exists via

# Check for line lengths > 75 in commit log, warn once
		if ($in_commit_log && !$commit_log_long_line &&
		    length($line) > 75 &&

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -14,6 +14,13 @@ use File::Basename;
>  use Cwd 'abs_path';
>  use Term::ANSIColor qw(:constants);
>  
> +use constant BEFORE_SHORTTEXT => 0;
> +use constant IN_SHORTTEXT_BLANKLINE => 1;
> +use constant IN_SHORTTEXT => 2;
> +use constant AFTER_SHORTTEXT => 3;
> +use constant CHECK_NEXT_SHORTTEXT => 4;
> +use constant SHORTTEXT_LIMIT => 75;

probably overly complicated

