Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9EEC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04E920851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHMRyzo4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B04E920851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732294AbeKTLWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 06:22:44 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44]:46504 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730140AbeKTLWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 06:22:43 -0500
Received: by mail-lf1-f44.google.com with SMTP id f23so110662lfc.13;
        Mon, 19 Nov 2018 16:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OwLV1eEg0tDXd2a16fmTUwqctPBXGeIi/8iNv0sVhFs=;
        b=PHMRyzo4oRxviQDB4M1Gh0YR+JpnV+NBBkCse28d3MwxnCnssSrMm4xH9C5UGaEnWH
         d2g8H2AlVMdx883gEQ5xGkF/l+ZRlwspns+S12rgbEyVilLSHogT7hfZovi2VgOFkTBK
         D3UCeu+MlAbIcHdHniXOZ29xbU7/h184hD08XOjLEpffoE3HIXzfCA4ylrWfuVhXH80E
         rzA6IkR3TuHMbwfhEOOzsqtIEK8w+soWdfTYZEaIFhT0UTZrmlTUFuIjzHlPzU6oR1R1
         H30njtRYT31mAY53Ee3mdv3HZ+pDk1InaZTeY+3so7zu440L1i+GRE+srw1ZHTC1q9On
         Lfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OwLV1eEg0tDXd2a16fmTUwqctPBXGeIi/8iNv0sVhFs=;
        b=q37Su9SU0Z5RI7xZv2EqsNtnY5cTguSPqGYtsh024fJtqsj1/AYqvb7M5jQCOLWCkQ
         JN3JUqg1cIVLRTsByEqoD6AJcD+0C525vNznLQB8d9GOPeU6Q+mkJY+tSi9x/Ealg837
         fTAARf2pNMdk+jVRnZuUPLpeUZ8EBbAFAIei8u/H3+rGuF9w5twDJVODlIDVE3N/7mlU
         cSjjbaMb59lDb3Qf5NQ8y1sMr65IhKXV2BgBPdeAtH/N+8ISWjsq2pw2kbcXGB1VYy8n
         Pkffw6NAdGetwKXb5TTo6JnVx1hM9kvIHF/Vj5iLN0FxM+jpv2F/Jw7RXoMDoajak4PS
         K+iA==
X-Gm-Message-State: AGRZ1gImY5nTm6JtR96q+3MH6S+cX1K8FjyObQnr7SAeWzHQ77LkTIbD
        SRKUC4G/xsp1eyC3AISRjOPjl76G
X-Google-Smtp-Source: AJdET5eJkFTtaS5E0Z/hZddrnBtq5SAPymihPt8RQhhlF4A4Fwq3bvnx45HobGf3VsMeoS3moA0WXA==
X-Received: by 2002:a19:d145:: with SMTP id i66mr12513886lfg.97.1542675376678;
        Mon, 19 Nov 2018 16:56:16 -0800 (PST)
Received: from [192.168.2.145] (ppp91-76-171-181.pppoe.mtu-net.ru. [91.76.171.181])
        by smtp.googlemail.com with ESMTPSA id p77-v6sm6708272lja.0.2018.11.19.16.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 16:56:16 -0800 (PST)
Subject: Re: linux-next: build failure after merge of the regulator tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181120114904.10ef0573@canb.auug.org.au>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <108dd586-379a-21ba-6c44-ea895034bbca@gmail.com>
Date:   Tue, 20 Nov 2018 03:56:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181120114904.10ef0573@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.11.2018 3:49, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the regulator tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> ERROR: "regulator_lock" [drivers/regulator/wm8350-regulator.ko] undefined!
> ERROR: "regulator_unlock" [drivers/regulator/wm8350-regulator.ko] undefined!
> ERROR: "regulator_unlock" [drivers/regulator/da9210-regulator.ko] undefined!
> ERROR: "regulator_lock" [drivers/regulator/da9210-regulator.ko] undefined!
> 
> Caused by commit
> 
>   f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators locking")
> 
> I have used the regulator tree from next-20181119 for today.
> 

My bad, forgot to export these functions. That's the same issue that was reporter by the build robot earlier. Will send the fix, sorry for the inconvenience.
