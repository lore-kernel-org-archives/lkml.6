Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469ECC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D0920835
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20150623.gappssmtp.com header.i=@mojatatu-com.20150623.gappssmtp.com header.b="AH+3y/jm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D0920835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeJIRSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 13:18:37 -0400
Received: from mail-it1-f169.google.com ([209.85.166.169]:51382 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJIRSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 13:18:36 -0400
Received: by mail-it1-f169.google.com with SMTP id 74-v6so1745012itw.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 03:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=BwxXtf34wbYWJSbaU6lXGtAoU69FnRvap7HZ1kgrqvs=;
        b=AH+3y/jmLyzKyvjab57zxg+HmvCybUHZNMQUSda3/i4A7hZ4PjBct4PWJlGZqFkC95
         yFyH3h2x3FtFa7mci+HH1gFJWYt9EMTkKzcJ/IK/eQnJ9WFj2LYDgI/9esykA/nEBXVs
         KarEbzTri3Q6+UsOUXp3101dF8g/cvozDUYI245brwmshanWvixuVXk5kMEwyyNDVr17
         VSPxhV7GniExdivRC1x/66BjJPbalMm/9sCeG0jomIAhsllfLQB6V4VOxtH2pswMNfHT
         +rD/kRWBTpzlBWM99Oww4WNuCNP2Fh+/qIqt2TT9kCF7EyBXBs//r6BU3IT7C9oqczz/
         +IYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=BwxXtf34wbYWJSbaU6lXGtAoU69FnRvap7HZ1kgrqvs=;
        b=FKKEG/A1ZnESNK0Ni717jL1kZd456ch9FzMuIcpjRTO0OCI8PcX83WXU6kvhs2gnHe
         FWcNJEEp82TBwhBWU31aWPevcl9Y3GcJihSpn096Yzh/Oq/T67qKFTQIv5T+F2TCt6IA
         5jFcfWzeLIiTv3eMu1xPkdE0aXEwG3pS0zdBNLxW4gzqjgcbci8VAPpzY3o4p3ARdOJh
         IX+7J8yfejBTPOwmDOPbs+FEwXyut+YZNk7cNKhdkd2S/XGbrXo2nqV5QFhugDhjpZHu
         nigehUaxvpZqXbTRUGNOs7EbHRpkbcPJJAJaaQnK1ux90a+zisUWfUCfnsvnUdVBrqcI
         b2qQ==
X-Gm-Message-State: ABuFfoh5qjPgWAyEuttbdnHb/F/N0LTSy2MkmU9flkM9bpcRvalOEgAs
        r8C+egADEwUzlokyFDv06YsRN1t7hqk=
X-Google-Smtp-Source: ACcGV611Sj02F1ePHR2r2qzSNHMkvMgoOokU7PXve19efQXDqLjHO2QdNKMxmP9wt0gdubuVGH74OA==
X-Received: by 2002:a02:8602:: with SMTP id e2-v6mr21795484jai.16.1539079347645;
        Tue, 09 Oct 2018 03:02:27 -0700 (PDT)
Received: from [10.0.0.145] (198-84-205-232.cpe.teksavvy.com. [198.84.205.232])
        by smtp.googlemail.com with ESMTPSA id a186-v6sm5547917itd.2.2018.10.09.03.02.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 03:02:26 -0700 (PDT)
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20181009122113.05fbf12a@canb.auug.org.au>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Message-ID: <7cb98153-14df-96e4-edee-518775f49ec5@mojatatu.com>
Date:   Tue, 9 Oct 2018 06:02:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181009122113.05fbf12a@canb.auug.org.au>
Content-Type: multipart/mixed;
 boundary="------------4143A68BAE4F56D44B625416"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4143A68BAE4F56D44B625416
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 2018-10-08 9:21 p.m., Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the net-next tree got a conflict in:
> 
>    net/sched/cls_u32.c
> 
> between commit:
> 
>    6d4c407744dd ("net: sched: cls_u32: fix hnode refcounting")
> 
> from the net tree and commit:
> 
>    a030598690c6 ("net: sched: cls_u32: simplify the hell out u32_delete() emptiness check")
> 
> from the net-next tree.
> 
> I fixed it up (I reverted the net tree commit as I could not tell
> wich parts of it, if any, are still needed) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
> 

Attached should fix it. Al, please double check.

cheers,
jamal

--------------4143A68BAE4F56D44B625416
Content-Type: text/plain; charset=UTF-8;
 name="al-merge-diff-net-next"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="al-merge-diff-net-next"

--- a/net-next/net/sched/cls_u32.c	2018-10-09 05:18:04.046642676 -0400
+++ b/net/sched/cls_u32.c	2018-10-09 05:29:51.965528032 -0400
@@ -391,6 +391,7 @@
 	RCU_INIT_POINTER(root_ht->next, tp_c->hlist);
 	rcu_assign_pointer(tp_c->hlist, root_ht);
 
+	root_ht->refcnt++;
 	rcu_assign_pointer(tp->root, root_ht);
 	tp->data = tp_c;
 	return 0;
@@ -606,7 +607,7 @@
 	struct tc_u_hnode __rcu **hn;
 	struct tc_u_hnode *phn;
 
-	WARN_ON(ht->refcnt);
+	WARN_ON(--ht->refcnt);
 
 	u32_clear_hnode(tp, ht, extack);
 
@@ -634,7 +635,7 @@
 
 	WARN_ON(root_ht == NULL);
 
-	if (root_ht && --root_ht->refcnt == 0)
+	if (root_ht && --root_ht->refcnt == 1)
 		u32_destroy_hnode(tp, root_ht, extack);
 
 	if (--tp_c->refcnt == 0) {
@@ -679,7 +680,6 @@
 	}
 
 	if (ht->refcnt == 1) {
-		ht->refcnt--;
 		u32_destroy_hnode(tp, ht, extack);
 	} else {
 		NL_SET_ERR_MSG_MOD(extack, "Can not delete in-use filter");
@@ -1079,8 +1079,7 @@
 	}
 #endif
 
-	err = u32_set_parms(net, tp, base, n, tb, tca[TCA_RATE], ovr,
-			    extack);
+	err = u32_set_parms(net, tp, base, n, tb, tca[TCA_RATE], ovr, extack);
 	if (err == 0) {
 		struct tc_u_knode __rcu **ins;
 		struct tc_u_knode *pins;

--------------4143A68BAE4F56D44B625416--
