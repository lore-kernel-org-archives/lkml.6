Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D68C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B14A20840
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="RwS3Q+ut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B14A20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeKIIeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:34:00 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:44362 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbeKIId7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 03:33:59 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D471980237;
        Fri,  9 Nov 2018 11:56:11 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1541717771;
        bh=ExT/PN9JkDT6hwZnsva5Y2QhllqZxrOcKW75pyNiaTI=;
        h=From:To:Cc:Subject:Date;
        b=RwS3Q+utAk0i0ttxzfuEIs3QLDyqU/JhNvWpKzIYFUEI0Q3mh+WrqkM8r6JqWHACV
         kecxnhiBe+2b3GIoiLjufg7YyOJn8ClIV2LWxrOIH5fS0n0WllzcwMut6Tc+WoK922
         PbltNidHO5k8r3ZNH+6UJLLhqnguX9vkgkDj/UWba+seJJPz669qRhF4l138Mjl3C3
         JD7pJoiGs3lDKeA67OCL+7ceAhsXDxGd0U9c/wZLNYb2Ld9kXCJTwoNUzow50Wj/is
         1l9PLmEA2Lz4wnShLVJqa1w6rfKLLILEVPbSBrcoXgcvFPR/aOR9poLkLCi/CNUmZ6
         CTgAsEg4czbTg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5be4bf0c0000>; Fri, 09 Nov 2018 11:56:12 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 9971413EEA1;
        Fri,  9 Nov 2018 11:56:16 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 6F59A1E0968; Fri,  9 Nov 2018 11:56:11 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@roeck-us.net, robh+dt@kernel.org, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 0/2] hwmon: (adt7475): inverted PWM output
Date:   Fri,  9 Nov 2018 11:56:05 +1300
Message-Id: <20181108225607.7521-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a hardware design that requires logic low PWM output. The adt7475
supports this but the current driver does not have any way of configuring=
=20this.
I've gone with a device-tree property as this is an artifact of the hardw=
are
design and not something that might be configured via sysfs.

Chris Packham (2):
=20 dt-bindings: hwmon: add binding documentation for adt7475
=20 hwmon: (adt7475): add support for inverting the pwm output

=20.../devicetree/bindings/hwmon/adt7475.txt     | 24 ++++++++++++++++
=20.../devicetree/bindings/trivial-devices.txt   |  4 ---
=20drivers/hwmon/adt7475.c                       | 28 +++++++++++++++++++=

=203 files changed, 52 insertions(+), 4 deletions(-)
=20create mode 100644 Documentation/devicetree/bindings/hwmon/adt7475.txt=


--=20
2.19.1
