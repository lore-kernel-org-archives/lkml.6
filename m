Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E7EC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB03B208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9pQjyHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB03B208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbeJPCYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:24:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:39446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbeJPCYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:24:36 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22ED6208B3;
        Mon, 15 Oct 2018 18:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539628689;
        bh=IitQw2EkUiOqrV8F20Ff8BE2zqFIfWkis+jHW1YpsAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s9pQjyHUbOnJrIMSEBBggpk2Jov6s77naeBWZJC90iORg7jspjIBc7zb7A1+ooSoc
         6JhLSSkqomdo0+oiOD3nqapjMak3L8FyNBpILmF56+EM4fdFCRCdmu9mDySKBycnTO
         8agzOS/wZ8Awi7n61/odiTPIF7MVnFWKElymvlUI=
Date:   Mon, 15 Oct 2018 20:38:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rkir@google.com
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com
Subject: Re: [PATCH v3 09/15] platform: goldfish: pipe: Move goldfish_pipe to
 goldfish_pipe_v2
Message-ID: <20181015183807.GA6905@kroah.com>
References: <20181003171720.169953-1-rkir@google.com>
 <20181003171720.169953-9-rkir@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003171720.169953-9-rkir@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 10:17:14AM -0700, rkir@google.com wrote:
> From: Roman Kiryanov <rkir@google.com>
> 
> This is the v2 driver. v1 will be added later.

This does not make any sense.  Why are you renaming a driver that has
been in the tree already?  It's not "v2", it is what we have today.

If you want to add a new driver later, great, but don't change the name
of an existing driver for no good reason.  Userspace has a tendancy to
break when that happens.

thanks,

greg k-h
