Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0A8C169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32D820869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="utd1Rlfl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A32D820869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbeJPUjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:39:43 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43905 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbeJPUjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 16:39:42 -0400
Received: by mail-ed1-f68.google.com with SMTP id y20-v6so21174141eds.10;
        Tue, 16 Oct 2018 05:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oU4tykwryFt2NLgxTnkWtuLA8r8oRanCLqtsye+zUDw=;
        b=utd1RlflLrXeX3Rh8gjvSCbCKYqxLVLYNHQmrZi44/8/hOaqram92eZjYkxLwppLXu
         fE2nEbW4+XP1IOAXFc7MwMjngUf1LWplOkCZCM/IZnrOLMgC/fbUxDCAmtcZjM9kGsnQ
         5SVLz5iXd4PrazX4QoaeTVZl7nVx1FCxImyD3o2Qi0qlzNIwjvE9Q39jSOWfp0IBG5DN
         ulnjlevlacIPePcdcSzOkZ00wezBuCnEfNE+XIgnnwcnVNqf/inei7g2NBxcRpXhOKO6
         7B1tlFZuxsJfAmwfJYPKknk55NZe+0Xw8OfuzlggXEDojo/1iA8XAMBuGiNlbB/KEvGn
         VnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=oU4tykwryFt2NLgxTnkWtuLA8r8oRanCLqtsye+zUDw=;
        b=JFbavpilj9SPT7HB6K5HBVBgrATvNFVVmjuGk5Y1g2Yb32VHexzC0MvEqpXeLkr/ba
         CHI93ymWsZlUUAPEb3NMFgQ3XpUVnDauw/CEffBd3/9pqUoDnF3Cz+MY8jsG+iOd5Irz
         gkrP+yktdgb4gtdmHV5L5vhDtnasp3YXDszX04Dy7o7wkYllYsoR7oGYVsScA/rhluFo
         +uN/tN7DI30irux0rY2Fng464ZnNaX2Ila81hJLjvleHYZRdIPhMLxbY0ypIBtf4WM6L
         l7kOG35ruN+u+K8zXZ32pTrD82OHKTUjf1GUBBslw/TqIRuXGs2cbcO5GJrrWRwji7h3
         00nA==
X-Gm-Message-State: ABuFfojUE1YU3viDb8NneOyeozNJW6r00QMsBOlt5Kwg17h3VJg5FV/I
        AdMpMazguagG7+L17+L1MUg=
X-Google-Smtp-Source: ACcGV62hsU+/eBQSHlGalbrshvjGyGqHiYtUtA7kG+AmRNT67jDszMepxRqZq0TIc94bLAuFfThnfw==
X-Received: by 2002:a50:eb97:: with SMTP id y23-v6mr29755184edr.38.1539694161360;
        Tue, 16 Oct 2018 05:49:21 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id t19-v6sm5675568edd.68.2018.10.16.05.49.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 05:49:20 -0700 (PDT)
Date:   Tue, 16 Oct 2018 12:49:19 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        x86@kernel.org, hpa@zytor.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2]  kvm:x86 :remove unnecessary recalculate_apic_map
Message-ID: <20181016124919.3qgn6a4g7y2srd7k@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <1539681150-9374-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539681150-9374-1-git-send-email-peng.hao2@zte.com.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 05:12:30PM +0800, Peng Hao wrote:
>In the previous code, the variable sw_apic_disabled influences
>recalculate_apic_map. But in "KVM: x86: simplify kvm_apic_map"
>(commit:3b5a5ffa928a3f875b0d5dd284eeb7c322e1688a),
>the access to sw_apic_disabled in recalculate_apic_map has been
>deleted.

s/sw_apic_disabled/apic_sw_disabled/ ?

>
>Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
>---
> arch/x86/kvm/lapic.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>
>diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
>index 70dcb55..0380e37 100644
>--- a/arch/x86/kvm/lapic.c
>+++ b/arch/x86/kvm/lapic.c
>@@ -246,10 +246,9 @@ static inline void apic_set_spiv(struct kvm_lapic *apic, u32 val)
> 
> 	if (enabled != apic->sw_enabled) {
> 		apic->sw_enabled = enabled;
>-		if (enabled) {
>+		if (enabled)
> 			static_key_slow_dec_deferred(&apic_sw_disabled);
>-			recalculate_apic_map(apic->vcpu->kvm);
>-		} else
>+		else
> 			static_key_slow_inc(&apic_sw_disabled.key);
> 	}
> }
>-- 
>1.8.3.1

-- 
Wei Yang
Help you, Help me
