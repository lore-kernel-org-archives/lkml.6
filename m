Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13879C37122
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D538D2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dI/dNAdC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbfAUXb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 18:31:58 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34571 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfAUXb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 18:31:57 -0500
Received: by mail-wr1-f65.google.com with SMTP id j2so25399994wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 15:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aPI08MEaihjfeULPZ5oyjGN03aWV/+CSSPVINdzDOeo=;
        b=dI/dNAdCaV9tB1c7IkbiRZ5b1BDtNe8+QiiWeEFAAjr3o6ih4gnMOYDW8tuhQPJLEd
         RTjkG6pRRp+K9C3K4/2IccFV6M3Yj0VDu/thPq9UF1H9KAvSrLn5FTgJAI3z+x188NXm
         dOdki/ekaQ/6e3sj0tB9XQbsjnuKapzy8RnWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aPI08MEaihjfeULPZ5oyjGN03aWV/+CSSPVINdzDOeo=;
        b=fWIAE5YT/6kTU3umP5AVs2a+fCv7izR6enDyIxSqlaWdrMjNyxyzz6QaYZnlIi02Ml
         d/42iLvNo1T3qRii+HqElad5TdPF3JDrlLsaMsIj7VVGGxgubSxj+KnDsRN0G/7i30kd
         ND1VjwjyDDOMzzi2/EMRx+KhOryRuFtfDgtuJ+DsHV+Q63BdexbB1UTYkNv6NBI1croe
         oV0ErUzNyNvB+kwEGRw8tfQmOodkT7K6aXPABv5IFbYqIRblV7cd/UOtGf+v3WVj02cz
         uUCKPaD7jmSrofcPLytxTu4b+465853TjwKVzYUkkOq51BLN5xAK5tsVZdBU+z4MBZe7
         wO/g==
X-Gm-Message-State: AJcUukfROhhiUlaMdLOE314q+q8j+yv8RFJghLgwWE5OpdNgwkz+ks3B
        vcY1C2GrtT1VF+py5Yd65ETkg5V5Nag=
X-Google-Smtp-Source: ALg8bN5dJkf647UgKNjze3wPF0GGokWGMJTrGMGdwYCtSZYYbnAZ6jbYx7PbVSDoIrX03ebaMr6GwA==
X-Received: by 2002:adf:b3c3:: with SMTP id x3mr30201825wrd.294.1548113515503;
        Mon, 21 Jan 2019 15:31:55 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6815:3901:cf0e:17bd:f425:fac3])
        by smtp.gmail.com with ESMTPSA id g67sm106405967wmd.38.2019.01.21.15.31.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Jan 2019 15:31:55 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux@armlinux.org.uk, mathieu.poirier@linaro.org,
        Mike Leach <mike.leach@linaro.org>
Subject: [RESEND PATCH v3 0/2] Update AMBA driver for enhanced component ID spec.
Date:   Mon, 21 Jan 2019 23:31:49 +0000
Message-Id: <20190121233151.13363-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latest ARM CoreSight specification updates the component identification
requirements for all components attached to an AMBA bus. (ARM IHI 0029E)

This specification defines bits 15:12 in the ComponentID (CID) value as the
device class. Identification requirements now depend on this class.
Class 0xF: Traditional components identified by Peripheral ID (PID) only.
Class 0x9: CoreSight components may be identified by a Universal Component
Identifier (UCI) consisting of the PID plus CoreSight DevType and DevArch
values.

Current and future ARM CoreSight IP will now use the same PID for
components on the same function - e.g. the ETM, CTI, PMU and Debug elements
associated with a core. The first core to use this UCI method is the A35,
which currently has binding entries in the ETMv4 driver.

This patchset prepares for the addition of the upcoming CTI driver, which
will need to correctly bind with A35 and future hardware, while overcoming
the limitation of binding by PID alone, which cannot now work.

The patchset updates the current AMBA Identification mechanism, which was
already differentiating between 0xF and 0x9 CIDs, to add
additional UCI compliant tests for the for the 0x9 device class.

Additional UCI structures are provided and added to the ETMv4 driver as
appropriate.

Rebased and checked against 5.0-rc2.

This is a second resend, of a set sent on 5th-Dec and 18th-Dec.

Would appreciate someone looking at this to progress the patchset.

Thanks

Mike


Mike Leach (2):
  drivers: amba: Updates to component identification for driver
    matching.
  coresight: etmv4: Update ID register table to add UCI support

 drivers/amba/bus.c                            | 45 +++++++++++++++----
 drivers/hwtracing/coresight/coresight-etm4x.c | 18 +++++++-
 include/linux/amba/bus.h                      | 32 +++++++++++++
 3 files changed, 86 insertions(+), 9 deletions(-)

-- 
2.19.1

