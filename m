Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5A5C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0897325FB9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0aJzp1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0897325FB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753371AbeF0P10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:27:26 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:37578 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751107AbeF0P1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:27:25 -0400
Received: by mail-pf0-f175.google.com with SMTP id y5-v6so1132800pfn.4;
        Wed, 27 Jun 2018 08:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sIfRx432+dn+nBytQlqPgA8VECdYeCgneEHZNax9ryo=;
        b=c0aJzp1FPvMzY0ikI7dNByX5lQtXXjOjG5VnZQLQTTb6O/5AdXXnORcGInKsW+BZsM
         70nbi/Pu3okg0GIUfYA18VYu9IBPuAZxjiao01wnGzAKvJ7umi62mLOcD+QzgSFFCUdQ
         LcfFtyAzOZJ7rCDf8xJqnlRb38Q5QfoEsvzJEri/kgY8CX8Gn4xObV5PP/qSt2KiNutK
         Alt9pNOKdjhJKYHL94GDuMzRS98xSe8p+xX8z7XKy/rQ35neTbYq5nrvmpN3NYQa+dcb
         XRJOPtY4dDcuaXIwUIUHH/qvQYiUb8aWxmFh2Eo5YOpvFL4y7vsyXQUfRpSNiZgiERcM
         sWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sIfRx432+dn+nBytQlqPgA8VECdYeCgneEHZNax9ryo=;
        b=oC/8N4/UsZWysNzpVTMVyPvA1RFsjtGcppjuz5ZamcPMJE4i/p7ROlg6T6xVSBA1M+
         v9p7K9uhOpSnfrB5gyaFg6ehfQjSQx29IdqDQvnrHfvSY7U7HxSZQW+G9xbS/oCIN+eU
         ZP6uBAvgRrucLlkeznaNj0gCQBCOyqrTwZhgnzX39aDnVwNObIPZhlRMOAfT3hRjXMDc
         qWqErmcPNBtS3JAssSWIFN37LuRFJ8nORv4SGEDZ1yAryB1uadg/YIBx10VJyIv16RV1
         BJ5i4TZzHKYGbvDSWSDqiDYdg/2hcOOGzAODBNk4kY9dnXJpV2j8fFF1cxJ8l0YiMweI
         mIcg==
X-Gm-Message-State: APt69E03hqw5M4IFD/s2eObSn+vqf8+WVLcZonD5tTbw88PEvv+TgNF7
        QmSPc8jHF51VCD7LmcqN5hVK1NV6
X-Google-Smtp-Source: AAOMgpcII+C/XeBap183NgdWk7Fw55j6izTh2xIyggXde49/BHCLu0nRrKloh4QBi997QU5xfTIIxg==
X-Received: by 2002:a62:9419:: with SMTP id m25-v6mr6325592pfe.120.1530113244301;
        Wed, 27 Jun 2018 08:27:24 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id s14-v6sm6656161pfh.116.2018.06.27.08.27.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 08:27:23 -0700 (PDT)
Subject: Re: [PATCH net-next] tcp: replace LINUX_MIB_TCPOFODROP with
 LINUX_MIB_TCPRMEMFULLDROP for drops due to receive buffer full
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1530100216-13070-1-git-send-email-laoar.shao@gmail.com>
 <c89b70f9-e70d-35a5-b9a7-7e3ed7d34edf@gmail.com>
 <CALOAHbCdRjq2n37GpeBdorcbxXMDX2vNDLftypViJd5hRTA28A@mail.gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <72f02552-9375-bf81-6a03-42656168b583@gmail.com>
Date:   Wed, 27 Jun 2018 08:27:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALOAHbCdRjq2n37GpeBdorcbxXMDX2vNDLftypViJd5hRTA28A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/27/2018 08:14 AM, Yafang Shao wrote:
 
> Got it!
> 
> What about introduce a new counter, i.e. TCPRcvQFullDrop ?

tcp_try_rmem_schedule() can fail for many different reasons,
not related to how occupied the socket receive queue is.
