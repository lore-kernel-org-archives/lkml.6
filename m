Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2CBC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3908208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnFY9ePt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3908208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeJSDPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 23:15:32 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39599 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeJSDPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 23:15:32 -0400
Received: by mail-pl1-f195.google.com with SMTP id e67-v6so5756614plb.6;
        Thu, 18 Oct 2018 12:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QF/LrY7iuL/AJgxskEfZ1z5Dz2J5Os8EfJ/RaKbgPVQ=;
        b=pnFY9ePt8LIwvV6bnejjjQHDnPGo/nBouYD0Rck4HJJi+YgAg8NNgD1IDPLbVb8Rkf
         9xUDJG5d4tiBLNSPC8+E4YDl6W1bZ2H5NhOeNpOKVXfDUdzQVSLutECVh/uCOgBbExbs
         JoEqOUIW9JtJvYC3TRehXL/UuEn5L9ie7LZv/fcWjd3Nuei/wioLqtNc/74DY2BQcsxO
         O8vXEda8QnWmCbg3Xb+K0pvm28qiT30XatVvl2TdKn3Wfece4HqGm1Nd2kXk6+4SzirB
         PEJ4Uk1iS6ngMThTPQ3W6m/YnMRFzQm74LCS8GgsUCyThooXYZc1bluvbakwuE8TXo5K
         dohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QF/LrY7iuL/AJgxskEfZ1z5Dz2J5Os8EfJ/RaKbgPVQ=;
        b=SHXYBMcApZ+FK08bc+kspHa4NKd6YYIDqNL0uSCQNoPJvroWFbuHiSUJELk83Zh4bm
         HQTPJrQZnrOAyK8cVf1iT1gxGU0kyV7P1cv6mHgq33HyIlOnUwCCcppIMzxrVjFSiOJy
         49Wo9U5g/BZitFZIdl/jO12LbpSmAl0lCjLCYXXVmVxKTPBieyuUkozcRgYitaA9D3k6
         FrLna1uBUbXaxcyKYYPnJ5UhDrsYndNwB6Z5S9VYs3pj7marGiRV79WbyFXQ1MdlIfbs
         9MPBswQRgGZWlCL/ExXsit/rP36JdamqSKoxQ04oDYR68O+TRvFGoa3xDs99X35d2XSi
         tGdw==
X-Gm-Message-State: ABuFfohTJ5DG2VPp2iMLcCUBYWSLMNb6+bpuZfcfQjhbhbtQ5gf8QOCf
        GJVYJnEKqD/lHjmW5FxZ0g8=
X-Google-Smtp-Source: ACcGV61vCE0ZwCYVrWt4ggVKaQd2SaX1lI2I5hvx6jI+0dIOMQozHakxBBOsX1H0sVlhQ5jQZbqHLw==
X-Received: by 2002:a17:902:bf44:: with SMTP id u4-v6mr2975568pls.48.1539889986567;
        Thu, 18 Oct 2018 12:13:06 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id 25-v6sm45982117pfm.36.2018.10.18.12.13.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 12:13:06 -0700 (PDT)
Subject: Re: [PATCH v4 09/18] of: overlay: validate overlay properties
 #address-cells and #size-cells
To:     Rob Herring <robh@kernel.org>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
 <1539657458-24401-10-git-send-email-frowand.list@gmail.com>
 <20181018181338.GD15557@bogus>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <b6c378d0-19db-5426-7c3a-dbbc5907c37c@gmail.com>
Date:   Thu, 18 Oct 2018 12:13:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181018181338.GD15557@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/18 11:13, Rob Herring wrote:
> On Mon, Oct 15, 2018 at 07:37:29PM -0700, frowand.list@gmail.com wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> If overlay properties #address-cells or #size-cells are already in
>> the live devicetree for any given node, then the values in the
>> overlay must match the values in the live tree.
>>
>> If the properties are already in the live tree then there is no
>> need to create a changeset entry to add them since they must
>> have the same value.  This reduces the memory used by the
>> changeset and eliminates a possible memory leak.  This is
>> verified by 12 fewer warnings during the devicetree unittest,
>> as the possible memory leak warnings about #address-cells and
> 
> Still missing the rest...
> 
> And what about my other comments too?

Apologies, paper bag.  Will fix all.

-Frank

> 
>>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>> Changes since v3:
>>   - for errors of an overlay changing the value of #size-cells or
>>     #address-cells, return -EINVAL so that overlay apply will fail
>>   - for errors of an overlay changing the value of #size-cells or
>>     #address-cells, make the message more direct.
>>     Old message:
>>       OF: overlay: ERROR: overlay and/or live tree #size-cells invalid in node /soc/base_fpga_region
>>     New message:
>>       OF: overlay: ERROR: changing value of /soc/base_fpga_region/#size-cells not allowed
>>
>>  drivers/of/overlay.c | 42 +++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 39 insertions(+), 3 deletions(-)
> 

