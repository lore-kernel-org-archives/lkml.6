Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A59C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584CF2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="X67Zk84y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584CF2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbeIGTHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 15:07:14 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:53281 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729773AbeIGTHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 15:07:14 -0400
Received: by mail-it0-f42.google.com with SMTP id p79-v6so20811797itp.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 07:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2Aw5SnLG6dUbnfTXCayQbTZvWAcTKmXGXLJs8Y70a8s=;
        b=X67Zk84yYP6lZc/NZ5HXyfDDQyJgrP+8CxJDOHmv3mixo/QpTTj5bH/zsTN4rBRAwj
         X246R+KDpigJaitH9124ZCV+kC8jsJ4NVML+t30iSjaD0ta9c6JkHdKjxQgjdlgsnVKZ
         Yhd/DpGf6+ewWaluzObc4BMcpyCH5Tai01p1dPfUHsZxQ4Ep/m9e6H7xyHTV3APy4kij
         zuP4co95s7JRQOTUDev26P11vKRe0tXEKdzX2gZY+kBvmPmF7G5Gr0R1jKZgDtoeu6E4
         CNoclB4qfbCx80ZvN2ksMLxOSNoF3swFVSCEj8tAYNSloblOP2atWz1kdbp9umsRDBFp
         Yu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2Aw5SnLG6dUbnfTXCayQbTZvWAcTKmXGXLJs8Y70a8s=;
        b=KjSZJDshuRzbMhykMRieBAsfwIMjtqeMHxHkioV8m7TAU8/ADyY9pFCPWTUuci70Dz
         RcraHaptrYLIz95s+pcDIscvoaJffnBK4U6QL9gjSMsGincYNLg37TCfQnFJkQ+UU18n
         XqdVz7hza6xQRQBHSeYI4jDyU9q/0dFx0by9gOwXP5b4/SrqI/XaKgC4icNujU+6Ic+2
         UP2R7ClnfhsCItObuQa3lthVVpaYsmMR963VTs1BiA566G4ZPstTjXyt2k3Y55+uzUJl
         hJA19t+e7q5hKOS/Rp2gBgDE8UdELykPKUB+YSpVaqHK0+Wx5bAplSHgPVKTHd8Ms9qj
         riIg==
X-Gm-Message-State: APzg51CxEYNwWdP5xh6tqHywSB5tUeVi3vVzCz4IZp47M1WsyHfCrclA
        bfznNkEhGzY65bf7VwieJZPacQ==
X-Google-Smtp-Source: ANB0VdaU7wilXr/g3w42fWgyLN2vrWV2YwODJjFZEoeta2+9jtwJ3fm+4Qe6pIf7HPOGj/w5EYbwZw==
X-Received: by 2002:a24:1688:: with SMTP id a130-v6mr7920384ita.74.1536330362954;
        Fri, 07 Sep 2018 07:26:02 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.22.static.utbb.net. [107.191.0.22])
        by smtp.gmail.com with ESMTPSA id v13-v6sm3817234ita.38.2018.09.07.07.26.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 07:26:01 -0700 (PDT)
Subject: Re: [PATCH v3] ata: Disable AHCI ALPM feature for Ampere Computing
 eMAG SATA
To:     Suman Tripathi <stripathi@amperecomputing.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joe@perches.com" <joe@perches.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     Open Source Submission <patches@amperecomputing.com>,
        Rameshwar Sahu <Rameshwar.Sahu@amperecomputing.com>
References: <1536257111-27948-1-git-send-email-stripathi@amperecomputing.com>
 <d3682fff-473f-021a-c805-466030b7644e@redhat.com>
 <MWHPR01MB2336EE4B6E4923C9ED851F20B3010@MWHPR01MB2336.prod.exchangelabs.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cd3e5c60-1619-9842-6198-e36fdbaa4b4b@kernel.dk>
Date:   Fri, 7 Sep 2018 08:25:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <MWHPR01MB2336EE4B6E4923C9ED851F20B3010@MWHPR01MB2336.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/18 2:08 PM, Suman Tripathi wrote:
>> Sorry, but the patch is still coming through mangled. Did you use git
>> send-email ?
>
> [Suman Tripathi] yes. I rechecked before sending twice. Sorry for the
> inconvenience. Will figure the issue out

I can apply it manually while you work out the kinks in your email
setup. It might even be your company MTA mangling it, I've seen all
sorts of crazy like that.

-- 
Jens Axboe

