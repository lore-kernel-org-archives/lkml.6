Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A43C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581E820811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZNWOvGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581E820811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbeLLAzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:55:36 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:54384 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeLLAzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 19:55:35 -0500
Received: by mail-it1-f195.google.com with SMTP id i145so6568369ita.4;
        Tue, 11 Dec 2018 16:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ckc7BYm/A/FyrDEIxKSqpTf6zyRuN3t8fKrLuJigIBI=;
        b=oZNWOvGELdH8/WuhZ3i486vMy1B7IfuMQx3mFVydNW8Q8zRR8w5pqnzzJ7O85t15dO
         EXqKx/OapKnSD3UBqfIW5yQUQTM/OizXinmuXHR+aE2NH09LnmsfA6bHj9ZSdYOzWfBF
         AtZxrDOJzTHUt9WjHx4Rruimgb/j5TQJgZEwhjnPfs6dpSVP1TscyBIy1FWbX8ZE4S2m
         Y8uasGHySRyd3I7f8hV8l/Zm4jINzuYUoV2fkFBzpiIcNWMMeTpytQXF1gA8OOhnZACz
         cXLxsoNFChDWh2HddCkKS1P/pEQ9gWynT/QOkLQKihWC8XO/YO3TdL8IomNYLfoXLcQj
         m4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ckc7BYm/A/FyrDEIxKSqpTf6zyRuN3t8fKrLuJigIBI=;
        b=BK7za0hWYyUmTV1pNXnoQ/WY/LglQQQt60ziOr2khZ3BvyJu5Sk/8Oi0U64jrCEi43
         yBqLYnxeqwptZkP+JQcwyzw31Na2metQMrkLKHdo3KYJN8UVSEfs3jOkkrt341NYLMus
         HCVGMhjyNY13ytWHlfPfYMp73miPF4j9X54p3CER+rrF7wMERyTdzob+U7jEGnbtXOfb
         zd20OxbDeB2Ul625v09Q5arYCMnEUNLxGruvO8Ff7cTD63DEdA+X3ODh8E6ci2xB95Lb
         pJAcooJO/a4i0bYziOrGBhiJInm79BGcrF4HlK2lrTBrkyjyUEMnXPOE8ZLq8nbqkbmV
         erEg==
X-Gm-Message-State: AA+aEWaIvwiGDAyKrztYsRh7E8AJkGiONNRDm5/tv2gcfr6MCw5leU2v
        U8HRZXjaswurSYsBL4wgm14=
X-Google-Smtp-Source: AFSGD/UkMcuaPS3RsTo41JumEsl5xoBoc5vrd/wf22BkgrPjUMe7a6dsD22q4z9XVOKu2XTgw7Qyew==
X-Received: by 2002:a02:4c55:: with SMTP id a82mr17746728jab.29.1544576134919;
        Tue, 11 Dec 2018 16:55:34 -0800 (PST)
Received: from r2700x.localdomain (c-75-70-96-103.hsd1.co.comcast.net. [75.70.96.103])
        by smtp.gmail.com with ESMTPSA id l186sm1952445itl.22.2018.12.11.16.55.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 16:55:34 -0800 (PST)
From:   Jeremy Fertic <jeremyfertic@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Jeremy Fertic <jeremyfertic@gmail.com>
Subject: [PATCH 00/11] staging: iio: adt7316: dac fixes
Date:   Tue, 11 Dec 2018 17:54:52 -0700
Message-Id: <20181212005503.28054-1-jeremyfertic@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some dac related fixes for adt7316. I'm testing with an adt7516
over i2c to an orange pi pc. I've attempted to test any functionality that
these patches are touching.

Jeremy Fertic (11):
  staging: iio: adt7316: fix register and bit definitions
  staging: iio: adt7316: invert the logic of the check for an ldac pin
  staging: iio: adt7316: fix dac_bits assignment
  staging: iio: adt7316: fix handling of dac high resolution option
  staging: iio: adt7316: fix the dac read calculation
  staging: iio: adt7316: fix the dac write calculation
  staging: iio: adt7316: use correct variable in DAC_internal_Vref read
  staging: iio: adt7316: allow adt751x to use internal vref for all dacs
  staging: iio: adt7316: remove dac vref buffer bypass from adt751x
  staging: iio: adt7316: change interpretation of write to dac update mode
  staging: iio: adt7316: correct spelling of ADT7316_DA_EN_VIA_DAC_LDCA

 drivers/staging/iio/addac/adt7316.c | 89 ++++++++++++++---------------
 1 file changed, 43 insertions(+), 46 deletions(-)

-- 
2.19.1

