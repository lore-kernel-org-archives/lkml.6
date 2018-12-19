Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68463C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5672080D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbeLSTRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:17:52 -0500
Received: from smtprelay0203.hostedemail.com ([216.40.44.203]:43005 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727844AbeLSTRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 14:17:52 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 27F1B8018345
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 19:17:51 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 4F33A18224D7B;
        Wed, 19 Dec 2018 19:17:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: gate79_a1352a9fde4f
X-Filterd-Recvd-Size: 2403
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Wed, 19 Dec 2018 19:17:49 +0000 (UTC)
Message-ID: <ad8b075efc39ef10727b118ed292f3353311c6db.camel@perches.com>
Subject: Re: [PATCH] checkpatch.pl: Improve WARNING on Kconfig help
From:   Joe Perches <joe@perches.com>
To:     Igor Stoppa <igor.stoppa@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Andi Kleen <ak@linux.intel.com>
Cc:     igor.stoppa@huawei.com, linux-kernel@vger.kernel.org
Date:   Wed, 19 Dec 2018 11:17:47 -0800
In-Reply-To: <20181219185544.6720-1-igor.stoppa@huawei.com>
References: <0fcf870749cae85490aa17cd637e2c933a792c90.camel@perches.com>
         <20181219185544.6720-1-igor.stoppa@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-12-19 at 20:55 +0200, Igor Stoppa wrote:
> The checkpatch.pl script complains when the help section of a Kconfig
> entry is too short, but it doesn't really explain what it is looking
> for. Instead, it gives a generic warning that one should consider writing
> a paragraph.
> 
> But what it *really* checks is that the help section is at least
> .$min_conf_desc_length lines long.
> 
> Since the definition of what is a paragraph is not really carved in
> stone (and actually the primary descriptions is "5 sentences"), make the
> warning less ambiguous by expliciting the actual test condition, so that
> one doesn't have to read checkpatch.pl sources, to figure out the actual
> test.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -2931,7 +2931,7 @@ sub process {
>  			}
>  			if ($is_start && $is_end && $length < $min_conf_desc_length) {
>  				WARN("CONFIG_DESCRIPTION",
> -				     "please write a paragraph that describes the config symbol fully\n" . $herecurr);
> +				     "expecting a 'help' section of " .$min_conf_desc_length . "+ lines\n" . $herecurr);

this could also be written without the concatenations

				     "expecting a 'help' section of $min_conf_desc_length or more lines\n" . $herecurr);
or maybe
				     "please write a paragraph that describes the config symbol fully ($min_conf_desc_length or more lines)\n" . $herecurr);

Andi?
You are the originator of this text.
Do you have an opinion?


