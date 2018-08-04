Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E9BC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 23:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49187217BD
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 23:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="DCEXwBF9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49187217BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbeHEBtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 21:49:32 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34213 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729663AbeHEBtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 21:49:31 -0400
Received: by mail-ed1-f65.google.com with SMTP id h1-v6so3447346eds.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 16:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0omvSgcHKNQQJ871ENut4sC8memhURlKwtub6d2LTLU=;
        b=DCEXwBF96NzgXmm1UFM7W4IN+BpF2ubxDIYGlY+Bo9aBGdkq8CC7i65KdTMSI7cQBD
         gNyuo3N1BWf9KOt/vmYWZV1KXa+MCG1z78/HqnJMq91393gTAypN+Wlc7+3oahF2v/9j
         5U9eIfr41QQqvsRXdCFY61qqacupXm3zvOunoizV1zg1YkKIH6w9E0UpwI7mNxJ/Vs92
         P5p6eZZaVYtF9PqO1N93ZF10ljlExi263JflHWna+OEV0hddXwwacIY2Jmd+x+I7F8UD
         PSpGQOeBzMaMzTgC6xP9b2rAWxlj/OS9R+OscpRyNQjePhCx5NCiBJ8cxOtutdBwY15G
         RyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0omvSgcHKNQQJ871ENut4sC8memhURlKwtub6d2LTLU=;
        b=XfTilgbISVJpTjhwhIb6HMhY60K9FUCfg0mShp+eyBuo4zqlLq4pJA/ypEfpR/Vf6b
         N+Ukj2NS7iawFySRDPf7yn2UGrH+C5B9t/Ccs6rMAWIsvDD7CUCK7qqqFD8bhb+zTxHX
         6HXYB2Xd8LNjaAAw+YsoM4+1Fabv+Oue1Z9jliLMqQxxrGV89u6SVlVb6Kjmq84WukFK
         9xTuK8vwYOtsxYbXpvfdAFxGPNKjMMR6vtRaFHaNfo1oOcuvIha5PwA1fk8aNGMZ6zal
         YMzm1TggKVdIgRZGlZQjqgMyQYvTFylvAnAkRPBU8p2/znmogqSXr6Kzc3/61TED3Zxx
         Hr3Q==
X-Gm-Message-State: AOUpUlFYC+f0Vy4omw9NWwm/S3nIZ/ciIBCLdZKVQlqmioSxxguG8sod
        QfyvCaR9HPVjaauv3CQ8n/55PEmk/zY=
X-Google-Smtp-Source: AAOMgpcMP2IcQb2danMZG0EG42HjeKkZgUgMiDN83XZE+N8icBX4L1y7APpe56C2mze6yb4OiSCT9Q==
X-Received: by 2002:a50:f5ad:: with SMTP id u42-v6mr12420656edm.93.1533426428090;
        Sat, 04 Aug 2018 16:47:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:5459:5b7e:632c:59fc])
        by smtp.gmail.com with ESMTPSA id t44-v6sm4655827edd.96.2018.08.04.16.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 16:47:07 -0700 (PDT)
Message-ID: <1533426425.2679.154.camel@arista.com>
Subject: Re: [PATCH 4.4 106/124] netlink: Do not subscribe to non-existent
 groups
From:   Dmitry Safonov <dima@arista.com>
To:     David Miller <davem@davemloft.net>
Cc:     natechancellor@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        herbert@gondor.apana.org.au, steffen.klassert@secunet.com,
        netdev@vger.kernel.org
Date:   Sun, 05 Aug 2018 00:47:05 +0100
In-Reply-To: <20180804.163348.896647113172060665.davem@davemloft.net>
References: <1533424322.2679.144.camel@arista.com>
         <20180804232102.GA3982@flashbox> <1533425198.2679.148.camel@arista.com>
         <20180804.163348.896647113172060665.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-08-04 at 16:33 -0700, David Miller wrote:
> From: Dmitry Safonov <dima@arista.com>
> Date: Sun, 05 Aug 2018 00:26:38 +0100
> 
> > Thanks for the testing, sorry again for the breakage.
> > Will send the patch shortly (with sizeof(unsigned long long)
> instead of
> > hard-coded 64). Hopefully, not too late.
> 
> 'groups' is "long unsigned int" not "unsigned long long"
> 
>         long unsigned int groups = nladdr->nl_groups;
> 
> And nladdr->nl_groups is specified as "__u32"
> 
> So the size of the relevant bits is actually strictly 32-bit.
> 
> This makes also the "ULL" in your constant specification incorrect as
> well.

I think, ULL is right - I did it to make shift for 32 well-defined.
(which in result has 32 bits set)

> 
> So much crazy stuff going on here :-/
