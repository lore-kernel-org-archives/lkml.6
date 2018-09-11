Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCE8C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A9320839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcFJhXJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A9320839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbeIKUt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:49:56 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40271 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbeIKUt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:49:56 -0400
Received: by mail-yw1-f67.google.com with SMTP id z143-v6so9388142ywa.7;
        Tue, 11 Sep 2018 08:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QTr3k7vV1353pdP7gQSS+TOpEeZOWjtIdRjApHX3V+s=;
        b=DcFJhXJbUJngS24vRbKHrKORepVFSKJuJDEJJ7IOeS/jOxh2vHXKGBbH60b4rb/JPs
         nLy0u1c1E3ww2X0Vkpt1FPQ6aMyNZnuH1LifyeWt0Am5/12oDaHJHXZD11xj3m2Re5ZG
         xGdFf7GUFMHhO+Bltdmicsj7/XZWrfKbBM4zIPndoGsS2OHa4ZuAMUgXbm1Nxc5qy8Sv
         vtqiNBsWbQvymzDfxNv248yUhSUXfoQABiKVUjC6qROKjPbIKIsdsfUf6k6cBe6OJlTg
         HpJ5ROCMpCn9sawFEhPdzCpVRG5WYW9b1m+gR1MWuXY+GEzlygjNdToAdp6WW8AccQlM
         aPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QTr3k7vV1353pdP7gQSS+TOpEeZOWjtIdRjApHX3V+s=;
        b=TTpVZAIkmmz32J8hOGQttg6bjEaX99esPY2ASm9Ii+PQw+6lrAhcgy2BEyMbFYhIMS
         PtmDCBa4df0h0+mFv8CszYeG984TAya9PzOZMz7qZ6myyzhbkOUlfqgehZ58n01xJIX3
         LcTapQqvsbMKgMzCcRQnGmbsJZgbBR9SzpIC1ecvVeaKByKc//e1bhKpezCBsvqPj17v
         0dQfG1JjkX0NcP37n70pfuUc2cF9L+yoEyug+W1keD5Dtj0Q4BavEgppc0f4jLD83Dsb
         u2q5rihtBz4Jozcio8dpiKzPbfHytJwr1ThGh4uObzuk1lONmjBlBVSgDqggKqmN2JRA
         iQAA==
X-Gm-Message-State: APzg51DiBLSBz2eWBME+se//R3yrjg+PtcC5Wj+Qn/76H0+MkJ9lxZ44
        NqrbIgeEwOnrJouREnT+opg=
X-Google-Smtp-Source: ANB0VdZqAUAWS00hylrZ4wbAt4zHj4p28tdLTtcehrch9gu16ceCG8E2gZxibd3bethP6yPLE+eR2g==
X-Received: by 2002:a81:4dd6:: with SMTP id a205-v6mr12848185ywb.289.1536681001804;
        Tue, 11 Sep 2018 08:50:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:6304])
        by smtp.gmail.com with ESMTPSA id d21-v6sm8463964ywb.16.2018.09.11.08.50.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 08:50:01 -0700 (PDT)
Date:   Tue, 11 Sep 2018 08:49:59 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
Message-ID: <20180911154959.GI1100574@devbig004.ftw2.facebook.com>
References: <20180909125824.9150-1-ming.lei@redhat.com>
 <20180910164920.GE1100574@devbig004.ftw2.facebook.com>
 <20180911000049.GB30977@ming.t460p>
 <20180911134836.GG1100574@devbig004.ftw2.facebook.com>
 <20180911154540.GA10082@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911154540.GA10082@ming.t460p>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 11:45:41PM +0800, Ming Lei wrote:
> > So, this part seems wrong.  The function is called percpu_ref_reinit()
> > - the refcnt is expected to be in its initial state with just the base
> > ref once this function returns.  If you're removing the restriction on
> 
> But the comment says that 'Re-initialize @ref so that it's in the same
> state as when it finished', and this invariant isn't changed with this
> patch.

The comment goes "when perpcu_ref_init() finished".  The function is
called re _init_.  It should put the ref in the initial state, right?

Thanks.

-- 
tejun
