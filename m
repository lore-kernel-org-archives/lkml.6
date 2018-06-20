Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55152C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139F520874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139F520874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754310AbeFTPlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:41:18 -0400
Received: from smtprelay0140.hostedemail.com ([216.40.44.140]:60392 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754085AbeFTPlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:41:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 521C7182CF671;
        Wed, 20 Jun 2018 15:41:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: offer19_280c35e2ed642
X-Filterd-Recvd-Size: 3562
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Wed, 20 Jun 2018 15:41:15 +0000 (UTC)
Message-ID: <87e66800d9e991499c43c2bcd5b0772f2dfa8ba8.camel@perches.com>
Subject: Re: [PATCH 4.17.0-rc3 1/1]partition: Remove trailing spaces and
 correct indenting
From:   Joe Perches <joe@perches.com>
To:     kidega <kidegamoses88@gmail.com>, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Date:   Wed, 20 Jun 2018 08:41:13 -0700
In-Reply-To: <20180620161434.GA3513@kidega-PC>
References: <20180620161434.GA3513@kidega-PC>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-20 at 19:14 +0300, kidega wrote:
> Reply-To:

It seems this is your first attempt to patch something
in the linux kernel.

You should read https://kernelnewbies.org/ and you
should start with files in drivers/staging.

The Reply-To: line should not exist here

> > remove trailing spaces
> > correct indenting 

The leading "> " uses should not exist here.

> Signed-off-by: kidega <kidegamoses88@gmail.com>

You need your full legal name here.

> diff --git a/block/partitions/mac.c b/block/partitions/mac.c

This file probably does not need style changes as
it's pretty old and unlikely to change.

But if it did:

> @@ -97,16 +97,14 @@ int mac_partition(struct parsed_partitions *state)
>  			int goodness = 0;
>  
>  			mac_fix_string(part->processor, 16);
> -			mac_fix_string(part->name, 32);
> -			mac_fix_string(part->type, 32);					
> -		    
> +			mac_fix_string(part->name, 32); mac_fix_string(part->type, 32);

This needs separate lines for each single statement.

>  			if ((be32_to_cpu(part->status) & MAC_STATUS_BOOTABLE)
>  			    && strcasecmp(part->processor, "powerpc") == 0)
>  				goodness++;
>  
>  			if (strcasecmp(part->type, "Apple_UNIX_SVR2") == 0
> -			    || (strncasecmp(part->type, "Linux", 5) == 0
> -			        && strcasecmp(part->type, "Linux_swap") != 0)) {
> +				|| (strncasecmp(part->type, "Linux", 5) == 0
> +				&& strcasecmp(part->type, "Linux_swap") != 0)) {

This is making the indentation worse as the parenthesized
sub-test block is now unaligned.

And some would prefer moving the && || to the end of the
previous line like:
---
 block/partitions/mac.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/partitions/mac.c b/block/partitions/mac.c
index b6095335636c..897da77e5379 100644
--- a/block/partitions/mac.c
+++ b/block/partitions/mac.c
@@ -98,15 +98,15 @@ int mac_partition(struct parsed_partitions *state)
 
 			mac_fix_string(part->processor, 16);
 			mac_fix_string(part->name, 32);
-			mac_fix_string(part->type, 32);					
-		    
-			if ((be32_to_cpu(part->status) & MAC_STATUS_BOOTABLE)
-			    && strcasecmp(part->processor, "powerpc") == 0)
+			mac_fix_string(part->type, 32);
+
+			if ((be32_to_cpu(part->status) & MAC_STATUS_BOOTABLE) &&
+			    strcasecmp(part->processor, "powerpc") == 0)
 				goodness++;
 
-			if (strcasecmp(part->type, "Apple_UNIX_SVR2") == 0
-			    || (strncasecmp(part->type, "Linux", 5) == 0
-			        && strcasecmp(part->type, "Linux_swap") != 0)) {
+			if (strcasecmp(part->type, "Apple_UNIX_SVR2") == 0 ||
+			    (strncasecmp(part->type, "Linux", 5) == 0 &&
+			     strcasecmp(part->type, "Linux_swap") != 0)) {
 				int i, l;
 
 				goodness++;

