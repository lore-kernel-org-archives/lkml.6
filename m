Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CFAD1C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB92208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB92208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756141AbeFOLpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 07:45:46 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:38969 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755827AbeFOLpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 07:45:44 -0400
Received: from stefan-Vostro-260.fritz.box ([109.104.43.150]) by
 mrelayeu.kundenserver.de (mreue003 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0McRqW-1flSXw2Xia-00HeIf; Fri, 15 Jun 2018 13:45:36 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFC 0/2] regulator: pfuze100: add pfuze3001 support
Date:   Fri, 15 Jun 2018 13:44:51 +0200
Message-Id: <1529063093-19582-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:EQltFlYywRsCBgca47m4RiGJUlYOzszXYVnldk3fya9sD7lEzAT
 hql+cS+ybcHyTSCO4zvo54MuJHGPmMf+oz5poXD2ZQyHYTsG/mZXN4X7X7POayt3IzvHjbe
 5II8k/GAC+2GPzCrZLk/p5z0/s3qlC0KV5/HCauYavmD2xD6VRtRA8Jw5K0GKZ3+3kSJ3Wk
 n7zww3q2qPi7R5CmVmS4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IaiHdTIHwFk=:rskl1B0PWawVTms/JNKYP5
 WIhQG8a2ovsIzh7faFpz4tKBvrELy3dWk+xSknp4ds+OuxjRidD+DneI+RJs7wLNFgtqQB2XJ
 917bEmw2BF3TOLcrzc9svyE4I3jAalYN8mgDgVvhzBG3e4CEIQjbHLkB8tmg9DcN9GmGrQSyv
 HPT9Mzu+Ld9UsF3DqqCe7jfnN5viyGrJjJDWGilvfOy39V0EiJQA2+KUzk0LwZESDXjtcT742
 0dwBUNOlDhs/XqEab1H+abFXwJ0t2WJTcpMKynzuEOF3pYBxyCkbR9vJZEhI4sYluvPGCBynn
 AQoPSwmk98mwjfnmA50oCA0Bgh3H4O/acpagYmQoJKQm8vInLnOz2rlt1rJS8lk1yAgmp/1M4
 EIcgV9SMVNhv5j+ZLln5G3gdmq7M9Jw1x/wqJOyXIdGW94GON2wCxJkTCUuYU8Y3SvIJeCOGs
 8fZAC3Rw6ityMBTdGxDsu3seu39Tg6qHCKZd9vHzF/Nu6oA23dwWG73JttNtKZFF+fA9sywsL
 r/8hnoTpFGm6WvQlvXz9hA3LGqgo4IhrLMkSxhKEsMyG1Quzq0iylw3Rz/WVt1GU5ZeVUDcL5
 cWdh9mjg0PiRy9F/em/SReNIFPZKQoSCYU/XbeqmNPtLud8AX1Qw+QDLO5GQzYqlelrvWNXWx
 KvKWosebxcmFg4Q8oYcx5eREYKYKIFikfMxfwPEY/4QAakUIgYaWAsewvRCujePrY/+8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the NXP PMIC PF3001. This
based mostly on the patches by Robin Gong and Mauro Salvini from
here [1].

[1] - https://community.nxp.com/docs/DOC-331899

Stefan Wahren (2):
  dt-bindings: pfuze100: add pfuze3001 support
  regulator: pfuze100: add pfuze3001 support

 .../devicetree/bindings/regulator/pfuze100.txt     | 77 ++++++++++++++++++++-
 drivers/regulator/Kconfig                          |  4 +-
 drivers/regulator/pfuze100-regulator.c             | 78 ++++++++++++++++++++--
 include/linux/regulator/pfuze100.h                 | 11 +++
 4 files changed, 160 insertions(+), 10 deletions(-)

-- 
2.7.4

