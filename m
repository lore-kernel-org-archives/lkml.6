Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDF6C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B432150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJXZmn3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B432150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732265AbeISXiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:38:25 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43642 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeISXiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:38:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id j26-v6so3055614pfi.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 10:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1xWLJ3gwaksNkIu3cVZ0CEVpn5KiNKFZfZApEwRhgmM=;
        b=jJXZmn3yyOA2h84kPma8v+Kz+95mc7E+KYf7zG97GZmI3MHX/yRS6NhjG1zBt/e1W/
         5SbZEn8HeHdxRckTfLH9GWG6xHFewWgGq8Ka2NUhSBJGL8PeVGw+SkEY6Y8HL/+CuHE0
         vmNhrSVdcFQoWJWEb1VCT6Yv8UUIKEsl2m8VmCeDy86B6D1bY/HftaPMcg2D6XrNg4LN
         zkAfIu/zSRN82UiMi5IaRPHwh/h1L/rJZQmfAe0SDrbVWac5dl5etcj+GkxARtcPFm7c
         J8twYv9afH46zd2Ync6kfqyqCYezWrKyxA6itCcXzHLbibUM4J0xY0/JTrYVD5tzC1Kw
         xvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1xWLJ3gwaksNkIu3cVZ0CEVpn5KiNKFZfZApEwRhgmM=;
        b=LbvlFsAWD8B0i7+2p90EU9wi0nT93qDLK71yTFL0v/WwI6JPHAx2fwIQJioWIfs4cP
         u+8FsbOrOXU885jxI+4uvSccY6shMF7BqH91NbqIRkAKvuypPw5wN66iBbCbfplqMBpy
         xK6aFMpMENP+Tb33ir/KeFdCpLy07dWy1iVLcqQK6RNI1b6J4991FQAMyQ1D00LXX/X0
         mDjsgb9NSscurXekqjcMHIZqdqrgjkjnvOVI6zfqHGHokU6fN5uSLoQQFwppdiDvBveD
         xe86AgYKKTutGf6i+jwnN/nPdGOa+Jnwvx0l3S41QrYzfVQ5Yug+cqEnbkPlBP2CYSqt
         Gfxw==
X-Gm-Message-State: APzg51AUwS4mt223KIvtldLOzqXTwicVrukbammCVWDdbrs9tsAg+689
        UD6GUCz41I3Qsk1jv1sZ2ck=
X-Google-Smtp-Source: ANB0VdYNxBgL4yBAyCSgLICjjlv/hdSa0FIHiM1e/lKax0w1wHNsm337ULNC8lkR+Ksd/zHXXfyjZA==
X-Received: by 2002:a63:5261:: with SMTP id s33-v6mr33290905pgl.313.1537379961760;
        Wed, 19 Sep 2018 10:59:21 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 1-v6sm38986236pfm.145.2018.09.19.10.59.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 10:59:20 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Jon Mason <jon.mason@broadcom.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Remove self from Broadcom SoCs
Date:   Wed, 19 Sep 2018 10:59:19 -0700
Message-Id: <20180919175919.19998-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1537371100-8245-1-git-send-email-jon.mason@broadcom.com>
References: <1537371100-8245-1-git-send-email-jon.mason@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2018 11:31:40 -0400, Jon Mason <jon.mason@broadcom.com> wrote:
> I'm leaving Broadcom, and will no longer have access to hardware and
> documentation necessary to be effective in a maintainership role.
> 
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
> ---

Applied to maintainers/next, thanks!
--
Florian
