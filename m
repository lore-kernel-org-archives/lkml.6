Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7E3C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 03:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D71C20C0E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 03:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="QWqhl34S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tZx9wtx3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D71C20C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbeJSLHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 07:07:13 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34845 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726424AbeJSLHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 07:07:12 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8E2E921FAA;
        Thu, 18 Oct 2018 23:03:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 18 Oct 2018 23:03:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=f
        U9Z+zOBXzPr0M2qDsgxYxsgam4NzfGbB+xY6OdFe4A=; b=QWqhl34SLJOhu7Ep7
        N5idUgVEEVPPs/D8VrFsS9Q6ZWdZIDTqmxAit3tRzG8ifnL3j2dCgz6ktoregxBq
        eWzaXw7yntOAAnEu7vk+BA7L1e+NzQI9JWbsUjW2X4eF5MuckzTxJjSGpHZmae5K
        fe4J/HBwTdH3eu0ZCh+claGPkhNawRgYG+lyY+TERyjlQ0HiJP0ti+ywejTWhJXI
        EHK/cYvNLfniOVRMHswfjuTzYYGHk+fuFvdiT/PLmnXRIHUl+fZkSpK6sCWgfUoO
        jGAO0k0zqrDL9SOPsz6dWxrbjtjEEBF9H2xyMhhQADSVE7D6cY61A5/i4NXSFdTz
        7iqNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=fU9Z+zOBXzPr0M2qDsgxYxsgam4NzfGbB+xY6OdFe
        4A=; b=tZx9wtx3++1I8PzCC8qmTGvK3pCexMbGCCfoj+JXSmMGU9mKNUxhqLCH9
        MRaIllBT8VLJS4mIgnPX5CpupKYElhtEGxvZjeAUkfEDdHmtxWt9Etp6eVvtqo7a
        MIQYajrHqnJpbygziULCnnNavqd/saoAhLHq/DaqGjBjfwumfFDUDTKlMVYky7WI
        VCy5rhAinvQ0h0Yq/cGT2VY3toF7SS7ADLMguJzueeXO9PYSsVQnuGo3EDyGEwmh
        tDFqdMtUNP2+mW6Iak58A850Tvm28owwUJR7Og6Ae/QNoQ9217hgTD1uYx5Bn39c
        Hop0DjHpunfIyuD+tmqwDJ08JEcwQ==
X-ME-Sender: <xms:aknJW3POYYLADoCXX0XKm6x-MzuVtN3S4_5I16uXvVASwZ1mlTcn6w>
X-ME-Proxy: <xmx:aknJW0vTiQL21BDxPquxs9BMkwh6W-fzpEJLFfb_DWKQQivcJfhfxA>
    <xmx:aknJW66O6Wj0KYi_iZzWlL7uCPrVKq61cirh4MMioVvmgrozZ__vbQ>
    <xmx:aknJW_VhoDxsiCIyAj-v66OkGZBbEkYOVe_PZ4lPztAXwfIlkQbiPQ>
    <xmx:aknJW8_mEjTRTSezqLJftiEAQMqwdDeE8-68JS5YQbLpFsfYoS0Jiw>
    <xmx:aknJW7kma4vF3wfiNifHOh29dhURyO-KrZEm5MHR_LXcCT0kKmlBUQ>
    <xmx:aknJW29DmMLE2UM6i6wIbPrXHJ0fAQid9WWrcUzWlDAIdWA6aQVRmQ>
Received: from [192.168.50.162] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id CF0A0102DD;
        Thu, 18 Oct 2018 23:03:04 -0400 (EDT)
Subject: Re: [PATCH] firmware: coreboot: Fix a missing-check bug
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1539877023-6398-1-git-send-email-wang6495@umn.edu>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <a5f57d38-4345-ae87-0a25-b7429a8b97ea@sholland.org>
Date:   Thu, 18 Oct 2018 22:03:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <1539877023-6398-1-git-send-email-wang6495@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/18 10:37, Wenwen Wang wrote:
> In coreboot_table_init(), a for loop is used to copy the entries of the
> coreboot table. For each entry, the header of the entry, which is a
> structure coreboot_table_entry and includes the size of the entry, is
> firstly copied from the IO region 'ptr_entry' to 'entry' through the first
> memcpy_fromio(). Then the 'entry.size' is used to allocate the
> coreboot_device 'device' through kzalloc(). After 'device' is allocated,
> the whole entry, including the header, is then copied to 'device->entry'
> through the second memcpy_fromio(). Obviously, the header of the entry is
> copied twice here. More importantly, no check is enforced after the second
> copy to make sure the two copies obtain the same values. Given that the IO
> region can also be accessed by the device, it is possible that
> 'device->entry.size' is different from 'entry.size' after the second copy,
> especially when the device race to modify the size value between these two
> copies. This can cause undefined behavior of the kernel and introduce
> potential security risk, because 'device->entry.size' is inconsistent with
> the actual size of the entry.

Thanks for the patch.

However, this IO region is not associated with a hardware device. It is a table
in RAM that is only written to by firmware (coreboot) before Linux is ever run.
So there's no device on the other side that could race with the kernel here.

Regards,
Samuel

> This patch rewrites the header of each entry after the second copy, using
> the value acquired in the first copy. Through this way, the above issue can
> be avoided.
> 
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  drivers/firmware/google/coreboot_table.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
> index 19db570..20fcd54 100644
> --- a/drivers/firmware/google/coreboot_table.c
> +++ b/drivers/firmware/google/coreboot_table.c
> @@ -128,6 +128,7 @@ int coreboot_table_init(struct device *dev, void __iomem *ptr)
>  		device->dev.bus = &coreboot_bus_type;
>  		device->dev.release = coreboot_device_release;
>  		memcpy_fromio(&device->entry, ptr_entry, entry.size);
> +		device->entry = entry;
>  
>  		ret = device_register(&device->dev);
>  		if (ret) {
> 

