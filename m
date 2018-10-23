Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048F7C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5EA204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5EA204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbeJWUZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 16:25:37 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:35317 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeJWUZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 16:25:37 -0400
Received: from null ([172.19.249.152]) by mrelayeu.kundenserver.de (mreue108
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MZCX1-1gAMx42iO1-00V5Dv; Tue, 23
 Oct 2018 14:01:43 +0200
Received: from null ([172.19.249.152]) by mrelayeu.kundenserver.de (mreue108
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MZCX1-1gAMx42iO1-00V5Dv; Tue, 23
 Oct 2018 14:01:43 +0200
Date:   Tue, 23 Oct 2018 14:01:41 +0200 (CEST)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     matthias.bgg@kernel.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        eric@anholt.net
Cc:     geert+renesas@glider.be, pmladek@suse.com, matthias.bgg@gmail.com,
        linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <mbrugger@suse.com>
Message-ID: <459136891.184150.1540296101955@email.1und1.de>
In-Reply-To: <20181021215848.5827-1-matthias.bgg@kernel.org>
References: <20181021215848.5827-1-matthias.bgg@kernel.org>
Subject: Re: [PATCH] thermal: bcm2835: enable hwmon explicitly
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev39
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:xc4DYkLH2FoM8b8NuEEbcA+a1oh3+uAG4/s6nMDjYCX4nfFjBm7
 ufSlXUh1Pb5JimxvOJnRagidEQugwQ4XHq7Ud7+NSSJhnJqt7yUX6kXJVO9pCLnaINCIUak
 FeyeQ46nNi69Bd7Jou7dWx21FMGYgMSF+ADCej30dQp44lkO62gb9gLqQ4FpsLCjjWp2KJh
 xD4BHT+rsCvCwUDkHuIzg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QKGJtkyhfTY=:+MOBwqNGOiyIlHBZlj5ZGY
 iM+IxdebKuKX9p+SGwZRJJ/VsFnas2Y4s79eCV+3vQ9D88+hzp21v56gqsXiRHAdxExP5EcIa
 diVUGIutJQFUqEYkaeezStE0gcg2gkC98Z+2GQnJuyiZjrF1d+yb5ugQJ7wqp09bmtwfemm/3
 LWIkwi3faSFFXYFSVGiYjCDRob67tcdD1YRYBZhl45EoXeUX820Eeba/bE4PIWi9D1558rwDE
 7m9QG+Rohdxs/E562/YPfNn+aCZWNJw1breqbm42yIVlTuec1zUYMYLcCYDFQtiLdD8f6WfZq
 nnbe4YpPaWeRZiqZys/HSICtKL9JNhsFvOokyEYmJwprnlNllQ7TUvlMd+p3c2u1qn9SvZZ3F
 kPDxJ2K8GVTtSLXmUeJoPbx9YHZ6V1yw2R+hjaL+6fDwAbQCAPKU+l6dLFf5LRX9aS1o8sy0L
 sy2Ppd3ydsJws8I0fiuEPwQS0ckNE9efOXNI05y9gppgRHwOJuki/AkcqB6wWtv770kY1yqxz
 rnIA2Zfb0CxhxOYp5x4VAXH8wUl6ju/iNjatz8p+01mm+ZWLvop/BOd7rhTGkn57qHjgkEV35
 Y6s+DOXxSvMOPUGnUy2SRhZO9F89G6n8iv2PYAOLVFnLm7XO0glZ6AmEmQL0jZ/Rhhmvy2qrG
 EIZEYYlVD+dUW6Xf2u3mdj4Y0/sDdT/nJhXooHshI2Fn+wXosxehlKkuKCS22IBCj/2F0idOx
 c0WklrjfudKqFdbm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

> matthias.bgg@kernel.org hat am 21. Oktober 2018 um 23:58 geschrieben:
> 
> 
> From: Matthias Brugger <mbrugger@suse.com>
> 
> By defaul of-based thermal driver do not enable hwmon.
> This patch does this explicitly, so that the temperature can be read
> through the common hwmon sysfs.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

I'm just curious which board and config did you use for your tests?

Regards
Stefan
