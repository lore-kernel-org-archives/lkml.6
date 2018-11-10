Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E74C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6982081C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6982081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=packi.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbeKJST1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 13:19:27 -0500
Received: from mail.binarylogic.ch ([88.198.23.72]:45788 "EHLO
        mail.binarylogic.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbeKJST1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 13:19:27 -0500
Received: from [IPv6:2001:8e0:2002:7300:11c7:1b28:a349:1c6c] (unknown [IPv6:2001:8e0:2002:7300:11c7:1b28:a349:1c6c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.binarylogic.ch (Postfix) with ESMTPSA id AD4B4DF386;
        Sat, 10 Nov 2018 09:35:15 +0100 (CET)
Subject: Re: [PATCH] riscv: add S and U modes to ISA string
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>,
        palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181110064543.12411-1-david.abdurachmanov@gmail.com>
From:   Patrick Staehlin <me@packi.ch>
Openpgp: preference=signencrypt
Autocrypt: addr=me@packi.ch; prefer-encrypt=mutual; keydata=
 xsBNBFIh6GYBCADTiConXKy4X5gl7xi6gaNfLvvl6mZ+GVAhlVQtMgpkkO7D8+YQuBiuYAFj
 6btXXI5Y7hrbHkokyknGLFUcMEXCI/L2+W8ta+2iCpVv++oLzD6h0FxiabKBOTdA60upmBdr
 MBMdG8jBfm3D4gE/2grhvLL7SmHMEtF2F4lxykwon6cdvuDBL5Jkkvv0/YROC4QIGHFIOUVP
 GJxS1YWVi4pCVhju9fsrXh2C9GEpKVL53t3ixj7VpaogwfTKkCweb7mSKmUOHnJE6i9pvBNg
 x77WSnefzbz4yQFl0dfcD7mCbPegWXQGs1gNaJLhxV+i+FOXMibFZfF4p9ieTYBube0VABEB
 AAHNHlBhdHJpY2sgU3TDpGhsaW4gPG1lQHBhY2tpLmNoPsLAlQQTAQoAPwIbIwYLCQgHAwIG
 FQgCCQoLBBYCAwECHgECF4AWIQR9yIKJQW2d0IKUGDgLDiHrZr8WEwUCW1AxJQUJCw98PwAK
 CRALDiHrZr8WE5NAB/449UGo8HvWL5JY2oo1c9sUz28MRXlkvVHVrMwB45nhM+WdMcQwTWV7
 SONscsvJ4aDVDo+7Tq0hrdMfo97jciA1J5x+p5MVNhNJYXZ1xxWqL8xoxof/4aUQ1lMbLAQj
 ODxff8hol/8p9RdO8Zkhh+IeIi7lQUCdKCyP3XpC58QneVwvsVhPI85R2+lrWtVpkwxJWE/o
 0PCJUFHMEE08UxSg2APuywTv0m14+UCFl8zL65k/MW8RWrSGaTz+ez4MOaAxVBLZjM5SVMKa
 j3wYcEHaW0IUd+0jnKoGzssjrIA0Ezb7gZV43TXgHB5k7UWx/HrJqSATOWFo/HwpAaq3X+H9
 zsBNBFIh6GYBCAC3KYJQ2NKm1P0f9Cywy5iXUPoPoHiMMZQQtU3Guk9KDcukF3sLJc73ByRL
 /63hkf310DSdEPgETWpfN+6piQCTDkdoNcE33OdOvsLaHHGXDKYuddC1orzxkqb5wGCyEKX3
 Fe7cO6IHtRwhS9xO02mnclGoqZ+VQ0rojS9Ve7HST7WptZab/MTJhVpuaWQrZfrCRZ6LQvYT
 p9JozxZv0Pgf6bntVqMPhMe/dZdaL/ti+kBk86YyemKxyWK5Q5rRMxS8qDEuvJ7lc80y0K2B
 bjiin8NS25xZ5p30mHLMYvOLj0kSH0oGQszRn6e1z+KNloICk7A+DykOuJWjcSAyxDFdABEB
 AAHCwHwEGAEKACYCGwwWIQR9yIKJQW2d0IKUGDgLDiHrZr8WEwUCW1AxJQUJCw98PwAKCRAL
 DiHrZr8WE+7xB/9I0MhfuJZkVy42ApQpRJljHg6bRlt8kfbj31t/9/qG5oy1DU6DtsZQjChV
 JUrowoxlMecLhIHHkwqrX9xcz+YxZTWp5qbalZ+au1JxzjJPDIyeImx0Emg41NVzcxNrTfQD
 +Vu7sIG57U8aIltJPIvg1KvAg6LA2XAM2iz4JgRKFtxPt6R5uFuwVy5AJGOKYLtBVDIMCXeh
 QblQSwszFmlErg1xDqp2ynUvgpq67x8ushAKyOnLfb/T5CFBW0Xg2igZYx+UQAOduZfi3NQi
 BnOM4Yr7WWVPQ5GCckYX0KxVBbxm4PgwQyPWZ9Ya6T4UKJNiXAIhDWBNV+CsOTxPFtI5
Message-ID: <7958aa50-8808-e909-753c-e232b3d1f84e@packi.ch>
Date:   Sat, 10 Nov 2018 09:35:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181110064543.12411-1-david.abdurachmanov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.11.18 07:45, David Abdurachmanov wrote:
> 
> The patch adds the missing S and U modes.

This is the same patch I submitted earlier (see v2 here [1], based on
Palmer's feedback). Palmer stated that the "S" extension should not be
exposed to usermode.

Since two people arrived at the same solution, I wonder if the
supervisor mode should really be hidden from userspace, as it's about
the CPU information, not about the environment the calling code is
running as.

[1] https://lkml.org/lkml/2018/11/10/96

Patrick
