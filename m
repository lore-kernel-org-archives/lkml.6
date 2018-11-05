Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD50C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E8220819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P969dGy3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E8220819
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbeKEWUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:20:21 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33542 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbeKEWUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:20:21 -0500
Received: by mail-qk1-f193.google.com with SMTP id o89so14461790qko.0;
        Mon, 05 Nov 2018 05:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JaASoSmxpXVl42VaA4ASGf1QzfHeqbobutrpAHeTcYM=;
        b=P969dGy3fEFAJYfX19jjH9qBE72QRLjsJWHPi/9dkhlWgRX/HKtwFxBN40QdSyGI+b
         pQ1/EiAUtZMkBZtLkTE8zwxSdphH2qJzeIc6YliIevepvTiY3dctDiG4ynChfZGl3dDG
         EvRYgIVRgRuMhfFTjHE0GbhVbCt0zAcLBDPEXpMadiTmX1aU8jRYYG29MVeDGhAq7bd/
         irqB/VBD/t8QJq5VkOqP/2A2LIDKvMsNmun1c/S/mdely1wQJQOtX/5X+Fg6Wls4JOAF
         sbDIPANYkTgtuKKsy2noU16D5TN9QeNPPDccaZignIkoaen9U3ZJzM0mLoPaHHsM5met
         95Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JaASoSmxpXVl42VaA4ASGf1QzfHeqbobutrpAHeTcYM=;
        b=ezprPd88Xrx4621qcyCsxtRLjyRWQ0Nu/qxb9nvExY68lnRBBLBwwfUHabuRI/rjqW
         FH26C3OYWR1PKtf6qflzAVfj8ayg6r8BHcxcsat5vUeHZiqz7kKjymihVXKZtGonMJhh
         j0C9YFYxl2MjeqaoBOvsZEIeEElMFyoV7oAB5+8bVbS1emNYeqz7MIG7jjF4Wh94O6st
         5ybVmMpGHUz22eZOgpJSA1QGHyK3bXYkE/yVHXy+jPoqj77XCeKtX2RZ2YtKuhcwsqyB
         SIMjkm2eyMP+0uadTbraKZ1UvI5CPzIMZX2TeGV1Es5vidDEzxncbc94xlWAbIcHU0J0
         5s1w==
X-Gm-Message-State: AGRZ1gJyCikjoYwKoJctdpjgbRpWGFFV1QjB82LQJGuUx9mQ6HOLC8rl
        8fDoT5ZaQMCObA0YwAiDlYqgsdMEjQ8VLFML4lsqeLrk
X-Google-Smtp-Source: AJdET5ehaH1sup+t60WW3zQCxnCJHtGdXZtn6shspjVd6tcElDDRwqQUToL96iai0FduCnEmhFL+VUbKu58zYZsd7oQ=
X-Received: by 2002:ac8:684:: with SMTP id f4-v6mr10799155qth.194.1541422841975;
 Mon, 05 Nov 2018 05:00:41 -0800 (PST)
MIME-Version: 1.0
References: <1541414431-84128-1-git-send-email-peng.hao2@zte.com.cn> <1541414431-84128-6-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1541414431-84128-6-git-send-email-peng.hao2@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Nov 2018 15:00:30 +0200
Message-ID: <CAHp75VeukhU7s_uyVoEPDaVYFe5r6dGq1iEzXU5Kumiw7f-4gQ@mail.gmail.com>
Subject: Re: [PATCH V7 6/9] misc/pvpanic : break dependency on ACPI
To:     peng.hao2@zte.com.cn
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        hutao@cn.fujitsu.com,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 4:31 AM Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> The pvpanic driver is available for architectures that do not
> support ACPI.So break the dependency.
>

Logically better to split this to two patches:
- preparation w/o any functional change, i.e. grouping ACPI related
stuff (which will go under #ifdef later on)
- do the OF extension

After addressing the split,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
