Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9E5C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 22:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7F120854
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 22:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Fa9rxh6S";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FWoIZS4W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7F120854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbeJEFWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 01:22:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54102 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeJEFWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 01:22:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F37F860BF7; Thu,  4 Oct 2018 22:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538692002;
        bh=bCKBjiLJ8rNaNJYhQNqP2ZYuAhl5owxFi+wSbXrycas=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=Fa9rxh6S1//JnKBUUdUw5XZjVkjMXmVWDxUnMZkDFM70r52c/ZK39Lkj/d1kMWCNp
         rSNQ2ON4XgUlphMnsW6/l9Qny5V8U5aQ4yYrZ+pv9XH+OdlzVXl+cyVaHpFu7yRcdu
         KhZlkdCpFtAHiQgxpfugezo23A9lx8Gd+2jOKMfw=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EF6116076A;
        Thu,  4 Oct 2018 22:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538692001;
        bh=bCKBjiLJ8rNaNJYhQNqP2ZYuAhl5owxFi+wSbXrycas=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=FWoIZS4Wt0qcSFUvQYZMoHUsLZyEIGnOutasSnK906ql18MWcd37h4GuO0Oj0OoqW
         PEDGJOTcZ2Z9Hn1S0GTVr2+WuGadcvkrIrcybSY6eEQpdyqA5K08YdneUnR8D42vfp
         oVDW1GS5wrA1IW2MrCwbKrsu1/dFT4lPn4VEgZpY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EF6116076A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v4 3/3] gpiolib: Show correct direction from the beginning
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Timur Tabi <timur@kernel.org>, swboyd@chromium.org,
        linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20181002140858.16833-1-ricardo.ribalda@gmail.com>
 <d1bbafcb-1b6a-b137-1fd1-954c17e14836@codeaurora.org>
Message-ID: <da760bcf-4716-e685-1ce4-1dbc6eb7c272@codeaurora.org>
Date:   Thu, 4 Oct 2018 16:26:40 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d1bbafcb-1b6a-b137-1fd1-954c17e14836@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/2018 9:21 AM, Jeffrey Hugo wrote:
> On 10/2/2018 8:08 AM, Ricardo Ribalda Delgado wrote:
>> Current code assumes that the direction is input if direction_input
>> function is set.
>> This might not be the case on GPIOs with programmable direction.
>>
>> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> 
> I'll try to get this series tested on QDF2400 by the end of the week. 

1-2/3 (v3) and 3/3 (v4) still fails.  Same issue.  Attempting to access 
config registers for GPIO 0 when the OS is not allowed to do that.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
