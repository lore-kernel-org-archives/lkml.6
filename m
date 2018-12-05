Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5306C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CB02054F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lH/NkyfY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CB02054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbeLEXlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:41:36 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39706 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbeLEXlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:41:35 -0500
Received: by mail-lf1-f67.google.com with SMTP id n18so16077293lfh.6;
        Wed, 05 Dec 2018 15:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qNKe+5KxT/esz0I+cZXkh1aeiS+WfwyvdIf8Ds443Ac=;
        b=lH/NkyfYlV6q7it4rU9iNpD0l0zr+ghZJWIOhvHhrBbngGyOj8EhG+C6Duw/8ExAz9
         9zmv/FofnZI2v0PmOr1Su0vZDF/nysz1bTLTAqu6y5Vl6jEMyoiWXjt0btg5UPpEofdY
         C8kToHQvhTX6Sqwk89COIGrOKB22x2w7JxK81SHYWO4Sm/sFRv9Yrv8GLgBc91q/pOa2
         puO5gALgwQioEH1V6AzrtsODjafsqY2I4uG0oLkAYSdp0oyRM9Qy2WFoNuZn5UU7ERqc
         cMO35cNH2jYHD2R1rc97XolI50LFGeKYY2DDb/GxjNzRVmZYUGKWtLT/tUXLcuVx2bVr
         9voQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qNKe+5KxT/esz0I+cZXkh1aeiS+WfwyvdIf8Ds443Ac=;
        b=QF/256YT639VwOIy1o/ulSVpc/RoS2yWveMWbr04WdSrTs2sDDZJRUvfGzb4VddncC
         ZeL+yE6irNMEam5uC3dNyW7ccCoFUhyXnQ2htyNVOV5Hv3l3adMSwbTG6nnVH6ZJnm6h
         ye9UnxIr53Nak60Kn3P2kWId3AKEOZGg2eZdUVofxBvZqdBF5WMd4YFZlnSNDk4OxLcS
         NvCOMzIwLsdlC7MESUBFbV10zkLlhwdPzrRfurKJGXtfyNmXRbXnqLfAStWLRbZpZPMx
         5CIKPoZn+uagOV4ENsaBzyTulI2+wzDnHGNxTaxhp/jFXUigKQLVZMfMKrlTYINdLjmo
         GP+A==
X-Gm-Message-State: AA+aEWaW1UVFGHcF0M4JnC9OPQPNTBAl6xmyssu2zAE/gSTOa+jC9th+
        ZFL2IYIncRfVLNz1rWW6E7LlschOtiaOWsLwU+o=
X-Google-Smtp-Source: AFSGD/W5MmOVTo8TQq+2HBiNymKCZPp2wLasc6xtW8qHTSX3UDtD8fxfag/nwkIu82NESWwSjznSeqc7tErgCcIvuTU=
X-Received: by 2002:a19:26ce:: with SMTP id m197mr15083019lfm.23.1544053292925;
 Wed, 05 Dec 2018 15:41:32 -0800 (PST)
MIME-Version: 1.0
References: <CAChUvXNO_8Frw1igaEAHSxmdtTy7MJVm8W1NpUqZ6tFD0hXwhA@mail.gmail.com>
 <0BF2A47F-7F33-4E4D-A566-23AF2F4CCD52@theinkpens.com> <CAChUvXMVHxhawLFPFzz_0+iFxjQ+dRwpTsCGo95oc8Y+7a-2DQ@mail.gmail.com>
 <AM0PR04MB3971FBCF6CB23BE778D39EED9AD80@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXPCfwfHrntJHWpsydYZE=P692Axd0pFE+GjZCXtx1fgog@mail.gmail.com>
 <CAChUvXMWZ-LYyqnczM-bt9cDP0r1XT+F1dcYuRHiVcx=QR7_Jw@mail.gmail.com>
 <AM0PR04MB3971768EA5D50D7045B462619AD10@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXN8rZqxBaV2qbdR8uymsmZAk_Jnc2kxSUf+kBf76QHV9A@mail.gmail.com>
 <AM0PR04MB3971FFCCDAF29E7DF0F0EE159AD10@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXNz=XR37EeVRJFnF195BGgjPgCeFv6nbjR3yV2_mQwxBQ@mail.gmail.com>
 <20181128234415.GH16830@zn.tnic> <CAChUvXPgntzMbAhcg8y2HJyyZWwaqNPe66efmpfyHLgN1JSW_w@mail.gmail.com>
 <AM0PR04MB3971D326D037CFB2497B1A559AA80@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXNxcpHDOn1Rkxwp8VbuN5-k08JfrgwdbN95uvMWVh1Rwg@mail.gmail.com>
 <AM0PR04MB3971DE1C9A0B3D6C938CBADD9AA80@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXNSGosbBbiBh-MF8FsnKpL3jMaS-fr_BzQAjEcPCWi7Ew@mail.gmail.com> <AM0PR04MB39717D1017A161D54940486D9AA80@AM0PR04MB3971.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB39717D1017A161D54940486D9AA80@AM0PR04MB3971.eurprd04.prod.outlook.com>
From:   Tracy Smith <tlsmith3777@gmail.com>
Date:   Wed, 5 Dec 2018 17:41:20 -0600
Message-ID: <CAChUvXOgUiQLAuTBAhYzkc2C-FN=BLbYo2fdKLkMZKOJW7gF+g@mail.gmail.com>
Subject: Layerscape UE detected and no EDAC panic
To:     york.sun@nxp.com
Cc:     bp@alien8.de, linux-edac@vger.kernel.org,
        util-linux@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I can't help you on that. I never tried to force errors by grounding the
> signals. You have read the driver. Do you see panic? The idea is to
> report the error and let upper layer to decide what to do. Sometimes
> limping forward is better than reset or panic. Again, it is not driver's
> responsibility.

Thanks for the clarification York. Yes there is panic code in the EDAC
upper layer, but no panic occurred.  A UE was printed on the serial
console, and the layerscape board reset.

The reason it did not panic is because edac_mc_panic_on_ue has to be
set at runtime. Just validated this will cause a panic when set. No
memory UE should reset the board, so this was caused because of
grounding the data line and an issue with how I'm testing for a UE not
related to a UE itself.

echo "1" > /sys/module/edac_core/parameters/edac_mc_panic_on_ue this
is the way to force a panic on a UE error.

MODULE_PARM_DESC(edac_mc_panic_on_ue, "Panic on uncorrected error: 0=off 1=on");

So, this is validated. Produced a UE and was able to avoid a panic and
I was able to induce a panic on a UE.  I'm satisfied with this. thanks
again!!
