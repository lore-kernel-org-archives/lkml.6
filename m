Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF000C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76CA21019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3SOUYXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfAVSHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:07:52 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44019 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfAVSHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:07:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so28430308wrs.10;
        Tue, 22 Jan 2019 10:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=My8b7FlvuN3psgDiTdl2oYvke/nMupwBdlAWoxtJNoA=;
        b=l3SOUYXVFMLcwdhq5VNk2xu2kLMU+YOHB6Ar9bPAY8fYUqlwK/59PbYLtXIYGRd//s
         uTaVToT/4OChFNZxvb2slp3OB2DpoKGD6RZ2R5yC8vHLR7coZmFbfnwPYim0IaMPgaCF
         V7r0PzHnn+7MdUMmwowYcXnSh6aUpN1KMU2dBcLNUe5gd8O9fbw2JjFgxOmD2/xApamf
         Kd6x/R5EJPJSTDMNuH4qOJ+erXp9UDBeUUECK3riQWSq37ebhhfsvkNxtwTb3so9fDLw
         6wqYZP/FVsGsjEYqf71g9I3FaUspN611/WUmous3scuzK7VzVtVzCR/WkJwFEbnDsgY4
         ozKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=My8b7FlvuN3psgDiTdl2oYvke/nMupwBdlAWoxtJNoA=;
        b=ADFK4mERY9lPoZQ/szQplalkXUgRYQ7Vl184h3WVFCfqpCQpeOTPzqRyYaQgwUULor
         NulHlIM9zvVnVJsgoHHwgvKeSpnG6jEyGRWtiVIlc0lCFiym9FWFIO0PNs/nXl2zc72f
         qYKxFUKV2FEUipv2uxJj3Vs9qUl8zqGIqW8uLzXJKi6dO+oYqHke+e3Q5xxgpVCwB7qW
         PMJ3ssn+CsKncD04FpKehTxARIzF3e/QPcjH9FApsX+XJSf2d1GVzBk+WTqAJDWq6g4C
         mV/ww/qNe5B9WcQfXT0NmWRcL/UiAGEsFFrKE1Rt9AqwRwvl8ouMuwxsMd5T2j3MiMpE
         4Qtw==
X-Gm-Message-State: AJcUukeRJoJ5PMghWVC+0gKr91qlXyB+xjGM0JilMyXtNXXGxl93fygS
        owJkHFmzcYOfgD7yKxd+s9ztF2s6024=
X-Google-Smtp-Source: ALg8bN4qlSv2alBvto7x/Y/NCvt+PrgErBdXFIEMhK+5uvyrdPufRgjfWOTYb1t9OT5EHv0x0V3tzA==
X-Received: by 2002:adf:e509:: with SMTP id j9mr6221912wrm.76.1548180469567;
        Tue, 22 Jan 2019 10:07:49 -0800 (PST)
Received: from Sarah.lan (229.98.125.91.dyn.plus.net. [91.125.98.229])
        by smtp.gmail.com with ESMTPSA id 129sm93804220wmd.18.2019.01.22.10.07.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 10:07:48 -0800 (PST)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     afaerber@suse.de
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        linux-lpwan@lists.infradead.org, robh@kernel.org,
        Ben Whitten <ben.whitten@lairdtech.com>
Subject: [PATCH v2 lora-next 0/4] net: lora: Add documentation for SX130x and SX125x parts
Date:   Tue, 22 Jan 2019 18:07:25 +0000
Message-Id: <20190122180729.1834-1-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds documentation for the SX130x and SX125x chips.
We are using the yaml binding format and this series builds with
'make dt_binding_check'.

Thanks,
Ben Whitten

Ben Whitten (4):
  dt-bindings: lora: sx130x: add basic documentation
  dt-bindings: lora: sx125x: add basic documentation
  dt-bindings: lora: sx125x: add clock bindings
  dt-bindings: lora: sx130x: add clock bindings

 .../bindings/net/lora/semtech,sx125x.yaml     |  72 ++++++++++
 .../bindings/net/lora/semtech,sx130x.yaml     | 133 ++++++++++++++++++
 2 files changed, 205 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/lora/semtech,sx125x.yaml
 create mode 100644 Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml

-- 
2.17.1

