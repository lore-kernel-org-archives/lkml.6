Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 0Qd7OGocGVuldwAAmS7hNA
	; Thu, 07 Jun 2018 11:52:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C3BF8608BF; Thu,  7 Jun 2018 11:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528372330;
	bh=ohVdrO11SpD5xXlQn8Tl/7C7mHHzqem4muMNjEmbioE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jjw4LYU7Zhvll8BLHQX+rwF10DbGH2fDPuB+dkHeW19QEyPyX1DP673xOBSdZ1jBD
	 PiTJu9sOdo4hbbaWC4gE6yCng2A0xEAW8jY361bkaNhNqDFxnjUeag/CyrezKYbQAu
	 i8+Diw8CLbM+g1ZkTFUT8Htmu1qFem+IpBSiIsDo=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3537B601D2;
	Thu,  7 Jun 2018 11:52:10 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GYFwYSki";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gc1eFHJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3537B601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753531AbeFGLwI (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 07:52:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55246 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752996AbeFGLwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 07:52:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A861760290; Thu,  7 Jun 2018 11:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528372325;
        bh=ohVdrO11SpD5xXlQn8Tl/7C7mHHzqem4muMNjEmbioE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GYFwYSkiWBTvmUf0XPD6roPTLQxZ/J14VWJpNozeY6rcO4msrKseTOK1+ehp9WFqY
         JDkem/cIxvAzZqu0tt6686eVEnntQqauV28EuFhscd6RIeti8MqsKiRxZo32JwiJWP
         Ivcv684f11xbL7NBh8M9fo8pPFbI1U9lEU5Ldkxk=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id D47EB60290;
        Thu,  7 Jun 2018 11:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528372324;
        bh=ohVdrO11SpD5xXlQn8Tl/7C7mHHzqem4muMNjEmbioE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gc1eFHJraENzzjfBiTFpYq9ynrHOl2Bv+BxOC31IPh9J0I2yj71D2I61mVImU/vA3
         /CTSyKlpV/ygFo9sQD2RrcqhIHF/o6yeGj5HLBOClcOfPvIP7Yr3txjQAUupT3GQb3
         D11hcCfoh1M30jQUHgCSB0bVPmTC0ONQUZoAi7Ts=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Thu, 07 Jun 2018 17:22:04 +0530
From: Sriram R <srirrama@codeaurora.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: stable@vger.kernel.org,
        Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4.4 08/56] ath10k: fix rfc1042 header retrieval in QCA4019
 with eth decap mode
In-Reply-To: <1528134761.2289.45.camel@codethink.co.uk>
References: <20180514064754.853201981@linuxfoundation.org>
 <20180514064755.718467503@linuxfoundation.org>
 <1528134761.2289.45.camel@codethink.co.uk>
Message-ID: <133624c2c44831fd70edb18c01508f64@codeaurora.org>
X-Sender: srirrama@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

On 2018-06-04 23:22, Ben Hutchings wrote:
> On Mon, 2018-05-14 at 08:48 +0200, Greg Kroah-Hartman wrote:
>> 4.4-stable review patch.  If anyone has any objections, please let me 
>> know.
>> 
>> ------------------
>> 
>> From: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
>> 
>> commit 2f38c3c01de945234d23dd163e3528ccb413066d upstream.
>> 
>> Chipset from QCA99X0 onwards (QCA99X0, QCA9984, QCA4019 & future)
>> rx_hdr_status is not padded to align in 4-byte boundary. Define a
>> new hw_params field to handle different alignment behaviour between
>> different hw. This patch fixes improper retrieval of rfc1042 header
>> with QCA4019. This patch along with "ath10k: Properly remove padding
>> from the start of rx payload" will fix traffic failure in ethernet
>> decap mode for QCA4019.
>> 
>> Signed-off-by: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
>> Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
>> Signed-off-by: Sriram R <srirrama@codeaurora.org>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [...]
> 
> I'm curious as to why this backport doesn't include the change to
> ath10k_htt_rx_h_find_rfc1042().  I understand that the addition of the
> new field is a dependency for the following patch, but shouldn't the
> fix included in the upstream commit also be applied to 4.4?
> 
   Our main intention with this patchset [1] was to provide fix for 
replay detection security issue seen in ath10k driver which needed to be 
in the stable releases.

And, as per stable tree guidelines we wanted the patchset to have only 
one and this important fix .

Also we felt the change in ath10k_htt_rx_h_find_rfc1042() is currently 
not  a must-have fix in 4.4 stable tree .

[1]
https://patchwork.kernel.org/patch/10370863/
https://patchwork.kernel.org/patch/10370865/

Thanks and Regards,
Sriram.R

> Ben.
