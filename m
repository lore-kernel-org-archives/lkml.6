Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67861C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1096220652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="abPqzUXI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fg8hE1xv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1096220652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbeJHSaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:30:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35004 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbeJHSaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:30:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 10D8C6083C; Mon,  8 Oct 2018 11:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538997550;
        bh=e7q2q2K2dKKC2J4ox1lUzVc7HN5zLyyq6D8v6wrybDU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=abPqzUXI+Sns0kjZaA9q/IPkSF2R3RNc6UvTIS8nGVTKW5fHFPCXDkZ6ydIzM3SzP
         QIORnqTY6NTNYiDk+JNYDoYPwBs3iE9NXamjq+Wb70BmTCcugIM6jE4ctO8/JBeIad
         vIjIMekZmBQp5GLzshCand4rmtHW+xTVlS/D4JvQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id C7E68605A4;
        Mon,  8 Oct 2018 11:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538997549;
        bh=e7q2q2K2dKKC2J4ox1lUzVc7HN5zLyyq6D8v6wrybDU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fg8hE1xvG2Qv2BEoP9/pKkQJ4K/DGQVDFjTMNGzguAJFVdGdJ0aMcASRhFkXXHVjc
         xZ6URGowuCzWQg6TXNFSZpzZbRVCzamQS0VpFLDsw7UsOJSxS9AEXCz/hE7m8aFXC5
         4a9PgHBzrSwYc6OR+25LINQsJQyXITlXmYbFyp58=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 08 Oct 2018 16:49:09 +0530
From:   Vikash Garodia <vgarodia@codeaurora.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        linux-media-owner@vger.kernel.org
Subject: Re: [PATCH] venus: vdec: fix decoded data size
In-Reply-To: <68f15b8b-3121-3412-2ad1-6647e9afc264@linaro.org>
References: <1538566221-21369-1-git-send-email-vgarodia@codeaurora.org>
 <68f15b8b-3121-3412-2ad1-6647e9afc264@linaro.org>
Message-ID: <a0758f3e3c214f8d6659cf85d6fbe67e@codeaurora.org>
X-Sender: vgarodia@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanimir,

On 2018-10-05 20:56, Stanimir Varbanov wrote:
> Hi Vikash,
> 
> please, increment the version of the patch next time. This one must be 
> v2.
> 
> On 10/03/2018 02:30 PM, Vikash Garodia wrote:
>> Exisiting code returns the max of the decoded size and buffer size.
> 
> s/Exisiting/Existing
> 

Posted v2 with above comments.

Thanks,
Vikash
