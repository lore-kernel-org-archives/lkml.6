Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BD5C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7995421EEA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linuxvaults.com header.i=@linuxvaults.com header.b="Z3uJ24ub"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7995421EEA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxvaults.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752898AbeGDTqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 15:46:19 -0400
Received: from crystal.urlnameserver.com ([99.198.127.110]:54491 "EHLO
        crystal.urlnameserver.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752607AbeGDTqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 15:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linuxvaults.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=demCyN6DBjyUioaff09hExLrMXe1gLnzFbAAkFEkPWk=; b=Z3uJ24ubxuBQo0KJAZgYzShBk8
        ODP1igLvEjpUy73lqv2tzEiUn4aB91ArCeW5/Mvw4gR+z7mYzN3h8sCW65t9VQvA7lkz8lmF+TN8d
        N6GPO4a/Jlrkx9EDsSLzX1ww64D65s0UHLXfb4X8RU38wz8X3ZvlM0LUDYh9mZ0B2/Md5Bw0ZuPBp
        YbXNMNvulFiThwVkDTeHsRW1BpiTK5z/pkFjdXzrVSZrhcbojP5tb/KEdmGiLMlUZ4gv9JcY6Z72D
        6LJoBkESjwUwqhofYDHbc2QyBu8JBrmA0FEwdbX6g6/+jj9lY2SPeT0AFwBca1wZwXaV6XTjxK+X6
        CTZ6W/Kg==;
Received: from [46.186.216.156] (port=58561 helo=[127.0.0.1])
        by crystal.urlnameserver.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <tsuliman@linuxvaults.com>)
        id 1fanj5-0003wc-FB; Wed, 04 Jul 2018 14:46:07 -0500
Subject: Re: [PATCH 3/3] drivers/speakup: Fix style and coding warnings
To:     Justin Skists <justin.skists@juzza.co.uk>, w.d.hubbs@gmail.com,
        gregkh@linuxfoundation.org, speakup@linux-speakup.org
Cc:     devel@driverdev.osuosl.org, chris@the-brannons.com,
        dhowells@redhat.com, linux-kernel@vger.kernel.org
References: <1530603080-1353-1-git-send-email-tsuliman@linuxvaults.com>
 <1527895743.93688.1530605455516@email.1and1.co.uk>
From:   Tamir Suliman <tsuliman@linuxvaults.com>
Message-ID: <fb7d3816-255d-15e7-b9ef-533b1167f73c@linuxvaults.com>
Date:   Wed, 4 Jul 2018 22:46:05 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1527895743.93688.1530605455516@email.1and1.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - crystal.urlnameserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxvaults.com
X-Get-Message-Sender-Via: crystal.urlnameserver.com: authenticated_id: tsuliman@linuxvaults.com
X-Authenticated-Sender: crystal.urlnameserver.com: tsuliman@linuxvaults.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Interesting construct...  Yeah I'm little bit rusty on my C 
/programming  . I understand  proper coding style may be should end with 
else so I wasn't sure .. however this resolved the warnings. :)


Did you compile this?


Yes I did compile  however the only issue i found when I'm compiling is  
modules symvers missing messages researched online and found couple of 
articles that recommended  to  run full kernel build . Please bear with 
me I'm new to this and very excited about learning and contributing.



On 7/3/2018 11:10 AM, Justin Skists wrote:
>> On 03 July 2018 at 08:31 Tamir Suliman <tsuliman@linuxvaults.com> wrote:
>> +++ b/drivers/staging/speakup/keyhelp.c
>> @@ -167,7 +167,7 @@ int spk_handle_help(struct vc_data *vc, u_char type, u_char ch, u_short key)
>>   		synth_printf("%s\n", spk_msg_get(MSG_HELP_INFO));
>>   		build_key_data(); /* rebuild each time in case new mapping */
>>   		return 1;
>> -	} else {
>> +	} else if {
> Interesting construct...
>
>
>> @@ -787,7 +787,7 @@ static ssize_t message_store_helper(const char *buf, size_t count,
>>   			continue;
>>   		}
>>   
>> -		index = simple_strtoul(cp, &temp, 10);
>> +		index = simple_ktrtoul(cp, &temp, 10);
> Did you compile this?
>
>
> Justin.

