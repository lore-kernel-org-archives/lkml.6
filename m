Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB632C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B42D2070B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="tXTeH0/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfBHIs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 03:48:58 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35982 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfBHIs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 03:48:58 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so2679527wrv.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 00:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J8ap7TVKBo6kF0rG+M5AdLUG4eAuiDx6Pq6cCaDWkJ0=;
        b=tXTeH0/v3uc7Qd5/NYENBzKDAjhFjRzzqsx64+QfGP4t0b0sbtcafEJdq9fEbsGtXB
         EbVUjeX1PZ+s8j5ukfvew0zPoqE8fRtSHRj3NzMWKuIgGVwo3H7dFEwqCIqvBrMCQsfc
         j6TxFnvvvwaRy1PDQFmQA90rdrzrwx47Fv/BOv1JmLy5YNW/DicKT2NRtR/fkYljO7qz
         x6quCopmaORWQclVaGHZ6kypNMjJQJW4lKkJbwCIWbwMIUi/DW4RPHjZhgai3B031NwI
         cFuS3bCHc4pPOOXZsuPbUf5gL3NL025B2ST+3MazvKKhcA08Hl0ccZwyzh4JNIAoUlQi
         xaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J8ap7TVKBo6kF0rG+M5AdLUG4eAuiDx6Pq6cCaDWkJ0=;
        b=RZcU7MWXooK8Hj/YF9ceRhz3jWQ7darIXSY2jtlmIYZUlHKkJu7TkdPRKfMqxax0NN
         ivxwF+Ll2LCscziSGZNxqVXpqLAINfMzUGdcHu5mTqwWKHptUbE+ZLJSuuShw7JRqTkV
         LzkcVBZZj2NWBCjWYqroXNLKKNwhj0V2aSyatFpSmgvTGcMCi0DxgBsTfbuFtKGK8prB
         okhgPDR3CziCcHvTOhRW4ZVLV8B4pu2g//ARTSBe46jE3x5VQv70KH5bY/8+bnYr7Iw9
         mYnvYIP3yeXsdlKUVItc/EGyRi2fB6lfeb+qM4W0oLtSCLSvB8MmX27EK2aFfRB5+Qzz
         lClg==
X-Gm-Message-State: AHQUAuYIqoISNlyuf+70INCpa6GOfwvJMIxYl6OOJX3KATR9AzY8zMrJ
        Q186PFW6M0xBULF7w8745Y4n8Q==
X-Google-Smtp-Source: AHgI3Iavgwpy69TWxcbssKhfi+69Q+tYXNc6G3SgRzwbHHVyx9+dgeyb/tRSI+ZkT9URp0V4VprTqg==
X-Received: by 2002:adf:9123:: with SMTP id j32mr16484330wrj.122.1549615736471;
        Fri, 08 Feb 2019 00:48:56 -0800 (PST)
Received: from localhost (ip-94-113-219-55.net.upcbroadband.cz. [94.113.219.55])
        by smtp.gmail.com with ESMTPSA id c1sm3074359wmb.14.2019.02.08.00.48.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 00:48:55 -0800 (PST)
Date:   Fri, 8 Feb 2019 09:39:42 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Simon Horman <simon.horman@netronome.com>
Cc:     Eli Cohen <eli@mellanox.com>, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jakub.kicinski@netronome.com, dirk.vandermerwe@netronome.com,
        francois.theron@netronome.com, quentin.monnet@netronome.com,
        john.hurley@netronome.com, edwin.peer@netronome.com
Subject: Re: [PATCH net-next 2/2] net: Change TCA_ACT_* to TCA_ID_* to match
 that of TCA_ID_POLICE
Message-ID: <20190208083942.GD2353@nanopsycho>
References: <20190207074549.29861-1-eli@mellanox.com>
 <20190207074549.29861-3-eli@mellanox.com>
 <20190208080141.dlksz5dfkufj2sbm@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208080141.dlksz5dfkufj2sbm@netronome.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Feb 08, 2019 at 09:01:42AM CET, simon.horman@netronome.com wrote:
>On Thu, Feb 07, 2019 at 09:45:49AM +0200, Eli Cohen wrote:
>> Modify the kernel users of the TCA_ACT_* macros to use TCA_ID_*. For
>> example, use TCA_ID_GACT instead of TCA_ACT_GACT. This will align with
>> TCA_ID_POLICE and also differentiates these identifier, used in struct
>> tc_action_ops type field, from other macros starting with TCA_ACT_.
>> 
>> To make things clearer, we name the enum defining the TCA_ID_*
>> identifiers and also change the "type" field of struct tc_action to
>> id.
>> 
>> Signed-off-by: Eli Cohen <eli@mellanox.com>
>> Acked-by: Jiri Pirko <jiri@mellanox.com>
>
>...
>
>> diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
>> index 7ab55f97e7c4..51a0496f78ea 100644
>> --- a/include/uapi/linux/pkt_cls.h
>> +++ b/include/uapi/linux/pkt_cls.h
>> @@ -85,7 +85,7 @@ enum {
>>  #define TCA_ACT_SAMPLE 26
>>  
>>  /* Action type identifiers*/
>> -enum {
>> +enum tca_id {
>>  	TCA_ID_UNSPEC = 0,
>>  	TCA_ID_POLICE = 1,
>>  	TCA_ID_GACT = TCA_ACT_GACT,
>
>This change updates the UAPI. It seems to me that it would not
>break existing users. But I would like to ask if this has been
>given due consideration.

Sure it has. I believe this is UAPI-safe change.
