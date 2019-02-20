Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B241BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7065C21773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Llk5tyc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbfBTC2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 21:28:11 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43066 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfBTC2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 21:28:10 -0500
Received: by mail-qt1-f196.google.com with SMTP id y4so25658038qtc.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 18:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=WjA6FPPMzuddTL3efvTcfL0GfcJxPYSY+upQUeouhQg=;
        b=Llk5tyc0vDgOETbv1OKN48hQwpk8NMlEz2VElPe5mylB6Fl8CLx3NQTUCi3NcwuukN
         xhmhvtyR5Y4D0Q77CHFm/NISIAKMYFza/1y5K/zZbmv/tT4tYmsQZDgvXKtU0YrJiBZ+
         ytdtuR+SsG5HySEw9FLO5om/ojuwFXRivVnk3AJfUrjfn57kYSGwR5nuX/tu79IAIlio
         MhiSmGBP7YoCzjubfxwabX/cpQQuX6MBnimtu+vsAwwD/x2BOM/AqONMTaXlds4m/Ocb
         bn0vgtoNNQcdrdtqtRvcCH2qSUtgap43HjjPl8M0ueNWh+1HuI/1o93kJBLFOvjRfF3J
         +b9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=WjA6FPPMzuddTL3efvTcfL0GfcJxPYSY+upQUeouhQg=;
        b=qLnHe3xvUV/QRHzLHC+95307nGXaWMBEQ6emEurqaWTjcfWVRyks72BgSX9x6nN/SY
         HIrIS6wRDTG+m3rYlJsUkRByHi544HV24lC5tzH50MiqAiMbJEEpdCt6Fkt+OiRm374P
         mVXIqDYOkoBIvBuqNW8sdaFXUfBrreMw1XNdPOoWGAInWSLfyC01u/CQat7/5LxQ6eI/
         b+bbDOkIBkbNXajGxXy0J8B3jmhLM5IqJHmEMXxd9GZRmBy7RqlZLgzZE7MqyHKs7doN
         RKrgHDyKFzuqiSUr/z7kG2gBvVUfQP1a/k/GCzd1Pj3KyXhiIbibM+GG+4MR39Od4+MU
         A2Fw==
X-Gm-Message-State: AHQUAubC4APS27kakdrZRRvBRl4TbxA70WF5JkxFQzvZNXny71pXHF8M
        +b5B7AeRgPf8yGFI7H5oEnz+5Q==
X-Google-Smtp-Source: AHgI3Ia3Y84XzEJp/3oJyTHG47gqFx1mvlPsWZzNVEGvLt1X5DpPHDW9TsHrNOxsSrmEPiVJYaK3dQ==
X-Received: by 2002:ac8:554d:: with SMTP id o13mr25535448qtr.105.1550629689288;
        Tue, 19 Feb 2019 18:28:09 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id o135sm9899294qka.47.2019.02.19.18.28.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 18:28:09 -0800 (PST)
Date:   Tue, 19 Feb 2019 18:27:59 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>, Jiri Pirko <jiri@resnulli.us>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next v3 05/21] ethtool: netlink bitset handling
Message-ID: <20190219182759.0abf08ae@cakuba.netronome.com>
In-Reply-To: <5f70eb8055a26f60f2282d7c1d193619a96c40a1.1550513384.git.mkubecek@suse.cz>
References: <cover.1550513384.git.mkubecek@suse.cz>
        <5f70eb8055a26f60f2282d7c1d193619a96c40a1.1550513384.git.mkubecek@suse.cz>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2019 19:21:49 +0100 (CET), Michal Kubecek wrote:
> +		else if (is_u32)
> +			bitmap_from_arr32(val, bitmap, nbits);
> +		else
> +			bitmap_copy(val, bitmap, nbits);
> +		nla_for_each_nested(bit_attr, tb[ETHA_BITSET_BITS], rem) {
> +			*err = ethnl_update_bit(val, mask, nbits, bit_attr,
> +						is_list, names, legacy, info);
> +			if (*err < 0)
> +				goto out_free;
> +		}
> +		if (bitmask)
> +			__bitmap_to_any(bitmask, mask, nbits, is_u32);
> +	} else {
> +		unsigned int change_words = DIV_ROUND_UP(change_bits, 32);
> +
> +		*err = 0;
> +		if (change_bits == 0 && tb[ETHA_BITSET_MASK])
> +			goto out_free;
> +		*err = -EINVAL;
> +		if (!tb[ETHA_BITSET_VALUE])
> +			goto out_free;

!tb[ETHA_BITSET_BITS] && !tb[ETHA_BITSET_VALUE] is already rejected
above.

> +		if (nla_len(tb[ETHA_BITSET_VALUE]) < change_words * sizeof(u32))
> +			goto out_free;
> +		if (tb[ETHA_BITSET_MASK] &&
> +		    nla_len(tb[ETHA_BITSET_MASK]) < change_words * sizeof(u32))
> +			goto out_free;
> +
> +		bitmap_from_arr32(val, nla_data(tb[ETHA_BITSET_VALUE]),
> +				  change_bits);
> +		if (tb[ETHA_BITSET_MASK])
> +			bitmap_from_arr32(mask, nla_data(tb[ETHA_BITSET_MASK]),
> +					  change_bits);
> +		else
> +			bitmap_fill(mask, nbits);
> +
> +		if (nbits < change_bits) {
> +			unsigned int idx = find_next_bit(mask, max_bits, nbits);
> +
> +			*err = -EINVAL;
> +			if (idx < max_bits)
> +				goto out_free;
> +		}
