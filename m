Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28A9C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 23:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03742084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 23:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlqK3ESa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A03742084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbeJEF5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 01:57:06 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46704 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbeJEF5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 01:57:06 -0400
Received: by mail-lf1-f65.google.com with SMTP id q2-v6so8006481lfc.13;
        Thu, 04 Oct 2018 16:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MQh6fKYeC0J5RKgxJWIng2bysTjvJ8HmfsKhhtJ34W4=;
        b=YlqK3ESas191vH9mBC7ClWx0ZYwIPgmFWVm2lDkdppLfOuk5btRw4EMU6A5uSydXY0
         JbVgSdrQoC42EgfZDPwCXpFWURkr7jEOLdL7z3V+j/lONefYolS03LVEaNSA7rhF+PqK
         Ipvtj9+T4/K1a6Ii4RRm58YjSFo3C2Uz5+xHwN4UPncpokapDk2wLDP3krYin7nW/zfJ
         LNLzytx2CvvbOFafHJvDwowCU+nMxJYdFGTDf+fqc3gJ2/aNRTFZA2T+h/e3zIJ6O2TS
         RbiI2+2hGT5ARltWTeQ3Htk2qxo7f4QPtkk8AbieKRa70Ok4U0ZN0rPqTgIbRFxMfOgM
         sQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MQh6fKYeC0J5RKgxJWIng2bysTjvJ8HmfsKhhtJ34W4=;
        b=Hx4SGVXwMcZyNFXIOYdOuIL7RB3LU7N0PSHQmpekuFipbK1oEd6Osvt9KzF12DHJm1
         ieErEftAWh8Jf4t17cC1LVzdDuH+jFHlygxAHIKngHz6FYPPj3RRGTPNCWi8BqyVHXou
         IwCdQZPehcwJzpBCcmBkXEIqUwEosDbSFEUb5NI6mGZqKTEyyVSywqYUOPPGlowf9G/E
         wc0EpLBOxeBSE4vRBywVM6mb9tfb1yQpydIBz2i4lg+pXf3ZdQO2Wiw9JJH4V73Prs3W
         72lGUDUjBgTaKnOzX5gKvZAvoXH7g6eOCuC05xlWJp+e6egT5VSYww04eR+xBOtmufxM
         +/rA==
X-Gm-Message-State: ABuFfohgC2Wzv3vSj6zSoTiGxkEUj6MKptf6JDaewKkVhJhqllhomEsL
        4MJh3Nc8Q5+8Xs/PDIu69Llmx7QH
X-Google-Smtp-Source: ACcGV61URIdO+sul/QEzzr5tbz/BJr1MjRKjRxr8PDp3aEf6ZVzEO6xaWuo2YCwdjTjNf/ErZHGQEA==
X-Received: by 2002:a19:a3d1:: with SMTP id m200-v6mr4726546lfe.38.1538694083782;
        Thu, 04 Oct 2018 16:01:23 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id g68-v6sm1372492lje.44.2018.10.04.16.01.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 16:01:22 -0700 (PDT)
Subject: Re: [PATCH] Input: mousedev - add a schedule point in
 mousedev_write()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        linux-input@vger.kernel.org
References: <20181004154749.111595-1-edumazet@google.com>
 <20181004185949.GA233675@dtor-ws> <20181004193407.GK2674@linux.ibm.com>
 <20181004225455.GC233675@dtor-ws>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <2664c117-76c0-a60b-d76a-350ae7b6351a@gmail.com>
Date:   Thu, 4 Oct 2018 16:01:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181004225455.GC233675@dtor-ws>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/04/2018 03:54 PM, Dmitry Torokhov wrote:

> OK, I see. I'll apply the patch then.

Thanks !

> 
> I think evdev.c needs similar treatment as it will keep looping while
> there is data...

Yeah, presumably other drivers need care as well :/

