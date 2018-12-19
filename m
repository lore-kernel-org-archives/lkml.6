Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED64C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472C921871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbeLSKok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:44:40 -0500
Received: from smtprelay0132.hostedemail.com ([216.40.44.132]:57775 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729138AbeLSKoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 05:44:39 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 33BA740E5;
        Wed, 19 Dec 2018 10:44:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hill68_285afd8dd363c
X-Filterd-Recvd-Size: 1976
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Wed, 19 Dec 2018 10:44:37 +0000 (UTC)
Message-ID: <af04860002d4b0f4607bd4ce6d767f5705430ace.camel@perches.com>
Subject: Re: [PATCH] checkpatch.pl: Improve WARNING on Kconfig help
From:   Joe Perches <joe@perches.com>
To:     Igor Stoppa <igor.stoppa@gmail.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     igor.stoppa@huawei.com, linux-kernel@vger.kernel.org
Date:   Wed, 19 Dec 2018 02:44:36 -0800
In-Reply-To: <20181219083559.30985-1-igor.stoppa@huawei.com>
References: <20181219083559.30985-1-igor.stoppa@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-12-19 at 10:35 +0200, Igor Stoppa wrote:
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
> @@ -2931,7 +2931,8 @@ sub process {
>  			}
>  			if ($is_start && $is_end && $length < $min_conf_desc_length) {
>  				WARN("CONFIG_DESCRIPTION",
> -				     "please write a paragraph that describes the config symbol fully\n" . $herecurr);
> +				     "please write a paragraph (" .$min_conf_desc_length . " lines)" .

could say "(at least $min_conf_desc_length lines)"


