Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2373AC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE64208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE64208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lucaceresoli.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbeJBDX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 23:23:58 -0400
Received: from srv-hp10-72.netsons.net ([94.141.22.72]:59791 "EHLO
        srv-hp10-72.netsons.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeJBDX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 23:23:58 -0400
Received: from [78.134.111.117] (port=50250 helo=[192.168.77.57])
        by srv-hp10.netsons.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <luca@lucaceresoli.net>)
        id 1g753C-005Bey-FT; Mon, 01 Oct 2018 22:44:18 +0200
Subject: Re: [PATCH RESEND] i2c: mux: pca954x: simplify code to reach the
 adapter
To:     Peter Rosin <peda@axentia.se>,
        Luca Ceresoli <lucaceresoli77@gmail.com>,
        linux-i2c@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20180926083534.21999-1-lucaceresoli77@gmail.com>
 <14ba57eb-0647-5dca-8f84-eaa27fd0af4a@axentia.se>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <5626f9c0-129a-8162-f9b3-ef95c3c835be@lucaceresoli.net>
Date:   Mon, 1 Oct 2018 22:44:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <14ba57eb-0647-5dca-8f84-eaa27fd0af4a@axentia.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srv-hp10.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: srv-hp10.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: srv-hp10.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

thanks for the review.

On 01/10/2018 13:49, Peter Rosin wrote:
> On 2018-09-26 10:35, Luca Ceresoli wrote:
>> From: Luca Ceresoli <luca@lucaceresoli.net>
>>
>> struct i2c_client has a direct pointer to the adapter, no need to dig
>> it out of the struct device tree.
> 
> Right, looks sane, but can you please also do the same thing for the
> ltc4306 and mlxcpld drivers which have the same pattern?

No problem. But be aware I can't runtime test these two drivers.

-- 
Luca
