Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2986AECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FDA20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bui/B5iS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FDA20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388438AbeGWTAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 15:00:09 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46560 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387981AbeGWTAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 15:00:09 -0400
Received: by mail-qt0-f196.google.com with SMTP id d4-v6so1502968qtn.13;
        Mon, 23 Jul 2018 10:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ru4ZVNbehFnVWZcb96nwDoRNnjIb3lUkwozzGs2drhc=;
        b=bui/B5iSQtWxLJs7uJ91GYU0Nim0mVR0ppRmTaaQ+efxa1ObzwyQ6hIfa4onCkeAV4
         ggbJIyk+5vZXBMt4tQoMp7r9593imcrUMlwUXYpOdnKpDsm5oJLvVaJMdop0nNhyypUQ
         4Dq9wCTWOzoZB1KUo9eXQdtOybyie6jZc2eh7NV/H/qU6AqgNXHJprMCpfvpCmuW8s/5
         l0t1HmLZC+QbR+Cdb1oM/3fjdSdhKLNhWvUKJemUIWV90FqvdCGqVV4daAyfNIpn7+Ya
         dex9k/bYBV/11wPhOJLiO0eBcBv8eUJw0iu9etKDMTuzY898Za1xC52Cvpk1+9NMrCv2
         Cknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ru4ZVNbehFnVWZcb96nwDoRNnjIb3lUkwozzGs2drhc=;
        b=saALibXb3uY4ZrpZ6FQg62Li76F/QsaLNZKGVdTOhh/RYJN2LdpRLdTiA9A2w/fsS7
         jprAZe91qKejXcbNG6Ecnf2GLvhasDcfhTjpc1XPEMsykIwOZ2nWQCU4DeAZ8dlFA+dm
         UOwvnW2Wq+W7NeslXK3HGMOqAn4nwBe2OIGVC43sx+oQrw4ij4KqsCG1r9rB+7f1cJDf
         t/h4314Mskipy7l2eMpqKAKlPyaZeDFzJm/1FVXmpUhrg+LJO79XnZFOs7ZH7wmCgxPZ
         Y6Dr2RTuzRHkmYfqn1xfNYQ3EO+Am4kEyQytUCHV7V/Ti1LciUR8dVqSuOOIQ/q4OP7Q
         DwTA==
X-Gm-Message-State: AOUpUlFplv8U6XMebyfyoQCtgCXT7CEtQgFmKyz36cJjcjY99SA5Zu8b
        Gfub9Exe8dVVENhcIaQyj9GglVm+6Hw=
X-Google-Smtp-Source: AAOMgpeKpA39RprF9F+qgvvf4RE3k2TIyLuxGKGLLPQCMnXGQeV76gGSxL99VgvK1q3q0ne0e9nh5Q==
X-Received: by 2002:ac8:6143:: with SMTP id d3-v6mr13079519qtm.298.1532368666781;
        Mon, 23 Jul 2018 10:57:46 -0700 (PDT)
Received: from [192.168.44.96] (65.sub-174-226-2.myvzw.com. [174.226.2.65])
        by smtp.gmail.com with ESMTPSA id l36-v6sm6664727qtk.12.2018.07.23.10.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 10:57:46 -0700 (PDT)
Subject: Re: [PATCH 1/2] Add sw2_sw4 voltage table to cpcap regulator.
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <d38d3fea-dc7d-09fe-651e-386b36befde1@gmail.com>
 <20180723170157.GD13981@sirena.org.uk>
From:   Peter Geis <pgwipeout@gmail.com>
Message-ID: <63de1504-5fc7-ee9c-9d91-69d0b2e3b944@gmail.com>
Date:   Mon, 23 Jul 2018 13:57:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180723170157.GD13981@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/2018 01:01 PM, Mark Brown wrote:
> On Fri, Jul 20, 2018 at 08:43:49PM -0400, Peter Geis wrote:
>> SW2 and SW4 use a shared table to provide voltage to the cpu core and
>> devices on Tegra hardware.
>> Added this table to the cpcap regulator driver as the first step to
>> supporting this device on Tegra.
> 
> This fails to apply with:
> 
> Applying: Add sw2_sw4 voltage table to cpcap regulator.
> .git/rebase-apply/patch:37: trailing whitespace.
>                                                 1437500, 1450000,
> error: corrupt patch at line 38
> Patch failed at 0001 Add sw2_sw4 voltage table to cpcap regulator.
> 
> Please check and resend.
> 
Apologies, I accidentally converted all of the tabs to spaces.
Re-sending both patches with tabulation intact.
