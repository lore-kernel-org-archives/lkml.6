Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3881655-1519034129-2-3677135713977859360
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519034129; b=hZ/E/c2tgIm7da308rTQaR+1qBA62nP8FIjWhWnqdVUScTe
    apw/hGYNQEEoOHw5KrICLM4rjdER1jIEfnw97F8KJ3hXaq7p4FbOPwxecsH8AKKA
    b4xkZ//nj9YCRYmaiK6SHBSBiMoMKlqELr2/nYLwJKc+dXTvYJo5Tv7KRSLCi14G
    2MMZ9nKu/lRHICd1Kv1sZwpj5X3pmKU4NbBs9mtc2do3eOgxnTQZY/hFxIVAcuyh
    hz7+wVS8N9OtA1Bqo05Sl2tcUsINx9uc5GAiZkDH2ilo7MSpfXslrZynKdfVv931
    o1Pi7mLE5OypqPK8GjvfIfmiXiu9n2RvDiiDv8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-transfer-encoding
    :content-type:message-id:date:from:to:cc:subject:in-reply-to
    :references:sender:list-id; s=arctest; t=1519034129; bh=g1WVVD63
    v8nhyL3dcvwBN7+hAmjXk6wGh7lNcDJimoM=; b=EGujqAGV1vxfEJSQFjsKZl3Q
    GKtup3B/jc4Wiljx1G3exX3Nionoyf3SyyVa2ehrx4j5nFU0cInopFj8ZznXVwW0
    o4huMWeJ7ADhs9y90rWCtucNZfYgrA8eFUZQhYHh1PfiudBJhnD4nRboY7nZ4QWw
    m6UOl87Bkvk1reVllrZTekyF6fInKAjRt6lldRVukIs1YPf/xkjplFNteLUup6lu
    oOPJ+ROsUxUODRS7w6fAnwb84bxj6bh/QRb5L6BFbujMBe2Hkfzn8qBetDP0yAql
    HpDyMo4VuitK8fyxubpu/BwdhIi6XFEwcusIXgMfxSrcUbKvwWIokZFi05odzg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=LEbvDB8d x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=LEbvDB8d x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752228AbeBSJz2 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 04:55:28 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:39891 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752109AbeBSJz0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Feb 2018 04:55:26 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180219095524epoutp0463106238ccc2619a069743f314c45f3e~UsXzifoMi1964919649epoutp04i
X-AuditID: b6c32a39-47fff70000000fc5-2e-5a8a9f0b75e1
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5A8A9F0A.70608@samsung.com>
Date: Mon, 19 Feb 2018 18:55:22 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Hans de Goede <hdegoede@redhat.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] extcon: int3496: process id-pin first so that we
 start with the right status
In-reply-to: <20180213192550.31579-1-hdegoede@redhat.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7bCmri73/K4og/aDmhZvjk9nsri8aw6b
        xe3GFWwWCzY+YnRg8Xi/7yqbR9+WVYwenzfJBTBHpdpkpCampBYppOYl56dk5qXbKnkHxzvH
        m5oZGOoaWlqYKynkJeam2iq5+AToumXmAG1TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gq
        RRsaGukZGpjrGRkZ6ZkYx1oZmQKVJKRmLFnQxVRwkr+ife899gbG0zxdjJwcEgImEt+nnWLp
        YuTiEBLYwSjR1b+EHcL5zigx43IXI0zVw8ProKp2M0rs2nuBDSTBKyAo8WPyPaAEBwezgLzE
        kUvZIGFmAU2JrbvXQw26xygx5d8mZoh6DYl515vBelkEVCXOvt7LDmKzCWhJ7H9xAyzOL6Ao
        cfXHY7DFogIREjvnfwOrEREIkrjxfQUrxC4Lifb9piBhYYE0ibb/a8HGcwpYSvw5dZIJZK+E
        wAo2iW3v57NCPOAisezhYqhnhCVeHd/CDjJHQkBa4tJRW4j6dkaJ9r3zmCGcKYwS567fY4Jo
        MJZ4trCLCeIzPol3X3tYIZp5JTrahCBKPIB+XM4MYTtK9D5oZIN4vodRYuGvLqYJjHKzkMJr
        FiK8ZiGF1wJG5lWMYqkFxbnpqcWGBaZ6xYm5xaV56XrJ+bmbGMHpS8tyB+Oxcz6HGAU4GJV4
        eAU2dkYJsSaWFVfmHmKU4GBWEuG1COmKEuJNSaysSi3Kjy8qzUktPsRoCgzuicxSosn5wNSa
        VxJvaGJpYGJmBExeloaGSuK8AQEuUUIC6YklqdmpqQWpRTB9TBycUg2MkTtjj2vd2TunfuO1
        9t/mPst6bBxLBTKcv0fNuvT9Z0n+jP+XD15VtP70UDHd9kv3iou899QP75aKu58pr32jQ7t5
        zpeV6VGe30KP3tw2QSZk+9zPCtx9kmlHTY0mtR+6174k2X6mpp7F48nd2vdE2r32zJ+R9FZq
        TtOfVIYCv9IbnRax13Z+UGIpzkg01GIuKk4EAJU0Dt11AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsVy+t9jAV2u+V1RBrMnWVu8OT6dyeLyrjls
        FrcbV7BZLNj4iNGBxeP9vqtsHn1bVjF6fN4kF8AcxWWTkpqTWZZapG+XwJWxZEEXU8FJ/or2
        vffYGxhP83QxcnJICJhIPDy8jgXEFhLYySgxaW49iM0rICjxY/I9oDgHB7OAvMSRS9kgYWYB
        dYlJ8xYxdzFyAZU/YJQ4+WEDO0S9hsS8681sIDaLgKrE2dd7weJsAloS+1/cAIvzCyhKXP3x
        mBFkpqhAhET3iUqQsIhAgMTPU/3sEKssJNr3m4KEhQXSJHp+nmSFWNXHKNF5ZxLYGE4BS4k/
        p04yTWAUmIXk0lkIl85CcukCRuZVjJKpBcW56bnFRgWGeanlesWJucWleel6yfm5mxiBQbvt
        sFbfDsb7S+IPMQpwMCrx8Aps7IwSYk0sK67MPcQowcGsJMJrEdIVJcSbklhZlVqUH19UmpNa
        fIhRmoNFSZz3dt6xSCGB9MSS1OzU1ILUIpgsEwenVAPjijqTZefZUyUm7lST2fS/Z/GMHRNn
        9/nOy5z14cv+oHL+hmIdj83me3iWPfvPmPLqXumht+sNKs+c9pu4ouNjlH6h3/Gilzy/JR7L
        2E6XuR75NPLBg2V5j8r4d82cZlbkHcG74M2UHPFCfpHXsYfnnDhm1rPJZ8rjvPbaD9Nd5tsk
        dbav/LUlRImlOCPRUIu5qDgRAAZT9QBWAgAA
X-CMS-MailID: 20180219095523epcas1p3612396d82204233599fd56c3c35d0db3
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180213192600epcas4p1cc557008467633131627c99f390d3157
X-RootMTR: 20180213192600epcas4p1cc557008467633131627c99f390d3157
References: <CGME20180213192600epcas4p1cc557008467633131627c99f390d3157@epcas4p1.samsung.com>
        <20180213192550.31579-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 2018년 02월 14일 04:25, Hans de Goede wrote:
> Some other drivers may be waiting for our extcon to show-up, exiting their
> probe methods with -EPROBE_DEFER until we show up.
> 
> These drivers will typically get the cable state directly after getting
> the extcon, this commit changes the int3496 code to wait for the initial
> processing of the id-pin to complete before exiting probe() with 0, which
> will cause devices waiting on the defered probe to get reprobed.
> 
> This fixes a race where the initial work might still be running while other
> drivers were already calling extcon_get_state().
> 
> Fixes: 2f556bdb9f2e ("extcon: int3496: Add Intel INT3496 ACPI ... driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Add Fixes tag
> 
> Changes in v3:
> -Fix oops on probe by scheduling the work too early
> 
> Changes in v4:
> -Ugh sorry about this, but we cannot call extcon_set_state() before
>  extcon_dev_register() at all because before registration the cable array
>  is not yet allocated. Instead wait for the initial processing of the
>  id-pin to complete before exiting probe().
> ---
>  drivers/extcon/extcon-intel-int3496.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/extcon-intel-int3496.c b/drivers/extcon/extcon-intel-int3496.c
> index c8691b5a9cb0..191e99f06a9a 100644
> --- a/drivers/extcon/extcon-intel-int3496.c
> +++ b/drivers/extcon/extcon-intel-int3496.c
> @@ -153,8 +153,9 @@ static int int3496_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	/* queue initial processing of id-pin */
> +	/* process id-pin so that we start with the right status */
>  	queue_delayed_work(system_wq, &data->work, 0);
> +	flush_delayed_work(&data->work);
>  
>  	platform_set_drvdata(pdev, data);
>  
> 

Applied it instead of v3.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
