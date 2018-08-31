Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFC4C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09EF92083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZSODHd4R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09EF92083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeIAAjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:39:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40719 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeIAAjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:39:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id l63-v6so1442466pga.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 13:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dTUBayao88A9o/yMCZP/Wmmznn5ja6meZpaFdmlUUDU=;
        b=ZSODHd4RABKAkB+JIDMlXfa/VwzYRGqjo6Axud1Ijak9mVULFXbP6KVMZyQV9YSpMJ
         /9upmxozDLAVUi45CYzmHRQh7VuSdbhU4vDjL8aHkr/h6grrbIBy34t6e3byU+A1pZ5n
         tnNMuRWt1tDZS6xrEn9DQj6CoSiXxauqawnvcW/ueGnXdpNaVqsYIkg5dnBEF96YxaLa
         DxR+CtbGQ7WF794Xf1R+FlNH1hDqXXm0mXfNabq+z9x2vAJr1P57CwAs0lfuOF/RG54d
         UcmUxyV5uJ6QWjrMBYeUeO0eINchbRNPHanhpgINGOIdKaPn3D/tB6FcJuqWC2TWlFAA
         Knpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dTUBayao88A9o/yMCZP/Wmmznn5ja6meZpaFdmlUUDU=;
        b=YqzZW2PL0Zj/AkmG3QUe+VFnLpXqEeTbbOJ8oaGlveXV9w2gsZXnW8G/MZZ4hcEKf7
         R7DPKiOPgx0HaNx/XZj89QwUIDJ9+wFl76bOixUvvN3CAUhqXTi2Sc+2mjlwMgJKL2eI
         9vUdGyURMMJUU/r1XZm170ptmubnH/KAUj7uENRWrpy0iMqZ6G9l7N/uKTD4awTiElcv
         7QPYVqa5nIi3DsgYIUIG5+5fxyIVB4jdeWS93xNL7lXB3ZQJaHsiMIWrP0B4583j6aJ8
         HLQStx9rWv7TZkOGNSgCjWBxPA9Jn+lIYu8YEeCKFSk8YZw/I4dwxFyG7YbUcx+Qu6nE
         2Psg==
X-Gm-Message-State: APzg51AJtmY9Qjr4QcfFb2lUFIsxVxGUI3NACHwMsaXO92krDAAy4KTk
        S9dlaGRd7e1G38ph/pd1axhIfQ==
X-Google-Smtp-Source: ANB0VdY3V55fzd0IQNqiXB3XVlRd1n/gS4X89vb+t6zwDGXKXkl/hrveRO9WCplmGn78abPzZi+ohw==
X-Received: by 2002:a63:5e45:: with SMTP id s66-v6mr15887929pgb.151.1535747403210;
        Fri, 31 Aug 2018 13:30:03 -0700 (PDT)
Received: from hackmann.mtv.corp.google.com ([2620:0:1000:1601:82f7:8f1:8c08:a97a])
        by smtp.gmail.com with ESMTPSA id j27-v6sm18621325pfj.91.2018.08.31.13.30.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 13:30:02 -0700 (PDT)
Subject: Re: [PATCH] staging: android: ion: fix ION_IOC_{MAP,SHARE}
 use-after-free
To:     Greg Hackmann <ghackmann@android.com>, linux-kernel@vger.kernel.org
Cc:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, kernel-team@android.com,
        stable@vger.kernel.org
References: <20180831202250.GB30176@kroah.com>
 <20180831202738.78559-1-ghackmann@google.com>
From:   Greg Hackmann <ghackmann@google.com>
Message-ID: <4717fe98-b0af-ea32-b5bb-27d527ad8fe0@google.com>
Date:   Fri, 31 Aug 2018 13:30:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180831202738.78559-1-ghackmann@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/2018 01:27 PM, Greg Hackmann wrote:
> Change-Id: Ia0542dd8134e81cd5e1412e126545303c766f738

Sorry, please disregard the Change-Id line.  This is what I get for
forgetting to re-run checkpatch after amending my commit message.  :/
