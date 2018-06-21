Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF7BC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F1821A1C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F1821A1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754142AbeFUSay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 14:30:54 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37919 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753725AbeFUSaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 14:30:52 -0400
Received: by mail-pf0-f196.google.com with SMTP id b74-v6so1939239pfl.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 11:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hBrx2RO9NgoH71yctiv8WNAwJqP3GeNhSk+BHd0purs=;
        b=F/QQB2rZfhTrDXdudEmAHRCIbyF87Nqmq7VZ2PgNslNC5CMH7eNpgw/hveXk6XDkV5
         FgHtwYOEQAyz9Iz0LHIFURdJSaHGGKZFMTgQouVCq2JRwMOUY5Cxo4veDXeQEUrBxzsz
         KzkQlfa5mFd2U80suJukh3BS8ZoVq1tHfdOJor/NluawLFWxnfMl+ES5HeYPxU0X3X8x
         IvC0mCeYG4aeLzetGvH4sz/+vsM7rglfbi3gdeNIkxkOrpZtukSGCc7eLdjSd7Ju8dbS
         hH2OlUYO3m0oZEIudZPORrw46ZmgxdtshZZFGvRF1kwNQotuUzGjxk/ItQ46Zxs24gH2
         e3Cw==
X-Gm-Message-State: APt69E3KjjREVl2pNZynvb3q6Ihehee0/mSgZ1uM5sWhgec7pR49x9+h
        jQxF82kal7NDuath2eXYmODkNg==
X-Google-Smtp-Source: ADUXVKLMTQoEojCYVQ3f4E7LPVYAq3DzAwap4X8+gyDSypBq0/LtGuHGYUjvu8cyimF8g3ji8WskgQ==
X-Received: by 2002:a65:520c:: with SMTP id o12-v6mr23718637pgp.15.1529605852191;
        Thu, 21 Jun 2018 11:30:52 -0700 (PDT)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id 8-v6sm10197411pfk.132.2018.06.21.11.30.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 11:30:51 -0700 (PDT)
Date:   Thu, 21 Jun 2018 13:30:50 -0500
From:   Moritz Fischer <mdf@kernel.org>
To:     David Miller <davem@davemloft.net>
Cc:     f.fainelli@gmail.com, mdf@kernel.org, keescook@chromium.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: nixge: Add __packed attribute to DMA descriptor
 struct
Message-ID: <20180621183050.GA9986@archbook>
References: <20180619165453.31894-1-mdf@kernel.org>
 <832bebb8-300d-e911-2946-5edfe82dc30a@gmail.com>
 <20180620.073750.642289685695664600.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620.073750.642289685695664600.davem@davemloft.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Wed, Jun 20, 2018 at 07:37:50AM +0900, David Miller wrote:
> From: Florian Fainelli <f.fainelli@gmail.com>
> Date: Tue, 19 Jun 2018 10:13:55 -0700
> 
> > How could padding be inserted given than all of the structure members
> > are naturally aligned (all u32 type). Compiler bug?
> 
> Agreed, this looks completely unnecessary.
> 
> __packed should only be used when absolutely necessary because using
> it generates less efficient code on some architectures.

Thanks for your input, will fix with the whole series when I submit it.

- Moritz
