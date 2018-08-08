Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1719C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86228214FE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="raDXFEyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86228214FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeHHRA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:00:27 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:35489 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbeHHRA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:00:27 -0400
Received: by mail-io0-f178.google.com with SMTP id w11-v6so2018521iob.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 07:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fky1w3IiLYWpjQc1HI/NzZekrIbcoI7vSsjc4d14/Q0=;
        b=raDXFEyI5A3ZTJpl3XbEOizYOfXif0jE3tgpanG3s2WyTW1oQ/4CZbtBLuksASPd/2
         mu8W4/ld/tS0FlRJN3L3DzdOxoDMyTz3jPWnF5elV4Huu5r4qf0E+OURn2A1EMiBHhP6
         cHlLM/Jf5idwQAN1B9GYSl+JBb0neKBKvcMs5ppsFOWAVSMu6ccSG85jVA+x1LpJO5mI
         PtXWFhSR9IFviqTldNZsx2Nw4gJv+7kHe2q0N/krfAk8//hoDs3huO05TAuk53i+Fj3Y
         nL6v/Ve8E8r0kxZfilkxtIlMOZxt//azk8y2ku748RuA9ifIy4O0HdI+XPQnXopU+oXY
         +hlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fky1w3IiLYWpjQc1HI/NzZekrIbcoI7vSsjc4d14/Q0=;
        b=EDGiTWG3DuNAZYgJohcBXDdIv8WulXYC7elXsSXHXOFjvm6OsLPK/FMi8KejN3iqFq
         7MlWMU/IHVzSVNBCR3678rsvD67bqp0bdfR87eaqauN6mtel6iZPyQvxriz5IT0aEMPQ
         q3qfJ7GgghvP0Ht8Htq9aXamys6VhPK2Q6p2zyYfHRUffURUCKqgn6cQ3vGVEjPLu0nC
         V6C8l3ud9NQkvroodyTnXV0O/xEfvSJjPz8fB0/b/3g1a+NAjymnCFh0XR3WJkSRWDcE
         /Rpbrp8Zr71lddrJziiyxqOphzgCoHiI4asPZCRLf7G633B90NTkuwEGntYJBqFbxOaO
         TfwA==
X-Gm-Message-State: AOUpUlHHimLscZEaFK8i5HwoZ1wBTTfBexjY02+KBfA3NZMyMdg38VtO
        6E5iLfdl1dNdINij5oJnyG8vMQxISEk=
X-Google-Smtp-Source: AA+uWPz3FWetwSerV93OE1BPPF9AM/mPqLk5IscVSbxqaL+d7eeUpl4CWUTo162M3HV1ohTNs6J/LA==
X-Received: by 2002:a5e:cb47:: with SMTP id h7-v6mr2618594iok.178.1533739229062;
        Wed, 08 Aug 2018 07:40:29 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id b195-v6sm2768675itc.42.2018.08.08.07.40.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 07:40:27 -0700 (PDT)
Subject: Re: [PATCH V2] blk-mq: count the hctx as active before allocate tag
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     tom.leiming@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1533722212-20327-1-git-send-email-jianchao.w.wang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <faf3e267-b6e6-7a44-2c14-91fd9bf63371@kernel.dk>
Date:   Wed, 8 Aug 2018 08:40:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1533722212-20327-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/18 3:56 AM, Jianchao Wang wrote:
> Currently, we count the hctx as active after allocate driver tag
> successfully. The other shared-tags users could exhaust the driver
> tags and starve a non-active and waiting-tag hctx. Count the hctx as
> active before try to allocate driver tag to fix this.

Patch looks good, but please add some comments along the way.

-- 
Jens Axboe

