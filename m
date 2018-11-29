Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C52CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA2120834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="SHWCnTXn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA2120834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbeK2VJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:09:43 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41210 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbeK2VJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:09:43 -0500
Received: by mail-lf1-f65.google.com with SMTP id c16so973651lfj.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 02:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KWE/R9lrV4PmO9vXTDjK1gVj25RR7siKl8PBSwBuFD8=;
        b=SHWCnTXn/qPRDpf+cKNKv2wnjJbv/SaujUEzX27Uaivs5v7KARLI/mfaG3F7Sehdlf
         Qn2zWMIxStNdiRupuhTVPHJCRtLsEVzJyvrTIvUI6Ie7plKrTeaMk9F7NsyELtuWBEFU
         x7ggsr9BiLhjBdVXCuKpQFq+h0QNnDN1CM5/0eqGPHlo2g4zT7Eu4B++KBzmHeQaF2TT
         OndvobzX+mV8iTDLZuGHTI03QqGlLRehL5eHtTlxdcKF3jQffFc5VnrX0Kp5stAKobg2
         faIV+eeefyOlSzB1H3j0IqV4u27v83rnNCPpwcDN8f5nMsYoZVWdWUELUeamTMScFDaS
         jZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KWE/R9lrV4PmO9vXTDjK1gVj25RR7siKl8PBSwBuFD8=;
        b=hFY2KNGl/eMG7gOSrZijx7dvAOiZjBOhg+8iqp2GB0l6y+LGWntRIocLLLjW6b1362
         TpLEheS78r3Z/66IH8T1MtDMnfsCYd4PlLTe2YPSm6sXR99b5HzCNtFBEG97BfGxoX8B
         9BfK8A0UHy2jSRXDvy1zZnepPbKSLkRobXUSQBXL+Aua/zqk43h0TR53aevv922fYhl7
         JCd8pJildmBp06gYZCCbeCckUjSvDYdGTi5OWX7fd+TOyywruxxeA797SbwCoYf5oUyl
         JWJv8qyp6XJxosGJD+cOYzi+YiBjK5FAAXGwXcPuCF79fouA/ZBqqIEyR7FG6qBcO6F0
         0BZA==
X-Gm-Message-State: AA+aEWbnOVqUS+PYd1+h93VlyzKMDvuGh7wLj/s2oiTmnr6tRAQTPUEA
        dw6848ull5SvhNSa85N7WIz6oQ==
X-Google-Smtp-Source: AFSGD/V/CJbuSesLe1Ica7bmNcYzPlagXSebyFKOKjd57zOCQFg8YKgvRyxDAtC0/rduaZWccCII6A==
X-Received: by 2002:a19:5349:: with SMTP id h70mr606996lfb.50.1543485893120;
        Thu, 29 Nov 2018 02:04:53 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.83.97])
        by smtp.gmail.com with ESMTPSA id z64sm222355lff.39.2018.11.29.02.04.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 02:04:46 -0800 (PST)
Subject: Re: [PATCH AUTOSEL 4.19 15/68] batman-adv: Expand merged fragment
 buffer for full packet
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        netdev@vger.kernel.org
References: <20181129055559.159228-1-sashal@kernel.org>
 <20181129055559.159228-15-sashal@kernel.org>
 <cad9ec40-5125-9bef-0e9e-5c70783a5cb7@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <3da190f1-254a-28d8-3219-1a129c5b8fda@cogentembedded.com>
Date:   Thu, 29 Nov 2018 13:04:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <cad9ec40-5125-9bef-0e9e-5c70783a5cb7@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/2018 01:00 PM, Sergei Shtylyov wrote:

>> From: Sven Eckelmann <sven@narfation.org>
>>
>> [ Upstream commit d7d8bbb40a5b1f682ee6589e212934f4c6b8ad60 ]
>>
>> The complete size ("total_size") of the fragmented packet is stored in the
>> fragment header and in the size of the fragment chain. When the fragments
>> are ready for merge, the skbuff's tail of the first fragment is expanded to
>> have enough room after the data pointer for at least total_size. This means
>> that it gets expanded by total_size - first_skb->len.
>>
>> But this is ignoring the fact that after expanding the buffer, the fragment
>> header is pulled by from this buffer. Assuming that the tailroom of the
> 
>    Pulled by what?

   Oops, this was a -stable patch! Nevermind then. :-)

>> buffer was already 0, the buffer after the data pointer of the skbuff is
>> now only total_size - len(fragment_header) large. When the merge function
>> is then processing the remaining fragments, the code to copy the data over
>> to the merged skbuff will cause an skb_over_panic when it tries to actually
>> put enough data to fill the total_size bytes of the packet.
>>
>> The size of the skb_pull must therefore also be taken into account when the
>> buffer's tailroom is expanded.
>>
>> Fixes: 610bfc6bc99b ("batman-adv: Receive fragmented packets and merge")
>> Reported-by: Martin Weinelt <martin@darmstadt.freifunk.net>
>> Co-authored-by: Linus Lüssing <linus.luessing@c0d3.blue>
>> Signed-off-by: Sven Eckelmann <sven@narfation.org>
>> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
> [...]
 
MBR, Sergei
