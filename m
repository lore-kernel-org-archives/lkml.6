Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CA4ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C280F2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKmoLM7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C280F2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733099AbeIXXb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:31:27 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55070 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731112AbeIXXb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:31:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id c14-v6so10569585wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 10:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vj5VqA2W2+hI6VJv2mKddEJ6rEF/4aE/EnvQDnAU2Fw=;
        b=EKmoLM7MKwSbrY66l80ju9bXu6sRbup9fGkD9/p2qb1hQrJ+vN7fvcFrtVUy1OlFzG
         4wx9UgXcMsPXP10p7l0opN3ijUEZff3K0jMJFsS+UHNHZmewfiTJZVBhK+KmACeZR8GO
         4rFkD8Go079uJdNXVwUPH+Q3QNTjEXGjz/3fqWuHTVGp2/nVZML10e/i8NHv+gjUESON
         lGS1/Qc67pVtpNvmVQ8jakKkWELE1lRy/J1sjcQoYsZI6Le5jSinvU89MnFeihFagm0f
         sryesvzKo2HaUl1bQKD5aw11FAJZBAvuI5IUUInCzzbOeQoZt7xcVPZScgPBphL/I2j4
         l9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vj5VqA2W2+hI6VJv2mKddEJ6rEF/4aE/EnvQDnAU2Fw=;
        b=R8DcNIKCjstFuU69GSufwGP67hrrd/aGM+yAQtgiLG/ixSto+KwdRX5GvwF1+fI5t4
         cei5sqzRq0ypvKt2jen+33Kj7s6v1SsaoTsePd48Opbi7/Y0uSowrBmG/WzCMfVluwE7
         J9QPJ7sKBjACNwgSmVoyJhDYuQ/IFxmPEM8oHO1mlxmzAwjf+iUQMmxTBTUgmEC/bSKh
         mICFh5U7S/asKEdA7HJySVGpunD+pwMbj+jP1G1zd7WHODRzwO4+2RIqPjfW3w89ZNhN
         8U2imCFY8bzld0ERQKgRcoABfAILgw6WkfMIWgVKyFmefD8uylCj7egdiufPnLGFO46b
         AhFQ==
X-Gm-Message-State: ABuFfojQqOCDRDG8nOfvSHX3eZm1yNIu0jkskwYT4d7prd+ndVfBx49e
        ikcpAaz4ExzvBn5nBvuNlnw=
X-Google-Smtp-Source: ACcGV60UHyyeE0V+jYOooyaE5ZiJR6tIuQ4tH6Cn5yFgTcePRMl+XxRuSbORHXxCNITicSuV7qjepA==
X-Received: by 2002:a1c:9816:: with SMTP id a22-v6mr2799148wme.54.1537810092811;
        Mon, 24 Sep 2018 10:28:12 -0700 (PDT)
Received: from localhost.co.uk ([2a01:388:3ce:110::1:c])
        by smtp.gmail.com with ESMTPSA id y206-v6sm15998258wmg.14.2018.09.24.10.28.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 10:28:12 -0700 (PDT)
From:   Aymen Qader <qader.aymen@gmail.com>
Cc:     Aymen Qader <qader.aymen@gmail.com>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] staging: vc04_services: Fix checkpatch.pl errors
Date:   Mon, 24 Sep 2018 18:27:39 +0100
Message-Id: <20180924172743.21153-1-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180923140620.14583-1-qader.aymen@gmail.com>
References: <20180923140620.14583-1-qader.aymen@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes the following checkpatch.pl errors in the
interface/vchi directory:

ERROR: space prohibited after/before that open/closed parenthesis
ERROR: code indent should use tabs where possible
ERROR: space required after that ','
ERROR: Macros with complex values should be enclosed in parentheses
ERROR: "foo * bar" should be "foo* bar"

Aymen Qader (4):
  staging: vc04_services: Fix "space prohibited"
  staging: vc04_services: Use tabs instead of spaces
  staging: vc04_services: Remove unused macros
  staging: vc04_services: Remove spaces after '*'

 .../vc04_services/interface/vchi/vchi.h       | 208 +++++++-----------
 .../vc04_services/interface/vchi/vchi_cfg.h   |   2 +-
 2 files changed, 86 insertions(+), 124 deletions(-)

-- 
2.17.1

