Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E881C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B000820854
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RTWdadSG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B000820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeKERgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 12:36:17 -0500
Received: from mail-pl1-f171.google.com ([209.85.214.171]:46582 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeKERgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 12:36:17 -0500
Received: by mail-pl1-f171.google.com with SMTP id c13-v6so4064965plz.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 00:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=+1Y0IESqCXAUF1WYQbbMkeCClugnfAHYwxu5cLWMc9g=;
        b=RTWdadSG1e5PH2vKcq0L0taSIo6nZ8oS8AGYY6gb6lmyFgb3uuxLgBu9JCcP/VUqXV
         +xWf8+qbfP1J8l+sXc0WNCZxd2uF1DBCyc0AC+LFnnRQiZoLz9wfP2ovtjeddGFUHrYS
         zmrWdesgx+xj1II44YR5ft5oUljA35pbnAnj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=+1Y0IESqCXAUF1WYQbbMkeCClugnfAHYwxu5cLWMc9g=;
        b=bNNe5CunrOMp+9x/N8HkkTt/sDd0rWEtBcd9rz+8812gYzn506i7zdN65yW0vT8/zN
         Y126bA+gGaYa10+c+Cc/lDI8mVmtdbIQB82zHvq9DAgZ7aOD0FllwuvWuRrZ9noaOolR
         Nu+Qt3gwUT1zobwoKqhqhSE6FCDLRrIk5HBPrSfV2gt9UsjJO5Fw+5JMJmrsJ/lhanPJ
         poR6Aiy89C3TAYpPZ+fAXugZ/15TboiGro/nQM+rBR/MOK0J7LQsvjVUv4VnG3Vxadbj
         id8TXSOQgm9zxKJV273+5NwEB+hnd3Hl05JiEOXDY6je2fi01LlTB7T4azCpfkkYslon
         aavA==
X-Gm-Message-State: AGRZ1gK0V9XjgWiLDcwUQrfechH3zhQmWwICumUdlgnuAZcjaoiQWf2Y
        HoZDqXNkzfDMXaPK9J5LqEEOxw==
X-Google-Smtp-Source: AJdET5enD/tt4UAvGzwHL2lZdEawOpA/02ZfJ2sZRpS6LdLOMmsQ4Dkjli9VNexmyvieQTRI2fEi1w==
X-Received: by 2002:a17:902:5590:: with SMTP id g16-v6mr21142365pli.56.1541405868132;
        Mon, 05 Nov 2018 00:17:48 -0800 (PST)
Received: from [10.176.68.125] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id p64-v6sm43211112pfi.22.2018.11.05.00.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 00:17:47 -0800 (PST)
Subject: Re: [PATCH 0/5] Use common cordic algorithm for b43
To:     Kalle Valo <kvalo@codeaurora.org>, Priit Laes <plaes@plaes.org>
References: <cover.f21c8e62e188620d586edb3f77514e6237122c4c.1541238842.git-series.plaes@plaes.org>
 <87muqoar5i.fsf@purkki.adurom.net>
Cc:     linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com, brcm80211-dev-list@cypress.com
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <870a5f59-1031-c62d-0ee8-742bd0f16d8a@broadcom.com>
Date:   Mon, 5 Nov 2018 09:17:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <87muqoar5i.fsf@purkki.adurom.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/2018 9:02 AM, Kalle Valo wrote:
> Also I don't see MAINTAINERS entry for cordic.[c|h], that would be good
> to have as well.

We added the cordic library functions during brcm80211 staging cleanup. 
We can add it to MAINTAINERS file.

Regards,
Arend
