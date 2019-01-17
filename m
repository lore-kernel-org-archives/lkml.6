Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D150C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09B320859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXHzeKKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfAQO0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:26:49 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39599 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfAQO0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 09:26:49 -0500
Received: by mail-qt1-f193.google.com with SMTP id u47so11463566qtj.6;
        Thu, 17 Jan 2019 06:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=qj+S80oVMmKMkbkSkgMh8yWZ6DRMk7MT5zaCIjeD/hc=;
        b=cXHzeKKUwbyk5jAb/Ete5Jq9I/gfngIRkj3iOossgbMHi00pB0olpn69glSyQ1jjhZ
         hsSTC8eovSMnyO0sSDzM/Ie4b95iO2vcLWPkzIcgIQdWAyPhWsrrVnX4iZEjhV2TMCHQ
         YWgw9I+nh8qNX9nf836KBgwt3LQFNEe/sSvNDQ193PzgO+Dzj6GdUav2UzFpAvBj3twF
         Lam1EM+B7ghwBbEZzjRJ17PTxowa4pc9aTqFAM2LSFoeyWEwVbm/xOY9rnvHOsgMtIeO
         34FbvvnHo4QPl88BeMkZLq+t9x68WsqPd51tUgus7/sKJ3/RLfqe0yVBGWt3AN9cqIKE
         ZX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=qj+S80oVMmKMkbkSkgMh8yWZ6DRMk7MT5zaCIjeD/hc=;
        b=DF8OACLTtBU3PtMk2i1uBaw3BmOvAf/+EoA5HU0gL299b2XXIraMa+jjYwklrAkaS9
         V64RFnlVFRXOkx44onyexLImdYAv0r9Owtegz6txLefnna6QLN/8pKi7cw19uBLTqbUn
         XvvEX/JA2HwTw6cyHcrGrxUPnVC4uSgDu3iJzJ913PMQJZQumjjTeNAXS3WKTL5zcp+m
         1hVF1W91lPhvGWRitgVzcA37SPdiUZZxtOiptcPM+jfptaPZDqc4Grb/JGxCxRIS76vb
         RAjLKFcaY3I7XbsCE/xpHVOClIN+fAQtrUdfBA/PUlGPOTOe8OZ1bG1ykkPbV+4k9vn5
         3u8w==
X-Gm-Message-State: AJcUukeVibhtLfWETAbiBUxVnB31/eA3lm6p+/7nvX6KhXoVf0uhkgdt
        I52RSd/BG7dCgAE7dAX5KXsgcPPc7qXYJtUscw==
X-Google-Smtp-Source: ALg8bN6I2qEdFCG+iF4I7goroQ2oJgNgrwQcH18v8TeI+8MjvPMwFNkQ4IXN8JF5jVaY8DnXCg0zYk3tpk2CoPNlsrI=
X-Received: by 2002:aed:29a6:: with SMTP id o35mr11328337qtd.257.1547735208082;
 Thu, 17 Jan 2019 06:26:48 -0800 (PST)
MIME-Version: 1.0
From:   Rob Herring <robherring2@gmail.com>
Date:   Thu, 17 Jan 2019 08:26:36 -0600
Message-ID: <CAL_JsqLiE8-TCRSigXxaGonaJE=7j9Ywggniy9_QXR3qFSbojg@mail.gmail.com>
Subject: [GIT PULL] Devicetree fixes for 5.0-rc
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull DT fixes for 5.0.

Rob

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
tags/devicetree-fixes-for-5.0

for you to fetch changes up to 3705add0b783e0deeb6646ba0311bf214fe52b0a:

  dt-bindings: reset: meson-axg: fix SPDX license id (2019-01-16 12:50:27 -0600)

----------------------------------------------------------------
Devicetree fixes for v5.0:

- Remove now unused struct device_node.type pointer

- Fix meson-axg reset header SPDX tag

- Add missing of_node_put in of_graph_get_remote_port_parent

- Fix several binding doc file references and typos

----------------------------------------------------------------
Jerome Brunet (1):
      dt-bindings: reset: meson-axg: fix SPDX license id

Julia Lawall (1):
      OF: properties: add missing of_node_put

Krzysztof Kozlowski (1):
      dt-bindings: soc: qcom: Fix trivial language typos

Lubomir Rintel (1):
      dt-bindings: marvell,mmp2: fix typos in bindings doc

Otto Sabart (2):
      doc: bindings: fix bad reference to ARM CPU bindings
      doc: gpio-mvebu: fix broken reference to cp110-system-controller0.txt file

Rob Herring (1):
      of: Remove struct device_node.type pointer

 Documentation/devicetree/bindings/arm/cpu-capacity.txt                | 2 +-
 Documentation/devicetree/bindings/arm/idle-states.txt                 | 2 +-
 Documentation/devicetree/bindings/arm/sp810.txt                       | 2 +-
 Documentation/devicetree/bindings/arm/topology.txt                    | 2 +-
 Documentation/devicetree/bindings/clock/marvell,mmp2.txt              | 2 +-
 Documentation/devicetree/bindings/display/arm,pl11x.txt               | 2 +-
 Documentation/devicetree/bindings/gpio/gpio-mvebu.txt                 | 2 --
 Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt | 2 +-
 Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt             | 2 +-
 Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.txt             | 4 ++--
 drivers/of/dynamic.c                                                  | 3 ---
 drivers/of/fdt.c                                                      | 4 ----
 drivers/of/overlay.c                                                  | 3 ---
 drivers/of/pdt.c                                                      | 1 -
 drivers/of/property.c                                                 | 1 +
 include/dt-bindings/reset/amlogic,meson-axg-reset.h                   | 3 +--
 include/linux/of.h                                                    | 1 -
 17 files changed, 12 insertions(+), 26 deletions(-)
