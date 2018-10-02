Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E042FC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 18:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF7E2082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 18:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHDgDkFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF7E2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeJCBYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 21:24:05 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:37269 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbeJCBYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 21:24:05 -0400
Received: by mail-wm1-f44.google.com with SMTP id 185-v6so3199996wmt.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 11:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=TuZRn11hrjvIKxv/2NbTFkClOg4u6Fk9KPY6HfAOP54=;
        b=tHDgDkFYrCghQajruAxmzSRJZrYiqclhPkpLGgBHizxmPuuol8MQtDKu3Gkl69jEn5
         4HcA2L+AqFgWJe2fCyXYj5RADlFJ/pjws2z4Hqy+bpjzUuIvlulYmLlFtymO2m+sQ7CS
         XU4flu8LKnekkUQ8o6gLhNkYut3yCsA5O8RJjvsXCByGINUx1M+UvjxzCkRsWbjTXaG3
         lyyAqK2m8rN+78k0HSFAa6Q15fl0ZG+S5d5NBMbcysPv9om4wRkSdRxMcdpek2MR8jM3
         vgNH0rySTfqh+2Xu1cUwr20wUNemJIxVWtmLDg2GthVOXbsVUIMYFxldZpCNLPLGSrEl
         lI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=TuZRn11hrjvIKxv/2NbTFkClOg4u6Fk9KPY6HfAOP54=;
        b=F8PnSCqaaHGWduaOsoliCLmNngMdqLS11qNWYlsX7CKA3q8tf+qQYKw+Z4NjmGIiEc
         TAHj6UcLo5Q6u8YQpftZKtwp5E11FzPWwNPBLQZ1gzTOVKoNuBQTGqsEnmqTLpa7m4+p
         OwOWuQLIanR9loh+Wp00xKxkPjqtuFw5Qe2NLVlnwKa2i9BCQ/ethYPTi4enbGrtFgXQ
         0Mnoq7H3AGaRhuJjRWLFH9iX7sStNAR5nW0FcUIXXfzsTbWtE0BtM6rxttEYwTpGxIE/
         GmwrShvy6b3+tXoENVuzpRwDg9GAfBqz+IOau2V+qgrok/DbXbcbuJKkhjXEUP82bCJA
         9XGA==
X-Gm-Message-State: ABuFfojRMOm0147CLKAssZsnuIbaWK61lTmSA1RFLPRQTT6h/h6UjHUG
        iTIeUhQ+JgBsFVPeXMGd9M0=
X-Google-Smtp-Source: ACcGV61VeI9CWSai/6BTted3OfT+7H8JXffjoiW171VGoR/BQpI13ggSAKyfnxzFIm6hcetlUBtOtw==
X-Received: by 2002:a1c:c2c3:: with SMTP id s186-v6mr2750166wmf.16.1538505560027;
        Tue, 02 Oct 2018 11:39:20 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id y4-v6sm20689875wrd.25.2018.10.02.11.39.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 11:39:19 -0700 (PDT)
Date:   Tue, 2 Oct 2018 20:39:17 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, jmkrzyszt@gmail.com,
        rppt@linux.vnet.ibm.com, linux-sunxi@googlegroups.com
Subject: [REGRESSION] boot fail due to commit efdfeb079cc3("regulator: fixed:
 Convert to use GPIO descriptor only")
Message-ID: <20181002183917.GA6824@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

The following boards fails to boot due to commit efdfeb079cc3("regulator: fixed: Convert to use GPIO descriptor only")
- sun8i-h3-libretech-all-h3-cc
- sun50i-h5-libretech-all-h3-cc

reverting the commit mades them booting again.
You could see two example of the boot failure log here:
https://storage.kernelci.org/next/master/next-20181002/arm/sunxi_defconfig/lab-baylibre/boot-sun8i-h3-libretech-all-h3-cc.html
https://storage.kernelci.org/next/master/next-20181002/arm64/defconfig+CONFIG_RANDOMIZE_BASE=y/lab-baylibre/boot-sun50i-h5-libretech-all-h3-cc.html

Regards
