Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7A4C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 20:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBFA1208B0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 20:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCgwZFa1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBFA1208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752937AbeGDUgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 16:36:39 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38617 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752732AbeGDUgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 16:36:37 -0400
Received: by mail-wm0-f66.google.com with SMTP id 69-v6so7700625wmf.3;
        Wed, 04 Jul 2018 13:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Yg1NiDwx/9saCOgjhnxunuRNb+a+c/491n0V97lEGtM=;
        b=cCgwZFa10rhzO4uhpDPz/Caxv5+ygkxEn7DffGaZiY4gmbADBcHtp32JToqWre9kAj
         Wz7gi0AhW72tRih5r5py3uNdn6nmdvaSfRf3i6nNGhrZhVmmyw5Io2HnU9N2xbGSFGAe
         gmGCDQkSqSYsnT1AMQtLNW0/Nxsnelt+idlMr8jtra7JQY+T2UamcxI+4fyL5XJet4Sy
         q7RWpjb3Jql5ynuZ2JKNMp3q5Vj4oBOdC8MZ0LSJaXEyQO4FRcyxUhnZkdvpkXfHEsP4
         ZMydDejNBrKfytiEylJNBiCkvTMVMwjmjyCf/mUQHIw4oXMcMwdzHhsxisJ2xYW6frSP
         kxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yg1NiDwx/9saCOgjhnxunuRNb+a+c/491n0V97lEGtM=;
        b=YaU1YJEWLvcgDWCye0g0mRTIFsZd/Cv6FUjQj63HoDEjjW8AVyQoh+vvD08eFbPSGb
         QSXn84N0o51c6jV8GQNBWKdsYyj4Adf9Jc0iFUS4oYBTq6k5lDal8n/fQLsY0Z5iQJaV
         aX4XXDtk9pf8IDKEvuG8CNEeWq7ABa25gn3px6OcUxda1n1eD2nNwyjYmGeVBO/oklfJ
         b5kBSGTWgYk+rVJ34s31pzJ/sWsQrh+ozGyNw/9j5n4k17emyWACA31iHTG65sGJIXwE
         moFZYfTie3rtg8ojpIvBjPXfKkaM/yOJxyzfBBGbpmFKDv0SZINBzqCbKI2smsReeUcN
         Pg6A==
X-Gm-Message-State: APt69E2pz35bkXDfRdukWx+JL8o1nFLS18M0bZUpDXG8Ok2yrH++KBC5
        xJVgnWQL9lfpMbWtcyhhGhX43mhJ
X-Google-Smtp-Source: AAOMgpf67HPfGBVJa373XaGg3JPbiQnCx5q3CvcY6545vMyq2NwWjNcYPbi/VBbZhd4++HLN40Ty2Q==
X-Received: by 2002:adf:9084:: with SMTP id i4-v6mr2728471wri.146.1530736595932;
        Wed, 04 Jul 2018 13:36:35 -0700 (PDT)
Received: from [192.168.1.18] (chl46.neoplus.adsl.tpnet.pl. [83.31.9.46])
        by smtp.gmail.com with ESMTPSA id c130-v6sm302920wma.26.2018.07.04.13.36.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 13:36:35 -0700 (PDT)
Subject: Re: [PATCH v2] leds: ledtrig-morse: send out morse code
To:     Pavel Machek <pavel@ucw.cz>, Andreas Klinger <ak@it-klinger.de>
Cc:     ben.whitten@gmail.com, geert+renesas@glider.be, w@1wt.eu,
        pombredanne@nexb.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20180703155328.GA18299@arbeit> <20180704065305.GA23509@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <b10a8282-0297-8cd6-5d29-fb4adcf72366@gmail.com>
Date:   Wed, 4 Jul 2018 22:36:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180704065305.GA23509@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 07/04/2018 08:53 AM, Pavel Machek wrote:
> On Tue 2018-07-03 17:53:28, Andreas Klinger wrote:
>> Send out a morse code by using LEDs.
>>
>> This is useful especially on embedded systems without displays to tell the
>> user about error conditions and status information.
>>
>> The trigger will be called "morse"
>>
>> The string to be send is written into the file morse_string and sent out
>> with a workqueue. Supported are letters and digits.
>>
>> With the file dot_unit the minimal time unit can be adjusted in
>> milliseconds.
>>
>> Also add documentation for the morse led trigger
>>
>> Thanks to Greg and Geert for suggesting improvements
>>
>> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> 
> As I stated before, I don't think morse encoder belongs in kernel.
> 
> LED pattern trigger should be merged, instead.

We've already agreed in [0] upon pattern sysfs file, and related
patch set [1] is just to be merged.

[0] https://lkml.org/lkml/2018/5/12/142
[1] https://patchwork.kernel.org/patch/10495595/

-- 
Best regards,
Jacek Anaszewski
