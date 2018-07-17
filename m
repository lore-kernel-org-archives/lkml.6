Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2A9ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8181720693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BCchh97A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8181720693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbeGQRI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 13:08:58 -0400
Received: from mail-pl0-f51.google.com ([209.85.160.51]:43225 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729600AbeGQRI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 13:08:58 -0400
Received: by mail-pl0-f51.google.com with SMTP id o7-v6so693721plk.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 09:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EAKO+UaQXtjMeemg1XsYhVxKuqYKWGkTVzqcLFcbomM=;
        b=BCchh97AidtteAB6IfOurfMaaIgAVYhPmVsK0kWKMLkE+qhCUkHRaiML6k3yqZ9VLn
         0ATPmOoxbxYtULYh7JIqjetH71kQR6Ine8M0rJZuoSBDV4HuxECtzuqikGqtTaZeVO0V
         7ygsOvyyInEML+UY8bYzYrbscdfeKlJoOova0Ww8XKtoLybf3AwKdQ7/XF2/JKFRjwKQ
         4xf4c+rePAf53PAkELnS+9Y3RcwWeZVGvSVWWMFQa3wb/BIlN2FH1+K/DiFqrgKzuhx3
         7RG2Lw8iZGLx7aUObEfk47pL/kiVWCTirHnTafW9G8+TsFADb5+21kJMfOB4ElOq2n77
         JYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EAKO+UaQXtjMeemg1XsYhVxKuqYKWGkTVzqcLFcbomM=;
        b=jjdHpV/MObm/nqRA+9Sl265GZufpsEEcsVycYy/G/TGyiPckGOsXqfoot6KRm1dk2q
         kWn1z10AgmZQoYTnapv1BuZvX1R06IMWc0ItzlqgSmbngxX+ylOcIRbdauBvAP/qjELz
         UTBfkbTNC2sCn8TWWgE8IWLua/QFRbOyGT0KlUM3jhp9loWHiVpAvNgq1EmvfVvML+OF
         2P+ooAXol/zgGyTzxdsbt/Txfx1POCShGDAzo6/IURC0/MCTEfIy6wU54nkD4lvL1LLf
         HJrd5LC58QMs0oTdmdwVrV0gI09WZx4xzy+aHApgiBfEgYdCGokHfS9nSA9hFEEtjWha
         qwpw==
X-Gm-Message-State: AOUpUlFd6ov2SJSYaKKtMs6IFrskMbcs07oMLiZBHMYLquF6HKwG6MMT
        lLtpwSji3GVu+bZsYVGVLZBKJA==
X-Google-Smtp-Source: AAOMgpcSxcecxID4Zmt0e7cJplZguy/YHHwp9Mbcf6BMiLh/6C/hiX9wFFbRoPU57jbBnq3Lr/NVlg==
X-Received: by 2002:a17:902:2f43:: with SMTP id s61-v6mr2281479plb.274.1531845329551;
        Tue, 17 Jul 2018 09:35:29 -0700 (PDT)
Received: from [192.168.1.56] (206-212-239-179.static.onlinenw.com. [206.212.239.179])
        by smtp.gmail.com with ESMTPSA id t88-v6sm8021376pfg.10.2018.07.17.09.35.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 09:35:27 -0700 (PDT)
Subject: Re: [PATCHSET v2] block: Separating discards from writes in Linux IO
 statistics
To:     Tejun Heo <tj@kernel.org>
Cc:     michaelcallahan@fb.com, newella@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
References: <20180605180120.2726113-1-tj@kernel.org>
 <20180717155740.GP72677@devbig577.frc2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9320d1e2-ccca-d49d-1be5-ec91ce1552a3@kernel.dk>
Date:   Tue, 17 Jul 2018 10:35:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180717155740.GP72677@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/18 9:57 AM, Tejun Heo wrote:
> Jens, ping.
> 
> Thanks.

Looks ok to me, should probably get it queued up. Can you respin
against for-4.19/block?

-- 
Jens Axboe

