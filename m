Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E0AECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F1120877
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="BgL7dlRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F1120877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391270AbeIVA0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 20:26:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33210 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391184AbeIVA0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 20:26:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id y18-v6so3132221pge.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 11:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lD1HJzkjStdB5/4Tpf3D08ik3IEhfeONrfbEwvYZ+cg=;
        b=BgL7dlRof3reWDSczslWoY2foxgt9kZexljZMzGw8INaNt1vegudCxlceohscPIYDL
         EsRDxwV2GmaXEU2HSsVZm/q7CC4fxdRgrKuTWPX3wG35t38+CBxro/21PxbHC66L8Jfw
         jVhVbzm+kBuvAHIPRinViH2QGA1aFbXC/oM35BwujKIWJHIGtIyV3wugCx0/bZ2l2VMK
         OLO2t1yj4W+LlU7OEjWRWLv5+vZEsw6FcYu9yeiiQQSArcKCFx7zUr9Si7dlhe2bt9EA
         wWn7lj3CIN76zU9tOLz9Ikx9Ua+m7RvzufEndwoikKT+OCJ/6D9McIymZ2PyJErWF9E8
         Rf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lD1HJzkjStdB5/4Tpf3D08ik3IEhfeONrfbEwvYZ+cg=;
        b=ubBoRbGgsDYpf4CRPVu6xuNuUlaga6opOsoajGE4xVDA81HursuodIpV0f+Svmxhf+
         HVS3L26Zjfq3xu22uVLpTkEmpVPjKG3J3n8Z9J3s5OMl0J/nj6/WJ+nyMn+R6REw6Xa7
         iMuMwLN9vWpayHnNYK07Aeoxl9rqH4qko2nbpD7vOPAc9hR1sj894KMbdxMIAbbiVNM8
         pbVTIvnvR27BZ8cIYfpZX0cEn8Mif171cCnimpLFxHexpmkfMxhEQ/90L68b33XYJuUA
         et/sGvPl9Uhh2NnLxcB8o4UBC4yMBwueJDEIkiQSwIGvsxQK82Oo0z4J2B4JhX/1Z/uB
         1W3Q==
X-Gm-Message-State: APzg51CdybvD2ztFBf6OEcqeBsNeQTZnLqQUfOGjnu48CNtr/QACfnWj
        TAATYGjB7gJQarZnTrebPRkM+tyJdqY=
X-Google-Smtp-Source: ANB0VdbupWyo8VWx6FBptjQR0af8RY2I/zOryFTvuXHVSiHb9q6jsITXZMSVlBf+4tA3aaecE2vnZw==
X-Received: by 2002:a65:6455:: with SMTP id s21-v6mr43379290pgv.25.1537555007445;
        Fri, 21 Sep 2018 11:36:47 -0700 (PDT)
Received: from xeon-e3 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id d7-v6sm18473247pfg.1.2018.09.21.11.36.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 11:36:47 -0700 (PDT)
Date:   Fri, 21 Sep 2018 11:36:39 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Haiyang Zhang <haiyangz@linuxonhyperv.com>
Cc:     haiyangz@microsoft.com, davem@davemloft.net,
        netdev@vger.kernel.org, olaf@aepfle.de,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        vkuznets@redhat.com
Subject: Re: [PATCH net-next, v2, 1/3] hv_netvsc: Add support for LRO/RSC in
 the vSwitch
Message-ID: <20180921113620.62a004cb@xeon-e3>
In-Reply-To: <20180921182037.10077-2-haiyangz@linuxonhyperv.com>
References: <20180921182037.10077-1-haiyangz@linuxonhyperv.com>
        <20180921182037.10077-2-haiyangz@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2018 18:20:35 +0000
Haiyang Zhang <haiyangz@linuxonhyperv.com> wrote:

Overall, this looks good. Some minor suggestions.

> +struct nvsc_rsc {
> +	const struct ndis_pkt_8021q_info *vlan;
> +	const struct ndis_tcp_ip_checksum_info *csum_info;
> +	u8 is_last; /* last RNDIS msg in a vmtransfer_page */
> +	u32 cnt; /* #fragments in an RSC packet */
> +	u32 pktlen; /* Full packet length */
> +	void *data[NVSP_RSC_MAX];
> +	u32 len[NVSP_RSC_MAX];
> +};
> +

This new state structure is state on a per-channel basis.
Do you really need this to be persistent across packets?

Could this be on stack or do you need it to handle split packets
arriving in different polls? Or is the stack space a problem?

Also, maybe data and length could be in one structure since they
are related.
