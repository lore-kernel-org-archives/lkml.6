Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EA6C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482A623FB1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KwW2oZZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482A623FB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934790AbeGDMim (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:38:42 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35305 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934324AbeGDMij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:38:39 -0400
Received: by mail-qt0-f193.google.com with SMTP id z6-v6so4384086qti.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 05:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rd4UUJQ6Zk3/xcTu4yTKZ7EMzqap7F6YLq2NRy1EvcI=;
        b=KwW2oZZ92Y8p48+QoyDaDy83n1dJhXHJoJgOERQ//v0FvqIunPSIoGWqJtx1YxUIkl
         0Hf7yU69t5SECT5Oyturs9nJZXNFW4IrGLz7EunvhF7GHQ1HlraAQsWKDBiFXU8fvIs8
         riTt3t2xQpiX5LLU48ri19vvK67doYY83CJQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rd4UUJQ6Zk3/xcTu4yTKZ7EMzqap7F6YLq2NRy1EvcI=;
        b=CFhr6jqAl5wdxXaSf3pWEv427/YDLSC1UpN59EUpeWTsTFjYYhxdIcjnkYJFg0jSJB
         1U/nQv+8/I6+9gE/h8+0sB8FuhSnR7sNwmBIN6TB/M5REbC7grZjHR08TAN10noMOuyv
         SDiP+hWl5Y9jreufdY2jTvB5xcrQbpy8Er8hZr96JU4cfaRcoJUHErYQBXO1wEjtwljt
         TzUHlZhJ3TBokbAciKlojG1DOLHE+0NHQL8jc1LVM7poP+R/qh9cLIqjt4cZ89+vpewl
         nDRpEsg9lwysfe+1vhJ8nfD7xfyPpHMIlircNIcCPsyivuE4Q/cOcidPLNHBCXpA8mEi
         nvxQ==
X-Gm-Message-State: APt69E0b0TO42QFz+jNDnGIhrQOi3vo2cdIH981CHfdlVdHesyos8WHp
        yDLeJtqHuJDbQq4vBX8cdh/2z7PpL6Yq3rpSwg5O3Q==
X-Google-Smtp-Source: AAOMgpdd+MKUDG7uSY3OGnu23svxAFf5zuJcbqyZqXPZixlEaeNqJ1T5Qs7Dwbcj0Fduxj57A0CRkDtrvB8L68CXT60=
X-Received: by 2002:ac8:29e:: with SMTP id p30-v6mr1508255qtg.131.1530707918454;
 Wed, 04 Jul 2018 05:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1530533998.git.amit.kucheria@linaro.org>
 <7e9beaa3218b1c46ea6a7399c5978c1538fce261.1530533998.git.amit.kucheria@linaro.org>
 <20180702185530.GD2050@tuxbook-pro>
In-Reply-To: <20180702185530.GD2050@tuxbook-pro>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 4 Jul 2018 18:08:27 +0530
Message-ID: <CAP245DUG=wXApk6BVmaaUyTRBDaiPc0x4EDh3KS2ZfMxPQowkg@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] thermal: tsens: Rename tsens-8996 to tsens-v2 for reuse
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000bc395105702bb51a"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000bc395105702bb51a
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 3, 2018 at 12:23 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Mon 02 Jul 05:44 PDT 2018, Amit Kucheria wrote:
>
> > The TSENS block inside the 8996 is internally classified as version 2 of
> > the IP. Several other SoC families use this block and can share this code.
> >
> > We rename get_temp() to reflect that it can be used across the v2 family.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  drivers/thermal/qcom/Makefile                     |  2 +-
> >  drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c} | 26 ++++++++---------------
> >  2 files changed, 10 insertions(+), 18 deletions(-)
> >  rename drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c} (66%)
> >
> > diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
> > index 2cc2193..a821929 100644
> > --- a/drivers/thermal/qcom/Makefile
> > +++ b/drivers/thermal/qcom/Makefile
> > @@ -1,2 +1,2 @@
> >  obj-$(CONFIG_QCOM_TSENS)     += qcom_tsens.o
> > -qcom_tsens-y                 += tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o tsens-8996.o
> > +qcom_tsens-y                 += tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o tsens-v2.o
> > diff --git a/drivers/thermal/qcom/tsens-8996.c b/drivers/thermal/qcom/tsens-v2.c
> > similarity index 66%
> > rename from drivers/thermal/qcom/tsens-8996.c
> > rename to drivers/thermal/qcom/tsens-v2.c
> > index e1f7781..2eca7ff 100644
> > --- a/drivers/thermal/qcom/tsens-8996.c
> > +++ b/drivers/thermal/qcom/tsens-v2.c
> > @@ -1,27 +1,18 @@
> > +// SPDX-License-Identifier: GPL-2.0
> >  /*
> >   * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> > - *
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License version 2 and
> > - * only version 2 as published by the Free Software Foundation.
> > - *
> > - * This program is distributed in the hope that it will be useful,
> > - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - * GNU General Public License for more details.
> > - *
> > + * Copyright (c) 2018, Linaro Limited
> >   */
> >
> > -#include <linux/platform_device.h>
> >  #include <linux/regmap.h>
> >  #include "tsens.h"
> >
> > -#define STATUS_OFFSET        0x10a0
> > -#define LAST_TEMP_MASK       0xfff
> > +#define STATUS_OFFSET                0xa0
>
> This is not backwards compatible with present day dts files, you need to
> keep this effectively 0x10a0 when the memory region isn't split in two.

Argh!! Good catch.

> Perhaps you can just offset the ioremap by 4k when there's only one
> region?

That'll cause problems when we want to access some features exposed in
the other register bank through the common get_temp_tsens_v2 function.
The SW reset bit is in there that I'd like to add support for, for
example.

I can see a few other ways to detect this at runtime. None of them
look pretty but option 3 looks least ugly at least to me. Any
preferences?

1. Don't try to combine get_temp for 8996 with other v2 platforms.
This would mean retaining a separate ops_8996, pointing to a custom
get_temp(). We end up with two copies of the function.

2. In get_temp_tsens_v2(), check for number of regions but this has an
overhead for each temperature read.

     struct platform_device *op = of_find_device_by_node(tmdev->dev->of_node);
     if (op->num_resources > 1)
        status_offset = 0xa0;
     else
        status_offset = 0x10a0;
     Read temperature(status_offset);

3. Restrict to init time (ideal) by storing the status_offset to
struct tsens_device. This is then used directly in
get_temp_generic_v2() to determine the actual address. This should
work for 8996, 8916 and 8974 which all have a single memory region
iomapp'ed. The last two don't even need this value since they have
their own get_temp functions. See diff attached.

I have to ask: Are there really devices in the field that rely on the
existing *upstream* code and DT? If not, could we consider deprecating
the "qcom,msm8996-tsens" property immediately or at least mark it for
future removal?

Regards,
Amit

--000000000000bc395105702bb51a
Content-Type: text/plain; charset="US-ASCII"; name="3.diff.txt"
Content-Disposition: attachment; filename="3.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_jj73xf8o0>
X-Attachment-Id: f_jj73xf8o0

ZGlmZiAtLWdpdCBpL2RyaXZlcnMvdGhlcm1hbC9xY29tL3RzZW5zLWNvbW1vbi5jIHcvZHJpdmVy
cy90aGVybWFsL3Fjb20vdHNlbnMtY29tbW9uLmMKaW5kZXggYjE0NDlhZC4uNzk4Mjg2NyAxMDA2
NDQKLS0tIGkvZHJpdmVycy90aGVybWFsL3Fjb20vdHNlbnMtY29tbW9uLmMKKysrIHcvZHJpdmVy
cy90aGVybWFsL3Fjb20vdHNlbnMtY29tbW9uLmMKQEAgLTE2LDYgKzE2LDcgQEAKICNpbmNsdWRl
IDxsaW51eC9pby5oPgogI2luY2x1ZGUgPGxpbnV4L252bWVtLWNvbnN1bWVyLmg+CiAjaW5jbHVk
ZSA8bGludXgvb2ZfYWRkcmVzcy5oPgorI2luY2x1ZGUgPGxpbnV4L29mX3BsYXRmb3JtLmg+CiAj
aW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+CiAjaW5jbHVkZSA8bGludXgvcmVnbWFw
Lmg+CiAjaW5jbHVkZSAidHNlbnMuaCIKQEAgLTEyNiw2ICsxMjcsMTIgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCByZWdtYXBfY29uZmlnIHRzZW5zX2NvbmZpZyA9IHsKIGludCBfX2luaXQgaW5pdF9j
b21tb24oc3RydWN0IHRzZW5zX2RldmljZSAqdG1kZXYpCiB7CiAJdm9pZCBfX2lvbWVtICpiYXNl
OworCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKm9wID0gb2ZfZmluZF9kZXZpY2VfYnlfbm9kZSh0
bWRldi0+ZGV2LT5vZl9ub2RlKTsKKworCWlmIChvcC0+bnVtX3Jlc291cmNlcyA+IDEpCisJCXRt
ZGV2LT5zdGF0dXNfb2Zmc2V0ID0gMHhhMDsKKwllbHNlCisJCXRtZGV2LT5zdGF0dXNfb2Zmc2V0
ID0gMHgxMGEwOwogCiAJYmFzZSA9IG9mX2lvbWFwKHRtZGV2LT5kZXYtPm9mX25vZGUsIDApOwog
CWlmICghYmFzZSkKZGlmZiAtLWdpdCBpL2RyaXZlcnMvdGhlcm1hbC9xY29tL3RzZW5zLXYyLmMg
dy9kcml2ZXJzL3RoZXJtYWwvcWNvbS90c2Vucy12Mi5jCmluZGV4IDA0NzNmMzMuLjg0MDAyOTAg
MTAwNjQ0Ci0tLSBpL2RyaXZlcnMvdGhlcm1hbC9xY29tL3RzZW5zLXYyLmMKKysrIHcvZHJpdmVy
cy90aGVybWFsL3Fjb20vdHNlbnMtdjIuYwpAQCAtMTAsNyArMTAsNiBAQAogI2RlZmluZSBUUkRZ
X09GRlNFVCAgICAgICAgICAgIDB4ZTQKICNkZWZpbmUgVFJEWV9SRUFEWV9CSVQgICAgICAgICBC
SVQoMCkKIAotI2RlZmluZSBTVEFUVVNfT0ZGU0VUCQkweGEwCiAjZGVmaW5lIExBU1RfVEVNUF9N
QVNLCQkweGZmZgogI2RlZmluZSBTVEFUVVNfVkFMSURfQklUCUJJVCgyMSkKICNkZWZpbmUgQ09E
RV9TSUdOX0JJVAkJQklUKDExKQpAQCAtMjgsNyArMjcsNyBAQCBzdGF0aWMgaW50IGdldF90ZW1w
X3RzZW5zX3YyKHN0cnVjdCB0c2Vuc19kZXZpY2UgKnRtZGV2LCBpbnQgaWQsIGludCAqdGVtcCkK
IAlpZiAoY29kZSAmIFRSRFlfUkVBRFlfQklUKQogCQlyZXR1cm4gLUVOT0RBVEE7CiAKLQlzZW5z
b3JfYWRkciA9IFNUQVRVU19PRkZTRVQgKyBzLT5od19pZCAqIDQ7CisJc2Vuc29yX2FkZHIgPSB0
bWRldi0+c3RhdHVzX29mZnNldCArIHMtPmh3X2lkICogNDsKIAlyZXQgPSByZWdtYXBfcmVhZCh0
bWRldi0+bWFwLCBzZW5zb3JfYWRkciwgJmNvZGUpOwogCWlmIChyZXQpCiAJCXJldHVybiByZXQ7
CmRpZmYgLS1naXQgaS9kcml2ZXJzL3RoZXJtYWwvcWNvbS90c2Vucy5oIHcvZHJpdmVycy90aGVy
bWFsL3Fjb20vdHNlbnMuaAppbmRleCA2OTIxMmNiLi44YTQyYTcwIDEwMDY0NAotLS0gaS9kcml2
ZXJzL3RoZXJtYWwvcWNvbS90c2Vucy5oCisrKyB3L2RyaXZlcnMvdGhlcm1hbC9xY29tL3RzZW5z
LmgKQEAgLTc3LDYgKzc3LDcgQEAgc3RydWN0IHRzZW5zX2RldmljZSB7CiAJc3RydWN0IGRldmlj
ZQkJCSpkZXY7CiAJdTMyCQkJCW51bV9zZW5zb3JzOwogCXN0cnVjdCByZWdtYXAJCQkqbWFwOwor
CXUzMgkJCQlzdGF0dXNfb2Zmc2V0OwogCXN0cnVjdCB0c2Vuc19jb250ZXh0CQljdHg7CiAJY29u
c3Qgc3RydWN0IHRzZW5zX29wcwkJKm9wczsKIAlzdHJ1Y3QgdHNlbnNfc2Vuc29yCQlzZW5zb3Jb
MF07Cg==
--000000000000bc395105702bb51a--
