Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AA5C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145D020867
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0znbCli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145D020867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbeISBnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 21:43:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33891 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbeISBnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 21:43:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id d19-v6so1567889pgv.1;
        Tue, 18 Sep 2018 13:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gExZ7n3rSpcp4K4oLKCh4VI0q9E/eIpSOcyxZn2on1U=;
        b=P0znbCliyH+zVhD6iuceAcobxgqZJsUDtrT4lZ3ZjbonvHHi/0DabS1ZZ0/ZVlRyCY
         g7+SCdEduolKhWV/Vw3hqvGDBxusA1XgE4cGYGGJRBl/clODskcr/kWqb2CicYICL3IO
         2osB+wh4qknbOuWZkRz5wm199T0FvkxZw4AqoD7IA9XqMXIUM978LROX1OQGW9ovLLAU
         CMRUd1Ux0CjczXjjq6jTTQHsgPvBSXTaiHFz71SYcWNNUX2SFAKUwLGWUQxS9jMfIfVZ
         8UV1zo62PWc8tvLnq9z5mIV4ieSyYdyvYD9eH1zJDEPvb48v2m0PCHgV8Zhfi0mxF+R7
         qbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gExZ7n3rSpcp4K4oLKCh4VI0q9E/eIpSOcyxZn2on1U=;
        b=XebKNjc4jUgu1kwJqmAznXduwdtVVk3SpZXU1ulPDiwJGNdowlS2GfO2DFBl11Pj+u
         pnE4YjvW+b3ZRuZT9PHbWpFvoirdcUJs6kXrQG77/CHfhaO/ujT6yggK4vSls+ZfmJlR
         9JEbwdzsOdlP1P6/7WHB8P8iy3x+q8NtTB2dELOPX7DqRfB5WvKVmp4JuyhjrspKkGqo
         G/bwyebafBIx2Rk87QxsNwdLyFaXziBZXkyHz93IGmSid0Y9MOJYrXIDXCrOtP0J4h80
         QQ2voyGkb9indJhmVDWIhoaIkWqcagEkMgqO84j93XxPp3eVIEhRMsfW9uWLM8PmVX4a
         fBqQ==
X-Gm-Message-State: APzg51AAkzsxS8c3ElMvumbMg9fzDOYDmEUSAdt/tl7uHEIQFElbstfC
        FNsB/89p+9s/m2O+eALU9Nw=
X-Google-Smtp-Source: ANB0VdYQqxe5Vxk2H4tfDiNadjjNA9SwFKqBQYZtEUmU9f7KK6sVBInGrghXuWSwbin2mcj7ooQmow==
X-Received: by 2002:a62:2646:: with SMTP id m67-v6mr32753546pfm.254.1537301342673;
        Tue, 18 Sep 2018 13:09:02 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id 22-v6sm26990807pfl.126.2018.09.18.13.09.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 13:09:01 -0700 (PDT)
Subject: Re: [PATCH 3/3] scripts/dtc: Update to upstream version
 v1.4.7-14-gc86da84d30e4
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20180913202828.15372-1-robh@kernel.org>
 <20180913202828.15372-3-robh@kernel.org>
 <f9684222-fae0-c305-d48a-be77ebb985a3@gmail.com>
 <CAL_JsqLTcLVGCmjTMi8GojomP=VbFQ5EqKcGnOPo=Wwh5Lc_mw@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <6414499d-2261-ef50-617e-a743173a3041@gmail.com>
Date:   Tue, 18 Sep 2018 13:09:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLTcLVGCmjTMi8GojomP=VbFQ5EqKcGnOPo=Wwh5Lc_mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/18/18 11:55, Rob Herring wrote:
> On Fri, Sep 14, 2018 at 2:32 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 09/13/18 13:28, Rob Herring wrote:
>>> Major changes are I2C and SPI bus checks, YAML output format (for
>>> future validation), some new libfdt functions, and more libfdt
>>> validation of dtbs.
>>>
>>> The YAML addition adds an optional dependency on libyaml. pkg-config is
>>> used to test for it and pkg-config became a kconfig dependency in 4.18.
>>
>> For Ubuntu, the libyaml dependency is provided by the packages:
>>
>>    libyaml-0-2
>>    libyaml-dev
> 
> Yes, but as it is not yet required by anything in the kernel I don't
> think that needs to be documented yet. Also, offhand, I don't think we
> generally document in the kernel distro specifics like package names.
> 
> Rob
> 

Agreed.  I was providing information that might save other people a bit
of research.  It is sufficiently visible in the email thread and does
not need to be in the commit message.
