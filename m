Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A413C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9E72086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiFiOl/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC9E72086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbeKQBm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 20:42:57 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37232 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbeKQBm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 20:42:57 -0500
Received: by mail-ed1-f66.google.com with SMTP id h15so15200389edb.4;
        Fri, 16 Nov 2018 07:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/4ok8kpo9bvLExSn3nIjKugopA68A76n4+CUS6j0knw=;
        b=GiFiOl/pDuKTMg56WpGhtqZeItRH04HdxoUUp4Yr/GyzbXTOZwAT9Ezmldtqznehre
         X6nlM0bKMkpo+5lEqOvW3GORIYf8bjbpkmonMLLHcZ9wvVYyqo6YkzSF8I6kHVF3FNp1
         FCab7nYX4q7XQnO7nzQwoDsJLFQoLtk5uZdarGIc+hsicL3BtMY/kcRRebJVRZ7BEdtV
         hMJxwXvSNYmFrY1mZQ3ptZO/CmVn6T3SBPC2iB34Ry2YYDn8xlzioCrjcu0ZYOAzMeAD
         rmgUccK2KtT1BBmsgPZQQU1aW6znw3C7WZCWiRLx1Y48vR0mdStXc2yS8NEnJ3LJAUSs
         jWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/4ok8kpo9bvLExSn3nIjKugopA68A76n4+CUS6j0knw=;
        b=i/bjmY2R04wt+E5fhoKuUSGS/H/VErqJofTTylNRNtC3grY9hruwm8LnHapLLuZ+t8
         N8xfyNKATbhpoq5CCi2Rr3poEkOfkJMdes1R98mS2L8/aQ0FBV7id5dLFFVgikyjK0lY
         XHtNA/dswmunLSdpFPtO2vXzD+KA1aQPQCuI3hG44hqsMCObLQGUQJ8hRwBSu72MHzvv
         7n6tJtUyGlpTrUi92aFrW/aU56XVObXqRlVs019Ay1Oir2ITQhn6HeVL2DTH0MTWJKeE
         /DnjDBanyScMQyJ0y5MB4R9Rc4JPsLSa7LUJUgkvHyUHaMyKRbQtCCTb8hUJYkFaPvad
         XLGA==
X-Gm-Message-State: AGRZ1gKpJ/ara/NSXNvQgj05S4RF4nCJgF0BM54fUBf2ih+v2B066PEg
        T/mQlJ9M+1t6/FIBebuk6HENlPHD
X-Google-Smtp-Source: AJdET5eOKz2G7Fj3aHm21nGm24t9TKLHJBTMIhOjyvjYrT3KIzvbhdxuXh0pKnkm6HDwHzjGY8taBQ==
X-Received: by 2002:a50:ce52:: with SMTP id k18-v6mr9623870edj.207.1542382206114;
        Fri, 16 Nov 2018 07:30:06 -0800 (PST)
Received: from dell.be.48ers.dk (d51A5BC31.access.telenet.be. [81.165.188.49])
        by smtp.gmail.com with ESMTPSA id br3-v6sm4950381ejb.24.2018.11.16.07.30.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 07:30:05 -0800 (PST)
Received: from peko by dell.be.48ers.dk with local (Exim 4.89)
        (envelope-from <peter@korsgaard.com>)
        id 1gNg4K-0006CK-EX; Fri, 16 Nov 2018 16:30:04 +0100
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND v2 2/2] arm64: dts: meson: add libretech aml-s805x-ac board
References: <20181116151539.18501-1-jbrunet@baylibre.com>
        <20181116151539.18501-3-jbrunet@baylibre.com>
Date:   Fri, 16 Nov 2018 16:30:04 +0100
In-Reply-To: <20181116151539.18501-3-jbrunet@baylibre.com> (Jerome Brunet's
        message of "Fri, 16 Nov 2018 16:15:39 +0100")
Message-ID: <87y39trqf7.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jerome" == Jerome Brunet <jbrunet@baylibre.com> writes:

 > From: Neil Armstrong <narmstrong@baylibre.com>
 > Add Libretech aml-s805x-ac board (aka 'La Frite') support

 > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
 > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Reviewed-by: Peter Korsgaard <peter@korsgaard.com>

-- 
Bye, Peter Korsgaard
