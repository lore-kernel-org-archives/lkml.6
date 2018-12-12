Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FAFC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CCEA2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="nhi9IXw2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CCEA2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbeLLSlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:41:06 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:40349 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbeLLSlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:41:05 -0500
Received: by mail-qk1-f169.google.com with SMTP id y16so11366082qki.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 10:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=o3rDKoBPZXRHTqBG/mAWbn32uuAgJSzAhuKn7Sc6EG0=;
        b=nhi9IXw2PR696uJXRGA6oKZwGqiaiQbFcxub4CdbDccM9unTwVmULT0ECPBnqqBbR0
         RVKQt+ldPc6kZ9YUmJoz+yt5oqNh5acj3FP6p3XkgxCyCEGdo/4HMu+JusiBJrD+dj5V
         m4jVorJieBJhYviDKb0aFGoJkR5rR3lyXkWKmK1im4umhfBKzZGVsozAaijfqCMWFvHH
         HcGNATnLiTikcuI3CJeRpmfIWxeY2nwEEa++Dr4ZbRZG3vHpOKeTZuidqpgccftYvQDS
         Vvf+s+IuHt/f6iXexLRlC58oM1yZ1WFjttls9eNqt3ev3L0qiGCq4AU4uQqQ5fM6wxSO
         aapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=o3rDKoBPZXRHTqBG/mAWbn32uuAgJSzAhuKn7Sc6EG0=;
        b=hyt1iuzePYlEHpQ02qQ6HR8RWen/E71cnj933Q+FOwPNmH+rBJYSl0ji1mnlYMnwY4
         ATEzRaKf/E/deFCoMWbsvLbp89qLkp3VoQpNO7wopXdwJ7/mY4PaxoyecS6TZxUJ8C4T
         dZb441yWKZcf3UG6O/X1WSu7K/4Va6ftLitol3bWBGsXDZDQFzNL3vHb4ohOZHbKqmmC
         zdnL4wu9Yjs02/aaY/3FjQFNIB0b0o8+4L5tLr71I4sqvBMdaXroLJK0vRvKQmbnj2aH
         ITPXV6rySlL0P+N+s/p+25VwLNTwZwX9xWpN0QGmoQi8m8+A/hESf1RwEvL8k6/ER5+T
         VbQA==
X-Gm-Message-State: AA+aEWZZJH2alfKBH0Oa/vT4QOlK4QuPFrtdHwYCiyWEZbQ0ZIFB3LI6
        X8XpJCrmkeWDemvygEspwHUIKw==
X-Google-Smtp-Source: AFSGD/V6km0trlN9uRmw2Pa3yZ5Ky7o0zmbJtWaIsawekpeN+z4J9urruXEO6oR8kaWZJS+t0st68g==
X-Received: by 2002:a37:5b47:: with SMTP id p68mr18665000qkb.299.1544640064920;
        Wed, 12 Dec 2018 10:41:04 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id v50sm11081419qtc.7.2018.12.12.10.41.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 10:41:04 -0800 (PST)
Date:   Wed, 12 Dec 2018 10:41:01 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Alice Ferrazzi <alice.ferrazzi@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] selftest/bpf: test_offload PEP8 format style fix
Message-ID: <20181212103804.467945cc@cakuba.netronome.com>
In-Reply-To: <20181211115607.13774-5-alice.ferrazzi@gmail.com>
References: <20181211115607.13774-1-alice.ferrazzi@gmail.com>
 <20181211115607.13774-5-alice.ferrazzi@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018 20:56:04 +0900, Alice Ferrazzi wrote:
> Signed-off-by: Alice Ferrazzi <alice.ferrazzi@gmail.com>

Thanks, are you just running pylint to catch those?  I tried in the
past but it's very noisy and it lacked "understanding" of some python3
modules.  Would you mind giving us a quick 101 of how to catch such
errors? :)

> -def bpf_obj(name, sec=".text", path=bpf_test_dir,):
> +
> +def bpf_obj(name, sec=".text", path=bpf_test_dir, ):
>      return "obj %s sec %s" % (os.path.join(path, name), sec)
>  

I think this one is just a typo.  bpf_obj() seems to always get called
with one param, no?
