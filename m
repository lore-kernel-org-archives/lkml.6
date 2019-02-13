Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A814C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F55F222D2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550085127;
	bh=NJUH8OjT32lVUv1CGwSZnGc2hl4Bww+5ZiKFTqrJNiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eMeoopHhUZwR4NqlSkZNgSTvxy+njtNqOjVoQlJoRq/EAJcCVuFumvhbRHjmvw2Yr
	 noHWwKJzTHPTl/3nuG5jdy49LVx5O57F3qXBxmyjUGPowRM2iQ6ozBbSNbHdxcq23b
	 XgWRZ7fOjENnXqgZXlajq+USB2B6QquYMzu2x/vw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392603AbfBMTMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 14:12:05 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38035 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbfBMTME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 14:12:04 -0500
Received: by mail-ot1-f66.google.com with SMTP id m1so6216833otf.5;
        Wed, 13 Feb 2019 11:12:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZbC5LnXGubLc1wq4H8M8A+bjL9pfYrq1rvDrOAJZZ3Q=;
        b=nxcUMHigphYnW9uTZ/uKi6lgU2svUZAETQ1lxiMtWOh/qG3ikCueZ8Tmjz0uOdgCsy
         fZfDBZPA2pXBe2+qFis7YBYFU2zJFVC862dQ6Z+bAxvLCpjRLlrCgN61h5K81RyFZsmB
         O4BF/lCfqiladSMEI+k8sWH+GmMyxmekd+AlI1zoLucI/D5H1msxF7+0pNfZSQKs5XB2
         qYg3Z4zjnf0dkID2825uTdxm/SXLzGzal63YdMOJ9EHfPIo48p47Yhn8XZJm45Ls/ZiQ
         8+TcBOFg64O6CeNQu5vWMOH+xq9rX0eayrrJC0QPk/JJouRON0Rz/igcbawWkJujnuz5
         iyGA==
X-Gm-Message-State: AHQUAubsjszY89pE+vC49fNIgtTX5UHq6HiEm+GLWmVGERNuTiwVVVoi
        xcZX7HpiqF0j1WzvJE4CBBuv8nI=
X-Google-Smtp-Source: AHgI3IZS2OASQ/Et5gFwty2u4rBiS7a3G/KOxopC9tVFIXkW152c77OKewjPxb6qPWxNYhAx3fQ/3w==
X-Received: by 2002:a9d:610a:: with SMTP id i10mr1332990otj.186.1550085123468;
        Wed, 13 Feb 2019 11:12:03 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a17sm42312oie.20.2019.02.13.11.12.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 11:12:03 -0800 (PST)
Date:   Wed, 13 Feb 2019 13:12:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     frowand.list@gmail.com, mcgrof@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] of: unittest: unflatten device tree on UML when
 testing
Message-ID: <20190213191202.GA3022@bogus>
References: <20190212185305.112847-1-brendanhiggins@google.com>
 <20190212185305.112847-2-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212185305.112847-2-brendanhiggins@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:53:05AM -0800, Brendan Higgins wrote:
> UML supports enabling OF, and is useful for running the device tree
> tests, so add support for unflattening device tree blobs so we can
> actually use it.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---

For a single patch, no need for a cover letter. Just add any commentary 
here.

>  drivers/of/unittest.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

Rob
