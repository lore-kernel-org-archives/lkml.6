Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6588C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786AD2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548409954;
	bh=JGiPWieOtzgzompoTfZzZ1olykcbteCi+dp+PMWioBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oyFeqU7zin1eFeQtGxdoBGU8u90H+BT7TvnNiJf1XRuehp8UD70uaKOKQoU8zDxcU
	 G5QL+qXR/OS5tICdVRHZMoPLtEucg2ySo9k1bbb7k+YdLlR2uLpYwzzzonJWP/cZkZ
	 wfBocu16S95TCvhek8D/BB8Eu+ZOorDXPmDuuLFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbfAYJwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:52:33 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40836 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfAYJwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 04:52:32 -0500
Received: by mail-lf1-f68.google.com with SMTP id v5so6475419lfe.7;
        Fri, 25 Jan 2019 01:52:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aHDUmqvKIuawxiIyHT/yvA/mOScL2A37TOKwl2en1lY=;
        b=SdD1aYY3x4MkeV1pAw6VYnD6LyPi1sZ+rOGQZm8iX1Xqsmo+12O1cjl+LQA29RvZIp
         1J8JQqPt0ARm7mxqAFle10fD3KC6di4MjtEd4SGLcAdfvP3LIJi+2cfPkytvsMiKwTD5
         /YzhlguyHdg4vzKgjn1TN2zIOe4zZ8Esz3mobGwdrf9S3X7ywqEQnvPcvR/lNyHoEUUd
         vI4GG5NDPu1GhYj7L/7RDdnp6ZnH/1VzvXGxhlV2pvU5PKQTQ3IDXt+xFRlNIB0abXc+
         Zu25Zc+lV/25ThQKhNAoK5g66f9krlUT++vIafXNNbEvRjrkZ/oxu1oJN3m1nlWlSN8l
         qxig==
X-Gm-Message-State: AJcUukfNFtDPg+DogTr3FMtuWVsV4gGKHRPxCgT091U8Dcrc9wu1NDpm
        0+/47f71TRTXdZiTC4k8rHs=
X-Google-Smtp-Source: ALg8bN6gq/kv7qflqp514/ry7/PH8CP6fseGu8eC7YrNwQqsICFhCOAqZZOnZUx7K+FWfayWPaLGhQ==
X-Received: by 2002:ac2:4116:: with SMTP id b22mr7780544lfi.19.1548409950549;
        Fri, 25 Jan 2019 01:52:30 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id p67sm1389005lfe.14.2019.01.25.01.52.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 01:52:29 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gmy9x-0000qI-Gj; Fri, 25 Jan 2019 10:52:25 +0100
Date:   Fri, 25 Jan 2019 10:52:25 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Mans Rullgard <mans@mansr.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Karoly Pados <pados@pados.hu>
Subject: Re: [PATCH] USB: serial: cp210x: support all gpios on CP2102N QFN28
 package
Message-ID: <20190125095225.GE3691@localhost>
References: <20190124134839.13316-1-mans@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124134839.13316-1-mans@mansr.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 01:48:39PM +0000, Mans Rullgard wrote:
> The QFN28 package version of the CP2102N has three additional gpio pins.
> Add support for these.
> 
> Signed-off-by: Mans Rullgard <mans@mansr.com>

Thanks for investigating and enabling support for the remaining pins.

Now applied.

Johan
