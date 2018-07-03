Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBB8C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44ED022427
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTmPVz6E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44ED022427
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932343AbeGCOV7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:21:59 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:35608 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753467AbeGCOV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:21:57 -0400
Received: by mail-yb0-f196.google.com with SMTP id x15-v6so790313ybm.2;
        Tue, 03 Jul 2018 07:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZZbFLtSFkfocKWFek6Rh8AEgrnU3XsGPOnkv9VkbtZw=;
        b=eTmPVz6EQWDYoKYif3NLqxPJ6U8DAFGrUg0u0Ag86cpCr5U/wQj6BrbeTUtMp9Te7H
         EYInGzveGDwetoKR0XXQu8vCAJNXrRVKOIfCdJeayYAuxGyBZUi4hlIT/OQrPZl7tXg4
         B4EaOepi/UqCamfDjQaVuRb8Tijcn9q4nHEzj5grZvzvU4/igyYlz5OlVby0PIuk7KKa
         oRZuX9N1P7WedruHp38+OMv2LH2P1oHA9pyd1BVQP55dUEbIO7XZ8fKcVJs7y6EsaPDT
         lx1UrYQV1ueSB1Y/8AUzXL9B4nkGoMcYumxL+Vzap7rr93B9X+iDiBJphURMOfoBJQyR
         AqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZZbFLtSFkfocKWFek6Rh8AEgrnU3XsGPOnkv9VkbtZw=;
        b=To+DHwM7ZBK2+NiTdSdwchjuK1nMANOTC/I8SkFvIU6nVBRIg49IY0oX99t9GL4d/x
         D71tgVm/yQrzfBqWAaCm6P2TjDsAswYJvVlH3h8td88hefMsdbXc0xuNJdYFxB2W86dc
         qdz0spcFcAGuU73zDv01wp/krUt5clxvQ1aC489vR8rqv7dHoOnEO1oxKDqjRUjENUGd
         2GYqbAU+/agpoEfsSMjuawpedBD1VQLy8VDd0kZlHrt5bxsGPC7wR/PZg+/yYcUxQEqQ
         AiuTHviYd3ui3i5Ea8qEz2cKYDAPfwoEI+kEIHgHYHEN8hugtYznXE/buAnqmW2yRVoC
         H9ZQ==
X-Gm-Message-State: APt69E3lvsHtcxEyEo7XzesS1S+1zivhJGs8ppW2obFteB21GyppfEEx
        E9p/0tNmaLaYaZEXYMDoixs=
X-Google-Smtp-Source: ADUXVKIa4zHphD/s2WL7Z6d+1uzK0jFEeTgGRHpwleq9om5HmoyjZ209tnJOJFRLtilEQIPpxXXnvw==
X-Received: by 2002:a25:a4c3:: with SMTP id g61-v6mr15640133ybi.302.1530627716272;
        Tue, 03 Jul 2018 07:21:56 -0700 (PDT)
Received: from sophia ([72.188.97.40])
        by smtp.gmail.com with ESMTPSA id q184-v6sm401183ywf.81.2018.07.03.07.21.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 07:21:55 -0700 (PDT)
Date:   Tue, 3 Jul 2018 10:21:53 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     gregkh@linuxfoundation.org, jic23@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        fabrice.gasnier@st.com, benjamin.gaignard@st.com,
        robh+dt@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com
Subject: Re: [v7,03/10] docs: Add Generic Counter interface documentation
Message-ID: <20180703142153.GC14958@sophia>
References: <7606bdc53c26c332b2bbff0f865380fb0e874b56.1529607879.git.vilhelm.gray@gmail.com>
 <c27faf65-9579-254b-725f-07b57c316285@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c27faf65-9579-254b-725f-07b57c316285@lechnology.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 02:42:06PM -0500, David Lechner wrote:
>On 06/21/2018 04:07 PM, William Breathitt Gray wrote:
>> +Userspace Interface
>> +===================
>> +
>> +Several sysfs attributes are generated by the Generic Counter interface,
>> +and reside under the /sys/bus/counter/devices/counterX directory, where
>> +counterX refers to the respective counter device. Please see
>> +Documentation/ABI/testing/sys-bus-counter-generic-sysfs for detailed
>> +information on each Generic Counter interface sysfs attribute.
>> +
>> +Through these sysfs attributes, programs and scripts may interact with
>> +the Generic Counter paradigm Counts, Signals, and Synapses of respective
>> +counter devices.
>
>I don't actually see any mention of the Synapses in the sysfs documentation.
>But configfs my be better suited to configuring Synapses anyway, e.g. one
>would symlink a Signal to a Counter to make the connection.

I expect in a future patch to add a synapses directory to the count
directories which will have symlinks to the respective associated
signals. I've postponed this development for now to keep the
introduction patchset simple, and also because the current users have
little use for this feature at the moment, but it is indeed planned for
the future.

William Breathitt Gray
