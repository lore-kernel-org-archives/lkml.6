Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B929F83CDE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 08:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B788920893
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 08:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B788920893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbeG2JrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 05:47:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55640 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbeG2JrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 05:47:13 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 506D1BD8;
        Sun, 29 Jul 2018 08:17:36 +0000 (UTC)
Date:   Sun, 29 Jul 2018 10:17:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH 02/10] staging:rtl8192u: Refactor use of enum
 dm_dig_sta_e - Style
Message-ID: <20180729081726.GA2216@kroah.com>
References: <20180727232826.28014-1-johnfwhitmore@gmail.com>
 <20180727232826.28014-3-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727232826.28014-3-johnfwhitmore@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 28, 2018 at 12:28:18AM +0100, John Whitmore wrote:
> Refactor the use of the enumerated type dm_dig_sta_e, which is not
> actually used for type checking by the compiler.
> 
> The enumerated type defines values for the enumeration, which are used
> by both dig_state and dig_highpwr_state, (members of the struct dig).
> Both of those variables were defined as being of type u8. This negates
> any usefulness of the use of the enumeration, (compiler type checking).
> 
> To make use of the compiler's type-checking the two member variables,
> dig_state and dig_highpwr_state have been changed to being of type
> enum dm_dig_sta_e. The enumerated type has been moved above the
> struct dig definition so that the enumeration is already defined when
> compiler reaches the two types using the enumerated type.
> 
> In addition the 'typedef' of the enumerated type has been removed to
> clear the checkpatch issue with declaring new types.
> 
> These changes, whilst convoluted, are purely coding style in nature and
> should not impact runtime code execution.
> 
> Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> ---
>  drivers/staging/rtl8192u/r8192U_dm.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
> index e86dda99c223..2444e1c1357b 100644
> --- a/drivers/staging/rtl8192u/r8192U_dm.h
> +++ b/drivers/staging/rtl8192u/r8192U_dm.h
> @@ -64,6 +64,13 @@
>  
>  
>  /*------------------------------Define structure----------------------------*/
> +
> +enum dm_dig_sta_e {

Don't end an enum with "_e", as that's not needed at all.

thanks,

greg k-h
