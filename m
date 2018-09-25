Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E1AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C32732086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="ek2QN8E1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32732086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbeIZJx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 05:53:29 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36853 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbeIZJx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 05:53:29 -0400
Received: by mail-lf1-f66.google.com with SMTP id v17-v6so18046343lfe.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 20:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KHzygPXoqENEPXePs2Hb+1ye0alU6qEeO5kR6kIs74U=;
        b=ek2QN8E1Skz5PL9Gb9IdwXj6VrCg2oitFtlHkiVIhm372eQvygxdmqgXR6qzNashzv
         cJWcSLQ7qeVc2kLDZdHI+LtolFiqeoHVxr6TCMq9+tbJUiQ2tkOga2IOSrd82RGLS5ul
         FDcd9QKMtQG6XLaG4H0CDRAFvNv172VsaqK8QpGEyyfZJbMmSbU2NWuRIQNNQa6lXBjZ
         7Q68PZSkxS3Zrk5aXbUS/WHc4+LhjHPO4+MCXfOlAv5Y1NrrRDjt4aOPubxsxwGMjzhI
         rvET9NC+ADYzssOYmAputeUSBVGgLNOgcjq1Jxq4VO4zAtg6UazTYjs0Mw45iv3cDErt
         1XfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KHzygPXoqENEPXePs2Hb+1ye0alU6qEeO5kR6kIs74U=;
        b=t9/b8ww1C2rU58NpTzPJLxFJecrlxQ54OW9BM8gKzqyLoriSbcQkzwskkOpkVgQE99
         FacwEeuQ0ykuwablhm9eUQMNC4E+tReukQz0L+ull7/MYzDxc+3SE7KmQfTpBneYA3AU
         IcxqqeHy6DVI5yQGclCVYKyuR01AVTJvhF2Em4oe8Lexj+m8HbggCzszlRWhUSsFsVyP
         ZVv+AbyGv83/uZgPCVqzx6prWhDA4QoOi3p6l0TUsHcDTBD406EiC0my/Fwh7T/gxkLS
         5pBTJENBLwCkr+EETZ2FENZ7c7wDgCCFRRlR5tOo7DSawEfmSFcGM6cqdwfCmKbkPcrp
         Pymw==
X-Gm-Message-State: ABuFfoiHFSX9IizYdAUo+4HloAbzV4i+Fd19zByfRvV3VMW1NK3OOtCt
        tvPgDu0D7WFr7QbIcrsRyG0UvA==
X-Google-Smtp-Source: ACcGV612PwK2IYWmvxbd7di+TpFQulSiAAz9UDwMRvls1PhsZPf3xG48msy2VJTCtBteV6QVfsjBSQ==
X-Received: by 2002:a19:1516:: with SMTP id l22-v6mr2862537lfi.69.1537933358693;
        Tue, 25 Sep 2018 20:42:38 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id m8-v6sm752103lfh.25.2018.09.25.20.42.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 20:42:37 -0700 (PDT)
Date:   Tue, 25 Sep 2018 14:00:55 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 2/2] ARM: dts: exynos: DT for v4.20 (or 5.0)
Message-ID: <20180925210055.7bnzdlponsb4lxaw@localhost>
References: <20180921174520.9126-1-krzk@kernel.org>
 <20180923134742.pugsdeozfp3lp56a@localhost>
 <20180924171841.GA11520@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924171841.GA11520@kozik-lap>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 07:18:41PM +0200, Krzysztof Kozlowski wrote:
> On Sun, Sep 23, 2018 at 06:47:42AM -0700, Olof Johansson wrote:
> > Hi,
> > 
> > On Fri, Sep 21, 2018 at 07:45:19PM +0200, Krzysztof Kozlowski wrote:
> > > Hi,
> > > 
> > > Nothing special, description in tag.
> > 
> > Hmm. Point 12 is special, I'd say.
> > 
> > I commented on the patch, and I don't want to hold everything else up so it
> > might make sense to separate that out and send a fresh pull request with the
> > base material while that part is discussed a bit more.
> 
> I was thinking about any special merging care and effects. I did not
> hide this point 12 as it received pretty big explanation.

No worries. :)


-Olof

