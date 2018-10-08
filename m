Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73787C6787E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 02:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30497206B2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 02:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHFeVw81"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30497206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbeJHJez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 05:34:55 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40519 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725760AbeJHJez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 05:34:55 -0400
Received: by mail-ed1-f66.google.com with SMTP id r1-v6so1714908edd.7;
        Sun, 07 Oct 2018 19:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dUKWP42tSEj4nZi5aNXIZNIm0AG5L6jzWxC0b78pWGc=;
        b=JHFeVw81IYVtzBGehC7cBAwhXeONXqQqLwDQf6SF6x8RX+e1eZhA90c12UQYYL0ShZ
         nylg6ESV16ARkcMJTry6HMR96SpiPfcJLD+cdJVvHIDjXpyyF6OUITUPg1NDUqLivrOn
         Oj7IcB5anPx983K7xbUIohNFaGcSV8LOI9sLnq4dxQaBvkoISb6SdwgN60j8KuLFl6MO
         ghKIMOZ2wwTur8EWtus7Nuf6nUD6MGGQRJQyeEddRrxZRK9d4YxZptcTLYq7DP/MO2Ew
         fQV5/PsPJnLyolNEl3z4GFYSelhaFofJSV5+MXaRPb5a21WCW5uhlZ63GPhUmnl/CFHZ
         D3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dUKWP42tSEj4nZi5aNXIZNIm0AG5L6jzWxC0b78pWGc=;
        b=VJMt8J5bGbRB+gk61H0Jm1ZmiwD2ciK7bCZ+2b8mpVENBdvuyuIp2dgVJTzCki5DxX
         vWPzYGuaQmLqnZvhTtSU886a+vGbxNBKJ5GXFY5O8teLkI7359G9tJISDkUWUs/xHDjo
         I6oZJWpDHkwng/ZvMq5/F4ryWr+R7VilZFf1HZeu75DnFNueddN+vkayds4zImJNSr4R
         8uOqwaiGxD5K1rX9lEeENBbSxBpDr8CjVkOzwUH3klphciUYQa/eFqaM/SkrKaUJOKV5
         FZIACwGULW9dAyaAC49/EOTMTZQ7a3+9v5DupzvfmGWAeBi25DoFmr/H7PUJVoe5IyvY
         lp8Q==
X-Gm-Message-State: ABuFfoiy5C6qHerh+6+SFwS3Z1kDG7G3twDkhvuYFkeXLVHyqW5MtJOb
        F5zk4ZMcBOgCFDeNt0q7U1Q=
X-Google-Smtp-Source: ACcGV63tP4FNDWbQf5BcKk1+FBvdPV24G25AFWR1bib5s7n8xNpJZ6J4w6Q1oGXzkw2eMCzzaAwN6g==
X-Received: by 2002:a17:906:e1ce:: with SMTP id gp14-v6mr14776661ejb.221.1538965533714;
        Sun, 07 Oct 2018 19:25:33 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id g48-v6sm5184406edc.93.2018.10.07.19.25.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Oct 2018 19:25:32 -0700 (PDT)
Date:   Mon, 8 Oct 2018 02:25:32 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     peng.hao2@zte.com.cn
Cc:     richard.weiyang@gmail.com, penghao122@sina.com.cn,
        pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, joro@8bytes.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH]  kvm/x86 : avoid shifting signed 32-bit value by 31 bits
Message-ID: <20181008022532.4ve2xww4yphk6f5d@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20181006070849.psgrrhiysnrytbjr@master>
 <201810080904344038939@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201810080904344038939@zte.com.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 09:04:34AM +0800, peng.hao2@zte.com.cn wrote:
>>On Sat, Oct 06, 2018 at 11:31:04AM +0800, peng.hao2@zte.com.cn wrote:
>>>>On Thu, Oct 04, 2018 at 01:47:18PM -0400, Peng Hao wrote:
>>>>>
>>>>>From: Peng Hao <peng.hao2@zte.com.cn>
>>>>>
>>>>>  modify AVIC_LOGICAL_ID_ENTRY_VALID_MASK to unsigned
>>>>>
>>>>>Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
>>>>>---
>>>>> arch/x86/kvm/svm.c | 2 +-
>>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>>diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
>>>>>index d96092b..bf1ded4 100644
>>>>>--- a/arch/x86/kvm/svm.c
>>>>>+++ b/arch/x86/kvm/svm.c
>>>>>@@ -262,7 +262,7 @@ struct amd_svm_iommu_ir {
>>>>> };
>>>>>
>>>>> #define AVIC_LOGICAL_ID_ENTRY_GUEST_PHYSICAL_ID_MASK    (0xFF)
>>>>>-#define AVIC_LOGICAL_ID_ENTRY_VALID_MASK        (1 << 31)
>>>>>+#define AVIC_LOGICAL_ID_ENTRY_VALID_MASK        (1UL << 31)
>>>
>>>>It is reasonable to change to unsigned, while not necessary to unsigned
>>>>long?
>>>AVIC_LOGICAL_ID_ENTRY_VALID_MASK is used in function avic_ldr_write.
>>>here I think it doesn't matter if you use unsigned or unsigned long. Do you have any suggestions?
>
>>In current case, AVIC_LOGICAL_ID_ENTRY_VALID_MASK is used to calculate
>>the value of new_entry with type of u32. So the definition here is not
>>harmful.
>
>>Also, I did a quick grep and found similar definition (1 << 31) is popular
>>in the whole kernel tree.
>
>>The reason to make this change is not that strong to me. Would you
>>minding sharing more reason behind this change?
>oh, I'm just thinking logically, not more reason.

This definition may introduce problem when this value is used to
calculate a 64bit data.

Since current entry is 32bit, we may leave it as it is for now.


-- 
Wei Yang
Help you, Help me
