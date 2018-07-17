Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F8FECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134F22064D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sz6EMy7V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134F22064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbeGQUfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:35:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729838AbeGQUfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:35:44 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF99F2064D;
        Tue, 17 Jul 2018 20:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531857692;
        bh=K5SmWreWk9sW2IhI1KpB5kOnl8pAIPXpFkUcT9kcpw8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=sz6EMy7VHnaCtut8nnkd6gCTM2zOFIpFAfdPADncgVwNSAZPTS69scSdPleFlHE7j
         Vnzw8FYqu/9chVdHFCyPs714QyrCbQH+ullpApRCKrkjd2e841zx+tHcu+nrq/tQ5z
         f4Y3yn6lNwwT5OxuvYlxZFOj2vuDdW9xkFfboIgM=
Received: by mail-wr1-f50.google.com with SMTP id a3-v6so2403608wrt.2;
        Tue, 17 Jul 2018 13:01:31 -0700 (PDT)
X-Gm-Message-State: AOUpUlHl3TcdTKGHQYwBNEGFUKOdUUN937PVZzzgoZZ8PRAdTJAXBgup
        4LD77ht1yu0IQT07+31sRLyFVbL0s63Pj/Dtj5o=
X-Google-Smtp-Source: AAOMgpfPoyBtPPeerU4P1UiSpw0I9G2ixkjxPGGEwiBfCYdbnr9aYOOMOBowD/8w6X2lR3hM+g96njewUe2pRYVF100=
X-Received: by 2002:a5d:4452:: with SMTP id x18-v6mr2457727wrr.227.1531857690412;
 Tue, 17 Jul 2018 13:01:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 13:01:29
 -0700 (PDT)
In-Reply-To: <CANAwSgSUv9aY6bhMxdnj9yGS8Ds7Bevy09+k=74CwVqiOX2+gA@mail.gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
 <1531822342-4293-5-git-send-email-linux.amoon@gmail.com> <CAJKOXPc256dCWWWaoJBOB9NUc=CUYtqgfeKh=LBOoFAfh_T8Ng@mail.gmail.com>
 <CANAwSgSUv9aY6bhMxdnj9yGS8Ds7Bevy09+k=74CwVqiOX2+gA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 17 Jul 2018 22:01:29 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfSs7rRN9z7oOOX-0O3cC=+jT=WVGvaQ3j+yL=MD_ifUA@mail.gmail.com>
Message-ID: <CAJKOXPfSs7rRN9z7oOOX-0O3cC=+jT=WVGvaQ3j+yL=MD_ifUA@mail.gmail.com>
Subject: Re: [PATCH 5/5] ARM: dts: exynos: add tmu aliases nodes
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 July 2018 at 21:56, Anand Moon <linux.amoon@gmail.com> wrote:
> Hi
>
> On 17 July 2018 at 17:59, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On 17 July 2018 at 12:12, Anand Moon <linux.amoon@gmail.com> wrote:
>>> add tmuctrl aliases node for exynos542x
>>
>> Please use full sentence, starting with capital letter and ending with
>> a dot. Also please explain why you need tmuctrl aliases.
>>
>
> As per the [0] Documentation/devicetree/bindings/thermal/exynos-thermal.txt
>
> For multi-instance tmu each instance should have an alias correctly
> numbered in "aliases" node.

Ah, right. However except reading value of alias and storing it, the
driver does not use it later. Maybe this should be just removed.

Best regards,
Krzysztof
