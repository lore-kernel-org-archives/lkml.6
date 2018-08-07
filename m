Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLACK autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390F7C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E229520C0E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnClIL/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E229520C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389485AbeHGQiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 12:38:06 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37511 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732639AbeHGQiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 12:38:06 -0400
Received: by mail-oi0-f65.google.com with SMTP id j205-v6so28758094oib.4;
        Tue, 07 Aug 2018 07:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7YqhuEk+P659GMgLrJyQUdbXaGwJv2m1E2YCu7BsK0g=;
        b=RnClIL/VaC1U+bDkzB85pNrAva637xv7BCFYiwknm+4iVupId3RIi5DUfGFx4Oe1VF
         HMIKZM+2aUrCqqW+8OXCCWk5uE7/LIDsVzECSGq9vV90T3NmZOy/Kwjk/Z7cdPOa81V6
         b9iJV6B+Np27uQJuLFjJyMp4wSemVVf+89XrZhH+DtZNAH4+buQgiL0VKSbNFlDvweEP
         dZS3J2QJZRYsWBL/ozGS9a9pZwfuQg3wnf8PAGW0nTuT72A9pQTpXihL+gWr8nn1yMPY
         MySqac50OYH/OOm3JsLJo9EP52ODBI4lPX73+PXnwyPXUAdSM/sLZC+ng8EZzrc6R+W7
         P+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7YqhuEk+P659GMgLrJyQUdbXaGwJv2m1E2YCu7BsK0g=;
        b=V4zUfmYa78K78BEv56zLo/ukn+fNppOdQOIIiVaNFsQv1RTrg+vZIi74Zb0lousbpF
         bpeerNJYksch6GES5IlEZfD5nSd7hA6Y+lcGszz7HAeje0FnR435aRvsTdoHgKECSdMF
         TNSJk8GrfEd01CCvKwiMfabuPH38a0KB/NaIRD+lEsvqEtTZoUuvEghviR4XLrZljcEG
         UBexKk42GdOhqY7qOZgwoIcCNeRguqixZFSaUES2Q1AIGMQZB0kPygU+3gXgBROY+tkQ
         gQ0pFuvsfqTzAUIm3HZH6+SZkdnK3qCtUo1crpqh/+17gNNKeLJMvg2gl6dXeqnyr0ct
         O7NA==
X-Gm-Message-State: AOUpUlHfBW7nBaaWBnKZ5MSU7p0xh0YUy/C2oFy7Otw8hZoX+8yG7kYP
        E5Xq8WtVRp0amsCk5h2ztmjcYOUL
X-Google-Smtp-Source: AA+uWPw4jyrNIGQ31LI5OVOJnJntBT8zW8tlblYa+u55y+88nREQQ5lb+thqWC46DPDk3HVPc4UCUA==
X-Received: by 2002:aca:c602:: with SMTP id w2-v6mr19173696oif.122.1533651811696;
        Tue, 07 Aug 2018 07:23:31 -0700 (PDT)
Received: from [192.168.1.107] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id w204-v6sm3044382oif.2.2018.08.07.07.23.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 07:23:31 -0700 (PDT)
Subject: Re: [PATCH] rtlwifi: btcoex: Fix if == else warnings in
 halbtc8723b2ant.c
To:     valdis.kletnieks@vt.edu, YueHaibing <yuehaibing@huawei.com>
Cc:     pkshih@realtek.com, kvalo@codeaurora.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, colin.king@canonical.com,
        linux-wireless@vger.kernel.org
References: <20180806045440.11920-1-yuehaibing@huawei.com>
 <63216.1533591775@turing-police.cc.vt.edu>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <577a831f-45c3-a687-ca04-edc977ddb925@lwfinger.net>
Date:   Tue, 7 Aug 2018 09:23:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <63216.1533591775@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2018 04:42 PM, valdis.kletnieks@vt.edu wrote:
> On Mon, 06 Aug 2018 12:54:40 +0800, YueHaibing said:
>> Fix following coccinelle warning:
>>
>> ./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:2952:2-4: WARNING: possible condition with no effect (if == else)
> 
>>   	/* sw mechanism */
>>   	if (BTC_WIFI_BW_HT40 == wifi_bw) {
>> -		if ((wifi_rssi_state == BTC_RSSI_STATE_HIGH) ||
>> -		    (wifi_rssi_state == BTC_RSSI_STATE_STAY_HIGH)) {
>> -			btc8723b2ant_sw_mechanism(btcoexist, true, true,
>> -						  false, false);
>> -		} else {
>> -			btc8723b2ant_sw_mechanism(btcoexist, true, true,
>> -						  false, false);
>> -		}
>> +		btc8723b2ant_sw_mechanism(btcoexist, true, true,
>> +					  false, false);
>>   	} else {
> 
> Rather than blindly fixing this, perhaps a bit of thought needs to be
> applied to why this code looks like this in the first place.
> 
> See commit c6821613e653a  (which looks like the bletcherous "do too many
> things at once" commit indeed), although the actual diff appears to be a
> "no harm, no foul" against this commit, where the issue already existed.
> 
> commit aa45a673b291fd761275493bc15316d79555ed55
> Author: Larry Finger <Larry.Finger@lwfinger.net>
> Date:   Fri Feb 28 15:16:43 2014 -0600
> 
>      rtlwifi: btcoexist: Add new mini driver
> 
> Larry? Can you reach back to 2014 and remember why this code
> looked like this in the first place?

The base code came from Realtek. My only part in getting it into the kernel was 
to clean up the checkpatch and Sparse errors and warnings, and submit it. I was 
a "script kiddy" just like the authors of the current patches. The only 
difference is that I was getting drivers into the kernel so that users hardware 
would work.

Any record of whether these duplicate branches are the result of incorrect copy 
and paste, or just extraneous code, would be at Realtek in their version control 
history. I have never had access to such archives, nor have I ever had an 
non-disclosure agreement with Realtek.

Ping-Ke Shih, who is Cc'd on these messages, might be able to answer these 
questions.

For the moment, these simplifications could be applied as long as they are 
correctly done. After all, they are not changing what is already there and that 
stops any other person that knows how to run coccinelle from submitting the same 
patch in the future. Why "kick the can down the road"? If PK can find that there 
was an error in the original code, he can submit a "Fixes" patch.

Larry

