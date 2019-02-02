Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0E0C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA51D20449
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfBBRrB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 12:47:01 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43832 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfBBRrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 12:47:00 -0500
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gpzNa-0005Oh-Vy
        for linux-kernel@vger.kernel.org; Sat, 02 Feb 2019 17:46:59 +0000
Received: by mail-pf1-f198.google.com with SMTP id o7so8514869pfi.23
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 09:46:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=n2hrbvigZxzMq8UD9489e8IiUlWO+1g62mvzkPk8Cj8=;
        b=ANI1mhwDJYZ42rKZfYS1ZWevjyY6xCvrkllnA923sOaGE75CxyPV7ZqMV2u2nzqp+i
         TBAeLXwhshFex7RozBfjkprnuStCEEuunWl7C2RE0oPDBRIO1PjH6SaQFBfkSXV5YIjZ
         t5dH/ckGoZXSHAdknGPBZUg/v1IjPjloWUJ3jDs+LeI1tGjaWG0jSa6+QjhkEfqzQ8oN
         1Wvdz9Us6Il/ScVZErH4vQGCYUD3r6bZ+ptCP1aQewU/umQ0ws4F4EjpuLETpPTHRtU/
         LwkLBLZQ6z0DSJ7d1oJ/azrL5Liosd7h2SqrWS+w07vih2BfpQiPbuv9MP6T3Xsjw2OC
         emZA==
X-Gm-Message-State: AHQUAua4AmDAgva304Ce46WAoObe7SWSSMReVzgsySd3S6PjsXFt/yTk
        Kx/0yS0jbI3kvZ1M0ybOmWH+cjvq1pqxvluHmGi2gA5c2WlnMX0lPEYtcciQ3xQqzJVYFahSX/D
        AH2fWkZ5zBof55dMPh3Mh0D/B5W7NRWReQVQOfyu5ag==
X-Received: by 2002:a65:6242:: with SMTP id q2mr6911678pgv.245.1549129617740;
        Sat, 02 Feb 2019 09:46:57 -0800 (PST)
X-Google-Smtp-Source: AHgI3IZjc5O6nnaJ8s26aG+vOXqziqbwxBjy3hZEQOzeCMe5b+ZOikQASG40XwvbySgEYlMMRehS/w==
X-Received: by 2002:a65:6242:: with SMTP id q2mr6911653pgv.245.1549129617422;
        Sat, 02 Feb 2019 09:46:57 -0800 (PST)
Received: from [192.168.1.215] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id h15sm16013649pgl.43.2019.02.02.09.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 09:46:56 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] PCI / ACPI: Don't clear pme_poll on device that has
 unreliable ACPI wake
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <C7E9B3C9-7E20-4CEB-8B56-D9A8D2E76DD0@canonical.com>
Date:   Sun, 3 Feb 2019 01:46:50 +0800
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, jeffrey.t.kirsher@intel.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <CFAC1243-982E-4BAC-BAF6-41568C1C1A9E@canonical.com>
References: <20190122064544.27426-1-kai.heng.feng@canonical.com>
 <20190122235134.GE14636@google.com>
 <91E74111-5BB6-4604-A1D7-B537AB42C317@canonical.com>
 <20190124151524.GF14636@google.com>
 <FFC6EC3F-3608-41FC-8B14-815D1747C4B6@canonical.com>
 <20190124200508.GH14636@google.com>
 <C7E9B3C9-7E20-4CEB-8B56-D9A8D2E76DD0@canonical.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

> On Jan 28, 2019, at 3:51 PM, Kai Heng Feng <kai.heng.feng@canonical.com> wrote:
[snipped]

>> If I understand correctly, the bugzilla lspci
>> (https://bugzilla.kernel.org/attachment.cgi?id=280691) was collected
>> at point 8, and it shows PME_Status=1 when it should be 0.
>> 
>> If we write a 1 to PME_Status to clear it, and it remains set, that's
>> obviously a hardware defect, and Intel should document that in an
>> erratum, and a quirk would be the appropriate way to work around it.
>> But I doubt that's what's happening.
> 
> I’ll ask them if they can provide an erratum.

Got confirmed with e1000e folks, I219 (the device in question) doesn’t really support runtime D3.
I also checked the behavior of the device under Windows, and it stays at D0 all the time even when it’s not in use.

So I sent a patch [1] to disable it.

[1] https://lkml.org/lkml/2019/2/2/200

Kai-Heng


