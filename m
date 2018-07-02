Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D925AC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C12254F8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efvJwpOE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C12254F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753845AbeGBLB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:01:57 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34774 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752862AbeGBLBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:01:55 -0400
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so3141790ois.1;
        Mon, 02 Jul 2018 04:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=buAaaDwWwD7qaxqpvFyjA3ZbJ23ck2dBEUihcY9rcVg=;
        b=efvJwpOExC7qEY+/YqR0UvgHqM+fuP8miaXzc1TGpiLumgJIUPkfcmkl4QLviNv/t0
         B4n+/Lv2Nw0rjGjkltNzOt0yR9jTCsxUcL81iIF9eNvnJs+bCo+GpQN0P07VkqgD4P9Q
         eX9USfntAKZpBV4jfRc7zVKVg1e/rCyKWW94JIR41UK4bSW+Yrwsr1wUcbSeR6hxsX3y
         I+nIkTOfMqTFyyYejR5QQJbklXAenjKE5KVDwL3sOHFEtRKtfrKZrJJ7NMo4tQdXLkOY
         rtiuen/u7/ppqLVmIqrePyuI8b5EKBsfAASSGDmWz2K8p972DaobgQn7dd7xLQO1Cbps
         MALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=buAaaDwWwD7qaxqpvFyjA3ZbJ23ck2dBEUihcY9rcVg=;
        b=sCb1KBPzXK1KWk1tgkKYZ1iiebj3h5HDoiidzBgdXbuTfRP/RRv0fZOLSTzS7XuqwK
         52KAsI3CWGi0xDVevhF2WQfcEUqe2WW9LDlpzzFqdMVc1QNtKU+sEPNyRMFB+Q72X5Dr
         Vu31+8OVvBUfJfyYCp8vDPtcaUXmxY6jx6JMdL9hSn0rQlpvgBDtEu+A/og8w1yvXGOX
         8vROCc6H/T/tcM2QVsildfFXvc6mmhfpP16YNLqAPhH9/B4VrVcLz9So9KtKhtkjpKPv
         jnr5GmU/y7oVkZB5XclBCr8BkeMRipG8cK20/HOPU0he/KcLXjSArT2FXztptKYvy85f
         30ng==
X-Gm-Message-State: APt69E2rB0arThss+mGl4gy0+yEbc7IWHVdePvCG6r+ftflS83u6vxaQ
        0Q6elPUgyuGUMwmUqFVQ51s4OyhmqfPxmI3+JyQ=
X-Google-Smtp-Source: AAOMgpfXhqc9lSTDGaPwOwn0Wk+hIQgUtkNxP6rgUZks4KHVgT9GaUQU5aX7v3WRUWcq1tQWn4LaNdsQJzcCaUedpoE=
X-Received: by 2002:aca:ad4f:: with SMTP id w76-v6mr8084810oie.233.1530529315017;
 Mon, 02 Jul 2018 04:01:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1427:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 04:01:54 -0700 (PDT)
In-Reply-To: <3895a0d8-9cca-2512-a06e-0ee2ac7db773@arm.com>
References: <1530289077-2444-1-git-send-email-sudeep.holla@arm.com>
 <CAJZ5v0gnspK3soa5j8iqU9QDM78MMBbz8YC9s7TOJ5Qwh7=mZg@mail.gmail.com> <3895a0d8-9cca-2512-a06e-0ee2ac7db773@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 2 Jul 2018 13:01:54 +0200
X-Google-Sender-Auth: HmtaY56gRdDh_-5tADUNxhrDc64
Message-ID: <CAJZ5v0gh0-psU7bbLf5zDGW5adQNALSdWdedbCgDoh1F-peh0g@mail.gmail.com>
Subject: Re: [PATCH] ACPI/PPTT: use ACPI ID whenever ACPI_PPTT_ACPI_PROCESSOR_ID_VALID
 is set
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        shunyong.yang@hxt-semitech.com, yu.zheng@hxt-semitech.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 11:57 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 02/07/18 10:06, Rafael J. Wysocki wrote:
>> On Fri, Jun 29, 2018 at 6:17 PM, Sudeep Holla <sudeep.holla@arm.com> wro=
te:
>>> Currently we use the ACPI processor ID only for the leaf/processor node=
s
>>> as the specification states it must match the value of ACPI processor I=
D
>>> field in the processor=E2=80=99s entry in the MADT.
>>>
>>> However, if a PPTT structure represents processors group, it match a
>>> processor container UID in the namespace and ACPI_PPTT_ACPI_PROCESSOR_I=
D_VALID
>>> flag describe whether the ACPI processor ID is valid.
>>>
>>> Lets use UID whenever ACPI_PPTT_ACPI_PROCESSOR_ID_VALID is set to be
>>> consistent instead of using table offset as it's currently done for non
>>> leaf nodes.
>>>
>>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>> ---
>>>  drivers/acpi/pptt.c | 10 ++++++++--
>>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> Hi,
>>>
>>> There's ongoing discussion on assigning ID based in OS using simple
>>> counters. It can never be consistent with firmware's view. So if the
>>> firmware provides valid UID for non-processors node, we must use it.
>>
>> OK
>>
>> Do you regard this as a fix for the recently merged PPTT material?  If
>> so, I should apply it as a fix for 4.18.
>>
>
> Yes, it should be considered as fix IMO.

So any chance to provide a Fixes: tag?
