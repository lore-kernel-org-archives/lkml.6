Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC15CC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A615B21570
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKxP5vWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A615B21570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbeHTQLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 12:11:10 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35182 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbeHTQLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 12:11:10 -0400
Received: by mail-pf1-f195.google.com with SMTP id p12-v6so6737386pfh.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 05:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9j1vxYD4bJltNHfXKRJTIpOVdm+dzOzVOQP8ciHPlbs=;
        b=gKxP5vWzolSLyUqDqFR3k0tzCeAME7NaKdR1yM63EWhRRsQxAyZUwuc6YpK4N9vPHD
         ilbDRoba42Bn3UzPDGev+Lel/FZ7+79Ej5B0Yg1HTSnTrudd0hzqUKbseNVnt81p9/5h
         EDPM8uZ7zlBgI5ob1H8ZbyiSS6G+wuHJZS23Cmf3lQZ8cGxNO279c7aRdV8ca+Xdatxv
         EOmHz2+UiNWGoZe+avlgnHdLj61Rr3H9cKroE3hOEGdw826W8YEsMvfs5SAgZWE6V3CZ
         Oy8hv/eXmXX3YVDCccCivN/ujKQ5bTR9RvP9aX0Aoh0DQpEaR7ExYkOuZnftqw8K7fxL
         /4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9j1vxYD4bJltNHfXKRJTIpOVdm+dzOzVOQP8ciHPlbs=;
        b=NENEZKIIVzX2cmXNyRHnEaQKFc2+wNXtAhlQHdD5y448n5DmEPJywWoyBVLymcdC9q
         8etm4H4nEeIJ/QlzWZU3qsHuDiezOw9dnnHe2XjKBYTkI2F5/vGZm2ivSaAYKXZb+c1Z
         iN7sp0UndZN5C38wK/aPu/+Mtum/VR3VtEShzD8baV/qUV+LKtBn32DxCpkU199UpNdy
         mKh6uTbypO84G9ikBr9ED7JOG9blLRSOBY1PeI3q+a+a/sHBNWxwo06QxtS/XnuLdup4
         6QYH2O8HQlRXU1FL1BuLeIU9EOnPkERLGhTRBLNUTLQZWlef5KH9HCbFCFEDtK7CiXVB
         DE0Q==
X-Gm-Message-State: AOUpUlE5BJBPEXW/mBPhRIFRQswrEdWjLkLfCqAJnXKGmgC0cYbP5AuK
        mQHDEKxpcJ76R//5O2yIPRzakr8s
X-Google-Smtp-Source: AA+uWPyUC0HlQhjcpJMYtLkZZYli3TOS0500jx5wgItJVrayYkboRv4BYlMCLsbEhCePBzrPuLVMaA==
X-Received: by 2002:a63:2d05:: with SMTP id t5-v6mr7964407pgt.403.1534769737741;
        Mon, 20 Aug 2018 05:55:37 -0700 (PDT)
Received: from Gentoo-PC ([117.204.240.63])
        by smtp.gmail.com with ESMTPSA id l27-v6sm17373645pfi.180.2018.08.20.05.55.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 Aug 2018 05:55:36 -0700 (PDT)
Date:   Mon, 20 Aug 2018 18:25:39 +0530
From:   Bhaskar Singh <bhaskar.kernel@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: Removed code valid for 5GHz
Message-ID: <20180820125539.GA1597@Gentoo-PC>
References: <20180817074729.GA16204@Gentoo-PC>
 <20180820095042.pgucu7e3i3aiu3lb@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820095042.pgucu7e3i3aiu3lb@mwanda>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 12:50:43PM +0300, Dan Carpenter wrote:
> On Fri, Aug 17, 2018 at 01:17:29PM +0530, Bhaskar Singh wrote:
> > This patch removed code which are valid for IEEE 802.11a i.e. 5GHz.
> 
> I would be uncomfortable accepting this kind of change without an Ack
> from the maintainers.
> 
> The messes up the indenting so we can accept it anyway.
> 
> regards,
> dan carpenter
> 

"find and remove remaining code valid only for 5 HGz. Most of the
obvious ones have been removed, but things like channel > 14 still
exist."
With due respect, I want to say that, the above thing is mention on the
TODO list, please correct if I intrepreted that statement wrongly.

And Thanks a lot for finding indentation problem

Thanks,
Bhaskar Singh

