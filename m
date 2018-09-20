Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D82C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 743E6214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="mI0WfvuB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743E6214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388696AbeIUCdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:33:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33337 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388513AbeIUCd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:33:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id y18-v6so1674053pge.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 13:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KlIFZq0BkhiXStaglp5pOQnVXeaD2lYE0VybL9AYoMQ=;
        b=mI0WfvuB6Uf8JA34dMS4SdFd1lGuFnGO8Ky6fWCibLrSYQW3SbpvbgcnJ/YgVrBuTk
         bNyia8abPCSfpPwXehQpSr3beLV1MWP2PLby6siJy6J7R+Z+5cgOlzgqxxxjEzdi6oq/
         AKPzjN58SpKOEuCmfu9u9RvzPnemqsvJg+QnFizWw9Y9hvT1gtaomMpd0ZqADJhCsV59
         lgp9h5fCNV7SXZIzX4kaCMi4FCtU223SV7wvGRYYxirrc5jTgHWBuua3vJXj7HpDOHGC
         /XVe815UR0bdkDzdSRGu7JU9uM6G63e3ch1tjq54whRjlq4lMEnhbd19kjKTmSB6Qy/F
         Oguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KlIFZq0BkhiXStaglp5pOQnVXeaD2lYE0VybL9AYoMQ=;
        b=cbLpwc6Mx0BlEOdGqjsvHy4girwVVNWTHF+XT4/PhBb7SGyxt2xTrAkuCC5PU4nFB+
         OuadHt1pbPGqGVhhTr4W6hcp3Qt5vT4SZ9OIfxs2Vekx6qXnMRu9pYzLXrttbc3ZlzlP
         lKxSTA3iGkxC0gczHuTdBB87GWKjRnmdbO49tl1FLrN2o3J6YgljxFlBhygan7kQrK+U
         MoZWafBzvi/vFseMXec+M7l5NqulQBEFRv7sF/3P8dJvgFCdGNskxZDrO+67I+tFChag
         RbWNRvJRK37/AraAw5YDqe/gaBLscuubYIM2k/AKs3mk1U+gwmCzzuX5O0OlRAV85JD6
         Z1bA==
X-Gm-Message-State: APzg51AnlFM+4ZILtw6tt83+7plQBGcacjUeK472mZTwpuj7dIq1eJU5
        tEj332jL4pwFugmj/2VTk8H5DA==
X-Google-Smtp-Source: ANB0VdYq2n1piVtOaExGdmqzrfqaunQRn2OHnseOm7xdc8oOIBKhull7xlAVVvSVZOXkR4LTMrqz1g==
X-Received: by 2002:a62:1b41:: with SMTP id b62-v6mr19364320pfb.172.1537476487163;
        Thu, 20 Sep 2018 13:48:07 -0700 (PDT)
Received: from xeon-e3 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id z11-v6sm42952174pfi.4.2018.09.20.13.48.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 13:48:07 -0700 (PDT)
Date:   Thu, 20 Sep 2018 13:47:59 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Haiyang Zhang <haiyangz@linuxonhyperv.com>
Cc:     haiyangz@microsoft.com, davem@davemloft.net,
        netdev@vger.kernel.org, olaf@aepfle.de,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        vkuznets@redhat.com
Subject: Re: [PATCH net-next, 1/3] hv_netvsc: Add support for LRO/RSC in the
 vSwitch
Message-ID: <20180920134725.3e149a0b@xeon-e3>
In-Reply-To: <20180920170701.9574-2-haiyangz@linuxonhyperv.com>
References: <20180920170701.9574-1-haiyangz@linuxonhyperv.com>
        <20180920170701.9574-2-haiyangz@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2018 17:06:59 +0000
Haiyang Zhang <haiyangz@linuxonhyperv.com> wrote:

> +static inline void rsc_add_data
> +	(struct netvsc_channel *nvchan,
> +	 const struct ndis_pkt_8021q_info *vlan,
> +	 const struct ndis_tcp_ip_checksum_info *csum_info,
> +	 void *data, u32 len)
> +{

Could this be changed to look more like a function and skip the inline.
The compiler will end up inlining it anyway.

static void rsc_add_data(struct netvsc_channel *nvchan,

