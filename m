Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495FDC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59DE206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1rd0Ooq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59DE206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeLEOl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:41:26 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44524 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeLEOlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:41:25 -0500
Received: by mail-ot1-f66.google.com with SMTP id f18so18781675otl.11;
        Wed, 05 Dec 2018 06:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7PJkTt1Q09aP9Mt4aoTE32lQqSFGN1wZG6dZAj981EY=;
        b=c1rd0OoqCf4oEJI7JQJlfJItrWmmF5L1xxVrbmxKvj24A43OQ4D4GolgnDdS+rjNCv
         mpjZDenzI7c4ZJV3e0U6fl5gcc6vIbdvN8bltDLG5NJuG6wP+keDFa6UtcLgQ31wxGZU
         hRvnRG5q7vKeEFET8Xmtgby16ncmDY7ImOt2QmMpANdiIHZFyDk9crTyFWJXmgHjwf3z
         FjUXyi/Rw17xbfyVxGJUAvDBSuf+cDpXscq3uewdunbyc9XVJSeFGy4heiQoniUamtbz
         xOCTFh/L5mUncnjmRCfW6Y24fB9Q06zRI0i2+T5/QXoHy/+wNuyhWDrhkMRlhnpPgm/Z
         ajSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7PJkTt1Q09aP9Mt4aoTE32lQqSFGN1wZG6dZAj981EY=;
        b=jO2ZIEbN30ZWIZpBd5vtS4dOH4V0XJVjlbTDzRM9X8wzb+C+no4lb+4glpkILC1A0A
         o0+BAqEfrblPpBAtP6tTRi7GI456Hclq5dfvYNBZT2SPxyBbrwJJl6rcHhZwSLBdjvQc
         VO+pi+CxcYMCyoJpAn5ZWfxJonK8nJiY4jTqJqQI7cvxqrS3eXDVGYekG8unHj35PTnF
         Hg+O7MirsMYh65DYqbcBZugrGrlWBxBbMmQw/zZqyfCNac/fXd/nk4jRCkeXfhfGTMQ/
         ehRZ72JDN1sXbtgHppl0SNt6jlQH10tW6J8kjahUWRBZLsrWge7APrLk0MtC8gas6nIG
         0gGg==
X-Gm-Message-State: AA+aEWbo7ObNffQcHFcJ2CfzzX8hx3kVSJLw+0Y9U9BCszKX4hnY49sC
        Sgnaq1mEdDIK49o/1Md+lsmSEWzwz6/j9bxMwBcq6A==
X-Google-Smtp-Source: AFSGD/WfkhQOP+TMCoA3kOGXwFWVxTHd5SSaOnJrJAngHhHSIIIf2cJ4xbiy5aOiHexrzo1wCH0Se0FKmT1u/Ln0ryU=
X-Received: by 2002:a9d:7285:: with SMTP id t5mr16204755otj.228.1544020883693;
 Wed, 05 Dec 2018 06:41:23 -0800 (PST)
MIME-Version: 1.0
References: <1544001240-18622-1-git-send-email-Anson.Huang@nxp.com> <CAOMZO5ACrqY9FusUG7E-vMWJ4pKpVgw-yLOYqJncOJ+H9A5k5w@mail.gmail.com>
In-Reply-To: <CAOMZO5ACrqY9FusUG7E-vMWJ4pKpVgw-yLOYqJncOJ+H9A5k5w@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 5 Dec 2018 12:41:27 -0200
Message-ID: <CAOMZO5DXDB+6an4N5SRmviW_oJ_6AtogkVQ_Mpj6o3bVKDsuKQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: imx6qdl-sabresd: add light sensor support
To:     Yongcai Huang <anson.huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: multipart/mixed; boundary="0000000000004c8df8057c4760c7"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000004c8df8057c4760c7
Content-Type: text/plain; charset="UTF-8"

Hi Anson,

On Wed, Dec 5, 2018 at 10:15 AM Fabio Estevam <festevam@gmail.com> wrote:

> I know that you followed the existing pattern for regulators in this
> file, but it is not recommended to put regulators under "simple-bus".
>
> I would suggest you to make a first patch of the series that removes
> all of the existing regulators from "simple-bus", then you add this
> series on top.

To make things easier, please find attached a patch that implements
this suggestion.

Please make it the first patch of your series.

Thanks

--0000000000004c8df8057c4760c7
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-ARM-dts-imx6qdl-sabresd-Move-regulators-outside-of-s.patch"
Content-Disposition: attachment; 
	filename="0001-ARM-dts-imx6qdl-sabresd-Move-regulators-outside-of-s.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jpba50ba0>
X-Attachment-Id: f_jpba50ba0

RnJvbSBhMDU1MjljNzdhYjEwN2RhYjZjY2Y5N2U5NzY3Y2VkOGZkMGIwNWQzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+CkRh
dGU6IFdlZCwgNSBEZWMgMjAxOCAxMjozNjozNSAtMDIwMApTdWJqZWN0OiBbUEFUQ0hdIEFSTTog
ZHRzOiBpbXg2cWRsLXNhYnJlc2Q6IE1vdmUgcmVndWxhdG9ycyBvdXRzaWRlIG9mCiAic2ltcGxl
LWJ1cyIKCkl0IGlzIG5vdCByZWNvbW1lbmRlZCB0byBwbGFjZSByZWd1bGF0b3JzIGluc2lkZSAi
c2ltcGxlLWJ1cyIsIHNvIG1vdmUKdGhlbSBvdXQgdG8gbWFrZSBpdCBjbGVhbmVyIHRoZSBhZGRp
dGlvbiBvZiBuZXcgcmVndWxhdG9ycy4KClNpZ25lZC1vZmYtYnk6IEZhYmlvIEVzdGV2YW0gPGZl
c3RldmFtQGdtYWlsLmNvbT4KLS0tCiBhcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLXNhYnJlc2Qu
ZHRzaSB8IDgyICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCAzNiBpbnNlcnRpb25zKCspLCA0NiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNo
L2FybS9ib290L2R0cy9pbXg2cWRsLXNhYnJlc2QuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lt
eDZxZGwtc2FicmVzZC5kdHNpCmluZGV4IDZlNDZhMTkuLmQ3NTg1ODUgMTAwNjQ0Ci0tLSBhL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtc2FicmVzZC5kdHNpCisrKyBiL2FyY2gvYXJtL2Jvb3Qv
ZHRzL2lteDZxZGwtc2FicmVzZC5kdHNpCkBAIC0xNiw1MiArMTYsNDIgQEAKIAkJcmVnID0gPDB4
MTAwMDAwMDAgMHg0MDAwMDAwMD47CiAJfTsKIAotCXJlZ3VsYXRvcnMgewotCQljb21wYXRpYmxl
ID0gInNpbXBsZS1idXMiOwotCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKLQkJI3NpemUtY2VsbHMg
PSA8MD47Ci0KLQkJcmVnX3VzYl9vdGdfdmJ1czogcmVndWxhdG9yQDAgewotCQkJY29tcGF0aWJs
ZSA9ICJyZWd1bGF0b3ItZml4ZWQiOwotCQkJcmVnID0gPDA+OwotCQkJcmVndWxhdG9yLW5hbWUg
PSAidXNiX290Z192YnVzIjsKLQkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDUwMDAwMDA+
OwotCQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8NTAwMDAwMD47Ci0JCQlncGlvID0gPCZn
cGlvMyAyMiAwPjsKLQkJCWVuYWJsZS1hY3RpdmUtaGlnaDsKLQkJCXZpbi1zdXBwbHkgPSA8JnN3
YnN0X3JlZz47Ci0JCX07Ci0KLQkJcmVnX3VzYl9oMV92YnVzOiByZWd1bGF0b3JAMSB7Ci0JCQlj
b21wYXRpYmxlID0gInJlZ3VsYXRvci1maXhlZCI7Ci0JCQlyZWcgPSA8MT47Ci0JCQlyZWd1bGF0
b3ItbmFtZSA9ICJ1c2JfaDFfdmJ1cyI7Ci0JCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDw1
MDAwMDAwPjsKLQkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDUwMDAwMDA+OwotCQkJZ3Bp
byA9IDwmZ3BpbzEgMjkgMD47Ci0JCQllbmFibGUtYWN0aXZlLWhpZ2g7Ci0JCQl2aW4tc3VwcGx5
ID0gPCZzd2JzdF9yZWc+OwotCQl9OwotCi0JCXJlZ19hdWRpbzogcmVndWxhdG9yQDIgewotCQkJ
Y29tcGF0aWJsZSA9ICJyZWd1bGF0b3ItZml4ZWQiOwotCQkJcmVnID0gPDI+OwotCQkJcmVndWxh
dG9yLW5hbWUgPSAid204OTYyLXN1cHBseSI7Ci0JCQlncGlvID0gPCZncGlvNCAxMCAwPjsKLQkJ
CWVuYWJsZS1hY3RpdmUtaGlnaDsKLQkJfTsKLQotCQlyZWdfcGNpZTogcmVndWxhdG9yQDMgewot
CQkJY29tcGF0aWJsZSA9ICJyZWd1bGF0b3ItZml4ZWQiOwotCQkJcmVnID0gPDM+OwotCQkJcGlu
Y3RybC1uYW1lcyA9ICJkZWZhdWx0IjsKLQkJCXBpbmN0cmwtMCA9IDwmcGluY3RybF9wY2llX3Jl
Zz47Ci0JCQlyZWd1bGF0b3ItbmFtZSA9ICJNUENJRV8zVjMiOwotCQkJcmVndWxhdG9yLW1pbi1t
aWNyb3ZvbHQgPSA8MzMwMDAwMD47Ci0JCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwzMzAw
MDAwPjsKLQkJCWdwaW8gPSA8JmdwaW8zIDE5IDA+OwotCQkJZW5hYmxlLWFjdGl2ZS1oaWdoOwot
CQl9OworCXJlZ191c2Jfb3RnX3ZidXM6IHJlZ3VsYXRvci11c2Itb3RnLXZidXMgeworCQljb21w
YXRpYmxlID0gInJlZ3VsYXRvci1maXhlZCI7CisJCXJlZ3VsYXRvci1uYW1lID0gInVzYl9vdGdf
dmJ1cyI7CisJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDUwMDAwMDA+OworCQlyZWd1bGF0
b3ItbWF4LW1pY3Jvdm9sdCA9IDw1MDAwMDAwPjsKKwkJZ3BpbyA9IDwmZ3BpbzMgMjIgMD47CisJ
CWVuYWJsZS1hY3RpdmUtaGlnaDsKKwkJdmluLXN1cHBseSA9IDwmc3dic3RfcmVnPjsKKwl9Owor
CisJcmVnX3VzYl9oMV92YnVzOiByZWd1bGF0b3ItdXNiLWgxLXZidXMgeworCQljb21wYXRpYmxl
ID0gInJlZ3VsYXRvci1maXhlZCI7CisJCXJlZ3VsYXRvci1uYW1lID0gInVzYl9oMV92YnVzIjsK
KwkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8NTAwMDAwMD47CisJCXJlZ3VsYXRvci1tYXgt
bWljcm92b2x0ID0gPDUwMDAwMDA+OworCQlncGlvID0gPCZncGlvMSAyOSAwPjsKKwkJZW5hYmxl
LWFjdGl2ZS1oaWdoOworCQl2aW4tc3VwcGx5ID0gPCZzd2JzdF9yZWc+OworCX07CisKKwlyZWdf
YXVkaW86IHJlZ3VsYXRvci1hdWRpbyB7CisJCWNvbXBhdGlibGUgPSAicmVndWxhdG9yLWZpeGVk
IjsKKwkJcmVndWxhdG9yLW5hbWUgPSAid204OTYyLXN1cHBseSI7CisJCWdwaW8gPSA8JmdwaW80
IDEwIDA+OworCQllbmFibGUtYWN0aXZlLWhpZ2g7CisJfTsKKworCXJlZ19wY2llOiByZWd1bGF0
b3ItcGNpZSB7CisJCWNvbXBhdGlibGUgPSAicmVndWxhdG9yLWZpeGVkIjsKKwkJcGluY3RybC1u
YW1lcyA9ICJkZWZhdWx0IjsKKwkJcGluY3RybC0wID0gPCZwaW5jdHJsX3BjaWVfcmVnPjsKKwkJ
cmVndWxhdG9yLW5hbWUgPSAiTVBDSUVfM1YzIjsKKwkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQg
PSA8MzMwMDAwMD47CisJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDMzMDAwMDA+OworCQln
cGlvID0gPCZncGlvMyAxOSAwPjsKKwkJZW5hYmxlLWFjdGl2ZS1oaWdoOwogCX07CiAKIAlncGlv
LWtleXMgewotLSAKMi43LjQKCg==
--0000000000004c8df8057c4760c7--
