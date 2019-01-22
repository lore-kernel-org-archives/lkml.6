Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE287C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A948121019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548154858;
	bh=vzuO/gdu7IDNL8aux4cvtcCD08EK65wVyoLPLTFRzBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RZYiC3cVR5aBbb0hhfzsQlmzR/DW7zGNq1Yv3jhqaK3tdUhY+G15Zxqsi73zk7o4x
	 iZK+8jc456Q5pQTXII0unDS4ll+1kpEmkqTFagjms0bTcYoDjeCOjBU8R3VvqHoUps
	 BcgmxDNOGl9P8KrIy/4WxEC4kTmwzA45STtUFurg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfAVLA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:00:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:56220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727332AbfAVLA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:00:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3F9720870;
        Tue, 22 Jan 2019 11:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548154856;
        bh=vzuO/gdu7IDNL8aux4cvtcCD08EK65wVyoLPLTFRzBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TMAm+1vFRPO+h5fjcKJGQHevBr41w9G8PISWW1j5p7JdLPHNLhr44/TBzZeqR9iDD
         nQlhbetaPv2VsriXA+3FIyEc7Qq/qo766PHbwvo3jkokiqnKlvBMA0UuqqVjPVCyw7
         IliDWvo3aeMObOYPEyDlySWi/V3uEXfR3NjZxGGs=
Date:   Tue, 22 Jan 2019 12:00:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Liu Jian <liujian56@huawei.com>
Cc:     hamish.martin@alliedtelesis.co.nz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] driver: uio: fix possible use-after-free in
 __uio_register_device
Message-ID: <20190122110053.GC21034@kroah.com>
References: <1546952508-186003-1-git-send-email-liujian56@huawei.com>
 <1546952508-186003-3-git-send-email-liujian56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546952508-186003-3-git-send-email-liujian56@huawei.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 09:01:48PM +0800, Liu Jian wrote:
> From: liujian <liujian56@huawei.com>

Same problem here.
