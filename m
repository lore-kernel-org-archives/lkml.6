Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0BFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77FB217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbeLQHZo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 02:25:44 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53134 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbeLQHZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 02:25:44 -0500
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gYnHZ-0007qp-AH
        for linux-kernel@vger.kernel.org; Mon, 17 Dec 2018 07:25:41 +0000
Received: by mail-pl1-f199.google.com with SMTP id 12so8482357plb.18
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 23:25:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ha3gGYYBMVrIoysS22ljTOnYxHCUFyUGxwr9PdR60Jc=;
        b=gKNC0VY09NQl/Z3Qa4r785H/k2ha+ZNsM60FQNpl5RDpMpIMlVZO8sdUmDqMFD3KBK
         8VNu2M44W2Gd0HMsrU1d/DGTGaNJhXivqFn/CGzibFCZeN+t4fju/Bzv2SN0r6PgwFO5
         rzk7Og7deROVMHJo+++fkipBkCBRx0AcTouGb2oIxfQ2YXmJ+wfBl3lJpqXOseE5k7LB
         DwYkKhS69yDzZFbrqkOp+ooGpVAsnGd72XipvGnhb4mbYdTUGb0Qb+3mUha5aVdfzEpZ
         85suFqh1Vm+B1vUS/7K42aTA+NzFjUdMRp9Y7Z8K+FVzYvMrfRdybMJ7b210jBlANfVE
         upmw==
X-Gm-Message-State: AA+aEWaZweQA8FPGV2vL7NMDu1D6Gol562MKk4oWWfIUxqsj31BfmsBY
        4otAp+VKZ5GsfqUyoFcYb2Q2pGs3h66+sbQkgM1WuCG4GIgvUtJ9aSRjYJXWnx+tWC0MEQTutWQ
        gcXS9Bpy8Q2CLjKql5f0mB6i7+d2mw+OiqMMxciXS/Q==
X-Received: by 2002:a17:902:765:: with SMTP id 92mr11781210pli.242.1545031540019;
        Sun, 16 Dec 2018 23:25:40 -0800 (PST)
X-Google-Smtp-Source: AFSGD/XO7cXQVKlFtiVBZG57ce1pXAhSgIY2ajXCZ9REWenYWog/iSyqaJmw053Wri0IBjaDBHuQhA==
X-Received: by 2002:a17:902:765:: with SMTP id 92mr11781195pli.242.1545031539636;
        Sun, 16 Dec 2018 23:25:39 -0800 (PST)
Received: from 2001-b011-380f-3f3d-8925-558c-514a-091c.dynamic-ip6.hinet.net (2001-b011-380f-3f3d-8925-558c-514a-091c.dynamic-ip6.hinet.net. [2001:b011:380f:3f3d:8925:558c:514a:91c])
        by smtp.gmail.com with ESMTPSA id x26sm16514763pfn.50.2018.12.16.23.25.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 23:25:38 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: Elantech SMBus support regression
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAO-hwJ+fshPj7xbJoBvK8uGrhfKCdFSmzicmmOyMJS0cdzAapQ@mail.gmail.com>
Date:   Mon, 17 Dec 2018 15:25:36 +0800
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <A67BA4A8-7A32-4B80-AF90-B9D99E7D5582@canonical.com>
References: <6E2F161C-046B-4D5F-B831-B1308A554C40@canonical.com>
 <CAO-hwJ+fshPj7xbJoBvK8uGrhfKCdFSmzicmmOyMJS0cdzAapQ@mail.gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On Dec 12, 2018, at 22:25, Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
> 
> Hi,
> 
> sorry for the late reply. I was always meaning to fix this the proper
> way but couldn't dedicate a full day of work to go to the bottom of
> elan_i2c.
> 
> Meanwhile, I am thinking at simply having a blacklist of devices that
> we know are not working well (P52, L480, L580 and P72).
> 
> Could you get the value of /sys/bus/serio/devices/serio1/firmware_id
> from all of these laptops?
> I know the P52 is LEN2131, but I don't seem to find the other PNPIds.

These are feedbacks from the users:

L480:
cat /sys/bus/serio/devices/serio1/firmware_id
PNP: LEN2036 PNP0f13

P52:
"cat /sys/bus/serio/devices/serio1/firmware_id":
PNP: LEN2132 PNP0f13

So looks like it’s different to LEN2131.

Kai-Heng

> 
> Cheers,
> Benjamin
> 
> On Thu, Nov 22, 2018 at 5:22 AM Kai Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> 
>> Hi Benjamin,
>> 
>> It appears the Elantech SMBus support breaks some users’ touchpad.
>> 
>> Please have a look at [1] [2], thanks!
>> 
>> [1] https://bugs.launchpad.net/bugs/1803600
>> [2] https://bugs.archlinux.org/task/59714
>> 
>> Kai-Heng

