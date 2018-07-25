Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB21C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D789208A1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8BTha46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D789208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730536AbeGYUdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:33:00 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36612 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbeGYUdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 16:33:00 -0400
Received: by mail-qk0-f196.google.com with SMTP id a132-v6so5647815qkg.3;
        Wed, 25 Jul 2018 12:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PkIPbsLqWQ8vIGr1ybop8eWfl8JMDu89PFgzBBCLUuU=;
        b=n8BTha465MGNqQDzfw/oqaSpUUvmR2g2xm09UWdnI4JolO+XxaSNjCcdAEQfaKHxWl
         KPSF6MQN8VgPSDW0pWzoqXSDuZ7TQ5ik20HHcibPGI5h4U7Es09EIFjPvnsMmiNLQCg1
         p6SPmwdejAIaKJQJKvsuX+qo7Ftfo5+L7ppZQOkF5EjjpzOO2H4opppgEFiZhXY1II80
         1JgjrtCBEDDL/ZcmzyIAAc7MmVLWviQi83WimgwiX8LuVAN8k/oDtc9Xg2rn5O9aLJr4
         0dRUTEb+Fn7c2zDvFsIc02VMUFs9VcElal/wHcvAjQsSaoN3DAUEtdmK5RuymnOgE4dg
         ZNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PkIPbsLqWQ8vIGr1ybop8eWfl8JMDu89PFgzBBCLUuU=;
        b=C7SdKzLUqd3hYUl08B/H9rMzOaFHBlULfJZGeko+usDNb+WixL/ut6WamJO1lUUMyH
         9QnBWPqGkhmegL6nNN13XHG9YnZeYGXjkze+deeVKnHPjl825JbcuCR0Vhvxvo3n3G3G
         JK2B5kPbq9cG3zjeM8077fZ7N/Q1+edd5RyeVlqSP9NMzWCaI6e5PeQkGE/yEA+7xLPE
         A/zODYyCas+8acrpyZx5NjreGdpHK5fK8H9NhcixyHTsiZC/wiTzbx6uz7XN1YvSE6xX
         B04tP/06PXXu3MVIKqyCH1EwMcEeK7lsBpQfwzc6aXKBQ+zKOJtOz/fhn+XenfskYDg5
         TtVA==
X-Gm-Message-State: AOUpUlFZeMR29V0U/9R21MPbQ6IVVvACHGyRh5mMVpWDhwxRF8y4J/dZ
        YVfWmnNupYR9vKO6knu2p16mogc3nHo=
X-Google-Smtp-Source: AAOMgpdCvPPlyo36sWBg2+Gf6lImQEn1XrqcrHuZDbTIKV0gcQkeCsq8cgoVeFK2udsAsIUr8Au8Hw==
X-Received: by 2002:a37:7607:: with SMTP id r7-v6mr14442013qkc.133.1532546396526;
        Wed, 25 Jul 2018 12:19:56 -0700 (PDT)
Received: from localhost.localdomain ([138.204.24.95])
        by smtp.gmail.com with ESMTPSA id m51-v6sm14182746qtc.85.2018.07.25.12.19.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 12:19:55 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id EC558180A70; Wed, 25 Jul 2018 16:19:52 -0300 (-03)
Date:   Wed, 25 Jul 2018 16:19:52 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 4.17 52/63] sctp: introduce sctp_dst_mtu
Message-ID: <20180725191951.GA20482@localhost.localdomain>
References: <20180723122446.351334162@linuxfoundation.org>
 <20180723122448.327988130@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723122448.327988130@linuxfoundation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 02:24:58PM +0200, Greg Kroah-Hartman wrote:
> 4.17-stable review patch.  If anyone has any objections, please let me know.

Both SCTP patches LGTM. Thanks.
