Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9805DC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 01:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BAC206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 01:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfAABWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 20:22:12 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43330 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbfAABWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 20:22:11 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <dann.frazier@canonical.com>)
        id 1ge8kz-0001bL-8q
        for linux-kernel@vger.kernel.org; Tue, 01 Jan 2019 01:22:09 +0000
Received: by mail-it1-f197.google.com with SMTP id x3so30349994itb.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 17:22:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zx/xA1XuVzWE+DZQS4+9BUeugwM6Rjy57Bb5GmC5j2Q=;
        b=WD3VSyIZqKyOM8KCitJ1f1p/j30ThqvvX2LHGr1rcxgwobl97XFb69mKO0rj/c5OzL
         bAhOImkcnBG8e2ZgUb3GGWgT5WgW0vfHtDgySy8cpWLTMN+OOBuzsCIL+/67RPh12OrC
         5Od3kavKMcUzg63ja4zC2VmWdblKo4qk+LFVCUDA1OdeRtJCUZZdOSVaFC7twcu6pQbX
         eeyrKGJjBIay9sBMsYLtq7hNsIW0ZdcR0Od6KFj6rxtwffTh2lNXIWQd7q7EjcfiJOQH
         NPuCQ3E3Mfo+xWbIm3sSdESSiknEAvpjVpxl0q8221buT6F1QvRGG//aBLUOp05yYioz
         ns6w==
X-Gm-Message-State: AJcUukccfHdLWM7U94aUBik8xb23RjNjU9j9TmA3vjE1oj3mZ4UhK1KW
        jDysfi+Hk25+bm2ViLV5fn3O7oJVSnYP0W3lbsXEX5c2TyUSAzNfyzhU/hhUJiF5lWiJY/nAMCF
        KthF6WlHNjqg7BzlyGvswKUiw0JwDu2MRus5hHcmM3Q==
X-Received: by 2002:a6b:b706:: with SMTP id h6mr25723072iof.295.1546305728101;
        Mon, 31 Dec 2018 17:22:08 -0800 (PST)
X-Google-Smtp-Source: ALg8bN4mmVdovmCY2J+xCF7dlEdQdkY3qlRaRjeFBCohht+QYIuVgW+IxRqmNjnWROEea10kB2Fjag==
X-Received: by 2002:a6b:b706:: with SMTP id h6mr25723058iof.295.1546305727813;
        Mon, 31 Dec 2018 17:22:07 -0800 (PST)
Received: from xps13.canonical.com (c-107-2-141-103.hsd1.co.comcast.net. [107.2.141.103])
        by smtp.gmail.com with ESMTPSA id u3sm19053386ita.18.2018.12.31.17.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Dec 2018 17:22:06 -0800 (PST)
Date:   Mon, 31 Dec 2018 18:22:05 -0700
From:   dann frazier <dann.frazier@canonical.com>
To:     Salil Mehta <salil.mehta@huawei.com>
Cc:     davem@davemloft.net, yisen.zhuang@huawei.com, lipeng321@huawei.com,
        mehta.salil@opnsrc.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH net-next] net: hns3: Config NIC port speed same as that
 of optical module
Message-ID: <20190101012205.GA22494@xps13.dannf>
References: <20181126184300.24964-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126184300.24964-1-salil.mehta@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 06:43:00PM +0000, Salil Mehta wrote:
> From: Peng Li <lipeng321@huawei.com>
> 
> Port 0/1 of HiP08 supports 10G and 25G. This patch adds a
> change to configure NIC port speed same as that of  optical
> module(SFP/QFSP). Driver gets the optical module speed and
> sets NIC port speed accordingly.

Hi,

I'm getting the following errors in dmesg about every 1s on a D06:

[  766.761823] hns3 0000:bd:00.0: get sfp speed failed -5
[  767.785823] hns3 0000:bd:00.0: get sfp speed failed -5
[  768.809820] hns3 0000:bd:00.0: get sfp speed failed -5
[  769.833818] hns3 0000:bd:00.0: get sfp speed failed -5

Reverting this patch fixes the issue.

 -dann
