Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9987AC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673B120848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 673B120848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbeJYXby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:31:54 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44012 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeJYXbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:31:53 -0400
Received: by mail-oi1-f196.google.com with SMTP id s69-v6so6903848oie.10;
        Thu, 25 Oct 2018 07:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H3KLghIatITsGO1bPqIs9wSjWGrC0u7BIppJy2GjADY=;
        b=c2H4LYuBsAwJbrY2DtHfnT8iej4Ssjj40v33ta8KJRyANzRtQpSdBg21UmUheVpSbP
         gautOC3DiSzp/DdV+RcxuG+74Jrme5DLWRJWl//CH0qSKy5VdcA0ehNOd4CzzA16hQkP
         xerOQRlRW9wrn9BYD2Kq4hZ9RpOKjll2jusMQhQjGeNrEOzxcugwndJxHCGDwzcha6wQ
         6rx4zj/uo/9geqAbA/SSJjgW7tVvdQcqkt+GRhdSRMTbyaZzhdAu1pwKuPFGdnZMQZhk
         ezxZQO4AnWhBAD/3GRvui0daEGkHjJPpE89aoloDteabRnXLG1Z9rVtcVM8oy1bqKD5c
         b/PA==
X-Gm-Message-State: AGRZ1gKOmkbTdTYsomBt9P4ZPrKMmGRKDbrHinnqmfwEFUuL3Je6uXUS
        wqQEdQjvRRG1oz33qIkqUw==
X-Google-Smtp-Source: AJdET5dPHlUE0QUD7fkb7UXzgQPN/9JD9lH+lZsewfoB5aUC/A4ThMmcgYMgbL1+ljMrAPZG1ZOmeQ==
X-Received: by 2002:aca:e804:: with SMTP id f4-v6mr639668oih.38.1540479523318;
        Thu, 25 Oct 2018 07:58:43 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w7-v6sm525164oif.22.2018.10.25.07.58.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 07:58:42 -0700 (PDT)
Date:   Thu, 25 Oct 2018 09:58:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     anilc@codeaurora.org
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        mark.rutland@arm.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] crypto: qce: ice: Add support for Inline Crypto
 Engine
Message-ID: <20181025145841.GB30244@bogus>
References: <1539789476-6098-4-git-send-email-anilc@codeaurora.org>
 <201810181902.44DQrfDL%fengguang.wu@intel.com>
 <d6f1930a618f6539a4c3e53d239fdd90@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6f1930a618f6539a4c3e53d239fdd90@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 04:44:37PM +0530, anilc@codeaurora.org wrote:
> Hi,
> 
> Thanks for the comments, response inline.

FYI, this was from a bot.

> 
> Thanks,
> AnilKumar
> 
> 
> On 2018-10-18 17:13, kbuild test robot wrote:
> > Hi AnilKumar,
> > 
> > Thank you for the patch! Yet something to improve:
> > 
> > [auto build test ERROR on cryptodev/master]
> > [also build test ERROR on v4.19-rc8 next-20181018]
> > [if your patch is applied to the wrong git tree, please drop us a note
> > to help improve the system]
> > 
> > url:
> > https://github.com/0day-ci/linux/commits/AnilKumar-Chimata/firmware-qcom-scm-Update-qcom_scm_call-signature/20181018-182318
> > base:
> > https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
> > master
> > config: sh-allmodconfig (attached as .config)
> > compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> > reproduce:
> >         wget
> > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> > -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=7.2.0 make.cross ARCH=sh
> > 
> > All errors (new ones prefixed by >>):
> > 
> > > > drivers/crypto/qce/ice.c:1372:5: error: redefinition of
> > > > 'qcom_ice_setup_ice_hw'
> >     int qcom_ice_setup_ice_hw(const char *storage_type, int enable)
> >         ^~~~~~~~~~~~~~~~~~~~~
> >    In file included from drivers/crypto/qce/ice.c:25:0:
> >    include/crypto/ice.h:60:19: note: previous definition of
> > 'qcom_ice_setup_ice_hw' was here
> >     static inline int qcom_ice_setup_ice_hw(const char *storage_type,
> > int enable)
> >                       ^~~~~~~~~~~~~~~~~~~~~
> > 
> > vim +/qcom_ice_setup_ice_hw +1372 drivers/crypto/qce/ice.c
> > 
> >   1371
> > > 1372	int qcom_ice_setup_ice_hw(const char *storage_type, int enable)
> >   1373	{
> >   1374		struct ice_device *ice_dev = NULL;
> >   1375		int ret = -1;
> >   1376
> >   1377		ice_dev = get_ice_device_from_storage_type(storage_type);
> >   1378		if (ice_dev == ERR_PTR(-EPROBE_DEFER))
> >   1379			return -EPROBE_DEFER;
> >   1380
> >   1381		if (!ice_dev)
> >   1382			return ret;
> >   1383
> >   1384		if (enable)
> >   1385			return enable_ice_setup(ice_dev);
> >   1386
> >   1387		return disable_ice_setup(ice_dev);
> >   1388	}
> >   1389
> 
> We will check and get back on the compilation. What is the idea behind for
> this
> effort, is this for testing the ICE driver?

The purpose is to make sure changes don't break builds that you likely 
haven't tested. Either different architectures or configurations.

Rob
