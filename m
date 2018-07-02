Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F124C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA1425D2F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QcsQk/7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA1425D2F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752678AbeGBNR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:17:28 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:39044 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752491AbeGBNRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:17:23 -0400
Received: by mail-io0-f193.google.com with SMTP id e13-v6so14694188iof.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 06:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Q9ZvjjYmfmgJDZhBm928CapR8nVFyc9uH4YgIolc3Iw=;
        b=QcsQk/7r6Oigh3tcrW1WCROeOn5K15BtVXC0XYbHBtNf9IPHlYGQYje1YbsHdIdjO4
         /VeCkYeNzufZbUrhkZcEHgcYPi4Ejq+WhRx5C+Hen7AVQv09KYNuDT565f8XM+EYt+Cg
         dyfS4Pt5nKilCqQAxQawGfUDLX9X+AweTiRYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Q9ZvjjYmfmgJDZhBm928CapR8nVFyc9uH4YgIolc3Iw=;
        b=j6horrRy6VmisB2nMHkKbrSDBGH2lOTUROOvxbdBwBc3z6DO/HsIG3zIYu7cmRDC50
         ikMJ7W8h9ToY9AF7zruf8gylR9HB8J6+a+DgGSiwOvR2NZRH8CuMe96vkyMHUqPZOD66
         spCw6Zsror861OS0vQAWUoNvgngOhAkBbXBIjQixPQqrQ+cDGWJxLX5gyFYdRuT9rebE
         EdyCO2vpxkzR84zTyOPr7nggJgbHHoGVjWjec4cLkenOvxQ/TkYQkJLIhccUgzz4C7C+
         R2cVzlt5wHJKEhd/zKHbpUO4G6zjhx5USXdKvse8wM/Z0XOkaAb3jobWngjSL+6b8JXd
         shqQ==
X-Gm-Message-State: APt69E2trp1m64OhaO+Jb3Ha9nlwZ5H9ER3wCT9SpIERrPDUNY3NyxEj
        Pu0VzoqhAIqZT0Ieo2X7E3ddvbYqVaCMTJNM5EUhGA==
X-Google-Smtp-Source: AAOMgpeC4FFNIRvf5BOnPuxRQhzXsZ4ZatEAyrfMIhjv2MoXLzXOtR0GmkZRcRprVGMo27XQjqAgShy2Hs6luxmO2aA=
X-Received: by 2002:a6b:c997:: with SMTP id z145-v6mr14739770iof.266.1530537442669;
 Mon, 02 Jul 2018 06:17:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 06:17:21 -0700 (PDT)
In-Reply-To: <1529386761-4923-1-git-send-email-vviswana@codeaurora.org>
References: <1529386761-4923-1-git-send-email-vviswana@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Jul 2018 15:17:21 +0200
Message-ID: <CAPDyKFof7cV-ixNCySBOTJ2Ht6m2-RNUNWYFxZ1WGf==v1P2qw@mail.gmail.com>
Subject: Re: [PATCH V3 0/4] Changes for SDCC5 version
To:     Vijay Viswanath <vviswana@codeaurora.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        devicetree@vger.kernel.org, Asutosh Das <asutoshd@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Jeremy McNicoll <jeremymc@redhat.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        vbadigan@codeaurora.org, Doug Anderson <dianders@google.com>,
        sayalil@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 June 2018 at 07:39, Vijay Viswanath <vviswana@codeaurora.org> wrote:
> With SDCC5, the MCI register space got removed and the offset/order of
> several registers have changed. Based on SDCC version used and the register,
> we need to pick the base address and offset.
>
> Depends on patch series: "[PATCH V5 0/2] mmc: sdhci-msm: Configuring IO_PAD support for sdhci-msm"
>
> Changes since RFC:
>         Dropped voltage regulator changes in sdhci-msm
>         Split the "Register changes for sdcc V5" patch
>         Instead of checking mci removal for deciding which base addr to use,
>         new function pointers are defined for the 2 variants of sdcc:
>                 1) MCI present
>                 2) V5 (mci removed)
>         Instead of string comparing with the compatible string from DT file,
>         the sdhci_msm_probe will now pick the data associated with the
>         compatible entry and use it to load variant specific address offsets
>         and msm variant specific read/write ops.
>
> Changes since V1:
>         Removed unused msm_reab & msm_writeb APIs
>         Changed certain register addresses from uppercase to lowercase hex
>         letters
>         Removed extra lines and spaces
>         Split "[PATCH V1 0/3] Changes for SDCC5 version" patch into two,
>         one for Documentation and other for the driver changes.
>
> Changes since V2:
>         Used lower case for macro function defenitions
>         Removed unused function pointers for msm_readb & msm_writeb
>
>
> Sayali Lokhande (3):
>   mmc: sdhci-msm: Define new Register address map
>   Documentation: sdhci-msm: Add new compatible string for SDCC v5
>   mmc: host: Register changes for sdcc V5
>
> Vijay Viswanath (1):
>   mmc: sdhci-msm: Add msm version specific ops and data structures
>
>  .../devicetree/bindings/mmc/sdhci-msm.txt          |   7 +-
>  drivers/mmc/host/sdhci-msm.c                       | 511 ++++++++++++++++-----
>  2 files changed, 391 insertions(+), 127 deletions(-)
>

Thanks, applied for next!

Kind regards
Uffe
