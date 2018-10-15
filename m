Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33E5C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 07:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1D72087D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 07:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOoMIxC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1D72087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbeJOPSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 11:18:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbeJOPSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 11:18:42 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B573B2086A;
        Mon, 15 Oct 2018 07:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539588879;
        bh=lZAvkkYX3Fe71C89/Tdf6+9kSeDtv+zOegJXjj/oXLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hOoMIxC4nOq4MxVMcvD2TYUwg2W1+CqbqBTujsAZOHHduCmr8qWE3ss3tC97WIHHz
         ox7lFVfEnoYuFuzo+JZyndZ+nwWweWHAi4MsCdiN8MYQgTUrUs1+ek41HAPu7Xk79O
         zji6N2y1wPk1T7vwK7OqvO7QDHtCCjDQN95277ZA=
Date:   Mon, 15 Oct 2018 09:34:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     Rob Springer <rspringer@google.com>,
        Ben Chan <benchan@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH 01/11] staging: gasket: core: debug log updates
Message-ID: <20181015073436.GC14476@kroah.com>
References: <20181015045927.156790-1-toddpoynor@gmail.com>
 <20181015045927.156790-2-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015045927.156790-2-toddpoynor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2018 at 09:59:17PM -0700, Todd Poynor wrote:
> From: Todd Poynor <toddpoynor@google.com>
> 
> Add debug logs for device enable/disable events,

Why?

What is going to need this?

> remove logs for
> callbacks (the called functions can generate their own logs if needed).

That's a different thing than "adding" them, so shouldn't this really be
2 patches?  If it was, I could have accepted this patch already, and
ignored the "add new logs" one :)

thanks,

greg k-h
