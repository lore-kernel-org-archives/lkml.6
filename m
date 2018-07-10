Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2682C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5C7208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="NdzrDa59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5C7208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934472AbeGJQMn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 12:12:43 -0400
Received: from vern.gendns.com ([206.190.152.46]:47248 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934326AbeGJQMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 12:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7avoomQMozh/L71goB04dN+Nvdz7BoIGcYJwh90bJGU=; b=NdzrDa59QD0oF0CPzv1CPyKtmX
        yP69EXFfvUtEEv+kHY1lUjkxd6buBoCDZlhdHTt6+zky/zxZd59QQ/ro0IP64XUTyEeFgxkfcsUeV
        NTXMKo5IGLCM2LGXhFISex/+To1JgfWsr/4KWkUqo6t0/N6YE3gNwJ1dxPl9IQJAXagmWMvZSAdBO
        jUODLCRlmvqeIIaIIS4M0nu1Amx8tTcS26p30wotjm+DlnL26Qjt02uSDa8SLRtBrib3zfZ+0Acuy
        BwkmSN+eIbGZhy5of+/4NSCajqBq7b8WdcENl5f6nLTuvRmuohOaBHUnjpbVdWt/5X8L9y1McCejc
        UgAHcVKw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:34786 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fcvFo-007yMu-Kf; Tue, 10 Jul 2018 12:12:40 -0400
Subject: Re: [PATCH] drm/tinydrm: add backlight dependency for ili9341
To:     =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>
Cc:     Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180709152106.990066-1-arnd@arndb.de>
 <42317727-5159-7cc2-f6a8-18c8f97b9e6e@tronnes.org>
From:   David Lechner <david@lechnology.com>
Message-ID: <e99234a1-1c58-b205-f718-77082181652b@lechnology.com>
Date:   Tue, 10 Jul 2018 11:12:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <42317727-5159-7cc2-f6a8-18c8f97b9e6e@tronnes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2018 10:55 AM, Noralf Trønnes wrote:
> 
> Anyways, thanks for fixing this:
> Acked-by: Noralf Trønnes <noralf@tronnes.org>
> 
> David Lechner do you apply this?
> 
> Noralf.
> 

Yes, I will pick it up.
