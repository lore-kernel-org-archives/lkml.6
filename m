Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF1BC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D5A2089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D5A2089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933480AbeGJN55 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:57:57 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:45006 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933255AbeGJN5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:57:55 -0400
Received: from [192.168.1.162] ([37.4.249.111]) by mrelayeu.kundenserver.de
 (mreue007 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0LcaOp-1gKRNU1W4t-00k3jd; Tue, 10 Jul 2018 15:57:47 +0200
To:     Douglas Anderson <dianders@chromium.org>
Cc:     hminas@synopsys.com, gregkh@linuxfoundation.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Bruno Herrera <bruherrera@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: 
Subject: Re: [RFT PATCH 0/4] usb: dwc2: Turn on uframe sched everywhere
Message-ID: <9a64fc45-7722-8650-99cc-a939132e252b@i2se.com>
Date:   Tue, 10 Jul 2018 15:57:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:8Ig6IohGBijJwqTgO4/5fOYoO2amOB6HqAqoIiCcPaz+J4u6g/c
 9vJ/zQfozeTgYRJk4IjjG7ISDiNOgRmpdB/YtTiXROYhlSpy9qQhyJb9CswKd+LhAZC61LS
 LqWWmF/sM/IeJyTt/d9oidBaKdmcAPoW/jh5c2a62Bzg+LDeI67SC0jk5pqI6NCBljnow0+
 ugIZv1BN3AbBM7JVT9l2g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WaYXOkDUigU=:aljA65GI3GWjKYA9v6Fypa
 mDyGMBcIKvzQRcPG5z2JGf2AtR99V2n11kCC+s+yVen9rZAxIfYn0MCYyFwhfv+a4nAqq6TPH
 +8lLmh6t83Yfr2BygDMWCN0UIM8sVrttu+CReM1o0MZZVPnGzB7z4e7UhMHqn3j4DC8AWwzzt
 AC2rR4+Jfm5fu5eM38M+ENKrX9wmx15E3pclA/aaSvi7++xxDIzCP2PfTkzRbb7gaY0mVhf19
 obM9jwpkyn+drc6evplAdAdnfp+zEcIBhEAvSDXxzkBxl9jnYTv4tcHnuoHKSszqj4jXEes3B
 gY3tTkZFMbRernpkTQACRj0ecjObBbwgS8EpJZThax7/VyXpOO1ruF7ppsZFhIkdvNaURjkRc
 3NRripVXbnVT5y89XKLuuA05GtEM3VD2+SXZRNFpCZIBVBSUhUNV7G/QkY4AC4K2dAAP3PKSV
 kE6VSZ/HiUiHe3A5b9IHVPw5LAfxmtpbFffOsO1DlxMADEoXggiWsXUaEGCGUeeDNBylPEQgl
 t4jXwEpOmElKpbBR7AbHaEmjYLsvGDwKoPgld8YNHWp/SbcnZechaMpCbmijx6noQgjGvIgar
 yhSw3WiqYAS2q1Hat/erGGk5c8hzS9iCQ8URQBvprKEV6DyvJfgn+BTZeGxnc449tm2oxQ0IE
 z1N0G0eqH52QUxcLb3amtQu7TVpFZFBU+TezlWhGxTuwhRNYwOi6lUMP/ZOfOspquRJbEs8bN
 qWxLAYhGVTA4oKGN
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

since Stephen isn't BCM2835 maintainer anymore, please keep me in the loop.

I'm not sure how to test this. Is there some kind of test scenario 
(don't have a USB analyzer)?

Best regards
Stefan

