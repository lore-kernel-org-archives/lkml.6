Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B6662C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C904208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="H02encai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C904208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755021AbeFNKTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:19:02 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:28517 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754988AbeFNKS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:18:57 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20180614101855epoutp034f9c1f8d4e563815f648ec46c18dc1ac~3-4LB78LL1294312943epoutp030;
        Thu, 14 Jun 2018 10:18:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180614101855epoutp034f9c1f8d4e563815f648ec46c18dc1ac~3-4LB78LL1294312943epoutp030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1528971535;
        bh=T5Q1k/uFTXT154bSYUosQ0LlcV8dqoPWXnZJhoXh2nE=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=H02encaia8t3UeLs7JG/cmGYGY65YsBJiwHYBQ4ffBQbJxEcZl+AOMY9wXwYKkJyl
         7UzywwMfSfBVExlDl094ipOTkY/+O5uVDmIVdf6B/ZYgsc6kcpM1zHWmS5TZs/7Yph
         1YLCrGO7RapPq0RPE0bTh2CDAnT6nYo2YwrjlreY=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20180614101853epcas1p489fad50c91532428fc3b4e5fc5e63efe~3-4IuintW1477814778epcas1p4a;
        Thu, 14 Jun 2018 10:18:53 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        91.57.04203.D01422B5; Thu, 14 Jun 2018 19:18:53 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180614101852epcas1p2b8af65ff2c09cd39cf68e1a7f51e545f~3-4IYsoYm0962709627epcas1p2A;
        Thu, 14 Jun 2018 10:18:52 +0000 (GMT)
X-AuditID: b6c32a39-24dff7000000106b-bb-5b22410d32c9
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.E6.03915.C01422B5; Thu, 14 Jun 2018 19:18:52 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PAB00MBQ5ZGKF90@mmp1.samsung.com>; Thu, 14 Jun 2018 19:18:52 +0900 (KST)
Message-id: <5B22410C.9080002@samsung.com>
Date:   Thu, 14 Jun 2018 19:18:52 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     linux-kernel@vger.kernel.org
Cc:     chanwoo@kernel.org, myungjoo.ham@samsung.com,
        stable@vger.kernel.org, Roger Quadros <rogerq@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] extcon: Release locking when sending the notification
 of connector state
In-reply-to: <1528949687-32002-1-git-send-email-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsWy7bCmri6vo1K0wae5rBYTb1xhsfix7SuT
        xYWnPWwWl3fNYbO43biCzaLnkZbFgo2PGB3YPda8P8XssWlVJ5tH35ZVjB7Hb2xn8vi8SS6A
        NSrVJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoCiWF
        ssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVK0oaGRnqGBuZ6REZA2jrUyMgUqSUjN2LBIquAM
        X8Wdz0vYGxjfcXcxcnJICJhInJ2xk72LkYtDSGAHo8TxpjNMEM53RolZW7ezw1QdWdTPCpHY
        zSixbvFdFpAEr4CgxI/J94BsDg5mAXmJI5eyQcLMApoSW3evh5p6l1Hi55MOVoh6LYlnC16D
        2SwCqhJLbz1gArHZgOL7X9xgA7H5BRQlrv54zAhiiwpESOyc/w3sCBEBBYnNvc/AjmAW2M8o
        0b/9BNggYYF4iYYP68CaOQXcJBouQhRJCJxhk+i594oF4gUXifYLp5ggbGGJV8e3sINcLSEg
        LXHpqC1EfTujxJcXzVDNExglPpzaDNVgLPFsYRcTxG98Eu++9rBCNPNKdLQJQZR4SHyccZMF
        4uWZjBKXdi9lm8AoOwsplGYhQmkWUigtYGRexSiWWlCcm55abFhgqlecmFtcmpeul5yfu4kR
        nNi0LHcwHjvnc4hRgINRiYd3g5xitBBrYllxZe4hRgkOZiUR3sk/gUK8KYmVValF+fFFpTmp
        xYcYTYGBPJFZSjQ5H5h080riDU2NjI2NLUwMzUwNDZXEeStuCkQLCaQnlqRmp6YWpBbB9DFx
        cEo1MPqcfddhyKzxZsmhicuC3vJGP29e3bPywy0G9+wdPLE332ypvFpYNePip56POadP7tlR
        mVy2TmBF4dKK60u4nR7mn8iQXlX0sqGaq3r3ae+3KsHvMxszfk3Y1Zr6eePV2LjdbT+sz0ww
        Pc4uFnlYN9S7ge1OzoeNXaox1YfPx6d2bNGaLjJnmbsSS3FGoqEWc1FxIgC77bz6ggMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsVy+t9jAV0eR6Vog8tr1Cwm3rjCYvFj21cm
        iwtPe9gsLu+aw2Zxu3EFm0XPIy2LBRsfMTqwe6x5f4rZY9OqTjaPvi2rGD2O39jO5PF5k1wA
        axSXTUpqTmZZapG+XQJXxoZFUgVn+CrufF7C3sD4jruLkZNDQsBE4siiftYuRi4OIYGdjBL7
        N65nA0nwCghK/Jh8j6WLkYODWUBe4silbJAws4C6xKR5i5gh6u8zSpyY2MAEUa8l8WzBa1YQ
        m0VAVWLprQdgcTag+P4XN8Bm8gsoSlz98ZgRZKaoQIRE94lKkLCIgILE5t5nrBDz9zNKLGjJ
        ArGFBeIlpu7cwgaxazajROf1c+wgCU4BN4mGi89YJzAKzEJy6iyEU2chOXUBI/MqRsnUguLc
        9NxiowLDvNRyveLE3OLSvHS95PzcTYzAMN92WKtvB+P9JfGHGAU4GJV4eCNkFKOFWBPLiitz
        DzFKcDArifBO/gkU4k1JrKxKLcqPLyrNSS0+xCjNwaIkzns771ikkEB6YklqdmpqQWoRTJaJ
        g1OqgTFpVwp35P1vlX2ySrpOpSslvnkvXcm5nvtEi7fXe+WbQZpZ0hIHLE5Hm7XO3asfOk8j
        r0V+7geBmVvn2Fw6v/nzvZMdHlPkfCSeZzFsCzutd9j1/i7v5wUfOW/ETnLpdJq4ZtXG2fGP
        nmeYF7HcCzrRqX7LYb1tyfn0lioLvTC1ueuqWb8whSixFGckGmoxFxUnAgByoDNKbwIAAA==
X-CMS-MailID: 20180614101852epcas1p2b8af65ff2c09cd39cf68e1a7f51e545f
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180614041448epcas2p400dad902581dc6875461d4c3dd3a231d
References: <CGME20180614041448epcas2p400dad902581dc6875461d4c3dd3a231d@epcas2p4.samsung.com>
        <1528949687-32002-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ H. Nikolaus Schaller <hns@goldelico.com>

On 2018년 06월 14일 13:14, Chanwoo Choi wrote:
> Previously, extcon used the spinlock before calling the notifier_call_chain
> to prevent the scheduled out of task and to prevent the notification delay.
> When spinlock is locked for sending the notification, deadlock issue
> occured on the side of extcon consumer device. To fix this issue,
> extcon consumer device should always use the work. it is always not
> reasonable to use work.
> 
> To fix this issue on extcon consumer device, release locking when sending
> the notification of connector state.
> 
> Fixes: ab11af049f88 ("extcon: Add the synchronization extcon APIs to support the notification")
> Cc: stable@vger.kernel.org
> Cc: Roger Quadros <rogerq@ti.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/extcon/extcon.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index 8bff5fd18185..f75b08a45d4e 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -433,8 +433,8 @@ int extcon_sync(struct extcon_dev *edev, unsigned int id)
>  		return index;
>  
>  	spin_lock_irqsave(&edev->lock, flags);
> -
>  	state = !!(edev->state & BIT(index));
> +	spin_unlock_irqrestore(&edev->lock, flags);
>  
>  	/*
>  	 * Call functions in a raw notifier chain for the specific one
> @@ -448,6 +448,7 @@ int extcon_sync(struct extcon_dev *edev, unsigned int id)
>  	 */
>  	raw_notifier_call_chain(&edev->nh_all, state, edev);
>  
> +	spin_lock_irqsave(&edev->lock, flags);
>  	/* This could be in interrupt handler */
>  	prop_buf = (char *)get_zeroed_page(GFP_ATOMIC);
>  	if (!prop_buf) {
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
