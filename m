Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B89CECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0552B20852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GHiv7SkR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0552B20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388213AbeGWXLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 19:11:44 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56045 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388105AbeGWXLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 19:11:43 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so554720wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 15:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ysg63dtrR5zXVNM1XeDRu/vIWLmKfI5yyeI33Vyn0qk=;
        b=GHiv7SkRf5X3eDH2JDQD/7CW88wj+48qsY8hbFCTjz4lqkEOvwLfYFlup1ChnLxxmD
         PwhLA8ncwVbaLuVFR8n0i8fAqft9R2xGGr5pditqMy+vITF95TcU9NMEfpD3g9zMiTMU
         qJZ2f6+Ki2iDb7rmx2zIRmvzNJFpQBlQYASVwkGpyXmBNQ6u6vCEMhOLlQSVTW5Cqps9
         +cIOZxLaqY0yuB8CkK0TkXCyE8rt5v4cxLgcr9xH4aRN/6wVyhibX54mTjY2b5yhUfqc
         DzduqGzLYaDY54wjnLx+Pulw0iaHnvs3B0P6HU13atrx3mYZilFMSVixrHtFG+dsKJW9
         ec6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ysg63dtrR5zXVNM1XeDRu/vIWLmKfI5yyeI33Vyn0qk=;
        b=qB8Mhf3udqds5hHvYM3VO9Zxd5cjm0dIZ/u9OtiT/Kz+O+DK4LHWiBwCcc/8skw5Tt
         1QsdFNwU6WWTGS4YGBcGWooE+na12I2aqeCMtuPKUtj0UuDx0rLYHHKNiXvZNYOZ1FXm
         lwQ+tp6WApY0IoNzUoTx+Gew1uiJcpTxHAZ8OhymDPUxt92vYE1D0tnrPZDHuMj6jlXO
         x8QYQglJn+S1I9CNoHDgDlsrtjgrggy+N5qhHVlsmaj8I2GhnUE0kikRJY60aD/QucJU
         0yixJlJxRw9ckpv6URZSeVcd86nsDthMi65hLdb5yvsZwHuFh4ezf+k124XwRWYt4Qpo
         GH4Q==
X-Gm-Message-State: AOUpUlFvDutGJm3Q+prWNJVnueXz0ZpOqM6G+J8xiIJVnIFtOnAkodsq
        9vJWChxve1b24j3Kato/xMDugw==
X-Google-Smtp-Source: AAOMgpezkvNF2gh7CGJgby7zsuVFdxjEA7Rd926FtFBN8lUaY9+7AQMrm39ubgROqly5xhFkZSed3A==
X-Received: by 2002:a1c:1509:: with SMTP id 9-v6mr372164wmv.142.1532383706040;
        Mon, 23 Jul 2018 15:08:26 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id a13-v6sm11668886wrf.93.2018.07.23.15.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 15:08:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fhj0A-000831-3t; Mon, 23 Jul 2018 16:08:22 -0600
Date:   Mon, 23 Jul 2018 16:08:22 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: add support for partial reads
Message-ID: <20180723220822.GJ532@ziepe.ca>
References: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
 <20180723201956.GB26824@linux.intel.com>
 <fb053916-f6e8-3266-14d7-128e062b6a92@intel.com>
 <1532380412.4112.22.camel@HansenPartnership.com>
 <7441b5ef-18d8-13aa-ef4d-40fe684c9218@intel.com>
 <20180723215620.GH532@ziepe.ca>
 <dabf6cf5-e62c-721f-9f19-18da34d52ec1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dabf6cf5-e62c-721f-9f19-18da34d52ec1@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 03:00:20PM -0700, Tadeusz Struk wrote:
> On 07/23/2018 02:56 PM, Jason Gunthorpe wrote:
> > The proposed patch doesn't clear the data_pending if the entire buffer
> > is not consumed, so of course it is ABI breaking, that really isn't OK.
> 
> The data_pending will be cleared by the timeout handler if the user doesn't
> read the response fully before the timeout expires. The is the same situation
> if the user would not read the response at all.

That causes write() to fail with EBUSY

NAK from me on breaking the ABI like this

Jason
