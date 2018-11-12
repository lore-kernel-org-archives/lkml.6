Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBFAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCA322503
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kmXb/r+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FCA322503
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbeKMDEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 22:04:30 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32882 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbeKMDEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 22:04:30 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so1709094pgu.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 09:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ej2zWVNDkKDNwVA+EVbiOGWXtvZFOLaPlACrw1hHV7k=;
        b=kmXb/r+TPkHme/w723MEjEX1OmHpW0Rzgx7MIqmYbImnpm7bgEJJFyKtMTgh+aQVte
         agicwsN632siixG/62KiWdGhoU46apMOF1brZjdXFJo2mgEK9HrjoOb55+V8JJPKQmj0
         ti08t693wG1g4M5YwSIPIqIQXBzq19GG4j+OuLtRXOqn8/2oFn6SXOcXh7HdYqVFD6bE
         AdtKnoNSsJQvNP62bXDvoSRh+lDcqpKt+ZzoR9M/j+dq5gnYH3mDLtkgblIsxSZnPV2u
         V6hUZaKHXLAgEDKbb2CvJvv2WW+Ae9xaNC5/NUMBNMzk9qsdXXHHfZZeVRzZ5WfOyAeP
         9QrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ej2zWVNDkKDNwVA+EVbiOGWXtvZFOLaPlACrw1hHV7k=;
        b=AC86VS2LTVlmIFq81GDbE/SMsb8EGtodLl3/D5js0+KaNC0Vx2OSA12b9QC9W/Ltoh
         PQitud9ok3tS42Kor2AbP7vMTxEIDyewINs0WZqx8r/mY+4cKCocFvx9oqjnIPvPXyVL
         b84sLTfqPbdK7eUP3Mn995tw/+kO6Bacx7l+Q6Yb/tallp9o+0QOXaPmTxpmuTZeX9y7
         iRUCtAGrfpgQolZOEtMwtEy3sJKs5cAN/vn8hX065n36Am+oDmUi6sODamh44OQO/TBZ
         wXT5wbHEI2aJcafvr6ihCacYu8shVxSLrl0Gj4oNgS5pJXd69PLnjU/YYnK5NwcBXZ5e
         74Uw==
X-Gm-Message-State: AGRZ1gLwHMLD99iYJvYBlaW2n5eI+pUSSoIQ3raGz3SxSV0l/CLnBLaX
        mNMrQiODF4JSWcz6kLZp1QnQPARp3bA=
X-Google-Smtp-Source: AJdET5fNMpBXSVwTARCXCIhhgisnHkPzwszZOFeYF6eVG46zcK2imqa2HIyMDB12ukhRBLBV8biyIg==
X-Received: by 2002:a62:3a82:: with SMTP id v2mr1661841pfj.174.1542042620858;
        Mon, 12 Nov 2018 09:10:20 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u82-v6sm204925pfj.131.2018.11.12.09.10.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 09:10:19 -0800 (PST)
Subject: Re: [PATCH V5 1/6] blk-mq: make __blk_mq_issue_directly be able to
 accept NULL cookie pointer
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1542014609-1769-1-git-send-email-jianchao.w.wang@oracle.com>
 <1542014609-1769-2-git-send-email-jianchao.w.wang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <01bd2f70-cc78-9bfd-aa30-b73c44eaa9bb@kernel.dk>
Date:   Mon, 12 Nov 2018 10:10:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542014609-1769-2-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/18 2:23 AM, Jianchao Wang wrote:
> Make __blk_mq_issue_directly be able to accept a NULL cookie pointer
> and remove the dummy unused_cookie in blk_mq_request_issue_directly.

What's the reasoning behind this? Seems faster to store the cookie
always, instead of introducing a branch to the hot path.

-- 
Jens Axboe

