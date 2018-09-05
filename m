Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CADC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F16C2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+YBv5BR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F16C2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbeIEXaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:30:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43530 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbeIEXaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:30:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id k5-v6so8745149wre.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 11:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=auQmh5ZW7RjjsBPWpkB2PEkNez/J4P1KmZTtd9wWg7g=;
        b=M+YBv5BRE8sC4XnX1Cg28VlfcB1K1oLYhiUyaD+cuGs7W4rRupV7ItUQBOfvBNWxQ7
         XKv9q9xVI6nPKzJE2YJ36GzO0fg0Jrsyu5tVLwiTyHeBMeX9UzOFoaonVl6QztAIdi+1
         U97tDwz5JzaP8MvCJEPSPkeV1wYB4dNzRvIF+JGTYgk+tYKOGBG/42A44xlPVFdw0Mih
         FlqQEGMDzCaXO6Ft9Poz64OdlbBr2ZiAoChDUl4Df2+wE+AxAy29f/JkwYgITsTnAvJx
         gQUakFmd09c0CUpX5oNVklkdvG4IyGZ1POuZqjjSnA3lQsz6PzCPk9h9DJWGCT4MpAP1
         q4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=auQmh5ZW7RjjsBPWpkB2PEkNez/J4P1KmZTtd9wWg7g=;
        b=fdTRrAvae37EMw642ZvQdMPRUx+BnBlB6Dc0n/5JjToDJeGRiNnqLBVpDUfbilF3pg
         jSA8eRRWqZ4UWD+XSWH99bajSAYZNqlmrm5TPz/JFgqXsy7ToiCB/l3Ke+nYv8QZ4Mv2
         4DTYubpPy5OUoHghAipoBtRHEpSczECWYJSK0eZ5pD4EIE/JJXTRZmgM3jOPYg9fMT8B
         8iEUyvqq9Jbh30XAw918Ydj0I3VEDMbpnbTT5nrUws1MTtTW3ANZm7hyV7tgpP+bjbI4
         GY5xXJGZLOi+hDdyPeiy9kV4WYKc7oc3RhWxMBhVsw/LBknv7PQyBbyxH/8BjgB4cZR3
         i8Fw==
X-Gm-Message-State: APzg51Dnwvdz3dfC7/hzhbzDAWPmY3APVk201vR5e+E1Z3xuB/FZiV1F
        V3u5p/s0kpUl+68y55mPB1gMNT4=
X-Google-Smtp-Source: ANB0VdZdaFiPTB2dOgDethdJ/68oHMS0HbipGM1zz1VNmn1Lsas5cGvK90NRRsoAbPT3rZ4umrrRRQ==
X-Received: by 2002:adf:eb47:: with SMTP id u7-v6mr27870971wrn.22.1536173965721;
        Wed, 05 Sep 2018 11:59:25 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id c10-v6sm5922703wrb.17.2018.09.05.11.59.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 11:59:25 -0700 (PDT)
Date:   Wed, 5 Sep 2018 21:59:22 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, dhowells@redhat.com
Subject: Re: [RFC] UAPI: Check headers by compiling all together as C++
Message-ID: <20180905185922.GA25461@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Sep 05, 2018 at 04:54:27PM +0100, David Howells wrote:
> > 
> > Here's a set of patches that inserts a step into the build process to make
> > sure that the UAPI headers can all be built together with C++ (if the
> > compiler being used supports C++).  All but the final patch perform fixups,
> > including:
> 
> Wait, why do we care?  What has recently changed to start to directly
> import kernel uapi files into C++ code?

I think David is seriously trying to compile kernel with C++ compiler
and this is first step.

He isn't alone. Resistance is futile. :^)
