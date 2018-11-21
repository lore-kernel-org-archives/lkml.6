Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271E6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D77214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="M9+3vVrI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D77214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbeKVFBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:01:00 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44000 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeKVFA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:00:59 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so6658620plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 10:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=UzSgwX/mRKa30UFg9nzgR4BDr+fry1rc6xVWY0eAl3M=;
        b=M9+3vVrIJWGF/VHqY2e2vdpgIegTwoCuWCI/f3x28gcA+wLqHwR4r4h1A/3KkAmiWr
         JJWefhBcfw1XThw/u84yykecQKPld5JnflQoSl5PgI/KHXDJOEDAHJ+Yp5E3iPGLNyns
         IpwsVdLupZ7YagWZR1scNul6uQUsPdifwgTOKIHVppQvTwHBM5QQVSAefGYTZxd7WmNW
         VLSfJ/HcFEVsPbQss3iNB1SwBcOu050c6zb+WqTSuv6ysBaov7moy3Stp+S0iioZHP9o
         qUD+YOfpR5fAuLLaMLBzwwLYfBL3CH8y/5mJ8S/SQ9da+5P1umcLBQrX1tFdqSK1K9vc
         K1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=UzSgwX/mRKa30UFg9nzgR4BDr+fry1rc6xVWY0eAl3M=;
        b=Cxufds39Ck/eaEUr2022DcCxBo5WSaQz3tELfczhaa5G0u2ZhJHhLSilMckV/7ilqG
         VOutZEDtv8dyLGwsV9TwlIAXjWj14zeXstflpm9u08ae5x/hJM24XPQsP7ETIvQBHB/U
         RsKMf7TEbwlI0yU/xWGgAsgdFz1XtrBhO+pIk7ANGfaiELAWJr74J4TwXKSourspzNMp
         m5HZWDcaB8Pjb0QX6B9GMwzzpUAGelDuOer+5JoxYmNJPSelxdrd0zPjPPb1690jl3TI
         LmxdmpzNGgBAbtg5I+walRsRp4Oq8DJmhaMGQoyS/PH5irJUaWbjE+VWXAado/ttfwvL
         inlw==
X-Gm-Message-State: AGRZ1gLD4VA5rhfAJVImB5D5iSSJ99eP0YnxDOO983fUBv2EWkkL2rVo
        yA+InrTUITdVPuFbtpTgbQlthQ==
X-Google-Smtp-Source: AJdET5d3pSecah5NCZ1QJTelkZSfuBKdaJmAK2Bng5ObrI9ORh0tpfWHJY8HgeXRG/wrdxPJug4tOA==
X-Received: by 2002:a62:2095:: with SMTP id m21-v6mr7965663pfj.32.1542824733037;
        Wed, 21 Nov 2018 10:25:33 -0800 (PST)
Received: from cakuba.netronome.com ([2601:646:8e00:727e::5])
        by smtp.gmail.com with ESMTPSA id u70sm5547437pfa.176.2018.11.21.10.25.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 10:25:32 -0800 (PST)
Date:   Wed, 21 Nov 2018 10:25:29 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Salil Mehta <salil.mehta@huawei.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "Zhuangyuzeng (Yisen)" <yisen.zhuang@huawei.com>,
        "lipeng (Y)" <lipeng321@huawei.com>,
        "mehta.salil@opnsrc.net" <mehta.salil@opnsrc.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH net-next 0/8] net: hns3: Adds support of debugfs to HNS3
 driver
Message-ID: <20181121102529.7d8df6e4@cakuba.netronome.com>
In-Reply-To: <F4CC6FACFEB3C54C9141D49AD221F7F93BFC8A64@FRAEML521-MBX.china.huawei.com>
References: <20181119211845.23168-1-salil.mehta@huawei.com>
        <20181119142955.56b6baa6@cakuba.netronome.com>
        <F4CC6FACFEB3C54C9141D49AD221F7F93BFC8A64@FRAEML521-MBX.china.huawei.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018 18:06:19 +0000, Salil Mehta wrote:
> > From: Jakub Kicinski [mailto:jakub.kicinski@netronome.com]
> > Sent: Monday, November 19, 2018 10:30 PM
> > To: Salil Mehta <salil.mehta@huawei.com>
> > Cc: davem@davemloft.net; Zhuangyuzeng (Yisen) <yisen.zhuang@huawei.com>;
> > lipeng (Y) <lipeng321@huawei.com>; mehta.salil@opnsrc.net;
> > netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Linuxarm
> > <linuxarm@huawei.com>
> > Subject: Re: [PATCH net-next 0/8] net: hns3: Adds support of debugfs to
> > HNS3 driver
> > 
> > On Mon, 19 Nov 2018 21:18:37 +0000, Salil Mehta wrote:  
> > > This patchset adds support of debugfs to the HNS3 driver.
> > >
> > > Support has been added to query info related to below items:
> > > 1. Queue related
> > > 2. Flow Director
> > > 3. TC config
> > > 4. Transmit Module/Scheduler
> > > 5. QoS pause
> > > 6. QoS buffer
> > > 7. QoS prio map  
> > 
> > Please provide a more informative cover letter.
> > 
> > From a short glance it looks like you add a single debugfs file, which
> > can be written to, and upon that write the driver will dump stuff into
> > kernel logs.  
> 
> That is correct. Do you foresee any problem with it or are we doing something
> which is objectionable?

Its fine with me, but I think not everyone reading the list will read
the code so a few extra words and adding one of the examples from the
patches to the cover letter could help people understand the changes.
