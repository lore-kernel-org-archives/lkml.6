Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9369EC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F222086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZhhwWlp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F222086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935157AbeFROsE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:48:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934657AbeFROsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:48:02 -0400
Received: from localhost (unknown [27.59.118.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C4ED2086A;
        Mon, 18 Jun 2018 14:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529333281;
        bh=WgkM3FEf8YpO15m0oI6RE2X4dQogcofMfbzet31jSzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WZhhwWlpcPjJMDH+artSmxwsCf/91VTWyvU89ID6VPj4meogw3+0vZvhCOMqvrJAC
         FKNUcnjE2ubsF90baKxhul3j1PMKb28jOwZK+fmw1+6ye3TAVTkmUhE6dXVpiLuVAe
         xodVPlCOKBMYRvhMrbp+MxjmKAXz0Kp6VjYGQwlA=
Date:   Mon, 18 Jun 2018 20:17:57 +0530
From:   Vinod <vkoul@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Kyle Spiers <ksspiers@google.com>,
        David Miller <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>, ray.jui@broadcom.com,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>
Subject: Re: [PATCH v3] async_pq: Remove VLA usage
Message-ID: <20180618144757.GH25852@vkoul-mobl>
References: <20180601202016.169085-1-ksspiers@google.com>
 <CAPcyv4gOhnEcJuZZwCoZyMuLsA65Q0EMx1y94xMyRCySv8XcQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gOhnEcJuZZwCoZyMuLsA65Q0EMx1y94xMyRCySv8XcQw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-06-18, 13:54, Dan Williams wrote:
> On Fri, Jun 1, 2018 at 1:20 PM, Kyle Spiers <ksspiers@google.com> wrote:
> > In the quest to remove VLAs from the kernel[1], this adjusts the
> > allocation of coefs and blocks to use the existing maximum values
> > (with one new define, MAX_DISKS for coefs, and a reuse of the
> > existing NDISKS for blocks).
> >
> > [1] https://lkml.org/lkml/2018/3/7/621
> >
> > Signed-off-by: Kyle Spiers <ksspiers@google.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> Vinod, will you have a chance to pick this and carry through dmaengine.git?

Applied now, thanks

-- 
~Vinod
