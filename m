Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6BAC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5175F2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:37:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5175F2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeLMJhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:37:34 -0500
Received: from mout.gmx.net ([212.227.15.19]:36555 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbeLMJhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:37:33 -0500
Received: from localhost ([130.180.45.238]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MNIAz-1gVSgX1kID-006uaN for
 <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 10:37:32 +0100
Date:   Thu, 13 Dec 2018 10:37:31 +0100 (CET)
Message-Id: <20181213.103731.734229932284065893.hartrumpf@gmx.net>
To:     linux-kernel@vger.kernel.org
Subject: Re: Can we drop upstream Linux x32 support?
From:   Sven Hartrumpf <hartrumpf@gmx.net>
In-Reply-To: <CAFLxGvy2sMW1nyMpxGN7xHPdUea713g89MdE3EcUNHJDCvZ3jA@mail.gmail.com>
References: <70bb54b2-8ed3-b5ee-c02d-6ef66c4f27eb@physik.fu-berlin.de>
        <20181213050313.GA21201@ip-172-31-15-78>
        <CAFLxGvy2sMW1nyMpxGN7xHPdUea713g89MdE3EcUNHJDCvZ3jA@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:qeTAEsQfxW5b8jxtdvvsiAn4/PTkY+4n9B0zsK4joLJEiOGo/Up
 FI8SKFzBKj+JtIYp4tF3O3zkJnyWA8MSjHjuhcp8BndtSv7DC8X/fss0cg9rHQnSSoz2OHN
 otohIkNy0lMluE8QDbbZ2ZlHRrdcZJXgYs/xq75x2tYuntYtIp/snE/IYWboB7S0P8WExOO
 gCriAobNC6o5lw6t9b8JA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zVvhfCzvVXU=:78bClzqYaE2xpKcoCVIcRQ
 6h9yVTRjEvKp3boaUYAFzZvsjCWY5g0akEy3xngZLj/FdaMLKdy0KKDpAEEg5by+m/2mJUwTm
 TJ3aqCUGoAFlBugAPSH4grEr1xlCb+mP3N8aeFCZl99GCXG/oELu5xqzGzJlsSDA9O1yjU0YC
 rznhtmk+6nCm6zHoZxzQ0QCrC39MeOKNk4CDMDacLAtI5C48UePQtGYQCJH3PlzKh322iGzAf
 d4Fm/v2CygJYZLAECND3C4H1lbCc/QBxbHW6V0PxWSHk9EKPPLZQTc4DA1q/Qqg1ZEWDlr4Nw
 5p19cBC1rMbCPIrxh2LtIxjQgp+0IJoAZmCWdxQrHEXq4rkFbCe/9Z6vOPdJwyXY++7UaGqBx
 BUs4md/NtscfJvpvduEC1Y5+SYeSFlALrHdPnUqJeM123Y6D3Tq6wKmBDdKdLhefPt9SF1QWu
 tNgQcxT0j1vRV1Fel7PvInD6/xG5prmbhBcZ6PEdaOVmBN/tZuRuFISuWvUJzXeHakUgTE38s
 fA8lsVTHsXhpHhlDS0q6NToOJp5URagyjhR/Tc/9T2sn3decbpYCdz0XaOq2Ea2Og40VxZkI5
 8E7UiARL6nJbNQBUe1PEpZL5BUfDjNuOeXpkup18bymrC94DAL7YZUTmAr88eLp9bmBUBQT7F
 0LxEQUysyfFiWfxFXqTP0eSOSLakwC2cLorTAjr0H/wB1z0aaNLEFA41RGQyQZ65oWtuKhmmG
 Qv3lDxF14fv6LuQ5TjhEPSGfsEV4QUr9rHnWmJYEm9AxWLItVdaCUVs8gqeEBQAIJt73tWTb9
 OVxT0qBDKf14WZG7ECHpmLcLdB3dixislrt/yrWOSyL/egFbzARDSvVZYHtfJFcXGrj7jInA7
 jokTafJOpVddUPIGw44HsOgLM7E6N4U/EPO5FaKXThevZQbv9RWgu0oBtSB6R/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will the proposed patch ("only") remove the possibility to build x32 kernels
or will it make impossible to compile and run any x32 binaries?

Sven
