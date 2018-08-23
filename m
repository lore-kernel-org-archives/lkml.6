Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03FBC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B7E20893
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AD8ucT8J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B7E20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbeHWLIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:08:15 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44972 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbeHWLIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:08:15 -0400
Received: by mail-lj1-f194.google.com with SMTP id q127-v6so3379076ljq.11;
        Thu, 23 Aug 2018 00:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wF20qBf+oD4vsCOh3muA4rDAj1jPHbpKGy6GenIUg9o=;
        b=AD8ucT8JR2l2HWZaw/OMg9Z6iEd5TAVp2WQwh8G7lK9Ng3uHOSN+2O0qnXT6Ew81jD
         FU4VuOdBorO/yZYj7NRqYJGLMl9mzYMdOjkFRnSDR5Khh6dcqVVN8ta9gfzN/9DpKPHU
         8YXfto+AioMMVX3vZN2Dsw1vMNLb2+QuDZvBCQv9r93oOg7P4weCeReOup2j4QcntYl6
         yKG+3m3/3N1Iq642DiVzLjK0UVcVP5D0RaYzXaHImRhWAQuXWh1rwzfqmuQ/qMWm60sV
         YKnQuZtC6fGdgOsMue834epDuvrwqBRPMboADDPTtOy6r4j+t0tqjow/qruAhqn6+BwZ
         hxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wF20qBf+oD4vsCOh3muA4rDAj1jPHbpKGy6GenIUg9o=;
        b=WX08bByczsfnoQpzeIZ1VlNdiJHpATLQ58bu4SZAdhtVcAwPyj92x/7kDx/6/ip+G3
         ZJlu2l8psUXWtd/AA9PiC5NCX0byJsr0PcJYSJstd07S5dYsuN/TEmABLjOKJtPeLVHK
         YNeu/SSxLBiurUKO+J7VfWd//OieaTosXeGg5dGVo6qMzH5CafzE960CAFYWKhp/zQMp
         ZgP8sJts1o/kWRWbH1PEGnV5hz2ibmST85xKDDVKgrCwCAv3YzcN/YGBlPqsdxYabuKd
         7Wb5il8camHGyX/bqF1RRUhBGTmXrs0Nu8oafuLCC6SB4fKbsjBk1SXwZPcJGMUJOziq
         BQLA==
X-Gm-Message-State: AOUpUlFIiBIst73wPqGj3KdNxpnsxg6hTOV1yyVIiFaVhPVnK85Owpmz
        SRe4yEHjIQ8lfJEWKODRikg=
X-Google-Smtp-Source: AA+uWPy+2++RIMEEndbjd+WKDYErFYXHz7M9jE5Zx9qfm1a4fFvnfUiOV44C4+YhflXf/Q0BUQNJmw==
X-Received: by 2002:a2e:9599:: with SMTP id w25-v6mr16215743ljh.6.1535009995448;
        Thu, 23 Aug 2018 00:39:55 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id i83-v6sm707519lfl.41.2018.08.23.00.39.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 00:39:54 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fskDh-00079l-Vh; Thu, 23 Aug 2018 09:39:54 +0200
Date:   Thu, 23 Aug 2018 09:39:53 +0200
From:   Johan Hovold <johan@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Johan Hovold <johan@kernel.org>, kbuild-all@01.org,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] of: add helper to lookup compatible child node
Message-ID: <20180823073953.GP14967@localhost>
References: <20180822105547.9634-2-johan@kernel.org>
 <201808231057.oOgtDWTB%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201808231057.oOgtDWTB%fengguang.wu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 11:17:26AM +0800, kbuild test robot wrote:
> Hi Johan,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on robh/for-next]
> [also build test ERROR on v4.18 next-20180822]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Johan-Hovold/of-fix-compatible-child-node-lookups/20180823-074211
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> config: mips-decstation_defconfig (attached as .config)
> compiler: mipsel-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=mips 
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/irqdomain.h:35:0,
>                     from arch/mips/include/asm/irq.h:14,
>                     from include/linux/irq.h:23,
>                     from include/asm-generic/hardirq.h:13,
>                     from arch/mips/include/asm/hardirq.h:16,
>                     from include/linux/hardirq.h:9,
>                     from include/linux/interrupt.h:11,
>                     from arch/mips/dec/ecc-berr.c:16:
> >> include/linux/of.h:637:28: error: 'of_get_compatible_child' defined but not used [-Werror=unused-function]
>     static struct device_node *of_get_compatible_child(const struct device_node *parent,
>                                ^~~~~~~~~~~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors

Bah, I forgot the inline keyword. I'll fix this in a v2, and I can amend
the commit message and mention the start node while at it.

Johan
