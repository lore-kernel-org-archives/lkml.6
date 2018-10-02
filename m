Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9DDC64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FD020666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="0SH+WWH9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EBLlTX/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22FD020666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeJCFMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:12:23 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:44425 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725832AbeJCFMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:12:23 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 9DF7FA99;
        Tue,  2 Oct 2018 18:26:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 02 Oct 2018 18:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=iHLdukaGrASJo2mSFXoagCfvXj43OAQHRO27Vpx/vTE=; b=0SH+WWH9
        SpqdMZHLmKqOS0BhMsbWBdZIFhhgqb1MRzMFYLMo3ZJmLrGv1ElazAakwyTytCVW
        0R61GWTnldRSTHbxY3AoPm5o9NTDWxkavYutJR4jQ1HrPBijdvekkqg8+5JwxQii
        7qm9cph7eDtMLhmK9Q5n5OwOLH5wyMT/hRjksjMS4YR9NeBa+d0n/lKEgmb6Ocxv
        nx8itSrKNZM8filGrzNDjk7ttiH3JOAyQI5cny4ZjFvx9IkfQiMQcYKsNEzvVcuF
        HV4g6EEZgcQlOFzOJ98i7URagMhZC78VXRSAE28Ku9rW7Cbd1gv8xq/To9E/MkM8
        x9g6XQRB1CmVeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=iHLdukaGrASJo2mSFXoagCfvXj43O
        AQHRO27Vpx/vTE=; b=EBLlTX/qRbL+Ytx8yCpy7TnPAZjnDC02oPQz98rQTAjN6
        011ft5drF7sMgDxDLF/0kcvOFeW+IzRu3E21WYKxFm8P/nJq73KaEvQ1uV8C4yrW
        n1M//dmWRgK6IiRvwlRKpYDjL9kVt8EKmT9nBaCEruUZyRUlpiUyy6HnnfZO+kNs
        bp9JKo4Q2TjSxLxu+g4jcFUA9FlAlrYbF1l/Zvi/fe8ZcWTaxvUyQS2xrNXw5U2v
        mIilN1sQmVowsE+oa27Kp6rGevaUqOJKBUJHAFOjqijoRJxUAeaVdIjMl99RxlVh
        YegVRIlCMwoMHR/XIQgPwbiSggTj//1sGjpfx2EvA==
X-ME-Sender: <xms:pPCzW0nkorYzVv5Uk71j3YG68cgcITBGHHnDQfays8bIMBfzs_bs9A>
X-ME-Proxy: <xmx:pPCzWx7ACoMcpbxyT2ayn7vISdqwKT_I9FYONMesjDJSlxcwkVAR4w>
    <xmx:pPCzW7Ib7adJ6HS0fZGTH7x68oefC8_oy6cwjyUC_Jbc0uwd9fIrng>
    <xmx:pPCzW-t0hjgw6v6q-zowOkqNCLS-X6yAz6FHIHeRw5FElY987jQgkw>
    <xmx:pPCzW3yLos7vlBlvmuA_0dbgt9KZxWv_NAt3WaD8_t1AtbaHVGPynQ>
    <xmx:pPCzW0JbSdYInS2649HEoN0CH2-yVNTwkFVyr9sqpqHL3yG9d0C5cQ>
    <xmx:pvCzW2VgayLTZA55r7LhKmJKguZhH_1wRhq48EUjo8blYaU2UW8IqQ>
Received: from localhost (unknown [64.124.202.226])
        by mail.messagingengine.com (Postfix) with ESMTPA id 178F7E446A;
        Tue,  2 Oct 2018 18:26:44 -0400 (EDT)
Date:   Tue, 2 Oct 2018 15:26:42 -0700
From:   Greg KH <greg@kroah.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH] nvmem: only build nvmem_find_cell_by_index() if OF is
 enabled
Message-ID: <20181002222642.GA19204@kroah.com>
References: <20181002110246.3175-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002110246.3175-1-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 01:02:46PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The following warning is produced when building nvmem core if
> CONFIG_OF is disabled:
> 
> drivers/nvmem/core.c:496:1: warning: 'nvmem_find_cell_by_index' defined but not used [-Wunused-function]
>  nvmem_find_cell_by_index(struct nvmem_device *nvmem, int index)
>  ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> This is caused by the fact that the only caller of this routine is
> under an ifdef depending on this option. Fix it by adding a relevant
> ifdef to the function in question as well.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

No "reported-by:" lines on this and the other patch?

Not nice :(
