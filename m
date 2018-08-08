Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF38C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C224621771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lkx1RGXn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C224621771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbeHHSTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:19:46 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:43420 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeHHSTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:19:45 -0400
Received: by mail-oi0-f67.google.com with SMTP id b15-v6so4557428oib.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 08:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uTLzsULbAt/wywxoSKrw71k7NJZtO4BWa+vNb7RUYCA=;
        b=Lkx1RGXnd6egKzazEveQwdcqPwNg8vvWDE0MU4LdFyRWEvlXqvTBA2A5uGhDylK34u
         FhLXjPAKPSgDjRUHJbYIezBUoT7caDSbY16pKqIs2jITe+PSd9pBgSKEZWfSkHMYeibp
         FYt0sAq6drw7EY1wGBc1PXD3tQbg5rkj19GwjpAJqsChETKHuptqI0WGudgvbo+0yMsc
         TIyDfu27RU2OhOAHR0jnNEEGO7RVopYxoDG0HAUYZcydyrBUEMXe3Xixtr7e64/NM+qn
         dq/D4t/9CZ8a4lYl066zvx2MjCdGQrD1srvfbCky2PTci45wGE2yB14aiz0bmXxT/2vI
         J/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uTLzsULbAt/wywxoSKrw71k7NJZtO4BWa+vNb7RUYCA=;
        b=VBSyJRLDBB5T3FYXqYsHeg03IQIqWdE9rsT208haSGtAWNFpUyvP/KO8REva9Vlsgm
         swlkiUMNWnnuF2QWwSWxKxIG3jqgu2KP3cin4picXqjSo4vq6MwI+c1muol8ec+meDaG
         kbUV5I2str0JKeiqXzxkOgH0a4E7wnUwK9qOQbGjQCSRBsmC2JGAsas6RYoHjnENiuIO
         oUihMgKtcUf/wGehWucb/O0vxkylV5gMvwSi4F7vxL6p/DwHU9B+e/4pe9kNU9fOzKar
         5wWIStOLGidmxeTQz4DYEuPcchYOB4kJ6ivoBVpznp3UcojNAGlO/oH2t/hgX6WwgRGT
         Ji1g==
X-Gm-Message-State: AOUpUlEJ9Qpo52wdzsl8TPuOtkuvngnKGsEfibGolrxWE40NHYkSF5bz
        jitfbapxeQd+/SBezKJcq7TBpgAz
X-Google-Smtp-Source: AA+uWPzHZvZQXxXir4IaxW/RLJ3saLk6wLVXLG7+klMraCI26R9zMWbszjxK1dmBaazOqFwvavoVEQ==
X-Received: by 2002:aca:ec51:: with SMTP id k78-v6mr3372418oih.236.1533743967415;
        Wed, 08 Aug 2018 08:59:27 -0700 (PDT)
Received: from [192.168.1.114] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id d191-v6sm8463874oig.16.2018.08.08.08.59.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:59:26 -0700 (PDT)
Subject: Re: [PATCH] Staging:rtl8712: Style - Removed inline block comment to
 fix "Statements should start on a tapstop"
To:     Greg KH <gregkh@linuxfoundation.org>,
        Frank Werner-Krippendorf <mail@kripp.ch>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <1533498066-31466-1-git-send-email-mail@kripp.ch>
 <20180808092257.GA4097@kroah.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <9b6d5aa1-dc6b-8d0a-78a1-b46d888db54f@lwfinger.net>
Date:   Wed, 8 Aug 2018 10:59:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180808092257.GA4097@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2018 04:22 AM, Greg KH wrote:
> On Sun, Aug 05, 2018 at 09:41:06PM +0200, Frank Werner-Krippendorf wrote:
>> Removed 5 inline comments "/*volatile*/" rtl87x_event.h, to fix
>> a coding style issue "Statements should start on a tabstop"
>> detected by checkpatch.pl script.
>>
>> Signed-off-by: Frank Werner-Krippendorf <mail@kripp.ch>
>> ---
>>   drivers/staging/rtl8712/rtl871x_event.h | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8712/rtl871x_event.h b/drivers/staging/rtl8712/rtl871x_event.h
>> index 5171379..2e59e8e 100644
>> --- a/drivers/staging/rtl8712/rtl871x_event.h
>> +++ b/drivers/staging/rtl8712/rtl871x_event.h
>> @@ -90,13 +90,13 @@ struct event_node {
>>   	unsigned char *node;
>>   	unsigned char evt_code;
>>   	unsigned short evt_sz;
>> -	/*volatile*/ int *caller_ff_tail;
>> +	int *caller_ff_tail;
>>   	int	caller_ff_sz;
>>   };
>>   
>>   struct c2hevent_queue {
>> -	/*volatile*/ int	head;
>> -	/*volatile*/ int	tail;
> 
> Those "volatile" seem to imply that something is needed for these
> variables.  Please check to ensure that these are ok to remove in that
> there is the proper locking for these types of things.

Those in-line comments are there as a warning that these variables are special. 
Just because a tool such as checkpatch says to remove them does not mean that 
you should; however, if you want to get rid of the warnings, change the space(s) 
after the "*/" into a tab. That silences the checkpatch warning without removing 
the implicit warning that these variables are special.

NACK.

Keep in mind that when this driver was submitted, it ran checkpatch cleanly. The 
fact that there are now warnings is due to changes in the tool. Following those 
will be a never-ending task.

Larry

