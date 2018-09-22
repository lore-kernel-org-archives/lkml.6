Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0909CECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 23:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE0920684
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 23:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cp+0BzRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE0920684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbeIWFwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 01:52:21 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35613 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeIWFwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 01:52:21 -0400
Received: by mail-pf1-f196.google.com with SMTP id p12-v6so7527337pfh.2;
        Sat, 22 Sep 2018 16:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yhU6AFucjYuaEBlXVfmhqsSUjsj7F/FZ3yfpqeIQT5w=;
        b=cp+0BzRXHG7YR4QT9lM/VGA1RlJdjXjvowfoSqlrtjS9gOhQy//A2gHLYZ1Tp6devk
         Yh+tN9OrMfEqN+nBZ9+cXr1f5/eNlX3yG92CTsvDqtBuU+zm/SmSg7xABdq1ueUxgPfy
         nhPsWL4d+jZGW++YM8hcsjfo9gIY7S/OTer2/xbcUegFoWmYRMq6ysxYau5xoS48dxPU
         fGtdgqEGmA43zcNL1G8hsfdLNKbvO8xtD19OhEN7j2RHXySDxxQ1Ffc6hck5CslMNDNa
         /AJz40BWnV6Y5yRQVJDKhgM+I0G2L8d8i/FAELXCGdz38FBKYYWGGkMVwmzzXDm+WSIm
         QTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yhU6AFucjYuaEBlXVfmhqsSUjsj7F/FZ3yfpqeIQT5w=;
        b=qvp0lEXlLxSYN0yiLpQPbIKQ1hCkdTt8c6yCkb46i+ZB+H0F8xDRb1CX8ZbkZeEXLw
         0/v5ZtpGSdCLbMUywXIzRphyof2ZrsnElhH2ycj+OhXZmYHA6trx9EN5VafmuBRrGOse
         x+/SvGqPklmt6tc4KqLdGiRT+AwpgUsvR6aif+AKg15l9fKQHVr80WxUZZvxBxGEhZyZ
         1rc9DkICaFXMHBaJWEDE7mccn27WWJ06XX/3O8QAdh1LqOrMwnqLNS8OppvkDyDr0yJb
         2mgbixMZ/ASsEW2JuY5v47OmCLfqAv7qdWEXGtRPlfcNvWPmij4ENdu+HwePST052+z4
         ozRQ==
X-Gm-Message-State: APzg51AvU/Px8TUsD9zUzVvduv0IFinS8Evs2gootTNS8GdWs8CW4A2m
        hCYypvLqLZ5X+a3XM9rsin0Gsjqn
X-Google-Smtp-Source: ANB0VdYCnY4Abq96LKg8N9o4Kbp+gKGCe3ddSwPfADxJNy9PvLwQjq7GTNXAtsexTtzRB4cUMczLvQ==
X-Received: by 2002:a62:8208:: with SMTP id w8-v6mr4047724pfd.215.1537660618262;
        Sat, 22 Sep 2018 16:56:58 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id o21-v6sm51202242pfa.54.2018.09.22.16.56.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 16:56:57 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: Add ina3221 documentation
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        corbet@lwn.net, afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20180921223216.634-1-nicoleotsuka@gmail.com>
 <20180921223216.634-2-nicoleotsuka@gmail.com>
 <3c117b80-f671-1e57-6eab-3d9801b4b889@roeck-us.net>
 <20180922180348.GA9092@Asurada>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b29cff36-b6c0-e9df-475b-f5138cff06c4@roeck-us.net>
Date:   Sat, 22 Sep 2018 16:56:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180922180348.GA9092@Asurada>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/22/2018 11:03 AM, Nicolin Chen wrote:
>>> +2) child nodes
>>> +  The names of child nodes should indicate input source names
>>> +
>>> +  Required properties:
>>> +  - input-id: Must be 1, 2 or 3
>>> +
>>> +  Optional properties:
>>> +  - shunt-resistor: Shunt resistor value in micro-Ohm
>>> +  - status: Should be "disabled" if no input source
>>> +
>>> +  Example:
>>> +
>>> +  input1 {
>>> +          input-id = <0x1>;
>>> +          status = "disabled";
>>> +  };
>>> +  VDD_GPU {
>>> +          input-id = <0x2>;
>>> +          shunt-resistor = <5000>;
>>> +  };
>>>
>>
>> Using child nodes is a good idea. However, you are converting the node name into
>> the hwmon 'label' attribute which I can not accept. First, it is undocumented,
>> second, it effectively creates an undocumented property (if one wants to configure
>> the shunt resistor value, one has to configure a child node which is converted
>> into a label), and third, it violates the hwmon ABI ('input1' is not a "hint
>> about what this voltage channel is being used for").
> 
> Oh. I see the point here now. Then a child name could be just input[123],
> and I will add a separate optional child property to indicate the label.
> 
Exactly. "label" is quite widely used as property name, so that should be acceptable.
I am not sure about index; we'll see if Rob has any comments.

Thanks,
Guenter
