Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FDFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B23206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547653752;
	bh=mWApE53W7HxHElG0jsnP1YWdyZFwuISLaWxNnhx88ds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UmmbGk0HdkqeJE++XXuTgCc1bziPYjdwU544+EKqOwyth+fdVmHFXWIatQbv6+/9a
	 XwQSL5H76kuLoWlT13hBqZW5o3SGVExVplk+f50MYSNKJEujUMvo4DV+16lFeur1x2
	 NhLBdFEt24WHBMnkmPFsCl+hXU3WtKjONlREcsHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405045AbfAPPtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:49:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:53684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728728AbfAPPtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:49:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C60EB20657;
        Wed, 16 Jan 2019 15:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547653744;
        bh=mWApE53W7HxHElG0jsnP1YWdyZFwuISLaWxNnhx88ds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZSu946Hxrn6yIh14El6M6WvUZAocEUPmDuk7BHn/vEYbpZSbLXcxxTjEfjMLeXaXA
         A5s3wo7VT2WHu7aw5v6XDwLK+7jlDaVYjeMUcWLaoSh/QbKmJ68Vzj1kUbBTsIbT/w
         nJSgOnGcxDquhAZhdliv3xRYJHtkRWo3kmoHvfYQ=
Date:   Wed, 16 Jan 2019 16:49:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, minyard@acm.org,
        Ignat Korchagin <ignat@cloudflare.com>
Subject: Re: ipmi_msghandler crashes in 4.19
Message-ID: <20190116154901.GA3207@kroah.com>
References: <CABWYdi3oWnOWL8sDfjWX7YC6M5ASuhCZNz8tsCGgjvO5yJJRLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABWYdi3oWnOWL8sDfjWX7YC6M5ASuhCZNz8tsCGgjvO5yJJRLg@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 10:36:42AM -0800, Ivan Babrou wrote:
> Hey,
> 
> We've upgraded some machines from 4.14 to 4.19 and started seeing rare
> crashes like these:

<snip>

Does the fix posted here:
	https://lore.kernel.org/lkml/1547616802-31868-1-git-send-email-yangyingliang@huawei.com/

help resolve this?

thanks,

greg k-h
