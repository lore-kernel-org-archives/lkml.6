Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD28C63685
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97BC921550
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 16:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="i6BYxQCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97BC921550
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbeIMV2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:28:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37551 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbeIMV2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:28:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id 2-v6so2980596pgo.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 09:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=bahVOE+68eBpR69ckES52C2LevujJX7lB5ydpMD/nOQ=;
        b=i6BYxQCstB25LDa0AYSZAtPtlrJIZfQbBcFqwpf5toPX0m0Ij5YLyWjyiYJNiZjWGG
         NP2uFnacX8LC6PMEbBnZ597geocpxGgcYoF+RBgPNU/v4u78G04rcOPIQHG/mwccO5+x
         Y8MIeT6znlrGMPRZgVne3Kq2PYkW4PFObZXcJ+v8sOurVFKdta5FznqBNDCnpWodkj0K
         ladQIfYuEmiCTAOXJbaco9MifR67/mNDxbh53eW+hjuvtz83mFihvVQws+Lh1SHX68RV
         4eiOfCmxB1/snXPz+SJby08qT6SMAsnJ2pOr6s+Se+FgxZ8QkJ47YKNHuOgTup58CWxS
         cz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bahVOE+68eBpR69ckES52C2LevujJX7lB5ydpMD/nOQ=;
        b=TCopazLotBmPfK6SODIDtTF2eMC/f0MD2SzYxPIM1FNSFIjgLCw1uiDhR38sLYhTa/
         URwcyAJr89bZ4uTIwEt8MAQ0qGNPLUzI9+84DLVyvABPmavws+a3RFMgRGRT4cXuKn/U
         4BEoJWDG3GKn13GuY4xNI8bzat+zMRXfkonP89Ykd4ca/RScBzRextr8jeJVxKxM299K
         9qybkpMdJ5wxJs37RwBzFDUJ/hNshc8S2DCWhozVq0a3jEqpfNX9W1jTPrnkLpAozzT0
         X3QzePlmbp0BOg4ti11Ua3iT5NDiGS5juzua65OnPzysy92QVZdG9vxUt9bMsr1XqmNn
         5ieA==
X-Gm-Message-State: APzg51A16KgT2l9D4T0AoSX9lFmJNp4eK2ovs9heuL2ayhipeIdHksKZ
        SatsLalUJRzjySsTzQKs5uFdmA==
X-Google-Smtp-Source: ANB0VdZ8OddADYKFcx3962N9chaKtfVxjVC71/mJrroECOTXx4wqQTgrUrvyZvH+T3Uq96aS5K3Y3g==
X-Received: by 2002:a62:280a:: with SMTP id o10-v6mr8127578pfo.129.1536855475948;
        Thu, 13 Sep 2018 09:17:55 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id z19-v6sm6430769pgi.33.2018.09.13.09.17.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 09:17:55 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] arm64: dts: meson: Switch simple-mfd and syscon order
Organization: BayLibre
References: <1536822747-13918-1-git-send-email-narmstrong@baylibre.com>
Date:   Thu, 13 Sep 2018 09:17:54 -0700
In-Reply-To: <1536822747-13918-1-git-send-email-narmstrong@baylibre.com> (Neil
        Armstrong's message of "Thu, 13 Sep 2018 09:12:27 +0200")
Message-ID: <7hzhwlv0b1.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The order between "syscon" and "simple-mfd" is important because in these
> particular cases, the node needs to be first a "simple-mfd" to expose
> it's sub-nodes, and later on a "syscon" to permit other nodes to access
> this register space through the "syscon" mechanism.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to v4.20/dt64.

> ---
> Hi Kevin,
>
> I rebased the patch on top of your v4.20/dt64 branch.
>

Thanks for the quick respin.

Kevin
