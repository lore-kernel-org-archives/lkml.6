Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-618430-1517904902-2-11226035963091944788
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
    t=1517904901; b=bKyeijwFulB5lwZge5uUCYJpWxvXLPPL6sVxmV0/C8dJ47C
    0w5dlkOdYuAVparIObeqSgMUxipo1CPpuy+9gUkdSMRUt0mEM5Oh3uJrw7x4+nuS
    pKvI57evCmXlynegqtxVVTRDMX8ipzJMcsyVhh3KfPTKdgQEHqWmLePyHc27m7Zv
    fL/aCSUk5qJatZR3o3TpmXRWLpX9xn6I+lFRyx1RB8iCgl185TCWrgcvASnjpZz5
    S2SazQoSsLfKVtuVluG/54lhGk5Kr+hi9xilckxOIONatikqpVsj4qNKLyT3hFFd
    vD+LyhHHIdui8a4fsLwKzlG8pQ6ILt5fIZt42+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-transfer-encoding
    :content-type:message-id:date:from:to:cc:subject:in-reply-to
    :references:sender:list-id; s=arctest; t=1517904901; bh=A9/qyrCL
    3Vma1IpBcWIkFIzblp3i4t7S6bw8ol1/cJM=; b=WH/8feHb/1fS7X/btFc8qxgk
    aTU+RINanXNyxg2bAWz1xDkbIdFywN4MFCelOAK2BHLNqptI5h6L/fGpI3lc8cz9
    loajW6zh76i0eLwlvNrJfBaJB3H0vo7jdamcb8bgBP1O56sqbjUyylrXqodflPXQ
    ATadwXUh2TlJE6XTDrhfw12+ZeKqfV8QwY+hZYbbrA18t34UW6ylV2m6HdCEm547
    svp07NNVdni8iiqCrlhJN9Ff60S2YcayiKnaqqdKKyrX6xi+WDqdO7Jm8wZx5ERM
    xCFJLj/XE0cfwCOKrEsQFEI9bgrFCYYq/YcbrrW6A7NCvSl5qvVlgVBG7aJs6w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=tITwwZEE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=tITwwZEE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbeBFIO7 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 03:14:59 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:10739 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeBFIO6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 03:14:58 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180206081457epoutp04301dcef6dfb2fd22253a3abc38e73065~QrnYt7lge2787927879epoutp04Y
X-AuditID: b6c32a35-879ff70000001031-28-5a7963ffb56f
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5A796400.20905@samsung.com>
Date: Tue, 06 Feb 2018 17:14:56 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Hans de Goede <hdegoede@redhat.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] extcon: int3496: process id-pin first so that we
 start with the right status
In-reply-to: <20180206081051.10785-1-hdegoede@redhat.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIKsWRmVeSWpSXmKPExsWy7bCmge7/5Moog0/72S3eHJ/OZHF51xw2
        i9uNK9gsFmx8xOjA4vF+31U2j74tqxg9Pm+SC2COSrXJSE1MSS1SSM1Lzk/JzEu3VfIOjneO
        NzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAdqmpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFV
        ijY0NNIzNDDXMzIy0jMxjrUyMgUqSUjNuL5+FXPBNLaK02dWsDQwNrJ2MXJySAiYSOxtm8fU
        xcjFISSwg1Hi9I8d7BDOd0aJJxf2sXUxcoBVrT5uAxHfzSjxcP1jZpBuXgFBiR+T77GA1DAL
        yEscuZQNEmYW0JTYuns91Jx7jBJrtkxngajXkJi74SjYZhYBVYn1i7sZQWw2AS2J/S9usIHY
        /AKKEld/PAaLiwpESOyc/40dxBYRCJK48X0FK8QuC4n2/aYgYWGBNImu9S/AzuEUsJSY3PmE
        DWSvhMAaNonOrb+gvnSRWH2inRnCFpZ4dXwLO8Rf0hKXjtpC1LczSrTvnccM4UxhlDh3/R4T
        RIOxxLOFXUwQn/FJvPvawwrRzCvR0SYEUeIhseppFwuE7Sjx5/5VFojnexglJh2YxDqBUW4W
        UnjNQoTXLKTwWsDIvIpRLLWgODc9tdiwwFCvODG3uDQvXS85P3cTIzh5aZnuYJxyzucQowAH
        oxIPr0BGRZQQa2JZcWXuIUYJDmYlEd7tSZVRQrwpiZVVqUX58UWlOanFhxhNgcE9kVlKNDkf
        mFjzSuINTSwNTMyMgKnL0tBQSZw3IMAlSkggPbEkNTs1tSC1CKaPiYNTqoGRZ9W8dS8WfTyZ
        Zn5aOEwvdk8mk11G/rXJ64IviPQonT3zwczP/Nu0nM8TayWyQ06JnNfgt3xYknWx2KAs2tTf
        x6ug4oB509xWHnu3w6UqRzcdeb1qXZ5YTrOD+LPVCd5//SvdH9ZvZCqPVT9vs9GQ4T3L6pbD
        4b0tf/h+3z11M66D2Wb2z9lKLMUZiYZazEXFiQCGYLWZdAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsVy+t9jAd1/yZVRBoveGVq8OT6dyeLyrjls
        FrcbV7BZLNj4iNGBxeP9vqtsHn1bVjF6fN4kF8AcxWWTkpqTWZZapG+XwJVxff0q5oJpbBWn
        z6xgaWBsZO1i5OCQEDCRWH3cpouRi0NIYCejxLVJZ4DinBy8AoISPybfYwGpYRaQlzhyKRsk
        zCygLjFp3iJmiPoHjBLnZz5hgqjXkJi74ShYL4uAqsT6xd2MIDabgJbE/hc32EBsfgFFias/
        HjOCzBQViJDoPlEJEhYRCJD4eaqfHWKVhUT7flOQsLBAmsS5M7NZIFb1MUpsmfKFBSTBKWAp
        MbnzCdsERoFZSC6dhXDpLCSXLmBkXsUomVpQnJueW2xUYJiXWq5XnJhbXJqXrpecn7uJERi0
        2w5r9e1gvL8k/hCjAAejEg9vRlZFlBBrYllxZe4hRgkOZiUR3u1JlVFCvCmJlVWpRfnxRaU5
        qcWHGKU5WJTEeW/nHYsUEkhPLEnNTk0tSC2CyTJxcEo1MFZJ9WVzVPB8mXf+z/30bPX/zBcm
        L59Qc4i56vY+sdiXSyt7si8pueUf5jgz6+jqr7mG3MtTtHxtu+RKS3eUBy4VN13CoX9w8feb
        Xv8DF5Y0uwhrhy454cEZ01C8ZBX//fXfpBhbrCYwsLE/O3997uNVPa3yjBsXuBvMcvu585bH
        5LfL9GZP6VJiKc5INNRiLipOBACZ5eFdVgIAAA==
X-CMS-MailID: 20180206081454epcas1p4dd9613ac7febc5a4464f4d07e35bd3ae
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180206081056epcas2p19485991e157843cf2e016a6dfed41027
X-RootMTR: 20180206081056epcas2p19485991e157843cf2e016a6dfed41027
References: <CGME20180206081056epcas2p19485991e157843cf2e016a6dfed41027@epcas2p1.samsung.com>
        <20180206081051.10785-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018년 02월 06일 17:10, Hans de Goede wrote:
> Some other drivers may be waiting for our extcon to show-up (exiting their
> probe methods with -EPROBE_DEFER until we show up).
> 
> These drivers will typically get the cable state directly after getting
> the extcon, this commit changes the int3496 code to process the id-pin
> before registering the extcon, so that other drivers see the correct state
> right away.
> 
> Fixes: 2f556bdb9f2e ("extcon: int3496: Add Intel INT3496 ACPI ... driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/extcon/extcon-intel-int3496.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
