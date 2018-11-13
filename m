Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C56DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1BB20685
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SW85G0v1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E1BB20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732514AbeKMVSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:18:18 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:57036 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732390AbeKMVSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:18:17 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 336C710C06BA;
        Tue, 13 Nov 2018 03:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542108038; bh=xDbYxh2zFyP44iZnShJMwgoJko8io8nNt+lMpDnQ9RI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=SW85G0v1UmImz2/3nCtayGJJYds3gI6LlpLWMfTiM9Bl5n+gtvAQ7g+o7I6kmiiGY
         SSh20bLhkKu7SBEZmHGROfH65tD/cPOsRpZHwOIhPZcpMF5F4zfFvv4pNwFxCpNPwZ
         x2hJor8NiMux4z5vuiWgHFjaVLGH7s4BI8r879drRr+yStCN4V9KWkpIvqgNcg6WPy
         QL5dBHo4dJWhk9/MVWkRwAV57ng+80FUE7A9CdKo4YqNPPxAraktX+SieZmyFNC3KO
         IYg8Qpr09UBMVRdakAA4xpVtc6dKeyq4qhGwAYlWOK2Es1M30rENiJIQ+o2n8WDqPc
         etS5XcDX0teOA==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 9C5833E18;
        Tue, 13 Nov 2018 03:20:35 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 13 Nov 2018 03:20:32 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 13 Nov 2018 12:20:29 +0100
Received: from [10.0.2.15] (10.107.19.128) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 13 Nov
 2018 12:20:29 +0100
Subject: Re: [PATCH v3 2/3] dt-bindings: i3c: Document Synopsys DesignWare I3C
 master bindings
To:     Rob Herring <robh@kernel.org>,
        Vitor soares <vitor.soares@synopsys.com>
CC:     <boris.brezillon@bootlin.com>, <wsa@the-dreams.de>,
        <linux-i2c@vger.kernel.org>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <arnd@arndb.de>, <psroka@cadence.com>, <agolec@cadence.com>,
        <adouglas@cadence.com>, <bfolta@cadence.com>, <dkos@cadence.com>,
        <alicja@cadence.com>, <cwronka@cadence.com>, <sureshp@cadence.com>,
        <rafalc@cadence.com>, <thomas.petazzoni@bootlin.com>, <nm@ti.com>,
        <pawel.moll@arm.com>, <mark.rutland@arm.com>,
        <ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <geert@linux-m68k.org>, <linus.walleij@linaro.org>,
        <Xiang.Lin@synaptics.com>, <linux-gpio@vger.kernel.org>,
        <nsekhar@ti.com>, <pgaj@cadence.com>, <peda@axentia.se>,
        <mshettel@codeaurora.org>, <swboyd@chromium.org>,
        <joao.pinto@synopsys.com>
References: <1541697251-20392-1-git-send-email-soares@synopsys.com>
 <1541697251-20392-3-git-send-email-soares@synopsys.com>
 <20181113020957.GA31668@bogus>
From:   vitor <vitor.soares@synopsys.com>
Message-ID: <ec1059fa-420e-ee18-1831-170904c0ccd0@synopsys.com>
Date:   Tue, 13 Nov 2018 11:20:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181113020957.GA31668@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.107.19.128]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 13/11/18 02:09, Rob Herring wrote:
> On Thu, Nov 08, 2018 at 05:14:10PM +0000, Vitor soares wrote:
>> Document Synopsys DesignWare I3C master module
>>
>> Signed-off-by: Vitor soares <soares@synopsys.com>
> Please make your author and S-o-b emails match.

This is an alias and both email will work. Anyway I agree that should be 
the same that appear in the mailing list and I will change it.

>> ---
>> Changes in v3:
>> - Remove dummy characters
>>
>> Changes in v2:
>> - Address the changes in Documentation/devicetree/bindings/i3c/i3c.txt
>> - Add controller version on compatible string
>>
>>   .../devicetree/bindings/i3c/snps,dw-i3c-master.txt | 42 ++++++++++++++++++++++
>>   1 file changed, 42 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
> Otherwise,
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks for review.


Best regards,

Vitor Soares

