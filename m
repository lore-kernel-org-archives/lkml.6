Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64566C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2197321905
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549998698;
	bh=IPJOsrQhcYA9nEJxppfXW5ekczl11u2uR+0+JhMOq7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EovsClA+b5DIYLuPZe3mjvzXml7xEoT3xZWVIheWxauEUl13Ft+7VvIS4tJ/XJbkV
	 Q7XEJ2PtJyX+eAsOImXohf8lW0DAmlAf6G4uZot+L4iRUAFh0AO4kpgX84h4IQ3ZYZ
	 PVgy8rp+tkRMNYG+hZdin+Wh48yalQFwhj0t/j34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbfBLTLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 14:11:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:57056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbfBLTLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 14:11:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E5E521905;
        Tue, 12 Feb 2019 19:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549998695;
        bh=IPJOsrQhcYA9nEJxppfXW5ekczl11u2uR+0+JhMOq7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FMxTGlGvWh1C/nWUipnKtxd4uk0N6BkVyiPROheeO/ZEip0fRO9rL3/rPL1B6s/zW
         OVD033l0bbo6O7WtWzhz9tSQuVeGdRchj5giIbNlT/u5hKRXuSUvXmdJh/+R+zsoe7
         jPWNzQGiX+KgeGWqdrVmUZFwE8Ns/LW2zD9glioY=
Date:   Tue, 12 Feb 2019 20:11:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xiang Xiao <xiaoxiang781216@gmail.com>
Cc:     alexander.shishkin@linux.intel.com,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        Xiang Xiao <xiaoxiang@xiaomi.com>
Subject: Re: [v2] lib/string: add memrchr function
Message-ID: <20190212191133.GA22246@kroah.com>
References: <1549994809-27479-1-git-send-email-xiaoxiang@xiaomi.com>
 <1549997683-27986-1-git-send-email-xiaoxiang@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549997683-27986-1-git-send-email-xiaoxiang@xiaomi.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 02:54:43AM +0800, Xiang Xiao wrote:
> Here is the detailed description for memrchr:
> 
> void *memrchr(const void *s, int c, size_t n);
> 
> The memrchr() function is like the memchr() function, except
> that it searches backward from the end of the n bytes pointed
> to by s instead of forward from the beginning.
> 
> The memrchr() functions return a pointer to the matching byte
> or NULL if the character does not occur in the given memory
> area.
> 
> Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
> ---
>  include/linux/string.h |  1 +
>  lib/string.c           | 21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+)

Don't add new apis without any users.

thanks,

greg k-h
