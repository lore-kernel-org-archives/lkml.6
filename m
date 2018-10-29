Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5F4C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 01:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711F920843
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 01:52:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711F920843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbeJ2Kiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 06:38:55 -0400
Received: from smtprelay0054.hostedemail.com ([216.40.44.54]:43999 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727820AbeJ2Kiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 06:38:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id AA52F18028236;
        Mon, 29 Oct 2018 01:52:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: gun79_8981504183648
X-Filterd-Recvd-Size: 2937
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Mon, 29 Oct 2018 01:52:24 +0000 (UTC)
Message-ID: <795912c5ade5a813cf5c70d7085c14c24b553f1d.camel@perches.com>
Subject: Re: [PATCH 8/9] w1: fix whitespaces of struct declarations
From:   Joe Perches <joe@perches.com>
To:     Steffen Vogel <post@steffenvogel.de>, linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>
Date:   Sun, 28 Oct 2018 18:52:23 -0700
In-Reply-To: <20181028220927.56227-9-post@steffenvogel.de>
References: <20181028220927.56227-1-post@steffenvogel.de>
         <20181028220927.56227-9-post@steffenvogel.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-10-28 at 23:09 +0100, Steffen Vogel wrote:
> This fixes a warning raised by the checkpatch tool.

checkpatch does not raise any whitespace errors on
this file.

It does suggest that braces could be moved.

$ ./scripts/checkpatch.pl -f --strict drivers/w1/w1_netlink.h
WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
#1: FILE: drivers/w1/w1_netlink.h:1:
+/*

ERROR: open brace '{' following struct go on the same line
#74: FILE: drivers/w1/w1_netlink.h:74:
+struct w1_netlink_msg
+{

ERROR: open brace '{' following struct go on the same line
#130: FILE: drivers/w1/w1_netlink.h:130:
+struct w1_netlink_cmd
+{

total: 2 errors, 1 warnings, 0 checks, 144 lines checked

> Signed-off-by: Steffen Vogel <post@steffenvogel.de>
> ---
>  drivers/w1/w1_netlink.h | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/w1/w1_netlink.h b/drivers/w1/w1_netlink.h
> index 08cbf08f3649..7873eb54352e 100644
> --- a/drivers/w1/w1_netlink.h
> +++ b/drivers/w1/w1_netlink.h
> @@ -61,19 +61,18 @@ enum w1_netlink_message_types {
>   * The netlink connector data sequence is, struct nlmsghdr, struct cn_msg,
>   * then one or more struct w1_netlink_msg (each with optional data).
>   */
> -struct w1_netlink_msg does n
> -{
> -	__u8				type;
> -	__u8				status;
> -	__u16				len;
> +struct w1_netlink_msg {
> +	__u8 type;
> +	__u8 status;
> +	__u16 len;
>  	union {
> -		__u8			id[8];
> +		__u8 id[8];
>  		struct w1_mst {
> -			__u32		id;
> -			__u32		res;
> +			__u32 id;
> +			__u32 res;
>  		} mst;
>  	} id;
> -	__u8				data[0];
> +	__u8 data[0];
>  };
>  
>  /**
> @@ -117,12 +116,11 @@ enum w1_commands {
>   * One or more struct w1_netlink_cmd is placed starting at w1_netlink_msg.data
>   * each with optional data.
>   */
> -struct w1_netlink_cmd
> -{
> -	__u8				cmd;
> -	__u8				res;
> -	__u16				len;
> -	__u8				data[0];
> +struct w1_netlink_cmd {
> +	__u8 cmd;
> +	__u8 res;
> +	__u16 len;
> +	__u8 data[0];
>  };
>  
>  #ifdef __KERNEL__

