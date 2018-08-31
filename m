Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED63C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FFED2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FFED2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeIADRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:17:00 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33895 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbeIADRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:17:00 -0400
Received: by mail-qt0-f195.google.com with SMTP id m13-v6so16389299qth.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 16:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=9+kN9XK7kQN1LKiImmXWJAGy4DGkuF4BnCsaRNk9fIQ=;
        b=lDYRavZWVghFxFFgQdlUtdNmeDEl/wRLfpSJcwcp+PWqx8ykpPn9g2EgHvov0e6VEL
         //hX0M3EVLvd+Np3yuFrpU2DLAQjL7WqQatw+PrrMgL2KpHZsA0P+KEIjC67PCzlc3SQ
         8EFFlKI/WWewYBeoBdJlEVGvinLsjewdtUBIvYmv89oTouJPnJwQESQdqDPBXezcEbdc
         MRaKpLhVkjSM8fiet52Xy4+fcee1hUjpUSIQxPcF+LrmU+uJrG42+nKi8Ml4Ow1gblki
         QbFIYHEBrKn27Usf49lo+j+1RqqdapWiefInLHO074Q/F8Ll3hbB4RnHJ6vVBqUNEvSI
         2u/A==
X-Gm-Message-State: APzg51DDXxlU8i06TGECeW9DehLcPIZ4HYoOas7jSV9+f9QSQcBNVwM+
        pKWAMG0eWJ696XdVrEbJxGGJfQ==
X-Google-Smtp-Source: ANB0VdZRED1MCbD59Bg6I4DTyZJnOKeiPRsrrZTdjL/WmlhKv0cIAcjSjKQ4blwysaqYOwKkfEEBRA==
X-Received: by 2002:ac8:3963:: with SMTP id t32-v6mr17816392qtb.331.1535756837262;
        Fri, 31 Aug 2018 16:07:17 -0700 (PDT)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id t36-v6sm7477065qtc.45.2018.08.31.16.07.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 16:07:16 -0700 (PDT)
Message-ID: <b0396fff969f5dca0c863992e42f4aba16939906.camel@redhat.com>
Subject: Re: [PATCH 0/2] drm/nouveau: Use more standard logging styles
From:   Lyude Paul <lyude@redhat.com>
To:     Joe Perches <joe@perches.com>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Date:   Fri, 31 Aug 2018 19:07:15 -0400
In-Reply-To: <cover.1535654026.git.joe@perches.com>
References: <cover.1535654026.git.joe@perches.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the whole series:

Reviewed-by: Lyude Paul <lyude@redhat.com>

Nice catch!

On Thu, 2018-08-30 at 11:36 -0700, Joe Perches wrote:
> Reduces object size ~4kb
> 
> Joe Perches (2):
>   drm/nouveau: Add new logging function nv_cli_printk
>   drm/nouveau: Convert NV_PRINTK macros and uses to new nv_cli_<level>
> macros
> 
>  drivers/gpu/drm/nouveau/nouveau_abi16.c |  2 +-
>  drivers/gpu/drm/nouveau/nouveau_chan.c  | 12 +++----
>  drivers/gpu/drm/nouveau/nouveau_drm.c   | 21 +++++++++++
>  drivers/gpu/drm/nouveau/nouveau_drv.h   | 44 ++++++++++++++---------
>  drivers/gpu/drm/nouveau/nouveau_gem.c   | 62 ++++++++++++++++------------
> -----
>  5 files changed, 87 insertions(+), 54 deletions(-)
> 
-- 
Cheers,
	Lyude Paul

