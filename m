Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D020C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E78C2089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E78C2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbeJPBRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:17:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58897 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726588AbeJPBRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 21:17:10 -0400
Received: from carbon-x1.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w9FHUm8j3715527
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 15 Oct 2018 10:30:49 -0700
Subject: Re: [PATCH] kvm/x86 : avoid shifting signed 32-bit value by 31 bits
To:     Paolo Bonzini <pbonzini@redhat.com>, peng.hao2@zte.com.cn,
        richard.weiyang@gmail.com
Cc:     penghao122@sina.com.cn, rkrcmar@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, joro@8bytes.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, x86@kernel.org
References: <201810080904344038939@zte.com.cn>
 <717c02f3-bb36-33c4-a463-f5759fde30fd@zytor.com>
 <08fd066f-e6c5-f82c-544f-536e9f29e6f3@redhat.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <32ae2c96-51da-304f-9fc0-d531979eff97@zytor.com>
Date:   Mon, 15 Oct 2018 10:30:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <08fd066f-e6c5-f82c-544f-536e9f29e6f3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/18 10:23 AM, Paolo Bonzini wrote:
> 
> Even for a value from a 32-bit register?  That would be _BIT, which
> doesn't exist.
> 

Just use _BITUL(). gcc is smart enough to know that that the resulting value
is representable in 32 bits.

Or if you really care, submit a patch to create _BITU(), but I don't
personally see much of a point.

	-hpa


