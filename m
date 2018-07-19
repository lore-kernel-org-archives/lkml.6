Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C65C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8DA2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qE9utXiQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A8DA2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731980AbeGSQdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:33:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39010 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730521AbeGSQc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:32:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id g2-v6so4134487pgs.6;
        Thu, 19 Jul 2018 08:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vwuCZ6xPTlRJQalzosoTte9tThqGeIAnZeI/2C8NNPI=;
        b=qE9utXiQu4KbCphO1MvzTM1zVJC5Tet0YSIjFqxUvfJfyNDaho6NOeeanI1g0UbOO3
         sBCk1SenVWCgMRQL7QhfYJs7MMmO3ekAC/USdfl59NXHPBC9PjRw9hvPQdsu/Ja7VzsP
         wrOesmKzOiGPPld1cg5IFnMCFSMK60whjxTV9vmT3x7jqe3N6XD1yZrWPLOMjrTSoYq4
         xSr7uazsfo4I+3WHbivA+atTInInUnkpijVGcTNDS1neQT9RLZABJ2PDlm4Fwd7F/NjI
         6qu94DKlB59ijBdc2N5FnlTwhkFcK3/+97eQdd5feNWZ383vtA2cRlOU5QYAfNrO6PdQ
         7ASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vwuCZ6xPTlRJQalzosoTte9tThqGeIAnZeI/2C8NNPI=;
        b=dYuIHc0cOmcbXfsbJejzpk/hSCgY2rx9cbVx8KfORIPsIXRWnUnXmPMIK0nqkxvXy+
         IPSwS/OrkbxpKzyntv5P8Wm0zfLhS1ruYi3QqIWH1bUnw7Zv1LZMJMmBH6kfXh248rlI
         vYX1XFVDOP4G+kn2Fg+M2Pwg0HVTXGmYKgqMaIBHvUVG8ACO43ufhty0tSjufHjJTD7J
         9i4KutlUz+8wWwBDym2hgZolfVuDGb7qRlZIDzPFVfvLl1J58pIAasBkWzzo8RHxQiIA
         jHg8mJR9Q3jS/hBjJjqGqZTXMavNO8xmceDt7u+sD0HbQ3yoKWR/zSaZBvad5LsvnB2o
         vJOw==
X-Gm-Message-State: AOUpUlF7g+3vJap+f9+vck7FwXl8Y3WtxaayOYayv4HOUdxFDWQhIlyz
        sDj5nYUuWGDsQMgiwBs54NhySYQy
X-Google-Smtp-Source: AAOMgpcn8MFshYvYcHT7TO9VU3xWyyyNIV8V3n+cuwbdcnH8XxlKTq3t7y+4Xz7LgzqMwdZONAh2VQ==
X-Received: by 2002:a62:c288:: with SMTP id w8-v6mr10088593pfk.92.1532015352304;
        Thu, 19 Jul 2018 08:49:12 -0700 (PDT)
Received: from dsa-mb.local ([2601:282:800:fd80:41e6:c9c0:c223:a927])
        by smtp.googlemail.com with ESMTPSA id f67-v6sm15470912pfe.75.2018.07.19.08.49.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 08:49:11 -0700 (PDT)
Subject: Re: [PATCH RFC/RFT net-next 00/17] net: Convert neighbor tables to
 per-namespace
To:     Michael Richardson <mcr@sandelman.ca>, dsahern@kernel.org
Cc:     netdev@vger.kernel.org, nikita.leshchenko@oracle.com,
        roopa@cumulusnetworks.com, stephen@networkplumber.org,
        idosch@mellanox.com, jiri@mellanox.com, saeedm@mellanox.com,
        alex.aring@gmail.com, linux-wpan@vger.kernel.org,
        netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180717120651.15748-1-dsahern@kernel.org>
 <15730.1531961643@localhost>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <996fe2a0-391d-d596-dbfd-7d330e3098bf@gmail.com>
Date:   Thu, 19 Jul 2018 09:49:09 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <15730.1531961643@localhost>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/18 6:54 PM, Michael Richardson wrote:
>> Remove open use of arp_tbl and nd_tbl in favor of the new
>> ipv{4,6}_neigh_table helpers. Since the existence of the IPv6 table
>> is managed by the core networking, the IS_ENABLED checks for IPv6
>> can be removed in favor of "is the table non-NULL".
> 
> What's the advantage of changing this check? (I am ignorant)
> 

Just makes the code simpler.

The current nd_tbl is a global owned by the ipv6 code
(net/ipv6/ndisc.c). If CONFIG_IPV6 is not enabled, then nd_tbl is not
defined which leads code referencing it to use if checks like this:

#if IS_ENABLED(CONFIG_IPV6)
		if (!p->dev || (p->tbl != &nd_tbl && p->tbl != &arp_tbl))
#else
		if (!p->dev || p->tbl != &arp_tbl)
#endif

With the neigh_find_table approach the IS_ENABLED can be removed in
favor of 'if (tbl)'. If tbl is set, then ipv6 is loaded and initialized.
