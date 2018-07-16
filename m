Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F85ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91FFA20BED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkbt2/U+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91FFA20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbeGPQy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:54:29 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37738 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeGPQy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:54:29 -0400
Received: by mail-pf0-f193.google.com with SMTP id a26-v6so4454523pfo.4;
        Mon, 16 Jul 2018 09:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xANKXLwH8VzqiAp9dTSNnuSsgLWkqdqYVnqqLfgtOnM=;
        b=lkbt2/U+96H2/lidGp8UhgQJsHcnCzQaeEYYrGv7QbTgqWuMPXVqmNWCs5BgQEMJfc
         NFkJz4oRo7W1L+qvCIliUoiCD4QbdRU7rVvnZN/Wpe5PmoRXVltActEJcyORxoh0HFpA
         qHn/CWRBIM3b7rDFntguLHkbJOyR5iLrZM5SNMqe3F0Fq85kDuo66JuX2YHW7OxfamF5
         XyPAFf3mQ5TwVRG5lXyC/tmCi+4ApbOm+fdBqSgymL+irlPVIWQmIhWroAw0NoTAQQnV
         QWPGAguunVZ2KVn0lcRoQxo2IGqhr7gyE+AMNVN4X+49fIX+sciR+e7fI8HuK8psfaJv
         HP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xANKXLwH8VzqiAp9dTSNnuSsgLWkqdqYVnqqLfgtOnM=;
        b=gKM2dSvBnczPRnQj4VRnfohUBG6aQ4crK4HtHpGTiRm8eJNUAYWj+QuqV+LzBJaI/u
         6f3lyLuA+JSLAR2pFFO7frHdYxNvV8Mp7p+iJ9ILIfsWledvPixT0DY/KUhXYfnfZY22
         mW5ZbbJibhYKrT2KmkpKq4hKqz+hzzwMsEBOrDKtefg4RuefWSyRWT6QS6L1cUqoXfMC
         qGlTfIETaECa9ydjAgbIUL12rxyftIlfHnj89/GQW00kec3hyKj661zmNtaVsQ366mPt
         ZIA6yzkvwnwWyFmuSPXwpoMJdshgAuZ69TCkiSyOa9HTgnjibomhZlVyfuafEJVQ+Qmt
         gxVw==
X-Gm-Message-State: AOUpUlHTcqaX/m0/FzCwGGgOCUKTS/JES0/7cKzRA5rgRqHaAQ+wB0U+
        jSNGfmgtk25dDYFdnnKAmik=
X-Google-Smtp-Source: AAOMgpdB0PHqqSD17fCfH7l8VVQ4hKB4Y9zfjfFGdu8WdahKWDhACfe9mrjq5fsj78Spdr2qqXnrQg==
X-Received: by 2002:a65:5c83:: with SMTP id a3-v6mr16178389pgt.164.1531758379793;
        Mon, 16 Jul 2018 09:26:19 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id d11-v6sm49627923pfo.135.2018.07.16.09.26.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 09:26:19 -0700 (PDT)
Date:   Mon, 16 Jul 2018 09:26:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/54] 4.14.56-stable review
Message-ID: <20180716162618.GC12065@roeck-us.net>
References: <20180716073450.534886211@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716073450.534886211@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 09:34:57AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.56 release.
> There are 54 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jul 18 07:34:24 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 173 pass: 173 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
