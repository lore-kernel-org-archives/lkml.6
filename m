Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72ED2C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB78E21523
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkTDAQKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB78E21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732029AbeITCEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:04:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34966 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeITCEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:04:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id o18-v6so8444198wmc.0;
        Wed, 19 Sep 2018 13:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:from:message-id;
        bh=TZWAFBHZx3Zrg09Ig9fRblbDNMmwymBwQFr4J9bYsxg=;
        b=TkTDAQKQNaxmyQBTapCr4DpljPeUeC32dSwkwmKfC+EYHIJnl8YMWdARYififyaCMc
         rTgs2/RUOJMfFlugEKcDPD+i2c6+ENbAE8FwDWsLZhe/HKVAC5PqCyvVxdAkrgcqeguQ
         2n/a1XyZ6qp9WKUuxaUOJghuafALc2uB5SibKmb8+50x2KbZMG9phlbJunBtYs0yapCF
         b8BH1fI0Hofj74ahWOuojQs4QCuWPmHd5Q3LEubh+JQsr1jwaUsYe8v/956NNWTwi5J6
         I4UFeO2Ay4pujJUdOXwEvABNi7cyNZa5y9ns8sn5/X2mmdhHIl/qdCvhdZtbg9HVIwIz
         0iEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:from:message-id;
        bh=TZWAFBHZx3Zrg09Ig9fRblbDNMmwymBwQFr4J9bYsxg=;
        b=oPKZtVebyG3f4Wd0AGmnFCJf3I7p44jtw0RZxbGVfNb0Ji74gStYmuy/fTbbelpxrh
         UDujKwHmq3awjYG3rfuheqdmf9TO4fzbugT664kgQnBwc9yvx0lVZ4enpjCZHRh0GynC
         LOrUwWuz1zZIZEB+5Ogl9NtaIbt8wvglyE2dGcNCrwa5pF3gYv7LR4qzMDd+EScWqv0A
         8c2LCvqI6I9MPROIy3xdm4F7CdONUGEoOwExFx1V6LS2J8ppS01mNItZDsolWmRkqf/D
         gB524gu7zh5v1AtaYmkFvv0y+PH+ARbM7UvbL41QFvr84stesblG7gSNTFGhWx3Wr1Lo
         9fEg==
X-Gm-Message-State: APzg51D18tLaHNurKFXOQ9cv/T4xnkaBEUisz/qJM50H8Ho5BNl1aQCY
        16LV0Zl54RcnOemMUAAFnA==
X-Google-Smtp-Source: ANB0Vdb+EwAPP0zcS7R9pQMH/hkmG5Jqc3blNlffxZ8+ZIeMWpOLZX7GStwrc1bAf6vvaB7Qw5jtNg==
X-Received: by 2002:a1c:3906:: with SMTP id g6-v6mr21157818wma.50.1537388696790;
        Wed, 19 Sep 2018 13:24:56 -0700 (PDT)
Received: from android-dhcp-8-1-0-d4-38-9c-a2-1f-05.home (host86-147-9-252.range86-147.btcentralplus.com. [86.147.9.252])
        by smtp.gmail.com with ESMTPSA id z69-v6sm9525864wmz.18.2018.09.19.13.24.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 13:24:56 -0700 (PDT)
Date:   Wed, 19 Sep 2018 21:24:53 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <D8FC68C0-2572-4A86-81D9-D0099D314A45@gmail.com>
References: <1534248753-2440-1-git-send-email-sricharan@codeaurora.org> <2ae96741-94c0-ba4c-fc19-05d33179683c@codeaurora.org> <d682580d-5070-0271-197f-29d988172937@codeaurora.org> <D8FC68C0-2572-4A86-81D9-D0099D314A45@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH V12 00/14] Krait clocks + Krait CPUfreq
To:     Sricharan R <sricharan@codeaurora.org>, mark.rutland@arm.com,
        robh@kernel.org, sudeep.holla@arm.com, linux@arm.linux.org.uk,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org,
        sboyd@codeaurora.org, linux@armlinux.org.uk,
        thierry.escande@linaro.org, linux-kernel@vger.kernel.org,
        david.brown@linaro.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, andy.gross@linaro.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, niklas.cassel@linaro.org
From:   Craig <ctatlor97@gmail.com>
Message-ID: <F5A89365-C613-4FE2-AD32-DC0AC6DF380B@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yup, this patch seems to have fixed the higher frequencies from the quick t=
est I did=2E

On 7 September 2018 15:28:53 BST, Craig Tatlor <ctatlor97@gmail=2Ecom> wro=
te:
>
>
>On 7 September 2018 10:57:34 BST, Sricharan R
><sricharan@codeaurora=2Eorg> wrote:
>>Hi Craig,
>>
>>
>>>> [v12]
>>>>   * Added my signed-off that was missing in some patches=2E
>>>>   * Added Bjorn's acked that i missed earlier=2E
>>>>
>>>=20
>>>   Can you give this a try on your 8974 device and check if the
>>>   pvs version reporting, scaling for higher frequencies are fine ?
>>>   Sorry, i could not get hold of a 8974 device=2E So in-case if you
>>still
>>>   have the issues with higher frequencies, can you give a quick
>debug
>>>   and report=2E That would be of great help=2E
>>>=20
>>   Ping on this =2E=2E
>
>Hi, didn't see your last message,
>
>Will have a try on mine in the weekend and report back=2E
>>
>>Regards,
>> Sricharan
>>
>>> Regards,
>>>  Sricharan
>>>=20
>>>=20
>>>> [v11]
>>>>   * Dropped patch 13 and 14 from v10 and
>>>>     merged the qcom-cpufreq-krait driver to the existing
>>qcom-cpufreq-kryo=2Ec
>>>>   * Rebased on top of clk-next
>>>>   * Fixed a bug while populating the pvs version for krait=2E
>>>>
>>>> [v10]
>>>>   * Addressed Stephen's comments to add clocks bindings properties
>>>>     to the newly introduced nodes=2E
>>>>   * Added a change to include opp-supported-hw to qcom-cpufreq=2Ec
>>>>   * Rebased on top of clk-next
>>>>   * Although there were minor changes to bindings and the driver
>>>>     retained the acked-by tags from Rob and Viresh respectively=2E  =
=20
>
>>>>
>>>> [v9]
>>>>   * Fixed a rebase issue in Makefile and added Tag from Robh=2E
>>>>
>>>> [v8]
>>>>   * Fixed a bug in path#14 pointed out by Viresh and also added
>>tags=2E
>>>>     No change in any other patch=2E
>>>>
>>>> [v7]
>>>>   * Fixed comments from Viresh for cleaning up the error handling
>>>>     in qcom-cpufreq=2Ec=2E Also changed the init function to lateinit
>>>>     call=2E This is required because nvmem which gets initialised
>with
>>>>     module_init needs to go first=2E
>>>>   * Fixed Rob's comments for bindings documentation
>>>>   * Fixed kbuild build issue in clk-lpc32xx=2Ec
>>>>   * Rebased on top of clk-next
>>>>
>>>> [v6]
>>>>   * Adrressed comments from Viresh for patch #14 in v5 [5]
>>>>   * Introduced a new binding operating-points-v2-krait-cpu
>>>>     as per discussion with Rob
>>>>   * Added Review tags
>>>>
>>>> [v5]
>>>>   * Addressed comments from Rob for bindings
>>>>   * Addressed comments from Viresh to use dev_pm_opp_set_prop_name,
>>accordingly
>>>>     dropped patch #12 and corrected patch #11 from previous patch
>>set in [4]
>>>>   * Converted to use #spdx tags for newly introduced files
>>>>
>>>> Mostly a resend of the v3 posted by Stephen quite some time back
>[1]
>>>> except for few changes=2E
>>>>   Based on reading some feedback from list,
>>>>   * Dropped the patch "clk: Add safe switch hook" from v3 [2]=2E
>>>>     Now this is taken care by patch#10 in this series only for
>>Krait=2E
>>>>   * Dropped the path "clk: Avoid sending high rates to downstream
>>>> 		      clocks during set_rate" from v3 [3]=2E
>>>>   * Rebased on top of clk-next=2E
>>>>   * Dropped the DT update from the series=2E Will send separately
>>>>   * Now with cpufreq-dt+opp supporting voltage scaling, registering
>>the
>>>>     krait cpu supplies in DT should be sufficient=2E But one issue
>is,
>>>>     the qcom-cpufreq drivers reads the efuse and based on that
>>registers
>>>>     the opp data and then registers the cpufreq-dt device=2E So when
>>>>     cpufreq-dt driver probes and registers the regulator to the OPP
>>framework,
>>>>     it expects that the opp data for the device should not be
>>registered before
>>>>     the regulator=2E Will send a RFC patch removing that check, to
>>find out the
>>>>     right way of doing it=2E
>>>>
>>>> These patches provide cpufreq scaling on devices with Krait CPUs=2E
>>>> In Krait CPU designs there's one PLL and two muxes per CPU,
>allowing
>>>> us to switch CPU frequencies independently=2E
>>>>
>>>> 				 secondary
>>>> 	 +-----+                    +
>>>> 	 | QSB |-------+------------|\
>>>> 	 +-----+       |            | |-+
>>>> 		       |    +-------|/  |
>>>> 		       |    |       +   |
>>>> 	 +-----+       |    |           |
>>>> 	 | PLL |----+-------+           |   primary
>>>> 	 +-----+    |  |                |     +
>>>> 		    |  |                +-----|\       +------+
>>>> 	 +-------+  |  |                      | \      |      |
>>>> 	 | HFPLL |----------+-----------------|  |-----| CPU0 |
>>>> 	 +-------+  |  |    |                 |  |     |      |
>>>> 		    |  |    | +-----+         | /      +------+
>>>> 		    |  |    +-| / 2 |---------|/
>>>> 		    |  |      +-----+         +
>>>> 		    |  |         secondary
>>>> 		    |  |            +
>>>> 		    |  +------------|\
>>>> 		    |               | |-+
>>>> 		    +---------------|/  |   primary
>>>> 				    +   |     +
>>>> 					+-----|\       +------+
>>>> 	 +-------+                            | \      |      |
>>>> 	 | HFPLL |----------------------------|  |-----| CPU1 |
>>>> 	 +-------+          |                 |  |     |      |
>>>> 			    | +-----+         | /      +------+
>>>> 			    +-| / 2 |---------|/
>>>> 			      +-----+         +
>>>>
>>>> To support this in the common clock framework we model the muxes,
>>>> dividers, and PLLs as different clocks=2E CPUfreq only interacts
>>>> with the primary mux (farthest right in the diagram)=2E When CPUfreq
>>>> sets a rate, the mux code finds the best parent that can provide
>the
>>rate=2E
>>>> Due to the design, QSB and the top PLL are always a fixed rate and
>>thus
>>>> only support one frequency each=2E These sources provide the lowest
>>>> frequencies for the CPUs=2E The HFPLLs are where we can make the CPU
>>go
>>>> faster (GHz range)=2E Sometimes we need to run the HFPLL twice as
>>>> fast and divide it by two to get a particular frequency=2E
>>>>
>>>> When switching rates we can't leave the CPU clocked by the HFPLL
>>because
>>>> we need to turn off the output of the PLL when changing its
>>frequency=2E
>>>> This means we have to switch over to the secondary mux and use one
>>of the
>>>> fixed sources=2E This is why we need something like the safe parent
>>patch=2E
>>>>
>>>> [1]
>>http://lists=2Einfradead=2Eorg/pipermail/linux-arm-kernel/2015-March/332=
607=2Ehtml
>>>> [2]
>>http://lists=2Einfradead=2Eorg/pipermail/linux-arm-kernel/2015-March/332=
615=2Ehtml
>>>> [3]
>>http://lists=2Einfradead=2Eorg/pipermail/linux-arm-kernel/2015-March/332=
608=2Ehtml
>>>> [4] https://lwn=2Enet/Articles/740994/=20
>>>> [5] https://lkml=2Eorg/lkml/2017/12/19/537
>>>>
>>>>
>>>> Sricharan R (3):
>>>>   clk: qcom: Add safe switch hook for krait mux clocks
>>>>   cpufreq: qcom: Re-organise kryo cpufreq to use it for other nvmem
>>>>     based qcom socs
>>>>   cpufreq: qcom: Add support for krait based socs
>>>>
>>>> Stephen Boyd (11):
>>>>   ARM: Add Krait L2 register accessor functions
>>>>   clk: qcom: Add support for High-Frequency PLLs (HFPLLs)
>>>>   clk: qcom: Add HFPLL driver
>>>>   dt-bindings: clock: Document qcom,hfpll
>>>>   clk: qcom: Add MSM8960/APQ8064's HFPLLs
>>>>   clk: qcom: Add IPQ806X's HFPLLs
>>>>   clk: qcom: Add support for Krait clocks
>>>>   clk: qcom: Add KPSS ACC/GCC driver
>>>>   dt-bindings: arm: Document qcom,kpss-gcc
>>>>   clk: qcom: Add Krait clock controller driver
>>>>   dt-bindings: clock: Document qcom,krait-cc
>>>>
>>>>  =2E=2E=2E/devicetree/bindings/arm/msm/qcom,kpss-acc=2Etxt  |  19 +
>>>>  =2E=2E=2E/devicetree/bindings/arm/msm/qcom,kpss-gcc=2Etxt  |  44 +++
>>>>  =2E=2E=2E/devicetree/bindings/clock/qcom,hfpll=2Etxt       |  60 +++=
+
>>>>  =2E=2E=2E/devicetree/bindings/clock/qcom,krait-cc=2Etxt    |  34 ++
>>>>  =2E=2E=2E/{kryo-cpufreq=2Etxt =3D> qcom-nvmem-cpufreq=2Etxt}   |   7=
 +-
>>>>  arch/arm/common/Kconfig                            |   3 +
>>>>  arch/arm/common/Makefile                           |   1 +
>>>>  arch/arm/common/krait-l2-accessors=2Ec               |  48 +++
>>>>  arch/arm/include/asm/krait-l2-accessors=2Eh          |   9 +
>>>>  drivers/clk/qcom/Kconfig                           |  28 ++
>>>>  drivers/clk/qcom/Makefile                          |   5 +
>>>>  drivers/clk/qcom/clk-hfpll=2Ec                       | 244
>>+++++++++++++
>>>>  drivers/clk/qcom/clk-hfpll=2Eh                       |  44 +++
>>>>  drivers/clk/qcom/clk-krait=2Ec                       | 126 +++++++
>>>>  drivers/clk/qcom/clk-krait=2Eh                       |  40 +++
>>>>  drivers/clk/qcom/gcc-ipq806x=2Ec                     |  82 +++++
>>>>  drivers/clk/qcom/gcc-msm8960=2Ec                     | 172 +++++++++
>>>>  drivers/clk/qcom/hfpll=2Ec                           |  96 +++++
>>>>  drivers/clk/qcom/kpss-xcc=2Ec                        |  87 +++++
>>>>  drivers/clk/qcom/krait-cc=2Ec                        | 397
>>+++++++++++++++++++++
>>>>  drivers/cpufreq/Kconfig=2Earm                        |   6 +-
>>>>  drivers/cpufreq/Makefile                           |   2 +-
>>>>  drivers/cpufreq/cpufreq-dt-platdev=2Ec               |   5 +
>>>>  drivers/cpufreq/qcom-cpufreq-kryo=2Ec                | 232
>>------------
>>>>  drivers/cpufreq/qcom-cpufreq-nvmem=2Ec               | 387
>>++++++++++++++++++++
>>>>  include/dt-bindings/clock/qcom,gcc-msm8960=2Eh       |   2 +
>>>>  26 files changed, 1941 insertions(+), 239 deletions(-)
>>>>  create mode 100644
>>Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc=2Etxt
>>>>  create mode 100644
>>Documentation/devicetree/bindings/clock/qcom,hfpll=2Etxt
>>>>  create mode 100644
>>Documentation/devicetree/bindings/clock/qcom,krait-cc=2Etxt
>>>>  rename Documentation/devicetree/bindings/opp/{kryo-cpufreq=2Etxt =3D=
>
>>qcom-nvmem-cpufreq=2Etxt} (98%)
>>>>  create mode 100644 arch/arm/common/krait-l2-accessors=2Ec
>>>>  create mode 100644 arch/arm/include/asm/krait-l2-accessors=2Eh
>>>>  create mode 100644 drivers/clk/qcom/clk-hfpll=2Ec
>>>>  create mode 100644 drivers/clk/qcom/clk-hfpll=2Eh
>>>>  create mode 100644 drivers/clk/qcom/clk-krait=2Ec
>>>>  create mode 100644 drivers/clk/qcom/clk-krait=2Eh
>>>>  create mode 100644 drivers/clk/qcom/hfpll=2Ec
>>>>  create mode 100644 drivers/clk/qcom/kpss-xcc=2Ec
>>>>  create mode 100644 drivers/clk/qcom/krait-cc=2Ec
>>>>  delete mode 100644 drivers/cpufreq/qcom-cpufreq-kryo=2Ec
>>>>  create mode 100644 drivers/cpufreq/qcom-cpufreq-nvmem=2Ec
>>>>
>>>=20

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
