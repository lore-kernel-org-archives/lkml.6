Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9288BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483972083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPrEjU5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483972083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeIACdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 22:33:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36598 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbeIACdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 22:33:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id d1-v6so6034263pgo.3;
        Fri, 31 Aug 2018 15:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6eYN1qllWYHTmUDJ48f68iHeHMhzkffLFI0awVIa5j0=;
        b=kPrEjU5e2tK87pz9E+X9q6lm3tr0PBJW8xWmrwPflD2HwZs1flPrzhhJO0NP1T+/2G
         yO9iCKAM5cKiTfTWlrY3PgOuECfW8naSaRd/NSsfi1DZE5W8JNfUDkiImCOQTRzf7KDH
         sIezu5Cvrh+kYNPY1fxh74Vhc7rnLzcxts5k1xeflN7eOwn21QCzR5QCcxFTKV/oud44
         NFeNlPnCz6pgDQAqyOazGnPvQfXwQfc+pC58Cj9h2vZBQl08oqwg1BhVvXBq91WBj4Ej
         cUMhkxFB0LMqH3pYEvYLbRZ35I00MdGLWtfE7FDgfMoT1B9nWaTR1gglNzBhEMdvimtZ
         58yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6eYN1qllWYHTmUDJ48f68iHeHMhzkffLFI0awVIa5j0=;
        b=Ypwpuh9cBgmHR7m7erpYVFM21CwVx0V5+/Pw3MXMytXwzti6DQVr+zm4ySP45YVFoI
         2m8vuTnMcCIkWjqG78T0lahCMd/0VYP5wEM5g+Vg9ZaPnZVB5ly3bM39MFfXlZS6Ysp6
         5W65kuYzDfhMt1pFNddkVm7xLTtWqRh6xuhDWG7TerK4I5i+Jxy/h1SCesg1772H3+O7
         G3Nu02wc8S8IMzgjWfY1vUzose5i17dsyJmLVIkCaSeJ/eTkSji1W/ybn6TkpfVjqoGR
         bIf6GsE3hh3mRdjTpfZ8VGTsXeQXQTwsVjmLd+N+RUi8rqbPI9LKyWliVB8mYCXYHfBb
         WIgw==
X-Gm-Message-State: APzg51BOH9f+2hW4g8Y3JLt1kTDY8O6fA9nKxDeaVgFYldUxo18Vl2u6
        Mzc0QwVLs4gyNOHRp+6dumY=
X-Google-Smtp-Source: ANB0VdbaLl2lvXQQuA/06WOe79byc+ltQ0NWuYfATqaPwvMRsUm7EJsT1bLeAx6AWFxiVkUz5v5XCw==
X-Received: by 2002:a63:e70e:: with SMTP id b14-v6mr9282200pgi.68.1535754256590;
        Fri, 31 Aug 2018 15:24:16 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::1:1347])
        by smtp.gmail.com with ESMTPSA id b6-v6sm9856619pfh.182.2018.08.31.15.24.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 15:24:15 -0700 (PDT)
Date:   Fri, 31 Aug 2018 15:24:12 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] fix blkcg offlining and destruction
Message-ID: <20180831222412.GA1488037@devbig004.ftw2.facebook.com>
References: <20180831202244.21678-1-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831202244.21678-1-dennisszhou@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 04:22:41PM -0400, Dennis Zhou wrote:
> Hi everyone,
> 
> This is a split of an earlier series I sent out [1] containing the first
> 3 patches with fixes from feedback. This series tackles the first
> problem where blkcgs were not being destroyed.
> 
> There is a regression in blkcg destruction where references weren't
> properly put causing blkcgs to never be destroyed. Previously, blkgs
> were destroyed during offlining of the blkcg. This puts back the blkcg
> reference a blkg holds allowing blkcg ref to reach zero. Then,
> blkcg_css_free() is called as part of the final cleanup.
> 
> To address the problem, 0001 reverts the broken commit, 0002 delays
> blkg destruction until writeback has finished, and 0003 closes the
> window on a race condition between a css migration and dying, and
> blkg association. This should fix the issue where blkg_get() was getting
> called when a blkcg had already begun exiting. If a bio finds itself
> here, it will just fall back to root. Oddly enough at one point,
> blk-throttle was using policy data from and associating with potentially
> different blkgs, thus how this was exposed.

For patches 1-3,

  Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
