Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76EEC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B1E20685
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B1E20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbeIZAXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:23:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51666 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeIZAXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:23:54 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 83A951028;
        Tue, 25 Sep 2018 18:15:10 +0000 (UTC)
Date:   Tue, 25 Sep 2018 20:15:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Xavier Deguillard <xdeguillard@vmware.com>
Subject: Re: [PATCH v2 17/20] vmw_balloon: compaction support
Message-ID: <20180925181507.GA25458@kroah.com>
References: <20180920173026.141333-1-namit@vmware.com>
 <20180920173026.141333-18-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920173026.141333-18-namit@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 10:30:23AM -0700, Nadav Amit wrote:
> --- a/include/uapi/linux/magic.h
> +++ b/include/uapi/linux/magic.h
> @@ -89,5 +89,6 @@
>  #define UDF_SUPER_MAGIC		0x15013346
>  #define BALLOON_KVM_MAGIC	0x13661366
>  #define ZSMALLOC_MAGIC		0x58295829
> +#define BALLOON_VMW_MAGIC	0xba11007

Any specific reason why you didn't put the leading 0 on your magic
number to make everything align properly?

And there is no need to put this in magic.h, nothing outside of your
code sees this value.  It is not a user api, so please do not make it
one.

thanks,

greg k-h
