Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AE1C6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 03:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248F020835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 03:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vCmx2J3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248F020835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbeJNLbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 07:31:06 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:45806 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeJNLbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 07:31:06 -0400
Received: by mail-qt1-f179.google.com with SMTP id e10-v6so18032407qtq.12;
        Sat, 13 Oct 2018 20:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=vhPUPs/et+RNZ/lE9VieSnMOpnMV0Vr+3u6KHjn1Rp4=;
        b=vCmx2J3WaQjMRTTVz1jnP7Xxh8LEee7cSUlyq5eB6ElkKvIlBm7057bK9YjtCJXZUY
         v3k09QotugDGKPtHMf5hH2/Ks016umivdWNAhgx6fLYIr8Un3FJ41krS18/aOV1XU56f
         zGvvrlayZIbq/aNs1nNwS744d58UPnifjlUxC5V8knb+K0H0OBdow6PurNVbcZ1gbq/x
         RzF5u+cjuETFvG0ohk93GSGGrC4P7DXDYX1d5DCquMZ0Cz5Kn9FeX7B5cGQwfFuXbeTt
         emAdmM0/kjAlWDM+7QI9QU9mnKFOb4+OgjAK96eJPb/gzfygTPtFmkorYNcpaHrdlye1
         qulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vhPUPs/et+RNZ/lE9VieSnMOpnMV0Vr+3u6KHjn1Rp4=;
        b=QZ40mMhNPUXMgamad1AvlwStlpqGdCf1DaaE7PFrmWRex5D5bMhdJsRmzGhbRJBCCM
         zxNS26kJbpyJassIEhDmyaLtJ/DBm1AkSy0ewIpyLXCjS7raldDiLVar6xX8es+c2b1P
         qH8w0TOIY+9rTL33CVoe70UkksTb3yw5kLTZXIqMSiPHZDsMxZjj1QpgJOVX5FwBflIu
         PPXgc24oyJ9gai35bwcv2laHdrf8z13ufMG8tj9U/xgQh01TvbghpjRnYlU5pI3plenF
         w1m/BohiN4Wc4SxzkwWi5PpYt2tXHq+KN+7BNnapkwdH+Jhk+U+R3ydjO6/Tu/2HILiQ
         tv7g==
X-Gm-Message-State: ABuFfogkOUdtqzXH+ECW5+fg5UdwuUMns/6ehFd+YHyYBmOccSYFN343
        kJjxfJzddWSfD7Yn36woFGXmqDKDbNtHuKpsNtkDlQ==
X-Google-Smtp-Source: ACcGV61dRavwVpIj7t6BS9yOA5HaQbquGqtunxG3T6V50B+1zUB1pQs2tamCOEQmamanAf0q9G5H198xKMig9EKDRFs=
X-Received: by 2002:a0c:d095:: with SMTP id z21-v6mr11774373qvg.35.1539489094330;
 Sat, 13 Oct 2018 20:51:34 -0700 (PDT)
MIME-Version: 1.0
From:   salil GK <gksalil@gmail.com>
Date:   Sun, 14 Oct 2018 09:21:23 +0530
Message-ID: <CAPACB-xT8fb4kTn_J0NMSR3bM6h-b_K99QKF5cySsTWqeRFz0A@mail.gmail.com>
Subject: What is the expected date of release for 4.19
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

   I would like to know the expected date of release of 4.19 kernel.

Thanks
~S
