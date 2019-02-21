Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DF0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0705A2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYjyleo4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfBUOCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:02:06 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33809 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfBUOCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:02:06 -0500
Received: by mail-pf1-f195.google.com with SMTP id u9so6622711pfn.1;
        Thu, 21 Feb 2019 06:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k5Schwkk1ah14OotQG7r095bpWgpXc7DDnuwku9sPow=;
        b=RYjyleo44vgSOKpZ27rFNL0kfrUAMRqzFCfI+cO+20a7B75sJ9gg09ipN4mDoxm+ca
         NyDB617LZqlWigaNbU2nP04X3yUd5rqBY0JuJx3fHyDsJvhOZoNC3ArINasEPhnSHoZm
         MP6nWgOsPDi+KJMsVWz7t2hJ+an7WBDLIvbU4yPyHFSOPLHn0qFvlo0qzogX1scHZOM1
         1SPxZixECxNZ8jtaJPyUSIBBl5jrA/NYCJqisgmLGfTh3ml0652q1Wn+bqxjViCoQOKP
         SG8CMfEXzBMJtFWFG5vntLVciHRK0wKzTfp7MREB9hRt7A88Cuh1PLxDJpoLUj0/3fSk
         qP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k5Schwkk1ah14OotQG7r095bpWgpXc7DDnuwku9sPow=;
        b=n3j367idUH3sOD6EEOIiOzzlzBYgBRzcBStPMlhAz1t5lufbMhDIhWtjFl5K5PDzdV
         fhVLTMSXQMngUomGu/zxiJg7P7PtksBfkVS++mNNxMgf4KkEqQVGikgIJUDVsIgC6EEI
         Lkyfb1L9zRtSwVVPMyi8Ipp7cHFVbi5HHm0N5U9TgitLOpSDKgtxhIvYKuDIuBbHYuqE
         HgzZYtknqechjSZwMSoFwodRZnGsYgRGk5/t3002cIfOkqg6xZ0vQF6nStrdu9JcDjBy
         a/SjHqHvKX8kUb0g9bSphL7S9V4fb63y0P6exzgjeSWxGfMpAyo1bQqsi185RDOlrzsY
         LV/Q==
X-Gm-Message-State: AHQUAuYw/xGbCDFBs/zT+bXcgXkmLGmHbV184Ta6QxHMcMDI6+Q+ApkN
        RKi9AAaUFt3lwvTmkNAQpp5gQD3y
X-Google-Smtp-Source: AHgI3IaGMSPKx0COprFB9zJpl/VnN6qE5PdAd4c2nAfwXT+t48pvhDtEdGBohAI5lTVTFJvdDoUxVw==
X-Received: by 2002:a63:d70a:: with SMTP id d10mr34327070pgg.286.1550757724896;
        Thu, 21 Feb 2019 06:02:04 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h15sm28148144pgl.43.2019.02.21.06.02.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 06:02:03 -0800 (PST)
Subject: Re: [PATCH v2] dt-bindings: hwmon: Add missing documentation for lm75
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-hwmon@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20190212113808.3040-1-jagan@amarulasolutions.com>
 <CAMty3ZBaOZoj+xV+e+4BtYdaWA2biwENmngOa9vbbMB=_vbB1w@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <59969c88-585c-cb7d-3104-8059b78ed2e3@roeck-us.net>
Date:   Thu, 21 Feb 2019 06:02:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMty3ZBaOZoj+xV+e+4BtYdaWA2biwENmngOa9vbbMB=_vbB1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/19 9:22 AM, Jagan Teki wrote:
> On Tue, Feb 12, 2019 at 5:08 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>>
>> Add missing dt-binding documentation for lm75 hwmon sensor.
>>
>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>> ---
>> Changes for v2:
>> -  Add all compatible nodes available in lm75.
>>
>>   .../devicetree/bindings/hwmon/lm75.txt        | 37 +++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/hwmon/lm75.txt
> 
> Any comments on this? It is blocking some dts changes to get merge
> into Mainline.
> 

Waiting for Rob's Ack.

Guenter
