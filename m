Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47F0ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67DBD20833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKC28EVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67DBD20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeINTOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:14:18 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44623 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeINTOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:14:18 -0400
Received: by mail-lf1-f68.google.com with SMTP id g24-v6so2719752lfb.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 06:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uUTJb8k/MHCKoeoqST5LNRlCz8FSQMaUKzHvmDlEuw0=;
        b=VKC28EVlLiLpIsHM0EorNzvd7mmcAKm3Rzv3PLtok2hPVZmtA3/OFd7clz/1vy1q1t
         +iqnQ7eR8cYlUdaHTm5qBCXumK15E8h2DW21PFmSQafwUry8eK+h7q5OYDewEWklqx6z
         H7Z9WM83sC6XQS5N/rSQfssF1Y1hBl1P6q+eXnknxkGDT/FFKsBMiXcG+u8/RtIjleQR
         KqPkaLpm5JP4AHfoxknL1D8RVazs1lXxkPzm0soaEhYCFqOHCX1lv2Bd8qcwbfAPyign
         iyRGPfxB8TJSmxv7z3arThXdExcPkYaBhoZbZ4dSn3HIOzXlPqDNd3fmv+Hy4LwYgpb+
         K26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=uUTJb8k/MHCKoeoqST5LNRlCz8FSQMaUKzHvmDlEuw0=;
        b=psDd2QTAxdU163HwXkzABrYDbwY7vDQeetW/jEh2AjLoxByLXlLMu2HO3SSQkoPIdf
         bY61nXAqIc65LgIjlzGF9oFCqdElFGcErfAeqlw99vzD5kKJFS6rFaGyNILt8iZTUanu
         M2E5QrJcFo3wV4FlIKxpZaWT5CoAZP2yNSzgwz7BgmMqX1O3t7V7Mt/yXQ1c0Vze/GQF
         EGiXb9SPXrkQElVvg5dLoleGRSl12Rx7STzggoRu7rjfo19lzR4ghv3seQ08V1ehgWt9
         Qth9zZO32CLGA8QJctzMzn+AiFoiswpn5JpVf1s1nC1PeM+mGjp7NVQpoF5F2y0kElXP
         JjlQ==
X-Gm-Message-State: APzg51CuPHDy6sqAQhemAdy7lIfDRLJooErTvTmYlTFGnvBp2/UKcRQM
        tEw1e/44edk5/Ov68KAv6cU43wuU
X-Google-Smtp-Source: ANB0VdbRJNsu/S/lgwNNNqVpZo7kL6Km66MuP8A0fTZikZSem7xntHGcb65Dv4EX9mxVZ2q7cI2/2Q==
X-Received: by 2002:a19:ed17:: with SMTP id y23-v6mr8398715lfy.65.1536933578281;
        Fri, 14 Sep 2018 06:59:38 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id e41-v6sm1269236lji.37.2018.09.14.06.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 06:59:37 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g0odH-0005mC-Pd; Fri, 14 Sep 2018 15:59:39 +0200
Date:   Fri, 14 Sep 2018 15:59:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/50] io_ti: switch to ->get_serial()
Message-ID: <20180914135939.GL1362@localhost>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-24-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913024049.24567-24-viro@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:40:23AM +0100, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Johan Hovold <johan@kernel.org>
