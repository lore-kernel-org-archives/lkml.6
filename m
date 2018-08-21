Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5390EC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC414217BE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMkq/C7a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC414217BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbeHUSPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:15:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34950 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbeHUSPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:15:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id z4-v6so3583719pgv.2;
        Tue, 21 Aug 2018 07:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DF0ibwn12RueZrztUi8PB0TfGgXdMrQHRtq7CPqcpgY=;
        b=RMkq/C7aRlBLAUWqqLmFqZoXzqEWN20JZt/99MXjd3LZ1QftCDoB+rTS8cXldORXTf
         W0V97wfHxTxbb/A6YAFhkc78+pw8V71x2UUMe2YUtswtGSKdYn0UBelCfEmsgTFuUiud
         G1eEbUr7vq/orxiGEhKk+C4Bc+bxt6hDw0wZ6jEKeXdqG2DdVNOTP1WhfbZhhAmzOHjR
         Dv/5Qq4W6hLepnQXQl8wEQr8DGV00cMdRV/AAHO5zJZuekVG3Cf5L94iTHL4WMWDwy9u
         eckGjkC52Ip2c9xfTkSNW0S+16XtnyVdD7jtOr10KEyQJWIg9je7ZI/dU3OInwnL0cdd
         8NBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DF0ibwn12RueZrztUi8PB0TfGgXdMrQHRtq7CPqcpgY=;
        b=a3g2hrmWTL++QkNJt3yXmRFyS1I1NQen6GurtjmzBIgr5ufFXl23L90MbRlR6OFrfL
         fTagzsgjE6Mde8OpqZq0wewF7SFD1ED+hWDoirNDKGnYBO1H12l6EXhmLRfCj5xJycaw
         hSutq4nMBc0jwPPBGIy7UNiYZTFXxRF26veQuSny3jr6tbwAnYyMDt35Id8gc7NOENKv
         uwg8+THdij9+CDQjYEBP07K9spN08HY6YEHNmBimjxD2rEr63o26hFcjlrwKcrZiXTh9
         Oiqp3jEDoe2dNlZ4eZoAJg29cS5/qrRFYxoRbfw/xsrksgB4DPcYFI5DHBu0m94sqn1y
         awRg==
X-Gm-Message-State: AOUpUlEwWm1xVdyKlHrWssPdRfJGdipMTExp6BXTYc4I6/vQjwilCDs3
        PKNJGVXTh/JQD4WL1Th9ecTRmC7V
X-Google-Smtp-Source: AA+uWPz/TtdhOjznQr2lL9z5E1e5vpk0rHdCt4Z6gZbrsvrkM3NcYZ3MWrDrQnOYQxJ10A6TCUIaiw==
X-Received: by 2002:a62:1157:: with SMTP id z84-v6mr53500497pfi.66.1534863319989;
        Tue, 21 Aug 2018 07:55:19 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id y128-v6sm20778885pfb.56.2018.08.21.07.55.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 07:55:19 -0700 (PDT)
Date:   Tue, 21 Aug 2018 07:55:17 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/22] 4.4.151-stable review
Message-ID: <20180821145517.GA13639@roeck-us.net>
References: <20180821055139.462620042@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821055139.462620042@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 08:21:26AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.151 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Aug 23 05:51:31 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 269 pass: 269 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
