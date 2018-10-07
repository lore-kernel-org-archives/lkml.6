Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A781AC65C30
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 08:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3D720882
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 08:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="bcnJBATG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3D720882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeJGPlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 11:41:24 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33350 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbeJGPlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 11:41:23 -0400
Received: by mail-lj1-f193.google.com with SMTP id z21-v6so15152220ljz.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 01:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JwuQ68bGAMkOzTLOLOFv1Spxtu/G86e8mbw/9vgDtyU=;
        b=bcnJBATGGNxhQz51cwX9WVdLlOzyK/BxPjPY5gRTp2Em3rzHcvB2chL1tne+uQUPdQ
         MwHuaDaAjQ4dGqanlPePexMdiikhhJbv4x2VzZ39rIe5wiy3/0Uu6CJI+mzxHDiS8Dui
         y6HWndvAwnC2ZWWLOeSG4KsGJq4lsTQ0papp8dQWqml1xPjkQJ641zXTCchvk/tVMoYV
         VAflWLFAfskp0FM7dSx3CIj4J86aO6+x9BaaTe+3PBLmRwhWoaQ2N1a2ze1FW8BMI+E+
         zAKhbwXIe3eMA0gMyXgRuGvSjhGhq7bXveGKfJHtIvtEVnPNq0Dmwh82is785fgm4IBs
         9HSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JwuQ68bGAMkOzTLOLOFv1Spxtu/G86e8mbw/9vgDtyU=;
        b=mY7yN0k2iVtHf+Pg/A6F+JNyqh0ZlJU71Yi80LwPiPH8NXXHWnYNeqTN4GqbGtwxiG
         t3u9QHM43lwc3LbgWXtJe+xmImCadoU5CjT/Zsyh2ZrRmgoWAfKNiAXPeXkjBtRxotXL
         /1/qLhvdF6TlGioZFQdhxteTZue/i9v1Q2GAA8VRhtw1uj80MYFyjFvn2C4jAmWWkCQ6
         r78jWPxuqiKVF85UaqmQm9p7IHNFR8an5oaT/5hHqnqTd0+G1E63UAtvpRFYIomI31EF
         mcqXhqFwvZEr5rv7Wz360b8ddfC5e60fwxI2SwWk72Zm8Xs4Ll6F+B9+lsldKdzklZKC
         sEWA==
X-Gm-Message-State: ABuFfohzBMRDEIFQ5KOoeAsi/QInxPq91duKAqCdKaFfXBe0aVMqr3IQ
        PtzhDPbdOX3ws1yHE+tMdMXazg==
X-Google-Smtp-Source: ACcGV62IfYDXhKHxxUKOQdrieKDd7y0WmcxWLYqe2jkA68o2hlp1Zr/vl92JQCOHUtAVl1qFPnZJqA==
X-Received: by 2002:a2e:458b:: with SMTP id s133-v6mr12582967lja.60.1538901290015;
        Sun, 07 Oct 2018 01:34:50 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.84.205])
        by smtp.gmail.com with ESMTPSA id x141-v6sm2851637lff.32.2018.10.07.01.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 01:34:19 -0700 (PDT)
Subject: Re: [PATCH net 2/2] net/smc: retain old name for diag_mode field
To:     Eugene Syromiatnikov <esyr@redhat.com>, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Ursula Braun <ubraun@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Hans Wippel <hwippel@linux.ibm.com>
References: <20181006203226.GA11438@asgard.redhat.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <9081dc32-8d5e-df78-7570-93862ac1f9f1@cogentembedded.com>
Date:   Sun, 7 Oct 2018 11:34:20 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181006203226.GA11438@asgard.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/2018 11:32 PM, Eugene Syromiatnikov wrote:

> Commit v4.19-rc1~140^2~285^2~4 changed the name of diag_fallback field

    The commit citing style should be the same as in the "Fixes:" tag.

> of struct smc_diag_msg structure to diag_mode.  However, this structure
> is a part of UAPI, and this change breaks user space applications that
> use it ([1], for example).  Since the new name is more suitable, convert
> the field to a union that provides access to the data via both the new
> and the old name.
> 
> [1] https://gitlab.com/strace/strace/blob/v4.24/netlink_smc_diag.c#L165
> 
> Fixes: c601171d7a60 ("net/smc: provide smc mode in smc_diag.c")
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
[...]

MBR, Sergei
