Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B53C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B58F208B7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B58F208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=winterdrache.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbeHXSIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:08:36 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:36575 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbeHXSIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:08:36 -0400
Received: from ninja ([83.135.210.22]) by mrelayeu.kundenserver.de (mreue104
 [212.227.15.183]) with ESMTPSA (Nemesis) id 0Lbqzs-1fU55T0XTQ-00jHGz; Fri, 24
 Aug 2018 16:33:39 +0200
Date:   Fri, 24 Aug 2018 16:33:38 +0200
From:   "Matthias B." <matthias@winterdrache.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: How to report kernel panic in 4.4.x
Message-ID: <20180824163338.4bd9db8f@ninja>
In-Reply-To: <20180824141254.GB31555@kroah.com>
References: <20180824142408.6340d052@ninja>
        <20180824125950.GA29673@kroah.com>
        <20180824154344.1c53a68c@ninja>
        <20180824141254.GB31555@kroah.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:W6OWxyqDgQ36dYE8Iq15dA1b/OkJScIDlVr7wbAGAYnSvdrzJ1J
 qRhh941gFyZI8jTvfkW8osaCOWqdbdjjoJfYTS0mpchGoE79MqsCUuWX//xEMUTl+P0DTl0
 SFpT3xYRgm/swERnw1axOArBWZviRQCFRzPORcIme2MmaP5x+m6txdOoj+j6NUjj2xAmUK8
 QmG7qVSE3tGFanerjnqYw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tHHHj5oKM/o=:Bj5KdNmXgu/u1bs+MgBMQv
 D6l3D1rQ87rCA3U3mIp/YNByUgCVCbPKue+fUNi1EMEb7vQ56zV57uiq0ggldXqg13LXdPaau
 vIrNMwZKartwkIuun/Na1kV8HE6NZOuajRd02M9zd5C0pW0HLFa9+ViQvCp0FiDc/KjFlRclT
 rAsxYUwAjJdPGwOVGKATbPBFc0drTcftXSxbTyRgXbs5FwC3EvHiHAhbNnmKt9tW2vnH2D5Bd
 SSYB9/K0WoPdpLkEelqKwmCiF7x/zMtUsL0SxuSaKIX4pCPMi2ymBkog45Oaa1sSx9r92jKWY
 qa3vPk6a511Ip/CnmNa3zdCuiczhoV3Xh9td3vNKPpHfZe+X6TjECVUIuVAeIidFbJ39q+0z4
 kC6WLm/ukpJWvJc64DYcK8kOt65wteWlRoqzKrUPwkJ+izuXlynK/5T/UvRougB5AzrFyhFtn
 LS2o1wFwfwD7LUeUDMRwmGdOn9uH21KzyjTmLVNtSBrZxT2DyLHutnx4/z9kliiQw7rvMAslk
 zQg1gVe7aTREG5Sz9TsZMl8VtWMiu44mgdjtR2JIqNxQmHLG4bu/6Eu3VgZ/qwbkYpYx/0Z7O
 nNzaIDDL4lTQQJyVlErKy2NNO1HtprZmWkREP6ARvEnTZIS3pjiT825tn6xFDTLOMMG8+uZhQ
 1cUiCdnzyds7t4p9b0TZpljSyZPeEUr7YDGier24sWB6aDZQDjCvloFQxiD686HHxX9aZEFDe
 TJ8iOnHJz840hCYr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 16:12:54 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> 
> All of the stable trees are here:
> 	https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/
> you want the linux-4.4.y branch to work off of.
> 
> All of the kernels releases are tagged, so you can start with v4.4.147
> as the good entry for 'git bisect'.

I've never used git bisect on the kernel. Can I simply do "make" for
each step or do I need to "make mrproper" every time?

MSB
