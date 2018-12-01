Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84BBC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 20:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D5820834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 20:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D5820834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725762AbeLBHkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 02:40:42 -0500
Received: from smtprelay0070.hostedemail.com ([216.40.44.70]:43623 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725726AbeLBHkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 02:40:42 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id E53F3180A884F;
        Sat,  1 Dec 2018 20:27:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bean93_5cb693a65d5d
X-Filterd-Recvd-Size: 2564
Received: from XPS-9350 (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Sat,  1 Dec 2018 20:27:19 +0000 (UTC)
Message-ID: <188e822951d0b3a30cf4eea8ec0ea7b6d3bb4fca.camel@perches.com>
Subject: Re: [PATCH 2/2] hwmon: Remove multiple space after dot
From:   Joe Perches <joe@perches.com>
To:     Corentin Labbe <clabbe@baylibre.com>, jdelvare@suse.com,
        linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 01 Dec 2018 12:27:18 -0800
In-Reply-To: <1543522155-17406-2-git-send-email-clabbe@baylibre.com>
References: <1543522155-17406-1-git-send-email-clabbe@baylibre.com>
         <1543522155-17406-2-git-send-email-clabbe@baylibre.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-29 at 20:09 +0000, Corentin Labbe wrote:
> This patch remove extra space after a dot.
[]
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
---
>  drivers/hwmon/Kconfig | 236 +++++++++++++++++++++---------------------
>  1 file changed, 118 insertions(+), 118 deletions(-)
[]
> @@ -11,7 +11,7 @@ menuconfig HWMON
>  	  of a system. Most modern motherboards include such a device. It
>  	  can include temperature sensors, voltage sensors, fan speed
>  	  sensors and various additional features such as the ability to
> -	  control the speed of the fans.  If you want this support you
> +	  control the speed of the fans. If you want this support you
>  	  should say Y here and also to the specific driver(s) for your
>  	  sensors chip(s) below.

Please no.

You can't pry two spaces after a period when using a
fixed width font from me.

And the use is nowhere consistent in the kernel as it's
less than 2:1 in favor of one style over the other.

$ git grep -i '[a-z][a-z]\. [a-z][a-z ]' | wc -l
146888
$ git grep -i '[a-z][a-z]\.  [a-z][a-z ]' | wc -l
85195

The kernel Kconfig use ratio is similar.

$ git grep -i '[a-z][a-z]\. [a-z][a-z ]' -- '*/Kconfig*' | wc -l
5389
$ git grep -i '[a-z][a-z]\.  [a-z][a-z ]' -- '*/Kconfig*' | wc -l
2463

And even in this specific file, it's reversed ratio

$ git grep -i '[a-z][a-z]\. [a-z][a-z ]' -- 'drivers/hwmon/Kconfig*' | wc -l
70
$ git grep -i '[a-z][a-z]\.  [a-z][a-z ]' -- 'drivers/hwmon/Kconfig*' | wc -l
129

So if you _really_ wanted to do this, please do the
entire file consistently.

You seemed to do 118 conversions.  Shouldn't there be 129?



