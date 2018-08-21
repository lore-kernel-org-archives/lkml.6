Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92703C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 04:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F37B2174D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 04:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5XWDVKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F37B2174D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbeHUHjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 03:39:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41033 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbeHUHjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 03:39:21 -0400
Received: by mail-pf1-f195.google.com with SMTP id y10-v6so7844583pfn.8;
        Mon, 20 Aug 2018 21:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bqK0gWspinBoyv/ZTcK8WWm4gW2UcD3pOBR/7ezZ0h0=;
        b=s5XWDVKbMBJjOlb4zgUxMS99l5ghodh7IqUAP7XKS9tFw8Ius3unUQaoqL8bokBPU1
         /6ic970GoPTd8TY0wkI6Osj8aDK8d7VKXDQshGGBk5ylTXeLiQ1GTy+CD34HUjg5yp2U
         sKD0CEbuAeT/cCkzPRcfVk0Xc6rPaoJr94p2BfogRiLAOSXUy3WzvayGdpG4KUUurpCw
         Ul/FDJd8T3eEjPmkLNNj7cXL+gpms3mAeCuZH+RAybqNfnG9NbPaoAahknR9czORdsEp
         jhY1dDxl93X8IZ5gyVpLEpA2r0GHEbTWamxmBpPQ+Q4of1jUJBOEYfXKiuwahdJEvuJs
         gpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bqK0gWspinBoyv/ZTcK8WWm4gW2UcD3pOBR/7ezZ0h0=;
        b=beGJQnPN4eSQQws0OGQM2I8bO8Pi+U4JUk6PYZPoX7nfgQf1alG4odcWwqhuGtlkU+
         kBgdqlAN7aRf6t/gw8QEEFu82We2VQQnqPyVqtUVrjdcSeXq5i9ii2PsY2NFIAjCPNOa
         ZVbwJC7PyBTiqtyGOoZuOf+Z7BuxZlD5b6PZ4CHqEFnh15EpDXfpzQpOtgcty05nkyqR
         GfbwSMmDeJb7mxJTPDRI8Ff3ywfWkUVLFMv2kuXwAWwQ6cA4lUW1316AXSeSqRQxju/B
         OqSx8fwum3C9gucyOnfAQ98YJ5jMTQf75D0q6WjgS8IJ6d9fRyFGsw3Mo93hey7sP/dn
         TvBg==
X-Gm-Message-State: AOUpUlE0nyyWVO0bFSaE58WcXqPKLZ7ZBou+oS6R81lfEn8PPRIcnNQx
        8iItFsMs5kGPJ8wUcETSzkpy3pMzKFVBXcOc/u+JMw==
X-Google-Smtp-Source: AA+uWPxsbSdV5tlsJxMoMMnfaVkw6RZusYc4Kf/sRvOaO4xzpoCk1DMdnODGfKomO4mWKptxWfgeydQYGaxz5lOink0=
X-Received: by 2002:a63:6183:: with SMTP id v125-v6mr14954996pgb.242.1534825255809;
 Mon, 20 Aug 2018 21:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180821141828.1cb8d79b@canb.auug.org.au>
In-Reply-To: <20180821141828.1cb8d79b@canb.auug.org.au>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 20 Aug 2018 23:20:43 -0500
Message-ID: <CAH2r5mv9SBxdfHhQmREo4HiibgzQpiDpauh5WQdwhGszxVPc7g@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the cifs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixed
On Mon, Aug 20, 2018 at 11:18 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commit
>
>   eacb610d8fc4 ("cifs: create a define for how many iovs we need for an SMB2_open()")
>
> is missing a Signed-off-by from its committer.
>
> --
> Cheers,
> Stephen Rothwell



-- 
Thanks,

Steve
