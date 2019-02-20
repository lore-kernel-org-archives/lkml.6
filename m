Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4756AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B772146F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="T8s3nbVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbfBTC4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 21:56:20 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40411 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbfBTC4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 21:56:20 -0500
Received: by mail-qk1-f195.google.com with SMTP id h28so1049545qkk.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 18:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=deF44qJAjt86taJ+l8eSByWPczeRp7xn7q+1O9KUzSQ=;
        b=T8s3nbVWS3/FtULm20rUAV7+eGLgyVFqEVSeklcHCzRvRWXuIfJWew2OgGcGkdq/hy
         bnlXMfwKqSI9rnQAVvG9CH0CNM/z0/oX+Zrwl2mp3e882qLcF5NmN5eozdmO19PQ9QjJ
         rDaJ5vUmF6TLaYlh+iJsBOROi9BcnH3K3h6OSAEZnjvCkfra8S4Pjr7DkrmqXN83KTAk
         q+cuQqDY5OFS1NlpkYgN7HkoRIOZw65B3FGKZNLPKx+2zeobaqNGngSyqOeUaIKGQuze
         gt8oQ+vwRBYdPIEZvipESvQc+Ekb69O90ERrburHFCrnVbQrtvCEcS0h8tCydoOsfUM2
         p1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=deF44qJAjt86taJ+l8eSByWPczeRp7xn7q+1O9KUzSQ=;
        b=V+au1C9RHjCX8sQOykbbN/vS/qlx8pwgQog8mv82X7syFL8qPyFAeEgWQ5TdzKEaQ9
         D9o8b4zaFHNOZJCp40GpedqfFb6+mRyDqJz3dxtqFNJADbdJrVkvBhB0Od/f/DPm7We/
         MD4nXq3vm+DFDjmcnsOlJX0NOOhyK7LyHEUav0IIwkNG49hJVYYSSJaD+XJWbmUhwrGZ
         pIrZ7dMK6PcYylIUff8I4RRXV9cYc5IcytFnDkrQDDPoZfvS+zJDFponlz2J+OSKTUSx
         rMUxdrJ3Hyw2VvEx5pdRtZvLGvBz8b89aXYhYEPQGcxR4b+2eInZMO0Zg0gBOz1jNJv3
         xlww==
X-Gm-Message-State: AHQUAuYTLj/ZCG+LenYovPalSIh+dB0dT8SPMXfX2yu7BQomHNLFcgAy
        QCkkbeBqgvBA3cAkf7u/C+eLtw==
X-Google-Smtp-Source: AHgI3IaHf/BW5M9wACPEWrqjWT408NmIQiX6K+CXwty0UPorokqEuQ1NSKJVaW6jfC58buSeBQKh4A==
X-Received: by 2002:ae9:dd04:: with SMTP id r4mr16518515qkf.187.1550631378784;
        Tue, 19 Feb 2019 18:56:18 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id a68sm3977405qkj.82.2019.02.19.18.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 18:56:18 -0800 (PST)
Date:   Tue, 19 Feb 2019 18:56:10 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>, Jiri Pirko <jiri@resnulli.us>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next v3 10/21] ethtool: provide string sets with
 GET_STRSET request
Message-ID: <20190219185610.4c6aa82a@cakuba.netronome.com>
In-Reply-To: <abfb63ea613f295a68a77f8ffba202d198c38fe1.1550513384.git.mkubecek@suse.cz>
References: <cover.1550513384.git.mkubecek@suse.cz>
        <abfb63ea613f295a68a77f8ffba202d198c38fe1.1550513384.git.mkubecek@suse.cz>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2019 19:22:14 +0100 (CET), Michal Kubecek wrote:
> Requests a contents of one or more string sets, i.e. indexed arrays of
> strings; this information is provided by ETHTOOL_GSSET_INFO and
> ETHTOOL_GSTRINGS commands of ioctl interface. There are three types of
> requests:
> 
>   - no NLM_F_DUMP, no device: get "global" stringsets
>   - no NLM_F_DUMP, with device: get string sets related to the device
>   - NLM_F_DUMP, no device: get device related string sets for all devices
> 
> It's possible to request all string sets of given type or only specific
> sets. With ETHA_STRSET_COUNTS flag, only set sizes (number of strings) are
> returned.

> +GET_STRSET
> +----------
> +
> +Requests contents of a string set as provided by ioctl commands
> +ETHTOOL_GSSET_INFO and ETHTOOL_GSTRINGS. String sets are not user writeable so
> +that the corresponding SET_STRSET message is only used in kernel replies.
> +There are two types of string sets: global (independent of a device, e.g.
> +device feature names) and device specific (e.g. device private flags).
> +
> +Request contents:
> +
> +    ETHA_STRSET_DEV		(nested)	device identification
> +    ETHA_STRSET_COUNTS		(flag)		request only string counts
> +    ETHA_STRSET_STRINGSET	(nested)	string set to request
> +        ETHA_STRINGSET_ID		(u32)		set id
> +
> +Kernel response contents:
> +
> +    ETHA_STRSET_DEV		(nested)	device identification
> +    ETHA_STRSET_STRINGSET	(nested)	string set to request

Is it common to put the device information outside of the main
attribute nest?

> +        ETHA_STRINGSET_ID		(u32)		set id
> +        ETHA_STRINGSET_COUNT		(u32)		number of strings
> +        ETHA_STRINGSET_STRINGS		(nested)	array of strings
> +            ETHA_STRING_INDEX			(u32)		string index
> +            ETHA_STRING_VALUE			(string)	string value
> +
> +ETHA_STRSET_DEV, if present, identifies the device to request device specific
> +string sets for. Depending on its presence a and NLM_F_DUMP flag, there are
> +three type of GET_STRSET requests:
> +
> + - no NLM_F_DUMP, no device: get "global" stringsets
> + - no NLM_F_DUMP, with device: get string sets related to the device
> + - NLM_F_DUMP, no device: get device related string sets for all devices
> +
> +If there is no ETHA_STRSET_STRINGSET attribute, all string sets of requested
> +type are returned, otherwise only those specified in the request. Flag
> +ETHA_STRSET_COUNTS tells kernel to only return string counts of the sets, not
> +the actual strings.
> +
> +

> +static int get_strset_id(const struct nlattr *nest, u32 *val,
> +			 struct genl_info *info)
> +{
> +	struct nlattr *tb[ETHA_STRINGSET_MAX + 1];
> +	int ret;
> +
> +	ret = nla_parse_nested(tb, ETHA_STRINGSET_MAX, nest, stringset_policy,
> +			       info ? info->extack : NULL);

Would it make sense to use strict parsing everywhere from the start?
You seem to add REJECTS, but won't attributes > max get ignored?

> +	if (ret < 0)
> +		return ret;
> +	if (!tb[ETHA_STRINGSET_ID])
> +		return -EINVAL;
> +
> +	*val = nla_get_u32(tb[ETHA_STRINGSET_ID]);
> +	return 0;
> +}
> +
> +static int parse_strset(struct common_req_info *req_info, struct sk_buff *skb,
> +			struct genl_info *info, const struct nlmsghdr *nlhdr)
> +{
> +	struct strset_data *data =
> +		container_of(req_info, struct strset_data, reqinfo_base);
> +	struct nlattr *attr;
> +	int rem, ret;
> +
> +	ret = nlmsg_validate(nlhdr, GENL_HDRLEN, ETHA_STRSET_MAX,
> +			     get_strset_policy, info ? info->extack : NULL);
> +	if (ret < 0)
> +		return ret;

